Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbeEKNls (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:41:48 -0400
Received: from ozlabs.org ([203.11.71.1]:40873 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbeEKNlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:41:47 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        naveen.n.rao@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.17-5 tag
Date: Fri, 11 May 2018 23:41:43 +1000
Message-ID: <87k1saqpgo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 4.17:

The following changes since commit b2d7ecbe355698010a6b7a15eb179e09eb3d6a34:

  powerpc/kvm/booke: Fix altivec related build break (2018-04-27 16:36:03 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.17-5

for you to fetch changes up to 6c0a8f6b5a45ac892a763b6299bd3c5324fc5e02:

  powerpc/pseries: Fix CONFIG_NUMA=n build (2018-05-08 14:59:56 +1000)

- ----------------------------------------------------------------
powerpc fixes for 4.17 #5

One fix for an actual regression, the change to the SYSCALL_DEFINE wrapper broke
FTRACE_SYSCALLS for us due to a name mismatch. There's also another commit to
the same code to make sure we match all our syscalls with various prefixes.

And then just one minor build fix, and the removal of an unused variable that
was removed and then snuck back in due to some rebasing.

Thanks to:
  Naveen N. Rao.

- ----------------------------------------------------------------
Michael Ellerman (2):
      powerpc/64: Remove unused paca->soft_enabled
      powerpc/pseries: Fix CONFIG_NUMA=n build

Naveen N. Rao (2):
      powerpc/trace/syscalls: Update syscall name matching logic
      powerpc/trace/syscalls: Update syscall name matching logic to account for ppc_ prefix

 arch/powerpc/include/asm/ftrace.h   | 29 +++++++++++++++++++++--------
 arch/powerpc/include/asm/paca.h     |  1 -
 arch/powerpc/include/asm/topology.h | 13 +++++--------
 3 files changed, 26 insertions(+), 17 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJa9Z2YAAoJEFHr6jzI4aWAS/IQAJwlHONhDnkjycj5hWQbmYuU
tRBckKHixyiB5r9trAhpiO7H78dod880qORM/Qvx4f/2fhs+2kNOAD5BJlAwfjg2
0OgJJWMXE6i5IPFzALwWn8rmUHWRaimYaOW+oGh+ieN0nup80OFQwZMLB28CUdGX
b4Nu0c+1jtc9TO5R4zbaDysCVA9xbQjEv0WffwrV5PFDoDm7cxy8cp/RqU1xwZwi
ar07SPM6eu+cUx9NqMpKG75wO2lh2KuqBSYqH3wxlxSSpygLSutdy/hQRZqqQJKF
sNFmb239OIDayTH38Ht2GADl7W+qbJSLmdpqhNvmu3xgnprEd6Ipf3M5hmkSksb/
/0ppzvGfFNOleBRMIOawTgRa7er+AsDZUuC65JZuEkGv1eNXMcALWy8/UCQ3gyQV
jlxL8JoWoTW8AqDgJvb50GDCDxvZpZNGebARWc57A2OkvhHTLG+DqYE/oVHKCyZM
wkCnHHsBOsS+0p/qOPIHuwvu1l03EsuY/K1D1tkWrqAjJX5MTIA9rn4R9zMZnDPb
9UXxPymYazMaJ5yKzbMZmsLNjntu9ltQi8aS1l1FwTrubYzdohagjdg3unOMwcHv
UAHPK609fhOncfylPNWlqaG4CjWRNyqBB6zGSSmj8v7Pg65VxhrgNac5ES8RbbN2
GZUrjS71LSRFiwqYK4+j
=nibe
-----END PGP SIGNATURE-----
