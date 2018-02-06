Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeBFQzI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:55:08 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37296 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbeBFQv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:51:56 -0500
X-Google-Smtp-Source: AH8x224pK9uLLAydMvFKt8Cs+02ZYY5WUdrqPEI6qplc2k1Htt+MO3lJ4JCczgP2VYFV3ljccwXOsg==
From: konstantin@linuxfoundation.org
To: corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH] Documentation/process: tweak pgp maintainer guide
Date: Tue,  6 Feb 2018 11:51:19 -0500
Message-Id: <20180206165119.18272-1-konstantin@linuxfoundation.org>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

Based on the feedback provided:

- Uniformly use lowercase k in "Linux kernel"
- Give a one-sentence explanation of what subkeys are
- Explain what signed commits might be useful for even if upstream
  developers do not use them for much of anything
- Admonish to set up gpg-agent if signed commits are turned on in
  git config
- Fix a typo reported by Luc Van Oostenryck

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 Documentation/process/maintainer-pgp-guide.rst | 50 +++++++++++++++++---------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index 28674eb42b95..b453561a7148 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -18,10 +18,10 @@ The role of PGP in Linux Kernel development
 ===========================================
 
 PGP helps ensure the integrity of the code that is produced by the Linux
-Kernel development community and, to a lesser degree, establish trusted
+kernel development community and, to a lesser degree, establish trusted
 communication channels between developers via PGP-signed email exchange.
 
-The Linux Kernel source code is available in two main formats:
+The Linux kernel source code is available in two main formats:
 
 - Distributed source repositories (git)
 - Periodic release snapshots (tarballs)
@@ -53,7 +53,7 @@ want to make sure that by placing trust into developers we do not simply
 shift the blame for potential future security incidents to someone else.
 The goal is to provide a set of guidelines developers can use to create
 a secure working environment and safeguard the PGP keys used to
-establish the integrity of the Linux Kernel itself.
+establish the integrity of the Linux kernel itself.
 
 .. _pgp_tools:
 
@@ -139,7 +139,7 @@ Protect your master PGP key
 ===========================
 
 This guide assumes that you already have a PGP key that you use for Linux
-Kernel development purposes. If you do not yet have one, please see the
+kernel development purposes. If you do not yet have one, please see the
 "`Protecting Code Integrity`_" document mentioned earlier for guidance
 on how to create a new one.
 
@@ -149,7 +149,9 @@ You should also make a new key if your current one is weaker than 2048 bits
 Master key vs. Subkeys
 ----------------------
 
-It is important to understand the following:
+Subkeys are fully independent PGP keypairs that are tied to the "master"
+key using certifying key signatures (certificates). It is important to
+understand the following:
 
 1. There are no technical differences between the "master key" and "subkeys."
 2. At creation time, we assign functional limitations to each key by
@@ -742,17 +744,29 @@ How to work with signed commits
 -------------------------------
 
 It is easy to create signed commits, but it is much more difficult to
-use them in Linux Kernel development, since it relies on patches sent to
+use them in Linux kernel development, since it relies on patches sent to
 the mailing list, and this workflow does not preserve PGP commit
-signatures.
-
-If you have your working git tree publicly available at some git hosting
-service (kernel.org, infradead.org, ozlabs.org, or others), then the
-recommendation is that you sign all your git commits even if upstream
-developers do not directly benefit from this practice. Should there ever
-be a need to perform code forensics or track code provenance, even
-externally maintained trees carrying PGP commit signatures will be
-extremely valuable for such purposes.
+signatures. Furthermore, when rebasing your repository to match
+upstream, even your own PGP commit signatures will end up discarded. For
+this reason, most kernel developers don't bother signing their commits
+and will ignore signed commits in any external repositories that they
+rely upon in their work.
+
+However, if you have your working git tree publicly available at some
+git hosting service (kernel.org, infradead.org, ozlabs.org, or others),
+then the recommendation is that you sign all your git commits even if
+upstream developers do not directly benefit from this practice.
+
+We recommend this for the following reasons:
+
+1. Should there ever be a need to perform code forensics or track code
+   provenance, even externally maintained trees carrying PGP commit
+   signatures will be valuable for such purposes.
+2. If you ever need to re-clone your local repository (for example,
+   after a disk failure), this lets you easily verify the repository
+   integrity before resuming your work.
+3. If someone needs to cherry-pick your commits, this allows them to
+   quickly verify their integrity before applying them.
 
 Creating signed commits
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -770,6 +784,10 @@ You can tell git to always sign commits::
 
     git config --global commit.gpgSign true
 
+.. note::
+
+    Make sure you configure ``gpg-agent`` before you turn this on.
+
 .. _verify_identities:
 
 How to verify kernel developer identities
@@ -882,7 +900,7 @@ Locate the ID of the master key in the output, in our example
 ``C94035C21B4F2AEB``. Now display the key of Linus Torvalds that you
 have on your keyring::
 
-    $ git --list-key torvalds@kernel.org
+    $ gpg --list-key torvalds@kernel.org
     pub   rsa2048 2011-09-20 [SC]
           ABAF11C65A2970B130ABE3C479BE3E4300411886
     uid           [ unknown] Linus Torvalds <torvalds@kernel.org>
-- 
2.13.6
