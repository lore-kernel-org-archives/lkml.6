Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20F3C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5FD214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgCDlAki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfA0PKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 10:10:32 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:46626 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfA0PKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 10:10:32 -0500
Received: by mail-lj1-f182.google.com with SMTP id v15-v6so12050212ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 07:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CZ48hnE1ZfHizbcvynnyo65szcUqt0ScFWmCyRc+Y7Y=;
        b=EgCDlAkidgpkLyhilUS3007t1Bamu0haFqAWKQl5L+xnHSjskHYKBuPACvykSe8/lt
         FrmZF0SSVlK3NYyIb3djrwq8DYU/nckgopsL/6wlGhqIFxtGsh0PER6BEU3WTfVRw00a
         o2aWW8C/DmHwLjZBqFAQVkF5noPuMPCCw1qRMS1LRygRyfPp3/waSl0SbiZrJgtzsKXD
         qUtfzD0JXZyB9fsSG94wn0UNhtnUeSTxKVLdiN+XXw06xnnrLFJtTDIzP3tbdVQYvfEL
         EHyVlxXzFZzvoHBFMTdM7LAklkqH8ifk/oOIjMl24Aj61G8t3wRdrbPpD7nDVtrHCs5u
         8mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=CZ48hnE1ZfHizbcvynnyo65szcUqt0ScFWmCyRc+Y7Y=;
        b=WmkcDRAGk6ClpbeUgSP0eaA0NAP8kxmvQlqBqXyxqZt08qHJ8PWIxWy37wm7N4pg3h
         ZjmVOlNgDPTzyfkraximiDFnpsJpe4AAILt5fV9a1wLEQWoimIK4FT8dAE9f71+JZS2z
         XGggHfzK31zQtqECxJEaPlcGG0y4EjaWR2IbgQcGPnc7rVMqDoSOWHWUAwMVljOrysn6
         PcK22CnVXpSfTXulNqFtE5hVNA/LohwhAgrHqc/DoPSyyrl/2UFHL3o6pwsPWsfTcgme
         NHhnjsLOWnd9KPEAWQIJ6gyzO4Df6Q9JR/Hof2EQfRaSxDqlEg7/PmbbY7LpYy8LtiUZ
         hU0w==
X-Gm-Message-State: AJcUukcUk6Su9UmvjVZCKZsKhtK2mqPJvWiqDxQm0+hMrfQ83ED1v3Xk
        FbgjvCFo/Hp5eBTDKINtixP+kD188qiwulzxLBtY8kec
X-Google-Smtp-Source: ALg8bN6IMwkf3V2KIZip7g72c8gxechafDH7dFX195fS42v+iU/LkrxF6W0ruvDkcdAOh/tsxiKxvCzauBox7SpUOSg=
X-Received: by 2002:a2e:3603:: with SMTP id d3-v6mr14467279lja.46.1548601829585;
 Sun, 27 Jan 2019 07:10:29 -0800 (PST)
MIME-Version: 1.0
References: <201901270823.14535.rhkramer@gmail.com> <31217686353807650412@scdbackup.webframe.org>
In-Reply-To: <31217686353807650412@scdbackup.webframe.org>
From:   Ivan Ivanov <qmastery16@gmail.com>
Date:   Sun, 27 Jan 2019 18:10:15 +0300
Message-ID: <CAAaskFC+f0+PC_io2yFLh_o81YU-=ZVFvvshkaFdrmcSbSbMCA@mail.gmail.com>
Subject: Re: Can a recipients rights under GNU GPL be revoked?
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes: The linux devs can rescind their license grant. GPLv2 is a bare
license and is revocable by the grantor. Search for "vsnsdualce" "gpl"
online to find his messages which prove that, he is a lawyer and has
investigated this subject very well. I am CC'ing him in case you'd
like to request more information. So if you didn't like the Code of
Conduct covertly accepted behind the scenes against your will, and
maybe some other questionable political decisions in technical
projects (e.g. the recent removal of useful "weboob" package which
have been a part of Debian for 8 years but got removed just because
some mad SJWs suddenly got offended at its' name) - well you know what
to do, and maybe vsnsdualce will be happy to help with your case free
of charge.

Best regards,
Ivan Ivanov

=D0=B2=D1=81, 27 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 17:55, Thomas Schm=
itt <scdbackup@gmx.net>:
>
> Hi,
>
> Ben Finney wrote:
> > > In other words: Any copyright holder can *say* they wish to
> > > retroactively revoke the GNU GPL to some party.
>
> Well, everybody is free to express wishes. But a granted license with no
> applicable revocation clause is irrevocable.
>
> The copyright holders alltogether are entitled to grant any license
> they can agree on (and that is not illegal or legally void).
> E.g. they can grant non-GPL licenses for their GPLed software.
>
> What they cannot do is to revoke granted GPL on published versions.
>
>
> rhkramer@gmail.com wrote:
> > I believe that the
> > original author of a package could do something like create further
> > modifications to the code and create a non-free version of the code.
>
> An example is the cdrecord-wodim fork. The copyright holders did not
> release newer versions of cdrecord under GPL. So some concerned Debian
> developers used an earlier GPLed version as base of their fork named
> wodim.
>
> > Assuming that is correct, people using (or basing modifications) on the
> > (presumably) older free version could continue to use and develop based=
 on
> > that, but would not have rights to that new non-free version.
>
> I agree and practical examples show that we are not alone.
>
> The copyright of the original authors remains, so that the forkers cannot
> change the old license until they replaced all copyrightable imaterial of
> the original authors.
>
>
> Have a nice day :)
>
> Thomas
>
