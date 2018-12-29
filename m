Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D31C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874F420869
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMfpU8Vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeL2Wah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 17:30:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45261 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeL2Wah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 17:30:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so11368694plm.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 14:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bd9fDX3wdZHp1sMZXkQG0K090i/MPkqqN+HNarvWHDg=;
        b=gMfpU8VxR+i43YtECs6ZWJ7fHllOZiz0VuTSLNg6XgL2ZLMvgTLQJdiffN7oISobBm
         T5zZzYF61st9iGecG2Ww75hEac9Z6zXx0uaNaT8gOroSxqRtfms5ODDBl0Ey4cbLqE7s
         V48z1ErMacl8gqOt6G8T6a+S1yzBDxlXjOz7xKXY7rInU08xZ64iFUjvTnQZ78hO07gr
         aJrBAiUt/ScWCMT0rU4wlRyaIIBD8aFRZEiz8Ng8Pw0kuE9ehXn2vnFwsS8bKNiAvmBZ
         McIPa9ZtfGmilBKSNkeB1DszTzh9AqYL1Mbd2tcLSaeCcHBdEVxw6S2rQU7v7pmEkxNK
         S6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Bd9fDX3wdZHp1sMZXkQG0K090i/MPkqqN+HNarvWHDg=;
        b=cpYlkfUePDUfRAZUj6Q5Dc0hc4aZoDL8kvDq/vcFDhugjBikYzdibctRQ6jej1vc2k
         wcYwE9yU5atOYcX5TfTCtkDuScVzK7rfkZO06zM2oOR41nzCf3MKl/0A3jMB31jNy8xv
         878/Ojt9xBco2//JChjAYxglFV/wTvl2Kk4sSvA8IErKpH9ha7Q9Ku3RtsaOf2cSL26S
         VWJY5w3P9UJNvb1oqDSM2KFeGhDadr6ul8E+2cVr9XKCIhpnHfC8zoQ+TBQCQhUNcMII
         5FC4o/U0sooGwGxZkwAl+IjXo8pOPilZ/Vo23WpG3a45doyBZjpTLXi2xaMpW0XysBYX
         rkKw==
X-Gm-Message-State: AJcUukcOGn+cwgKFlh9J1WuYX9jdTPFycG8iXBmvQ3hwCAZ6MLrvfEj5
        WfkUlghRg+w9c6lAUythM6c=
X-Google-Smtp-Source: ALg8bN6CzcUp3C3eGF2jJVBYz3F2iSGEZJSh2YQCjOR3OY3mh0EgzW0GVf66/iuY9jESohAmWZHY4w==
X-Received: by 2002:a17:902:7d82:: with SMTP id a2mr32610060plm.163.1546122635820;
        Sat, 29 Dec 2018 14:30:35 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id x27sm80122765pfe.178.2018.12.29.14.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Dec 2018 14:30:35 -0800 (PST)
Date:   Sat, 29 Dec 2018 12:30:33 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH 2/4] rcutorture/nolibc: fix some poor indentation and
 alignment
Message-ID: <20181229223033.q4gx4cn7ci6scysr@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Willy Tarreau <w@1wt.eu>, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20181229180218.15798-1-w@1wt.eu>
 <20181229180218.15798-3-w@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ooymwtdeubbwy536"
Content-Disposition: inline
In-Reply-To: <20181229180218.15798-3-w@1wt.eu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ooymwtdeubbwy536
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 29, 2018 at 07:02:17PM +0100, Willy Tarreau wrote:
> A few macros had their rightmost backslash misaligned, and the pollfd
> struct definition resisted the previous code reindent. Nothing else
> changed.
>=20
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

> ---
>  tools/testing/selftests/rcutorture/bin/nolibc.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/testing/selftests/rcutorture/bin/nolibc.h b/tools/test=
ing/selftests/rcutorture/bin/nolibc.h
> index 30bd27b..985364c 100644
> --- a/tools/testing/selftests/rcutorture/bin/nolibc.h
> +++ b/tools/testing/selftests/rcutorture/bin/nolibc.h
> @@ -81,9 +81,9 @@ typedef   signed long        time_t;
> =20
>  /* for poll() */
>  struct pollfd {
> -    int fd;
> -    short int events;
> -    short int revents;
> +	int fd;
> +	short int events;
> +	short int revents;
>  };
> =20
>  /* for select() */
> @@ -239,7 +239,7 @@ struct stat {
>  		"syscall\n"                                                   \
>  		: "=3Da" (_ret)                                                 \
>  		: "0"(_num)                                                   \
> -		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                     =
           \
> +		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
>  	);                                                                    \
>  	_ret;                                                                 \
>  })
> @@ -255,7 +255,7 @@ struct stat {
>  		: "=3Da" (_ret)                                                 \
>  		: "r"(_arg1),                                                 \
>  		  "0"(_num)                                                   \
> -		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                     =
           \
> +		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
>  	);                                                                    \
>  	_ret;                                                                 \
>  })
> @@ -272,7 +272,7 @@ struct stat {
>  		: "=3Da" (_ret)                                                 \
>  		: "r"(_arg1), "r"(_arg2),                                     \
>  		  "0"(_num)                                                   \
> -		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                     =
           \
> +		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
>  	);                                                                    \
>  	_ret;                                                                 \
>  })
> @@ -290,7 +290,7 @@ struct stat {
>  		: "=3Da" (_ret)                                                 \
>  		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
>  		  "0"(_num)                                                   \
> -		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                     =
           \
> +		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
>  	);                                                                    \
>  	_ret;                                                                 \
>  })
> --=20
> 2.9.0
>=20

--=20
Cheers,
Joey Pabalinas

--ooymwtdeubbwy536
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwn9YgACgkQ2rGdfm9D
tVJs7g//S+jTcccpthno9btNKaPE3RajcbJf1/vKAhPtyIe1IRJFKAFCJ9kPPSYt
TFsHrGq4Rs/kaNifR2at1ANJpUDV06e9rW8F6jqwB5MnP6ay8LPmQonzBECgQ0NB
R6HM4p3YaJCqRzO9rB62S8HUvy/R1pOnfqntzBjwAF6xXgbBSfYHWewx+45SAnK7
qY34BWXCWljNPKmftlQFdSBomu6XYpawzSi+7j1pT6JSVl44LkyUiomoRfx4iZfr
2Hn3t5KHx8AzBtpgnyzg5R+hnI9AoZqo+huXD4jXrTu4tKGts9AdvjygeHPA/Kx4
DRPs6NvdliH8bhMyyzGpCtqY569MHPpr6jH1FXfnjwBYaGGzPxjmJ68fyZ3Ja+q9
B7wsj0WO7EMd3WN8ZzOxyk2NsXrI6BSKPBBTzhHnVtyMjp8YHKl1goJ+rRBXUd68
A5ZwhA8N8giQ65FuD+HNPT4h/hFjgNkIJqZdknYObVW3VELv5JZSisRdq/5PqXuB
49DlSmdxx6PSrpP59rvDusxMTgSCQ2GwC766tBZOYxv0gSKJs9bYlEkds1DFlCQM
VMcCqmX7pFnzsCArbtD6Kyv/C+VkP9Bu99rw2A620E1DXVTcxRgqAoczp8sNf2VL
q+rrg1UkvrrluiqZordH00YYaAVda5cx2K1vhciLk+e2E1jSqAQ=
=NPhC
-----END PGP SIGNATURE-----

--ooymwtdeubbwy536--
