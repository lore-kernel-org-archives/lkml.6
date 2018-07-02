Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E31FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE2A23E91
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="AVLt812S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE2A23E91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbeGBQYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:24:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34704 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeGBQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:24:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so8211702wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Jnr+s4GpGc2kimRzX3kEJ386TBFsBq9z5HizMSxO9kc=;
        b=AVLt812Sbw9aKo6owWNG64/ACaP82Nc8JPdlHBw0mTCZg7T5dcqYACQRAeFsL82swR
         PhivHKfmrWnQBGpEE7rXqZ2M8nandjI4bJUd0O8ng81dIasCnXksyL/k3Aee0SEzchEn
         TZwmcNH14QBMsgqUkfMmyJoIY9Q74/sPjsrqk0F2JeZZHwnbJKkLTawv06SDOhZCReh3
         6mMlqbtfxLHkL2jhjpuw5KV/70fHlp6z2w/Vkb5TWwKFRzxydIZ07HMibnnFlIsjHHXs
         UYTn9Hazcoy2nnICiXIYa8oyNv0CJRTFVQ2bXLw7Pt0Wrz5B1qiGqCj4BNYV/gTOlZYq
         BrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jnr+s4GpGc2kimRzX3kEJ386TBFsBq9z5HizMSxO9kc=;
        b=BRYjLCaMbu3GMdqi/mmq+zdEOv/VAMDuJL9SV8uTVaQ7OCJK23ib7wo99fY8/IK13S
         cZhTyTg0q2ZGBqqND5Cj9APwO9RlFgVhHLuJVYXRvD3/WTFGb8TVa9cgCWQdipkZRmqg
         e/R7ziBLlwx6ymyoVqvUtShpuXjyr1rdJAM+HTncx++pJnKWuT7qWRQkkQYKXk+2LtKu
         jKqdsp9oKlkDPb9m2YJx38RzoFjYMgk+nk8yjkQ1fvo6kdt6Lz3LOqowZTL2uBdZxfnL
         WAuc0MK52qyVz4+IpCqS3ubz8MqtsDh7kp7vlukF0EfNvumlcZghCpK39diP4zGxQJEc
         DUhQ==
X-Gm-Message-State: APt69E0nDao37aK+PESRITrub/hvUtHbBBKzI9HBF5rd1fB7t0z3ZL/q
        1HUASANF26Uv1jzfMfplafQaPw==
X-Google-Smtp-Source: AAOMgpe1KFMHRuD7ERjPA/m72aQzM3RlhpLa6MQsYlkFf4e6DnzqJuLxL9D4l2mDMo/KlzX7nDe9Ng==
X-Received: by 2002:a1c:850c:: with SMTP id h12-v6mr8334795wmd.116.1530548654216;
        Mon, 02 Jul 2018 09:24:14 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id e128-v6sm11281593wma.46.2018.07.02.09.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 09:24:13 -0700 (PDT)
Date:   Mon, 2 Jul 2018 18:22:38 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Michael =?iso-8859-1?Q?R=F6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>
Subject: Re: [RFC net-next 05/15] HACK: net: lora: Deal with .poll_mask in
 4.18-rc2
Message-ID: <20180702162238.GB2737@nanopsycho.orion>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-6-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180701110804.32415-6-afaerber@suse.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Jul 01, 2018 at 01:07:54PM CEST, afaerber@suse.de wrote:
>linux-next and 4.18-rc2 both identify as LINUX_VERSION(4,18,0), but
>commit a11e1d432b51f63ba698d044441284a661f01144 (Revert changes to
>convert to ->poll_mask() and aio IOCB_CMD_POLL) reverted .poll_mask
>to .poll again.
>
>Signed-off-by: Andreas Färber <afaerber@suse.de>
>---
> net/lora/dgram.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/net/lora/dgram.c b/net/lora/dgram.c
>index 4d931fd3778a..ef56fd90e762 100644
>--- a/net/lora/dgram.c
>+++ b/net/lora/dgram.c
>@@ -217,7 +217,11 @@ const struct proto_ops dgram_proto_ops = {
> 	.socketpair	= sock_no_socketpair,
> 	.accept		= sock_no_accept,
> 	.getname	= dgram_getname,
>+#if 0 /* LINUX_VERSION_CODE >= LINUX_VERSION(4, 18, 0) */
>+	.poll_mask	= datagram_poll_mask,
>+#else

I guess that you sent this patch by mistake...


> 	.poll		= datagram_poll,
>+#endif
> 	.ioctl		= dgram_ioctl,
> 	.listen		= sock_no_listen,
> 	.shutdown	= sock_no_shutdown,
>-- 
>2.16.4
>
