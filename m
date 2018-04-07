Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-582365-1523136112-2-1999469175638560955
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523136111; b=m5px0apzGC1HPJBEuSIOa2tI/wOe6bAaQZ1y1XDMsdIFpr+cSf
    npvk9sOC1UJuue72QPd9cv2Rt4EcPQ08KhHhv07s41ls8/DCvstJAOGZIyIRANKw
    MOO2hyYq+/ZKmrkUsXF/vrSUJWQvGJAb/wGkaFJx0rXsAbtbkCarq3WbCStGKwb+
    968vtakZ9y6qUNv5J9EIR8XWAMZXsjIKAJTs/YC1hwMOhvwxyj9SKl5gtOj+szsq
    ZwPAgjeiyBRr3Na+au9lG/5VIxND21z+q2h2StbVC576G4SBnLdbmyZaYyNYtzA+
    2QjSuxGZR4Iuc/GYUXm4e5a7j/++hjqJKakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523136111; bh=KD0ruwfmdzn
    RdICUursgfNL2AzgaPOIqBLTGRD2hwf8=; b=wYOGhI78i6pLJ3L0Bev/X2L3SsU
    mYcIRUe0OqyQmCbtnmp44utsvWTkzx+kMoWVsLby59fpEOiLk/TkezDgIPKGB1Ci
    9grj/Uj1wslyLScZ2BWX+DR1iQX0e1/M1vIvMsyMN84N6EfO9Rsq5AzayWK+YJnd
    4xD/yJzBCdWd1YkA+qb2kIYnM/rbYNyOu2kKk7IcKfX+X8rq6/OLZJ9h5McEuBXH
    mYaMfYy9GeFMI1Rb3iWTC79UqoidBxq6287+ZrqcTbE+/lM20FWjYtPclx5piXGf
    BAfpHm/maaBs7tmivjGlXRXsDOcCeKUTwm5wg4gR4BtA+x/18gSR4wZBl8A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Xbd68Pxp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W2zVbz3H;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Xbd68Pxp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W2zVbz3H;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJlDLerf21LRyHFkKSdQdilpJrpn7uVYVYwSmqbJ5eO5725Tt18VQnd1O6GeIFAHkohu2tZxSfccX0jzITBr2sx+jGg9v887/KGdoQXNTpeY08UtLwyv
    Tn9t5oJHEewnHpvvjBMGAOZhwr6VEF87y5652AYc11HUdAmgX1FUnhOxtAPUlkUSs1EX2lms0/PqONXAH+reOMYbh1r09v4QN34VsIgmK6xo2HW6GSRAw3Ir
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=wslChEY2J8gA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=fLTa5ub6N_VHodZhm84A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeDGVVs (ORCPT <rfc822;greg@kroah.com>);
        Sat, 7 Apr 2018 17:21:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51180 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbeDGVVr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Apr 2018 17:21:47 -0400
X-Google-Smtp-Source: AIpwx482MtPGQO5l/tGWSBDQLkZGosjsnNmf8A1tw4lGUPkMES01MnngLb68fY8DbcnnBYsBY3a/IQ==
Date: Sat, 7 Apr 2018 16:21:44 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.16 00/31] 4.16.1-stable review
Message-ID: <20180407212144.wyfgjesmildfvxqo@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
References: <20180406084340.999820380@linuxfoundation.org>
 <CA+G9fYsbMhN_h8d7QGpEXwG9RZRg0otP9DZHfO8CtQo2tv4Vag@mail.gmail.com>
 <20180407122815.GA2399@kroah.com>
 <CA+G9fYvim=o4cc0PtM1UMKznThkX0C7RqVr370GiK8J7Bb9ceg@mail.gmail.com>
 <20180407175427.GA23053@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180407175427.GA23053@kroah.com>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 07, 2018 at 07:54:27PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 07, 2018 at 10:37:33PM +0530, Naresh Kamboju wrote:
> > >> Results from Linaro’s test farm.
> > >> No regressions on arm64, arm and x86_64.
> > >>
> > >> Summary
> > >> ------------------------------------------------------------------------
> > >>
> > >> kernel: 4.16.1-rc1
> > >> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > >> git branch: linux-4.16.y
> > >> git commit: 30380aa579224caf6a737160802151f466fe3953
> > >> git describe: v4.16-32-g30380aa57922
> > >> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/build/v4.16-32-g30380aa57922
> > >>
> > >> No regressions (compared to build )
> > >
> > > Compared to what build?  :)
> > 
> > There is no previous build to compare.
> > stable-rc 4.16 is the new build in our system.
> > This build results will act as base line for coming up 4.16 builds.
> 
> Why were you all not testing 4.16-rc releases and the final 4.16.0
> release?  For some reason I thought you all were doing that.

Hi Greg -

We track each branch separately and since linux-4.16.y is new, this was
the first build. But, we tested 4.16 release on our mainline tracking
branch (along with all the RCs and such before release). We have been
testing all along, it just doesn't show up here because this is a new
git branch and new qa-reports 'project'.

In any case, we review all test failures to identify any issues, on all
LTS branches, stable, mainline, and next. So, regardless of whether or
not qa-reports identifies something as a 'regression', we'll notice it.

Hope that helps,
Dan
