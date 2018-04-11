Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeDKFWs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:22:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37405 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeDKFWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:22:33 -0400
From: John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] apparmor updates for v4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM"
        <linux-security-module@vger.kernel.org>
Organization: Canonical
Message-ID: <70d319b8-4cf7-117b-8369-1490bf45176a@canonical.com>
Date: Tue, 10 Apr 2018 22:22:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XAcIuJDh9s7BoAXSiRWJaEg4VAmpxU0aU"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XAcIuJDh9s7BoAXSiRWJaEg4VAmpxU0aU
Content-Type: multipart/mixed; boundary="XOtFii0vtWNi0kMLghMtTL6ibFo419u6H";
 protected-headers="v1"
From: John Johansen <john.johansen@canonical.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKLM <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Message-ID: <70d319b8-4cf7-117b-8369-1490bf45176a@canonical.com>
Subject: [GIT PULL] apparmor updates for v4.17

--XOtFii0vtWNi0kMLghMtTL6ibFo419u6H
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,


Please pull these apparmor changes for v4.17

Thanks!

- John

The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8=
ff:

  Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/ap=
parmor-pr-2018-04-10

for you to fetch changes up to 588558eb6d0e0b6edfa65a67e906c2ffeba63ff1:

  apparmor: fix memory leak on buffer on error exit path (2018-03-30 21:1=
4:04 -0700)

----------------------------------------------------------------
+ Features
  - add base infrastructure for socket mediation. ABI bump and
    additional checks to ensure only v8 compliant policy uses
    socket af mediation.
  - improve and cleanup dfa verification
  - improve profile attachment logic
    - improve overlapping expression handling
    - add the xattr matching to the attachment logic
  - improve signal mediation handling with stacked labels
  - improve handling of no_new_privs in a label stack

+ Cleanups and changes
  - use dfa to parse string split
  - bounded version of label_parse
  - proper line wrap nulldfa.in
  - split context out into task and cred naming to better match usage
  - simplify code in aafs

+ Bug fixes
  - fix display of .ns_name for containers
  - fix resource audit messages when auditing peer
  - fix logging of the existence test for signals
  - fix resource audit messages when auditing peer
  - fix display of .ns_name for containers
  - fix an error code in verify_table_headers()
  - fix memory leak on buffer on error exit path
  - fix error returns checks by making size a ssize_t

----------------------------------------------------------------
Colin Ian King (2):
      apparmor: fix error returns checks by making size a ssize_t
      apparmor: fix memory leak on buffer on error exit path

Dan Carpenter (1):
      apparmor: Fix an error code in verify_table_headers()

John Johansen (31):
      apparmor: fix display of .ns_name for containers
      apparmor: fix resource audit messages when auditing peer
      apparmor: fix logging of the existence test for signals
      apparmor: split load data into management struct and data blob
      apparmor: add first substr match to dfa
      apparmor: use the dfa to do label parse string splitting
      apparmor: provide a bounded version of label_parse
      apparmor: cleanup add proper line wrapping to nulldfa.in
      apparmor: root view labels should not be under user control
      apparmor: make signal label match work when matching stacked labels=

      apparmor: audit unknown signal numbers
      apparmor: rename task_ctx to the more accurate cred_ctx
      apparmor: move task domain change info to task security
      apparmor: drop cred_ctx and reference the label directly
      apparmor: rename tctx to ctx
      apparmor: cleanup fixup description of aa_replace_profiles
      apparmor: cleanup, drop unused fn __aa_task_is_confined()
      apparmor: move task related defines and fns to task.X files
      apparmor: move context.h to cred.h
      apparmor: update domain transitions that are subsets of confinement=
 at nnp
      apparmor: dfa move character match into a macro
      apparmor: dfa add support for state differential encoding
      apparmor: dfa split verification of table headers
      apparmor: cleanup create_aafs() error path
      apparmor: cleanup: simplify code to get ns symlink name
      apparmor: convert attaching profiles via xattrs to use dfa matching=

      apparmor: improve overlapping domain attachment resolution
      apparmor: add base infastructure for socket mediation
      apparmor: remove POLICY_MEDIATES_SAFE
      apparmor: update MAINTAINERS file git and wiki locations
      apparmor: fix dangling symlinks to policy rawdata after replacement=


Matthew Garrett (1):
      apparmor: Add support for attaching profiles via xattr, presence an=
d value

