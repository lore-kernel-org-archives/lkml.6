Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5D5C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E682174E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MlykcVAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E682174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeHUB7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:59:02 -0400
Received: from mail-yw1-f53.google.com ([209.85.161.53]:33118 "EHLO
        mail-yw1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeHUB7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:59:02 -0400
Received: by mail-yw1-f53.google.com with SMTP id x67-v6so2377698ywg.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8mTI1+a5+TRH2Lwrujn00YE6MhN8HUV1/tJyCBu9yA=;
        b=MlykcVASvSGOYgQ7ZfQ6ijx99M1upT1bPpbOtNa8UQJ2JC+0fbhzPp8c6XwU/KaSI0
         dfPk4+Xp/sG0XrSMtffS44UOJtopICv3Q4lg1eEOVCydET0GukxbNO8BOBAmoMjr+T9Y
         nRWkRcIhB/2Ctui/0p13fxwt8tW48QhCZP+W6rStj7VtJ3psabi7Aheg7TbJ90KypekK
         72zyQnimPK0UWsEObVpevvT7VYRMhT6BaJalMttqpHSxekWorpxXfwfLEC2XhNaQen1A
         2j1vzArod+r+RC3FwRPUwlX2JpNOnv88r4+sq5ukBmyVMOTZEa+YhdWYdE40QvIjGfkI
         +2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8mTI1+a5+TRH2Lwrujn00YE6MhN8HUV1/tJyCBu9yA=;
        b=tJVamFrn7rMWdXLQ+mTesqSb35vy99PmSwQIeDpUF46r0zZNsXvEL6uu0yCffuMmc8
         x/FpgPWHq7Bf1qfKmH+BvGSOldFMT4aEU77OIcvqRJ6VXT5DMlg4FTsBYA5ZSaADTAy3
         QhIacYmHt3dPZgBOrbm3vr/EqhVMIufmaji9PUUbJCw/OCg3LqtiiChvst+RpLUZk0Bv
         j4dfKyy8HEGgeWrFN3R97BxJbc5wXC2LRUi9eYVs+P7L9DlzNaSeovWNZoelPQl3EGtn
         hpPUSCFXNtbifNKPAqiLbltI/SaRuVq7TuNc49wXQMbJSPoUk1JmlWiJLh3rlpGA0xy8
         jSEg==
X-Gm-Message-State: AOUpUlH2VynlClPfclb1K8XZToDdFS4CuAWLMLQGkAAf82UOKQAUss3C
        fTvc+vQxDCYFcWe4RSKYwtNXelCAsexDVg6RljwiLUTdwvM=
X-Google-Smtp-Source: AA+uWPysgqxw3NKt5xTCv3YKUFTLH/Rq8AxyFbvSODgKjeqW+2ih1WvEOG75XmScZjMglRW2Ww4AnTyO06Bpfrc90b8=
X-Received: by 2002:a81:6a45:: with SMTP id f66-v6mr7909387ywc.300.1534804892721;
 Mon, 20 Aug 2018 15:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 15:41:21 -0700
Message-ID: <CAGZ79kbrv62ttBYt7nwO7E4S7wTVWZGceqE6hPjAbhPPWfRkEQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  * The conversion to pass "the_repository" and then "a_repository"
>    throughout the object access API continues.
>
[...]
>
>  * The conversion to pass "the_repository" and then "a_repository"
>    throughout the object access API continues.

I guess it continues twice as two large series were merged? ;-)
sb/object-store-grafts
sb/object-store-lookup

The latter one is not the correct one, as later we'll have

  * lookup_commit_reference() and friends have been updated to find
    in-core object for a specific in-core repository instance.

>  * "git submodule" did not correctly adjust core.worktree setting that
>    indicates whether/where a submodule repository has its associated
>    working tree across various state transitions, which has been
>    corrected.
>    (merge 984cd77ddb sb/submodule-core-worktree later to maint).

Personally I do not view this as a bug fix but a feature
(but then again my thinking might be tainted of too much
submodule work) hence I would not merge it down.

Stefan
