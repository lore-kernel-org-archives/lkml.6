Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D50DECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B9420846
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="nv/S24D/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B9420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbeGLXb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:31:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43151 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732464AbeGLXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:31:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so4352710pgr.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DcK46Q99O7zg0qFywGK5ISuKvrCOmsvXy4TNoaEAQ0k=;
        b=nv/S24D/ymDVmWqNcKQgMMzKNb4B91ZckfdTrdqgtvXif/+77n3ISn2elOSIwUOYXz
         VkW0F7zys5YRuNgSbrO4FoHHasFj8hww6bP8zflbNprFUw6asBVJPiMVrDZFxuGXbcN+
         C9VwPGzI5zcWo/UfBhgA4tkCi7hr/DYz/9/c8TVNjdRxTi0Om9vr/FAjo6OPJGjA88tm
         7gpF5Ikshq116NUWytS9w8kVUFIMCac1F71cimNcK/dD5mjQmnwMSY26e5bkGAExKmAu
         T+zSpowuIQLBr5esbTB5W3qyFEsHtrWi3YsIKO3D6d1pbvfXjy5H9dFi0z8KwzKA7xOs
         IxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DcK46Q99O7zg0qFywGK5ISuKvrCOmsvXy4TNoaEAQ0k=;
        b=OtaTG9lZEkBlY+nSQqRQo6wNEdVh9I2bDRtmuiX806PRvDjsRaIajS/2I82ssrC2pT
         UtcAzXeXQTSinkvJFLTIXTtJeyiw92Q5sMqAa7QgOhtBibWRT4e2GcW02CyhCvuKPB6c
         VJGIDyP3sDXV11JGtolk27Ne0XaVDyNlikaFNF1B53L+TJweYmuPX7P7Amv76rF6JO54
         MCVw6EDSsWFHZtE2FrSisrzdcRXwsgjCTyjIZZEyXqDE0475lipg9cm7H4pMVoq/V1sL
         oAhj3dCNmyJtuEvGkg6A/Z1nmvTgmHqyPdS0W7Xs2UaV6PBUkNoTLNfT1SlG19inH9F9
         DVOg==
X-Gm-Message-State: AOUpUlF2SWkkRE98U5en6HLV5dMMUx1ZnOvvylQygDBmt9Z5tsTCCABj
        sygOdHnP/cmbdS/YwZhXLgPM8w==
X-Google-Smtp-Source: AAOMgpfjMwXOfow8HXj0Kx+KvqSmZrh9mUrDCQk6hu+JF8bSFyMvXEV8wTSS9Rd3x/X5kpRTo30bLA==
X-Received: by 2002:a63:8c0b:: with SMTP id m11-v6mr3854123pgd.372.1531437609695;
        Thu, 12 Jul 2018 16:20:09 -0700 (PDT)
Received: from ?IPv6:2600:1011:b01e:e4d1:54df:ba07:cac1:aeab? ([2600:1011:b01e:e4d1:54df:ba07:cac1:aeab])
        by smtp.gmail.com with ESMTPSA id p8-v6sm6040326pfk.186.2018.07.12.16.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 16:20:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: vdso: Fix leaky vdso link with CC=clang
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <1432bfde-41b4-e8aa-037b-fca41a149cb8@zytor.com>
Date:   Thu, 12 Jul 2018 16:20:06 -0700
Cc:     Alistair Strachan <astrachan@google.com>,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, kernel-team@android.com, joel@joelfernandes.com
Content-Transfer-Encoding: 7bit
Message-Id: <5AB78E47-BC62-4DA5-920B-00E9731AAE04@amacapital.net>
References: <20180712201032.156997-1-astrachan@google.com> <47d4b24e-8c60-fb3b-3377-62d20c5f3dd1@zytor.com> <CANDihLEz3_fZ4r4g=VcxWps5DWSjMJdbJZKZWsLFKVp_c7FscA@mail.gmail.com> <1432bfde-41b4-e8aa-037b-fca41a149cb8@zytor.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 12, 2018, at 3:06 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> 
>> On 07/12/18 13:37, Alistair Strachan wrote:
>>> On Thu, Jul 12, 2018 at 1:25 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>>> On 07/12/18 13:10, Alistair Strachan wrote:
>>>> The vdso{32,64}.so can fail to link with CC=clang when clang tries to
>>>> find a suitable GCC toolchain to link these libraries with.
>>>> 
>>>> /usr/bin/ld: arch/x86/entry/vdso/vclock_gettime.o:
>>>>  access beyond end of merged section (782)
>>>> 
>>>> This happens because the host environment leaked into the cross
>>>> compiler environment due to the way clang searches for suitable GCC
>>>> toolchains.
>>>> 
>>> 
>>> Is this another clang bug that you want a workaround for in the kernel?
>> 
>> Clang is a retargetable compiler (specified with --target=<something>)
>> and so it has a mechanism for searching for suitable binutils (from
>> another "GCC toolchain") to perform assembly and linkage. This
>> mechanism relies on both --target and --gcc-toolchain when
>> cross-compiling, otherwise it will fall back to searching /usr.
>> 
>> The --target and --gcc-toolchain flags are already specified correctly
>> in the top level Makefile, but the vdso Makefile rolls its own linker
>> flags and doesn't use KBUILD_CFLAGS. Therefore, these flags get
>> incorrectly dropped from the vdso $CC link command line, and an
>> inconsistency is created between the "GCC toolchain" used to generate
>> the objects for the vdso, and the linker used to link them.
>> 
> 
> It sounds like there needs to be a more fundamental symbol than
> KBUILD_CFLAGS to contain these kinds of things.

How about $(CC)?

> 
>    -hpa
