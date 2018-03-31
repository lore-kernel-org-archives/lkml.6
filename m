Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-858207-1522468361-2-10964891796621993493
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522468360; b=o6gsRo45rgcYXk+csul72L80ufgNtvDHn+hMvqL3Ea6U8Y8tlN
    I/z6eFjZ6685Yc/t2weuuRgnXO8eksgaj1zN1bq01d31cPkQ/5FioBq2tNTpVZTn
    KZCdeLadKwIohdqRHkbaBiCT12kWBiddSwqXo/BMXtR4iBaDalwIxkuLo6HNQTT/
    JqFgRHnUcDWANdIxntCKOfbuFju3pLmXRzFFSIFIf84iXwrpjDwmnehNf1czlVJm
    MR5zw1+Yyzy8Vzsy8Z3IYGsPRQ8YBVRI4WYr1QZnIbWreB8HuRqiKIpfGPdVyRrA
    kRTJoMUQAWRJQEnuOne14LYAHE2Fy3bpnM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1522468360; bh=7PO/yJ89Ox34QHgS45O9+7EI8l3ijUS
    Tti+A+CxDFak=; b=frZk7W3HLpYCaARhVCo25RfXrbfKTtCHgl/NkIGilREcdWw
    t8ZToCmJjgBF6hncyYaga92h+b4UEThwIXS6mw3VX7GZBnc6pO/JRjvOsSUkp3Am
    f9W0urIeCSFmVXHyDNKC8eLfhtCp9kQutQAedGoEwcqCiT16b41eYkWpxV0ojrdR
    KefTPYUNKFt6r8gNCl5BVFwpqw7JHYpSxmcBDGINKo8VQKnCJQseGOqUh5UV18sF
    6B4b8zpJYCo33iBCvaWwNsY5s4ZL1nut5n6oLNuefiS652z+OpiNKiJgpcLRcNDL
    0UiaHcqOFp9w6M/WpjTCzN90ORhAXnYyJW/zc1A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKVqFmWxHJ1EXpP36EbU9WLwNgVeQtY5KdzhM5emc8T+JKrflxgFYtSeix+m5QZuM9SJYLcToD2qKiBSvhvyTZBXGNCdqyBM118WGrEEVphq8wn7iTZ1
    RBTVILC+/fUcWi3Hey8oKITMeZfNeG1ClKv2FufNBh57hrAelGl3O6Q3blyKEVeKM1sbZKWFn0uZnzpWPDsUlN20qGRvjKqW3F2AmxFb37vcLfdAT15EbeTo
    oUs3EDZc+eCHLsQWwmh2jg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=1oJP67jkp3AA:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ZZnuYtJkoWoA:10 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=JfrnYn6hAAAA:8 a=iox4zFpeAAAA:8 a=sK_hXKufAAAA:8
    a=Pv3XZVpQ2yypkRIsQrIA:9 a=N2WSDsOodWJD5QhigVcA:9 a=ONNS8QRKHyMA:10
    a=DDOyTI_5AAAA:8 a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10 a=pC-h2on8RWMA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=yWjlxG-dkHreuWcaj4iL:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 Andreas Dilger <andreas.dilger@intel.com>, Oleg Drokin <oleg.drokin@intel.com>
Date: Sat, 31 Mar 2018 14:52:18 +1100
Subject: Re: [PATCH] staging: lustre: libcfs: use dynamic minors for
 /dev/{lnet, obd}
In-Reply-To: <1522437006-31539-1-git-send-email-jsimmons@infradead.org>
References: <1522437006-31539-1-git-send-email-jsimmons@infradead.org>
Message-ID: <877eps3nrh.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "John L. Hammond" <john.hammond@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: multipart/mixed; boundary="===============6411582534038953732=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============6411582534038953732==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30 2018, James Simmons wrote:

> From: "John L. Hammond" <john.hammond@intel.com>
>
> Request dynamic minor allocation when registering /dev/lnet and
> /dev/obd.
>
> Signed-off-by: John L. Hammond <john.hammond@intel.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-100086
> Reviewed-on: https://review.whamcloud.com/29741
> Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
> Reviewed-by: Jian Yu <jian.yu@intel.com>
> Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> Signed-off-by: James Simmons <jsimmons@infradead.org>

