Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE6DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DA320657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epnDOoDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfARBPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:15:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41584 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfARBPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:15:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so5228373pgq.8;
        Thu, 17 Jan 2019 17:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nfJ8xS7Q4/2eN93Hqyw2Vxt0we5DRJFkV8HYkEezqLo=;
        b=epnDOoDPCYmQOrRqrJQDp6hqSyVOqA0OACC2E+Ypn35v71FNxBed0ZH8UKd8f1psrB
         kJs41dfmRvph0F9K7JaapS1CHnzIy2vKVy9qkAUllNemr9yxSw8C6DunC3RMPtVKvwlR
         LOUcswMxytdeBueSBzD9P3zQeg6E9vFeE7IXhdHzF98pMEvyF812GWg0Ji2Qhgu86q3R
         apfvAxMV3yN41Y8OKaxw2fHOrIZBMQTkEg72xsNxSei7Pjwor+U9qnFFUH5nqhyesWHN
         kkoMYn3Ji7E8+iDqmxNIFglZ+aX99ecIENnM9cTC8a6aNiLvGg2zZ4Vr4QvgYhw+2hLX
         /yVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nfJ8xS7Q4/2eN93Hqyw2Vxt0we5DRJFkV8HYkEezqLo=;
        b=Kw+Gr65rTOFdDiaTLTXE8HHyaV/ntAtYKEFzuNG0qIAOgbq9RUFLWHfOXpQGyK+3h9
         9b0Z1W2CwdwIB3Q32m9ytLMm/r7upYnkqyX8NON6N0m9RCNdetWHueUv9ttXu17Eo33Z
         jVzOK5Nl2bzDHq8VvzlpmzexlvoxXnpIO6vD7puxFXUNNqpTPI1oviq3N9fC0lzHpnDO
         86urxWipYRXvtVSm877kE9NN0+WZuV0QTA03T280fFaLPSU+jGAIRFceyxRgHDzF4Vnt
         6Z3gAd8cMRRaT5gOZn3LoGJXd+ih47qyRP6Y1MTGYtV3iE3zoPhWH4VvOFB26stjpUph
         mkhw==
X-Gm-Message-State: AJcUukfQMnvtd5zS7KLn5mI3dI4j32L1SKzjFdBDwihM5w2Fx5dBPAcv
        5ycUUBYMCxUFkgtcHR7L5o4=
X-Google-Smtp-Source: ALg8bN5AQhFbL8A26bYpIKqbPXZPdnzW7UXtqw5Th4jK4eVuovdHK0vo/XXSzX+oHLDUBlskz3aYQA==
X-Received: by 2002:a63:1204:: with SMTP id h4mr15579607pgl.51.1547774130020;
        Thu, 17 Jan 2019 17:15:30 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id r6sm6866962pgk.91.2019.01.17.17.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 17:15:29 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 17/17] module: Prevent module removal racing with
 text_poke()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <e865e051-be79-adce-7275-72abf2173bdb@zytor.com>
Date:   Thu, 17 Jan 2019 17:15:27 -0800
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        ard.biesheuvel@linaro.org, kristen@linux.intel.com,
        deneen.t.dock@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <69EA2C81-826F-46BA-8D80-241C39B0B70B@gmail.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-18-rick.p.edgecombe@intel.com>
 <20190117165422.d33d1af83db8716e24960a3c@kernel.org>
 <e865e051-be79-adce-7275-72abf2173bdb@zytor.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 17, 2019, at 3:58 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>=20
> On 1/16/19 11:54 PM, Masami Hiramatsu wrote:
>> On Wed, 16 Jan 2019 16:32:59 -0800
>> Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:
>>=20
>>> From: Nadav Amit <namit@vmware.com>
>>>=20
>>> It seems dangerous to allow code modifications to take place
>>> concurrently with module unloading. So take the text_mutex while the
>>> memory of the module is freed.
>>=20
>> At that point, since the module itself is removed from module list,
>> it seems no actual harm. Or would you have any concern?
>=20
> The issue isn't the module list, but rather when it is safe to free =
the
> contents, so we don't clobber anything. We absolutely need to enforce
> that we can't text_poke() something that might have already been =
freed.
>=20
> That being said, we *also* really would prefer to enforce that we =
can't
> text_poke() memory that doesn't actually contain code; as far as I can
> tell we don't currently do that check.

Yes, that what the mutex was supposed to achieve. It=E2=80=99s not =
supposed just
to check whether it is a code page, but also that it is the same code
page that you wanted to patch.=20

> This, again, is a good use for a separate mm context. We can enforce
> that that context will only ever contain valid page mappings for =
actual
> code pages.

This will not tell you that you have the *right* code-page. The module
notifiers help to do so, since they synchronize the text poking with
the module removal.

> (Note: in my proposed algorithm, with a separate mm, replace INVLPG =
with
> switching CR3 if we have to do a rollback or roll forward in the
> breakpoint handler.)

I really need to read your patches more carefully to see what you mean.

Anyhow, so what do you prefer? I=E2=80=99m ok with either one:
	1. Keep this patch
	2. Remove this patch and change into a comment on text_poke()
	3. Just drop the patch

