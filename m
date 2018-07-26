Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EC3C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9317720685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="H+xl47a6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nVJWgfJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9317720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbeGZGRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:17:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42901 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbeGZGRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:17:42 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F3F4521F69;
        Thu, 26 Jul 2018 01:02:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jul 2018 01:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xORFv8WqKlEqoecnG
        Vjq1v8vW187smH56TIqszi9ulI=; b=H+xl47a6P1Fv7LFxu1wdAsDW5akXKpT9t
        3pW1CJZ3s12bCN6R+IPK7fbbRTOK9NPk+CDqxaUtfQB4HhPNHhCNff+howVVLupc
        Msi4YCTbo35UTPJNlksxLSdFEnwj6I0XTP3+RYcfhWIPKJp5SkaMpMJY/m/60VDQ
        SRtKAkQZDraC90UIrd5DE1J6RcgK33C+et1XSDK8AHJkry8x/Jmy7xGPT9QHyAis
        dMdYge5Zu4Y8GWyhcuVqbpXNzHIZnNX4XY/PGxVlaQHMkylBn2kTQcptp/FBm1kO
        d1we9XdZpw6+O/QjNIPJVPQlmWkwNtlooN8KSFTsrzgyHZDwJQO7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=xORFv8WqKlEqoecnGVjq1v8vW187smH56TIqszi9ulI=; b=nVJWgfJU
        hx7ONCvydF2IQNX98e64Qbb1Io4cFl2/RSiJtkPwfcrtIXptsMoZZHducugoX58v
        M8j50V3sq5s6eBB+vMkeMovbbMHtGXFYEapiBnCePMpLynkJkMc2B51aPEw+vvFR
        3COHOEhAA3ggbTvnKuoqEUM3UubhOrOiUeL74LlWsnT3jRNomFDUU5CjJdrh2n5f
        ocj+1TeJpONSh4yrDZTq+YFZ/VXIeCRsDjx84rTKIGJ6zttr5lwoRGfyB3tCW2u+
        yG4HLR4LnclqtxF0Dx+GN/QiAzYTjXtKc7jeYle88KdcF+0tgoKffuJaGzo79mQ2
        LXd4xc1pX6UIYg==
X-ME-Proxy: <xmx:8FVZW2byNyDIGgHm3eFKV7iDuo3sYqjvkMaXzXnabpH0f-OM-7AK8g>
    <xmx:8FVZWwaa0Ei__F7_5_oBl_k8eo3ea9fOfmvpY0wrYTaG2BY-4NQveg>
    <xmx:8FVZW18GpQoYzDrB_RZv7hJtkQPTULEyo-txiLGhnxSPgJG2UUsq6g>
    <xmx:8FVZW3gesebB6ZwVUJw9j2SGHacPXamdG0WmIxGnHFjgFt82CF00Ww>
    <xmx:8FVZW9f-qi5UFMJZVXOWBOnpwObojxqZV8NwgHzQP13vCN5hVtalxQ>
    <xmx:8FVZWw33A0zRN9Pr5Oa8RobYNzRDpuLqXzca-cpKmyCdF0amVu-5Ow>
X-ME-Sender: <xms:8FVZW_RCcF6u-AZoNraDBPFI9NXLO7xsdphYZVbob39lmIkf7B2TMA>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD69910255;
        Thu, 26 Jul 2018 01:02:39 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 2/3] docs: net: Convert netdev-FAQ to restructured text
Date:   Thu, 26 Jul 2018 15:02:25 +1000
Message-Id: <20180726050226.1980-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726050226.1980-1-me@tobin.cc>
References: <20180726050226.1980-1-me@tobin.cc>
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

 - Remove stale entry from Documentation/networking/00-INDEX

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/00-INDEX       |   2 -
 Documentation/networking/index.rst      |   1 +
 Documentation/networking/netdev-FAQ.rst | 259 ++++++++++++++++++++++++
 Documentation/networking/netdev-FAQ.txt | 244 ----------------------
 4 files changed, 260 insertions(+), 246 deletions(-)
 create mode 100644 Documentation/networking/netdev-FAQ.rst
 delete mode 100644 Documentation/networking/netdev-FAQ.txt

diff --git a/Documentation/networking/00-INDEX b/Documentation/networking/00-INDEX
index 1e5153ed8990..02a323c43261 100644
--- a/Documentation/networking/00-INDEX
+++ b/Documentation/networking/00-INDEX
@@ -138,8 +138,6 @@ multiqueue.txt
 	- HOWTO for multiqueue network device support.
 netconsole.txt
 	- The network console module netconsole.ko: configuration and notes.
-netdev-FAQ.txt
-	- FAQ describing how to submit net changes to netdev mailing list.
 netdev-features.txt
 	- Network interface features API description.
 netdevices.txt
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

