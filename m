Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3637C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B915218D0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5e6GWUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B915218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeHEVdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 17:33:00 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45657 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeHEVc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 17:32:59 -0400
Received: by mail-ua0-f195.google.com with SMTP id k8-v6so9821376uaq.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hk22uFlSagTRl/AuL24BOOFZKVv026RsCIUW0M2x5U8=;
        b=M5e6GWUVBzYmfdd4mzjnKLlvsL9mAIa26ky2L07tUkZYlFRGFVK9H26zFFNkU4+OoK
         Y1D5sAG9EH/IKKxSv8l+D27iF/1UKUcj4bA5h5Ltf37D3IAWdHauB8XZxjNokwJ8RuyH
         Ak/rYZctqWbPZeItt5OxL3yvCd/nagdR0OZWOab/WrtgyBQ8E8cTuZVW+i4DlnXdBGqO
         IDDdflgxYtvzXcqBBIBbxXoveM/EX5fgF+lkiztdNKrkoSXejRSiqE7trAstJ7W3MtFZ
         FikSw3XwYn0CyczvzNuw/XuvbvOGBG/ELzFKrf/ombjpgeIxIsmx7ZeKVnYv+kPMdVa4
         5vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hk22uFlSagTRl/AuL24BOOFZKVv026RsCIUW0M2x5U8=;
        b=m6sDzscH98S3VpZ+ds0zEmGN/cpDY5MnSIGW9tnyT9vZKEdfMidhhRYxwIOgX2ZPZI
         HywhcchlBo6+2WvdQeqCaLoN0gGBaUpBdVkJes0awtQ3ELLAp1fbaZ4H/6yAgeTpPdw1
         vmXSSLlF+tmeDKQp0JKBVstMc5M6AZlbf9H3AUsXHl1rjkbYaiuFxgZwv3Vt8XBWHkIg
         bcc8nsPhheww/KwH1j91AJEtsIXYQRlDX1X7hK0MiN9gnZqHdG2BkPhwRrirGkj2OYfh
         1yDUBySRPPP4XVjYagEzjyyAc7QOdVQped02qRNrLo8U9jrsvPlj8M1aM6tx2m/tZHVG
         DYCw==
X-Gm-Message-State: AOUpUlFMPOsUnIA7kFrS1GG9Ktt2gjoDzUdNZmwMK4J30M0bTqb5OFKE
        /Y95grLYwXDrTL8UvHhipTQZrmdpbsh3/oPwFYNOWvYL
X-Google-Smtp-Source: AAOMgpcUf28ukWFGsjAp49iMpIkzjFYcZM93UEzG7U55CzVQ8nqd75NF/KHoV8tMQhETmxlklEUUQhGq0U74I89ZAHg=
X-Received: by 2002:a1f:ccc5:: with SMTP id c188-v6mr7458476vkg.151.1533497242261;
 Sun, 05 Aug 2018 12:27:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:7187:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 12:27:01 -0700 (PDT)
In-Reply-To: <a88b1975-4232-4b6f-9497-ab44dbdda5d6@suse.com>
References: <CADPp2fB3Oj3Jm08rVqeHxX855EnO8+22-H552Q6AFfJL-dWmtQ@mail.gmail.com>
 <a88b1975-4232-4b6f-9497-ab44dbdda5d6@suse.com>
From:   Adam Novak <interfect@gmail.com>
Date:   Sun, 5 Aug 2018 12:27:01 -0700
Message-ID: <CADPp2fCY7DKi_0fxi+r986T3e=7rzygAPHLby6amcdC11f+=Hw@mail.gmail.com>
Subject: Re: Problems with Zen under Xen and recent Linux kernel improvements
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I am using Xen version 4.9.2, specifically 4.9.2-0ubuntu1.

I am seeing the bug with *kernel* version 4.15.0, and specifically
Ubuntu's tag Ubuntu-4.15.0-23.25. That appears to have the "x86/cpu:
Re-apply forced caps every time CPU caps are re-read" patch, but not
"x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths".

I can try cherry-picking that commit. Are there other commits in
particular that might need to be pulled into the Ubuntu kernel to get
it to work?

On Tue, Jul 31, 2018 at 4:58 AM, Juergen Gross <jgross@suse.com> wrote:
> On 31/07/18 03:14, Adam Novak wrote:
>> Hello,
>>
>> I was advised to take this here, and to Boris Ostrovsky and Juergen
>> Gross, by Thomas Gleixner.
>>
>> I am having some trouble with the new speculation control code that
>> has been added to the Linux kernel, for AMD Zen CPUs. I am running an
>> AMD Ryzen 7 1700, and I am running Linux as a Xen dom0 (which is part
>> of the problem; the code seems to work fine running outside of Xen).
>>
>> I started having trouble on Ubuntu's commit
>> 3f6a3b035f91a22c0d3bd27630bf61eac9c8cf6c, "x86/speculation: Handle HT
>> correctly on AMD", which appears to be cherry-picked from
>> 1f50ddb4f4189243c05926b842dc1a0332195f31. Since that commit, my system
>> hangs during the boot process; it starts starting stuff up and trying
>> to mount things and printing "[OK]" messages, but then fairly early in
>> the boot process the kernel complains that it is "unable to handle
>> kernel NULL pointer deference at 000...0008"
>>
>> On my Ubuntu bug:
>>
>> https://bugs.launchpad.net/bugs/1777338
>>
>> I have a "Screenshot of the null pointer dereference message". It is
>> running into trouble during a spin lock in the new
>> speculative_store_bypass_update().
>>
>> Has anyone else seen this behavior on these CPUs under Xen (I am using 4.9)?
>
> You want at least 4.9.112, especially due to the missing patches
> "x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths",
> "x86/cpu: Re-apply forced caps every time CPU caps are re-read"
>
> Juergen
