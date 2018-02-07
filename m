Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbeBGR0i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:26:38 -0500
Received: from ms.lwn.net ([45.79.88.28]:41608 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754412AbeBGR0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:26:37 -0500
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/8] Clean up kernel-doc and fix literal-block handling
Date: Wed,  7 Feb 2018 10:26:16 -0700
Message-Id: <20180207172624.24555-1-corbet@lwn.net>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So once upon a time I set out to fix the problem reported by Tobin wherein
a literal block within a kerneldoc comment would be corrupted in
processing.  On the way, though, I got annoyed at the way I have to learn
how kernel-doc works from the beginning every time I tear into it.

As a result, seven of the following eight patches just get rid of some dead
code and reorganize the rest - mostly turning the 500-line process_file()
function into something a bit more rational.  Sphinx output is unchanged
after these are applied.  Then, at the end, there's a tweak to stop messing
with literal blocks.

If anybody was unaware that I've not done any serious Perl since the
1990's, they will certainly understand that fact now.

Jonathan Corbet (8):
  docs: kernel-doc: Get rid of xml_escape() and friends
  docs: kernel-doc: Rename and split STATE_FIELD
  docs: kernel-doc: Move STATE_NORMAL processing into its own function
  docs: kernel-doc: Move STATE_NAME processing into its own function
  docs: kernel-doc: Move STATE_BODY processing to a separate function
  docs: kernel-doc: Move STATE_PROTO processing into its own function
  docs: kernel-doc: Finish moving STATE_* code out of process_file()
  docs: kernel-doc: Don't mangle literal code blocks in comments

 scripts/kernel-doc | 658 +++++++++++++++++++++++++++++------------------------
 1 file changed, 357 insertions(+), 301 deletions(-)

-- 
2.14.3
