Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeBIUTY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 15:19:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43172 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeBIUTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 15:19:23 -0500
From: John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] apparmor updates for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM"
        <linux-security-module@vger.kernel.org>
Organization: Canonical
Message-ID: <8b079d9c-f436-eb11-0060-9cad1525aa62@canonical.com>
Date: Fri, 9 Feb 2018 12:19:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="FCO7iKlPcarwwbsh4yrSvRTmGld1dIUxI"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FCO7iKlPcarwwbsh4yrSvRTmGld1dIUxI
Content-Type: multipart/mixed; boundary="LT76AdarAkyXKN1yhvyImRp7fJoeml157";
 protected-headers="v1"
From: John Johansen <john.johansen@canonical.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKLM <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Message-ID: <8b079d9c-f436-eb11-0060-9cad1525aa62@canonical.com>
Subject: [GIT PULL] apparmor updates for v4.16

--LT76AdarAkyXKN1yhvyImRp7fJoeml157
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,


Please pull these apparmor changes for v4.16

Thanks!

- John


The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8=
ff:

  Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/ap=
parmor-pr-2018-02-09

for you to fetch changes up to ad2b3884f07f95f9e0dd897ae56d6c82ad7b00e8:

  apparmor: add base infastructure for socket mediation (2018-02-09 11:30=
:02 -0800)

----------------------------------------------------------------
apparmor pull-request for 4.16

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

----------------------------------------------------------------
John Johansen (28):
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

Matthew Garrett (1):
      apparmor: Add support for attaching profiles via xattr, presence an=
d value

Pravin Shedge (1):
      security: apparmor: remove duplicate includes

 security/apparmor/.gitignore                    |   1 +
 security/apparmor/Makefile                      |  45 ++-
 security/apparmor/apparmorfs.c                  |  73 ++--
 security/apparmor/capability.c                  |   2 +-
 security/apparmor/domain.c                      | 355 +++++++++++++-----=

 security/apparmor/file.c                        |  32 +-
 security/apparmor/include/audit.h               |  19 +-
 security/apparmor/include/{context.h =3D> cred.h} |  63 +---
 security/apparmor/include/label.h               |  28 ++
 security/apparmor/include/match.h               |  28 ++
 security/apparmor/include/net.h                 | 114 ++++++
 security/apparmor/include/perms.h               |   5 +-
 security/apparmor/include/policy.h              |  17 +
 security/apparmor/include/policy_unpack.h       |   2 +-
 security/apparmor/include/sig_names.h           |   5 +-
 security/apparmor/include/task.h                |  94 +++++
 security/apparmor/ipc.c                         |  52 +--
 security/apparmor/label.c                       |  42 ++-
 security/apparmor/lib.c                         |   5 +-
 security/apparmor/lsm.c                         | 462 ++++++++++++++++++=
++++--
 security/apparmor/match.c                       | 423 ++++++++++++++++++=
----
 security/apparmor/mount.c                       |   2 +-
 security/apparmor/net.c                         | 185 ++++++++++
 security/apparmor/nulldfa.in                    | 108 +++++-
 security/apparmor/policy.c                      |  11 +-
 security/apparmor/policy_ns.c                   |   2 +-
 security/apparmor/policy_unpack.c               | 117 +++++-
 security/apparmor/procattr.c                    |   2 +-
 security/apparmor/resource.c                    |   2 +-
 security/apparmor/stacksplitdfa.in              | 114 ++++++
 security/apparmor/{context.c =3D> task.c}         | 139 +++----
 31 files changed, 2067 insertions(+), 482 deletions(-)
 rename security/apparmor/include/{context.h =3D> cred.h} (70%)
 create mode 100644 security/apparmor/include/net.h
 create mode 100644 security/apparmor/include/task.h
 create mode 100644 security/apparmor/net.c
 create mode 100644 security/apparmor/stacksplitdfa.in
 rename security/apparmor/{context.c =3D> task.c} (53%)


--LT76AdarAkyXKN1yhvyImRp7fJoeml157--

--FCO7iKlPcarwwbsh4yrSvRTmGld1dIUxI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJafgJHAAoJEAUvNnAY1cPYA/MP/21mmnusyO+7iVSzfZaDj4qg
6r/4Ih7DG4YkhLpUL+Ko+SJs4hB8aNSFli/moNfEuLO71tsfUJHjonkqNDkh0Hh7
OlWe2TySUICzm3SWV13/NLtbfRafzGknvwuoqn/kli2Q+NvJu/SjIqNf2qwcT4DH
uTZUkdWHHoZygkpqVznquncoeHOADdgJIlJ8g9U4J8C4ueLpKmGIJ8RC7DHG+p0+
Qn0I7OAMPTeXpj/COmd58ZVTMBhVuCIdh1uGTwMh8G9ec3bZE9QuclHW5stvLHEP
CrVYNS2IugKE27dE3TJ7S7zqoH2Wmpg4L9Q30Z+LKjecFjVISO5IvsgpKwMzwirH
XpDLZiztbxvXTR+jig24ja35S7z1UP4NblH5A5sC4RJK103bqbxMXyHLhTPxIH0J
+5GA1tbRc9nkrKq6NRGSPRJCAfMifR2cxnpV5epsLAhTAW2QcPNOCXOewybaNkla
4TgpA9r2I9J6+v4qstOvCLuu7e7k05S1bqi4NpNV0VjzOxVeet2GwcNVmLigcnqs
/GY+m+8r5kLzNNQM41Y3cIFSF9y60G0D1cGkVvDJBUXld+zc814oPq1FaVZwt3PY
wP6CsY0tNWUOWK7FZ6dkwKkbJLZxIe/aUUZkta0pXT+ljlZO4rztiZwNgFTqyVIB
ZQcVk6L+klL7TXResVqe
=X6xM
-----END PGP SIGNATURE-----

--FCO7iKlPcarwwbsh4yrSvRTmGld1dIUxI--
