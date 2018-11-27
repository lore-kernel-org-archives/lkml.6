Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56B0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9250621104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB1noKHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9250621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeK1Aeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:34:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46237 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeK1Aet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:34:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so20056922otm.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xehEJo/ZC+98SrynuSeKyeFfz+YHVz+9L7jEr3Ob4OY=;
        b=SB1noKHyA4vx/Z24BBQqEFlJgUi1FVc4PahnKaT6rKDf4cu9PsnO3GVbMNBu8HvBr3
         WVVsnDBBsl49ZVw8SC3HkCLtrWhDbknhJz6qMZYyU4JOvfb5RdIEy8/iH1altoJZo62T
         B/bKdxS2xmpg6VOJxwBcLv1Jb4JMYDPysf6lUmNAX+o5xqaf+LJ0mbu7wnim4LJMB66l
         zlJ/6SVXf5a0GvlBmKYGlZIxgFvlUFF30OkgBMrD+AFSrOU6eQhBXZhjZRCEDAfM6xPX
         0ngM8JiNj9s4Hx6p3YUimWx8n97RBoBB/YzlsjjdrfsAUlz+ZPlJvg28laECR6jbivQ8
         sajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=xehEJo/ZC+98SrynuSeKyeFfz+YHVz+9L7jEr3Ob4OY=;
        b=q4NQJ/1EMTWmbf4rvTLw7Ar7UTju6ZyUh1K55V6/57Gftlr0Mqm3nNehRjuoEyosbn
         LIJH3dsYHOZeN8wjfoOpGu9fxgObRjF+sJY9ua+W0rC8UYMfLgceBfqkybkNj6olU3kM
         GRakqTvKfMEW7hN07WwcZZoAaLiUmwqqUsgWpGOF4bkvTOWpuJof17Kmn01ttsuzqyM/
         BUSjYbARhS5ECjTO+SSzWVQNYjW3MhZ5OMB08zsGM5X7NqxeQ3WrE61lxa7lhtdu/eL+
         /6DAid8M6CsCafhoWG/9BarTVoIYbeRfTE4/M5+FTRuClrWFRYuFQOxe06BS4J4qJidm
         /xYw==
X-Gm-Message-State: AA+aEWYPJizom7fXcv37Cxa7ldbm6I98XCIn2tF/3Ue20eSTL21wUzUY
        VOmzjt8N3Psf6nmu+a+NfA==
X-Google-Smtp-Source: AFSGD/UxGMimP73+q93egY22u3I3GC/C5LOv3kLiMMvzSDY/Ov28oUSFKFGaQbPFAx9yXa3cRl2/JQ==
X-Received: by 2002:a05:6830:2010:: with SMTP id e16mr16946767otp.86.1543325811187;
        Tue, 27 Nov 2018 05:36:51 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.64])
        by smtp.gmail.com with ESMTPSA id z9sm2130903oiz.21.2018.11.27.05.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 05:36:50 -0800 (PST)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id E2526915;
        Tue, 27 Nov 2018 07:36:48 -0600 (CST)
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi: kcs_bmc: handle devm_kasprintf() failure case
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Haiyue Wang <haiyue.wang@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1542812905-27337-1-git-send-email-hofrat@osadl.org>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <9320680f-679e-fc89-4349-17dbbd30bbfc@acm.org>
Date:   Tue, 27 Nov 2018 07:36:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542812905-27337-1-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/18 9:08 AM, Nicholas Mc Guire wrote:
> devm_kasprintf() may return NULL if internal allocation failed so this
> assignment is not safe. Moved the error exit path and added the !NULL
> which then allows the devres manager to take care of cleanup.


Added the original author.  This looks correct to me, I've included it, 
but I would
like Haiyue to comment, if possible.

Thanks,

-corey


> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: cd2315d471f4 ("ipmi: kcs_bmc: don't change device name")
> ---
>
> Problem located with experimental coccinelle script
>
> Patch was compile tested with: aspeed_g5_defconfig (implies
> CONFIG_IPMI_KCS_BMC=y)
>
> Patch is against 4.20-rc3 (localversion-next is next-20181121)
>
>   drivers/char/ipmi/kcs_bmc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> index e6124bd..86d29d2 100644
> --- a/drivers/char/ipmi/kcs_bmc.c
> +++ b/drivers/char/ipmi/kcs_bmc.c
> @@ -440,12 +440,13 @@ struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv, u32 channel)
>   	kcs_bmc->data_in = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>   	kcs_bmc->data_out = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>   	kcs_bmc->kbuffer = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
> -	if (!kcs_bmc->data_in || !kcs_bmc->data_out || !kcs_bmc->kbuffer)
> -		return NULL;
>   
>   	kcs_bmc->miscdev.minor = MISC_DYNAMIC_MINOR;
>   	kcs_bmc->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s%u",
>   					       DEVICE_NAME, channel);
> +	if (!kcs_bmc->data_in || !kcs_bmc->data_out || !kcs_bmc->kbuffer ||
> +	    !kcs_bmc->miscdev.name)
> +		return NULL;
>   	kcs_bmc->miscdev.fops = &kcs_bmc_fops;
>   
>   	return kcs_bmc;


