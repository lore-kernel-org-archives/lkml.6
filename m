Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFC8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213472088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="m5+HNEj5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kfqe+25i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213472088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbeGYD7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:59:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46137 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388524AbeGYD7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:59:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 985BD21B46;
        Tue, 24 Jul 2018 22:50:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 24 Jul 2018 22:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=B5of/qRq2XqpEUAg9
        0Tpjm4utrhq2wCTAtd9jDWrpy0=; b=m5+HNEj5W0wXKFkdsO4Kq9jYMjdXWhmoG
        hYVv5uUlwjMs6ogF1IQIOOGSJZpMxiH0q3XKYbBixsz2NRVa0t3lbzvgtuo8CpyU
        kVUtnoCZv1Ydj0hoiy7ycg2GriuyCxvd7GqzslqOKILOZlMaXLCtZaz8dSS/JNnj
        hbMT7nGPXEOsTrQddarrh1cSzR9y1KTTuBQ4QxvpYZ8r2nL/S0Bdo/rHPJPH8+jF
        MUC0b91uTD0JvDuxRWgMPJsePY+dfDi1DMGUoGm4XptFcXyNcZHFIlA059R8n3C6
        BsTBnWcuz2EOmRT8HkiVnlE64RA/wHh2IffQRvZU65C3pydhkXeFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=B5of/qRq2XqpEUAg90Tpjm4utrhq2wCTAtd9jDWrpy0=; b=Kfqe+25i
        GHavdYEg0GpdLkvLS6u6VHehGhCCGeiEsei3zMSJCV/KRHgjflT4yCNPZP272N83
        dcYkM1+zUKRjzK4cpBtiRRKouQskSwb8eUU7coejs/aSeTyHjqAfDJ2QvpZF3ZtG
        jAmoWbB9800WwBWQp+URJ0RPbzxJdcrspBS0fOS04Az+2ZqJI+KEE6UFleXbRdrq
        T394W4jiu6xzOjmVfTzeEqdcb6rFG9rU1yNMe9K6vs1kIGHaVBlQDz0veGbFvyPX
        ymQjlem51yRHrJKFvqQGmomTh3rXh6xzjyj0/3SGERE+j6RxmbGgB2K/Ne637OXT
        MDGhVfgGrl5kdA==
X-ME-Proxy: <xmx:b-VXW0w3C3Pt9qo4Z7Lbsb0vK9tI0FOvClx7uOx6Gq-okC07bPe50w>
    <xmx:b-VXW8TDFzR25qUA6qhP7KhMDY_nR758EREyBDuY4_L5Q7G7gh_TPA>
    <xmx:b-VXW2-nYMzbfceqEeXSDDREC904tC-lu_cJKIuyFPFVgoyOZbAGpg>
    <xmx:b-VXWyZS7AzICdEowCUAYyiW3j61XiW8AuOwG4pS4uDZr9oyqZubHw>
    <xmx:b-VXW_q7sDvr95_Wao7A9CyVvm9Eon86T7v2kXDaVKcu_nswJ8mfEw>
    <xmx:b-VXW9l1gAKqakdvexeP2BS3IfvzBzg2DG2INMMgTw54W-7JgVyDwA>
X-ME-Sender: <xms:b-VXWyCVWnH1Adp_lIjrXQNDS9W143nhygcT2K2vNz4yh8k9zhgAFg>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 40A12E403B;
        Tue, 24 Jul 2018 22:50:21 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] docs: net: Convert netdev-FAQ to restructured text
