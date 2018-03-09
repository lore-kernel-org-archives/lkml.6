Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELvZB8ngLYKSByQ87OK46Wr1N/9OL9fQaaElMGzWeMhJdUSgf9HgJtB9mRpfTN2hYGI3wThz
ARC-Seal: i=1; a=rsa-sha256; t=1520555828; cv=none;
        d=google.com; s=arc-20160816;
        b=o/regRt+j8dh3vrnDfKE1d14I47dhIEoZVYlh9X69i9s2GmpNyAy0WB6UGkPg7Jt5u
         SsqLI+hS3DHK/lJWK5SBPBcFzFGex6Yq4hqDRgijCcYw+1RvyBbbDDF6zUnWgjBnX3yR
         qMDWz6EH/o/QFagGeXgb4c/tpOGBJhYjn9aEy6smAop4ZpH+6cUsWHz6tnc6jYEjWuph
         ZbstdLhlCWM3oqj9dSNIEO9pPK2TrwXNk7b92QvmjvCtfGQ18+924WYMzpCBoOqPuAeM
         0hi5lQ86NdFWSeNLKbw9lg/LQdnxudGD6m+PXJxxJpiLtgUq46FC25nW2qK/MgamnjxZ
         jXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=2Y0eyUrD8780VLGq298F6KKtW/C0XUSQ6269H2ns1sM=;
        b=fXqFlR7kq74T1vVMRIF+LXczlo5FJm2NaE+RHkkC1413k1bCbjrjb9tu5J1+7hJGtZ
         5i/zk1ShHsm1xJBYf3sX8hfOtFD++fELYa2nyK22X6/0yZlexHCDImiKcBm0BRhGOzXy
         fEjxdKiPP68w7/0aanAPPf9fJhpHIGk8oP0TnNHwQ/V++N+GX32j+SMAdcKH3KZN8gDu
         hiZ8oKXZj90a6ntX0k1TNdSESDx/9kcCCBxotONZs93VU6FNRbYi1maML5/Y9GghH70P
         EJfcu4bGQnMB9Te3qmKQdFT3VVAW5hBKSsI4XeZoQZGNyw7eE5LKKKTcCDioTAXyIB0s
         nfWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="210075092"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 17/17] Revert "staging: Disable lustre file system for
 MIPS, SH, and XTENSA"
Thread-Topic: [PATCH 17/17] Revert "staging: Disable lustre file system for
 MIPS, SH, and XTENSA"
Thread-Index: AQHTsbXS8fsJegIGeE+AKhcFxfzFRaPHoDAA
Date: Fri, 9 Mar 2018 00:37:07 +0000
Message-ID: <607D7FFB-CF2F-43DF-A19A-5A713C959670@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708565.7628.14283641203455668904.stgit@noble>
In-Reply-To: <151994708565.7628.14283641203455668904.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.37.249]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1B597D0543E3B49A752A88FB295A044@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780214051615691?=
X-GMAIL-MSGID: =?utf-8?q?1594418348412117528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> This reverts commit 16f1eeb660bd2bfd223704ee6350706b39c55a7a.
>=20
> The reason for this patch was that lustre used copy_from_user_page.
> Commit 76133e66b141 ("staging/lustre: Replace jobid acquiring with per
> node setting") removed that usage.
> So the arch restrictions can go.

I don't think these platforms will be used with Lustre any time soon,
but who knows... :-)

In any case, thanks for this patch series, definitely a lot of good
cleanups in there.

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> drivers/staging/lustre/lustre/Kconfig |    1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/Kconfig b/drivers/staging/lust=
re/lustre/Kconfig
> index c669c8fa0cc6..ccb78a945995 100644
> --- a/drivers/staging/lustre/lustre/Kconfig
> +++ b/drivers/staging/lustre/lustre/Kconfig
> @@ -1,6 +1,5 @@
> config LUSTRE_FS
> 	tristate "Lustre file system client support"
> -	depends on !MIPS && !XTENSA && !SUPERH
> 	depends on LNET
> 	select CRYPTO
> 	select CRYPTO_CRC32
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
