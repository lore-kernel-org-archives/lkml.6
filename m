Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D2BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B585321480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcRxbbsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B585321480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbeIXUZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:25:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37237 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeIXUZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:25:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so19868790wrr.4;
        Mon, 24 Sep 2018 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Si0/x9SME+yYiJCX7KylcChYCVre+6JeZ3GeFVRFZ08=;
        b=KcRxbbsWO6BJTXLbBBuKVwgGIcz39DhLaTEWKE1ht0lOevmVzaUQw5Z0V6YeE7073r
         aq7aR+pXT5OaFuxbyk07vJy+wsCZ5B9Z2WrrZuiM9AbLq0K6i/EQ5e1/wPfPnGgWOzOe
         sn5JtDN+S3d0rGIPNc6eWtkP8xrH4Wp1LbMubK3+ysb9EmLqSf1cuvfkBtpF1CSN7wyz
         i9PRTrm9t/uCCM3FEX/2Dw7zEoRvZHReXCn9Yl+j/XDSpK9/BxA2HGLQI0EnnuamKEx0
         EeGIek9+IBQqdQ3vVGiP+EQPCdrwhj7Ur5dYYZKovFH23iAcJdAdJjyvUPv666Be87bV
         RBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Si0/x9SME+yYiJCX7KylcChYCVre+6JeZ3GeFVRFZ08=;
        b=Keat++dh0Lj5DnUp50TnA1znq0aSKtPNpoUtGV1/m1odF2TJbc6U6Lt2evUP5KHhNV
         YCZdjl4PtoVlrmeo2sw//jmsmeOsqGmpn6A1/ECrP7gAI8PbTB4h12Z0fHwDzAuXk3Bt
         GTCc/xoog99HrcYY7ZpY7ciCtVouXZXMTziAf4zRWYDexb/UZWJDYnbyYdcVbWBSVy/q
         fZGnFXi+MhKvXHAn3XesT7bAt5gsmMVL78OmFp3L5pgJVoRhjk5gaGQx64SNzc/sAxQK
         VBSJ/67n6FE9nSXsBfVKp5klabOjeLa6jLbwzhEjB76J1c9Tc6Jhn81f60GYXeZPkdRx
         8VLQ==
X-Gm-Message-State: ABuFfojRBqGBez84VLSsPk+7Y8MvdX7YqDQXYbnlN0C3nG3Ahbw8FIGD
        kwK1Xr8fpS234UuKqNWkEW0=
X-Google-Smtp-Source: ACcGV61Ixzlqpyk1r3mhSMEyfLTqV50w8rVsSqwTg8oWU9Eu4SdTG3qif/UJ3u0bg29lXOWrHBe8QQ==
X-Received: by 2002:adf:fe06:: with SMTP id n6-v6mr9169169wrr.171.1537799000121;
        Mon, 24 Sep 2018 07:23:20 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id x204-v6sm13237977wmg.27.2018.09.24.07.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 07:23:19 -0700 (PDT)
Date:   Mon, 24 Sep 2018 16:23:18 +0200
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
Message-ID: <20180924142318.GG23547@ulmo>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
 <20180924115301.GV21032@ulmo>
 <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
Content-Disposition: inline
In-Reply-To: <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:59:03PM +0200, Fabrice Gasnier wrote:
> On 09/24/2018 01:53 PM, Thierry Reding wrote:
> > On Fri, Sep 21, 2018 at 04:02:47PM +0200, Fabrice Gasnier wrote:
> >> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it cau=
ses
> >> regression with multiple pwm chip. It creates a new entry in
> >> '/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > export=
':
> >> - 1st time export will create an entry in /sys/class/pwm/pwmX
> >> - when another export happens on another pwmchip, it can't be created
> >> (e.g. -EEXIST)
> >>
> >> This also changes existing ABI (Documentation/ABI/testing/sysfs-class-=
pwm):
> >> - pmwX should be there: /sys/class/pwm/pwmchipN/pwmX
> >>
> >> Example on stm32 (stm32429i-eval) platform:
> >> $ ls /sys/class/pwm
> >> pwmchip0 pwmchip4
> >>
> >> $ cd /sys/class/pwm/pwmchip0/
> >> $ echo 0 > export
> >> $ ls /sys/class/pwm
> >> pwm0 pwmchip0 pwmchip4
> >>
> >> $ cd /sys/class/pwm/pwmchip4/
> >> $ echo 0 > export
> >> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> >> ...Exception stack follows...
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >> ---
> >>  drivers/pwm/sysfs.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >=20
> > Can we come up with an alternative that allows us to have both? We want
> > uevent and proper sysfs creation, or is that not possible?
>=20
> Hi Thierry, all,
>=20
> With current approach:
> - "export->child.class =3D parent->class"
> - ABI (e.g. "pwm%d") device name isn't unique with multiple pwm chip.
> I think this is not possible.
>=20
> Trying to think of an alternative... I just did a quick test, by
> changing device name, to take pwmchip into account:
> +       export->child.class =3D parent->class;
>         export->child.release =3D pwm_export_release;
>         export->child.parent =3D parent;
>         export->child.devt =3D MKDEV(0, 0);
>         export->child.groups =3D pwm_groups;
> -       dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
> +       dev_set_name(&export->child, "pwmchip%d-pwm%u", chip->base,
> pwm->hwpwm);
>=20
> But this also impacts existing ABI :-(
> Would you have suggestions to send an uevent, without modifying ABI ?

I don't quite understand why, in the example you show in the commit
message, the pwmX nodes appear in the top-level /sys/class/pwm
directory. According to Documentation/ABI/testing/sysfs-class-pwm they
should appear as /sys/class/pwm/pwmchipN/pwmX. I can only imagine that
setting the class may have changed that. If so, perhaps we can
workaround that by creating a new class that is not parent->class?

Thierry

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluo81YACgkQ3SOs138+
s6GxAA//WkdXn0Zu2emfyYspUknO2Yb9looGZZElPqNLt0YPaWPcryc8JSxRE5p/
aE31wGjwOK6eHRWgqWI18XC0W/67yyzF9MgzzcM39JW+ApM1OfEOShItNj8Xs1aS
/9GgndxL2NpaSxkIiZJd/yhJOYMIQtyvpuy+0ealFLB+XNah2jW8r9I07xD+bWwL
UjLIA2cB/o8kdTuxF0aOW0nG4j/O74hI+ctyFqobPFEG7+ggtLgCqLhZvEydD5g1
tItLAcR73YQ9ZLWunePCdJIAiKY6eaITCaLyYR35pFHMSC5vHp9M1maqHQpsGtjA
602kPP3em0UOr+92421mIjYWwgR08d03TKtzOMn0g2lvKVmPIbxrv5Z6H9c+ueJl
q4QY14ogGdUTRA/ODiBET97P9OGfWsYB91qSwfDzool+7wgG5oxdNzXIjUFsW/89
X1ny7+ULzMe6ft3x7ePOnRW+15t7pYILWQRsgd/4IVJGfH1wfP/GrAWkJ1JZyybq
dDogVXTU4nhIhTc1T5m9WwCp41VkXoQVPUo8P7tpWExa0oq8mH8CPZSJZLGfE+Bc
DF6wIfUhjJuyf0xBezDTAEfmHwRwLHI5uGV2tJUbD13NrlK3TxBFlF6751M12btK
yZvYqbbiF+QPLF1pNMHD3r1m3Hm0wuE+DwnUA+PvqkofCnCueps=
=FmsP
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--
