Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86D2C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824FA2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=snewbury.org.uk header.i=@snewbury.org.uk header.b="AWRkn/gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824FA2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=snewbury.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeLLN0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:26:48 -0500
Received: from know-smtprelay-omc-11.server.virginmedia.net ([80.0.253.75]:42513
        "EHLO know-smtprelay-omc-11.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbeLLN0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:26:48 -0500
Received: from mail.snewbury.org.uk ([77.243.189.247])
        by cmsmtp with ESMTPA
        id X4XEgQUF7htC0X4XEgNQ7w; Wed, 12 Dec 2018 13:26:45 +0000
X-Originating-IP: [77.243.189.247]
X-Authenticated-User: sjnewbury@virginmedia.com
X-Spam: 0
X-Authority: v=2.3 cv=KJXu82No c=1 sm=1 tr=0 a=7eWGW6afXjFjJVQJLTi0Pg==:117
 a=7eWGW6afXjFjJVQJLTi0Pg==:17 a=IkcTkHD0fZMA:10 a=2ur7OfE09M0A:10
 a=q4uHb2JfoHBGn-mcJ-AA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=snewbury.org.uk;
         h=content-transfer-encoding:mime-version:x-mailer:content-type
        :content-type:references:in-reply-to:date:date:from:from:subject
        :subject:message-id; s=eater; t=1544621203; x=1546435604; bh=kWj
        mIltsq6B/tjEvq+fx2ux6POJfkYpJ2n2A55mvA1U=; b=AWRkn/gEoFLk/aI5XmA
        6vGmyfnOITwlEtmcfmaF1125xDgrkNNCBTvQrly2Gxtqv8AuJd4pZ2HrF+nFBHe3
        qHvcG5BkEFhHpDU1ogHN/ebVd7KfISJ6nlziZgjUkKrW3u02YXlHNygChKMP3iXv
        PZb32SDzSo1kwtIoQs24fzyo=
X-Virus-Scanned: amavisd-new at snewbury.org.uk
Received: from android-a9f8fd57ba190b44.media.snewbury.org.uk (android-a9f8fd57ba190b44.media.snewbury.org.uk [192.168.75.105] (may be forged))
        (authenticated bits=0)
        by mail.snewbury.org.uk (8.14.9/8.14.9) with ESMTP id wBCDQfTJ019409
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Dec 2018 13:26:42 GMT
Message-ID: <1544621233.117529.33.camel@snewbury.org.uk>
Subject: Re: Can we drop upstream Linux x32 support?
From:   Steven Newbury <steve@snewbury.org.uk>
To:     Thorsten Glaser <tg@mirbsd.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        macro@linux-mips.org, luto@kernel.org, arnd@arndb.de,
        dalias@libc.org, s@ecloud.org, catalin.marinas@arm.com,
        fweimer@redhat.com, glaubitz@physik.fu-berlin.de,
        christian.brauner@canonical.com, hjl.tools@gmail.com, hpa@zytor.com
Date:   Wed, 12 Dec 2018 13:27:13 +0000
In-Reply-To: <Pine.BSM.4.64L.1812121047070.21176@herc.mirbsd.org>
References: <1544605954.117529.27.camel@snewbury.org.uk>
         <Pine.BSM.4.64L.1812121047070.21176@herc.mirbsd.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJaXkC1sApP7rfLdV/Ed/puU08beWbbcBzwBd2/kmrK/MpN7DuyOB2lfItvQs/AWPxNLDc0zZAimfFgt0s27GhEExWlfH8zN88Hm5C8DVahxCU80zdqt
 42eELp/sBkG6SdTlET1J5YCQAX8KdRqkbpwhDg0079l2DAcr/Bh30gTzPDmsz0ef7XfQXZkc+qTFDwzwHYwTMoaENvdq9by6eD8oYgnVUPIKJWZqsabwoUlh
 xuikYtxFmdCs3fgwB/abrS9ub7JkFYUeqry8fKMV+FUZ3CN63Ri/ZAjbranCrnFeAPju5nJFKEsFImHtncUFxT4OynnJLHmky5nH2Xz6tVukToJAwx+8Yn3E
 vKDO8HZ02jR1Y1w6X7s4GTvI/09PXCJ76X9IXKMjbZMDIPEep4WV7P88DhJuEmLTeOdCCYKyYsa4VqLemCotCtmou4d4idC+yswFiw7fEqkLjDVE9P6dpawK
 AjeRxENXjzK0HIhf2kS5VO3lHBHwvpsM68NTEw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Wed, 2018-12-12 at 10:48 +0000, Thorsten Glaser wrote:
> Steven Newbury dixit:
> 
> >I can't help but wonder if it wouldn't make more sense to drop x86
> >support from long mode than x32.  AMD64 x86 support was always
> intended
> 
> Do you mean i386?
> 
> x86 = { i386, x32, amd64 }
> 
Yes, sorry to be unclear.  I mean the "IA32 ISA".

> No, please don’t. I use i386 as “companion architecture” to x32,
> only the kernel and actually memory-hungry things (qemu) are
> amd64 binaries on my system, and this works very well.
> 
Well, if you have amd64 qemu anyway, why can't you use binfmt_misc with
qemu-user to simulate i386?  I'm just saying that makes more sense to
me than dropping x32.
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWa1B4K0Hk12RDstE+lAa6BzrmeAFAlwRDLIACgkQ+lAa6Bzr
meB2FQgAxF85pmFK90op1tY/lPKFqnQZdbx1zq1gPQVS1N30Kqt+FTJYSi0HNfPd
Q0l1TVx7BCF2VFzqQkLWPwtjeK8OP8SY9D8ShbYo2/Ul0e0tfc2L9+YJpa3QCzvE
p3G6SE92+wZZZlPoT+bVGj4heRUrCzUi77/bTIRO4JkSelJFDSZEVoZqTabYuveh
lBtbDZ6WvFxAGZg3fSjpZwq31C0cV/W7S0FJhutb+rAhIpoL4jHmddnhUSq+mM0+
lHNQ3O8WmbzR8FY6lezhhmBir29iW/2gJ/+Z5kSSdBV3buk6O8LB2WbFORhpGSYb
pWb2drFGVZeQhuOrboG95ZQ1d+4YnQ==
=skLP
-----END PGP SIGNATURE-----

