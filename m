Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeDCVPc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:15:32 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35806 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeDCVPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:15:31 -0400
X-Google-Smtp-Source: AIpwx4/drpYa6DbdKYm/BVJHrKjAwAMoO8JzVQWp4TsY26nZFX12+is74rDOI3/8rXQZvT6Ux9J2R6jkPnbKmzPl0uo=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Apr 2018 17:15:29 -0400
Message-ID: <CAHC9VhSpUP3ac=ACbotPd=6Ymy4bX2Xg6wkuo9DHH3Notp0eng@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

We didn't have anything to send for v4.16, but we're back with a
little more than usual for v4.17.  Eleven patches in total, most fall
into the small fix category, but there are three non-trivial changes
worth calling out: the audit entry filter is being removed after
deprecating it for quite a while (years of no one really using it
because it turns out to be not very practical), created our own
version of "__mutex_owner()" because the locking folks were upset we
were using theirs, improved our handling of kernel command line
parameters to make them more forgiving, and we fixed auditing of
symlink operations.

Everything passes the audit-testsuite and as of a few minutes ago it
merges well with your tree.

Please pull, thanks.
-Paul
--
The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:

 Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-
20180403

for you to fetch changes up to ea841bafda3f7f9aa8b06a09f0f3e41c207af84f:

 audit: add refused symlink to audit_names (2018-03-21 11:31:03 -0400)

----------------------------------------------------------------
audit/stable-4.17 PR 20180403

----------------------------------------------------------------
Greg Edwards (1):
     audit: do not panic on invalid boot parameter

Paul Moore (1):
     audit: track the owner of the command mutex ourselves

Richard Guy Briggs (9):
     audit: update bugtracker and source URIs
     audit: session ID should not set arch quick field pointer
     audit: deprecate the AUDIT_FILTER_ENTRY filter
     audit: bail before bug check if audit disabled
     audit: return on memory error to avoid null pointer dereference
     audit: make ANOM_LINK obey audit_enabled and audit_dummy_context
     audit: link denied should not directly generate PATH record
     audit: remove path param from link denied function
     audit: add refused symlink to audit_names

Documentation/admin-guide/kernel-parameters.txt |  14 +--
MAINTAINERS                                     |   1 -
fs/namei.c                                      |   5 +-
include/linux/audit.h                           |   6 +-
kernel/audit.c                                  | 108 +++++++++++++++++-------
kernel/audit.h                                  |   3 +-
kernel/audit_tree.c                             |   8 +-
kernel/auditfilter.c                            |   5 +-
kernel/auditsc.c                                |  22 +++--
9 files changed, 106 insertions(+), 66 deletions(-)

-- 
paul moore
www.paul-moore.com
