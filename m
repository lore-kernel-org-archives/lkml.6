Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305D8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E662B2178D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E662B2178D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbeHCTwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:52:46 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:36648 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727356AbeHCTwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:52:45 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w73HtQQP027888
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 13:55:26 -0400
Received: from mail-qt0-f198.google.com (mail-qt0-f198.google.com [209.85.216.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w73HtLcZ006994
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 13:55:26 -0400
Received: by mail-qt0-f198.google.com with SMTP id k21-v6so4787357qtj.23
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=Ct1gfRyFzeS+8oGd5FN9WLEbXGQhL5apQ/shLophfPI=;
        b=RXppLQptYh2ID5rrsuaR1Fj8owDWdMmFiJ5duW2jNFNibErG0KQKbdhmRhc967cDW5
         3HLp14tIuo21vzIKpWHd/fYv13hXEA4KYH7/XNa7d8KoLZZhdxHRSIVHU4jKQmH5FPie
         LsxnRv0qz21xxnU2VU4hIBuXpt3oi2aP1HVvg7FOLISlSS8Yr80JhQoJxpQykb0Cxtnt
         ELIGtv39F00pCeoFCE8fmDeNWW1rUiEWk7AAqbL5sA6ja5IrlPc/cZOd03JhcTrVzi41
         sVUrIEmSYRxu+ivvm5gnAWF5Y1+14EnASs++SVefLI/sCrADq4CdKHoSQraOqX0AmBtM
         EJ5w==
X-Gm-Message-State: AOUpUlEglZ9rp5s/PfAufdhmuE30P/DA18/G2PdA4EgpZ8FOo3f5Yf1b
        WupRp/vbizx0r8mhLpn7MPb+KJOpdJI7JzXwOuuw0UZTYCsTu8vFOcIsFWApIL6Yonaf0FuVWVh
        iQJ6Shs06cqWnMXJ5x53ticZD41SLSCyp+u8=
X-Received: by 2002:a37:264b:: with SMTP id y72-v6mr4666765qkg.340.1533318920949;
        Fri, 03 Aug 2018 10:55:20 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpdkvu1UmbKWAi75/2PXB5H4FLdF7eh1zy1ODo563QRFRs3tuPUiwM5CVwSLzjncIU48fjqMpw==
X-Received: by 2002:a37:264b:: with SMTP id y72-v6mr4666754qkg.340.1533318920712;
        Fri, 03 Aug 2018 10:55:20 -0700 (PDT)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id r23-v6sm1930503qtn.40.2018.08.03.10.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 10:55:19 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch fall-through
In-Reply-To: <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
References: <cover.1533151956.git.gustavo@embeddedor.com> <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com> <30613.1533313609@turing-police.cc.vt.edu> <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com> <20180803164504.GF6591@sirena.org.uk>
 <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1533318918_3353P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Aug 2018 13:55:18 -0400
Message-ID: <39703.1533318918@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1533318918_3353P
Content-Type: text/plain; charset=us-ascii

On Fri, 03 Aug 2018 11:56:12 -0500, "Gustavo A. R. Silva" said:
> On 08/03/2018 11:45 AM, Mark Brown wrote:
> > Basically nobody ever uses OPCLK so I'd be susprised if anyone ever
> > noticed.

I wonder if nobody uses it because any attempts to do so get an error? :)

> I see. I wonder what's the best approach in this case. Should that code be
> removed instead of 'fixed'?

I'm thinking that's a spot that needs a 'break;' added.

Of course, my understanding of that code is limited to looking at the first 10
patches and the fall-through hit something reasonable, and then the last
one did a fall-through to an error return.

--==_Exmh_1533318918_3353P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW2SXBo0DS38y7CIcAQLLbAf8CUAP8aa3NdO4Wi8ii4C5O+Q0r2dJHb0z
TDLpH9cM0ZgU22oXebcJDLfuGUAAP1lT6rrxb3WfDHgEeMhLNq8tGvz0CqlJny+2
zcPUFd5IPOGfRw2PBArMNj1CECLwIGUBJODtyR0D/kCOSFpXyqCVAl3sIrimFntN
N1pVU6H474DFVRlebm3sKNJp+HYl8TfWN5drGmLsLxWkRy69OXUDQjz4J2UaCcN1
psMKJDo3PcIzariYZsFwZnU/FwanKzwUAsEP9cAE2GrCt5hyne1JLl2L+4FXn3lr
0xWFcWbe8+hwHBGcG8KYukx9e7iP67bYM8ABPuPh2CtHQjQXKqnnMQ==
=8jtF
-----END PGP SIGNATURE-----

--==_Exmh_1533318918_3353P--
