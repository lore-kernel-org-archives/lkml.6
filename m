Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6565AC67837
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B93420841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sp4dA9TR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B93420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJLFm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:42:26 -0400
Received: from ozlabs.org ([203.11.71.1]:34151 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeJLFm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:42:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42WQFv2ZLhz9s3Z;
        Fri, 12 Oct 2018 09:13:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539295987;
        bh=HvJlP7WZ4xWtn92lKPZPPXTmcHPmKk9/YK+uZ8dLAEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sp4dA9TRVz7sbxwCW7bPyUuBaGYy61OOYDrS7AMmtLr+16RiCKDnfIX2YxTdyGJKu
         0mqLeTLnJeJaV475uba9QEqgRpADPebOWcbIGjPCq+bWXwDhnpBz2vf+CBUdiMwIOO
         vzuB1d/X2jU0iR8Ppmi6WdTiP3BUPA/C7W3k8WwGJPSNudCi6kMEnUgxo/qyi3t3j9
         yvgvXqIJcH+jgZMob0AvTfzDtTLsQl5Q39tca4koUMfJ+xsD/CUKH+x9pvvPhuCT5i
         cs7mJ9Fj+HicN31bPV/Icjy1bc+/yrpiI3v9d1NHATseDK9mciF3LNcRetuYmufV1e
         vzxd0S2Dl/Big==
Date:   Fri, 12 Oct 2018 09:12:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <gregkh@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus <torvalds@linux-foundation.org>
Subject: [GIT PULL] A couple of warning fixes
Message-ID: <20181012091246.05e8d4ef@canb.auug.org.au>
In-Reply-To: <CAK8P3a3DTbcSgOEqt-zAsX9DpVSOmS6apYXXkRHK2FKc5mvW2Q@mail.gmail.com>
References: <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <20180824204756.e787765461975cd1e27502dc@kernel.org>
        <20180824224211.2934d7c0@canb.auug.org.au>
        <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
        <20180828072333.36af4d5d@canb.auug.org.au>
        <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
        <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
        <20181011114809.5590ecb3@canb.auug.org.au>
        <d5b166d6-461c-f382-e3d2-8993b845bd5a@linux.ibm.com>
        <20181011205849.6f6645fa@canb.auug.org.au>
        <20181011103750.GA29735@kroah.com>
        <CAK8P3a3DTbcSgOEqt-zAsX9DpVSOmS6apYXXkRHK2FKc5mvW2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ctpuL9E/W36PAbp7PSlxH9+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ctpuL9E/W36PAbp7PSlxH9+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

[Hopefully you and others don't mind fetching these from me directly.]
[My first pull request, let me know if I did something wrong.]

The following changes since commit 0778a9f2dd924c3af41971ba40eec44793aea531:

  Merge branch 'for-4.19-fixes' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/tj/cgroup (2018-10-11 19:24:01 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sfr/next-fixes.git tags/nex=
t-fixes-20181012

for you to fetch changes up to 52c8ee5bad8f33d02c567f6609f43d69303fc48d:

  vmlinux.lds.h: Fix linker warnings about orphan .LPBX sections (2018-10-1=
2 08:55:29 +1100)

----------------------------------------------------------------
Two fixes from Peter Oberparleiter <oberpar@linux.ibm.com>:

Commit

  6b7dca401cb1 ("tracing: Allow gcov profiling on only ftrace subsystem")

uncovered linker problems when using gcov kernel profiling on some
architectures. These problems were likely introduced earlier, and are
possibly related to compiler changes.

----------------------------------------------------------------
Peter Oberparleiter (2):
      vmlinux.lds.h: Fix incomplete .text.exit discards
      vmlinux.lds.h: Fix linker warnings about orphan .LPBX sections

 arch/arm/kernel/vmlinux.lds.h     | 2 ++
 include/asm-generic/vmlinux.lds.h | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

--=20
Cheers,
Stephen Rothwell

--Sig_/ctpuL9E/W36PAbp7PSlxH9+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu/yt4ACgkQAVBC80lX
0GwGoAf+PY8Ml6XVU/yR/op0MHvnQExzUlKzKnsI29NFY0HlDhyfKZX4b+xgd+/J
opYztMYtOgPl8cT9UwSo63Q1eMJ6Lrx5VCSPZ3mwIRAGv6FxkFzZGPNt8nFUX5zl
ZhmIzQiwSZSnKI64Glqwv3UI+FSFSwlqB7V6lYqI3jLkha4rabJ0AVD/qip3qlzU
Sfy5zu8sBghhBKuCJFxBN/y+us08/eF5ziFtMVw40Z+gHhKSg6gP+ZoxCPDPI2ey
DEHiOlvR5t2T2+GLg5pzqVGw9KUH9f93UL7p1bqGHWuOMSCHt+JeYQs3kgqdT3gZ
lSm/rlIdOba2fwnulGy19goB9FYzaQ==
=W+zP
-----END PGP SIGNATURE-----

--Sig_/ctpuL9E/W36PAbp7PSlxH9+--