Date:   Wed, 25 Jul 2018 12:50:05 +1000
Message-Id: <20180725025005.14332-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180725025005.14332-1-me@tobin.cc>
References: <20180725025005.14332-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preferred kernel docs format is now restructured text.  Convert
netdev-FAQ.txt to restructured text.

 - Add SPDX license identifier.

 - Change file heading 'Information you need to know about netdev' to
  'netdev FAQ' to better suit displayed index (in HTML).

 - Change question/answer layout to suit rst.  Copy format in
   Documentation/bpf/bpf_devel_QA.rst

 - Fix indentation of code snippets

 - If multiple consecutive URLs appear put them in a list (to maintain
  whitespace).

 - Use uniform spelling of 'bug fix' throughout document (not bugfix or
   bug-fix).

 - Add double back ticks to 'net' and 'net-next' when referring to the
   trees.

 - Use rst references for Documentation/ links.

 - Add rst label 'netdev-FAQ' for referencing by other docs files.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/index.rst      |   1 +
 Documentation/networking/netdev-FAQ.rst | 259 ++++++++++++++++++++++++
 Documentation/networking/netdev-FAQ.txt | 244 ----------------------
 3 files changed, 260 insertions(+), 244 deletions(-)
 create mode 100644 Documentation/networking/netdev-FAQ.rst
 delete mode 100644 Documentation/networking/netdev-FAQ.txt

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index f0ae9b65dfba..884a26145f20 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -6,6 +6,7 @@ Contents:
 .. toctree::
    :maxdepth: 2
 
+   netdev-FAQ
    af_xdp
    batman-adv
    can
