Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4F6C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C653420849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=snewbury.org.uk header.i=@snewbury.org.uk header.b="rIXL9+53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C653420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=snewbury.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeLLJRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:17:46 -0500
Received: from know-smtprelay-omc-11.server.virginmedia.net ([80.0.253.75]:38038
        "EHLO know-smtprelay-omc-11.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbeLLJRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:17:46 -0500
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2018 04:17:44 EST
Received: from mail.snewbury.org.uk ([77.243.189.247])
        by cmsmtp with ESMTPA
        id X0YqgPbgchtC0X0YqgN8Ay; Wed, 12 Dec 2018 09:12:09 +0000
X-Originating-IP: [77.243.189.247]
X-Authenticated-User: sjnewbury@virginmedia.com
X-Spam: 0
X-Authority: v=2.3 cv=KJXu82No c=1 sm=1 tr=0 a=7eWGW6afXjFjJVQJLTi0Pg==:117
 a=7eWGW6afXjFjJVQJLTi0Pg==:17 a=IkcTkHD0fZMA:10 a=2ur7OfE09M0A:10
 a=_vhMSwdQLMa2vP6iUl0A:9 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=snewbury.org.uk;
         h=content-transfer-encoding:mime-version:x-mailer:content-type
        :content-type:date:date:from:from:subject:subject:message-id; s=
        eater; t=1544605926; x=1546420327; bh=yNqG4mwTiFCcJNVzw0aQBId8D6
        wZ5Xk7YlJODlS2FQE=; b=rIXL9+535+f/tPTkrAQkWdZG0oNzve+iBJp32/awp3
        naTHCFkeyxjmNOl9mlK/PglAqd1RcwPyJ3kEqMKmIqMkkd3zHFdqtlTY8pHtbRpm
        E2SXRQ3RaV3xPlWcZMM8lC6rpVMw0RIKSk0YScsVX+MREznjoUgiHOdBvxf52TM7
        A=
X-Virus-Scanned: amavisd-new at snewbury.org.uk
Received: from android-a9f8fd57ba190b44.media.snewbury.org.uk (android-a9f8fd57ba190b44.media.snewbury.org.uk [192.168.75.105] (may be forged))
        (authenticated bits=0)
        by mail.snewbury.org.uk (8.14.9/8.14.9) with ESMTP id wBC9C43k012282
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Dec 2018 09:12:05 GMT
Message-ID: <1544605954.117529.27.camel@snewbury.org.uk>
Subject: Re: Can we drop upstream Linux x32 support?
From:   Steven Newbury <steve@snewbury.org.uk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        macro@linux-mips.org, tg@mirbsd.de, luto@kernel.org, arnd@arndb.de,
        dalias@libc.org, s@ecloud.org, catalin.marinas@arm.com,
        fweimer@redhat.com, glaubitz@physik.fu-berlin.de,
        christian.brauner@canonical.com, hjl.tools@gmail.com, hpa@zytor.com
Date:   Wed, 12 Dec 2018 09:12:34 +0000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPBfW+NSX8Q9egM+3b0va2ByrGxc4xUt+HhNtrjuoFEc3mt/0vYt8I2gMGIu7n66l8f23lwCxfijR9r2F0w45VYjPRE2JE0wjPZfrPxETCqJ5Dqdexpf
 g3ifV5+pbqwGPOPfx8jQLV72t51WMFFiniTE9MhZ31kaBtcZRi4Hb3c8LEEJH++MSpzxdovzIaLfPJT80E6FEsduQQgpaynH0IheXP0mM5hd5MIOHvRMD6gf
 u3bTTmpovEN9tLZg/Wgf8vfAlRCxJR6uNz/NaX9MV8bJUfnwUqllQDgG3HYGWp7xeTmywbE5tBUgXaUaQvQpHvhN+5xtMfBZikKkeb104Ej7e/V3P0SK0PHE
 3ZjrgXp7MCPtqepICQiZl3qY2jtdtbDHBs+DnjTRv+NdQdEIJL2bydOstVKO6N2gFNuxjjI9wmNc0Vt14/5VDg+l9qn5wo51K7+J7x47eySwjYZATxOo86p6
 Ok72sOl0ovWHKfgQXXe7XRV3OTH5pl8UB9NBXQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

First off I'd like to request: Please don't break my userspace!

I have a number of systems running with x32-abi as native.  They work
well, I've no want or desire to upgrade their memory or CPUs to make
keep them working as well as they do now.  Let alone the hassle of
having to redeploy with a completely different ABI.


I've been working on getting as much userspace as I can working with
x32 since it first became somewhat usable, I've sent patches upstream
and pushed to encourage projects to write portable code.  Sometimes
that has meant just little tweaks to build systems, or sometimes
disabling asm where I consider it isn't worth the effort of making it
work.  For other projects I've converted the asm or even in some cases
got the JIT working, mozjs17 for example.

So I'm both a user and a developer.

Breaking support for x32 would be really bad for me, but if I'm the
only one using it I suppose I can't really justify it being kept on
that basis.  I know CERN has sucessfully experimented with it over the
years though, so I wouldn't be surprised if there are other users
hiding out there.

I can't help but wonder if it wouldn't make more sense to drop x86
support from long mode than x32.  AMD64 x86 support was always intended
 as a compatibility feature, I very much doubt there are more people
out there using an x86 native userspace on a 64 bit kernel than there
are native x32 users.  x86 support could be implemented via KVM and/or
qemu-user.  There is no reason to keep the extra complexity in the
kernel for what is effectively an emulation layer anyway.
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWa1B4K0Hk12RDstE+lAa6BzrmeAFAlwQ0QQACgkQ+lAa6Bzr
meBILQf9EF1GqHKfnRC7AOFnNCm0235OmH1dJJd4+6zzLWTKGAAvFF6T1F1IG3fu
QTZTEok5s238BapjrvgZ5bxtMP0TGNK++vGZ8ESb6Hi+Q975duemWD8ZsSVPw7SH
YcqEgmxKn28iHq/W//SUPo1kqz7D0jFCDU9dIA1wQY+AwTIzjfMPltWGrKbMbOBQ
LsW+VlL7PfoEzx9sXvaMpjgINEouCvLcuTvhTRclCOO5MWqTQLdIdL9urrBGukUN
7dvKiWWAk6c/Af1W5jnLtYIijaztu3hrZ7lykFmOnwyDoeOhqzIhUkcDaLJcy7Vo
Rsrb1CjzFngpbgTJeOkyC9ZGZ2CZ0g==
=TCpw
-----END PGP SIGNATURE-----

