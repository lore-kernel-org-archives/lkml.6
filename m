Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84C3C6369F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1C12085B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzhVzUA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfATJAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 04:00:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33399 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbfATJAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 04:00:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so3944394wmh.0;
        Sun, 20 Jan 2019 01:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7P1wAuu3GXSAiExKI7V0UM9oB45p9s208bi5DpUAo3M=;
        b=qzhVzUA8xlZI6BttzeYOt3FscVeqvqqKpqNOVgtar2XjkXHW+UBXFTrElKxcYy7ZXr
         gOLuPBp5NUd/HSOQZkDo6LqMEnDE+gKIdr10YehrKo7TaQpL8sAuDObWjKbQsUR0i8nI
         s/oK44gnpS2AMTUBTvNHtsTKOMAyNyT9itfJVFdGAc6cnznkWyEaTBOVURuQfSEZvfIL
         G7VyOrSj2R/6GSgLA3uAYoCHUSQyS+Oo9aTDzkn7s7jslpMVPei9FQSxZrTnXKC6mPjD
         6flZJa6hsJLQQso7XR8o8DJhhyKLix3l3z3ONytpq+esU7HL0nAZQ6gvjO+noYCNsYKx
         vQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7P1wAuu3GXSAiExKI7V0UM9oB45p9s208bi5DpUAo3M=;
        b=GhKsg8XcfVfzTwpNUGNJ3IHXbOHTtr5GTBltyZeYLY+TJq1IvBuSbhjCDWC9SESPBt
         8xBWJ9iwqmFvpfnm2CXSDbHimfRIjw5XMor3warPelftv1+/nBBTbM14QUlypaiiWtd+
         A7Fr2uVzgngpz8Fn6Dvvb9T+gSxEMTQN/LRVSKsLBb8XUibbQesBpBF0rA/LAh1V0Ej8
         S+vJfXlD61xO/ulLBnoyDZ51bOLDYaLx/iV5GZLdVrj+TjcDpiEaDx9PBAso84rU8hMg
         lbGflWoQ+mzL5UzScv6Dj+HEyqDcuqB2OYCEwYigtxgvuHdgZBTe32Z8YjiWEu60HpWA
         IB7g==
X-Gm-Message-State: AJcUukeP88J7FUYQglmOB70/k2b7Tf0wu5OrNaW8PbKi3HDTBEXdFsIH
        T1csnYypn0mL9WcUyP/Vt/+xPTGS
X-Google-Smtp-Source: ALg8bN7l6fvdzmCEn0O2VA1hnMAcOlYNKbcAErHvJSxVxp1Ridz85FosJj64e7EajaL+yltk458DRA==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr19485915wmj.0.1547974804792;
        Sun, 20 Jan 2019 01:00:04 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i186sm58315347wmd.19.2019.01.20.01.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 01:00:03 -0800 (PST)
Date:   Sun, 20 Jan 2019 10:00:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] platform/x86: wmi: add WMI support to
 MODULE_DEVICE_TABLE()
Message-ID: <20190120090002.imufwdnvtufjgoxh@pali>
References: <cover.1547827336.git.2pi@mok.nu>
 <ff56fb53485ec75b5e8a81f306983aa7976574c5.1547827336.git.2pi@mok.nu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ep2rclsk66ehzbgb"
Content-Disposition: inline
In-Reply-To: <ff56fb53485ec75b5e8a81f306983aa7976574c5.1547827336.git.2pi@mok.nu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ep2rclsk66ehzbgb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 19 January 2019 12:55:54 Mattias Jacobsson wrote:
> Add WMI support to MODULE_DEVICE_TABLE() by adding info about struct
> wmi_device_id in devicetable-offsets.c and add a WMI entry point in
> file2alias.c.
>=20
> The type argument for MODULE_DEVICE_TABLE(type, name) is wmi.
>=20
> Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
> ---
>=20
> The idea of adding wmi support to MODULE_DEVICE_TABLE() originates from
> a suggestion at [1].

Thanks for implementation!

> However [2] states: "Please note that this tag
> should not be added without the reporter's permission, especially if
> the idea was not posted in a public forum." about the "Suggested-by:"
> tag.
> Pali Roh=C3=A1r: May I add a "Suggested-by:" tag?

Yes, you can!

> [1]: https://lore.kernel.org/patchwork/patch/795892/#989423
> [2]: Documentation/process/submitting-patches.rst
>=20
> ---
>  scripts/mod/devicetable-offsets.c |  3 +++
>  scripts/mod/file2alias.c          | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-=
offsets.c
> index 293004499b4d..99276a422e77 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -225,5 +225,8 @@ int main(void)
>  	DEVID_FIELD(typec_device_id, svid);
>  	DEVID_FIELD(typec_device_id, mode);
> =20
> +	DEVID(wmi_device_id);
> +	DEVID_FIELD(wmi_device_id, guid_string);
> +
>  	return 0;
>  }
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index a37af7d71973..f014a2466ff7 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1287,6 +1287,23 @@ static int do_typec_entry(const char *filename, vo=
id *symval, char *alias)
>  	return 1;
>  }
> =20
> +/* Looks like: wmi:guid */
> +static int do_wmi_entry(const char *filename, void *symval, char *alias)
> +{
> +	DEF_FIELD_ADDR(symval, wmi_device_id, guid_string);
> +	if (strlen(*guid_string) !=3D WMI_GUID_STRING_LEN) {
> +		warn("Invalid WMI device id 'wmi:%s' in '%s'\n",
> +				*guid_string, filename);
> +		return 0;
> +	}
> +	if (snprintf(alias, 500, WMI_MODULE_PREFIX "%s", *guid_string) < 0) {
> +		warn("Could not generate all MODULE_ALIAS's in '%s'\n",
> +				filename);
> +		return 0;
> +	}
> +	return 1;
> +}
> +
>  /* Does namelen bytes of name exactly match the symbol? */
>  static bool sym_is(const char *name, unsigned namelen, const char *symbo=
l)
>  {
> @@ -1357,6 +1374,7 @@ static const struct devtable devtable[] =3D {
>  	{"fslmc", SIZE_fsl_mc_device_id, do_fsl_mc_entry},
>  	{"tbsvc", SIZE_tb_service_id, do_tbsvc_entry},
>  	{"typec", SIZE_typec_device_id, do_typec_entry},
> +	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
>  };
> =20
>  /* Create MODULE_ALIAS() statements.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ep2rclsk66ehzbgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXEQ4jwAKCRCL8Mk9A+RD
Ut4UAJ9AQad7lLnB6TGKD3SvcQMDxn2mXACeI0niLpxaZfAEh0s1M5F6yIbBMDo=
=qKIk
-----END PGP SIGNATURE-----

--ep2rclsk66ehzbgb--