diff --git a/Documentation/networking/netdev-FAQ.rst b/Documentation/networking/netdev-FAQ.rst
new file mode 100644
index 000000000000..d388843d4d54
--- /dev/null
+++ b/Documentation/networking/netdev-FAQ.rst
@@ -0,0 +1,259 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _netdev-FAQ:
+
+==========
+netdev FAQ
+==========
+
+Q: What is netdev?
+------------------
+A: It is a mailing list for all network-related Linux stuff.  This
+includes anything found under net/ (i.e. core code like IPv6) and
+drivers/net (i.e. hardware specific drivers) in the Linux source tree.
+
+Note that some subsystems (e.g. wireless drivers) which have a high
+volume of traffic have their own specific mailing lists.
+
+The netdev list is managed (like many other Linux mailing lists) through
+VGER (http://vger.kernel.org/) and archives can be found below:
+
+-  http://marc.info/?l=linux-netdev
+-  http://www.spinics.net/lists/netdev/
+
+Aside from subsystems like that mentioned above, all network-related
+Linux development (i.e. RFC, review, comments, etc.) takes place on
+netdev.
+
+Q: How do the changes posted to netdev make their way into Linux?
+-----------------------------------------------------------------
+A: There are always two trees (git repositories) in play.  Both are
+driven by David Miller, the main network maintainer.  There is the
+``net`` tree, and the ``net-next`` tree.  As you can probably guess from
+the names, the ``net`` tree is for fixes to existing code already in the
+mainline tree from Linus, and ``net-next`` is where the new code goes
+for the future release.  You can find the trees here:
+
+- https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
+- https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
+
+Q: How often do changes from these trees make it to the mainline Linus tree?
+----------------------------------------------------------------------------
+A: To understand this, you need to know a bit of background information on
+the cadence of Linux development.  Each new release starts off with a
+two week "merge window" where the main maintainers feed their new stuff
+to Linus for merging into the mainline tree.  After the two weeks, the
+merge window is closed, and it is called/tagged ``-rc1``.  No new
+features get mainlined after this -- only fixes to the rc1 content are
+expected.  After roughly a week of collecting fixes to the rc1 content,
+rc2 is released.  This repeats on a roughly weekly basis until rc7
+(typically; sometimes rc6 if things are quiet, or rc8 if things are in a
+state of churn), and a week after the last vX.Y-rcN was done, the
+official vX.Y is released.
+
+Relating that to netdev: At the beginning of the 2-week merge window,
+the ``net-next`` tree will be closed - no new changes/features.  The
+accumulated new content of the past ~10 weeks will be passed onto
+mainline/Linus via a pull request for vX.Y -- at the same time, the
+``net`` tree will start accumulating fixes for this pulled content
+relating to vX.Y
+
+An announcement indicating when ``net-next`` has been closed is usually
+sent to netdev, but knowing the above, you can predict that in advance.
+
+IMPORTANT: Do not send new ``net-next`` content to netdev during the
+period during which ``net-next`` tree is closed.
+
+Shortly after the two weeks have passed (and vX.Y-rc1 is released), the
+tree for ``net-next`` reopens to collect content for the next (vX.Y+1)
+release.
+
+If you aren't subscribed to netdev and/or are simply unsure if
+``net-next`` has re-opened yet, simply check the ``net-next`` git
+repository link above for any new networking-related commits.  You may
+also check the following website for the current status:
+
+  http://vger.kernel.org/~davem/net-next.html
+
+The ``net`` tree continues to collect fixes for the vX.Y content, and is
+fed back to Linus at regular (~weekly) intervals.  Meaning that the
+focus for ``net`` is on stabilization and bug fixes.
+
+Finally, the vX.Y gets released, and the whole cycle starts over.
+
+Q: So where are we now in this cycle?
+
+Load the mainline (Linus) page here:
+
+  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+
+and note the top of the "tags" section.  If it is rc1, it is early in
+the dev cycle.  If it was tagged rc7 a week ago, then a release is
+probably imminent.
+
+Q: How do I indicate which tree (net vs. net-next) my patch should be in?
+-------------------------------------------------------------------------
+A: Firstly, think whether you have a bug fix or new "next-like" content.
+Then once decided, assuming that you use git, use the prefix flag, i.e.
+::
+
+  git format-patch --subject-prefix='PATCH net-next' start..finish
+
+Use ``net`` instead of ``net-next`` (always lower case) in the above for
+bug-fix ``net`` content.  If you don't use git, then note the only magic
+in the above is just the subject text of the outgoing e-mail, and you
+can manually change it yourself with whatever MUA you are comfortable
+with.
+
+Q: I sent a patch and I'm wondering what happened to it?
+--------------------------------------------------------
+Q: How can I tell whether it got merged?
+A: Start by looking at the main patchworks queue for netdev:
+
+  http://patchwork.ozlabs.org/project/netdev/list/
+
+The "State" field will tell you exactly where things are at with your
+patch.
+
+Q: The above only says "Under Review".  How can I find out more?
+----------------------------------------------------------------
+A: Generally speaking, the patches get triaged quickly (in less than
+48h).  So be patient.  Asking the maintainer for status updates on your
+patch is a good way to ensure your patch is ignored or pushed to the
+bottom of the priority list.
+
+Q: I submitted multiple versions of the patch series
+----------------------------------------------------
+Q: should I directly update patchwork for the previous versions of these
+patch series?
+A: No, please don't interfere with the patch status on patchwork, leave
+it to the maintainer to figure out what is the most recent and current
+version that should be applied. If there is any doubt, the maintainer
+will reply and ask what should be done.
+
+Q: How can I tell what patches are queued up for backporting to the various stable releases?
+--------------------------------------------------------------------------------------------
+A: Normally Greg Kroah-Hartman collects stable commits himself, but for
+networking, Dave collects up patches he deems critical for the
+networking subsystem, and then hands them off to Greg.
+
+There is a patchworks queue that you can see here:
+
+  http://patchwork.ozlabs.org/bundle/davem/stable/?state=*
+
+It contains the patches which Dave has selected, but not yet handed off
+to Greg.  If Greg already has the patch, then it will be here:
+
+  https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
+
+A quick way to find whether the patch is in this stable-queue is to
+simply clone the repo, and then git grep the mainline commit ID, e.g.
+::
+
+  stable-queue$ git grep -l 284041ef21fdf2e
+  releases/3.0.84/ipv6-fix-possible-crashes-in-ip6_cork_release.patch
+  releases/3.4.51/ipv6-fix-possible-crashes-in-ip6_cork_release.patch
+  releases/3.9.8/ipv6-fix-possible-crashes-in-ip6_cork_release.patch
+  stable/stable-queue$
+
+Q: I see a network patch and I think it should be backported to stable.
+-----------------------------------------------------------------------
+Q: Should I request it via stable@vger.kernel.org like the references in
+the kernel's Documentation/process/stable-kernel-rules.rst file say?
+A: No, not for networking.  Check the stable queues as per above first
+to see if it is already queued.  If not, then send a mail to netdev,
+listing the upstream commit ID and why you think it should be a stable
+candidate.
+
+Before you jump to go do the above, do note that the normal stable rules
+in :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
+still apply.  So you need to explicitly indicate why it is a critical
+fix and exactly what users are impacted.  In addition, you need to
+convince yourself that you *really* think it has been overlooked,
+vs. having been considered and rejected.
+
+Generally speaking, the longer it has had a chance to "soak" in
+mainline, the better the odds that it is an OK candidate for stable.  So
+scrambling to request a commit be added the day after it appears should
+be avoided.
+
+Q: I have created a network patch and I think it should be backported to stable.
+--------------------------------------------------------------------------------
+Q: Should I add a Cc: stable@vger.kernel.org like the references in the
+kernel's Documentation/ directory say?
+A: No.  See above answer.  In short, if you think it really belongs in
+stable, then ensure you write a decent commit log that describes who
+gets impacted by the bug fix and how it manifests itself, and when the
+bug was introduced.  If you do that properly, then the commit will get
+handled appropriately and most likely get put in the patchworks stable
+queue if it really warrants it.
+
+If you think there is some valid information relating to it being in
+stable that does *not* belong in the commit log, then use the three dash
+marker line as described in
+:ref:`Documentation/process/submitting-patches.rst <the_canonical_patch_format>`
+to temporarily embed that information into the patch that you send.
+
+Q: Are all networking bug fixes backported to all stable releases?
+------------------------------------------------------------------
+A: Due to capacity, Dave could only take care of the backports for the
+last two stable releases. For earlier stable releases, each stable
+branch maintainer is supposed to take care of them. If you find any
+patch is missing from an earlier stable branch, please notify
+stable@vger.kernel.org with either a commit ID or a formal patch
+backported, and CC Dave and other relevant networking developers.
+
+Q: Is the comment style convention different for the networking content?
+------------------------------------------------------------------------
+A: Yes, in a largely trivial way.  Instead of this::
+
+  /*
+   * foobar blah blah blah
+   * another line of text
+   */
+
+it is requested that you make it look like this::
+
+  /* foobar blah blah blah
+   * another line of text
+   */
+
+Q: I am working in existing code that has the former comment style and not the latter.
+--------------------------------------------------------------------------------------
+Q: Should I submit new code in the former style or the latter?
+A: Make it the latter style, so that eventually all code in the domain
+of netdev is of this format.
+
+Q: I found a bug that might have possible security implications or similar.
+---------------------------------------------------------------------------
+Q: Should I mail the main netdev maintainer off-list?**
+A: No. The current netdev maintainer has consistently requested that
+people use the mailing lists and not reach out directly.  If you aren't
+OK with that, then perhaps consider mailing security@kernel.org or
+reading about http://oss-security.openwall.org/wiki/mailing-lists/distros
+as possible alternative mechanisms.
+
+Q: What level of testing is expected before I submit my change?
+---------------------------------------------------------------
+A: If your changes are against ``net-next``, the expectation is that you
+have tested by layering your changes on top of ``net-next``.  Ideally
+you will have done run-time testing specific to your change, but at a
+minimum, your changes should survive an ``allyesconfig`` and an
+``allmodconfig`` build without new warnings or failures.
+
+Q: Any other tips to help ensure my net/net-next patch gets OK'd?
+-----------------------------------------------------------------
+A: Attention to detail.  Re-read your own work as if you were the
+reviewer.  You can start with using ``checkpatch.pl``, perhaps even with
+the ``--strict`` flag.  But do not be mindlessly robotic in doing so.
+If your change is a bug fix, make sure your commit log indicates the
+end-user visible symptom, the underlying reason as to why it happens,
+and then if necessary, explain why the fix proposed is the best way to
+get things done.  Don't mangle whitespace, and as is common, don't
+mis-indent function arguments that span multiple lines.  If it is your
+first patch, mail it to yourself so you can test apply it to an
+unpatched tree to confirm infrastructure didn't mangle it.
+
+Finally, go back and read
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+to be sure you are not repeating some common mistake documented there. 
diff --git a/Documentation/networking/netdev-FAQ.txt b/Documentation/networking/netdev-FAQ.txt
deleted file mode 100644
index fa951b820b25..000000000000
--- a/Documentation/networking/netdev-FAQ.txt
+++ /dev/null
@@ -1,244 +0,0 @@
-
-Information you need to know about netdev
------------------------------------------
-
-Q: What is netdev?
-
-A: It is a mailing list for all network-related Linux stuff.  This includes
-   anything found under net/  (i.e. core code like IPv6) and drivers/net
-   (i.e. hardware specific drivers) in the Linux source tree.
-
-   Note that some subsystems (e.g. wireless drivers) which have a high volume
-   of traffic have their own specific mailing lists.
-
-   The netdev list is managed (like many other Linux mailing lists) through
-   VGER ( http://vger.kernel.org/ ) and archives can be found below:
-
-	http://marc.info/?l=linux-netdev
-	http://www.spinics.net/lists/netdev/
-
-   Aside from subsystems like that mentioned above, all network-related Linux
-   development (i.e. RFC, review, comments, etc.) takes place on netdev.
-
-Q: How do the changes posted to netdev make their way into Linux?
-
-A: There are always two trees (git repositories) in play.  Both are driven
-   by David Miller, the main network maintainer.  There is the "net" tree,
-   and the "net-next" tree.  As you can probably guess from the names, the
-   net tree is for fixes to existing code already in the mainline tree from
-   Linus, and net-next is where the new code goes for the future release.
-   You can find the trees here:
-
-        https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
-        https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
-
-Q: How often do changes from these trees make it to the mainline Linus tree?
-
-A: To understand this, you need to know a bit of background information
-   on the cadence of Linux development.  Each new release starts off with
-   a two week "merge window" where the main maintainers feed their new
-   stuff to Linus for merging into the mainline tree.  After the two weeks,
-   the merge window is closed, and it is called/tagged "-rc1".  No new
-   features get mainlined after this -- only fixes to the rc1 content
-   are expected.  After roughly a week of collecting fixes to the rc1
-   content, rc2 is released.  This repeats on a roughly weekly basis
-   until rc7 (typically; sometimes rc6 if things are quiet, or rc8 if
-   things are in a state of churn), and a week after the last vX.Y-rcN
-   was done, the official "vX.Y" is released.
-
-   Relating that to netdev:  At the beginning of the 2-week merge window,
-   the net-next tree will be closed - no new changes/features.  The
-   accumulated new content of the past ~10 weeks will be passed onto
-   mainline/Linus via a pull request for vX.Y -- at the same time,
-   the "net" tree will start accumulating fixes for this pulled content
-   relating to vX.Y
-
-   An announcement indicating when net-next has been closed is usually
-   sent to netdev, but knowing the above, you can predict that in advance.
-
-   IMPORTANT:  Do not send new net-next content to netdev during the
-   period during which net-next tree is closed.
-
-   Shortly after the two weeks have passed (and vX.Y-rc1 is released), the
-   tree for net-next reopens to collect content for the next (vX.Y+1) release.
-
-   If you aren't subscribed to netdev and/or are simply unsure if net-next
-   has re-opened yet, simply check the net-next git repository link above for
-   any new networking-related commits.  You may also check the following
-   website for the current status:
-
-        http://vger.kernel.org/~davem/net-next.html
-
-   The "net" tree continues to collect fixes for the vX.Y content, and
-   is fed back to Linus at regular (~weekly) intervals.  Meaning that the
-   focus for "net" is on stabilization and bugfixes.
-
-   Finally, the vX.Y gets released, and the whole cycle starts over.
-
-Q: So where are we now in this cycle?
-
-A: Load the mainline (Linus) page here:
-
-	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-
-   and note the top of the "tags" section.  If it is rc1, it is early
-   in the dev cycle.  If it was tagged rc7 a week ago, then a release
-   is probably imminent.
-
-Q: How do I indicate which tree (net vs. net-next) my patch should be in?
-
-A: Firstly, think whether you have a bug fix or new "next-like" content.
-   Then once decided, assuming that you use git, use the prefix flag, i.e.
-
-	git format-patch --subject-prefix='PATCH net-next' start..finish
-
-   Use "net" instead of "net-next" (always lower case) in the above for
-   bug-fix net content.  If you don't use git, then note the only magic in
-   the above is just the subject text of the outgoing e-mail, and you can
-   manually change it yourself with whatever MUA you are comfortable with.
-
-Q: I sent a patch and I'm wondering what happened to it.  How can I tell
-   whether it got merged?
-
-A: Start by looking at the main patchworks queue for netdev:
-
-	http://patchwork.ozlabs.org/project/netdev/list/
-
-   The "State" field will tell you exactly where things are at with
-   your patch.
-
-Q: The above only says "Under Review".  How can I find out more?
-
-A: Generally speaking, the patches get triaged quickly (in less than 48h).
-   So be patient.  Asking the maintainer for status updates on your
-   patch is a good way to ensure your patch is ignored or pushed to
-   the bottom of the priority list.
-
-Q: I submitted multiple versions of the patch series, should I directly update
-   patchwork for the previous versions of these patch series?
-
-A: No, please don't interfere with the patch status on patchwork, leave it to
-   the maintainer to figure out what is the most recent and current version that
-   should be applied. If there is any doubt, the maintainer will reply and ask
-   what should be done.
-
-Q: How can I tell what patches are queued up for backporting to the
-   various stable releases?
-
-A: Normally Greg Kroah-Hartman collects stable commits himself, but
-   for networking, Dave collects up patches he deems critical for the
-   networking subsystem, and then hands them off to Greg.
-
-   There is a patchworks queue that you can see here:
-	http://patchwork.ozlabs.org/bundle/davem/stable/?state=*
-
-   It contains the patches which Dave has selected, but not yet handed
-   off to Greg.  If Greg already has the patch, then it will be here:
-	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
-
-   A quick way to find whether the patch is in this stable-queue is
-   to simply clone the repo, and then git grep the mainline commit ID, e.g.
-
-	stable-queue$ git grep -l 284041ef21fdf2e
-	releases/3.0.84/ipv6-fix-possible-crashes-in-ip6_cork_release.patch
-	releases/3.4.51/ipv6-fix-possible-crashes-in-ip6_cork_release.patch
-	releases/3.9.8/ipv6-fix-possible-crashes-in-ip6_cork_release.patch
-	stable/stable-queue$
-
-Q: I see a network patch and I think it should be backported to stable.
-   Should I request it via "stable@vger.kernel.org" like the references in
-   the kernel's Documentation/process/stable-kernel-rules.rst file say?
-
-A: No, not for networking.  Check the stable queues as per above 1st to see
-   if it is already queued.  If not, then send a mail to netdev, listing
-   the upstream commit ID and why you think it should be a stable candidate.
-
-   Before you jump to go do the above, do note that the normal stable rules
-   in Documentation/process/stable-kernel-rules.rst still apply.  So you need to
-   explicitly indicate why it is a critical fix and exactly what users are
-   impacted.  In addition, you need to convince yourself that you _really_
-   think it has been overlooked, vs. having been considered and rejected.
-
-   Generally speaking, the longer it has had a chance to "soak" in mainline,
-   the better the odds that it is an OK candidate for stable.  So scrambling
-   to request a commit be added the day after it appears should be avoided.
-
-Q: I have created a network patch and I think it should be backported to
-   stable.  Should I add a "Cc: stable@vger.kernel.org" like the references
-   in the kernel's Documentation/ directory say?
-
-A: No.  See above answer.  In short, if you think it really belongs in
-   stable, then ensure you write a decent commit log that describes who
-   gets impacted by the bugfix and how it manifests itself, and when the
-   bug was introduced.  If you do that properly, then the commit will
-   get handled appropriately and most likely get put in the patchworks
-   stable queue if it really warrants it.
-
-   If you think there is some valid information relating to it being in
-   stable that does _not_ belong in the commit log, then use the three
-   dash marker line as described in Documentation/process/submitting-patches.rst to
-   temporarily embed that information into the patch that you send.
-
-Q: Are all networking bug fixes backported to all stable releases?
-
-A: Due to capacity, Dave could only take care of the backports for the last
-   2 stable releases. For earlier stable releases, each stable branch maintainer
-   is supposed to take care of them. If you find any patch is missing from an
-   earlier stable branch, please notify stable@vger.kernel.org with either a
-   commit ID or a formal patch backported, and CC Dave and other relevant
-   networking developers.
-
-Q: Someone said that the comment style and coding convention is different
-   for the networking content.  Is this true?
-
-A: Yes, in a largely trivial way.  Instead of this:
-
-	/*
-	 * foobar blah blah blah
-	 * another line of text
-	 */
-
-   it is requested that you make it look like this:
-
-	/* foobar blah blah blah
-	 * another line of text
-	 */
-
-Q: I am working in existing code that has the former comment style and not the
-   latter.  Should I submit new code in the former style or the latter?
-
-A: Make it the latter style, so that eventually all code in the domain of
-   netdev is of this format.
-
-Q: I found a bug that might have possible security implications or similar.
-   Should I mail the main netdev maintainer off-list?
-
-A: No. The current netdev maintainer has consistently requested that people
-   use the mailing lists and not reach out directly.  If you aren't OK with
-   that, then perhaps consider mailing "security@kernel.org" or reading about
-   http://oss-security.openwall.org/wiki/mailing-lists/distros
-   as possible alternative mechanisms.
-
-Q: What level of testing is expected before I submit my change?
-
-A: If your changes are against net-next, the expectation is that you
-   have tested by layering your changes on top of net-next.  Ideally you
-   will have done run-time testing specific to your change, but at a
-   minimum, your changes should survive an "allyesconfig" and an
-   "allmodconfig" build without new warnings or failures.
-
-Q: Any other tips to help ensure my net/net-next patch gets OK'd?
-
-A: Attention to detail.  Re-read your own work as if you were the
-   reviewer.  You can start with using checkpatch.pl, perhaps even
-   with the "--strict" flag.  But do not be mindlessly robotic in
-   doing so.  If your change is a bug-fix, make sure your commit log
-   indicates the end-user visible symptom, the underlying reason as
-   to why it happens, and then if necessary, explain why the fix proposed
-   is the best way to get things done.   Don't mangle whitespace, and as
-   is common, don't mis-indent function arguments that span multiple lines.
-   If it is your first patch, mail it to yourself so you can test apply
-   it to an unpatched tree to confirm infrastructure didn't mangle it.
-
-   Finally, go back and read Documentation/process/submitting-patches.rst to be
-   sure you are not repeating some common mistake documented there.
-- 
2.17.1

