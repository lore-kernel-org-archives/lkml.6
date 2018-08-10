Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78B0C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49632223A2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q237gvWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49632223A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeHJCal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:30:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39265 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeHJCal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:30:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so3610960pff.6;
        Thu, 09 Aug 2018 17:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mXMgWPG52DWQNpd2BfZY5MUeHt9q6JByG3o3Rf0LjFg=;
        b=Q237gvWdMc7LPSzLi2UBhUwhcKFvs8qFZhHvPE5qfnAMzQbc0zOb1vO5E5iEO/Sr2B
         EakPX7Wbzi9ohE0p6zkYYwT4iLT5oSFx4FWJeOVXRBPpXVeJgZhrQ6cs+6ZjV2JP/22j
         zLuonVimVAbPaR9wK7figLr+jNEmqpMTJS1R8QwOHque9/1fp/TB1UgdnfDlvDc9+gFu
         w/Tqkn5ZzCJmm5+SIcrQ8Lalm671MwyOTxw+SXDZKmXeU4EhaP4b5FKnzLFJ4e1FeL20
         x084mWeh96P0OcdV7uH39R+dTZAjB7np4XUVOQKfspRSANS+ApzpTPktn2zeRrPBQelB
         jltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mXMgWPG52DWQNpd2BfZY5MUeHt9q6JByG3o3Rf0LjFg=;
        b=LLIQYnME/Txbz4Diml7qnPQ8jsShiSz5/rMmnPSL6WdVkZTqSs0MI7u10HS9hpL97Y
         mHPfR/48PRrN7R4H70bQhr1rMYs3docLTE3YcB72XRNQBVVR0b7AmuRBrsM5swDIr7+F
         bC3qNmbUMth5Cm1TgqcN3cu70QGG2rZBgUNxBWiCrOOoGH0L35gn7AMuNekpqgl29fal
         JZdloU6pq75nh/iSya36PyKTySJSB+Cn9KtotetPhUO7RqeWxtL6jik7gny2XwAraUQX
         WWABLVkG6EOoJue80L/tMB8TpqXOU+4I3fUb0bbB7Kpg5aH4O6vNFGJcaApp/8nvueA0
         VPHw==
X-Gm-Message-State: AOUpUlGoFIbUFz/1deBcxtaYAN9kcRJY4chi7EPCIMITZzYlPSSvslev
        OJS4GN4Fl2QRT4JDnayqNG4=
X-Google-Smtp-Source: AA+uWPzxVGtepd2cwIvJsMt3WveMadx+a3oAJk3Ri0MzEG9PSqzkdatBe00vUE1EBoVTvOTbEqitVQ==
X-Received: by 2002:a63:e0b:: with SMTP id d11-v6mr4101649pgl.134.1533859405686;
        Thu, 09 Aug 2018 17:03:25 -0700 (PDT)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id m15-v6sm21296245pfj.171.2018.08.09.17.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 17:03:25 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:03:22 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH 4/4] HID: multitouch: remove unneeded else conditional
 cases
Message-ID: <20180810000322.my7n5fdzq4f2o6fa@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
 <d35643165a1d1972fd91e547922697a3c785a413.1530402641.git.joeypabalinas@gmail.com>
 <CAO-hwJ+ZHb8xyr=1RgVROvP2=yzmepccVOqZM5qP3hbOEYEo9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgk3gjfxx6yyurj6"
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+ZHb8xyr=1RgVROvP2=yzmepccVOqZM5qP3hbOEYEo9g@mail.gmail.com>
User-Agent: NeoMutt/20180716-169-191348
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgk3gjfxx6yyurj6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 10:17:58AM +0200, Benjamin Tissoires wrote:
> This one looks good.
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>=20
> Just FYI, I sent out a big refactor of the hid-multitouch code. Jiri
> should be still reviewing it, so I am not so sure who will have to
> rebase which series on top of the other, but someone between us will
> have to do it :)

Somehow also missed this reply... I guess I messed up my LKML
filters somewhere. Noted, thanks for the review; I'll check
your trees for the refactor when (if) I do my v2.

--=20
Cheers,
Joey Pabalinas

--xgk3gjfxx6yyurj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlts1kkACgkQruvLfWhy
VBkIjA//c1VMxyu78bYExhBC9NID+s3iORVYfHduxuSEtjn1NJqcKeDYatnV1av/
xqkBdvj8UJ4EH3anEKTXxG64K8Y/xukNgUyzCs42AH0cdLR9rL7CiW/po//Kk/n1
qMaFPxzCDFH+Ae7Na2VIlTTYZKv/t2NYcevkMqBvOIN8FrPR3wSbfmnaZxCxZtVM
ftLBXkSX2Wrx5LLZklpXHiGRJCAqHa7wpf/lnf9xbQ7NfOoaQ4cRN+3zZoYdnzIZ
LRJFfGcSVWWdW8zLVfS+8IVNqnNcrtNzokDjkP0DyI2fdfEQkLbRKAi2XRbjRAlA
WRlv5YjDr9MQjMdfBUdIMNIWbZPhaxKxtncYbe26pu1nvklT6NzK+rv98rnzpmpK
6ODaWbU5824DjoRhhljXXSmo4n68FuqUxOiIH4XXkEeFdmuBYf6E8tat4m8x50hx
hGtx2y1NcqhnnZRLeZixYH8zs418SBVU7SGYZnGw8Uz/IxUf7BTqgWsxg3Qasj8/
MXSeqstEuljmAl/QE8klREJiy2wvCNCuzxBhxBfvaRZV25uTtgJ4BjWSiMFUAkLn
lfxQoHKynykSerhR64fi6MT29l5MzwZbTtMyZ3OTtb+kR9HctNQUfJv9Z4PcVdHI
Cd1KsVTbWGPYsPJDW4pqxhprkOObdAxA41r7s1I5eoiE4nN9gNQ=
=A/21
-----END PGP SIGNATURE-----

--xgk3gjfxx6yyurj6--
