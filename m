Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162534AbeBPRzg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:55:36 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35450 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162497AbeBPRz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:55:26 -0500
X-Google-Smtp-Source: AH8x224RQDYr5rI1i2Dr5wlYNrUFoGDgL/p8CgtioVR7V+mWccn0zYh8WiqOqpgdQGj7pjBIIoaZUw==
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.16.2
Date: Fri, 16 Feb 2018 09:55:22 -0800
Message-ID: <xmqqinaw7rat.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release Git v2.16.2 is now available at
the usual places, with small fixes that are already in the 
'master' front.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.16.2'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.16.2 Release Notes
=========================

Fixes since v2.16.1
-------------------

 * An old regression in "git describe --all $annotated_tag^0" has been
   fixed.

 * "git svn dcommit" did not take into account the fact that a
   svn+ssh:// URL with a username@ (typically used for pushing) refers
   to the same SVN repository without the username@ and failed when
   svn.pushmergeinfo option is set.

 * "git merge -Xours/-Xtheirs" learned to use our/their version when
   resolving a conflicting updates to a symbolic link.

 * "git clone $there $here" is allowed even when here directory exists
   as long as it is an empty directory, but the command incorrectly
   removed it upon a failure of the operation.

 * "git stash -- <pathspec>" incorrectly blew away untracked files in
   the directory that matched the pathspec, which has been corrected.

 * "git add -p" was taught to ignore local changes to submodules as
   they do not interfere with the partial addition of regular changes
   anyway.


Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.16.1 are as follows:

Andreas G. Schacker (1):
      doc/read-tree: remove obsolete remark

Daniel Knittl-Frank (1):
      describe: prepend "tags/" when describing tags with embedded name

Jason Merrill (1):
      git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

Jeff King (4):
      t5600: fix outdated comment about unborn HEAD
      t5600: modernize style
      clone: factor out dir_exists() helper
      clone: do not clean up directories we didn't create

Junio C Hamano (2):
      merge: teach -Xours/-Xtheirs to symbolic link merge
      Git 2.16.2

Nguyễn Thái Ngọc Duy (1):
      add--interactive: ignore submodule changes except HEAD

René Scharfe (9):
      commit: avoid allocation in clear_commit_marks_many()
      commit: use clear_commit_marks_many() in remove_redundant()
      ref-filter: use clear_commit_marks_many() in do_merge_filter()
      object: add clear_commit_marks_all()
      bisect: avoid using the rev_info flag leak_pending
      bundle: avoid using the rev_info flag leak_pending
      checkout: avoid using the rev_info flag leak_pending
      revision: remove the unused flag leak_pending
      commit: remove unused function clear_commit_marks_for_object_array()

Thomas Gummerer (1):
      stash: don't delete untracked files that match pathspec

Ævar Arnfjörð Bjarmason (2):
      perf: amend the grep tests to test grep.threads
      cat-file doc: document that -e will return some output
