Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23547C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B607720861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Jy0yBUA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B607720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeINHz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 03:55:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45732 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeINHz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 03:55:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id u83-v6so6247952lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 19:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBnF/Iug2VprWavKp/yn7LsTqdpP4SbGPhMzwmaCiTU=;
        b=Jy0yBUA6aSyZBj3WzUqar32R9N1nCnSamzQXQyy7LPPs/dI2cm4nop3XrbC0crDMAN
         UzuZob1K1dkl+ZGGxH+Anlig5ON1U4gjD9RydgiG713yvumgeRKIP4A39z1z+gRq2iQ1
         SwkXiQridnLMGK8oZpg6UtWxIAv/vDy0ZURr9jf+nzdZ2ppLwYUJKG9sGf7a5YYQIZJq
         C1Hj7M1vt7SxZXx2/zAPEMwmYqLPDZaqr54PeJRtv6Pk0CSaSLqcASg8U3hdy9KQi+8l
         OVX+0klscmMIGaHGOscgrZd4tpvIITj2W2pXyD6+ZztorMPb1nqqhemk9f8XZX9ueini
         D/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBnF/Iug2VprWavKp/yn7LsTqdpP4SbGPhMzwmaCiTU=;
        b=EdwiPCVRQ2AP2AhZCgpJPlnkTzrcwmKeUoAlaObouMyiLI0t7GIxcaIQDNzOGXjSDa
         XmmMRwaTTKTXVQzncpC9+XWxyPvttPyY68zVjetloThe5l+OX5QymH3rt3hsOYgmfdu6
         1PLbWFsVtkag6ZxSTex5uOhwZD8LeBq/DbhZlxL3z3rIdu2HRyO1I4++FGUvK7S1Z4PB
         YgjsFpXHfxW1FU1upmoJQnDIB2vcJqeDze74HeYRJzBk3RYTBI7hx1m0CR5H96AQHj6M
         9TrYIAupds/GiJtmsOwCG+dSyzuMsARvP4/KxxK4oAu5l9c19ZULZNDZ6QdSe7/pcut+
         g0Rg==
X-Gm-Message-State: APzg51Aa5D7nICoVgpRLq5jVD/Ye/Bk/Yvi1vDiXUX0uZpJTFlh/s2r/
        2RnJ1Hxij3deV2OdcpymOqXvHWGBCiXBwqFrkLoI
X-Google-Smtp-Source: ANB0VdYeFYN9tkS6RJFW/0mYUwIJHyN40LM/8fiwEWWY422NFyr0SzJ5I1phc/OQov+p9kaP3i+IAlxXFj1itsP87GY=
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr6249259ljf.102.1536892991008;
 Thu, 13 Sep 2018 19:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com> <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
In-Reply-To: <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Sep 2018 22:42:59 -0400
Message-ID: <CAHC9VhRXOuGqSw9yu18QZeA1z+vYwLFixTqEJ1WyBBFCeLebuA@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     keescook@chromium.org
Cc:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, adobriyan@gmail.com,
        casey.schaufler@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 5:52 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 13, 2018 at 2:38 PM, Paul Moore <paul@paul-moore.com> wrote:
> > The infrastructure bits aren't really my concern; in fact I *like*
> > that the infrastructure is always exercised, it makes
> > testing/debugging easier.  I also like the ability to limit the
> > user/admin to one LSM at boot time to make support easier; my goal is
> > to allow a distro to build support for multiple LSMs without also
> > requiring that distro to support *stacked* LSMs
>
> I see your point, but as soon as SARA and Landlock appear, they'll have:
>
>     depends on SECURITY_STACKING
>
> and then all distros will enable it and there will be no sensible
> runtime way to manage it. If, instead, we make it entirely runtime
> now, then a CONFIG can control the default state and we can provide
> guidance to how SARA and Landlock should expose their "enable"ness.

I question why SARA and LandLock require stacking.  While some LSMs
may benefit from stacking, e.g. Yama, traditionally each LSM has been
able to stand on its own.  I think this is a quality that should be
preserved.

> > (see my earlier
> > comments about the difficulty in determining the source of a failed
> > operation).
>
> Agreed. I would hope that audit could help for that case. *stare at blue sky*

*also staring at blue sky*

Audit can help, but it is independent of the LSMs and not a hard
requirement for all, and even when it is enabled the config might not
be suitable to provide enough information to be helpful in this case.

-- 
paul moore
www.paul-moore.com
