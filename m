Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F61DC65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEE9206B2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEE9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeJFT1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 15:27:36 -0400
Received: from ozlabs.org ([203.11.71.1]:60647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbeJFT1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 15:27:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42S5R052Q2z9s4Z;
        Sat,  6 Oct 2018 22:24:28 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     christophe.leroy@c-s.fr, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        srikar@linux.vnet.ibm.com, herbert@gondor.apana.org.au
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.19-4 tag
Date:   Sat, 06 Oct 2018 22:24:28 +1000
Message-ID: <87y3bbi7pf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Greg,

Please pull some more powerpc fixes for 4.19:

The following changes since commit 7e0cf1c983b5b24426d130fd949a055d520acc9a:

  selftests/powerpc: Fix Makefiles for headers_install change (2018-09-28 15:07:45 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.19-4

for you to fetch changes up to ac1788cc7da4ce54edcfd2e499afdb0a23d5c41d:

  powerpc/numa: Skip onlining a offline node in kdump path (2018-10-05 23:21:54 +1000)

- ------------------------------------------------------------------
powerpc fixes for 4.19 #4

Four regression fixes.

A fix for a change to lib/xz which broke our zImage loader when building with XZ
compression. OK'ed by Herbert who merged the original patch.

The recent fix we did to avoid patching __init text broke some 32-bit machines,
fix that.

Our show_user_instructions() could be tricked into printing kernel memory, add a
check to avoid that.

And a fix for a change to our NUMA initialisation logic, which causes crashes in
some kdump configurations.

Thanks to:
  Christophe Leroy, Hari Bathini, Jann Horn, Joel Stanley, Meelis Roos, Murilo
  Opsfelder Araujo, Srikar Dronamraju.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc/lib: fix book3s/32 boot failure due to code patching

Joel Stanley (1):
      lib/xz: Put CRC32_POLY_LE in xz_private.h

Michael Ellerman (1):
      powerpc: Don't print kernel instructions in show_user_instructions()

Srikar Dronamraju (1):
      powerpc/numa: Skip onlining a offline node in kdump path


 arch/powerpc/kernel/process.c    | 10 ++++++++++
 arch/powerpc/lib/code-patching.c | 20 ++++++++++++--------
 arch/powerpc/mm/numa.c           |  5 +++--
 lib/xz/xz_crc32.c                |  1 -
 lib/xz/xz_private.h              |  4 ++++
 5 files changed, 29 insertions(+), 11 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAlu4qRMACgkQUevqPMjh
pYDEmRAAg7zDF379BIYZ9cCtyaEsPr1Qozu4qMKlq0cwhNSBNIC6AIjxlYqbRVcX
qmlvfSCfxEXxFOWLVxVxChNtYHTkRnhK0UFus6DszsJcBwxNlJCfXS8ufhOFDlpt
OKBx1bqS3NIiWhSXOzSmwHY9L4o/oyiZKjfk4HJ/7er0woS20bF3pHtXPdsuEjno
dSMftLI5YYKWSKAfsv1z6zSQRdxWOqM3Zd+Zpnvp9oTNSgqPvRFU9JwnGXVbJHOk
mQsJalMCOnbVphW8XnImbtW7TQfkbctmN95rl/OcEVm39QX4UL7suAJih5Z45TIU
mYuXXH6gTahGd4N3RfGUf2QO/3pQOiPOpywuqey/Pa68Bc5b2/fvySQ2sdMhE6yJ
rMfYlXDlFd/xL63d231QR8DiTzSdDHhDUo7T6R12fJK2f/q5Sng6rJj/71o68lun
9v/Jvt/G/Z9w25AUsPO2zlS/rIVP7C7EGknycBe5UwC2DRx7HCtKwFjOb0e2BY23
ysqF3Jpk+TsLBES4ye9vafhhDlGZg/cuej0OWFf0Ca/bi1fV59Hw2XaI3qj+VsFf
psl/DcJE8+EyDUVAVloYaM8yr96QJdH7+I9Ea/8FC4cyJSIAiMzrlrTp/zonzbQl
hbMVjZujVrQiNdbJ+irb7bCpaAPXdP81CK4FSGGyRvJ0Jycnvno=
=u2T9
-----END PGP SIGNATURE-----
