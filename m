Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF1AC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1752152C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDAxTR4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1752152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeHMNmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbeHMNmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:42:16 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 403402152C;
        Mon, 13 Aug 2018 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534158030;
        bh=pghY/dmGO1l8koea/Uvpa0p4Jrmugo33rYrxD4K9dYk=;
        h=Subject:From:To:Cc:Date:From;
        b=BDAxTR4o9gZBL/4644eZuWc6d50tKUsV9hnbfQWUtXGyajwnFUM+RBNModTBpCF4+
         nRTBStzPse7CtCK8MT9vFhegnJ/BeSrJ5yXigVbRxfuklmO/lpemrmPF2ffQr1f50u
         wZpSl05gfXezs5I5fQHcsAW6zsumSV/RsrqjmTgk=
Message-ID: <a7bddd53bf70f7aeb2c761ab84411bd2a285d7af.camel@kernel.org>
Subject: [GIT PULL] file locking updates for 4.19
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Bruce Fields <bfields@fieldses.org>
Date:   Mon, 13 Aug 2018 07:00:23 -0400
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/Ty7EMG8IRYuKkwIglNe"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/Ty7EMG8IRYuKkwIglNe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 2837461dbe6f4a9acc0d86f88825888109211c99=
:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/j=
ejb/scsi (2018-06-14 16:35:32 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/lock=
s-v4.19-1

for you to fetch changes up to da33a871ba178dbe81da7d755818d3c2088cae32:

  locks: remove misleading obsolete comment (2018-08-08 12:59:06 -0400)

----------------------------------------------------------------

Just a couple of patches from Konstantin to fix /proc/locks when the
process that set the lock has exited, and a new tracepoint for the
flock() codepath. Also threw in mailmap entries for my addresses and a
comment cleanup.

----------------------------------------------------------------
Jeff Layton (3):
      locks: add tracepoint in flock codepath
      mailmap: remap some of my email addresses to kernel.org address
      locks: remove misleading obsolete comment

Konstantin Khorenko (2):
      fs/lock: skip lock owner pid translation in case we are in init_pid_n=
s
      fs/lock: show locks taken by processes from another pidns

 .mailmap                        |  3 +++
 fs/locks.c                      | 20 +++++++++++---------
 include/trace/events/filelock.h |  5 ++++-
 3 files changed, 18 insertions(+), 10 deletions(-)
--=20
Jeff Layton <jlayton@kernel.org>

--=-/Ty7EMG8IRYuKkwIglNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAltxZMcTHGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFYq+D/9y4xNLel4vXcLmZIyWA+a+s+kxAqao
PiTMbmRa/4FwE7QIc3g82kWDkioSJ5sadE1j+GozH1Lp0mEOGbS7LHxOdQiMoSwN
sqrH3cC1144SRAGZm2Ryn0KuFWdWHWs513QmWg5T7M1iHs6Peb2kDlp+rpvVUPpH
pmRgPWn6EChMsCJNoeQPNb9aoU0om1CCSnAalb6nJ4gTwunewH0t5FgSOP30mV6q
lHPAeFrJ6CVVuZzvBFAUc18+EkY/QQjlCjYIOdF4dj28IovADpu/9YcNBoVA3Pex
wM//5yGwn94JeLaetNicYWMjVVRuesS/JyRU948eDepUBhDoW6Kw4aK1u7Au9tpM
4xSZx4H3spDCDFzteDF3oXxeq2Xga53UsLz2YYECcoqo1EoRnjuy72c2KVErA9hJ
KVmcAE29zseWVXQVAK7IOPuagP/IsGukGifAq2WBX2YRGLGFVpXJ4u/qrMLS8cJd
0QHEkaUP1HjYtE7witkfGqMSEEpOFKhHwYAxPw9u+dEnFMhLmra7pcIvevto0mrK
CO7DGcP4wB9gCKB5HIkA2x7WaVwaKJEzuME2gV6hRUAVbSuIwdWOjms7UljJQm3z
aCWo2cY3Tv6AWVWJw8EGSMT+MHL0nYRYngt/Dm5h00+aciZBVWuEjIle3nMq+Jm3
jONK19/hS0OSYA==
=X8Ts
-----END PGP SIGNATURE-----

--=-/Ty7EMG8IRYuKkwIglNe--

