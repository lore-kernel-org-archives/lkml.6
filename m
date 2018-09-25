Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287D8C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC68C2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wca55Dhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC68C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeIYXX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:23:26 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:35052 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeIYXX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:23:26 -0400
Received: by mail-lf1-f46.google.com with SMTP id r191-v6so8191010lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nX8vK+4i7Z82c28RP+tXXz9pNe4uV8599K9lZ9crGH0=;
        b=Wca55DhnKjTpBGujvjjQsM9jqSDszec4AFtMlb4DuU6wdt7JqmkwFITLpwtZwQEZ9W
         oZ1gfDEpFOA61zHLGU9YUf+eftIWxkLvw/PwhbDDZVDKCAmKzSl7aKbZmNjn4VA2DvYw
         feQ2fJwoDIePqK5iQXHlxuqE6WDAETNSj6rSHAX1oJETEY5TZXnDlqbAZD9VSlr3s9OG
         K6ng//tP4gznI0lvMbLVosx7x/InbNjI90Qjj5YK2duXzbDgyk1ZlW4xdsB780S3S7UR
         mWxZGVoqdjPErNXBa8ftb5WKr+WGXS7BzpaR/Cj/KaYrjFDqF7OyNsbEp1Nju2lrOaIc
         bJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nX8vK+4i7Z82c28RP+tXXz9pNe4uV8599K9lZ9crGH0=;
        b=BQ/acaMGZFqijo5Q5RvlDaEm0K09hj8xa/PE1GJJffm/VuYNQmAb5kWB1RFMzz8TXx
         aFy9W4ZhicrbCOjGO5+RhjxU9rI15kGpNQsskEgNrMt/l3eINPeV4oGim9E8EY7tz0aJ
         w+zi9MB5xfNlBy5nCZIQPwNHzM4WD7uXIkw/mJkJI2QBK+/r8xUumJb1Fc7DkP/NkA6v
         rpiuMdLFxve5PQenssizvndB0d90gWVR0w974afYgkUGJ7GEmeS2t/C4cVbcDcIQ8M9Y
         GeEtMUciVDFZOu4Kb7rvZwiS3RjZYdq70w+uguaBMLtK6twHXKig9IBLjSXM/LiKmbqI
         5OSQ==
X-Gm-Message-State: ABuFfoiJDh2nku6oqOVn5dTB9xBLEAVywBVUNLEeBfcZB8RQEbwZ2UYj
        E2JRisuvpgmxTueBnFzyk/MOR8ny+MP8rlBM890=
X-Google-Smtp-Source: ACcGV61Ldbe3ye2oFq6ZsywCiBRiKtqbmGUac8gmErw0+7xUOzxLqkClGZXEx85fNH1YnGmXNthULx5++I/oHQe6DM0=
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr1498967lfo.124.1537895697334;
 Tue, 25 Sep 2018 10:14:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:278e:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 10:14:56
 -0700 (PDT)
In-Reply-To: <8c18dcc5-9028-672f-1449-359ac3d73592@petrovitsch.priv.at>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net> <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com> <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org> <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
 <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
 <CAMjeLr-a4cCrs0cF0aBRoeeXXLwiM835BXqhP9ZoeLB8=w=YKw@mail.gmail.com> <8c18dcc5-9028-672f-1449-359ac3d73592@petrovitsch.priv.at>
From:   "\\0xDynamite" <dreamingforward@gmail.com>
Date:   Tue, 25 Sep 2018 12:14:56 -0500
Message-ID: <CAMjeLr-j1XhZJgcvsP5z6SHCDmbUA=rMyfvQpX40qKBK+2ojbw@mail.gmail.com>
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

>> The notion of being "published" means at least these two things:  1)
>
> Where exactly - URL? - is that notion defined?

I'm giving you the most sensible definition, from the point of view of
a Doctor of Law.  I have not seen a real definition, so I'm giving you
one.

> Especially the intention is IMHO not necessary - just the fact if it
> happened (and I don't think we want to discuss legal stuff about "X
> broke into my home, stole and published my work" - the patent world has
> the same problem).

No, you must have the intention.  If you have a copy of your new book
on your computer, but someone steals it and prints it -- it is not a
"published" work.

And there is no URL.  You can take my word for it, along with my
credentials, or you can ignore it.

>> So, is code a *published* item?  Most of the public can't read it.
>
> I cannot read (or understand) neither Russian nor Chinese nor almost any
> natural (let alone dead) languages of the world. I'm pretty sure that
> I'm not the only one;-)
> Does that make Russian literature non-public? I don't think so ...

You confuse the issue.  My definition included "intended for the
public".  But it isn't clear that open source code is intended for the
public -- it is intended for those who code or wish to.

Past your inflammatory remarks, I withdraw any further commentary.

Mark Janssen, JD
