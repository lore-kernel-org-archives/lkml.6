Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E4AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C148206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPTxarOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C148206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbeG0DJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:09:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37382 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbeG0DJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:09:16 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so1607785plc.4;
        Thu, 26 Jul 2018 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GlfodYsBhrpRi8XG4bnTIywn1ySvcHCrYdNH/KkO6sw=;
        b=pPTxarOyCBfXmST0vm8KEkGJaTywcgkXMEyD1Gr7+LiH2ceVr7PvXNjVSIqhMTSE7f
         7wa5L4du0V1VfFyV3IHwgBx0WSAO62pv09gWxGXUG5GmBTlgxofoHlc91ag6caRk2sZH
         Laqze0wCb/1+dIhzHJz9vcq8rnRPMsN23kUVNitineIm+7lozMjrwWfOV37HtMm23yO7
         MZK/oLuDQ45llrq1vX3T2/DyEAuy57YuFH7fK6bJm8GcniM/Bc5t+/toSJn5fTGl7AzV
         KmMIFNDrWCeGvVEj/6Mff0UhnTBl9F0agb9WavGBqdXwnaX5kpE5oCudpl1cttQ3v9QY
         6hJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GlfodYsBhrpRi8XG4bnTIywn1ySvcHCrYdNH/KkO6sw=;
        b=eS3IcuDS+xuYM/Ja1I5OsuxXv0wFLYHqDWaoJpm6rQEV7vtB5AtX2IZWjzFdZQd/u+
         WqOW3wdadjy1CpBSacch/omPeDjfdLW4lJB42RLnvi8XwV0qwvOg+iknmYQIlfDa2X4e
         7Vwl7CGAxK1y4bG+XFIt9c4KEESMfys7VhwtqYq2qRvQA/WXMJzy/kxzXUWVQWKknu4a
         siICiLKQwI75JG/32BzipxOqOCtHYR9ahBsYHNcy/mDZevm5gMPVTOXqcmOC0Jb2pvaM
         QuVv6OehjAv7fgVe75n1OuZImZOvHQivv4dEkto0u0QLTA1KejZft3OMkXobEH7xM7n3
         Szww==
X-Gm-Message-State: AOUpUlGB7pMDv3v7VRHQpLY7df8HtSkmMGuyzrynJH08w8iazyn0hugi
        h/yAaJUz9S/IVuDyEMW7LCce6Ai9
X-Google-Smtp-Source: AAOMgpfgbCSG/lPC8l2abwFnHG1ae9Ekhv+D1FcUMwJYRK/z8Pp15Cfe1IBDerXweQrj8XrqKm8NlA==
X-Received: by 2002:a17:902:a5:: with SMTP id a34-v6mr4184096pla.60.1532656187613;
        Thu, 26 Jul 2018 18:49:47 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:101.5.211.5? ([2402:f000:1:1501:200:5efe:6505:d305])
        by smtp.gmail.com with ESMTPSA id l70-v6sm3275845pge.64.2018.07.26.18.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 18:49:47 -0700 (PDT)
Subject: Re: [BUG] video: fbdev: broadsheetfb: Possible null function pointers
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20180726141748epcas1p28f6f11fea0152ed22113351e3a0affbc@epcas1p2.samsung.com>
 <cb43741a-83af-0b55-f53b-489bf7cb8b61@gmail.com>
 <2568790.PcaMMF1rzM@amdc3058>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <c95d4381-1278-e561-29d8-ae84be2c680e@gmail.com>
Date:   Fri, 27 Jul 2018 09:49:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <2568790.PcaMMF1rzM@amdc3058>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/26 22:34, Bartlomiej Zolnierkiewicz wrote:
> On Thursday, July 26, 2018 10:17:44 PM bai wrote:
>> In Linux-4.16, drivers/video/fbdev/broadsheetfb.c,
>>
>> 158. static void broadsheet_mmio_send_cmdargs(...) {
>>               ......
>> 163.     par->board->mmio_write(...);
>>               ......
>> 166.     par->board->mmio_write(...);
>> 167. }
>>
>> For x86 kernel configuration, I find that there is no assignment of the
>> function pointer ".mmio_write" in the kernel code.
>> So calling the function pointer in lines 163 and 166 may cause a null
>> pointer dereference.
>>
>> In this file, there are many calls to this function pointer...
> This is a platform driver and it won't be used on x86 (actually it is
> used only by single ARM PXA board). The dependency for FB_BROADSHEET
> in Kconfig file could be improved to i.e.
>
> 	depends on FB && (ARCH_PXA || COMPILE_TEST)
>
> but there is no bug there.

Thanks for the reply :)
So I want to submit a patch of updating Kconfig in 
drivers/video/fbdev/Kconfig:

config FB_BROADSHEET
     tristate "E-Ink Broadsheet/Epson S1D13521 controller support"
-    depends on FB
+   depends on FB && (ARCH_PXA || COMPILE_TEST)
     select FB_SYS_FILLRECT
     select FB_SYS_COPYAREA
     select FB_SYS_IMAGEBLIT
     select FB_SYS_FOPS
     select FB_DEFERRED_IO


Do you think it is okay?


Best wishes,
Jia-Ju Bai
