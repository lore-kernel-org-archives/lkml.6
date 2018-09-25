Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D83C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E065720877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtCDgmdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E065720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeIYQ2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:28:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46409 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeIYQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:28:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id z3-v6so10909171wrr.13;
        Tue, 25 Sep 2018 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+AevHrwddpeIhvbgCRpiBgWO5dEBsFhiMaZTkv8g6Wc=;
        b=JtCDgmdQPf4UEChU3fUJQUkPppaQ65BcL94wwAh+vLWS9qcCoZ6fRHvW7VblVJeb0e
         NFy1AgcPcS3oYVm6GmM5Wj/MTSjVFZK1SrjmusN8m9/XoSyLrQVHahcOPqhg79EEMPwB
         097yx29NpYpBdZbxwFSSEhsLnxfQS7a2GPAq3JbB2eKv0io09CUHmLvEOHjQ9Zaky2Uo
         7jjtitdx1yB0PaVoiH2D7XOga/FSiH8JjmLH64p3gkIbfBfk9y+xy5gDf+tnQ9HU1KGq
         DCXCkAbT1IFV5c1MqaUWpCgjIIpNEsDcOy182j3JmjwJbyhsPwRJ0m5pM0qc6HszKLic
         tNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+AevHrwddpeIhvbgCRpiBgWO5dEBsFhiMaZTkv8g6Wc=;
        b=GHcCN6Y/u+JYV7TM1ruBiGsTyparAHw4BL2wqVeWKUSeevR0F+daGHc4WScW2oTFws
         Hgy6dzkY4FKE/GyfjWvPs235stdd6eC9QGTyTGP2EIEiLPIYlDrGlmPgcN0tZIsexhaw
         /7gHQQR6oUctSYiDRkg+ZnUzFTuI0/nooLGRsrJ9FkuPaTLYZ8nODSifWdEW1THppP4P
         O68MXh9giF0fnZgj4PXYMI1vuA4cv7SZS55lqqDfgLN3RB1BPwpt1175MiSaWeBOw3ly
         M0Bi93aCjwiQfesIQv6U9PBmMp3VFJ8z1YZzuzD5+9gROZC0AQ1RvhZOLo6Q0CnLxRcY
         jmTw==
X-Gm-Message-State: ABuFfog/ygnvnLhIaQJoRVVs3uJQCX9w6s/75P+MckePemE1YCzCQ2n2
        alCf3mzIbn4SVxbVCPLPdQ4=
X-Google-Smtp-Source: ACcGV636GXrjxt0MvsDEZd1vYlHnbbAPswDuOeSPLGtKyXlXhjr5oWh69bZGmSKyE2JBPmNzZEx6zQ==
X-Received: by 2002:a5d:6209:: with SMTP id y9-v6mr307522wru.179.1537870915435;
        Tue, 25 Sep 2018 03:21:55 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id v10-v6sm1502305wrt.34.2018.09.25.03.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 03:21:54 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:21:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gottfried Haider <gottfried.haider@gmail.com>,
        linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: Re: [BUG] pwm: sysfs: It is not possible to export more than one
 channel
