Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1633BC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1CA21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpoYatti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfBSKqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:46:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34276 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfBSKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:46:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id l5so13587721lje.1;
        Tue, 19 Feb 2019 02:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ffG50zcYRZxWfUGn5WkhVM3jBYqv2vEwRvPWaUtideQ=;
        b=YpoYattijyPWHezIgZMKDwdjebSn69PKDuhJxtXkwpjt/p8HH2X1x+3YGadInP2Dx1
         rGlMK8oPorD/BJVjvzjPYOn/gp6hSvmVGAZ956FJHnKdzavF59LNoVdN9YDgc/JBqRM/
         DMoBFHlW/537VF0CeNabpK9+6W2AJ8K4ziSdeZh7zDDz34Oj9HlH7hYsMJzwv5j8UTKF
         /3gTZkXUKflREJJyEeTWV2M6GWGI/Tu8iuRyL3QeSNPeVcOHvR0lDn28auo4wrHXAkc4
         BFFliD+xepgc6tV+e4S7WKF07D5iNbCZwn3KyN38V83wZKBoOPwgJ6KE42M8l09V7GU2
         d6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ffG50zcYRZxWfUGn5WkhVM3jBYqv2vEwRvPWaUtideQ=;
        b=V9MnG7zJAQurpsG9aDtchMJizJxgPCwmlwjOd0I84BLRIUskuvKoUXQKXsK1Dcr3do
         r7goplhc9DuHezE/uX3/vyJUHXnJetLaiCJdTJHlEllWdYy4N4rix6dP9nyCx93YM+1C
         kEUdkG1Vye2nJxsxJPWIXxfWHEEEVdfr6Jebv8pvdMLNSJEj7FexUk5YyLatTRLmvBAL
         q6ejF8Q5kPqNPCcE4yKYJhCee7G/T93UOWlui2xVGC+RxOfNxnSpmdYdLEC18TV7Ma0K
         YV5peovPZA5mL+y1umBY3kOyOkM1i/KShxUEiBykqddaFz6hiHVcjP4kkFqOyFp6T7oa
         aYIQ==
X-Gm-Message-State: AHQUAubxEVqmRmbSuIztj+UVsYacutIWbTKZutfPff2fuIoqNt8uZiiQ
        gDHecMfBYE0wLaZCk4chnAzj8ifdOTtpDLP5HrlPK8HdyOA=
X-Google-Smtp-Source: AHgI3IZ+FYcQpqLOs3r6vs6rfw+yWXTt3gr7z2oiY8vq1ixrrl1/gx3aW8UGINQJJL3tc1uFpnVxZoP13f0D7A/hf1Y=
X-Received: by 2002:a2e:965a:: with SMTP id z26mr15089257ljh.59.1550573163554;
 Tue, 19 Feb 2019 02:46:03 -0800 (PST)
MIME-Version: 1.0
References: <1550278564-81540-1-git-send-email-yang.shi@linux.alibaba.com> <20190218210504.GT50184@devbig004.ftw2.facebook.com>
In-Reply-To: <20190218210504.GT50184@devbig004.ftw2.facebook.com>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Tue, 19 Feb 2019 18:45:52 +0800
Message-ID: <CAHCio2g-S6snHsh84r0Wp1RQW1CR3t_eyUUjcdDaxnUHWTcdFw@mail.gmail.com>
Subject: Re: [PATCH] doc: cgroup: correct the wrong information about measure
 of memory pressure
To:     Tejun Heo <tj@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi TeJun
I've built the 5.0.0-rc6 kernel with psi option, but I cannot find any
cgroup.controllers when I mounted cgroup2.

[root@bogon /]# uname -r
[root@bogon /]# 5.0.0-rc6+
[root@bogon /]# mount -t cgroup2 none cgroup2/
[root@bogon /]# cat cgroup2/cgroup.controllers
[root@bogon /]
[root@bogon /]# cat cgroup2/cgroup.subtree_control
[root@bogon /]#

What's wrong with this kernel? Or maybe I lost some mount option?

Thanks
Yuzhoujian

Tejun Heo <tj@kernel.org> =E4=BA=8E2019=E5=B9=B42=E6=9C=8819=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Feb 16, 2019 at 08:56:04AM +0800, Yang Shi wrote:
> > Since PSI has implemented some kind of measure of memory pressure, the
> > statement about lack of such measure is not true anymore.
> >
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 7bf3f12..9a92013 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1310,8 +1310,7 @@ network to a file can use all available memory bu=
t can also operate as
> >  performant with a small amount of memory.  A measure of memory
> >  pressure - how much the workload is being impacted due to lack of
> >  memory - is necessary to determine whether a workload needs more
> > -memory; unfortunately, memory pressure monitoring mechanism isn't
> > -implemented yet.
> > +memory.
>
> Maybe refer to PSI?
>
> Thanks.
>
> --
> tejun
