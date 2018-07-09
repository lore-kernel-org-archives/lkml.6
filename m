Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2BEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2F22089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="gUhTFT/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2F22089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeGISPc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:15:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40950 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933703AbeGISPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:15:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id e13-v6so848854pff.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNIRMT9TMh0WA967cYsvPLKbs+nwa6iWjzUhuPhdTy4=;
        b=gUhTFT/oElETDmHtUixE0bjLmjkMXpAS4TQBlHuIua51wUH4q+Ovz9+XiDJj3eDyzy
         LGUSScd2Lp5tFEEW8a1aIuH3XixloqULw8rhYhH4CTJHemtFfrFQNqIZIus6oPzkPKWu
         0oI/CoQyAw17a37ZNYpFK96UI0nbQ5UajgbS9h/CrZZFX4qZrls0kv3BhGsx+ezeDLK6
         plhqeilQR4kRysLsOtLSnr2eoVldpLG4YMpOyoqHbk1vHbhNpLnup+Cf11zTtnYCfdKM
         l4clqx4HuDtL89DnTuXKpRDGU9F+tX8c7Qr01llmjaW5+17uT8J92ae/2yeIoen2ACvl
         GwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNIRMT9TMh0WA967cYsvPLKbs+nwa6iWjzUhuPhdTy4=;
        b=UGbcuIxa55TBudMFdmLIZw6x2eJi5fU3srNB2fSRilrJlZr456JvMXpvS0fdT2YfdD
         UsO+OW7fdcwAfaGnb6qjhLsQuq1Y1OsR5VFYSY71/15hUEgw/j+jnJBqWOZuX/z0KGgZ
         oBmRZ8E00WxT7UXlzbAZAj+7d9g82LMwNRWXVfnUNlePUHqpZ3yDXHtth7dfGfk1JJlQ
         9JvNy4+ixdrvSugA7K51oERuHMFNE3noU7DZbJA6K+9xTEyBTgcACRccxmzc/KjShLPP
         EHCAX4wte+x4dEt/wEqCcakV/iQVJrpLU3hSWMzqCZTA3C9DekJXp/yVovah8nPpMb9z
         yU1w==
X-Gm-Message-State: APt69E2+yo/cVVh0JczBH5bmJrGWS5axIll3ORKZdtLjp47RZf2UuUUJ
        cAzqyFx5opbPy5UnQIpRxgNwNQ==
X-Google-Smtp-Source: AAOMgpcxwYfMtfnZ1kM9wCN3DUpjSLjHjvBYHH97Ppa7Qz56PisewgJ360o1gNltM+NTAjr6niRA2A==
X-Received: by 2002:a62:3001:: with SMTP id w1-v6mr6205380pfw.19.1531160129839;
        Mon, 09 Jul 2018 11:15:29 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id h9-v6sm8550648pgn.67.2018.07.09.11.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 11:15:29 -0700 (PDT)
Date:   Mon, 9 Jul 2018 11:15:27 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@linuxonhyperv.com>
Cc:     haiyangz@microsoft.com, davem@davemloft.net,
        netdev@vger.kernel.org, olaf@aepfle.de, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        vkuznets@redhat.com
Subject: Re: [PATCH net] hv_netvsc: Fix napi reschedule while receive
 completion is busy
Message-ID: <20180709111527.70ab354c@xeon-e3>
In-Reply-To: <20180709164319.5058-1-haiyangz@linuxonhyperv.com>
References: <20180709164319.5058-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Jul 2018 16:43:19 +0000
Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> If out ring is full temporarily and receive completion cannot go out,
> we may still need to reschedule napi if other conditions are met.
> Otherwise the napi poll might be stopped forever, and cause network
> disconnect.
> 
> Fixes: 7426b1a51803 ("netvsc: optimize receive completions")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/hyperv/netvsc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 8e9d0ee1572b..caaf5054f446 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -1285,14 +1285,14 @@ int netvsc_poll(struct napi_struct *napi, int budget)
>  		nvchan->desc = hv_pkt_iter_next(channel, nvchan->desc);
>  	}
>  
> -	/* If send of pending receive completions suceeded
> -	 *   and did not exhaust NAPI budget this time
> +	send_recv_completions(ndev, net_device, nvchan);
> +
> +	/* If it did not exhaust NAPI budget this time
>  	 *   and not doing busy poll
>  	 * then re-enable host interrupts
>  	 *     and reschedule if ring is not empty.
>  	 */
> -	if (send_recv_completions(ndev, net_device, nvchan) == 0 &&
> -	    work_done < budget &&
> +	if (work_done < budget &&
>  	    napi_complete_done(napi, work_done) &&
>  	    hv_end_read(&channel->inbound) &&
>  	    napi_schedule_prep(napi)) {

This patch doesn't look right. I think the existing code works
as written.

If send_receive_completions is unable to send because ring is full
then vmbus_sendpacket will return -EBUSY which gets returns
from send_receive_completions.  Because the return is non-zero,
the driver will not call napi_complete_done.
Since napi_complete_done was not called, NAPI will reschedule
the napi poll routine.
