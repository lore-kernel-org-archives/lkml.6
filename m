Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeB0DET (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:04:19 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53851 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751514AbeB0DES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:04:18 -0500
X-ME-Sender: <xms:scqUWjHki3Cb8FgfJcXgSepS8LTvAoxQVqh4oDAVyG5hPqknu37Zbg>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] checkpatch: warn for use of %px
Date: Tue, 27 Feb 2018 14:04:04 +1100
Message-Id: <1519700648-23108-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This is a resurrection of a patch set from last December.  There was
some confusion (on my behalf) as to how patches to checkpatch got into
the mainline.  Are you willing (and able) to take patches to
checkpatch.pl?

Patch 1 through 3 are cleanup/refactoring patches.

Patch 3 makes checkpatch emit a warning for usage of specifier %px.

You may remember that the initial idea for this was from yourself, v1
requested permission to use 'Suggested-by' tag.  I didn't get comment on
that so v2 removed the tag.  (I'm not totally across when one should add
the 'Suggested-by' tag.)

v3 was an Epic fail, not testing final patch series before submission.

Joe, I removed your 'Acked-by' tag because the patch you originally
acked is different after rebasing.  I kept the Co-Developed-by tag
because the code you wrote is still there I just had to massage it a bit
since the check for deprecated %p[Ff] has been added since we did v2.

(Sorry about the noise with v3, I hacked that version together as a
RESEND, a v1, and then finally decided on a v3 and failed to test it
after rebase :( And now I am going to violate the 1 version per day
rule to boot. 


thanks for your patience,
Tobin.


Tested on a bunch of old patches and a hand rolled printk test module
to stress test printk %p extensions.

v4:
 - actually rebase the patch set properly
 - remove 'Acked-by' tag for Joe

v3:
 - rebase onto 4.16-rc3
 - separate 'remove unused variable' into it's own patch

v2:
 - change new sub name stat_real() -> get_stat_real()
 - add new sub get_stat_here()
 - move the addition of new sub routines into separate patches
 - add 'Acked-by' tag for Joe
 - remove 'Suggested-by' tag for Andrew Morton

Tobin C. Harding (4):
  checkpatch: add sub routine get_stat_real()
  checkpatch: remove unused variable declarations
  checkpatch: add sub routine get_stat_here()
  checkpatch: warn for use of %px

 scripts/checkpatch.pl | 130 +++++++++++++++++++++++++-------------------------
 1 file changed, 66 insertions(+), 64 deletions(-)

-- 
2.7.4
