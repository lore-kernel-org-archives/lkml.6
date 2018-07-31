Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59486C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B21320841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="jXCwTA29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B21320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeGaQKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:10:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47012 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbeGaQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:10:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id p23-v6so9163422pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wIQG573o+JRvmpcvV7ZUMk/gkWZriOscBdmFH2glTqI=;
        b=jXCwTA297x453Z/LiGh6dwi+Yk+kE7rG0T5pJRZF0C3sXkr++MQwZz/5C0Z7JJerdz
         qaUiVyHu9rFn4MoYGiTsiOenOWJ6wvX+wigUh9Wgqp+r9eu4Y4XnLyG8z0rWf/lEmdG3
         m5k08c/sbG/t1dmAIG2oaew2b4q3LLsw+YEuYLG13gLH2jAPynge1Yvu+sn9k0IK82LS
         Jg+luqjnsNlfEKKYAcogtN/NFDl5Dr0iczqzC+SmCsBRTNyHPBsJQf5GIQukt3vJ6nvP
         omo3HKeYu8Wm69F8TkBX9oXYUSKDNwFg2hJoS1ZKnWD6KSoARh3nzktqErjnJR/92hjY
         bj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wIQG573o+JRvmpcvV7ZUMk/gkWZriOscBdmFH2glTqI=;
        b=uN/MGdoIPqZXH1SL82O6oXKxG8QZIt93ycBBIBd2UQu+f0EDvhLfHwbedII5yjSDFT
         D6yBmAJqzHZh/JrxEdN2s/3M2CLfx9W7G7+2RXYWZSUVN0jhBXXL2sqJQXtIWORPRv+V
         uZ4Fj4wGLQEdC099nBorLiBmcOGTgYbZ/uiz3qV3KaWryYAPwGLqyDdYruf3sIWtGPdF
         3g9Hp27IcwUPBhzrZhIbF0ZtB7ulrsnC7XU9rrXkZ85k4lo4qvgg2xOeTMlS+SnXYvZd
         TS3jxmIwgXVgKx9os+sjBbJq02e7NhpGdpZl+VShG8BKy1vgVRIB9y8iWEvQB4L/f7Ah
         eIkA==
X-Gm-Message-State: AOUpUlHcO9K2oYykhUD5+oeRbA+TUDP3zUps003PU+wY3swWaFH3WHeI
        2jZuYS1ooyh990p6tYxExGOhfw==
X-Google-Smtp-Source: AAOMgpeUTUPgaiybKlO4FeZNdkqV5IgjbRedSTEcja2CIMvMYAk7jtUMqrPqLwFl8WI5U250D7Ktig==
X-Received: by 2002:a63:3c0c:: with SMTP id j12-v6mr20396542pga.440.1533047368297;
        Tue, 31 Jul 2018 07:29:28 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:258b:eb0a:93b4:e6a8? ([2601:646:c200:7429:258b:eb0a:93b4:e6a8])
        by smtp.gmail.com with ESMTPSA id l3-v6sm20102954pff.8.2018.07.31.07.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 07:29:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm refcounting
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180731091248.GS2494@hirez.programming.kicks-ass.net>
Date:   Tue, 31 Jul 2018 07:29:26 -0700
Cc:     Rik van Riel <riel@surriel.com>, Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9664A02-AD53-4A6A-8A56-E729DC919E16@amacapital.net>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-11-riel@surriel.com> <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com> <20180729155452.37eddc11@imladris.surriel.com> <20180730095502.GG2494@hirez.programming.kicks-ass.net> <1532961011.28585.30.camel@surriel.com> <20180730162653.GM2494@hirez.programming.kicks-ass.net> <1532999155.28585.56.camel@surriel.com> <20180731091248.GS2494@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 31, 2018, at 2:12 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Mon, Jul 30, 2018 at 09:05:55PM -0400, Rik van Riel wrote:
>>> On Mon, 2018-07-30 at 18:26 +0200, Peter Zijlstra wrote:
>>>=20
>>> So for ARCH_NO_ACTIVE_MM we never touch ->active_mm and therefore
>>> ->active_mm =3D=3D ->mm.
>>=20
>> Close, but not true for kernel threads, which have a=20
>> NULL ->mm, but a non-null ->active_mm that gets passed
>> to enter_lazy_tlb().
>=20
> I'm confused on the need for this. We mark the CPU lazy, why do we still
> care about this?

I have considered renaming enter_lazy_tlb() to something like lazy_switch_to=
_kernel_mm() (or an irqs_off variant) and making it take no parameters or ma=
ybe just task pointer parameters. M=
