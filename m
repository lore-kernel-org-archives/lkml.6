Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELsueP8WVr8Ejt9OuHRf0m3+/ps+gZpHWOvrXdIzhwxkoRniuxVYI2eelvwbMOfAXXfSEmaP
ARC-Seal: i=1; a=rsa-sha256; t=1520555561; cv=none;
        d=google.com; s=arc-20160816;
        b=hyI/9bAdHM6C6+hVnZILdWx7l5MSeGkxAvgAWi4wlzpYPznXiqXr1pkCGBAtW5WF+X
         GfqRgyLgsh8okAjpCQnJIRNFSPXQT82+EFbkJ1mjUFi6jzU6Mcn9VyYYACeG6lsn3G+9
         ROOIifNgVwaFNpxc7YEGuKNOkecdMBOG/Bps+JwCd0cy96XjJIBrOPoTq+fVJfr2zNp+
         pQNucvErNtOt8Y+Gj4XiLoU2ANxRgs+kQh3Sx6u6L4oeM824GjjzZo2/wrFithEt78Kf
         5/CfkPNbvephAURZNXqr2e3SwH2oPX9D9Ur6kYdqlnliSwUwDEouFEwE+KRt1lQMX8jR
         Ui/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=H0kMq2jnNuSV0VH4TkF7OWakPgE1dnnG4Y+41KHR0vs=;
        b=0EgQUiriygh6zDsi4MWolAJH1zxQD9V6Lf++HdOFv8TNq3AD6rAMGPxohyw2bYHWNH
         RDGST5SAgt2HPPSQW8LoYiM+zj8u9RSmM7lz2lHmZhl1u09ma62CpuN5voxx2kU78Lyt
         J5Ot6oYpSt1IlHpRow5hIHk9o5rYgLeIb5u/+ATrpEMN7p7ogC60FTylKVK/amriaQqt
         14YlcvqJpxL4WtOsTl6wCtgCDNLCSHYFTEB05iunu9xc+S28l0h9Zdga61s+FFgBu9sA
         POMpm65+onHrXiFi3+PDttSiFOecHPyeMo7RYlub3ZV2NExc4246BsQ8dwtRB3mIIOi5
         CWcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="26458989"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 16/17] staging: lustre: allow monolithic builds
Thread-Topic: [PATCH 16/17] staging: lustre: allow monolithic builds
Thread-Index: AQHTsbXo919fD08lyk2DEZk28HbuXaPHnvKA
Date: Fri, 9 Mar 2018 00:32:39 +0000
Message-ID: <F1BB7EF9-AFAE-4376-9519-A6C97CB1EE8F@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708561.7628.11951662173369388423.stgit@noble>
In-Reply-To: <151994708561.7628.11951662173369388423.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.37.249]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AEAFBA8BE86D6D4EA709629AD61C92CD@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780207006562731?=
X-GMAIL-MSGID: =?utf-8?q?1594418068234512257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> Remove restriction the lustre must be built
> as modules.  It now works as a monolithic build.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lnet/Kconfig   |    2 +-
> drivers/staging/lustre/lustre/Kconfig |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lnet/Kconfig b/drivers/staging/lustre=
/lnet/Kconfig
> index 6bcb53d0c6f4..ad049e6f24e4 100644
> --- a/drivers/staging/lustre/lnet/Kconfig
> +++ b/drivers/staging/lustre/lnet/Kconfig
> @@ -1,6 +1,6 @@
> config LNET
> 	tristate "Lustre networking subsystem (LNet)"
> -	depends on INET && m
> +	depends on INET
> 	help
> 	  The Lustre network layer, also known as LNet, is a networking abstacti=
on
> 	  level API that was initially created to allow Lustre Filesystem to uti=
lize
> diff --git a/drivers/staging/lustre/lustre/Kconfig b/drivers/staging/lust=
re/lustre/Kconfig
> index 90d826946c6a..c669c8fa0cc6 100644
> --- a/drivers/staging/lustre/lustre/Kconfig
> +++ b/drivers/staging/lustre/lustre/Kconfig
> @@ -1,6 +1,6 @@
> config LUSTRE_FS
> 	tristate "Lustre file system client support"
> -	depends on m && !MIPS && !XTENSA && !SUPERH
> +	depends on !MIPS && !XTENSA && !SUPERH
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
