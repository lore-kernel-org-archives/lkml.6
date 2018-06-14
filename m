Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3BFEAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0772208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0772208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754851AbeFNR2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:28:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:48688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754644AbeFNR2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:28:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C1BC8AE89;
        Thu, 14 Jun 2018 17:28:02 +0000 (UTC)
Date:   Fri, 15 Jun 2018 03:27:57 +1000
From:   Aleksa Sarai <asarai@suse.de>
To:     Ivan Zahariev <famzah@icdsoft.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Cgroups "pids" controller does not update "pids.current" count
 immediately
Message-ID: <20180614172757.ovu6sbolcgc4cdjr@gordon>
References: <77af3805-e912-2664-f347-e30c0919d0c4@icdsoft.com>
 <20180614172634.ymoik5uov3vzftmp@gordon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ffjecwbgrtrqriux"
Content-Disposition: inline
In-Reply-To: <20180614172634.ymoik5uov3vzftmp@gordon>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ffjecwbgrtrqriux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-06-15, Aleksa Sarai <asarai@suse.de> wrote:
> > I've tested this on 4.14.27 and 4.4.0-124-generic Ubuntu.
> >=20
> > If I start a couple of processes which exit very quickly (like a simple=
 Bash
> > script with many commands in it), the reported value in "pids.current" =
is
> > not updated immediately when processes exit. This leads to too many
> > processes incorrectly accounted in "pids.current" which hits the "pids.=
max"
> > prematurely.
>=20
> One possible reason for this might be related to zombie processes.
> cgroup.procs doesn't include any zombie processes (tasks are removed
> when they exit(2)), but the pids controller does track zombies (tasks
> are removed when the 'struct task' is put'd). This could explain why
> there's a discrepancy which clears itself up after a short period of
> time -- though I am not sure that your reproducer will actually produce
> zombies (I only took a quick look at it).

Scratch that -- it can happen even without zombies. Basically it just
depends on when the 'task struct' is freed (which could happen
arbitrarily later than the process exit(2)-ed).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ffjecwbgrtrqriux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlsipZ0ACgkQnhiqJn3b
jbTowg//Q3Bz8gL+xLSPM+qPx5XjzY8pwhJWMvL/dPcXLSDeLyAvNnKJzmNk2yw8
wp7TCm2Prl6IG/lb9VP/HK7Vy/EKDHfTeH72HPUsIpVLaQbSL0+CGEIlYJGBHseo
XNj4Db75jFu9VtbJe33m9SnDweIh8W3+e8raqLUz55vbX4oCRMzXBMtH44waKKxN
22vWutgvrhZhWd3CDdAAnJKh1EGIZqeSSui4v/aZ+lFFX49ydMEzwvf1yMAVLTGT
RKiWFfpLDvEuPL21nPjVxkIXT2cLA9vb9dNs5xyOtEZtVKHnl6CMJRGx8Htu7VxT
mX4+BRqDK059F/uU0PK/GsklvgrDGYCMpf9zZARwJBymm0VuKo+BFbPS/EcZIV41
LsgN2NH0Ksm5g67F/5XfSkuS23zQqVBLn3Sq3YJcM1k8wEUd9UNicQ6O/QXQ2kZM
Mga/tlwe5Iyep+dpYT50om655hY1Ya7+v1FXmpxcBxSJ3RPLwQ7UD4E30X4mVKNI
o0Ubp2kFRPw4BvVVQxDF1Oat7TeWssbY4szSIF/ATIAtv+yGtCF7E4QEFdFQUE/q
1I7AmO8ui7977s37w5vWThMfFvlpORfsKibVnBx75pXzpXkloNnYFJZuuYBi/WoX
I3bCjAvrSXKtTSIlcXUB/hAkoD8fe9W6htUhWck4DoYbc+1cJWE=
=iDN8
-----END PGP SIGNATURE-----

--ffjecwbgrtrqriux--
