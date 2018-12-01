Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90676C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C8E206B7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZF0WNPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C8E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeLAM5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:57:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42720 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLAM5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:57:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so3240591pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 17:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXGxWvqHDEn+bvRyCRdxX3OiMj535codbapxqfSc1yM=;
        b=dZF0WNPa1VtzyEJ5EpHvHSuvmF1TrN+R3PLqVmPhSq9rKPa2M18VFxKwMDoD1pbt6z
         2mNzdz0fFI/NVvtHcEvC1EUHcYC2bweVqQ2ojqK4IMeNmXRjPk9V3IEywwfIOxYJY1UA
         IJo/8KauGMXHM/bCeqj68z7GJEGQKa1VZhuGvSmPI207LyumWHjXBBCrYdJomT6Z2waA
         lDa+55A5YggUphcvqdRr5WILJwRcHhyk2BdguOZymN2cFzh15l67l89f+RVKYBf6V0wF
         RWe8fXDnlJpRtwRc+hNE5Wm+bDXalsaNOKo2J+H/TL2jG9VkrnrkR0USo72r1r8QATqG
         wfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JXGxWvqHDEn+bvRyCRdxX3OiMj535codbapxqfSc1yM=;
        b=ZglhFlFWARAqhOgQ82l7vs3/6uZ2RwHW0La5U6LRFWIulcSF9c5KiAubp+wQgZuZLb
         iKY0IaxLQe7+hNCAa+ATCvViivNsFUfDGUrGXiPbrN80c7P4ePkQ+xebZ5HDeD7vzOR+
         V6CCb1Yvhoxm3S/52nmQ9281mKIwN4OZWJSr8JbcDbGc2I4Qt7f5NGIVqhYGUEt4Dcjc
         OnTiMSsMQSm/BkwJtpTmYE/nX0g99qdNrfQjpyJDh3lJuRx+boPuIIl8g+ebEP8LkFae
         +sfP96kQHa62QCqT+H9JsLmcWXGjb6XJ4V2ZJtNROYkUiXCRPxs4n6GbRntkIsyH7WUN
         5L0Q==
X-Gm-Message-State: AA+aEWZ865dnsOYtKxaAnAMqKYxu8436OshLPBc6G9AXhu6vsQCjLltl
        4yVW4h2Jujhn8EsZtU0Fy7o=
X-Google-Smtp-Source: AFSGD/UaCd2784FdmyK2WxoztCFUk5VTNprtsXDn1g8ODbmK1QT0iRh1Y44OwziR7LS9+xYCP/0gnA==
X-Received: by 2002:a62:75d1:: with SMTP id q200mr7794497pfc.254.1543628788219;
        Fri, 30 Nov 2018 17:46:28 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id x3sm20552627pgt.45.2018.11.30.17.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 17:46:27 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:46:24 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] binder: remove BINDER_DEBUG_ENTRY()
Message-ID: <20181201014624.7ukgr6e2c5msajzq@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181201012630.4459-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aenzoeexw3i3nwa4"
Content-Disposition: inline
In-Reply-To: <20181201012630.4459-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aenzoeexw3i3nwa4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 08:26:30PM -0500, Yangtao Li wrote:
> We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
> such a macro,so remove BINDER_DEBUG_ENTRY.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Good catch.

Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

