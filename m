Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELtyx8U2jOi18BlPNtHWIC0GldkiBKFP9k22fujgS0+aGeJATLXkUcQ47/+T40x/EjPHdT+w
ARC-Seal: i=1; a=rsa-sha256; t=1520468403; cv=none;
        d=google.com; s=arc-20160816;
        b=KjCmp72nFfS/6kUqnyPxTRPfOn2fe26WKuV5U9ANyl7rOKFKn+gUI/AhGKQOvVZ1WG
         Eo0krm3c8kUEhJ37UaHKS0xLG8aEcmmXJxxdcAJXLqBImMxiSsX6wTR3v3aedDgksKoi
         n+iTcye0oedInZaUu9/GQkCAnImHYsBzE0R0IS5GXvwUxQTFuobpDmx+3H8hR9QrR8Lx
         esuo4NTbh8aWMZnoGhm7fWhkqsJwz0yHT0wE3JJKMp9JZW0cBNy9HI1+tjuOPeIEvHjm
         4eRamTcL4+yT/kLlagLJ7UgMahoshmyZ/zpUawlz8ySYTbogjQ3+PkBQi50Lg0Zt6VMl
         QjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=XI5m6R97PMpjiAB+FEclTI9h4YpBF8w6YQaCpIQbHxA=;
        b=G3bjSVk7szyqsJPq0IvM7BcN27znuOwEBdbwSlP6PXTOX37ve92vcxkHTsM7SrwT9X
         yR7xJz8BpUzuwEmCCGU0X7BRijAzuDUr0mQnK2oPJQ04xI6uYBIHXMmpeJteObOLnta2
         K/CPWp8MZer8qO1JJrQ/yrcMm364CPrmPKzyorma63/S3gViTFpRtAPYPvz0lO+WABnp
         P1jU8bIbZm/c9WuiSObgXHrluMWixQXihtQZj5PtLeLajSHsG6knWoGtSuDO5psW5DBa
         4mJ/wbnAm2rRxS7kJw18x6wc6TxRaH+Dqc72I2qV2HLpwmjw4g+W/kecVX0zbPZzYLz4
         4lsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="22612340"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 07/17] staging: lustre: ptlrpc: change GFP_NOFS to
 GFP_KERNEL
Thread-Topic: [PATCH 07/17] staging: lustre: ptlrpc: change GFP_NOFS to
 GFP_KERNEL
Thread-Index: AQHTsbWnaNIxLrEYiUONnFtCprg+06PGCRQA
Date: Thu, 8 Mar 2018 00:20:00 +0000
Message-ID: <D522B515-A92B-4169-9B98-31F99ABF1D49@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708527.7628.4121961365281382022.stgit@noble>
In-Reply-To: <151994708527.7628.4121961365281382022.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.6.233]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3D05C837508164BA002FA24615ECC71@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780137676490305?=
X-GMAIL-MSGID: =?utf-8?q?1594326676780109246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> These allocations are performed during initialization,
> so they don't need GFP_NOFS.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c |    2 +-
> drivers/staging/lustre/lustre/ptlrpc/service.c  |    4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c b/drivers/st=
aging/lustre/lustre/ptlrpc/sec_bulk.c
> index 577c5822b823..625b9520d78f 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c
> @@ -377,7 +377,7 @@ static inline void enc_pools_alloc(void)
> 	page_pools.epp_pools =3D
> 		kvzalloc(page_pools.epp_max_pools *
> 				sizeof(*page_pools.epp_pools),
> -				GFP_NOFS);
> +				GFP_KERNEL);
> }
>=20
> static inline void enc_pools_free(void)
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/service.c b/drivers/sta=
ging/lustre/lustre/ptlrpc/service.c
> index 49417228b621..f37364e00dfe 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/service.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/service.c
> @@ -2046,7 +2046,7 @@ static int ptlrpc_main(void *arg)
> 			goto out;
> 	}
>=20
> -	env =3D kzalloc(sizeof(*env), GFP_NOFS);
> +	env =3D kzalloc(sizeof(*env), GFP_KERNEL);
> 	if (!env) {
> 		rc =3D -ENOMEM;
> 		goto out_srv_fini;
> @@ -2072,7 +2072,7 @@ static int ptlrpc_main(void *arg)
> 	}
>=20
> 	/* Alloc reply state structure for this one */
> -	rs =3D kvzalloc(svc->srv_max_reply_size, GFP_NOFS);
> +	rs =3D kvzalloc(svc->srv_max_reply_size, GFP_KERNEL);
> 	if (!rs) {
> 		rc =3D -ENOMEM;
> 		goto out_srv_fini;
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
