Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35695C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0009208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L823Nhq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0009208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeHBFzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:55:42 -0400
Received: from ozlabs.org ([203.11.71.1]:37635 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbeHBFzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:55:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gxSR6MlFz9s0R;
        Thu,  2 Aug 2018 14:06:31 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533182791;
        bh=rZLbmbanPbXVV6eTPyKNSrO4Uu2s4JWT+kV30ESK2Z8=;
        h=Date:From:To:Cc:Subject:From;
        b=L823Nhq5cj7jmOPUW9HkPSrgjsEhrKebJdp+gDAn3ysooD7Zjqm/ZTJO4y48q8KiB
         4ScBrFVzJEr2m52Hj2Fyr7VHv3GVLxq1z9Oege18lzCvuiORa5hoEwslXTxFafKWGi
         zha+2kK0sJurZvQtJp8cCKnInbrRGho9n55D7Ov50dgO9GNX/zHyqBrENiRntS0gVy
         wKp4y8DSLdGB/yMR+BzzMWjtaYnEyW6x98ir7gzboOv94Pd6yfqkO26/NOTrT4JvEg
         SprdGPtJVPP1G17ahpLBgefDFWS58xQlWxDIWUCOkUzqHpvEdXW7PdHVPoGkvcNIG+
         umktc0kYWrxzA==
Date:   Thu, 2 Aug 2018 14:06:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20180802140630.7618b9d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fu4qPo_36Zq/xl/Y6r3sLCJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fu4qPo_36Zq/xl/Y6r3sLCJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: unmet direct dependencies detected for SND_SOC_QDSP6
  Depends on [n]: SOUND [=3Dm] && !UML && SND [=3Dm] && SND_SOC [=3Dm] && Q=
COM_APR [=3Dn] && HAS_DMA [=3Dy]
  Selected by [m]:
  - SND_SOC_SDM845 [=3Dm] && SOUND [=3Dm] && !UML && SND [=3Dm] && SND_SOC =
[=3Dm]

Introduced by commit

  6b1687bf76ef ("ASoC: qcom: add sdm845 sound card support")

--=20
Cheers,
Stephen Rothwell

--Sig_/fu4qPo_36Zq/xl/Y6r3sLCJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltig0YACgkQAVBC80lX
0Gwr2Qf/YzcvpELTqK+2twSOMiBXWDwoVM1JdWi6sUFm99u31dwPVzTm0dZLm8t5
lLkx0lJ88XYDvi/cIEOTgrG2SZuouBNQaNEkCGJOy1g/QALZu+t4KKWCkt3e8UiJ
S2TvfdTmFUmhOA+23SrBnUixIlWQvVrBS+vQZKVS/6zr5SJAYammtQEAo4ntlTCU
mqYyKGf+G/JMo5kmZzSKtUIVgM+9odQxzxBiDuKjMplaHsLWGEeM8fj1LbHUWAtv
v5aeNZeEoFzO4WOau16DAi/HAgAaVAN4MyRNsG4xcyZ7KekMtOezvbfAvmZHDwR0
kfgu0rNsDJcmAucm9b0hnCH8xNJbIQ==
=R9UE
-----END PGP SIGNATURE-----

--Sig_/fu4qPo_36Zq/xl/Y6r3sLCJ--
