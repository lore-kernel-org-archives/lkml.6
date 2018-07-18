Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBD2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10FC20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8Nh6sVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10FC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeGRTKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:10:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50441 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeGRTKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:10:13 -0400
Received: by mail-it0-f66.google.com with SMTP id w16-v6so5549277ita.0;
        Wed, 18 Jul 2018 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dffiendSCHpPFCwy7TQmY5V19xC/lcSt5xxJgIwh2/0=;
        b=Q8Nh6sVFP4NQvF3VQAK3LSVA4KDrqLk01AEwtwMT6Cn9KnLFNyHSJrgLxEQmJeU1R8
         ZU9JtcEMfG5p6dGVjInc2JS6I3lq8M83zElVh4LEigH83YhHuKSMRrhYVK7/pik9j9Zq
         FxBmav9HZLslSl815cBnvL9JmVQOJuT5qmBbILTDVlMWo15+ld2RM62AIhDp9wuocVqr
         IcuNm72pgMtR/lZMn/rGBk/h0IxQv9EDkGJEW0sW4+PCFN062S3FBgBH3yvrXSgUSvGV
         pJ4f772UQdixzRXD4QJYK9BxWAcjoyMxcO/lpPuVUr1BPrImpoDq5pdpCh/WIaSoERjD
         OD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dffiendSCHpPFCwy7TQmY5V19xC/lcSt5xxJgIwh2/0=;
        b=pyO0GpiSnVy6LvvRCCICcnapu5llTEuZcqKAyJVggxEecJct4vddExTYK8MQ7/ER73
         zlv4Qs3yu5/JqX+SfRkz2Dk/uNyBupbJ6BMRA9e7AUY6VqgMOELLn2/7yCBMXm6+XkCW
         RaTTTct7wgd7RyEDaQTXNrpRDVJeMIVza2+G1WnAai0ohqjrl61IqA4NCkW91m6PhjkU
         Ec1Vr9yAn88bQv+KGkJHWKvaIJIClhEPEpN3iDahKktTA6c6RORvyeeFjoGx0JaHrXqf
         5a+ntlfDPWGUXdC6nbL21I7nqTVsfDHBdMjdffNzrriBDf2niS90AiKkzAJ7Kr9fw8GS
         c+8A==
X-Gm-Message-State: AOUpUlEiFlqI5jgiJx6T87y6lV9WStST/gDljfvSY/IdVsbIBtScIuyy
        zCBbcGZLu817iHoZhvPh85LbY2NJ6qNzdTkJL7W7aq1T
X-Google-Smtp-Source: AAOMgpetPwh1SkaJLqxU2P3XKOEW/8EAwlAOrKBV75gCw7YvZmkFskjUZTOQ34QKMjrVkA9LURHFt6gPfMxlcJn8JDs=
X-Received: by 2002:a02:97a1:: with SMTP id s30-v6mr6235400jaj.89.1531938663955;
 Wed, 18 Jul 2018 11:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180717145525.50852-1-colyli@suse.de> <20180717145525.50852-4-colyli@suse.de>
 <CADfjVriarrPnxixjun1g0m7izp4kMCvP4vXuPtNTth7_LWXrMA@mail.gmail.com> <CAHp75Ve7w8HxAcRXozsctFETuBtA0VD6jAsExEb6Wtq4UYRNAg@mail.gmail.com>
In-Reply-To: <CAHp75Ve7w8HxAcRXozsctFETuBtA0VD6jAsExEb6Wtq4UYRNAg@mail.gmail.com>
From:   Noah Massey <noah.massey@gmail.com>
Date:   Wed, 18 Jul 2018 14:30:27 -0400
Message-ID: <CADfjVrg_oe1d5+3Hr3dv5fVpcA9jYP44B24LJS2_OsUFpnyB5g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] lib/test_crc: Add test cases for crc calculation
To:     andy.shevchenko@gmail.com
Cc:     Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, kstewart@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:59 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 17, 2018 at 9:51 PM, Noah Massey <noah.massey@gmail.com> wrote:
> > On Tue, Jul 17, 2018 at 10:56 AM Coly Li <colyli@suse.de> wrote:
>
> >> +       if (err == 0)
> >> +               pr_info("test_crc: all %d tests passed\n", i);
> >
> > Similar to previous comment: we should not report the number of passed
> > tests, since adding a test would invalidate previous golden output.
> > Also, consider the situation where some tests are conditionally
> > executed depending on kconfig.
>
> We do similar in many test modules and I know at least two that had
> been changed in order to get new test cases.
> Are you proposing to change 'em all?
>

I was proposing that the message should be "test_crc: all tests
passed\n", since that would maintain a static expected output. Upon
further review, parsing minor variations in the messages is simple
enough so if the automated test tools already handle it keeping the
test count in the output is better.

Sorry for the noise,

~ Noah
