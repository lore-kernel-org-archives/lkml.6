Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1D6C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131502086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3MSvPkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131502086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbeKNAXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:23:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44646 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbeKNAXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:23:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so10953565lji.11;
        Tue, 13 Nov 2018 06:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BjlCuWwV0XhG5M/Vs9+XqiQhcHAPHhzqj8fntK4oh4Y=;
        b=a3MSvPkFyT+SkEEYH/s0Ek7nd/Rl3ZC3qx99za4CxikuJhU5aAtrGf7yArtQOdd84r
         168IZM/NVm+JtHv22doUNsPcdou9LficsLjHm3hSB3xB+krst4Hjmo+p+aHORuapOoMU
         Ni2DwqlK1eseoOBsZIkN8muGqpI4p9tIXTL0rNULKqJYPOwzC1dIBom4WQIlNUKzRc/9
         t7UG4g2AyLh8iI1mdc4Jc/lE4SLDZ+2s+3aQr2wp1mGv/zTZ82nch/oO2Y33c8RPm3Ve
         V4ZAywJ7UxuV7f6FkAQBUgflYg2DefYO8fJOgHl8Cz7mcQXmy4l8OPPjG+sgZWVvJ5tZ
         TghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BjlCuWwV0XhG5M/Vs9+XqiQhcHAPHhzqj8fntK4oh4Y=;
        b=I9vAydNNttZs33kn0yHj6GttzEirkKLMzr7ldZS87DalZ432rbKIj7wvtCslFMQbq/
         PML5sm2lX4KBe/slvJiAQOJE1hgWkrHGODCCEpLMzRFy+p5AlfBircwEi6LO/s9xjFeQ
         NSMDrABLhxOM8ejQ2RKGQG97d8gS6ZlfoCBGyaJm5f0SHEmH7tO+sk9iVjSdArGeuhM/
         mV2bDbwMWVvoz1gMOqqnq9v62qnW8m6Z1SUdqogh4RcchY77bXzBqWBUPdFyvbJMAcHD
         SPPwu7GxcsgTAuDRycpBPyY++EYz8z0FBhQ6VKvlP8QD1aiOKdTyggReX31ktqGSozzy
         aPkQ==
X-Gm-Message-State: AGRZ1gJ91q1WbLIiJvrkGlcpvvWZ7XyVSEBZEDygFXWX0gHNf8KgJYMO
        4wO2zWpgglANtJ66YqXWzqE=
X-Google-Smtp-Source: AJdET5ezMdNoePu2JHKcFskIid7SjooAJ77ZTagbpFpg8MCSqPQ6bOYsCd2Bg/b02XGc9NHC2UAhug==
X-Received: by 2002:a2e:8596:: with SMTP id b22-v6mr3243629lji.122.1542119116280;
        Tue, 13 Nov 2018 06:25:16 -0800 (PST)
Received: from ?IPv6:2001:14bb:40:1c40:f0bf:dd2d:f008:5213? (dkyrfb8g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:40:1c40:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id w12sm2461903lfe.80.2018.11.13.06.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:25:15 -0800 (PST)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
Date:   Tue, 13 Nov 2018 16:25:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I've been studying v4 of the patch-set [1] that Nadav has been working on.
Incidentally, I think it would be useful to cc also the 
security/hardening ml.
The patch-set seems to be close to final, so I am resuming this discussion.

On 30/10/2018 19:06, Andy Lutomirski wrote:

> I support the addition of a rare-write mechanism to the upstream kernel.  And I think that there is only one sane way to implement it: using an mm_struct. That mm_struct, just like any sane mm_struct, should only differ from init_mm in that it has extra mappings in the *user* region.

After reading the code, I see what you meant.
I think I can work with it.

But I have a couple of questions wrt the use of this mechanism, in the 
context of write rare.


1) mm_struct.

Iiuc, the purpose of the patchset is mostly (only?) to patch kernel code 
(live patch?), which seems to happen sequentially and in a relatively 
standardized way, like replacing the NOPs specifically placed in the 
functions that need patching.

This is a bit different from the more generic write-rare case, applied 
to data.

As example, I have in mind a system where both IMA and SELinux are in use.

In this system, a file is accessed for the first time.

That would trigger 2 things:
- evaluation of the SELinux rules and probably update of the AVC cache
- IMA measurement and update of the measurements

Both of them could be write protected, meaning that they would both have 
to be modified through the write rare mechanism.

While the events, for 1 specific file, would be sequential, it's not 
difficult to imagine that multiple files could be accessed at the same time.

If the update of the data structures in both IMA and SELinux must use 
the same mm_struct, that would have to be somehow regulated and it would 
introduce an unnecessary (imho) dependency.

How about having one mm_struct for each writer (core or thread)?



2) Iiuc, the purpose of the 2 pages being remapped is that the target of 
the patch might spill across the page boundary, however if I deal with 
the modification of generic data, I shouldn't (shouldn't I?) assume that 
the data will not span across multiple pages.

If the data spans across multiple pages, in unknown amount, I suppose 
that I should not keep interrupts disabled for an unknown time, as it 
would hurt preemption.

What I thought, in my initial patch-set, was to iterate over each page 
that must be written to, in a loop, re-enabling interrupts in-between 
iterations, to give pending interrupts a chance to be served.

This would mean that the data being written to would not be consistent, 
but it's a problem that would have to be addressed anyways, since it can 
be still read by other cores, while the write is ongoing.


Is this a valid concern/approach?


--
igor


[1] https://lkml.org/lkml/2018/11/11/110
