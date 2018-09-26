Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA56C004D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8701721547
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQDJO+ke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8701721547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeI0Bsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:48:39 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:39496 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeI0Bsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:48:39 -0400
Received: by mail-lj1-f169.google.com with SMTP id 5-v6so120059lju.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZbejSOsf/HNSenUZx3ri4rExr0h6w1GsWVc3Mxx78Q4=;
        b=tQDJO+keoyX6UcUqiSuMUk/vs7qyt4PY/o3ZnpytXl/4MzsgVhD8nIVj7eQae9paHB
         2l+mJ8k6/kiaqmdI9FwMszbrwTwwOOQKxxyLzfI/+3TWynJkWH/Z64a5nyjdaa1SQ3ZG
         pOtG/SVSpbk82ofP9pKXvu0O2WYF14OKfA7mdRZavLC0qG2O1kftGBceVfrNpH6Y7ujy
         uEZ8DBWo/rdD8s08lXmxI0P10dfuNJVVQ2aybPUJ7+bs3ZKhgefTdqvq3klOcaAU0XqU
         StkxGgSbP6BWyynrsF/ijZWtmv2NF2hSngPHbY3+dpeU/AQVLLmQ2CkZ7fB9aZ/T5msh
         L/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZbejSOsf/HNSenUZx3ri4rExr0h6w1GsWVc3Mxx78Q4=;
        b=DAcdv9Kgj4kJuNolYhFP8TbFm+ghur4AztEglzrBB1lirmka2paS924isvQ5DMoOxt
         pCd3s0MhmM3ty7ETaS4Hm6TPbsNwrtmCxKW7LJLt9E96jDt9B5mR1kKz+5uQqGBhw9PB
         adiaUenHe/ySYG7I5KgXeMJEwDCSpdllwhYjMONAGICnkEToduk//ICYno6F4BMWzrwJ
         EnPeXXV74nYF0sYv1f0lsdD22n6faCKUY77McsU9Ac5InqGLiMxp9Cgd35fXlmY43kZv
         NS0y5Gn3FhPXVCPfhfrn4/fYuaWaO3Fl0WBKBaJWrAmIc4RzGLSo4OkT9aYGDtFUzBUe
         RmqQ==
X-Gm-Message-State: ABuFfoh55MCy8GcYKhblBdZKtQsb/IhxSiCGZF9tW9N7oLRF24Av+rnJ
        7LKFX4MIJMogoDKyRqTD1A1bnyMSC+66f6MUhVA=
X-Google-Smtp-Source: ACcGV61OvxksZdxpuf+pF4UQGLCW0UoSHwMOro3eYFucb+JJCqDy5RrdVoVSiR09th9nR5cNXe5AzZcYKa7aCnqNVAc=
X-Received: by 2002:a2e:44d0:: with SMTP id b77-v6mr3491965ljf.47.1537990448692;
 Wed, 26 Sep 2018 12:34:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:278e:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 12:34:07
 -0700 (PDT)
In-Reply-To: <9be16b08-7aa9-d42e-24c0-f054af39b78a@petrovitsch.priv.at>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net> <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com> <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org> <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
 <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
 <CAMjeLr-a4cCrs0cF0aBRoeeXXLwiM835BXqhP9ZoeLB8=w=YKw@mail.gmail.com>
 <8c18dcc5-9028-672f-1449-359ac3d73592@petrovitsch.priv.at>
 <CAMjeLr-j1XhZJgcvsP5z6SHCDmbUA=rMyfvQpX40qKBK+2ojbw@mail.gmail.com> <9be16b08-7aa9-d42e-24c0-f054af39b78a@petrovitsch.priv.at>
From:   "\\0xDynamite" <dreamingforward@gmail.com>
Date:   Wed, 26 Sep 2018 14:34:07 -0500
Message-ID: <CAMjeLr_cx5+96NGedcYB-MjugA53_j+tksP0Na8W9GY-PAhoZA@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc:     "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
        Theodore Tso <tytso@mit.edu>, fche@redhat.com,
        riel@surriel.com, ec429@cantab.net,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> So, is code a *published* item?  Most of the public can't read it.
>>>
>>> I cannot read (or understand) neither Russian nor Chinese nor almost any
>>> natural (let alone dead) languages of the world. I'm pretty sure that
>>> I'm not the only one;-)
>>> Does that make Russian literature non-public? I don't think so ...
>>
>> You confuse the issue.  My definition included "intended for the
>> public".  But it isn't clear that open source code is intended for the
>> public -- it is intended for those who code or wish to.

> Well, then I have to repeat myself: Signed-off source code (in form of
> patches) in a well-known programming language for a (nowadays)
> well-known GPLv2 licensed project mailed on "everyone can subscribe"
> mailinglists, (thus) to be found in several $SEARCH_ENGINE-indexed
> mailinglist archives, if accepted to be found in lots of publicly
> accessible git repos can be not intended to be published?

You did it again.  You changed words.  I said intended for the public,
and you ended your sentence with "intended to be published".

Like it or not, both the law and English grammar have ambiguities.
People put up with them because they share a common intuition (in a
lot of cases) of what each other means.

If you share a birthday card with your personal love note inscribed
and the birthday girl sends it around to everyone at the party, have
you been violated?  She might argue:  how did you expect it to remain
private if you knew there were several people invited to the birthday
party?

> I wonder what else must happen.

Wonder no more.

Mark
