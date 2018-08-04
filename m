Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CC5C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A1721777
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBHPT1EK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A1721777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbeHDXFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:05:09 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35027 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbeHDXFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:05:09 -0400
Received: by mail-qt0-f194.google.com with SMTP id a5-v6so9921950qtp.2;
        Sat, 04 Aug 2018 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sdfeb2nS5uYQ4PBlIa37BEliJtunLI143ByWiSgM7hg=;
        b=GBHPT1EKssTeefhOXJWV6g68jiYnA90UAduk9Xot+upCwG1Pgjd/Ah0lVz+7K3L+dm
         TZTY6UDCVwJJPEk8CtOqBvPoctHa3Ku3S1iMRT85CGh14YG6d+1Eg1aaWdLcGD+hzykk
         UxQ76a6jZe7r74nV0sDbyHo7K7+wLncQO0rju8SM4+jrjH+saqxU2QARmA97q9nikPjf
         7XjSjSwn20tUeD3LcASrlNHWtQTbIH4+ay7dD+YKvopvyUC5ZL9ZrTbdzI2qpzq+tBmu
         3LqBIfzUSe0vyvGqj9IGj79CzGZle+8VifPiKLtYI8aQtsHzvtYDrLK1rX7QcKOdyXAv
         3+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sdfeb2nS5uYQ4PBlIa37BEliJtunLI143ByWiSgM7hg=;
        b=BWKAtQASUk3MApSHNtSw70z44APaBXaRQeh7gsHiVydorTRenet8+m0TP4AnWJohFB
         Bt0ipnidtoI/SR2tuc3cfs6ZSl9QcK14Px25FlRNfwTaVZ7r2H7a8obI8FH3up86hKTE
         VVnlFiZhbPNm2FJpZha/LU90gSQEtnlJfO1fMEBeOoriisuRUEpcG647GGcTT1noMkJH
         rHOTePzs3dXoREv2mfCyj8raNzoYHocI5vLlGmgsdlNAWSuS9yCzcO1Vi8olvmBMrpOr
         Fe0vn6ti5/6wPPSEd1XvxoD18gTRj3alv20tcPPYMyZ6OWimRiWFloGT5aLVKP9zhSmO
         Wjww==
X-Gm-Message-State: AOUpUlEAAS3L4RM8IukjzUpLliGVqQugXk7CoFpk7qhHjeQQxOLrJbEl
        9Q2JCzFhLrjJoa4KzW9TNjw5OMSAx7U/rKY7Mk4=
X-Google-Smtp-Source: AAOMgpfrwfgIUpdystMUe4Eq9DY2fmzTpimpz4qRAyHTf8hGpt+YLWN5QcXA+0a6PmCkMuN0Qs/pu1Lrq8HubyoPbbk=
X-Received: by 2002:a0c:93b3:: with SMTP id f48-v6mr8064789qvf.151.1533416591769;
 Sat, 04 Aug 2018 14:03:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 14:03:11 -0700 (PDT)
In-Reply-To: <20180804124309.GB4920@kroah.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com> <20180803055640.GA32226@kroah.com>
 <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com> <20180803103023.GA6557@kroah.com>
 <3360edd2-f3d8-b860-13fa-ce680edbfd0a@hauke-m.de> <20180804124309.GB4920@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 4 Aug 2018 23:03:11 +0200
X-Google-Sender-Auth: D5xT2V0G6ccViDmL1AOUBIAPRBk
Message-ID: <CAK8P3a3qs34LuhPeaef2wPHYEWbYO5N-4n7763BcaDyppiJ6DA@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] serial: intel: Add CCF support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "Wu, Songjun" <songjun.wu@linux.intel.com>, hua.ma@linux.intel.com,
        yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 4, 2018 at 2:43 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Aug 04, 2018 at 12:54:22PM +0200, Hauke Mehrtens wrote:
>> On 08/03/2018 12:30 PM, Greg Kroah-Hartman wrote:
>> > On Fri, Aug 03, 2018 at 03:33:38PM +0800, Wu, Songjun wrote:

>> This patch makes it possible to use it with the legacy lantiq code and
>> also with the common clock framework. I see multiple options to fix this
>> problem.
>>
>> 1. The current approach to have it as a compile variant for a) legacy
>> lantiq arch code without common clock framework and b) support for SoCs
>> using the common clock framework.
>> 2. Convert the lantiq arch code to the common clock framework. This
>> would be a good approach, but it need some efforts.
>> 3. Remove the arch/mips/lantiq code. There are still users of this code.
>> 4. Use the old APIs also for the new xRX500 SoC, I do not like this
>> approach.
>> 5. Move lantiq_soc.h to somewhere in include/linux/ so it is globally
>> available and provide some better wrapper code.
>
> I don't really care what you do at this point in time, but you all
> should know better than the crazy #ifdef is not allowed to try to
> prevent/allow the inclusion of a .h file.  Checkpatch might have even
> warned you about it, right?
>
> So do it correctly, odds are #5 is correct, as that makes it work like
> any other device in the kernel.  You are not unique here.

The best approach here would clearly be 2. We don't want platform
specific header files for doing things that should be completely generic.

Converting lantiq to the common-clk framework obviously requires
some work, but then again the whole arch/mips/lantiq/clk.c file
is fairly short and maybe not that hard to convert.

From looking at arch/mips/lantiq/xway/sysctrl.c, it appears that you
already use the clkdev lookup mechanism for some devices without
using COMMON_CLK, so I would assume that you can also use those
for the remaining clks, which would be much simpler. It registers
one anonymous clk there as

        clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);

so why not add replace that with two named clocks and just use
the same names in the DT for the newer chip?

      Arnd
