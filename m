Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36221C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19322145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp1TukoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19322145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeIXRyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:54:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35068 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbeIXRys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:54:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id o18-v6so9752456wmc.0;
        Mon, 24 Sep 2018 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZxxS0CQy2jSyQH2Vbclfha+43ywmWWXZy81lc7+fokc=;
        b=gp1TukoWZVf08zVO2efbbsDF2aLy7cGWQQ2n11pRcNLyOqyzpe6yuw1PGlV6tgyFqR
         BWEwXiQYrezmRNDJiGCQawnC4N3NLfNkMC1Cqqb3/Lb7U45IDq/hiozG42l/15xvYn2h
         5Ht5BMMpDpzrvF+wtGr4ho6Xd6WcfrCuPa5wE+3EwQ9JM2aDicrg15ieAPPZCq+OJSn7
         qdqIkxmIEXW7TQEiRGrPz1ePKvguTk56R+7ba/XEdnUgMXMAs3aRujedQJYUTvzQbIUU
         2ZImm408nwIpl4+qWTaLa8f3M8W7JryNjTNMRGd3RuZtY3DRyJHBfomFphxXU/AtMycX
         bckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZxxS0CQy2jSyQH2Vbclfha+43ywmWWXZy81lc7+fokc=;
        b=bUPxnyY9DiZLXgEbj9dVtGFh7hhWjHFPapVo1pHiZcChlILlnuZPgYq9zDZy6VKhpR
         Vx9WwqwdY6mrGJPaOiuiKC9hqZZA+Jemgrj9Eo/7B2gbtgHVzoT1vqKUptdcDIFcZjJC
         D8MZ45fo3LHmJAA2E1yE7NW308QxYqtz2apEuOooKHLdaloCE24NHO9ukBMTRL0L9NL8
         maeoYr2Ru9oSiCWTZvBfEi3nEV67RrnRWSSAYw9QjGx6g4pRrpo6ING/jNJ6rNgjQOWw
         +FiJbZfTi45sJhpdGKsfoBDyB2mzNUI3v0Fx6aagNsDLuNB+PorO8ekibOGNeOKIsKAy
         UTgg==
X-Gm-Message-State: APzg51CQa5PQw6lXTE9Ad/IPgpFp27TwuLg3vr95qBlBM9LRty1Tgm05
        OX9re2b01wCQ5oH9wHqo8hs=
X-Google-Smtp-Source: ACcGV60I6kZYAlM4Jmfa7IkE+7odjLUN9wQ7fEAXp1BQJB1XoltG4CS0PbbTX412qDZk+GzKEfdDkQ==
X-Received: by 2002:a1c:6386:: with SMTP id x128-v6mr6800767wmb.104.1537789982580;
        Mon, 24 Sep 2018 04:53:02 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id s10-v6sm21289889wmd.22.2018.09.24.04.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 04:53:01 -0700 (PDT)
Date:   Mon, 24 Sep 2018 13:53:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     stefan.wahren@i2se.com, gohai@sukzessiv.net,
        hsweeten@visionengravers.com, gottfried.haider@gmail.com,
        loic.pallardy@st.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in
 sysfs"
Message-ID: <20180924115301.GV21032@ulmo>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3a/Z8KDuKqDOIvAo"
Content-Disposition: inline
In-Reply-To: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3a/Z8KDuKqDOIvAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 04:02:47PM +0200, Fabrice Gasnier wrote:
> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it causes
> regression with multiple pwm chip. It creates a new entry in
> '/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > export':
> - 1st time export will create an entry in /sys/class/pwm/pwmX
> - when another export happens on another pwmchip, it can't be created
> (e.g. -EEXIST)
>=20
> This also changes existing ABI (Documentation/ABI/testing/sysfs-class-pwm=
):
> - pmwX should be there: /sys/class/pwm/pwmchipN/pwmX
>=20
> Example on stm32 (stm32429i-eval) platform:
> $ ls /sys/class/pwm
> pwmchip0 pwmchip4
>=20
> $ cd /sys/class/pwm/pwmchip0/
> $ echo 0 > export
> $ ls /sys/class/pwm
> pwm0 pwmchip0 pwmchip4
>=20
> $ cd /sys/class/pwm/pwmchip4/
> $ echo 0 > export
> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> ...Exception stack follows...
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/sysfs.c | 1 -
>  1 file changed, 1 deletion(-)

Can we come up with an alternative that allows us to have both? We want
uevent and proper sysfs creation, or is that not possible?

Thierry

--3a/Z8KDuKqDOIvAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluo0BwACgkQ3SOs138+
s6EHUw//XihD4PTiYRbp2BgEONYQVv9olCZpDV9XeDuhhEp7ejTEp9cDDzfuT/nJ
gMEWrVvzykDiL+x4YwknSNOif9ID4dctHsgky8obwHjkwCnbL7JpZg7z3wf6JVpP
ZGx2TJzKP5bxnogpdT8pPf6o0rraaGKfsF6VjNk/Br/Q1+Fok5dQlOVq+koK+awi
B5MeVTp7HkeM28H0GKB+W949cnm+c151atfUaqUTDiNr5m3sPddt66YOoAdacp2g
HRyn5SoXgifc8g/BiOLCbdJ6jkVE8/J024nmX5ocVjKmp3RPpbmNZcSP/UYfhCps
wApPJWlQZi6Mcog+oDVkHSgwYnSe8qpjTS5i1IYXedxt53DMpG+lb4W39+ri6AQ9
erpzlVS54Q96AUjNEy5pTFWz2bjCLbWqthw5N1eQdQ03k6N0AiMioWo/mMOlFdIq
TZ0OR9fERejWbdqmPwEJmFp++ArM1FGgezWoBOUXtSeu7tg1f/dTI1SHHdWN2n4Y
caozOKJkZvDcDlUNEtx46aRFCQsXz24D3B98Hc1ke8VW7JJcSY2O0gFfq/oppy4J
6IfDznypkzTX7OkroXxZrzxm9ScpoUitW3q+fyMNhpScnyx9Run4/0kDFLEpfKpi
ITterfo9MsyQqvwROIVWIv5i3QtwfaWBXrU1/u5IhcHIFzjOrPs=
=wDcO
-----END PGP SIGNATURE-----

--3a/Z8KDuKqDOIvAo--
