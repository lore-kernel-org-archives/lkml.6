Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tAPjHP7KHFvZKQAAmS7hNA
	; Sun, 10 Jun 2018 06:53:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4D54D60850; Sun, 10 Jun 2018 06:53:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=mlen.pl header.i=@mlen.pl header.b="g2Jm2YJW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7D060604D4;
	Sun, 10 Jun 2018 06:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D060604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mlen.pl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeFJGxq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 02:53:46 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36112 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932183AbeFJGxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 02:53:45 -0400
Received: by mail-lf0-f65.google.com with SMTP id u4-v6so25934463lff.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 23:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mlen.pl; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p6y2lNa4ewNUg5Ev8B0xYQbE0BtH+qOiChTxyXSrvJY=;
        b=g2Jm2YJW12a9TiRWD5iOtlXXMy+42IVdy4aMW1ZAbVmyrJYY1nUWzqs+FKFfmxEdFg
         VRcvQHwEjbDzfWOviCi8fq0CddwGAmUjNR3W1hZ0rKAblph8OT7j2Qri9mtc5MNpkLxp
         +nWhd2Apv44aDtFdcBdPT4dyKz7tRZ7VjNzOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p6y2lNa4ewNUg5Ev8B0xYQbE0BtH+qOiChTxyXSrvJY=;
        b=oYJdn59PNQLrwwY5ah4AQq8sbux4W1nfJCkydVbrFsk9BpL6DN7+NAl7BOJL3s6lyW
         mSay5H0w0jeYcDh8SnSeEYpRiAfK3ToWOqtKeh8BffDXp8jEsGEJVpbL3Gh6vN5ERGc8
         2TFZnE6N6+f15ssNRd8hELE37InGKDuNJTZMFKumHZrzzs19XaSwKNTzpg9uMns4+TIa
         RIBqD8IbNLhSpFiFuAv0Hgk26Thgz7/ruUOW/1vycdG0rUYouI7T2/8gvLVGHZ04EQLA
         SQBMFbJ5IcpFEXEYG1dZS0jFExaBYl1VvT9mG9qZ/dcfPqOkG2kH/V/7seGFnhnQdHUF
         rWqA==
X-Gm-Message-State: APt69E1zR+8TyYsuWGHfApDhPjPQyJf056XkLeGunDte1Bggy1KTj/PU
        fDMM3HE52rIYeLOiMA97NkeM2+qUIXE=
X-Google-Smtp-Source: ADUXVKK6TtGYQBCoSFddviEAMJH9kHkPuWlap7GG4PS/8t7w0QpShy6Hdw6I6CHJU2DMqSdkUp66sw==
X-Received: by 2002:a19:5ad4:: with SMTP id y81-v6mr7985762lfk.82.1528613623759;
        Sat, 09 Jun 2018 23:53:43 -0700 (PDT)
Received: from mlen.pl ([176.111.135.248])
        by smtp.gmail.com with ESMTPSA id e16-v6sm3569223lfi.70.2018.06.09.23.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 23:53:42 -0700 (PDT)
Date: Sun, 10 Jun 2018 08:53:40 +0200
From: Mateusz Lenik <mlen@mlen.pl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        bugzilla-daemon@bugzilla.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug 199965] New: Memory management: BUG in kernel_restart
Message-ID: <20180610065340.GA31504@mlen.pl>
References: <bug-199965-27@https.bugzilla.kernel.org/>
 <20180608151508.d0c250db2a0900d4ebb2b115@linux-foundation.org>
 <20180609140726.GE28854@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20180609140726.GE28854@kroah.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 09, 2018 at 04:07:26PM +0200, Greg Kroah-Hartman wrote:
> Here's the full callstack, but yeah, it's not very obvious as to what
> device is having the problem, which isn't good.  I don't know what to
> suggest here.

I think it is related to amdgpu -- when the script that unbinds the=20
second GPU from host is not executed, there are no issues during reboot.

I found out that amdgpu leaves i2c-dev and hwmon device nodes after=20
unbind, which seems to be a bug in that driver.  In 4.16, it only left=20
stale hwmon node.

Best,
Mateusz

--=20
mlen

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE85gHe3FjDwziU4z9xZ+f5hCG0IkFAlscyvEACgkQxZ+f5hCG
0IkjQA/9FcMKDdCmSI4Zeo/Es/++WfjD0HGL5IVDXvZJjggYB193g2MVPddvwccf
sk00vQpUBl0Pu8vDM99vy3Z+ThFkyJyWB6xtd3sXSM+EQnQdhUb0/BM3dB+Obs2Z
xJcs+ckd4m07eNzPUJiHwMVy6uiyPBHf3WeqGrHuBnyu8NFr3EcSl6mLcK3FDpp8
qomJpfpVbUNLL1NqhtZ49H9RcsryknIsa7NZsmVjUEFx6L6YQjOH68scrYCeBLSm
I5/wpPoI79UlIykXAzwhhVjYHAKm0A9G83ltMgP4JDvXKVl3ukQFHy3JfBl1wWvu
cpbUe6XeA/xCfJ17QGANBNaOqmHn8S7sbHXMhU45nwr8CTD8q8ElWB4/VCjzPCmW
/mSxhK9sk8OAPldhPWXdDWV5UKIxl5PncpHE2CeJmSn16qbQKkKws9E6thqEWaQx
0pG/CL8+lLH7fTYI22rVP8JXv/F85pbLgQRW5hjXtYVlj4ap9DGiUpBa8HCcLmM1
l2tPO3PcFVaFbCF247KxmiBjGR51skYcL8g2cqLiyJHP/fD86kxSvF79WL6cBC3D
bsiYLJ13nCXPHa3INoV5mDXffriexrNu+neZ+z/qODqUjbPk6vUnZgrm9aPb2kUm
pjdlZvfdbiw16ufhMP9fd0nxKxojngNNPGi44cBML5THDfzgz9c=
=kgyJ
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
