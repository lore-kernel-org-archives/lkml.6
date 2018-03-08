Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988500-1520515321-2-6044644693676691736
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='utf-8', cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520515320; b=OICTrk4CIQxlpJ7Kwz0iHOgM1rbLq3PnAcX9EXJcYTBe8XL
    QnCwRboEwetJEmY6oF6uCMaCscvgzkMIE2rCenIYPrIOZ0UUL7N2WeoeMgUHFwmH
    OIF0XvryoQXNPc21qa3YBXpaiD9vsNx29UtSkTZNAarTWEbw61QXq1wZcTHJEUDT
    HjfKFMEiV/Lj9YlhEVc1ekipW6/tFIpctEg4U5FJttFlGCgICbZaFz2THtW+P1Gw
    +rBaFbPSrqspJ0DORc0Wj6ldJ+Mrf/54r8B7kublw1MBzIhG5wr5nAvrhi15f2t0
    lMVLKc2COKrpVetyNU65OCfnCvFvexmmOdiyMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520515320; bh=nK5XPhc
    2lZgEQXG408D6lILiFlL3kn4DKMvNMmGKKkE=; b=RRJ3s4qxZfmt+smtiHXM9CS
    NdEs8s3Seb36QGs4KVvGQXIYJBYxutH+KXY8fWey2y1igKqadqSuSSut691ZPvKN
    E1hBX08J4Gj4j3HOZH32mU4/TDDBuZYUfA4uZiWY8gdNcdlHYgQM4UgvV5cjZLVt
    mviLQ1YsX9e7hmV8BLWq9tJlIU6pMJdvEyWWRGTQFsgulfe6MtshKEy5f5IeDt0N
    sx27WZ4Tabo6khVnNS1UjkuAqiTpZzv4rM1I9bA05RNal/T1f3E9rFHNSukCclqm
    WpOMQRfGy937h1SL4FdfEI6RH2+TJCOoNB2rUnsdHoSpB5nSoY4ZjPDWOvdZcIw=
    =
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dVelFt7D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wf3Ug2SV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dVelFt7D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wf3Ug2SV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755756AbeCHNVp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 08:21:45 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37014 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeCHNVn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 08:21:43 -0500
X-Google-Smtp-Source: AG47ELswPOH5n4BPHgNL3PPr51ao9RDIuKZxsDHBBiQLASupzaHCzM48Rko4pHRLcMD1izOJAdGHSA==
Date: Thu, 8 Mar 2018 14:21:39 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alex Shi <alex.shi@linaro.org>, sre@kernel.org,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Message-ID: <20180308132139.apabmgw4magrp3d7@pali>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180308122715.GB21514@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180308122715.GB21514@amd>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thursday 08 March 2018 13:27:15 Pavel Machek wrote:
> Hi!
>=20
> > Resent without non-upstream patches.
> >=20
> > This backport patchset fixed the spectre issue, it's original branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=
=3Dkpti
> > A few dependency or fixingpatches are also picked up, if they are neces=
sary
> >  and no functional changes.
> >=20
> > No bug found from kernelci.org and lkft testing. It also could be gotte=
n from:
> >=20
> > git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstre=
am-only
> >=20
> > Comments are appreciated!
>=20
> Not entirely related to this patched, but... I have few older ARM
> boards here, and Nokia N9000 I really care about.
>=20
> AFAICT Meltdown is arm64 only?

IIRC ARMv7 is not affected by meltdown.

> Spectre affects the older boards, too, right? Was there any work done
> on that? cpuinfo says "ARMv7" for N900.

I remember that I saw some spectre patches for ARMv7 on LKML.

In general for ARMv7 it is problematic as mitigation needs to change IBE
bit which is not possible on OMAP HS devices. But for Nokia N900 there
is special code which do it via smc instruction (function
rx51_secure_update_aux_cr(), see also nokia_n900_legacy_init()).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
