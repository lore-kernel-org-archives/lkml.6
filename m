Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A412C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C8024F17
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZaz/dn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C8024F17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbeGCCst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:48:49 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41073 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeGCCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:48:47 -0400
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so162405ybe.8;
        Mon, 02 Jul 2018 19:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jzOgsFx75bprPfF/GiE/pCF372lX9XtG0R81km2L3zM=;
        b=EZaz/dn0qZsg2vf54pqKdB0hFbzDbrk29x/QkRqQbZWlBa0e7BHXbIBroPuOHiANBI
         AQWQIsWUQnmc7C6ChPXWyO0ErThCl49g2WEqVnUKPnvKO2I1+HTva9b+Xfxi4KR9O44V
         J4iEk6rR7vBYZQQAIt0iXGVTrHNnjlvO9Qo1LQygjEkgkqNJUl6aXoC/ibx/Pvs8mB51
         QE+ocsU3uv1Z7KHYPh4FPzDG+TI1GMmtXThYCJWkoJ/kRX3A2y8uMY77+M7rjPRMmcKz
         t+217hyZc8HLQiOqamy4cCwLQSLibk0WDuLPA0sANLScBzCSZcpWRh6WUH1t9/rCnvQq
         lkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jzOgsFx75bprPfF/GiE/pCF372lX9XtG0R81km2L3zM=;
        b=TzAYlJLpQQTkMYFvaTHsBwAe1zzdG/mSUEQznuvfXKR3i53WhXjqttfCON45VpFUc8
         imic7vei0xTaWoJRW+qNPgBNQpGgDSVGBweGTgwT2hazuRuNr4z9GF26SCdBv+33vnSG
         Aaq+he6f+8bAt7mlSySf7DQp9zLV5hxjfwzvlUK8yQzc+MmRfaIz8AKYdEm6KtQgbeFn
         AwOvq1Qmlxq2zw79sOxis+F4sOpPlFBzVLHo0b+5J6O8g5+eIZnwZtkLxqm9GjOBfpcX
         O4u8DuFBhO2+b4CJYAJCbMeurmtal7sWRyaXj/Krjn72uZnA1Wt32R5ZIBLMeOPTgoNl
         916w==
X-Gm-Message-State: APt69E1nOqUuFO6nH1X5F8uueGqHBehVO2E2T+ERLWPvpbnhs52zTqQ2
        B3kpF3Jb3aGfBBrQWbHekGQ=
X-Google-Smtp-Source: ADUXVKLZeMBdz34ro24RPJmv1SFxCjEgEqU9573IcevyoQCPtO5E89fVHGLMVEmgtERcX5Std1PYqw==
X-Received: by 2002:a25:bf90:: with SMTP id l16-v6mr15074076ybk.390.1530586126397;
        Mon, 02 Jul 2018 19:48:46 -0700 (PDT)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id b68-v6sm24480ywh.68.2018.07.02.19.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 19:48:45 -0700 (PDT)
Date:   Mon, 2 Jul 2018 22:48:35 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 00/10] Introduce the Counter subsystem
Message-ID: <20180703024835.GA9493@sophia>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <603b0373-f1e1-5938-fa53-8328c9a5964f@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <603b0373-f1e1-5938-fa53-8328c9a5964f@lechnology.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 01:13:40PM -0500, David Lechner wrote:
>On 06/21/2018 04:06 PM, William Breathitt Gray wrote:
>> I decided to strip down these devices to arrive at the core essence of
>> what constitutes a "counter device" and therefore design a "generic
>> counter" abstraction to better represent these devices and prevent the
>> ambiguity we discovered with the existing IIO Counter interface. This
>> abstraction became the Generic Counter paradigm, which is explained in
>> detail within the Documentation/driver-api/generic-counter.rst file
>> introduced by this patchset.
>
>I'm curious if you have given any thought to the time aspect of counters.
>I am interested in the rate at which the counters are counting (e.g. how
>many counts per second). I realize that you can calculate this in
>userspace or in the kernel using the system timer, but it is not very
>accurate since Linux is not a realtime OS. So, I would like to get the
>rate directly from the hardware. For example, the TI eQEP[1], like the
>one found in BeagleBones, has a couple ways of measuring time (see link
>for details).
>
>[1]: http://www.ti.com/lit/ug/sprug05a/sprug05a.pdf

Ah yes, I see you initially attempted adding a frequency channel type to
the IIO code. I agree with you that this calculation is best kept away
from the operating system, not just because of the realtime requirement
considerations, but also because the hardware likely knows best its own
data, so let's expose it!

Regarding the Generic Counter interface, a frequency attribute can be
added quite easily in a technical sense, so this discussion should be
focused more on the warrant for exposing this data. I understand from
the discussion thread on your initial patch submission that you're
working with hot-swappable encoder wheels and would like to expose a
counting rate since you have trouble otherwise knowing the number of
counts equal to one revolution due to the various possible encoder
wheels that could be installed -- do I understand this correctly?

Luckily the Generic Counter interface is a more abstract paradigm, so
the hot-swappable encoder wheels should not be a problem for us as long
as we nail down a consistent and thorough definition for this attribute.
To that end, since the Generic Counter paradigm is designed to abstract
away specifics of counter devices in order to present the final data of
interest to users (e.g. the count value, the mode of operation, etc.),
let's make sure frequency is actually what we want to expose and not
just a middle-step datum on the path to the final result.

What is the real life use-case for this information (are you tracking
position)? Does the relevant hardware report the number of counts equal
to one revolution, or are you calculating this from frequency? Are you
using this frequency to simply track the number of revolutions? Should
revolution count also be exposed? Is frequency useful for other
applications on its own (perhaps velocity of an automobile device
equipped with an encoder wheel for some reason or other)?

Once we figure out how this data is used, we can determine the best
design and place to introduce it into the Generic Counter interface,
then move on to integration from there.

William Breathitt Gray
