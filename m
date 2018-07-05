Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB06C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7B9240C9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXIk4lbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7B9240C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753660AbeGEWbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:31:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42188 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753489AbeGEWbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:31:50 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so9183075ioh.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sug5JS97rTlVkz/prn+QJVSLTqQcj3MaSmDD4yZyoig=;
        b=OXIk4lbfKVgq0lMRK9AWey1m+RL5hTce0ZOZfrRqlOrVkBbaDsTTackpin1XuVMGNc
         iRZWpuYFtWfJH8XlpIzc4yds+FYz+b5cDQBVzyAa/8QqRUcn47KtB84osgG/7mcITBZw
         4h6FzhSXPCT0I8/RfVtYii/27EV2C3pZu8srQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sug5JS97rTlVkz/prn+QJVSLTqQcj3MaSmDD4yZyoig=;
        b=a0tvlug1V2nU433CPsIKNk/kEe+n6E+GRjLagxYJR6XqrMz0kH8dspL/zyr2CccJMY
         R2kYvQ0paYptA0CUaAQhFkkSfatYO2r1xOz/XmWj6R7Ynn9CJwAcuqY1sbUloYg6CbLa
         0FCNbHcNz3W2vlOMmXkxcXxu+5I3mlP9WVcDpclw8e46041slXczdHW5uepKP9VGtSXe
         0LZwcvurA+sE2/rKaz+Z01s4RgHu9Gwd/2XOxyWfNdBiYW56DUXQ1N9Zf2vFLWETsQNk
         cmkyxzKR4UrZTThSfcUPr4Td94yp2E6Met2z7nsxjTpxfWJiPwqZvCA6X0BrUOXOoYYq
         o+0Q==
X-Gm-Message-State: APt69E1ztwTSF5RF1HJSzKI2MSGEHbl9P8aoWwvIwnPn+5Mx2oxf8aKt
        Npnd54x+pwDnEOCAJ/KNDa/0ci0AAhqjvjnRtICCIA==
X-Google-Smtp-Source: AAOMgpe1Vxb0TqN+LwvbmGtFxrcTvCZ2Rr+3PUgwjRvr0YITZPt+icPiJMqdYXnbq4tq5Wwoee0NNihjko2QLJkNW+k=
X-Received: by 2002:a6b:5d1a:: with SMTP id r26-v6mr6391907iob.170.1530829909631;
 Thu, 05 Jul 2018 15:31:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 15:31:49 -0700 (PDT)
In-Reply-To: <20180705164824.GA7445@arm.com>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org> <20180704170655.GD8370@arm.com>
 <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
 <20180705094313.GL28220@linaro.org> <ec1a5f0f-99e3-fda1-9a64-5c2539817190@arm.com>
 <20180705164824.GA7445@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 6 Jul 2018 00:31:49 +0200
Message-ID: <CAKv+Gu-c0wcscUZzRqOTAHg-L70jFf80T=7x6pVPe7iK8-wykw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
To:     Will Deacon <will.deacon@arm.com>
Cc:     James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 July 2018 at 18:48, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Jul 05, 2018 at 12:02:15PM +0100, James Morse wrote:
>> On 05/07/18 10:43, AKASHI Takahiro wrote:
>> > On Wed, Jul 04, 2018 at 08:49:32PM +0200, Ard Biesheuvel wrote:
>> >> On 4 July 2018 at 19:06, Will Deacon <will.deacon@arm.com> wrote:
>> >>> On Tue, Jun 19, 2018 at 03:44:23PM +0900, AKASHI Takahiro wrote:
>> >>>> Since arm_enter_runtime_services() was modified to always create a virtual
>> >>>> mapping of UEFI memory map in the previous patch, it is now renamed to
>> >>>> efi_enter_virtual_mode() and called earlier before acpi_load_tables()
>> >>>> in acpi_early_init().
>> >>>>
>> >>>> This will allow us to use UEFI memory map in acpi_os_ioremap() to create
>> >>>> mappings of ACPI tables using memory attributes described in UEFI memory
>> >>>> map.
>>
>> >>> Hmm, this is ugly as hell. Is there nothing else we can piggy-back off?
>> >>> It's also fairly jarring that, on x86, efi_enter_virtual_mode() is called
>> >>> a few lines later, *after* acpi_early_init() has been called.
>>
>> >> Currently, there is a gap where we have already torn down the early
>> >> mapping and haven't created the definitive mapping of the UEFI memory
>> >> map. There are other reasons why this is an issue, and I recently
>> >> proposed [0] myself to address one of them
>>
>> >> Akashi-san, could you please confirm whether the patch below would be
>> >> sufficient for you? Apologies for going back and forth on this, but I
>> >> agree with Will that we should try to avoid warts like the one above
>> >> in generic code.
>> >>
>> >> [0] https://marc.info/?l=linux-efi&m=152930773507524&w=2
>> >
>> > I think that this patch will also work.
>> > Please drop my patch#2 and #3 if you want to pick up my patchset, Will.
>>
>> Patch 2 is what changes arm_enable_runtime_services() to map the efi memory map
>> before bailing out due to efi=noruntime.
>>
>> Without it, 'efi=noruntime' means no-acpi-tables.
>
> So it sounds like we want patch 2. Akashi, given that this series is only
> four patches, please can you send out a v3 with the stuff that should be
> reviewed and merged? Otherwise, there's a real risk we end up with breakage
> that goes unnoticed initially.
>

Yes, we want patches #1, #2 and #4, and this one can be replaced with
my patch above. Everything can be taken via the arm64 tree as far as I
am concerned.
