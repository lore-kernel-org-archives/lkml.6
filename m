Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D640C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9FA2150C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VDMbFx92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9FA2150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeJUE0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 00:26:52 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39228 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725198AbeJUE0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 00:26:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 477168EE0CC;
        Sat, 20 Oct 2018 13:15:16 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LR4QJ32KypYp; Sat, 20 Oct 2018 13:15:16 -0700 (PDT)
Received: from [192.168.11.218] (ip-64-134-136-40.public.wayport.net [64.134.136.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C59B18EE0C8;
        Sat, 20 Oct 2018 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540066516;
        bh=lO8b0TLR4mZpDdLhwc+YMp6PvmJSaFzCHqrsZv0O4rw=;
        h=Subject:From:To:Cc:Date:From;
        b=VDMbFx92olPm0kbNO80CQh6oh/ArkINGHmzWPZb7JXoOJltwc8/p/nVw9h0Nplbfk
         JakAXRDdTWmh3aVXXuZPa1B8gLd28xx6kE4zSvbo4lQ9JQyle8WRE3uNZgWPc8WPGJ
         bBT1+jxIA0X/f1eqZqJXHyQsjjSgKf3m5RGMUmU4=
Message-ID: <1540066514.3464.22.camel@HansenPartnership.com>
Subject: [GIT PULL] code of conduct fixes for 4.19-rc8
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <greg@kroah.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Sat, 20 Oct 2018 13:15:14 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the series of patches which has been discussed on both ksummit-
discuss and linux-kernel for the past few weeks.  As Shuah said when
kicking off the process, it's designed as a starting point for the next
phase of the discussion, not as the end point, so it's only really a
set of minor updates to further that goal.

The merger of the three patches to show the combined effect is attached
below.  However, Greg recently posted the next phase of the discussion,
so people will be asking what the merger of the series looks like. 
Ignoring the non-CoC documents, I think it looks like this

---
diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index eec768471a4d..8913851dab89 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -59,19 +59,27 @@ address, posting via an official social media account, or acting as an appointed
 representative at an online or offline event. Representation of a project may be
 further defined and clarified by project maintainers.
 
-Reporting
-=========
+Enforcement
+===========
 
 Instances of abusive, harassing, or otherwise unacceptable behavior may be
-reported by contacting the Technical Advisory Board (TAB) at
-<tab@lists.linux-foundation.org>. All complaints will be reviewed and
-investigated and will result in a response that is deemed necessary and
-appropriate to the circumstances. The TAB is obligated to maintain
-confidentiality with regard to the reporter of an incident (except where
-required by law).
+reported by contacting the Code of Conduct Committee at
+<conduct@kernel.org>. All complaints will be reviewed and investigated
+and will result in a response that is deemed necessary and appropriate
+to the circumstances. The Code of Conduct Committee is obligated to
+maintain confidentiality with regard to the reporter of an incident
+(except where required by law). Further details of specific enforcement
+policies may be posted separately.
+
 
 Attribution
 ===========
 
 This Code of Conduct is adapted from the Contributor Covenant, version 1.4,
 available at https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
+
+Interpretation
+==============
+
+See the :ref:`code_of_conduct_interpretation` document for how the Linux
+kernel community will be interpreting this document.
---

And I'm sure it can be rebased to this without disturbing the currently gathered tags.

The patch can be pulled from

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/linux-coc.git coc-fixes

With the diffstat:

 Documentation/process/code-of-conduct.rst | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

With full diff below.

James

---

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index ab7c24b5478c..eec768471a4d 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants include:
 * Trolling, insulting/derogatory comments, and personal or political attacks
 * Public or private harassment
 * Publishing others’ private information, such as a physical or electronic
-  address, without explicit permission
+  address not ordinarily collected by the project, without explicit permission
 * Other conduct which could reasonably be considered inappropriate in a
   professional setting
 
@@ -59,20 +59,16 @@ address, posting via an official social media account, or acting as an appointed
 representative at an online or offline event. Representation of a project may be
 further defined and clarified by project maintainers.
 
-Enforcement
-===========
+Reporting
+=========
 
 Instances of abusive, harassing, or otherwise unacceptable behavior may be
 reported by contacting the Technical Advisory Board (TAB) at
 <tab@lists.linux-foundation.org>. All complaints will be reviewed and
 investigated and will result in a response that is deemed necessary and
 appropriate to the circumstances. The TAB is obligated to maintain
-confidentiality with regard to the reporter of an incident.  Further details of
-specific enforcement policies may be posted separately.
-
-Maintainers who do not follow or enforce the Code of Conduct in good faith may
-face temporary or permanent repercussions as determined by other members of the
-project’s leadership.
+confidentiality with regard to the reporter of an incident (except where
+required by law).
 
 Attribution
 ===========
