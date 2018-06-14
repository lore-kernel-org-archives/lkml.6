Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AFB64C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5958C20020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk9LN6DJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5958C20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966277AbeFNOXI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:23:08 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42475 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964986AbeFNOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:23:03 -0400
Received: by mail-ot0-f194.google.com with SMTP id 92-v6so7261270otw.9;
        Thu, 14 Jun 2018 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7BCncvekmWi8SA6Jwh15xEC5glJuQhTRCZ1TygblpeY=;
        b=Xk9LN6DJyi4Vs0WUIreg0k7I7X2HOmXSqjpHcJhJJV8Hq0pXIfUrJFzvXD4CEyntEY
         Ag1XPFOjurmH0QAVHa4g+SHpUbd2U28yKFmqX6Zsag98zIoOn4F/DFaCt4MZd22gBvWB
         ltiQ68bYd5muMYdOJmXl+61AaPI81UzCWtVH1xlmfpdWxahM3GG7SCMDcudsQZlQ14p9
         lu+G4e6zL3fRo/ikhhKBt6S//xG/fe/M80mUBm7iUhD1lggMRtFZmWMH1ocW/vvQmqn8
         vOWDeDuAduBexdEKkJsoW8eXL6K1+s979GIeWV5jm2jd/LbLBVbkdlAXOXojkj7xL2hE
         RmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7BCncvekmWi8SA6Jwh15xEC5glJuQhTRCZ1TygblpeY=;
        b=QSH94SsZZ6WT8Uba7E0BCYMFvxRide6/7Nh73Ig6+Rz2h64U6zNhjn9f6l0FF+9mqc
         DLCn/g7HfQRZDFhXvRU9ruJ0aV4odHGFXSL4WP+QQlEdGQfzF5Bj3+//bCUgAycVkYq0
         hSNzyLSLgPOKPzoym1cCgXfQ3dMeibwTkmMRmDThKaaCdrQyYO4rn/tRvNvGtC7gOWgT
         rZQfJtZIKBQD7/8Nz0Hc2kmgPI2Wgx6yfTVM/6IIG4LlDV8kr+31WXdZmxxU6zKf5JcN
         2LeDm1ahlk+Q6IiyDr4kCOI7KhR73nTBgIwHFvhaTblQ7thHiY776pPqakGmrl3h0UNV
         0ZGQ==
X-Gm-Message-State: APt69E0iYWoXVI47prenT36r/UDM8HTcs7ejUAJIxKJ1sdnHO6be607s
        GzhczJSktVPmPfFMJCYYWiZdX041
X-Google-Smtp-Source: ADUXVKKaGDUYfK0q8ABoCivt/bCF+hFeGmNGm1CHw3OGqF2QcskdSnrq5GppOqJkzZLDmtxvSBHAEQ==
X-Received: by 2002:a9d:4a6d:: with SMTP id d42-v6mr1416661otj.48.1528986181874;
        Thu, 14 Jun 2018 07:23:01 -0700 (PDT)
Received: from [192.168.0.2] (cpe-24-27-59-32.austin.res.rr.com. [24.27.59.32])
        by smtp.gmail.com with ESMTPSA id e202-v6sm3850011oih.8.2018.06.14.07.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 07:23:00 -0700 (PDT)
Subject: Re: [PATCH v3] dcdbas: Add support for WSMT ACPI table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>, Douglas_Warzecha@dell.com,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jared.Dominguez@dell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
 <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com>
 <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com>
Date:   Thu, 14 Jun 2018 09:22:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 180613-2, 06/13/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/13/2018 3:54 AM, Andy Shevchenko wrote:
>> +               /* Calling Interface SMI
> 
> I suppose the style of the comments like
> /*
>  * Calling ...
> ...

Yes... goof on my part.  Thanks.

>> +                *
>> +                * Provide physical address of command buffer field within
>> +                * the struct smi_cmd... can't use virt_to_phys on smi_cmd
>> +                * because address may be from memremap.
> 
> Wait, memremap() might return a virtual address. How we be sure that
> we got still physical address here?
> 
> (Also note () when referring to functions)
>
>> +                */
>> +               smi_cmd->ebx = smi_data_buf_phys_addr +
>> +                               offsetof(struct smi_cmd, command_buffer);
> 
> Btw, can it be one line (~83 character are okay for my opinion).
> 

Before this patch, the address in smi_cmd always came from an alloc, so
virt_to_phys() was used to get the physical address here.  With WSMT, we
could be using a BIOS-provided buffer for SMI, in which case the address in
smi_cmd will come from memremap(), so we can't use virt_to_phys() on it.
So instead I changed this to use the physical address of smi_data_buf that
is stored in smi_data_buf_phys_addr, which will be valid regardless of how
the address of smi_data_buf was generated.

But that would be like 97 characters long if I made it all one line...

>> +       acpi_get_table(ACPI_SIG_WSMT, 0, (struct acpi_table_header **)&wsmt);
>> +       if (!wsmt)
>> +               return 0;
>> +
>> +       /* Check if WSMT ACPI table shows that protection is enabled */
>> +       if (!(wsmt->protection_flags & ACPI_WSMT_FIXED_COMM_BUFFERS)
> 
>> +           || !(wsmt->protection_flags
>> +                & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))
> 
> Better to indent like
> 
> if (... ||
>  !(... & ...)
> 

Yes thanks.

>> +               return 0;
>> +
>> +       /* Scan for EPS (entry point structure) */
>> +       for (addr = (u8 *)__va(0xf0000);
>> +            addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table));
> 
>> +            addr += 1) {
> 
> This wasn't commented IIRC and changed. So, why?
> 

I changed this is response to your earlier comment (7 june)... you had pointed
out that it would be better if I put an "if (eps) break;" inside the for loop
instead of having "&& !eps" in the condition of the for loop.  I put the note
"Changed loop searching 0xf0000 to be more readable" in the list of changes for
patch version v3 to cover this change.

Thanks again for your time!
