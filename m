Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5D8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF3C208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGKDiSWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfAAJAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 04:00:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33229 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfAAJAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 04:00:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so24885636ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 01:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6e7XHgxGECzkpmNiy1smp5NrDTB/dBXyTg9co5l4zuI=;
        b=EGKDiSWexgSr1XkUIc6aZ+klB17X3vPU9mkKPr9eGoMdanekxdfiSlyW1alwt80Gnz
         MHa77jJQu5/tv2EBTYGVXppUAxr98rJR4pTMcaFlMneSNq49p3ac/J9wQpoqtQsnEzfK
         rXpTK5wPoQs/Qrl20D94NKsQY5uOqKy5TBNWT+Qfythheru9dCx4HKlc/Toc58PNWBw3
         JzL12AbPdn5N5nbYusdy10VfabYLVh0RwE65hsoLmhRhIdmNgjjeHMFV1qeyfzTjuds+
         A+h4OiBxZRPNK4H5auBkEeK5Cztar0s8WABKQwOSA1GvgWwXgF1xny9912OMK1on3JNA
         XKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6e7XHgxGECzkpmNiy1smp5NrDTB/dBXyTg9co5l4zuI=;
        b=XxUWK2c6AX0/L1huS1gFJRB6WeaMOLN+rvH6vW9frsv3HnGEJuKGnWce040tyE4h9v
         57Rxj4OXleVXxhjcuJjSCrvb8MBgQIUA2ub9jiJ/h9QEdrIy1j2bq/PnQBs0QxHF7qLj
         8ot+MStsUwAJyw21QTEQqjT3rSOyt53Lm0r6tEzFuT5zR0IdYEBzewYnftov5DnKXA19
         G8FYT/7L8vSdymI9K87AVATMhrvRVZ+uyFsj9lofBWltGp+ozz/taIdBd0rLkeUQTDaT
         zLSa/jc13E6l5B1r0taEc5BmlYyl+vGSwYP7vRQaha77QeiQqNz3Zw2uRy/Z2YUWWoJW
         16ag==
X-Gm-Message-State: AJcUukd6PdU0uIbdanEcMtK+HjfWwDSDUCIasi/vF/uU/s6xmmUlYMfL
        BhMDGWCabjUV43BLBqsMLcIeJuLN
X-Google-Smtp-Source: ALg8bN5vkK5ij+wdGTINXRTV8wYAtGKqdgZlL25U1YZ02uO/YW8qnbxaZf5yJ4vENBXgyPoJrZY27w==
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr19175698ljj.43.1546333199176;
        Tue, 01 Jan 2019 00:59:59 -0800 (PST)
Received: from [192.168.0.160] ([178.71.223.48])
        by smtp.gmail.com with ESMTPSA id c133sm10654629lfc.45.2019.01.01.00.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 00:59:58 -0800 (PST)
Subject: Re: [PATCH] Revert "staging:r8188eu: use lib80211 CCMP decrypt"
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181230183918.3888-1-straube.linux@gmail.com>
 <efbc3a4a-ce31-8785-73c0-3d89edc66977@lwfinger.net>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <4dd17d38-8c4d-b5db-1091-edba0d95cadf@gmail.com>
Date:   Tue, 1 Jan 2019 12:02:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <efbc3a4a-ce31-8785-73c0-3d89edc66977@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I suggested a patch for loading modules from interruptible mode, but 
this patch remained unclaimed ( 
http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124851.html 
).

For some reason I thought that this patch had been removed and did not 
track the fate of this code ( 
http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124573.html 
).

On 1/1/19 5:17 AM, Larry Finger wrote:
> On 12/30/18 12:39 PM, Michael Straube wrote:
>> Commit 6bd082af7e36 ("staging:r8188eu: use lib80211 CCMP decrypt")
>> is causing hardfreeze whenever the driver tries to connect to my wifi
>> network. That makes the driver unusable on my system. Reverting the
>> commit fixes the issue and the driver works properly.
>>
>> Dec 29 19:21:17 gentoo kernel: BUG: scheduling while atomic: 
>> swapper/6/0/0x00000100
> 
> Michael,
> 
> I have verified the freezes that you see. Although I have not been able 
> to capture the console dump, I think we are likely seeing the same problem.
> 
> I do have a work-around in that I have not gotten any freezes when I 
> force module lib80211_crypt_ccmp to be loaded before I load module 
> r8188eu. This clue was used in finding what seems to be a good fix.
> 
> I do not know anything about demand loading of modules using 
> try_then_request_module(); however, I noticed that the macro actually 
> calls __request_module(), which has the following comment:
> 
>   * Load a module using the user mode module loader. The function returns
>   * zero on success or a negative errno code or positive exit code from
>   * "modprobe" on failure. Note that a successful module load does not mean
>   * the module did not then unload and exit on an error of its own. Callers
>   * must check that the service they requested is now available not blindly
>   * invoke it.
> 
> I note that it says "user mode module loader". Routine rtw_aes_decrypt() 
> is likely inside some sort of locking, which leads to the "scheduling 
> while atomic" bug that you see. As a result, I suspect that the module 
> is not loaded, and that leads to the NULL dereference when the module is 
> accessed. Please try the one-line patch attached, which forces lib80211 
> to load when r8188eu is loaded. With this patch, I have been connected 
> to an AES-encrypted AP for nearly 3 hours with no problems.
> 
> Larry
> 
> 
