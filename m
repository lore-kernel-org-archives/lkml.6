Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B67CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F8E20867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPGW0+A/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F8E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeKYMn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 07:43:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33918 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeKYMn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 07:43:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so12211093plo.1;
        Sat, 24 Nov 2018 17:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KdgWOd0+TQZLDDq4Bt3cfqolNkJyhcdgYK2S/B1VKdM=;
        b=kPGW0+A/v+0zyMhQ+G4OdzZc9sqIltSIuyc7mGGtKLI1Dp7thiySNtbVbhIcbutI+i
         5GeNGefqVG+uc8Mc5SZw+K3N0rZkpQQBKzEWTVMbZxOfrjGiIodwfO6/RCmCE4fgEAY0
         JUJAgx2dUMa+34nTtGOcCgkWe5bsEmm4SqqDsdh65lLzq86UOQ6beO/VP67wF2Bz1XCU
         pNz+ZLwZ6sVNUyZEoXyEEemrROvqvZLWXhojFQ5doTroSVKOGh1MIC/izN0LJifZYX7T
         cFiUpZiBWTqaUzu5gik+JWr8fJ6XEcBdLlylC9UxbzypZqrfAQ/sgmLlBTiGYycy+yK1
         2xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KdgWOd0+TQZLDDq4Bt3cfqolNkJyhcdgYK2S/B1VKdM=;
        b=Qzle0eZco81wU0/gT8/VmRbAi7HvWl3FoNPDLOAZWNz+aDLO+oGthDUlMv2bKtksbS
         eNmpUmWxb0F/NuJjdaY4/w3BUAvNNlr9+CxaVAvy8NHLB2nlhjh/t5QsK/bx5sfGl2sr
         vbsgrBQFmuPYpN7LFoZoXU8XriMA6P9MpHG32cOIXTEcjwELw6XrBGZpxRVkLZf10N5A
         mq7ng5R1xbB4R139Xv1ItUz+pd1Mzv7jgTCWvyeZc7A1SVPmJJgfbnqigyP7gLpW3trj
         oDPZcQWrGYnE2iAKkBGQ+uSigcAr4u/tlX7iC9FtWKwMaeotY9Ax0kD8Fb5jS7vJyTpE
         rEnA==
X-Gm-Message-State: AA+aEWaQ6nf2to7BM8GJ/sEp2sw/xfmCwaOEghjqpAgX7tWn5XZi861B
        loREDabAQGlP5VNN914fwwHE1XTg2Kc=
X-Google-Smtp-Source: AFSGD/V9kctWXIB7GsXKO7F6rbD8MOs+BlUa1E885iFPvmqIJM9B12zXGi4wuHUAUGIekKNm0picCw==
X-Received: by 2002:a17:902:9045:: with SMTP id w5mr21102977plz.32.1543110846689;
        Sat, 24 Nov 2018 17:54:06 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id y6sm33571340pfl.187.2018.11.24.17.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 17:54:05 -0800 (PST)
Date:   Sat, 24 Nov 2018 15:54:02 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Elvira Khabirova <lineprinter@altlinux.org>
Cc:     oleg@redhat.com, rostedt@goodmis.org, mingo@redhat.com,
        linux-api@vger.kernel.org, esyr@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, ldv@altlinux.org,
        strace-devel@lists.strace.io,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH RESEND v3 1/3] ptrace: pass type of a syscall-stop in
 ptrace_message
Message-ID: <20181125015402.glcaw3kghcu4pr22@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Elvira Khabirova <lineprinter@altlinux.org>, oleg@redhat.com,
        rostedt@goodmis.org, mingo@redhat.com, linux-api@vger.kernel.org,
        esyr@redhat.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        ldv@altlinux.org, strace-devel@lists.strace.io
References: <20181125022150.46258a20@akathisia>
 <20181125022227.55e8caf7@akathisia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vdbkloxosvqpo44e"
Content-Disposition: inline
In-Reply-To: <20181125022227.55e8caf7@akathisia>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vdbkloxosvqpo44e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2018 at 02:22:27AM +0100, Elvira Khabirova wrote:
> Define two constants, PTRACE_EVENTMSG_SYSCALL_ENTRY and
> PTRACE_EVENTMSG_SYSCALL_EXIT, and place them in ptrace_message
> for the duration of syscall-stops.
> This way ptracers can distinguish syscall-enter-stops
> from syscall-exit-stops using PTRACE_GETEVENTMSG request.

Is there an advantage to using two constants instead of a single
sys_exit bit (set/unset for syscall-exit-stop/syscall-enter-stop)?

--=20
Cheers,
Joey Pabalinas

--vdbkloxosvqpo44e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv6ALkACgkQ2rGdfm9D
tVLi0Q//UPIcLhCeeQC2SfdW8U7Ul0C9+7Ox/YhYslXMK95uwdUZAjdfomhPHKr2
Q6mraLrDgIaHygDKqX3FWkuFlOPWw+LHIV6xnpPotbQAT16JHWXnu/EqcRF5GQ43
Hz/0GUcgBAGiPeiINvgl56E74hUyikVKPf3ppKV5PhQvoD0lDR0Ko2HYepJaG4KH
aglOle74Cf0hBy9zHGRFs36fWrFSepaBGYIlYAm598IsaUEqA/yFbZQiSgGfVjr/
XhZpj1G22Vk8xXjPHWFWk7wCblGoIleRXVT0EShu2ZUt79BUT0xUxrYyqpmT5SVZ
PiCgiYKmeEmpS18AVDVCbQXzYkJ3lqzbrSqaCcY0h0OrVZ8YShXBO7L2lrlLQAkk
0P3o08duYbRfdTJzmcLA7gpJpI8yFuQKb55sgBLZT1OBisWkDoQSqtpzzoKlPw7f
mD0WyexCFkrUxAEk2W7ZZ6FzrNKth7VHWDy/X3hQs56bTNCOEJITFY01GMODfI4E
V6jDwElAauUUNMeuYIG4LKmbD9LMBEEutxnQ2BhzYXPGI6q/LIA3KKuI5/Ktqg0A
DiEVTYMdsHFpjmZNXRGlP5lPjN4zxUo5F+MoiOefpUT4oPxOcMEbWiMzeChjK9xT
iD8fU8oxLYS9wiaBvUM0Bx0Ia5d0K8f++zHpuhLdF6WIiS6A4Dk=
=KbCj
-----END PGP SIGNATURE-----

--vdbkloxosvqpo44e--