Pravin Shedge (1):
      security: apparmor: remove duplicate includes

 MAINTAINERS                                     |   4 +-
 security/apparmor/.gitignore                    |   1 +
 security/apparmor/Makefile                      |  45 ++-
 security/apparmor/apparmorfs.c                  | 203 ++++++----
 security/apparmor/capability.c                  |   2 +-
 security/apparmor/domain.c                      | 355 +++++++++++++-----=

 security/apparmor/file.c                        |  32 +-
 security/apparmor/include/apparmor.h            |   3 +-
 security/apparmor/include/audit.h               |  19 +-
 security/apparmor/include/{context.h =3D> cred.h} |  63 +---
 security/apparmor/include/label.h               |  28 ++
 security/apparmor/include/match.h               |  28 ++
 security/apparmor/include/net.h                 | 106 ++++++
 security/apparmor/include/perms.h               |   5 +-
 security/apparmor/include/policy.h              |  23 +-
 security/apparmor/include/policy_unpack.h       |   2 +-
 security/apparmor/include/sig_names.h           |   5 +-
 security/apparmor/include/task.h                |  94 +++++
 security/apparmor/ipc.c                         |  52 +--
 security/apparmor/label.c                       |  42 ++-
 security/apparmor/lib.c                         |   5 +-
 security/apparmor/lsm.c                         | 467 ++++++++++++++++++=
++++--
 security/apparmor/match.c                       | 423 +++++++++++++++++-=
---
 security/apparmor/mount.c                       |   2 +-
 security/apparmor/net.c                         | 187 ++++++++++
 security/apparmor/nulldfa.in                    | 108 +++++-
 security/apparmor/policy.c                      |  11 +-
 security/apparmor/policy_ns.c                   |   2 +-
 security/apparmor/policy_unpack.c               |  70 +++-
 security/apparmor/procattr.c                    |   2 +-
 security/apparmor/resource.c                    |   2 +-
 security/apparmor/stacksplitdfa.in              | 114 ++++++
 security/apparmor/{context.c =3D> task.c}         | 139 +++----
 33 files changed, 2119 insertions(+), 525 deletions(-)
 rename security/apparmor/include/{context.h =3D> cred.h} (70%)
 create mode 100644 security/apparmor/include/net.h
 create mode 100644 security/apparmor/include/task.h
 create mode 100644 security/apparmor/net.c
 create mode 100644 security/apparmor/stacksplitdfa.in
 rename security/apparmor/{context.c =3D> task.c} (53%)


--XOtFii0vtWNi0kMLghMtTL6ibFo419u6H--

--XAcIuJDh9s7BoAXSiRWJaEg4VAmpxU0aU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIbBAEBCgAGBQJazZuVAAoJEAUvNnAY1cPYop8P914oykIW63mbObFDd3nZh5B9
mbMOnS/a//cSlduTd/SNsoR8QO09L0LHSoRkYv+C3VHZcGM73KfQ4bRD32R/91ef
/viXbU7G60bwQtg3moInoOPNkpnLJj9Z2K++8aBCH+nd1f0DSucgYKxLRar15Opk
nzf9UC3aAZxX4unx1i2mFFZNK39Xm7X0E/0opJzbsQODcxgzn0eHhsF993YAO5di
EEWZ+M7eF52X48bOZY4GBeX1JLwDARq78byWy0JrppSDp6TFx2caVvScd8346Z9z
A+VIAiy7cQDl4r4W7Mrn6curFgzzO2QEeYtFBPiXWYZTs0VA60m+4Dw666DA6G/W
sx5hN3NeQ2Lt+Luw7KljHPuHkjLwqqGQqzvt/G6IA0exQp337l5JNMa593IHQAQW
IRSxw5u7yQVVoKkxQuRdKcV/lWfPPPLxzykUaATNC5yoz0SD08dOdXBGEKvoS7nu
806GTqGN9CDe1E3cHnxONoWX9qN6ESSJWKLjJUdhmQMHt7KiPdIsuFGGeKx8K/d1
XIjPOfXZDDDrS57OYdlZOTGuYGGi77vnIBrWDr4cwmq2mrijd5AMzj3ZmGbEDpUU
xFfrJXwv7EQKA3VNvsmXJG4vp62/IcfrgRvs00PuSy3WXPPr0LS5+h3vDJ12Uomw
8l3YqMHy4vI849cQJsk=
=RP3C
-----END PGP SIGNATURE-----

--XAcIuJDh9s7BoAXSiRWJaEg4VAmpxU0aU--
