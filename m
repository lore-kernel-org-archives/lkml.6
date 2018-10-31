Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611FBECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247BC2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lj58WwUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247BC2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeKAG2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:28:19 -0400
Received: from ozlabs.org ([203.11.71.1]:60511 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725736AbeKAG2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:28:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42lhK64VNcz9s3C;
        Thu,  1 Nov 2018 08:28:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541021307;
        bh=JgnQsqUyCrj4eaVFdDoNjcXx27idJnRwSMrtkDgDf7g=;
        h=Date:From:To:Cc:Subject:From;
        b=lj58WwUWOsgVPt/s+rJtii7b9SGATwT8qujVV2STI6AwIKWnSYTjFyH8EjN/TwcMB
         FGFAgRVEO/cMFtnFtHzI+5tpdKnYWT/iw4ZexDBM0b126KBUlJL7GRGg/yf57wAASl
         U4zCJlUsqfh9XLnPZY5TxwHwgJVq47LVEmc3WweD8vqvr02bQRJtOKyMM95VZ5Sf+D
         mhjmf4q8N5w5e5RwkXaVP3sM2o9x7DAeMjXWRtoa9X1blQDn7hQGh1tG8MmdTApP2w
         MUdW+KCcoss9nRR2tfYIPfXvnqJNWa0N4i+drPtHw3R6LZ38p5iVKrZwJFZ2dgndX2
         uNwLMxy6MqVVA==
Date:   Thu, 1 Nov 2018 08:28:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: linux-next: build warning in Linus' tree tree
Message-ID: <20181101082820.76abf19e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/S4J=K4+oMH9+GRcnjJfR.d4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S4J=K4+oMH9+GRcnjJfR.d4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Building Linus' tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

./usr/include/linux/v4l2-controls.h:1105: found __[us]{8,16,32,64} type wit=
hout #include <linux/types.h>

Introduced by commit

  c27bb30e7b6d ("media: v4l: Add definitions for MPEG-2 slice format and me=
tadata")

--=20
Cheers,
Stephen Rothwell

--Sig_/S4J=K4+oMH9+GRcnjJfR.d4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvaHnQACgkQAVBC80lX
0GzcKgf/aWgqqX6RVS+KzpGjxjYbjuj2PCYdkuJPnjcs4z71HaBfvuB+r0gPKbkX
QPu4MGDGvj4SETaE8EqEMTC0dJ8sO8jIW8B+HvYZGqCbP3tp4M9mF8guJiAWiVeK
IvvS0I0lGd9eI7/np71t4V4JYvwkQxcN2fGuo214ErznU8ynl18cqO8lZnd7NSes
++FhL+3ssslIeL6gc5A6QJ3EAeaJfFCpCfMD9okVDJt5oafd74ruSGcLvwnNnY9P
64Xmp/bhuF78saLlunz/1BNx3293jRBoXFIyaOPvO0isWsR31u+PioEQU+1ouG/U
YZHpKMTz2P+bCPjzOIRolnewBPH8sw==
=i9P6
-----END PGP SIGNATURE-----

--Sig_/S4J=K4+oMH9+GRcnjJfR.d4--
