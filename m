Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AD5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 08:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D542206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 08:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbbybRfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbeLPIIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 03:08:07 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43608 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbeLPIIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 03:08:07 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so7219947lff.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 00:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QWjl+WSAf2QEUgFjTZ8JfbpyiGB5cSyHu4fD69SRXiU=;
        b=nbbybRfsYapy6UOXdSn+6BibXYaQtBesJOmEZPy6cpxvikKZN1+7jEcwOXN3Fg9X5C
         giwfNByhynFNCoIMSqCzZy36Zr1WSaDgtTlz8HwnfrYSqKfA/Q7dxKt9gxLw1HGIl1jJ
         5kF8vRo5HUNnmf4kqZajHOZhOLtJUoFErmZF6qsjnVHOFL8r7T8Pb/EgoNmK1aO9eaqa
         hO1xnO1y2DG2sqOTDNtxe0k8PT0t5saypivl8X1XHPRsAPlwpEyHXE0hGHU8TCHOgYIg
         Tt2G4xK5BEQtz2E6Czp7oTVRznfxavzJzz6kjSPVBZmaD2oJ+GHWsa1nuJWkq+Gs9nhi
         7Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QWjl+WSAf2QEUgFjTZ8JfbpyiGB5cSyHu4fD69SRXiU=;
        b=SkaElFLXz0Rf8k+QI/a6dB+aAfsA2rlFLGQ4BCj52eAYszt/0vcfA5T2ScKOHRU5XF
         Q6i9htmFUQLza4C/UbGYPp0qMMogvg/jfrM8We/z1/6S3FDvJjmh8I2kEFsKk5iKAXlh
         TYd2vWkxJ7BHnJy3iTdffWLwGHJChoHa00c+t4LnxOWxsXPj4ZEcHXnqQ4DYR+VFd4qx
         /U8pQqPciVOh4/DjOi4DNrjicQcFxpCrPXUQzVDB11tzQIta75lJFH93j2+k6nQsaOxV
         +hafDfEXz3iEiXKoVmB7k4Au9XX1t2glkDu8SowNSGqv09xwMdf9upxfTNsZr67kiiL6
         34Gg==
X-Gm-Message-State: AA+aEWbf6nii7irt+AGSvEwhD3E6tQdQpZ19T+wT0GtJ8CfWeGPKaafR
        IX3p3hf/tjI/7vmbH5mI7baa3cP8
X-Google-Smtp-Source: AFSGD/WbIY5WVPbRt1RKnvzLlspuvhljCfrJt6fIRbhydwGSSkrWMBrpLWnijCHWgrdXjfk6aWxU+w==
X-Received: by 2002:a19:be16:: with SMTP id o22mr4935502lff.22.1544947683615;
        Sun, 16 Dec 2018 00:08:03 -0800 (PST)
Received: from [192.168.26.160] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id r26-v6sm1846577lji.25.2018.12.16.00.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 00:08:02 -0800 (PST)
Subject: Re: Problem with late AMD microcode reload/feedback
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CACna6ryhfaOFS4qjZoLjJqcu5LQd05_jDndL5+GpADTHhu3_7Q@mail.gmail.com>
 <20181216000510.GC6693@zn.tnic>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <bac495ca-ccfd-3551-97ca-1444a391fa40@gmail.com>
Date:   Sun, 16 Dec 2018 09:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181216000510.GC6693@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.12.2018 01:05, Borislav Petkov wrote:
> On Sun, Dec 16, 2018 at 12:46:05AM +0100, Rafał Miłecki wrote:
>> [19.736770] microcode: [find_equiv_id] sig:8458000
> 
> That's your CPU's family/model/stepping: 0x0810f10
> 
>> [19.736772] microcode: [find_equiv_id] equiv_table->installed_cpu:8392466
>> [19.736775] microcode: [find_equiv_id] equiv_table->installed_cpu:8392578
> 
> and those are present on the system. Best to look at them in hex, btw:
> 
> 0x0800f12
> 0x0800f82
> 
> Which means, there's no microcode for your CPU so nothing gets updated.

Thanks! I had no idea microcode_amd_fam17h.bin is a container with few
microcodes. I thought there is a single microcode for a whole family
(e.g. 17h).

Using hex also makes more sense indeed!
[   44.127941] microcode: verify_and_add_patch: Added patch_id: 0x08001227, proc_id: 0x8012
[   44.127948] microcode: verify_and_add_patch: Added patch_id: 0x0800820b, proc_id: 0x8082
[   44.127952] microcode: [find_equiv_id] sig:0x810f10
[   44.127955] microcode: [find_equiv_id] equiv_table->installed_cpu:0x800f12
[   44.127958] microcode: [find_equiv_id] equiv_table->installed_cpu:0x800f82

So for now I'm stuck with the default/BIOS-uploaded microcode:
[    2.604680] microcode: CPU0: patch_level=0x0810100b
[    2.605617] microcode: CPU1: patch_level=0x0810100b
[    2.606583] microcode: CPU2: patch_level=0x0810100b
[    2.607528] microcode: CPU3: patch_level=0x0810100b
[    2.608408] microcode: CPU4: patch_level=0x0810100b
[    2.609285] microcode: CPU5: patch_level=0x0810100b
[    2.610270] microcode: CPU6: patch_level=0x0810100b
[    2.611135] microcode: CPU7: patch_level=0x0810100b

I've one more hacking idea. My notebook has Ryzen 5 PRO 2500U CPU but I
also have access to another one with Ryzen 5 2500U running:
[    2.780949] microcode: CPU0: patch_level=0x08101007

For my hack tests I'd like to replace my 0x0810100b with a 0x08101007.
Is that possible to extract/dump current microcode from the CPU and
package it as microcode_amd_fam17h.bin?

Are there any ready tools for that?
