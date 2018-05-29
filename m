Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965258AbeE2RBX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:01:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51900 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965031AbeE2RBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:01:20 -0400
X-Google-Smtp-Source: ADUXVKKpCP/lio/OAwQo8nq9Q174U9hQfb84g3lwKnzLw4q1DmlGMoXfAjmSD6OIqZDw8aoyg+ezXA==
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.17.1, v2.13.7, v2.14.4, v2.15.2 and v2.16.4
Date: Wed, 30 May 2018 02:01:17 +0900
Message-ID: <xmqqy3g2flb6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release Git v2.17.1 and updates to older
maintenance tracks are now available at the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.17.1'
tag and the 'maint' branch that the tag points at, as well as the
v2.13.7, v2.14.4, v2.15.2 and v2.16.4 tags:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.17.1 Release Notes
=========================

Fixes since v2.17
-----------------

 * This release contains the same fixes made in the v2.13.7 version of
   Git, covering CVE-2018-11233 and 11235, and forward-ported to
   v2.14.4, v2.15.2 and v2.16.4 releases.  See release notes to
   v2.13.7 for details.

 * In addition to the above fixes, this release adds support on the
   server side that reject pushes to repositories that attempt to
   create such problematic .gitmodules file etc. as tracked
   contents, to help hosting sites protect their customers with
   older clients by preventing malicious contents from spreading.
   This is enabled by the same receive.fsckObjects configuration on
   the server side as other security and sanity related checks
   (e.g. rejecting tree entry ".GIT" in a wrong case as tracked
   contents, targetting victims on case insensitive systems) that
   have already been implemented in the past releases.  It is
   recommended to double check your configuration if you are hosting
   contents for other people.


Git v2.13.7 Release Notes
=========================

Fixes since v2.13.6
-------------------

 * Submodule "names" come from the untrusted .gitmodules file, but we
   blindly append them to $GIT_DIR/modules to create our on-disk repo
   paths. This means you can do bad things by putting "../" into the
   name. We now enforce some rules for submodule names which will cause
   Git to ignore these malicious names (CVE-2018-11235).

   Credit for finding this vulnerability and the proof of concept from
   which the test script was adapted goes to Etienne Stalmans.

 * It was possible to trick the code that sanity-checks paths on NTFS
   into reading random piece of memory (CVE-2018-11233).

Credit for fixing for these bugs goes to Jeff King, Johannes
Schindelin and others.

----------------------------------------------------------------
