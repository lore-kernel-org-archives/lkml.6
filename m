Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1235C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B19520855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdasYtC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B19520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeK0Aix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:38:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35310 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeK0Aiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:38:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so6205491pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 05:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dUbcAN2gPZ6PeLWbTP297440rde6MzGwvluYcFE0ytQ=;
        b=TdasYtC8aiet84vikaUhXkSw/Fhfygkp40wBngWamiA9G4bVeGW6VqKzuj6/RGHrkI
         54Rc4Tm3Dofp+oqIe10vIKDoCLhjxgIfhpbzoQmNIVafwwP7wtWe/n/ZG0kMmVAYbomM
         WjMOAD8mzs5QlkA5gqipcwzlZBj717CgiwPFA50oabqAfjhDsM5y5Up4GTF2Od7CyTjo
         psesFJfMfk/wOrCunhaNc3Oakuvovw4ZpKnv7esWa3ly234UJq3vpMbKgWfc37NbMTVa
         y84I6gCecEjCTV9ssTopsSw7bIcwp5boF5Ipa6R2ikpop+IFeliaFNCULGPSC5gsD2lz
         LLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dUbcAN2gPZ6PeLWbTP297440rde6MzGwvluYcFE0ytQ=;
        b=O8yQDLOZyNoiJXqb5XXQ7jpSwt7/4aQJxfSki6qSCeEp+qHWxgf3O75CIRx1+DxsJ0
         1Y+K8idg5qouADW+xM3AHlFphx5QRAjG7V7NweHFcS2jG9+mfEchd5y5orEG7Sdb7Gb+
         qhn5mRgmfR5goi5bhHbH8xc6VILCEX6iNBi5CJ+AY01KtdyjSe1wrrxS2boqYQ0EjA+I
         +irinPXbouUILzNDUNh8NGXgkvyV/mo/hS3NJbTgVjFoaepWbRFwfRoZWAyFF3EgkiKO
         PTEBEwEvxzINdSw2mLPQzVCyvR00wuy8dybNZTcBZXnqzVPZy//pByCnng69qUh2ocL+
         gdaQ==
X-Gm-Message-State: AGRZ1gJdrUsZslZTAPKzGlZh7qAN86alQJG7kzCp6lWCiTYav7DYqk0l
        0fwm4phwY2eOizkf7lOn5Tg=
X-Google-Smtp-Source: AJdET5cJ5k3b40bTZ9Es3zkLr8P+nMrFTfP1vueR1DL48Kb54LWMqvbZ242xlUFJu+fb1ViiVVi3sA==
X-Received: by 2002:a62:130c:: with SMTP id b12mr28174528pfj.247.1543239881326;
        Mon, 26 Nov 2018 05:44:41 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id z186sm515867pfz.119.2018.11.26.05.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 05:44:40 -0800 (PST)
Date:   Mon, 26 Nov 2018 03:44:38 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 5/7] zram: support idle/huge page writeback
Message-ID: <20181126134438.7shen7saoo2mifmo@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <20181126082813.81977-1-minchan@kernel.org>
 <20181126082813.81977-6-minchan@kernel.org>
 <20181126094737.sfudpeoigra2vir7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p54u7efpquuy2ne2"
Content-Disposition: inline
In-Reply-To: <20181126094737.sfudpeoigra2vir7@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p54u7efpquuy2ne2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2018 at 11:47:37PM -1000, Joey Pabalinas wrote:
> > +		if ((mode & IDLE_WRITEBACK &&
> > +			  !zram_test_flag(zram, index, ZRAM_IDLE)) &&
> > +		    (mode & HUGE_WRITEBACK &&
> > +			  !zram_test_flag(zram, index, ZRAM_HUGE)))
> > +			goto next;
>=20
> Wouldn't writing this as `mode & (IDLE_WRITEBACK | HUGE_WRITEBACK)`
> be a bit easier to read as well as slightly more compact?

Scratch this comment, it just dawned on me that this is not an
equivalent expression, heh.

--=20
Cheers,
Joey Pabalinas

--p54u7efpquuy2ne2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv7+MUACgkQ2rGdfm9D
tVIIyw//fdicYFBla0D5Vw7v1nQsYwXaX05XdERBRp0wwxskAbL10GQSlp6ldhQY
Zi7n5o3/Y7HUnAfFGHkJh71GLrLORPoaz+ivrCJGcoolJbtxApXdL6g+LJrJBI1E
6lZdajBeRpDvabxUUtjLkYqe8DFfwIuo9IXYiy1ezxIHTaP+c0G7hBvM3YNnRzdY
Q2PhMM+c0INL0/SO6dxYABQaCBqqkY4YXgaeLA80FZ8Ga+390kGwIrAjffJ1DrNZ
kqozILnz596J9pfuGX05wgdr3iL0y5hzdXZTRUBiRxj/HBg34hutkcQkZk487vKb
bCDVQBs67PY08qjf3Dd82SB4iq1PYwy77+BgZIRB4yOASiaZyKif4yREIHqTYB19
BJtFPItr70ojGXteGErE6XnrU2Yl1B9jDvGf9awNGYsRRIgG+sV77b0sj1oEuxy5
6DmczBBu7j+CSwRggD5WyE4AFuqqEDCKNWMyOV8tQsiURKylzAZvt8AvMaHMgS2i
6WF603z0HCfMCIUzt6NjLtSO8Gsh9zizYV2ITYlqeaW5uIasMghA7kNa3GlonZW1
/ZiRuTudfOHdJTkP7p80oTFETY7DY8IOcOoEC7CUQKxiFvR8eWMDEPSktTnB8/T/
gl/8mxi5AZnZpnBPioMD1x6CufBrvkkBMCYd27O2Sq05kZ/ldSs=
=C8Fr
-----END PGP SIGNATURE-----

--p54u7efpquuy2ne2--
