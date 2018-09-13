Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E16AC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE9E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZzXmeOYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE9E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeINENK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 00:13:10 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:44827
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbeINENK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 00:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1536879695; bh=9ymXK2klKZOgr5rqdQaG88uoVjgEpBolLcefErCMuNk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ZzXmeOYkj22RT2Fr6sKYSX0gD75loZ3fJPUzXijv0p9EPBzUPOKtHWQCR8AkW5iSvVQnT6D+YzTI4PiuidIquRLE9ythOwKNuqjXnz1T7XAJJ3OnfRjmzf5fbkn8Mh09TJqeT3A3Mn+8ixlZAtGnS3lCaSTaMGYd5uENvzf/MhzEIHoB0M/HcyAE77IT3eEple1rdhRUA6HCDJmJ403mpZsYLXFcH2XYni1ZDtO1GZgI1dTZgNjyIn5AS9/RNudMl2bVvoTLAZEkoP6vXIx6gkPGsm5e3tGZoODs/SFQqxWQNIIxhRoWL0Qm8/R5g7mN6V2Gv9YnZkApA3UDzjII0g==
X-YMail-OSG: tACzQY8VM1m0t5mi4Vj3oPUnfPkAaXKhvCrS6.FFDPpoBYVZMZ.VQti.8ehb_cT
 KCEGJYkVMzKtlmvL42rDFAnVsG5uwEebBp6jyorKBFqjA6t0czLpRhlLclNnifz.NFWMrytwoNUb
 sTD9plBj3N7YOgToEInKc4jf17yi6_6.ThjpJNXir3gHST_DPq8a3Wg9rWN8H4LCIbJL80u28qe4
 9shvGGQM43Bt6MtVRgqCZxk16Ch6TLba4w33tW_LLToVUOWXauNIrb29mZzUmL6JZiTz2X_K74Tq
 dM495245Q.JlnCAFMEkw74wFGc5agy._CZnM3ZRTo_GgvoWC6IHBRpOfwfqDkUqGfFx6GfTjiSGu
 UCFq2sOxBQ3YPoge57emKv8bfOabaRJcUGrl1w7ZnEoxQ5qAJhEk7Y7lgNVrJbDkMZL_g9y_0VTv
 WbpEQlj0YyxveOqzi9rAXskV7ixS2tqw1QKXTo1yBOwtXeppp74fHa.nl_QE8W_lHq_MaiY6s4Uq
 5s.BpAniz7Y5SYv7gLcJfBBeZftt1Ar5B8DFoB5dCPNt_CSimp4dIxxaZv_NpUmMU7yJ3iGaLjmk
 85demhDsqalsS0fyERFxXQwPlCbPVcZ4.rp0Ld2OLGW6mWiRQ_VgAQ71FUHdfdFk9tQc6nCRC_8e
 UyqmgLsup5BcaIi0HoyNxrH9FmrOO2RmqdXOiT39SQzb3DJKPyIEHRI5vYp1b41O8CuoL.qfw3eb
 US8p7UMfsLJEhd.mmhlDAkuyP9XWBA93LMz89UaNTU7wxvvjMI7MWe0l5mJulQCZXCWDpLNL_GE0
 S62xuvd3.G0V.Svsfw2pOBIRgv_TR86ZNsj5h9hRDonDNQN62hBY_fqIoXYYpK1AbjbNkqir07XO
 H8Oc9gcqZZ2KNw7V5u_SbjaWvWi25pig6B7dS0L7Q_UfL.D5E_kRFiNnvF_ByQuGp1cPrPMqy15g
 1G3SmjqSx034q6SeA6UFdh7MvJP3dJTba9LsdODFfS8Mtczmnsz_NoLpFamGJLtLPZqAwYpzvF25
 GcRWzb8iNjU.u_sDjCbicfzP2Dsk7mVB7kzd8Puu65NSzZg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Sep 2018 23:01:35 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp413.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0ed57e84cfc0d54239bf60355712cbb2;
          Thu, 13 Sep 2018 23:01:33 +0000 (UTC)
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Paul Moore <paul@paul-moore.com>, Golden_Miller83@protonmail.ch
Cc:     keescook@chromium.org, linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, casey.schaufler@intel.com
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <tb3zfQ7fac9Oth8YArOo84SbMfqV1s0DjOmVy7op90J_o1XOaEjflZloOpj9PIiUQRhKJxhauXzJD3irkSSjOXK94qYlfQ1frIQiH1OTWPQ=@protonmail.ch>
 <CAHC9VhR0qfTn3qwVGpBV=LcM8O1jz-dmqxTW0OqJ-xfO+1k6ew@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <372226d8-89ec-312d-7698-9b2b9e8ec85b@schaufler-ca.com>
Date:   Thu, 13 Sep 2018 16:01:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR0qfTn3qwVGpBV=LcM8O1jz-dmqxTW0OqJ-xfO+1k6ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2018 2:50 PM, Paul Moore wrote:
> On Thu, Sep 13, 2018 at 4:58 PM Jordan Glover
> <Golden_Miller83@protonmail.ch> wrote:
>
>> This implies that your real concern is something else than
>> CONFIG_SECURITY_STACKING which only allows you to ignore the whole
>> thing. Please reveal it. There are a lot of people waiting for LSM
>> stacking which is several years late and it would be great to
>> resolve potential issues earlier  rather later.

It would be really handy if the "lot of people" were a lot more
vocal about their impatience. Keeping the stacking work on the stove,
much less on a front burner, hasn't always been easy.

> What?  I resent the implication that I'm hiding anything; there are a
> lot of fair criticisms you could level at me, but I take offense at
> the idea that I'm not being honest here.  I've been speaking with
> Casey, John, and others about stacking for years, both on-list and
> in-person at conferences, and my
> neutral-opinion-just-make-it-work-for-everything-and-make-it-optional
> stance has been pretty consistent and isn't new.

Paul has always been quite upfront about this, and responsive as well.
I won't say that we always agree because we don't, but I don't have a
good argument against either point.

> Also, let's be really clear here: I'm only asking that stacking be
> made a build time option (as it is in Casey's patchset).  That seems
> like a pretty modest ask for something so significant and "several
> years late" as you put it.

There's a significant difference between something taking a long time
and something being late. I hope that I haven't given anyone the impression
that I'd have this finished years ago. If so, I owe whoever that was a
beer. This patch set may look deceptively straight forward, but there have
been many heavy branches pruned from the tree. This subset of the total
change for "extreme" stacking represents the easy part. Without a road map
for completing the task (i.e. any/all modules together) Paul's hesitation
to take anything is defensible, and the desire that it be configurable
reasonable.

