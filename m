Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F72C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3442084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="o7Rn7CgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfATFDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 00:03:55 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:34778 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfATFDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 00:03:54 -0500
Received: by mail-pf1-f175.google.com with SMTP id h3so8598363pfg.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 21:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zc70GkTYoCB6FM0EHkmD0aG16ESc2gl8eV2Wkz2pga4=;
        b=o7Rn7CgCT4bBol44KtIlEvH+gT3c/V7JWbj29lklvDxtJOvAycHwuGPVIGlzVxCcoK
         RxNQ/I0H2HO5nH6krrOsw6h+z1kbydjlnv24xW0QbpHqnHtp+I8BsehJdFa1dNDZo61d
         qDLhIudRLu9jDk+Zg5VYIRVDC9XRrsCra8WZzpQmb+O95dcCrrxBGv1zvQh5lbc4eIpS
         zx6FsnTu7R/X9vmqrsfs069/lzoltLxo2XKuUYu80nhbdFBJm4tGwuoAZMi9qwhUiDb4
         6TXmDT3cLtvYHCbFF4A0DDeIgWMgvpctaDy5nrodO3V4RzurNkuZFD9hN8Rval/DNzcV
         2akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zc70GkTYoCB6FM0EHkmD0aG16ESc2gl8eV2Wkz2pga4=;
        b=gkY6u3DsiH63djraGy8Ltswy328vt8klelusFkAUGqHnWccaDer1+q9EEmXxEv2mrb
         xF2Me1VkxC7kG3KHDlRsJdvxP51YDUHasJIgeBgUpRupTKG1bJ7F34U4VohnsUyfKYdk
         IBodaoqPUTXwIu7S2Sui3cwRmGD61rBiBkBCSJs8Os1qh9wlEKUZMhFoIn5v8s1sLIdy
         1hd2Otk4uBeZh8uYJUhpLVwLxQxTJYkr1524nR2L1oWdqcU0Iq/xs6PSLcBeMKMzD6r/
         Fev73HlGM3RLTmu0i3hmIgykXj/mPy6yh1UYEVBlVoooj88tlAQxLf+fdSJ7SS5H/7z/
         ArRg==
X-Gm-Message-State: AJcUukfdyb1+Or2XNl2zrlasW8qui3Rrm/3EnRz3Fpn6dePJD+S6WuOd
        buZ01+t9s0dfJCtBEIKx6xJfpMjQI6xbCAXGS1oroPzRfjI=
X-Google-Smtp-Source: ALg8bN6AmF4sq7R+HGokB1yPC0Wq6CphaAf86gYjqQ+cEayUmLboHUocCE8qi2gS0R/Y4PfUicYb8N5fEbMZoDW8Qsc=
X-Received: by 2002:a63:504d:: with SMTP id q13mr23893467pgl.319.1547960633805;
 Sat, 19 Jan 2019 21:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20190119151450.26879-1-Florian.LaRoche@googlemail.com>
 <20190120000138.GI26876@brain-police> <CAHk-=wjKgJ-9ypvzq+CB_NKnRk6iAqFtgVPwSH17C5RqJoYF=A@mail.gmail.com>
In-Reply-To: <CAHk-=wjKgJ-9ypvzq+CB_NKnRk6iAqFtgVPwSH17C5RqJoYF=A@mail.gmail.com>
From:   Florian La Roche <florian.laroche@googlemail.com>
Date:   Sun, 20 Jan 2019 06:03:17 +0100
Message-ID: <CANZrA2YLtnv+PRBYzcLdFUg4uktx82G8dkoZCic8-ANK-3-7fA@mail.gmail.com>
Subject: Re: fix int_sqrt() for very large numbers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

my comment said ffs(), but the code only uses fls() and that's what I meant.


Am So., 20. Jan. 2019 um 04:49 Uhr schrieb Linus Torvalds
<torvalds@linux-foundation.org>:
> But yes, our current int_sqrt64() does seem buggy as-is, because it's
> *supposed* to work on u64's, even if I don't think we really have any
> users that care.

Right. No real bug, just not 100% correct code.

> And as Will mentioned, the regular int_sqrt() looks perfectly fine,
> and subtracting 1 from the __fls() return value would actually
> _introduce_ a bug.

I think no bug introduced as the code handling 0 and 1 is already done.

For __fls() and fls64() I am actually using the folloing code:
/*
 * fls - find last (most-significant) bit set
 * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
 */
static __always_inline unsigned int flsl(unsigned long x)
{
    return x ? sizeof(x) * 8 - __builtin_clzl(x) : 0;
}

Please note the "_builtin_clzl()" instead of the "_builtin_clz()".

The real bug is that we compute 1 to 64 for bit 0 to bit 63, whereas
the algorithm
expects 0 to 63 for the value of m.

best regards,

Florian La Roche
