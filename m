Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C58CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B563B2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VGwvCyje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B563B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeIJIvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:51:46 -0400
Received: from ozlabs.org ([203.11.71.1]:60201 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeIJIvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:51:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 427vSY67R1z9sBs;
        Mon, 10 Sep 2018 13:59:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536551981;
        bh=EeYt7n090wd38B7yQ/MMTXRmHmNVb3uHICYDFVFJDoE=;
        h=Date:From:To:Cc:Subject:From;
        b=VGwvCyjeVnTIc4f7Q8A/vAM9aaAtPh58w3aWKFEeaBr6HWEnYUdVy00mLNSLhijHO
         yJN/6hDMIVR1BYBuz2yJITi7HazJDYyIXDMwwWLEXtPZQ+FZz04tbXs8nbP04IPfZC
         EKxBmvrsl4MmpKmjG7tn0WBW7RupCP8zegxqsLkiEwwlLSXAHllVcQtaGs27laguqn
         XkAi+55q0q+cBdVPLCJYUQNlhygon3bqZlQrttzUUONTXwhVH28Ih4Xl/BwrRMeric
         ia+1sf3xqQyyObajkiUDRq2Hv2EVrzHqZDfv7J1KqfgiptJ6aruUJiLc1CERf1WSps
         jN22I8u6FDgtg==
Date:   Mon, 10 Sep 2018 13:59:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs tree
Message-ID: <20180910135941.1da2426d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0bX3eQ4SOS.md+MLLpVLtpX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0bX3eQ4SOS.md+MLLpVLtpX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (sparc64 defconfig)
failed like this:

In file included from arch/sparc/include/asm/fbio.h:5:0,
                 from fs/compat_ioctl.c:76:
arch/sparc/include/uapi/asm/fbio.h:100:25: error: field 'pos' has incomplet=
e type
         struct fbcurpos pos;    /* cursor position */
                         ^~~
arch/sparc/include/uapi/asm/fbio.h:101:25: error: field 'hot' has incomplet=
e type
         struct fbcurpos hot;    /* cursor hot spot */
                         ^~~
arch/sparc/include/uapi/asm/fbio.h:103:25: error: field 'size' has incomple=
te type
         struct fbcurpos size;   /* cursor bit map size */
                         ^~~~
In file included from fs/compat_ioctl.c:76:0:
arch/sparc/include/asm/fbio.h:63:18: error: field 'pos' has incomplete type
  struct fbcurpos pos; /* cursor position */
                  ^~~
arch/sparc/include/asm/fbio.h:64:18: error: field 'hot' has incomplete type
  struct fbcurpos hot; /* cursor hot spot */
                  ^~~
arch/sparc/include/asm/fbio.h:66:18: error: field 'size' has incomplete type
  struct fbcurpos size; /* cursor bit map size */
                  ^~~~
arch/sparc/include/uapi/asm/fbio.h:113:39: error: invalid application of 's=
izeof' to incomplete type 'struct fbcurpos'
 #define FBIOSCURPOS     _IOW('F', 26, struct fbcurpos)
                                       ^
fs/compat_ioctl.c:640:21: note: in definition of macro 'XFORM'
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
                     ^
fs/compat_ioctl.c:650:27: note: in expansion of macro 'COMPATIBLE_IOCTL'
 #define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
                           ^~~~~~~~~~~~~~~~
fs/compat_ioctl.c:1188:1: note: in expansion of macro 'IGNORE_IOCTL'
 IGNORE_IOCTL(FBIOSCURPOS)
 ^~~~~~~~~~~~
arch/sparc/include/uapi/asm/ioctl.h:47:29: note: in expansion of macro '_IO=
C'
 #define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
                             ^~~~
arch/sparc/include/uapi/asm/fbio.h:113:25: note: in expansion of macro '_IO=
W'
 #define FBIOSCURPOS     _IOW('F', 26, struct fbcurpos)
                         ^~~~
fs/compat_ioctl.c:1188:14: note: in expansion of macro 'FBIOSCURPOS'
 IGNORE_IOCTL(FBIOSCURPOS)
              ^~~~~~~~~~~
arch/sparc/include/uapi/asm/fbio.h:113:39: error: invalid application of 's=
izeof' to incomplete type 'struct fbcurpos'
 #define FBIOSCURPOS     _IOW('F', 26, struct fbcurpos)
                                       ^
fs/compat_ioctl.c:640:28: note: in definition of macro 'XFORM'
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
                            ^
fs/compat_ioctl.c:650:27: note: in expansion of macro 'COMPATIBLE_IOCTL'
 #define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
                           ^~~~~~~~~~~~~~~~
fs/compat_ioctl.c:1188:1: note: in expansion of macro 'IGNORE_IOCTL'
 IGNORE_IOCTL(FBIOSCURPOS)
 ^~~~~~~~~~~~
arch/sparc/include/uapi/asm/ioctl.h:47:29: note: in expansion of macro '_IO=
C'
 #define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
                             ^~~~
arch/sparc/include/uapi/asm/fbio.h:113:25: note: in expansion of macro '_IO=
W'
 #define FBIOSCURPOS     _IOW('F', 26, struct fbcurpos)
                         ^~~~
fs/compat_ioctl.c:1188:14: note: in expansion of macro 'FBIOSCURPOS'
 IGNORE_IOCTL(FBIOSCURPOS)
              ^~~~~~~~~~~
arch/sparc/include/uapi/asm/fbio.h:113:39: error: invalid application of 's=
izeof' to incomplete type 'struct fbcurpos'
 #define FBIOSCURPOS     _IOW('F', 26, struct fbcurpos)
                                       ^
fs/compat_ioctl.c:640:42: note: in definition of macro 'XFORM'
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
                                          ^
fs/compat_ioctl.c:650:27: note: in expansion of macro 'COMPATIBLE_IOCTL'
 #define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
                           ^~~~~~~~~~~~~~~~
fs/compat_ioctl.c:1188:1: note: in expansion of macro 'IGNORE_IOCTL'
 IGNORE_IOCTL(FBIOSCURPOS)
 ^~~~~~~~~~~~
arch/sparc/include/uapi/asm/ioctl.h:47:29: note: in expansion of macro '_IO=
C'
 #define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
                             ^~~~
arch/sparc/include/uapi/asm/fbio.h:113:25: note: in expansion of macro '_IO=
W'
 #define FBIOSCURPOS     _IOW('F', 26, struct fbcurpos)
                         ^~~~
fs/compat_ioctl.c:1188:14: note: in expansion of macro 'FBIOSCURPOS'
 IGNORE_IOCTL(FBIOSCURPOS)
              ^~~~~~~~~~~
arch/sparc/include/uapi/asm/fbio.h:114:39: error: invalid application of 's=
izeof' to incomplete type 'struct fbcurpos'
 #define FBIOGCURPOS     _IOW('F', 27, struct fbcurpos)
                                       ^
fs/compat_ioctl.c:640:21: note: in definition of macro 'XFORM'
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
                     ^
fs/compat_ioctl.c:650:27: note: in expansion of macro 'COMPATIBLE_IOCTL'
 #define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
                           ^~~~~~~~~~~~~~~~
fs/compat_ioctl.c:1189:1: note: in expansion of macro 'IGNORE_IOCTL'
 IGNORE_IOCTL(FBIOGCURPOS)
 ^~~~~~~~~~~~
arch/sparc/include/uapi/asm/ioctl.h:47:29: note: in expansion of macro '_IO=
C'
 #define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
                             ^~~~
arch/sparc/include/uapi/asm/fbio.h:114:25: note: in expansion of macro '_IO=
W'
 #define FBIOGCURPOS     _IOW('F', 27, struct fbcurpos)
                         ^~~~
fs/compat_ioctl.c:1189:14: note: in expansion of macro 'FBIOGCURPOS'
 IGNORE_IOCTL(FBIOGCURPOS)
              ^~~~~~~~~~~
arch/sparc/include/uapi/asm/fbio.h:114:39: error: invalid application of 's=
izeof' to incomplete type 'struct fbcurpos'
 #define FBIOGCURPOS     _IOW('F', 27, struct fbcurpos)
                                       ^
fs/compat_ioctl.c:640:28: note: in definition of macro 'XFORM'
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
                            ^
fs/compat_ioctl.c:650:27: note: in expansion of macro 'COMPATIBLE_IOCTL'
 #define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
                           ^~~~~~~~~~~~~~~~
fs/compat_ioctl.c:1189:1: note: in expansion of macro 'IGNORE_IOCTL'
 IGNORE_IOCTL(FBIOGCURPOS)
 ^~~~~~~~~~~~
arch/sparc/include/uapi/asm/ioctl.h:47:29: note: in expansion of macro '_IO=
C'
 #define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
                             ^~~~
arch/sparc/include/uapi/asm/fbio.h:114:25: note: in expansion of macro '_IO=
W'
 #define FBIOGCURPOS     _IOW('F', 27, struct fbcurpos)
                         ^~~~
fs/compat_ioctl.c:1189:14: note: in expansion of macro 'FBIOGCURPOS'
 IGNORE_IOCTL(FBIOGCURPOS)
              ^~~~~~~~~~~
arch/sparc/include/uapi/asm/fbio.h:114:39: error: invalid application of 's=
izeof' to incomplete type 'struct fbcurpos'
 #define FBIOGCURPOS     _IOW('F', 27, struct fbcurpos)
                                       ^
fs/compat_ioctl.c:640:42: note: in definition of macro 'XFORM'
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
                                          ^
fs/compat_ioctl.c:650:27: note: in expansion of macro 'COMPATIBLE_IOCTL'
 #define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
                           ^~~~~~~~~~~~~~~~
fs/compat_ioctl.c:1189:1: note: in expansion of macro 'IGNORE_IOCTL'
 IGNORE_IOCTL(FBIOGCURPOS)
 ^~~~~~~~~~~~
arch/sparc/include/uapi/asm/ioctl.h:47:29: note: in expansion of macro '_IO=
C'
 #define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
                             ^~~~
arch/sparc/include/uapi/asm/fbio.h:114:25: note: in expansion of macro '_IO=
W'
 #define FBIOGCURPOS     _IOW('F', 27, struct fbcurpos)
                         ^~~~
fs/compat_ioctl.c:1189:14: note: in expansion of macro 'FBIOGCURPOS'
 IGNORE_IOCTL(FBIOGCURPOS)
              ^~~~~~~~~~~
arch/sparc/include/uapi/asm/fbio.h:117:39: error: invalid application of 's=
izeof' to incomplete type 'struct fbcurpos'
 #define FBIOGCURMAX     _IOR('F', 28, struct fbcurpos)
                                       ^
fs/compat_ioctl.c:640:21: note: in definition of macro 'XFORM'
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
                     ^
fs/compat_ioctl.c:650:27: note: in expansion of macro 'COMPATIBLE_IOCTL'
 #define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
                           ^~~~~~~~~~~~~~~~
fs/compat_ioctl.c:1190:1: note: in expansion of macro 'IGNORE_IOCTL'
 IGNORE_IOCTL(FBIOGCURMAX)
 ^~~~~~~~~~~~
arch/sparc/include/uapi/asm/ioctl.h:46:29: note: in expansion of macro '_IO=
C'
 #define _IOR(type,nr,size)  _IOC(_IOC_READ,(type),(nr),sizeof(size))
                             ^~~~
arch/sparc/include/uapi/asm/fbio.h:117:25: note: in expansion of macro '_IO=
R'
 #define FBIOGCURMAX     _IOR('F', 28, struct fbcurpos)
                         ^~~~
fs/compat_ioctl.c:1190:14: note: in expansion of macro 'FBIOGCURMAX'
 IGNORE_IOCTL(FBIOGCURMAX)
              ^~~~~~~~~~~
arch/sparc/include/uapi/asm/fbio.h:117:39: error: invalid application of 's=
izeof' to incomplete type 'struct fbcurpos'
 #define FBIOGCURMAX     _IOR('F', 28, struct fbcurpos)
                                       ^
fs/compat_ioctl.c:640:28: note: in definition of macro 'XFORM'
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
                            ^
fs/compat_ioctl.c:650:27: note: in expansion of macro 'COMPATIBLE_IOCTL'
 #define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
                           ^~~~~~~~~~~~~~~~
fs/compat_ioctl.c:1190:1: note: in expansion of macro 'IGNORE_IOCTL'
 IGNORE_IOCTL(FBIOGCURMAX)
 ^~~~~~~~~~~~
arch/sparc/include/uapi/asm/ioctl.h:46:29: note: in expansion of macro '_IO=
C'
 #define _IOR(type,nr,size)  _IOC(_IOC_READ,(type),(nr),sizeof(size))
                             ^~~~
arch/sparc/include/uapi/asm/fbio.h:117:25: note: in expansion of macro '_IO=
R'
 #define FBIOGCURMAX     _IOR('F', 28, struct fbcurpos)
                         ^~~~
fs/compat_ioctl.c:1190:14: note: in expansion of macro 'FBIOGCURMAX'
 IGNORE_IOCTL(FBIOGCURMAX)
              ^~~~~~~~~~~
arch/sparc/include/uapi/asm/fbio.h:117:39: error: invalid application of 's=
izeof' to incomplete type 'struct fbcurpos'
 #define FBIOGCURMAX     _IOR('F', 28, struct fbcurpos)
                                       ^
fs/compat_ioctl.c:640:42: note: in definition of macro 'XFORM'
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
                                          ^
fs/compat_ioctl.c:650:27: note: in expansion of macro 'COMPATIBLE_IOCTL'
 #define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
                           ^~~~~~~~~~~~~~~~
fs/compat_ioctl.c:1190:1: note: in expansion of macro 'IGNORE_IOCTL'
 IGNORE_IOCTL(FBIOGCURMAX)
 ^~~~~~~~~~~~
arch/sparc/include/uapi/asm/ioctl.h:46:29: note: in expansion of macro '_IO=
C'
 #define _IOR(type,nr,size)  _IOC(_IOC_READ,(type),(nr),sizeof(size))
                             ^~~~
arch/sparc/include/uapi/asm/fbio.h:117:25: note: in expansion of macro '_IO=
R'
 #define FBIOGCURMAX     _IOR('F', 28, struct fbcurpos)
                         ^~~~
fs/compat_ioctl.c:1190:14: note: in expansion of macro 'FBIOGCURMAX'
 IGNORE_IOCTL(FBIOGCURMAX)
              ^~~~~~~~~~~

Caused by commit

  be248ed54d65 ("compat_ioctl: trim the pointless includes")

I have reverted that commit for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/0bX3eQ4SOS.md+MLLpVLtpX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluV7C0ACgkQAVBC80lX
0GxbjQf/ZIpdI+dhw6hfDUoVjyGmpmJn+4IotYssS11TB+4DdMMqSWIsfeDt1f3U
TxZ7xdKKYzRQt3gN6KjQaZ1RgmrGwWxpeJ+e9LjMNBiHv6BqIBTDN9lGvO7ZrbQP
0yy9A2zGacybtZdO1u7G32sa4btFenx4+gWGKUWAklIJzGjQixb70FSMU6e5jhoX
C/dMPGpDRvSQSexYLby+0NxcRmum/wCpkw2POCnpkjvBpvHSOejK0cLpKin/XX+Q
JvlZ99Z6gBXmTXp5cQYIV2mxd1zlS8EOgIPuW251SSV7yTzta0drHvaMKJNiKEL1
b76CbYKOqWC84HXc5PG3Tl5/AIHkVQ==
=LSID
-----END PGP SIGNATURE-----

--Sig_/0bX3eQ4SOS.md+MLLpVLtpX--
