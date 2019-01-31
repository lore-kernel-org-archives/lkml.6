Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6C7C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5C62184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ce9iCm8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfAaBqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:46:09 -0500
Received: from sonic303-10.consmr.mail.bf2.yahoo.com ([74.6.131.49]:44779 "EHLO
        sonic303-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728419AbfAaBqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1548899167; bh=l+w/UPXcdfeCWFbiNt+8SxOczIzc4rbSsfi8qrTcsYI=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=ce9iCm8lS/paxorREsImaSoVNDIZ7CLii+ZKfKkzMgGkTRKBkUD5fSNdYjpWyGaSP5ai6dv3CLIFC5p2LkLs4uX7phtZc7gtCc1XiaA2Ui1LQeirHtKREVRaeUID8krbYr7zY96O/8vgiei+EBwbuFEJOK2w7cW1TCxjmn9q3ADHb7yH9KamBp1icgrf+ZOYEE4586VyFRYbGnetfpKG0otRZsGowrXJKUJwSTgWyRgvfYHKQtgcECyVIV+rk8/Fa9alBuSvP+p3qVvLwqsXN9fFC0M1n4g1R+0uLyNX9718LmYiSd3N14ree4d5cbWpETd5vbpNfSfcMBNA26HDbA==
X-YMail-OSG: 8upxAccVM1myXZ70QWTl6TmEOlHdm1xfll2CJReSsGrVNInbTz2Eden4PetFKSA
 ECH1ZZxOtMtsPXBd5CU7i38.VZPfM6QHg1H49Aq4xqNMJ9P9UBWoEq9MZxDoxpuwsBRUHIRIuJd5
 TMLmY6aR_YR9qrYrFlQII3OHBnZd8dOBGicLeOKvic06uvYx65hqtFEhLHkT45Go5bUKg0p2yWYB
 _OIQj9HddZypUCZFaj_ePBp_.RxX.IaWWhmOaZmxS6dq6FWZ1xVo827UTEWgatT405pXrZw9VKc.
 9rP1.akIkQceUY4aypUikcypYDH90cwkxXy65XEdirTGPT85oWHPxXk_KfxjFnEtWhFMz1nAWCo2
 aTaxHJpMSBoOXj8dGyn0.n1UX1qiS.e6WLasPJjYqVJUyvMnJsgElanQkb2ayE4ZaoalKsXKSF_q
 m6LUKpIU1hSxYlOFOT0dIPkR4P66SostPzStHHDeP2REQewVsjLE05vNggcWUgCbNVBxyAkvWoMb
 9V40VLn0Hi5iC79dYcS8I7MODePTn6YnNu.viLE02f8uu4wIcVjye_vg80fJ95Sw9vFz8FLg09_H
 CRIETmJ1DoDq24Q9W4LxBvoMYZSMMqo1GyI2tjLbgNKnRm7b08.hUiJPmjjVjlBUKo_HA2njxngI
 lWKpmFlqEobKgwyBBqObZtIqZSxjVpuVIPRXL6vAKiGkzA9NLJUoF4rBFfmXpFWW1XIxiVb2hJHX
 TcQnju4UnWDPi8j8mFhx0v2v95La0lVOgar_LjFbGPwfnZ5C1VyFB3XnwpQyUO4laVkmFY1owjjK
 l1fn.EidkYuaRRRsiiEifEYNK6enyi7khKRVCS3XFI5TK7zzjepZpHojVjDMtKsIrOUPMehqA4.0
 1Oas9n5DqGDJJqTi9V5XqCbswWZ1Xo0wCZHXygpEC4QSJ9dd6k3YHaco9cKfU3yOAld.Ck0iWeOf
 1QqGNzUP1sj4JaMSe.NOGw0KLfRCnQoFIjVyljo01wMpTawt0jKJ.mxDz.V05AlpKS7b7z5Xf.gb
 _0kPA90AH5hcNQKP4zUsiTD5ImQK8vzQuVFxgKX8wtaqq4qbJdtp8HktNSNEXkswHXdq5K4EAUk2
 Hqg.cOSI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Thu, 31 Jan 2019 01:46:07 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp407.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID baafaa44e4a9157cefe7fce99c3e2a0a;
          Thu, 31 Jan 2019 01:46:02 +0000 (UTC)
Subject: Re: actx not used?
To:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190131005849.fmwpsg2dvwwwmali@madcap2.tricolour.ca>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1d8a940a-d903-5bf4-9e83-5a1a4d62a6de@schaufler-ca.com>
Date:   Wed, 30 Jan 2019 17:46:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190131005849.fmwpsg2dvwwwmali@madcap2.tricolour.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2019 4:58 PM, Richard Guy Briggs wrote:
> Hello users of *audit_rule_match(),
>
> As far as I can tell, it appears that the audit_context *actx parameter
> to *audit_rule_match() is not used by any consumers in-tree upstream.
> This includes selinux, apparmour, integrity and smack.
> Might there be others out of tree that do use it (or did request it)?
>
> I'm a bit puzzled that it was ever offered since it should be relatively
> opaque and accessed only by audit or its accessor functions.
>
> It was part of the 2008 commit 03d37d25e0f9 ("LSM/Audit: Introduce
> generic Audit LSM hooks").
>
> Would anyone object if I ripped out actx?

I don't see any reason to keep it based on what I see.
I don't see what it was supposed to be for, either.

> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
>
