Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELs+4DLFHr5Z3lj7P0EjxolBjIOVz23XqWYr9DM54YVMECg7UQZlLh+KXPtLljPq3AikgNgE
ARC-Seal: i=1; a=rsa-sha256; t=1520457019; cv=none;
        d=google.com; s=arc-20160816;
        b=sen+qa7+Mg+2lh4AnlqYc29hyq0jh6B1wPugv7/yKF+BZ+E3c7OQAD4aF199XvaNAL
         bR9oc6LQjQw/8FqvzoMPagTGTF993FMLxx1p0EB7daZ4KVuoBaQ9q+m/8lIyhf0eJTV7
         4rTclN4Z/bj/8AvidEVwRJ1jroB5ehfe9OQkc+pxDNaNmEbmriUIS4U/WUnzEDwBcR12
         G36umQF2HUE6n0v9xdeLLUFQHuULiwAuO9mzc5DDcm822iXtyd4wiji8RwP+jfpfzMZK
         Tg+4fOv//UaRfygoWtKIgHzOFVcNOUk9c6kecIJ0YuiftDfuW9Of1WaVq/t3XyOIYBht
         fAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=yjYVMuyXdN0GcFaVGQhfn9cdeuH+BCOsmt89MzhNeDc=;
        b=pRGTQyo0LLY4G96+DajW5Q5ZOwM39WjS77wYrlExhRqhY92XFRLkjinhh4NwVjdi/G
         Nbsn6T5I/UGNmW+N2Oc/WKGFtZ0szBZJ1zSnL2QNybCZpY6UJ3on/FI0DiQOshGhkcRd
         CzCOsBCzRIKNT5BnXVzAEhL6ghp/yb1xFAY3axGH9e0/jBFzO46tix25y4toRISSx5pU
         1srikFbecqVRbKRO26R53jGKhZ0PTcD5QBbPqRU2Vdcn4NctdNdV5S8zX7RViO3g9cBM
         mTUJ1+Y1ZcyAYH6Q3IMqhB6T1trzvricn0oL7NSHNs7OI+USWrTJL3o1SNjCwfEKeBEP
         GaeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="209668885"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 04/17] staging: lustre: obdclass: don't require
 lct_owner to be non-NULL.
Thread-Topic: [PATCH 04/17] staging: lustre: obdclass: don't require
 lct_owner to be non-NULL.
Thread-Index: AQHTsbWZEU9W0VVzmkufKJTNHAVNgKPF1BGA
Date: Wed, 7 Mar 2018 21:10:16 +0000
Message-ID: <09E84FB8-BF65-4D08-BAB1-8C2AEC85B3B2@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708517.7628.10169180583984336095.stgit@noble>
In-Reply-To: <151994708517.7628.10169180583984336095.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.6.233]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBA7919C1530BB48B5EBC2B63AE257BC@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780115063763673?=
X-GMAIL-MSGID: =?utf-8?q?1594314739306120338?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> Some places in lu_object.c allow lct_owner to be NULL, implying
> that the code is built in to the kernel (not a module), but
> two places don't.  This prevents us from building lustre into
> the kernel.
>=20
> So remove the requirement and always allow lct_owner to be NULL.
>=20
> This requires removing an "assert" that the module count is positive,
> but this is redundant as module_put() already does the necessary test.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/obdclass/lu_object.c |    7 +------
> 1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers=
/staging/lustre/lustre/obdclass/lu_object.c
> index cca688175d2d..880800e78c52 100644
> --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
> +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
> @@ -1380,12 +1380,8 @@ static void key_fini(struct lu_context *ctx, int i=
ndex)
> 		lu_ref_del(&key->lct_reference, "ctx", ctx);
> 		atomic_dec(&key->lct_used);
>=20
> -		if ((ctx->lc_tags & LCT_NOREF) =3D=3D 0) {
> -#ifdef CONFIG_MODULE_UNLOAD
> -			LINVRNT(module_refcount(key->lct_owner) > 0);
> -#endif
> +		if ((ctx->lc_tags & LCT_NOREF) =3D=3D 0)
> 			module_put(key->lct_owner);
> -		}
> 		ctx->lc_value[index] =3D NULL;
> 	}
> }
> @@ -1619,7 +1615,6 @@ static int keys_fill(struct lu_context *ctx)
> 			LINVRNT(key->lct_init);
> 			LINVRNT(key->lct_index =3D=3D i);
>=20
> -			LASSERT(key->lct_owner);
> 			if (!(ctx->lc_tags & LCT_NOREF) &&
> 			    !try_module_get(key->lct_owner)) {
> 				/* module is unloading, skip this key */
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