On Fri, Nov 30, 2018 at 08:26:30PM -0500, Yangtao Li wrote:
> We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
> such a macro,so remove BINDER_DEBUG_ENTRY.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/android/binder.c | 48 ++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index cb30a524d16d..5496b8e07234 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -94,22 +94,8 @@ static struct dentry *binder_debugfs_dir_entry_root;
>  static struct dentry *binder_debugfs_dir_entry_proc;
>  static atomic_t binder_last_id;
> =20
> -#define BINDER_DEBUG_ENTRY(name) \
> -static int binder_##name##_open(struct inode *inode, struct file *file) \
> -{ \
> -	return single_open(file, binder_##name##_show, inode->i_private); \
> -} \
> -\
> -static const struct file_operations binder_##name##_fops =3D { \
> -	.owner =3D THIS_MODULE, \
> -	.open =3D binder_##name##_open, \
> -	.read =3D seq_read, \
> -	.llseek =3D seq_lseek, \
> -	.release =3D single_release, \
> -}
> -
> -static int binder_proc_show(struct seq_file *m, void *unused);
> -BINDER_DEBUG_ENTRY(proc);
> +static int proc_show(struct seq_file *m, void *unused);
> +DEFINE_SHOW_ATTRIBUTE(proc);
> =20
>  /* This is only defined in include/asm-arm/sizes.h */
>  #ifndef SZ_1K
> @@ -4964,7 +4950,7 @@ static int binder_open(struct inode *nodp, struct f=
ile *filp)
>  		proc->debugfs_entry =3D debugfs_create_file(strbuf, 0444,
>  			binder_debugfs_dir_entry_proc,
>  			(void *)(unsigned long)proc->pid,
> -			&binder_proc_fops);
> +			&proc_fops);
>  	}
> =20
>  	return 0;
> @@ -5592,7 +5578,7 @@ static void print_binder_proc_stats(struct seq_file=
 *m,
>  }
> =20
> =20
> -static int binder_state_show(struct seq_file *m, void *unused)
> +static int state_show(struct seq_file *m, void *unused)
>  {
>  	struct binder_proc *proc;
>  	struct binder_node *node;
> @@ -5631,7 +5617,7 @@ static int binder_state_show(struct seq_file *m, vo=
id *unused)
>  	return 0;
>  }
> =20
> -static int binder_stats_show(struct seq_file *m, void *unused)
> +static int stats_show(struct seq_file *m, void *unused)
>  {
>  	struct binder_proc *proc;
> =20
> @@ -5647,7 +5633,7 @@ static int binder_stats_show(struct seq_file *m, vo=
id *unused)
>  	return 0;
>  }
> =20
> -static int binder_transactions_show(struct seq_file *m, void *unused)
> +static int transactions_show(struct seq_file *m, void *unused)
>  {
>  	struct binder_proc *proc;
> =20
> @@ -5660,7 +5646,7 @@ static int binder_transactions_show(struct seq_file=
 *m, void *unused)
>  	return 0;
>  }
> =20
> -static int binder_proc_show(struct seq_file *m, void *unused)
> +static int proc_show(struct seq_file *m, void *unused)
>  {
>  	struct binder_proc *itr;
>  	int pid =3D (unsigned long)m->private;
> @@ -5703,7 +5689,7 @@ static void print_binder_transaction_log_entry(stru=
ct seq_file *m,
>  			"\n" : " (incomplete)\n");
>  }
> =20
> -static int binder_transaction_log_show(struct seq_file *m, void *unused)
> +static int transaction_log_show(struct seq_file *m, void *unused)
>  {
>  	struct binder_transaction_log *log =3D m->private;
>  	unsigned int log_cur =3D atomic_read(&log->cur);
> @@ -5735,10 +5721,10 @@ static const struct file_operations binder_fops =
=3D {
>  	.release =3D binder_release,
>  };
> =20
> -BINDER_DEBUG_ENTRY(state);
> -BINDER_DEBUG_ENTRY(stats);
> -BINDER_DEBUG_ENTRY(transactions);
> -BINDER_DEBUG_ENTRY(transaction_log);
> +DEFINE_SHOW_ATTRIBUTE(state);
> +DEFINE_SHOW_ATTRIBUTE(stats);
> +DEFINE_SHOW_ATTRIBUTE(transactions);
> +DEFINE_SHOW_ATTRIBUTE(transaction_log);
> =20
>  static int __init init_binder_device(const char *name)
>  {
> @@ -5792,27 +5778,27 @@ static int __init binder_init(void)
>  				    0444,
>  				    binder_debugfs_dir_entry_root,
>  				    NULL,
> -				    &binder_state_fops);
> +				    &state_fops);
>  		debugfs_create_file("stats",
>  				    0444,
>  				    binder_debugfs_dir_entry_root,
>  				    NULL,
> -				    &binder_stats_fops);
> +				    &stats_fops);
>  		debugfs_create_file("transactions",
>  				    0444,
>  				    binder_debugfs_dir_entry_root,
>  				    NULL,
> -				    &binder_transactions_fops);
> +				    &transactions_fops);
>  		debugfs_create_file("transaction_log",
>  				    0444,
>  				    binder_debugfs_dir_entry_root,
>  				    &binder_transaction_log,
> -				    &binder_transaction_log_fops);
> +				    &transaction_log_fops);
>  		debugfs_create_file("failed_transaction_log",
>  				    0444,
>  				    binder_debugfs_dir_entry_root,
>  				    &binder_transaction_log_failed,
> -				    &binder_transaction_log_fops);
> +				    &transaction_log_fops);
>  	}
> =20
>  	/*
> --=20
> 2.17.0
>=20

--=20
Cheers,
Joey Pabalinas

--aenzoeexw3i3nwa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwB5+8ACgkQ2rGdfm9D
tVLhphAAsBmrt1cSnwvaCThNuz/NLMwDiZ8l+Rez5KydpAkZ3nVfdNZBu4gFiGeI
5HFZM7wpiKJToCqXtfEfCSBTxt9g7vhEfwItr49vpV74SFxcfVEET32KFVPDR1Qj
2wJ/M4Zou7CmvspZ61h/MA79cqrEU9CyYWzGu3wbjhZg0xJhATR2xIAMCVWpCPkS
tTmd3/8P19yBN5c60YdIRriT5Mg5nE9eNdTIi8GyBVZj8iWHJBjqRXPAaEuVC18f
Km54+QZzsN0OvoM7NO1PQ18CQvvwqF+pkqJxoqpc6IK9G4DCb22Bid34VFtCL8PZ
62CYBVmqhZ7laLADPE690Onlj8j4NrWQkAgLkaPpiGEEqRSZm6AnAZ8eo8W12wN9
2QsBU0WF/g4+YbI/RRxq2/J9Z5N6xn8RUoBGdoRMSBJc/bUO4ukoB9ogAmp2jKKl
FFQLvUiDSgptszI1hpaBmLZsWmkMs/hqANkDRxKC8/42Isgh8KLZUgtUWu3a0R3s
Uyxoi6TC8FGcV8/vUxNIC5Ift1IKrxtBS7la8yt6wRKpsJDAx1efTsjQrCwm6/v4
Zwh0qU+UVB9KyTs/tLsRu/5f6QrvSZK3uvIqIgqtKePDb/U9l477rPYkLifk695b
4c0tvUGMPjczabD19K5Hoz/DtI2e4KoP/TcZoQ6N4AnUc24UOmw=
=NMOf
-----END PGP SIGNATURE-----

--aenzoeexw3i3nwa4--
