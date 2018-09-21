Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7FBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA2C21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGJM6RkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA2C21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391549AbeIVFLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:11:52 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:35953 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeIVFLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:11:52 -0400
Received: by mail-pg1-f175.google.com with SMTP id d1-v6so6696734pgo.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=svdaMWwqpAS1oNT5kjabS4qPDgxbZdzSZEt2yzmIv28=;
        b=SGJM6RkUeqa55Dqy/ZShrWe2IjkfTVXF6xqKIAiJgm0ta/cr1sQXUANcQe4ivJaXw2
         lz+XT2AEoAC7fp1q5qU4bYwvIekDdsYlmiFIpK6JOZl3prr4musZhjCDQpPaLMWco+7h
         Ya0uhWo920yv/7vSu/f2bZzbqoiZ32AFD2pDZh/Dowqp8IsU0E7w7oG6yNvkTu+X4mpy
         at0gaWQMIa10SxtOfBM/RG9EYHdatHWBrVT93eZafQKbtQlk6NzGA/xMLLLvorr0d4o1
         Q0rzUWBqXWUQlSoBH3/UEmTKAKYhuRO4f3MEhlp0rTK7g9FSoGPVhM3bJuXGyTI0d0c4
         Ugpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=svdaMWwqpAS1oNT5kjabS4qPDgxbZdzSZEt2yzmIv28=;
        b=NvApygZla7mJjDNSCA6OwYiFdBht6Dm3PU/yd2kcTyYIugLBItwdYR2FxRM1t+FIpc
         QoVF75Y5oQNorWpT5vhtV/+gHRw5/fzeVw4LJhsTcMyqzdMrJVFNRgJAKJ7E14cV2mzj
         5oNfnKViJCx26TjdqTFDj6Ge0VTiAYLaZ3jx4qdswENApJmDR5rPVsJY1hpwlVYXBqqb
         ++pTBAG6tkH06Br/WsNFGRPbRV+pSqs9fLHLjqnkzEP1VOBd/LcFHz9m0+hVanF57oVK
         vDJFzLwCVpJp/0UeaJfCtT1E5Nj+90QaZZNHhIqrv9HMaZVcm7tk8paGQXI2L8f5o5S7
         f+5w==
X-Gm-Message-State: APzg51BWAaHIEJEPb9Xi6yWcOUS5R4vtOe0DvrsDmZloshgvBioyuB48
        UV1LFJx3w7oSlCZ+3m8R5qs=
X-Google-Smtp-Source: ANB0VdYsK/H3Pg1uIEC0FR8daWdgE0kKNHYEsOKNAGrB2NvmUGSXr6vTb/Drb76ypOht0AVE/plFOw==
X-Received: by 2002:a62:4f94:: with SMTP id f20-v6mr9546760pfj.60.1537572046919;
        Fri, 21 Sep 2018 16:20:46 -0700 (PDT)
Received: from gmail.com ([2605:e000:1117:c128:2e0:1bff:fe70:ea])
        by smtp.gmail.com with ESMTPSA id u11-v6sm17436714pgj.71.2018.09.21.16.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 16:20:46 -0700 (PDT)
Date:   Fri, 21 Sep 2018 13:20:43 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "\\0xDynamite" <dreamingforward@gmail.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180921232043.zerybmhxgrjqimun@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "\\0xDynamite" <dreamingforward@gmail.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Rik van Riel <riel@surriel.com>, Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>, Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
 <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com>
 <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ipavtfg5tcb2eg3b"
Content-Disposition: inline
In-Reply-To: <20180921231545.GC2966@thunk.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ipavtfg5tcb2eg3b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 07:15:45PM -0400, Theodore Y. Ts'o wrote:
> People can decide who they want to respond to, but I'm going to gently
> suggest that before people think about responding to a particular
> e-mail, that they do a quick check using "git log --author=3Dxyzzy@exampl=
e.com"
> then decide how much someone appears to be a member of the community
> before deciding how and whether their thoughts are relevant.
>=20
> There are a lot of strong feelings on this issue, and allowing people
> who aren't members of the Linux kernel development community, to
> escalate the rhetoric --- either in the pro- or anti- CoC direction,
> and whether on mailing lists, github comment threads, Twitter, or
> Reddit --- is not helpful.

I completely agree with this; very eagerly seconded.

--=20
Cheers,
Joey Pabalinas

--ipavtfg5tcb2eg3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlulfMsACgkQruvLfWhy
VBmIbg/+M6N4c6HJWvt0fywaTLshk7d1aYJe5qUSSjRtGHwzwwinsVLgckUZI0as
e+gGSuq8GqvNjNJ0Ux5ADszlOlcdn+ru6Bgt+vZwptwpoGvpVhsuJI6ooxcUwbTK
OinFaujWn7cq7Mn1sqyctfmL239lGl22jkux+1JCK9igpvtniu3jnri4qKXuLThX
OsR4CmvGQknPoxvqxFbQwqHTMFnswHwvIPieSUcZrlxvo3ZokPTUL42G/wf/WuBp
ZOhbd6ASRWlPvpGarVG1WF/o7Nn6676VfTbY70cB7YSZFfPdHVaH9xgEArFfK/7U
ZcRO02B5coQ4RocZNPzmXp+ApnKhK0vFKC9Rl1UqibvDY8QlFMLP2zEj89xvGGK+
/6Dek7/rsJVgGQyOtUqA0vSF3C11ubOjGPKkkND6vhcz+4+59V30dCyb3h5GsmUS
QrYKwvs24R8+Ayijak7R2/CqUFfQYb4jmFD/FTm+vWtAVIcRjeU5xrmiRPyASXXO
TdqOvTbhsGTgKRq92YpOj4SXn9KUuEn05gNn+SDcydNXI6lkJ/j1CDsEJkCnVeBf
UmrMT71zRKsUeimRNmqK/K6J3eVAWfNbS7y5SbQ7/5EZ5A9PAJ2pqnUSs9y5cZNN
r38aYJsZYzilvkMQJGES5eGcO2vGwsgNVR8U3UVSQP3Msp533gA=
=3Th7
-----END PGP SIGNATURE-----

--ipavtfg5tcb2eg3b--