Message-ID: <20180925102153.GI7097@ulmo>
References: <cd7b3cad-98bf-d976-2e30-0b018f51f90a@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AptwxgnoZDC4KQWS"
Content-Disposition: inline
In-Reply-To: <cd7b3cad-98bf-d976-2e30-0b018f51f90a@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AptwxgnoZDC4KQWS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2018 at 11:11:32AM +0200, Michal Vok=C3=A1=C4=8D wrote:
> Hi,
>=20
> Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in
> sysfs") it is not possible to export more than one PWM channel.
>=20
> This is because for each exported channel a directory named pwmN is
> created in /sys/class/pwm/. As channels for all PWM chips are numbered
> from 0 it is not possible to export pwmN channel from one chip and
> pwmN channel from another chip at the same time.
>=20
> In theory if your SoC has N PWM chips and each chip has N channels you
> should be able to export N channels. But only one channel from each chip.
>=20
> I found the issue on i.MX6dl SoC with two PWM chips where each PWM chip
> has just one channel.
>=20
> This is how it can be reproduced:
>=20
> root@hydraco:/sys/class/pwm# ls
> pwmchip0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmch=
ip0
> pwmchip1 -> ../../devices/soc0/soc/2000000.aips-bus/208c000.pwm/pwm/pwmch=
ip1
>=20
> root@hydraco:/sys/class/pwm# cat pwmchip0/npwm
> 1
> root@hydraco:/sys/class/pwm# cat pwmchip1/npwm
> 1
>=20
> root@hydraco:/sys/class/pwm# echo 0 > pwmchip0/export
> root@hydraco:/sys/class/pwm# ls -l
> pwm0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmchip0/=
pwm0
> pwmchip0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmch=
ip0
> pwmchip1 -> ../../devices/soc0/soc/2000000.aips-bus/208c000.pwm/pwm/pwmch=
ip1
>=20
> root@hydraco:/sys/class/pwm# echo 0 > pwmchip1/export
> [  543.110824] sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> [  543.117314] CPU: 1 PID: 351 Comm: sh Not tainted 4.19.0-rc5-00025-g249=
f3ed-dirty #8
> [  543.124990] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [  543.131587] [<80112d20>] (unwind_backtrace) from [<8010ddb4>] (show_st=
ack+0x20/0x24)
> [  543.139383] [<8010ddb4>] (show_stack) from [<80ba1044>] (dump_stack+0x=
80/0x94)
> [  543.146652] [<80ba1044>] (dump_stack) from [<8031e2b4>] (sysfs_warn_du=
p+0x6c/0x78)
> [  543.154257] [<8031e2b4>] (sysfs_warn_dup) from [<8031e61c>] (sysfs_do_=
create_link_sd+0xd8/0xdc)
> [  543.162988] [<8031e61c>] (sysfs_do_create_link_sd) from [<8031e678>] (=
sysfs_create_link+0x38/0x44)
> [  543.171986] [<8031e678>] (sysfs_create_link) from [<806026b0>] (device=
_add+0x2c8/0x630)
> [  543.180025] [<806026b0>] (device_add) from [<80602a3c>] (device_regist=
er+0x24/0x28)
> [  543.187724] [<80602a3c>] (device_register) from [<80501acc>] (export_s=
tore+0x118/0x190)
> [  543.195762] [<80501acc>] (export_store) from [<805ffc10>] (dev_attr_st=
ore+0x28/0x34)
> [  543.203539] [<805ffc10>] (dev_attr_store) from [<8031d7dc>] (sysfs_kf_=
write+0x48/0x54)
> [  543.211485] [<8031d7dc>] (sysfs_kf_write) from [<8031cde0>] (kernfs_fo=
p_write+0xf8/0x1e0)
> [  543.219696] [<8031cde0>] (kernfs_fop_write) from [<80294d78>] (__vfs_w=
rite+0x48/0x170)
> [  543.227645] [<80294d78>] (__vfs_write) from [<80295064>] (vfs_write+0x=
b4/0x1c0)
> [  543.234981] [<80295064>] (vfs_write) from [<802952e8>] (ksys_write+0x5=
c/0xbc)
> [  543.242144] [<802952e8>] (ksys_write) from [<80295360>] (sys_write+0x1=
8/0x1c)
> [  543.249313] [<80295360>] (sys_write) from [<80101000>] (ret_fast_sysca=
ll+0x0/0x54)
> [  543.256901] Exception stack(0xecfbffa8 to 0xecfbfff0)
> [  543.261980] ffa0:                   00000002 76fc8000 00000001 76fc800=
0 00000002 00000000
> [  543.270184] ffc0: 00000002 76fc8000 76f5cd60 00000004 00000002 000bd13=
4 00000001 000ba730
> [  543.278380] ffe0: 00000000 7ebff954 76e8b988 76ee3cd0
> -sh: echo: write error: File exists
>=20
> I am not sure what will be the right solution. The problem is that
> numbering of the PWM channels does not work the same way as in the GPIO
> subsystem where each GPIO has its unique number.
>=20
> Should we just revert the change? It was not documented in the PWM sysfs
> interface. What do you think?

Fabrice has reported the same thing. We've been discussing possible
solutions here:

	http://patchwork.ozlabs.org/patch/973224/

It looks to me like we'd need to at least revert the patch to restore
the sysfs ABI. At the same time I think we'll want to fix the issue that
the offending commit was trying to address.

Thierry

--AptwxgnoZDC4KQWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqDD4ACgkQ3SOs138+
s6GR0w/9E1Rmy75TdPZxrPH26950BBRF0eDAd5k2SebseMoOcgvByKfe+QiB82ip
sLw3QZAtXikOBZys5GNVZ/lY7+tkPSMk9R8nR5LkYfRf+GJloS2eQdA61fGRypVV
/H/F81gwpURxQVgYcdNBm3c2LryT9JJHQWjrQHDO24lQetjhKFwy6tbTQdwfvct5
7F+NuG2cYCsTx2U9quD2nJv4dXwiqsuTes8BxSrIZF2oGRdNM3ZJ4iPtUxxrbiei
0iV/Jo+Q5KgnZLUjJHrpFlYfwGbQXZvBhRYfzkgPPKTAG+XPOYR+W3LoN1brGUiu
C+BrYiIxjDpOmAeKKId8IXOCm3sydelFBdrx5B8vTlqT8qOSiEdWL3L9wMTYfJco
CcOFwwmlhFhsWGyivsw4Joy1Puiz/qi/8mE2OuDp+ErzT+OAyl26Me0k+qF2Rlyh
w1kubG4ooT8FcQTzu51VMW3RVyBujSuN2Gy3mvR8MEHS+j+2NmRLo6rDkEyfxtpF
A7irnNnLvHW02fRvkXGrAF9BvvuLoqPhLCUEvIkBkfsGOfcr3uKnTcs6yEe6TRtv
g/+K/W8M8ypS80KfJXCn0sOBd/h7dno8xIZ2/WB8G/dGpgzGyHsla+TkQxrjsESe
SXx29as0PUX2u0FenOBrNpe6jsLZa83WC0p8Rh1eCNLUgLhjtjg=
=PTiU
-----END PGP SIGNATURE-----

--AptwxgnoZDC4KQWS--
