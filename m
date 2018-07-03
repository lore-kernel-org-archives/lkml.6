Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720B2C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E5C2086E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H79wq3h7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E5C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeGCNw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:52:29 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44158 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbeGCNw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:52:27 -0400
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so3891974oih.11;
        Tue, 03 Jul 2018 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kbBFCgkvIIK7F837SU7iNxCTEPyiT83JKNYsyEyGboc=;
        b=H79wq3h7GSOocaKLhLm2tae/rgo13TaIZj1FS6Ym0lpLOb7vYyIT0/nkvspN2hXRZu
         TP8+gIFo1HBppeocAoxP6F2KEduALfa/vWQXiijlufxmR/iDttFT3Qh3Q7kMQCapzMtA
         Pq70B3k+O3jqUNBTkqJu2rqCZJqMkKhJ6z3VfeAvGPpvUmHAJaPQ/+pNK6BAKEt9jZ3X
         QFdeH8Kar+rB72vyI1Jk+ZuHynXIGpLSedKcgKVlyabAml3gzPDc2E7PW0tj5xMlCG2E
         9jz+ZqMs8p1Z7CCLNvaplMD3RQ92Xn5kahN5S4jF+9dX2EG7ijuHZGR8D9jQhbUf9b5G
         FTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kbBFCgkvIIK7F837SU7iNxCTEPyiT83JKNYsyEyGboc=;
        b=tgS/eLAS3kZTtFNlgdz+XCdS+Vqwzcqlut9Mx91DJxaCxLlYpU01bKCjJzxZEr45XG
         IapAFmuEh8CMP3fgxqqmuUBgavyUAp/69GdPTzk7npxB9YFsdy5jVJxZUfhSY9wtVmi9
         3dEN/DwnccQjE3kTO7mS3kf0t9/4z28NCzaYjOnxwA0Ti7FsRQ94vDfTkVxncKMMWSHB
         5ClhIA3cAsZSTXZ2TNkTFoLbK1f0K6+cI6evZcv4Wbzh+EsRPVvu4DTdqd+83LkEmpB7
         yQNAu6mCfDYclo9TDdLdSxC15CzUJNjQ/pqwWBdkywsd3hNqANLDSXh1+4oinwt+khwu
         TLUA==
X-Gm-Message-State: APt69E2TeOqO1a6NweEXKcQaW/XYjR+wUIeraCEXuPsk7BXXUuldz3AN
        IutBhEYAV7bX/gOclSUYdIQiYYe6
X-Google-Smtp-Source: AAOMgpela9CYAAErqroD34NBLuIDRO7gcNmnDqs1y1+K87REc/2ssF6Fb8CCpycpJEvmMyEjdzWzBg==
X-Received: by 2002:aca:c0d5:: with SMTP id q204-v6mr19388046oif.77.1530625945573;
        Tue, 03 Jul 2018 06:52:25 -0700 (PDT)
Received: from [192.168.0.2] (cpe-70-124-142-160.austin.res.rr.com. [70.124.142.160])
        by smtp.gmail.com with ESMTPSA id r16-v6sm1278458otd.43.2018.07.03.06.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 06:52:24 -0700 (PDT)
Subject: Re: [PATCH v3] dcdbas: Add support for WSMT ACPI table
To:     Mario.Limonciello@dell.com, andy.shevchenko@gmail.com
Cc:     dvhart@infradead.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
 <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com>
 <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
 <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com>
 <CAHp75VdTGXqE__VHjRphEmpMVfxaVVik=u-_0NRhQAKeq=+ZKA@mail.gmail.com>
 <b5652ed8-5fff-4f8b-ec0f-467bce853bf8@gmail.com>
 <CAHp75VfL3v8U6o36-e3+XPL53sb9wMUOXsL6gn3XE4=-kJjuKQ@mail.gmail.com>
 <367a12e9-7d10-98e4-4791-69cdc7d01129@gmail.com>
 <CAHp75VdSVLzNHnrOzzrBMf4X2Cg4QACRrnxKNkQzcYJ0h5W+tw@mail.gmail.com>
 <e17fbb51b98d45318001adb7eb6a51b2@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VfNo9NVfgGn4Fqa5fA9zp47TkqHwn1MJ044qMQoMNMB-Q@mail.gmail.com>
 <73c53c23c0824e4595292bfafc6054ee@ausx13mpc120.AMER.DELL.COM>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <4e9a34c5-e0e6-b060-40fa-30d738d1eb69@gmail.com>
Date:   Tue, 3 Jul 2018 08:52:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <73c53c23c0824e4595292bfafc6054ee@ausx13mpc120.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 180702-4, 07/02/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/2018 11:15 AM, Mario.Limonciello@dell.com wrote:
>>
>>> I don't believe SMM communication ACPI table has ever been implemented by
>> Dell
>>> on server or client BIOS.  I do agree this table describes the behavior that DCDBAS
>> driver
>>> has used since before even UEFI BIOS pretty accurately.
>>
>> So, EPS table has been for ages in Dell machines?
>> Can we consider it as a predecessor of that SMM communication ACPI table?
> 
> No, EPS is new this year, specifically for server BIOS to be able to support SMM communication
> when WSMT is enabled.  The code tests in Stuart's patch will detect if WSMT is enabled
> and if it's enabled test if EPS was defined.  On server BIOS when EPS is defined dcdbas
> will be able to communicate using addresses defined in EPS.
> 
> Server BIOS will support EPS for applications using dcdbas interface and may at a later time
> introduce same WMI interface as client too (but applications will need time to update so
> they need to support both).
> 
> Actually Stuart's patch will cause client BIOS that has WSMT enabled make dcdbas fail
> initialization (as it should because dcdbas doesn't have a region that it can successfully
> communicate).  
> 
> In client machines we moved this communication to ACPI buffer allocated by WMI, which
> is why we have dell-smbios-wmi now in kernel.
> 
> I think once some variation of Stuart's patch is merged, I'll send a follow
> up patch to drop this test because it's no longer necessary:
> https://github.com/torvalds/linux/blob/master/drivers/platform/x86/dell-smbios-smm.c#L106
> 
> 
>>
>>> Stuart and I did discuss with server BIOS (who uses this EPS mechanism) to see if
>> its possible
>>> to move EPS to SMM communication ACPI table however since it's been
>> deprecated by
>>> UEFI 2.7 they weren't willing to adopt it.
>>
>> It's pity, but the motivation to deprecate is "lack of use" which is
>> not true. That's why I would suggest to escalate this to UEFI
>> committee.
>>
>>> Stuart, anything else you want to add here?
>>
>> Darren, what's your opinion about this?
>>
>> P.S. I'm not against this approach (just some technical comments I
>> already shared), but on the other hand it would be nice to have undo
>> that deprecation and follow the standard in new firmwares.
>> Would you agree?
> 
> Sure.  Due to the timing of how long this will take, even if SMM communication
> ACPI table is undone from deprecation we may have to still support both EPS
> and SMM communication ACPI table though (maybe it would be order of preference).
> 
> 

I have confirmation that the EPS table will be 16-byte aligned, so I can make that
change.  I'll send a v5 with that and the updated comment.
