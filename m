Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC32ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181A520848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="EIKQLJCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181A520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeJ0D1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:27:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45856 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeJ0D1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:27:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id j4-v6so2059878ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9eOI13aG3Owne4W1tN8Px2rCml38s/QfTsNL6mWlDxM=;
        b=EIKQLJCpFryl7wwTlpAAYIWI/AMdvXiy5oKEt+tYOUsQeII55gOtqZcOXTGsJoJoOa
         E9qlfHMKntqeKbUB+qpR4PzuXIpvgOKDHONm/sQsqGhhMWJhMSBTxl8BOJYJkU6yAOng
         8I3MjJadrt3ZclqDJs6tT91WaWdUyWY9l4Icu3W7AVtekN1NI2er83UZI8gjGAAWBdGs
         QJvHszKfHOPR5ifn38PR7EYkwJv+vU5X8WzKaNQsmp95c/n/8WRnUAnJxbAUaoLUbq0g
         Ej5jof5xgAbt6eGbJG0Jettrn/O+muo2PbEuASkp57JZMBGk5nxeoxB9R+FH53OTyTP5
         aNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9eOI13aG3Owne4W1tN8Px2rCml38s/QfTsNL6mWlDxM=;
        b=Ly1i7XzjHSUKlBdmBNjc0hZ//TU8B9MketeKHe81cuKUROrpOw+LlL5KgSS5llcpzH
         BymFHHs5mhe1FmHCAh5hrJBUnqe0tfOJ/LUBErcC/qCgHJl6x3eqpZwFK2a6KFJViRcY
         aIe4C+o0xZ+hbb+uC8+Dm+BBkL54yEwyiuQzSasSdH8kpgCRO4Gvd1oAW8MJirrXBOsY
         uLOxPWfSLGWMvum0kn3gKDSy6TzEu5TFKbuHQWVdsmz/9dKy7LyCH1R6MLIp3RjpmOCh
         t/LOeR11kNj9yTLyzRDW+DcVfhjvjdBnPfVD5qkNpzN1nBblvv3sfVkmm7+vgU6aEi5j
         FdyA==
X-Gm-Message-State: AGRZ1gLhr4z+IOSErJlLMi5zMJ+A28gOm+06yUKJzKeVAoq785aFvEdP
        D7lu1vgINXly45g4gcIDrP9N9Q==
X-Google-Smtp-Source: AJdET5ctUp1SHzG9z2bzqOEBqTwem3SfQ/HsLD8HDBGl8vqj9WYBweA4Lfg95PPKW5LQtxT7YsKepg==
X-Received: by 2002:a2e:4e01:: with SMTP id c1-v6mr3388818ljb.157.1540579771668;
        Fri, 26 Oct 2018 11:49:31 -0700 (PDT)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id k72-v6sm548894lfg.5.2018.10.26.11.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 11:49:30 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: fix chunk close trace event check
To:     hans@owltronix.com
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        linux-kernel@vger.kernel.org, hans.holmberg@cnexlabs.com
References: <1540541544-7761-1-git-send-email-hans.holmberg@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e884c6c9-d875-e282-59dd-f1733ffc38fb@lightnvm.io>
Date:   Fri, 26 Oct 2018 20:49:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540541544-7761-1-git-send-email-hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/2018 10:12 AM, Hans Holmberg wrote:
> The check for chunk closes suffers from an off-by-one issue, leading
> to chunk close events not being traced. Fix this.
> 
> Fixes: 4c44abf43d00 ("lightnvm: pblk: add trace events for chunk states")
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> 
>   drivers/lightnvm/pblk-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 6944aac43b01..6581c35f51ee 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -531,7 +531,7 @@ void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd)
>   		if (caddr == 0)
>   			trace_pblk_chunk_state(pblk_disk_name(pblk),
>   							ppa, NVM_CHK_ST_OPEN);
> -		else if (caddr == chunk->cnlb)
> +		else if (caddr == (chunk->cnlb - 1))
>   			trace_pblk_chunk_state(pblk_disk_name(pblk),
>   							ppa, NVM_CHK_ST_CLOSED);
>   	}
> 

Thanks Hans, Applied for 4.21/5.1. Note that you're sending from your 
owntronix email account. Checkpatch complains that sender and author 
doesn't match.