Yes, this is a much better fix than my kconfig change.

 Reviewed-by: NeilBrown <neilb@suse.com>

and thanks for your quick review on my last series!
Thanks,
NeilBrown


> ---
>  drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h    |  1 -
>  drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h      | 11 -----=
------
>  .../staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h   |  2 --
>  drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c        |  1 -
>  drivers/staging/lustre/lnet/libcfs/linux/linux-module.c       |  5 ++---
>  drivers/staging/lustre/lnet/libcfs/module.c                   |  1 +
>  drivers/staging/lustre/lustre/obdclass/class_obd.c            |  6 ++++--
>  drivers/staging/lustre/lustre/obdclass/linux/linux-module.c   |  3 +--
>  8 files changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h b=
/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> index 30e333a..cf4c606 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> @@ -50,7 +50,6 @@
>  #include <linux/kernel.h>
>  #include <linux/kmod.h>
>  #include <linux/kthread.h>
> -#include <linux/miscdevice.h>
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
>  #include <linux/module.h>
> diff --git a/drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h b/d=
rivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h
> index d9da625..cccb32d 100644
> --- a/drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h
> +++ b/drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h
> @@ -119,16 +119,5 @@ struct lnet_fault_stat {
>=20=20
>  #define LNET_DEV_ID 0
>  #define LNET_DEV_PATH "/dev/lnet"
> -#define LNET_DEV_MAJOR 10
> -#define LNET_DEV_MINOR 240
> -#define OBD_DEV_ID 1
> -#define OBD_DEV_NAME "obd"
> -#define OBD_DEV_PATH "/dev/" OBD_DEV_NAME
> -#define OBD_DEV_MAJOR 10
> -#define OBD_DEV_MINOR 241
> -#define SMFS_DEV_ID  2
> -#define SMFS_DEV_PATH "/dev/snapdev"
> -#define SMFS_DEV_MAJOR 10
> -#define SMFS_DEV_MINOR 242
>=20=20
>  #endif
> diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioct=
l.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h
> index 9590864..6e4e109 100644
> --- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h
> +++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h
> @@ -51,8 +51,6 @@ enum md_echo_cmd {
>  #define OBD_DEV_ID 1
>  #define OBD_DEV_NAME "obd"
>  #define OBD_DEV_PATH "/dev/" OBD_DEV_NAME
> -#define OBD_DEV_MAJOR 10
> -#define OBD_DEV_MINOR 241
>=20=20
>  #define OBD_IOCTL_VERSION	0x00010004
>  #define OBD_DEV_BY_DEVNAME	0xffffd0de
> diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c b/dri=
vers/staging/lustre/lnet/libcfs/linux/linux-debug.c
> index 0092166..1d728f1 100644
> --- a/drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c
> +++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c
> @@ -48,7 +48,6 @@
>  #include <linux/completion.h>
>  #include <linux/fs.h>
>  #include <linux/uaccess.h>
> -#include <linux/miscdevice.h>
>=20=20
>  # define DEBUG_SUBSYSTEM S_LNET
>=20=20
> diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c b/dr=
ivers/staging/lustre/lnet/libcfs/linux/linux-module.c
> index ddf6256..c8908e8 100644
> --- a/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
> +++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
> @@ -33,10 +33,9 @@
>=20=20
>  #define DEBUG_SUBSYSTEM S_LNET
>=20=20
> +#include <linux/miscdevice.h>
>  #include <linux/libcfs/libcfs.h>
>=20=20
> -#define LNET_MINOR 240
> -
>  static inline size_t libcfs_ioctl_packlen(struct libcfs_ioctl_data *data)
>  {
>  	size_t len =3D sizeof(*data);
> @@ -191,7 +190,7 @@ int libcfs_ioctl_getdata(struct libcfs_ioctl_hdr **hd=
r_pp,
>  };
>=20=20
>  struct miscdevice libcfs_dev =3D {
> -	.minor =3D LNET_MINOR,
> +	.minor =3D MISC_DYNAMIC_MINOR,
>  	.name =3D "lnet",
>  	.fops =3D &libcfs_fops,
>  };
> diff --git a/drivers/staging/lustre/lnet/libcfs/module.c b/drivers/stagin=
g/lustre/lnet/libcfs/module.c
> index a03f924..4b9acd7 100644
> --- a/drivers/staging/lustre/lnet/libcfs/module.c
> +++ b/drivers/staging/lustre/lnet/libcfs/module.c
> @@ -30,6 +30,7 @@
>   * This file is part of Lustre, http://www.lustre.org/
>   * Lustre is a trademark of Sun Microsystems, Inc.
>   */
> +#include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> diff --git a/drivers/staging/lustre/lustre/obdclass/class_obd.c b/drivers=
/staging/lustre/lustre/obdclass/class_obd.c
> index 3e24b76..7b5be6b 100644
> --- a/drivers/staging/lustre/lustre/obdclass/class_obd.c
> +++ b/drivers/staging/lustre/lustre/obdclass/class_obd.c
> @@ -32,7 +32,9 @@
>   */
>=20=20
>  #define DEBUG_SUBSYSTEM S_CLASS
> -# include <linux/atomic.h>
> +
> +#include <linux/atomic.h>
> +#include <linux/miscdevice.h>
>=20=20
>  #include <obd_support.h>
>  #include <obd_class.h>
> @@ -462,7 +464,7 @@ static int __init obdclass_init(void)
>=20=20
>  	err =3D misc_register(&obd_psdev);
>  	if (err) {
> -		CERROR("cannot register %d err %d\n", OBD_DEV_MINOR, err);
> +		CERROR("cannot register OBD miscdevices: err %d\n", err);
>  		return err;
>  	}
>=20=20
> diff --git a/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c =
b/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c
> index 7bceee7..3b1d096 100644
> --- a/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c
> +++ b/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c
> @@ -42,7 +42,6 @@
>  #include <linux/module.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
> -#include <linux/major.h>
>  #include <linux/sched.h>
>  #include <linux/lp.h>
>  #include <linux/slab.h>
> @@ -271,7 +270,7 @@ static long obd_class_ioctl(struct file *filp, unsign=
ed int cmd,
>=20=20
>  /* modules setup */
>  struct miscdevice obd_psdev =3D {
> -	.minor =3D OBD_DEV_MINOR,
> +	.minor =3D MISC_DYNAMIC_MINOR,
>  	.name  =3D OBD_DEV_NAME,
>  	.fops  =3D &obd_psdev_fops,
>  };
> --=20
> 1.8.3.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq/BfIACgkQOeye3VZi
gbnXQhAAtIuCTrInME7qA1sab6sOWUSWAGVxn9ETf3pPxdSL9JH7/9IU75ZV35z8
dn0zUD9RJMiHtGEP+eFrlHLZT66dxV1yBoKRDQvxPnXRh4p4/G+VicB7RnP0huEG
9OSZstxe/Tse8+y7T9qwDmejeDPelx3Rt2sjpW9lxNl1Q4Q/t8QVHan8jKgya6SO
I2BOBoeOxpQQJmxzd9ChwjkL1xe1fRO/speMsRubrXqRitaL7GItIHLPjTLR1LsC
HF7y8D87gnZAPQ6fVp8f6gDYpZgewnpS094WDMP0my+G61uyd8W70tWt5cZ1+kkf
1og4CBDe/xyiiR2+8fa9PWo5ys8WJKGNfywJjeL/6hG5x2xtWcgkkhSlKJFtkm2F
LcDT5tj4boUEmFqK/BDNvlUAiDU3KImAoLcNYiBee+5OwVv4kwfnfiTdvFRf68ef
bH7P2eHwSRiHVpUb0hH1uVlM5/JfVQ5OxhzMzIo90e5jsfASALxhKhOiEVW7j0b8
dizD4CMW//1E9SYzghAAhfN1H4LlfUH/ueaJjrlBtzM5zwxNK6oZaZ2dQRsGwBdQ
03XOOk6McX+wVcXKDs3UyfF4za5q1IePeoYXLbhTR5FDX42EF9PIojgEfeoGcwii
70V0//acDaNvrDf2Y2tACfvHn8pcKwUOE8ZiK8JZJ3b+6g6fyiM=
=4bVZ
-----END PGP SIGNATURE-----
--=-=-=--

--===============6411582534038953732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============6411582534038953732==--
