Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D89AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD4C20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls9DtSrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD4C20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbeHARIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:08:00 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34257 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389627AbeHARIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:08:00 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so16402782ioj.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ez73GmH1RyapxpKP3SuxPR22jFWRkXKtVjk+TjK2OWI=;
        b=Ls9DtSrgLnEt/Q1AAOD1ooHmjU9DyjxlpZCcjNPiFApXjwzmN5k7MxbL0B++RnT6DX
         A8LrHptF+jMlnYO2y6oh+wSe6tw/PWytgGIRj1pZ76aS8+/4ucVGTuKeZihgxPaAsfp/
         nXYx/SPF/A9YJ7E2tetq4bapZ4LLQkjww4A0RYOZrYpyVT97ShRGGZM+qju5cd0jqEJU
         bQTmm8duTR8Pxyg5Mhn/gV8wy2dxCgad3+FE9q8KAEWf1pRO0J2sJ0MjCtBe2hetNNVf
         D2cSVIHZL4V0Q0TQ0m2HgPDIprC31iz5DeDyM6LfppH0V8Hg/ofzfPQBhgSA3TfcUYdj
         hF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ez73GmH1RyapxpKP3SuxPR22jFWRkXKtVjk+TjK2OWI=;
        b=sTf7qIvfq6rFR5cHVSCJlwDRUXVe5z28Dt7pKuaWismJpaQ+YND7lVZib7/zLc1ipz
         VwteqXzHP8EsCCSEV95mBu0YZ1vKrzr2C72Sdodm+THIy3smSQZluushZHeVzySIrq13
         4YR2RDaKw7NhZF/DImbUSOqL8tjXORASHq0EdCE34OO254VoSdEuHJhCQqcJB+7puC8U
         +mVJ1cLgVpcKz0blcRV6kAugQlbFMbAutDeqDMHj4INjnU+8BRggRNKg9QtlhGQ3zfZk
         nxH8wL8Ff1ME0oHoIQWflAmqlplRAWXsPI4z08DGXJ9r8eWg8wGjrbZOmrDqXb55muJL
         gFqA==
X-Gm-Message-State: AOUpUlEYwkCk9vYhDJE5MplzLTFRaYwXzAhL+x4cNCxvQOgt7naYZY1t
        rZoYRYxTpfPqHGxFIuitKGb6HMzIae8UrfDB9Z9z
X-Google-Smtp-Source: AAOMgpc87MykDr8sGEnV2kFEasTeYKHEqYT/yY3PJsmeCoCkbzacRparNkzUfPtfbkn2UNqrSb6oAtI37lYjeh1XYdE=
X-Received: by 2002:a6b:1741:: with SMTP id 62-v6mr3724737iox.1.1533136908139;
 Wed, 01 Aug 2018 08:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180730194059.5781-1-tedheadster@gmail.com> <7c274466-6d93-d1ba-8721-4d69f847b40f@redhat.com>
 <CAP8WD_aP5-bh=+NrJV8a3BCMbQK_PyJD88PGRuU8Qh_exFBy9w@mail.gmail.com> <1d40dca9-c128-0390-98d2-5ca9c8791448@redhat.com>
In-Reply-To: <1d40dca9-c128-0390-98d2-5ca9c8791448@redhat.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 1 Aug 2018 11:21:36 -0400
Message-ID: <CAMzpN2jY7AC2Kmp7rr+cP2Xynx66fWnzEXs9_JhbNpsqix0_Vg@mail.gmail.com>
Subject: Re: [PATCH] x86: kvm: Restrict X86_FEATURE_VMMCALL to x86_64 platform
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     whiteheadm@acm.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 9:00 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 31/07/2018 14:57, tedheadster wrote:
> >>
> >> This shouldn't be necessary; for systems that don't have virtualization
> >> extensions, the comment explains why setting X86_FEATURE_VMMCALL is safe.
> >>
> >> But it is also wrong, because you can run a 32-bit kernel as a guest on
> >> a 64-bit processor, and then it should set X86_FEATURE_VMMCALL because
> >> the processor has the vmmcall instruction and not Intel's vmcall.
> >>
> >
> > Paolo,
> >   I'm running this on a bare metal machine (no virtualization) with a
> > 32-bit AMD i486 class cpu. Should the feature be showing up in
> > /proc/cpuinfo under the 'flags' line? It does on my machine, and it
> > looked wrong to me.
>
> It's a bit silly, but it's not particularly wrong.

Why is there even a specific feature flag for VMMCALL?  Isn't
X86_FEATURE_SVM sufficient to differentiate which opcode to use?

--
Brian Gerst
