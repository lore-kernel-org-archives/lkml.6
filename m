Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65048C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3159620862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKZDtJ6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3159620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbeKHDK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:10:59 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40747 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbeKHDK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:10:59 -0500
Received: by mail-oi1-f195.google.com with SMTP id u130-v6so14519616oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rZiFRx9VrRsRXac2sOm4lzh12bTAfzn9VB1zquKY3fA=;
        b=MKZDtJ6EMv3vOo/rEQsIPjw3sVU4PlMGJJjgmXFdinJ2v5kojsfqvVxTOJ8Iz2McBq
         8EgYm1R/EjLL5KIYI9+eszcI27nFi+CO7oGGniql0fqvWkVAg8G/rlTuI2GVP9gKlcJN
         +m7jK95GD+yD8fQxh0DbbchGnhzSmKH+cLI7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rZiFRx9VrRsRXac2sOm4lzh12bTAfzn9VB1zquKY3fA=;
        b=HCCkn+iI4vhGk99bVHVUF8NaDG/glH3LgB9NqSekKmlDS2uSVYnErvwzlU9kJ+6Yv0
         MFtSu1/ayBJpFwrHPFULfP81NEeZxo6+LkOABth6OWZ+wYkaQ62DD1U5nP29m4uE6zxK
         ZRBx5lPlwdYPRLykFEZGzohuQwZmBj5iqGCPmOMdpmIhq1a4pNWJY0JRXdnejaAIV3A5
         LgOUUcAYaINOijBJ9GZ8xnW34C4nG8niqmrx97rmqpYSDeQuZxh/d4UOEGmrFsdh5cyB
         IftyhCvvGbDMHhoUWdM/Gqf9v7QrGlzUPr3MnjgEmIbw7zhYa0+Qbx/AALvHfZcQiMzI
         LROQ==
X-Gm-Message-State: AGRZ1gIbDdHu++lw0DvB5VwYYGfrepsiBM987GKfPQg0/ePVZrwFaUgW
        EchnScW+/8cBvjuQxboDbODmQytFZTP77Z15FV5Jaw==
X-Google-Smtp-Source: AJdET5f8fNwLAE04sRh0xhjZKmvvzPPW0CYmd7V7zAC7y6dpH4gfjzw68LNH32du75sdRapfsoBLKQja+SRGHrzPby4=
X-Received: by 2002:aca:b68b:: with SMTP id g133-v6mr668680oif.25.1541612374957;
 Wed, 07 Nov 2018 09:39:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:4b0e:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 09:39:14 -0800 (PST)
In-Reply-To: <20181107171031.22573-1-alex.bennee@linaro.org>
References: <20181107171031.22573-1-alex.bennee@linaro.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Wed, 7 Nov 2018 17:39:14 +0000
Message-ID: <CAFEAcA8LL0uC6o1V3W2T=2P47xZ0zGhMR5mEE+x=8qwmDKZL_g@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     kvm-devel <kvm@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 November 2018 at 17:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Not all faults handled by handle_exit are instruction emulations. For
> example a ESR_ELx_EC_IABT will result in the page tables being updated
> but the instruction that triggered the fault hasn't actually executed
> yet. We use the simple heuristic of checking for a changed PC before
> seeing if kvm_arm_handle_step_debug wants to claim we stepped an
> instruction.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

What's the rationale for this change? Presumably it's fixing
something, but the commit message doesn't really say what...

This feels to me like it's working around the fact that
we've separated two things ("advance pc (or set it if we're
going to make the guest take an exception)" and "notice that
we have completed a single step") that should be handled
at one point in the code.

thanks
-- PMM
