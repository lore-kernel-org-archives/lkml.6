Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07043C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC26206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="IoCzTkWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC26206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeJAKHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:07:17 -0400
Received: from sonic315-10.consmr.mail.gq1.yahoo.com ([98.137.65.34]:39387
        "EHLO sonic315-10.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727287AbeJAKHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1538364696; bh=NJEq6hr5OCwwuuIyOl9lI+PUHSrnZ+pIiFLv3pl7Kx8=; h=To:From:In-Reply-To:Cc:References:Subject:Date:From:Subject; b=IoCzTkWf3LAP4p9pd0jMt9+O4AoiD9QWeClqQnMh/h91FLoGEYDVLHPf5mSu3qKzFMjIKHETQP2AOGUHyzlL1CcAP2SJuKm1k5RELWjtwcCNFe5mbn3dRMkpfYQm1sB+BDCrnFpilsVGq/UPjOE1ukQT1wIOFP+7Xseodu6ZqF8IezoPLpGiR/FhYv2A3tazOQiE6wTJyOrO0gwqifMcYjUcDQnKzf2LX86EjKVO4Adl5MSjFpD7JY+/kAnmo2ygejdNUevuHMYk9Bn4nPbxdlW2GLdjXGbno0MvECncPekjz0voq64LTpqMW+29b1uq67PaI7xD6Pik8GyHp4qDtA==
X-YMail-OSG: 4d_btewVM1kOyBvluo.zikY8e1ZpHedSRP8x1rGXbGhe4tKq9tuq5A5XXnohA1V
 XPZYVstdBbYh7jtCgO6_vyyB.8wfxbJvpOGe2OPjgfiP_4oqORw7DCLBrJAlso3ulzFU619Vb.8B
 Wx6cFhWP.YaWKcJHK0rQF4O0l5SltRz7e3sMJN90MDr4oqqbN1wfpps4nFslWG5L8q1FRZRf9fZ_
 LVAxnADIYFVANCO2fBfdLbWvmDcG0zUeyVBfySU4fRmm1tDDtsWKRaI26dyPsD_EVgUMBxySKlxH
 K2HeECEEGeEIilBVUhSHY6Apg_P4G0vuhTq16p5Re1NU45RBsr4ddFdF2PNq5wPQLxcCFAweGL96
 5zgw8SnwGo2wl74Tu8sPL9K6_YXwt7Pe8LOfkfs5MH6BH5YTf8DfN4tWjT5eeb_E_qNMpIY__PHK
 HfVHfMfaAgoiQrSF5DzeylQlhwVQdfC.LQKIPBbQ.RbWLfTuZFZwjNrz9fEMw8pkwa89FXUzVX7S
 uBgKDzwGOu3CnrofGOO0tN1sWK9HTjioW6JD0F9Z4oJhOLldHeUfRWeS_DQAimtp3TSx.WGvNmtD
 3k2pOODa40unVzSjWAn0f.WvtHnqzWtBZJ61f8pYU1hWNiyRSEMuIH0FBkDmBWK8PZTiZnggY4.A
 rWKQVT3qOr6UECFN8MxSSfADGjl2C9mXlQ5hmhXBAOI7E3NJMYZ26GIoQPGqOLj0h67SO5.2KnOD
 YYB3H0inHUGqbv.1Zi5vt2tm8JJJnXAyivrg3vLl.FndUa90iQDMkk7SLyRr0FhbzNLbOPXygUIf
 PgMTDR7AzIdZIdqLqtGuHOTX..hPitHx05IxUBtqSUFUNGXY0Y5XtegDFAfE.y1co4o4r5jhAccv
 R7chYxYHdpM1nA8VsK0eXqd7xXQUOi42Hk2UR2mgrKEeTFLpdNM4SMpDtm51HSh5RFa5NtOkKmI.
 EiERe5RAo9GXJ5CCX7zgWRzKxBAPUECs.tIESGDzStl5mAh14soLMskSuMd0tqZ4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Mon, 1 Oct 2018 03:31:36 +0000
Received: from pink.alxu.ca (EHLO localhost) ([198.98.62.56])
          by smtp428.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c7bb44d55f9d56ead4afdefc97b5ef04;
          Mon, 01 Oct 2018 03:31:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andrew Lunn <andrew@lunn.ch>
From:   Alex Xu <alex_y_xu@yahoo.ca>
In-Reply-To: <20181001023947.GA4943@lunn.ch>
Cc:     Daan Wendelen <daanwendelen@gmail.com>, netdev@vger.kernel.org,
        hkallweit1@gmail.com, nic_swsd@realtek.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <1538319728.z22jaatdgh.astroid@alex-desktop.none>
 <20180930221751.rd7wva3zolephj6q@scappy>
 <153834665886.421.6376790866713055481@pink.alxu.ca>
 <20181001023947.GA4943@lunn.ch>
Message-ID: <153836469540.421.16736256316219683461@pink.alxu.ca>
User-Agent: alot/0.7
Subject: Re: [PATCH net v2] r8169: always autoneg on resume
Date:   Mon, 01 Oct 2018 03:31:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Lunn (2018-10-01 02:39:47)
> I keep reading the patch wrong, so here is the end state:
> =

>         /* It was reported that several chips end up with 10MBit/Half on a
>          * 1GBit link after resuming from S3. For whatever reason the PHY=
 on
>          * these chips doesn't properly start a renegotiation when soft-r=
eset.
>          * Explicitly requesting a renegotiation fixes this.
>          */
> =

> I would also say 'don't'. For me the subject is 'PHY on these chips',
> which is plural.
> =

> However:
> =

> For whatever reason the PHY, on these chips, doesn't properly start a
> renegotiation when soft-reset.
> =

> Now just 'the PHY' is the subject, so singular.
> =

> But i'm just a native speaker who never actually learnt the rules of
> grammar, it just sounds right or wrong, and i have no idea why.

No. Ending in a plural noun doesn't make a noun phrase plural.

Example 1: The boy with the books is walking.
Example 2: The women on the roof are waving.

In these cases, "with" and "on" introduce prepositional phrases
which are subordinate to the noun phrase. The subjects are "boy" and
"women" respectively; the books are not walking, and the roof is not
waving.

In fact, this can be clearly seen by drawing a parse tree, which should
hopefully be a familiar tool to all programmers.

Furthermore, the addition of commas in these cases is not correct (hey,
another example!); the phrases are essential, so commas may not be used.

Regardless, this is highly off-topic, so I think further replies can go
off-list.
