Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AB8JxZok/EC0OqGft/Lut+1FOoCHvZ4Pcg7rM3xsHxeIf7mSPjEGwYcYtA8kYZonmae8/fLrGJMU
ARC-Seal: i=1; a=rsa-sha256; t=1526113972; cv=none;
        d=google.com; s=arc-20160816;
        b=dpRJmCBPeQJIaO8j2pRT9ODwrJBwpGbDrHY5jdshy9BVdQwn/1lllSOmp4VQetiCWZ
         xRsK+GSB6TrPDzZ4kFSahYu260+lJ3Y/Sjfgdj47t2X41g6UmlXxbTUcT7SeOyJqz/nK
         IlOgOty/I+fdldZsK+sp3DO1y1lenbnZJrFA2afhZqDisRRa5TTdSyZZtMitn6rSbQqu
         HkSuCdggs4ET2iYZQbJdQ8e9x92lp0CNNw8HsP1eOIHYHmyqbrisAsOEf6EIpFpectzK
         wtshxS+62l8mofJGjgoJmt27wXjhfFnvAnrK8EXYrc2yW4UtHBXrchdR0QQLM10o4685
         20tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=P55w9M0lBL1b5u1NuFXMbd3jcqgmlTkdzOqo7XGe4TU=;
        b=bUZemLnqhvKs3fwrcmD+jG+BPj4Ju9qVSipmc9xiAJQ1vjEXTfvxSqdzB7T9zBvHzh
         iwMCyg3okkk2CtfSRokiLqhJhkTDOuYi5wCMdbalVTirnMOecVHp57LipF0YN7dCM1hF
         fyGU2DS2X36OXYb/IRp+pGbdFzE/8yX7K9t8VeVrvmxBxpnCUHxhAGigxkxprcs9V0tJ
         eIM/tAvqfBsOIl1SlqadbUCD7OaPGwP/saZESElGdLVnWI1USwCHsJXk8GEyXUc6c33b
         5AZt2fq17OVhDnD+qyFmkUjex/2RfVYEEvFXB9FQyapGXhwjUJfkLbe6pqHUmPKlvsyQ
         t3kw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,391,1520924400";
   d="scan'208";a="38741805"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, James Simmons
	<jsimmons@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	NeilBrown <neilb@suse.com>, "aastha.gupta4104@gmail.com"
	<aastha.gupta4104@gmail.com>, "santhameena13@gmail.com"
	<santhameena13@gmail.com>, "devel@driverdev.osuosl.org"
	<devel@driverdev.osuosl.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lustre-devel@lists.lustre.org"
	<lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH] staging: lustre: Fix an error handling
 path in 'client_common_fill_super()'
Thread-Topic: [lustre-devel] [PATCH] staging: lustre: Fix an error handling
 path in 'client_common_fill_super()'
Thread-Index: AQHT6bsXYp6G7L/s/kaRQD/naUwLdaQsOYGA
Date: Sat, 12 May 2018 08:32:50 +0000
Message-ID: <21FD761A-0604-41B2-869C-1A1276732D3B@intel.com>
References: <20180512063305.7339-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20180512063305.7339-1-christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.11.24]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4FBFBFB0958074BBF90A2556E8CEA8A@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600238944812579169?=
X-GMAIL-MSGID: =?utf-8?q?1600246484733073508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On May 12, 2018, at 00:33, Christophe JAILLET <christophe.jaillet@wanadoo.f=
r> wrote:
>=20
> According to error handling path before and after this one, we should go
> to 'out_md_fid' here, instead of 'out_md', if 'obd_connect()' fails.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Good catch.

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> The last goto 'out_lock_cn_cb' looks spurious but is correct.
> In case of error, 'd_make_root()' performs a 'iput()', so skipping it in
> the error handling path lokks fine to me.
> ---
> drivers/staging/lustre/lustre/llite/llite_lib.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/st=
aging/lustre/lustre/llite/llite_lib.c
> index 60dbe888e336..83eb2da2c9ad 100644
> --- a/drivers/staging/lustre/lustre/llite/llite_lib.c
> +++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
> @@ -400,11 +400,11 @@ static int client_common_fill_super(struct super_bl=
ock *sb, char *md, char *dt)
> 		LCONSOLE_ERROR_MSG(0x150,
> 				   "An OST (dt %s) is performing recovery, of which this client is no=
t a part.  Please wait for recovery to complete, abort, or time out.\n",
> 				   dt);
> -		goto out_md;
> +		goto out_md_fid;
> 	} else if (err) {
> 		CERROR("%s: Cannot connect to %s: rc =3D %d\n",
> 		       sbi->ll_dt_exp->exp_obd->obd_name, dt, err);
> -		goto out_md;
> +		goto out_md_fid;
> 	}
>=20
> 	sbi->ll_dt_exp->exp_connect_data =3D *data;
> --=20
> 2.17.0
>=20
> _______________________________________________
> lustre-devel mailing list
> lustre-devel@lists.lustre.org
> http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
