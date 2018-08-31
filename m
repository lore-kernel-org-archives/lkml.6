Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C044DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F5C2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3fQGGjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F5C2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeHaXr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:47:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45582 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaXr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:47:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so12171215wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/QHssJhxS95xYF7OjkMqbnqwArkZoviXKJsG3Z2Eq7I=;
        b=N3fQGGjs6Y+8XK20ODg94/cmSAyRs+9QKjc+6lVYHcOw5bOuQlgsYiBHHqKNYNmMYp
         8MU9VJgffCGlfZ+z/Cg0GyFpDCVz0acmF+/YJA+UEtHMENORRxsNVnVis3LvBawdIXHF
         9I2Sdpf0S7YZm2WVHUU+qGs91kCTVjq/VLlz20q0Em4u+RL8K9N+7Tt1vKAiiUQCn+Kv
         i54a98voDxoyzMfqWHy189cbQw2OVyjBCigPgWTYTcYCAqTGAXRr6PXezdQimogeuXcr
         Gm4sEWCXGcOp9xsrVgJbIGXzba9m0HOAuuldBrHpGr/w/quRGNmTi/aIPMNXgj6YrwAH
         x4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/QHssJhxS95xYF7OjkMqbnqwArkZoviXKJsG3Z2Eq7I=;
        b=LAjziSQEJjwAMf4qaeaJ31xJAodvovafqNxQlSKW7PzQINY+dYmi1DR7TfkDjJGaiF
         LDVj3paCwEcDdYjJftNoOngFnmwrNP8moQhw5BlOdMp9OGh3C0ti/Vga5pZrt1gw7D2w
         Yqs7t/8zBKKUprs9KrTC/wwR4kJYNpB9/mP2ucLCae84qxK1nuu/7H9IHOLcxge5e/ec
         Y4H8zAGHVr5hnkUliPdCUObKPmglldRZXcSlxvUU2A7WdXLPQfcxyG65k+HPz8e+dA9W
         sHrc4hi4DLqW6nHsdYphpBydZtAxB9eO7kgR/VrgjvzvLC+1S1Xr26rCG3sftqW9vlbn
         OZyg==
X-Gm-Message-State: APzg51DmXhb10+Sm5+BSRQqCJ6E1XFxjB5NFu2JQe3yF6bhTYGHE29jk
        xUbtI3NpGUdGdyGss/p1hvM=
X-Google-Smtp-Source: ANB0Vdagbq7y/tBIAYZbDt1s2MdI2SufTGOG2Fhehe2H3+q6F6h1ZlFTFneW0ks9JJEKQUKx5DcDqw==
X-Received: by 2002:adf:9ae5:: with SMTP id a92-v6mr12553118wrc.125.1535744308767;
        Fri, 31 Aug 2018 12:38:28 -0700 (PDT)
Received: from korsan.localdomain ([78.167.231.57])
        by smtp.gmail.com with ESMTPSA id f17-v6sm8129651wrs.1.2018.08.31.12.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 12:38:28 -0700 (PDT)
Date:   Fri, 31 Aug 2018 22:38:23 +0300
From:   Numan =?UTF-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PROBLEM: Keyboard not responding after resuming from
 suspend/hibernate
Message-ID: <20180831223823.33404864@korsan.localdomain>
In-Reply-To: <20180831191611.GR24124@hirez.programming.kicks-ass.net>
References: <20180831215121.1b1f66bf@korsan.localdomain>
        <20180831191611.GR24124@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, 31 Aug 2018 21:16:11 +0200 tarihinde
Peter Zijlstra <peterz@infradead.org> yazd=C4=B1:

>On Fri, Aug 31, 2018 at 09:53:11PM +0300, Numan Demird=C3=B6=C4=9Fen wrote:
>> If I put laptop to suspend or hibernate by closing lid, power
>> manager or any other method and then I resume/wake up laptop,
>> keyboard is not responding. My laptop is a Sony Vaio VPCEH2F1E.=20
>>=20
>> Steps to produce bug:
>> 1. Boot
>> 2. Put laptop to sleep
>> 3. Resume
>> What I expect to happen: Keyboard responds to key press.
>> What happens: Keyboard does not respond but mouse and trackball are
>> working.
>>=20
>> git bisect point 9d659ae14b545c4296e812c70493bfdc999b5c1c as the
>> first bad commit.
>>=20
>> Bad commit link:
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=
=3D9d659ae14b545c4296e812c70493bfdc999b5c1c =20

Hi,

Thank you for looking into this problem!
>
>That doesn't make any kind of sense... if that commit had trouble
>(oddly there is one another report fingering this) all the mutex
>locking should be busted (and there is a _lot_ of that in the kernel).

So, should I re-run a git bisect in order to confirm whether that
commit is the culprit or not?

>I really wouldn't know where to begin debugging this. Suspend/resume
>isn't really something I know much of, all I can say it that it works
>on my laptop.
>
>Rafael, any idea where to start looking for this?
>
>>  Link to actual bug report:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D195471 =20
>
>No, _this_ is the actual report, that is a random website you put stuff
>on.

--=20
Numan Demird=C3=B6=C4=9Fen
