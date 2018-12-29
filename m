Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF90AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83532146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbeL2Bco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:32:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:39632 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728848AbeL2Bcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 20:32:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 335FBAF5A;
        Sat, 29 Dec 2018 01:32:40 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Date:   Sat, 29 Dec 2018 12:32:30 +1100
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 treewide] headers: separate linux/mod_devicetable.h from linux/platform_device.h
In-Reply-To: <20180707155306.GA23729@kroah.com>
References: <7baed3cc-cb9c-66d2-b179-517877324407@infradead.org> <20180707155306.GA23729@kroah.com>
Message-ID: <871s61azip.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 07 2018, Greg Kroah-Hartman wrote:

> On Tue, Jun 19, 2018 at 10:47:28PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>=20
>> At over 4000 #includes, <linux/platform_device.h> is the 9th most
>> #included header file in the Linux kernel.  It does not need
>> <linux/mod_devicetable.h>, so drop that header and explicitly add
>> <linux/mod_devicetable.h> to source files that need it.
>>=20
>>    4146 #include <linux/platform_device.h>
>>=20
>> After this patch, there are 225 files that use <linux/mod_devicetable.h>,
>> for a reduction of around 3900 times that <linux/mod_devicetable.h>
>> does not have to be read & parsed.
>>=20
>>     225 #include <linux/mod_devicetable.h>
>>=20
>> This patch was build-tested on 20 different arch-es.
>>=20
>> It also makes these drivers SubmitChecklist#1 compliant.
>>=20
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kbuild test robot <lkp@intel.com> # drivers/media/platform/=
vimc/
>> Reported-by: kbuild test robot <lkp@intel.com> # drivers/pinctrl/pinctrl=
-u300.c
>> ---
>> v3: add fix for drivers/pinctrl/pinctrl-u300.c
>> v2: add fixes for drivers/media/platform/vimc/
>
> I've queued this up now, let's see what else breaks!  :)

Some MIPS watchdog drivers break, at least.

NeilBrown

From: NeilBrown <neil@brown.name>
Subject: [PATCH] Fix compilation problem for mt7621_wdt.c and rt2880_wdt.c

These files need
   #include <linux/mod_devicetable.h>
to compile correctly.

Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/=
platform_device.h")
Signed-off-by: NeilBrown <neil@brown.name>
=2D--
 drivers/watchdog/mt7621_wdt.c | 1 +
 drivers/watchdog/rt2880_wdt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 5c4a764717c4..81208cd3f4ec 100644
=2D-- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/watchdog.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
=20
 #include <asm/mach-ralink/ralink_regs.h>
=20
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 98967f0a7d10..db7c57d82cfd 100644
=2D-- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -18,6 +18,7 @@
 #include <linux/watchdog.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
=20
 #include <asm/mach-ralink/ralink_regs.h>
=20
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwmzq4ACgkQOeye3VZi
gbkm8hAAhnOvpU6mkx90QVyixnKphhe92bxoDDxdBQ8oKMctLn+yXu0s7T9+nm6V
MbjHGWFDFYC8nqdFBE6MaD3MyS5HnClCxHKeZGSvHW0z0diTXHAUSDSJmdZiQwxX
PWsDT3lJ1v+aUO/RYX6KKcfntWAHkjav+UWZHbV3y/1qYwV6Cq0agqrSYDLfb7fn
AlHWmrT43eOrUyrRVonk+/KVIKTKdQRjLNa1vz4ZlZoa2g46RJZeHHzUMOu2OHbb
zPkNOQcFbGTmG82i8FTGtu0V1MZyWHeVM4uRnRJXiUEDfuHOnoy/RElyCjvxFqmd
XBANZPxPXzbGUylH9yRtIzuDENPAlnMMDWhnL9auERSNLKx2Sg3ylwgbIIkA34KX
wT6IxEzRmLU8Vlv8vlJuo/N+xE8mCpDzLEs9igQ996SufWrsrhhPbhBmZS1BIWeY
W9S8msCBemB5QwABmYEeKZgAfCSjXU5hOmFsdE/77R8em5b8D3ZDVoyaLhhmoxfN
nUR/z2rRvcnNOr1ByeTYUrKhJ5ADuXnjHA6735gHA27QSaFpEmPF5HSYyRymCXC2
h4OmnkhSc1B4G6bNsUEzDVD2LjeDqWST7EhUoOx5BbdS48Lxvxwd5VN8J3dfxkma
Re2YNxWGHF5/JB3G8BO3hMR3HpOvcU1moZmctLdxSM2JUYT4hI8=
=/6XV
-----END PGP SIGNATURE-----
--=-=-=--
