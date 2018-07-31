Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97145C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA6320870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFiscG9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA6320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeGaJjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:39:19 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40507 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeGaJjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:39:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so26265839oie.7;
        Tue, 31 Jul 2018 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4LFGO3vfeqaGUEywzbWbQQYuApoEQgeDKVJCDqgteqY=;
        b=NFiscG9d49HxidY8lx0jGbcYTk3PwgbjhENGfTFJSXIeru3xNoyBBHNrR8zjOqfUKN
         EEmeTnLk29ERiVOHw03gI2GJ290ROPXrXauTG/iJqbZAcaiO8iIzQvSoN1jMgR4511Bc
         hm9MUtvPqq05eLt7XWqy3pmD/vq67UrhxZJUx4CLLL9OELEn9Jqdr64t0SJWvZRnv1nY
         TsC1eLZlusBQXjG9wZ7ogBfMTk/oZ8DB2pWeZRNHv+UT+xhFB99CYJ6QIhouaGKyeI16
         bqemE7S9oT867lxNttA9t3OJORipqGqrg4BXvSlzbyS15xp4T+aG8sPoY/770SFYice8
         JeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4LFGO3vfeqaGUEywzbWbQQYuApoEQgeDKVJCDqgteqY=;
        b=sz0m6CRzD+QAZ89ddy0fyFyeE44vPSWiDtl+DQb/2DV1xv08DlOMMuRgrJnTameQlx
         gIGUC/HCLWhDNC3V997KZw7oabJM+wF23pT1fIJ4tTnzxUGCW0xDNIUpGgSPq2gULeif
         o7d6Bj3F5TUc91s4REFhc98o/sewsM2Fuo/z5YEJ7bIEqLF0l9G98+yRwqbV3dGThaXi
         zvKNX5r+mAfl2w9BZ46emV9kRuOmHhajVGldErvbozZiKTYlRHbL60NbkgVztFTg64HO
         6brOt74qGee4u+FxgNsMFLxcd+LlmFvzERyUUrEFoB7BA3Ovn3BCaI2ygYr2qNH0dfEI
         02Sg==
X-Gm-Message-State: AOUpUlElAY00qFk8jLcv3w0Oqg8RkdIY/JJL+ZCAJ1BTl3JWpBtEvJWx
        JbaTtCqHkb0dxPEaExRPfIipfMBmb+1i9UZNRLw=
X-Google-Smtp-Source: AAOMgpf1exKm3SUh5t/l1Z3uIP8EVZMfHNGa44zyz+bt0CGDwbSBlaZWx2JBmYBbEhjQK15lsPPlfQcra/ZZxY9V0nY=
X-Received: by 2002:aca:b841:: with SMTP id i62-v6mr20299953oif.358.1533024013586;
 Tue, 31 Jul 2018 01:00:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 01:00:13
 -0700 (PDT)
In-Reply-To: <534629d03437bc8e72a62d89e726dbe5@codeaurora.org>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
 <CAJZ5v0grRtkm5mZto-UW3Dn=OnbAbBARyH12T22V5gZfSaV5dw@mail.gmail.com> <534629d03437bc8e72a62d89e726dbe5@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Jul 2018 10:00:13 +0200
X-Google-Sender-Auth: ltZVTwZ_lfG_XGWNPUxLEnohmAo
Message-ID: <CAJZ5v0jYmy9z488bg8gbAGceRqv-c-ONhW0DtaKD6GUGUnCTLw@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Generic cpufreq governor
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 8:58 PM,  <skannan@codeaurora.org> wrote:
> On 2018-07-29 03:52, Rafael J. Wysocki wrote:
>>
>> On Sat, Jul 28, 2018 at 5:56 AM, Saravana Kannan <skannan@codeaurora.org>
>> wrote:
>>>
>>> Many CPU architectures have caches that can scale independent of the
>>> CPUs.
>>> Frequency scaling of the caches is necessary to make sure the cache is
>>> not
>>> a performance bottleneck that leads to poor performance and power. The
>>> same
>>> idea applies for RAM/DDR.
>>>
>>> To achieve this, this patch adds a generic devfreq governor that can
>>> listen
>>> to the frequency transitions of each CPU frequency domain and then
>>> adjusts
>>> the frequency of the cache (or any devfreq device) based on the frequency
>>> of the CPUs.
>>>
>>> To decide the frequency of the device, the governor does one of the
>>> following:
>>>
>>> * Uses a CPU frequency to device frequency mapping table
>>>   - Either one mapping table used for all CPU freq policies (typically
>>> used
>>>     for system with homogeneous cores/clusters that have the same OPPs.
>>>   - One mapping table per CPU freq policy (typically used for ASMP
>>> systems
>>>     with heterogeneous CPUs with different OPPs)
>>>
>>> OR
>>>
>>> * Scales the device frequency in proportion to the CPU frequency. So, if
>>>   the CPUs are running at their max frequency, the device runs at its max
>>>   frequency.  If the CPUs are running at their min frequency, the device
>>>   runs at its min frequency. And interpolated for frequencies in between.
>>
>>
>> While not having looked at the details of the patch yet, I would
>> change the name of the feature to "Generic cpufreq transition
>> governor" to make it somewhat less ambiguous.
>
>
> In my opinion it makes it look MORE like this is a cpufreq governor. How
> about the following?
> PM / devfreq: Generic cpufreq to devfreq mapping governor
> Seem a lot more clear to me.

Well, it's not just mapping, but also it triggers on cpufreq transitions AFAICS.

Which makes me wonder if the approach here is the right one at all.

Shouldn't the cpufreq driver be hooked up to the related HW through
the OPP framework and sharing access with devfreq rather?

> I'm open to suggestions for the devfreq governor name too. "cpufreq" has
> been very confusing so far.
> cpufreq-map maybe?

It's more like "cpufreq drriven" IMO, but I don't really have any good
names for it in mind ATM I'm afraid.
