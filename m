Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1212C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886E620896
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2fDpQo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbfACHjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:39:00 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:38836 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfACHi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 02:38:59 -0500
Received: by mail-oi1-f171.google.com with SMTP id a77so27034837oii.5;
        Wed, 02 Jan 2019 23:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7lh/cFAa2ByrsjVrl6PN/Vh/mb45ecVTmVFRCuC3WiE=;
        b=s2fDpQo3kSbm3U+HaUeQgko70CWG4s9aAHC7w/HCF/qHUHEReur3ngZwhO3vuj7fGi
         aj70IAX2F3UcFWRIFsq2LTkG8gkjtg7HjGFeaNp1lbopccA56Bn1cDOLNmETuH5l2KZW
         xjJBkTHPw9HNvdFhhaDk+gyQZYAttI0LusX4qlt2jgFLpqX3CAM+PDzfKKNHOxZ+uZdC
         fkBAIN+tQ+VbT0ddSqkARW3o1PrHq91Gk2n4r2MQnvCaxoGKVT1K36N0Ic9Ik0hGpqTQ
         BD9VazmugrKrRa+TQwZQ7TPPkRAQNpIxVo7aRXr0f7onw0NRRDHFD90Dot6XnNWdL9KZ
         XCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7lh/cFAa2ByrsjVrl6PN/Vh/mb45ecVTmVFRCuC3WiE=;
        b=Vh3TFxj1GtUB3oUGFbef1mRp0lVQKVQOrZbAQQXFUYj3r1OKKCGJuFKIHWCYyUXuaO
         G5z0o6MKKyB6rwe9vneUDJnxV8MZRlK3Q7Lx+NgKJxRphdJjR8Wr8FhJFYsFkPSlXZcx
         rQOhGnasFr7amFk3Dipw0loG6tPLQ/bCKMVat2BWAWCmuzDulysS6xPTQ/eEUIGLe1eS
         j14Yehhg39KRDV8liZVJGkSzf5UAB9nuh/dKzV1UhG6LncScmWyIysFeP1DYNInsJJjb
         /CPoPXLdbWu7byRxfMZuY+M5YkEF9akA7rwl1U5Dhd/8hSVGU/0RJqVOB92Ih2k8+l1U
         Zcmg==
X-Gm-Message-State: AJcUukcH6JOq+hMWb7Fg8rFS9eIM+avgm9woaYtafqZKyC7PSLbNN0OP
        NemCxG6rPxtfLql5G7FP2rGVOkGtSUwZ8SeStmBb50CA
X-Google-Smtp-Source: AFSGD/Wt39WIvjnt85JI6jHcpHe+fHnq+iRaDp1H7w+K0KFTdq1C3O3H145IMmYyD+FDJM4KFosDS7h7mo9Ho/8S3hc=
X-Received: by 2002:aca:ec55:: with SMTP id k82mr29703015oih.55.1546501138763;
 Wed, 02 Jan 2019 23:38:58 -0800 (PST)
MIME-Version: 1.0
References: <398a74fa-6566-8d0d-6434-e68ff3763656@kernel.dk> <af940531-2535-2777-8c09-e9d1e6c16e82@suse.com>
In-Reply-To: <af940531-2535-2777-8c09-e9d1e6c16e82@suse.com>
From:   Jinpu Wang <jinpuwang@gmail.com>
Date:   Thu, 3 Jan 2019 08:38:46 +0100
Message-ID: <CAD9gYJ+725cU_n1EMzQ7hyaf_HrKJajL2oiJp8RZmwQ1Lhmt5g@mail.gmail.com>
Subject: Re: Shaohua Li
To:     Guoqing Jiang <gqjiang@suse.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guoqing Jiang <gqjiang@suse.com> =E4=BA=8E2019=E5=B9=B41=E6=9C=883=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:16=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 1/3/19 1:13 AM, Jens Axboe wrote:
> > Hi,
> >
> > I've got some very sad news to share with you - over Christmas, Shaohua
> > Li passed away after battling cancer for most of last year.
>
> It is really a sad news and a big lost for the community consider Shaohua=
's
> great contribution!

It's really a sad news, Shaohua is one of the best Chinese Linux Hackers.
>
> > As you know, Shaohua acted as the maintainer for md. He remained
> > dedicated to that through the difficult times. With his passing, we
> > obviously have a void that needs to be filled.
>
> It is better if there is a small team to maintain md in future since nobo=
dy
> have broad/deep knowledge as Neil or Shaohua, also people in the team
> can cover/backup each other, see [1].

Agree!
>
> > For now, I'll act as interim maintainer for md until we can find a good
> > permanent solution. I'll queue up reviewed patches in a separate branch=
,
> > in the block tree, and help review fixes. I'm subscribed to linux-raid,
> > but please do CC me as well.
>
> Thanks, I think there are some patches in shli/md/for-next which supposed
> to be merge to 4.21, could you please help to merge them to your branch?
> And I suppose you will send a patch to CREDITS for Shaohua.
+1
>
> [1]. https://lkml.org/lkml/2015/12/21/9
>
> Regards,
> Guoqing
Regards,
Jack Wang
