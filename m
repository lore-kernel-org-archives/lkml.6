Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1354C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875182146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMZYuGVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875182146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbeK3BgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388288AbeK3BgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0BCD2145D;
        Thu, 29 Nov 2018 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501837;
        bh=b2Og7VXOwsXeO1+dAl7dbBw+Ssr7q7jRZbv0jf/DPy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMZYuGVzCzQYjA4Dd4lvT1uzpN/xMzZyc7UX7/hwwnQPJn8RbMIHL/ZJrNDbFdNSJ
         54joATkcG+FOfcXIyWyxPGpb6WNxazYickBND/ThcAMrOIBigHVrKKS5gTRPJG1b2V
         8DLx88dDYKXHeXzzHTmotfo1mIOBzemlyeXxtpTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 017/110] Documentation/security-bugs: Clarify treatment of embargoed information
Date:   Thu, 29 Nov 2018 15:11:48 +0100
Message-Id: <20181129135921.938157685@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 14fdc2c5318ae420e68496975f48dc1dbef52649 upstream.

The Linux kernel security team has been accused of rejecting the idea of
security embargoes. This is incorrect, and could dissuade people from
reporting security issues to us under the false assumption that the
issue would leak prematurely.

Clarify the handling of embargoed information in our process
documentation.

Co-developed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/admin-guide/security-bugs.rst |   45 +++++++++++++++++-----------
 1 file changed, 28 insertions(+), 17 deletions(-)

--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -26,23 +26,34 @@ information is helpful.  Any exploit cod
 be released without consent from the reporter unless it has already been
 made public.
 
-Disclosure
-----------
+Disclosure and embargoed information
+------------------------------------
 
-The goal of the Linux kernel security team is to work with the bug
-submitter to understand and fix the bug.  We prefer to publish the fix as
-soon as possible, but try to avoid public discussion of the bug itself
-and leave that to others.
-
-Publishing the fix may be delayed when the bug or the fix is not yet
-fully understood, the solution is not well-tested or for vendor
-coordination.  However, we expect these delays to be short, measurable in
-days, not weeks or months.  A release date is negotiated by the security
-team working with the bug submitter as well as vendors.  However, the
-kernel security team holds the final say when setting a timeframe.  The
-timeframe varies from immediate (esp. if it's already publicly known bug)
-to a few weeks.  As a basic default policy, we expect report date to
-release date to be on the order of 7 days.
+The security list is not a disclosure channel.  For that, see Coordination
+below.
+
+Once a robust fix has been developed, our preference is to release the
+fix in a timely fashion, treating it no differently than any of the other
+thousands of changes and fixes the Linux kernel project releases every
+month.
+
+However, at the request of the reporter, we will postpone releasing the
+fix for up to 5 business days after the date of the report or after the
+embargo has lifted; whichever comes first.  The only exception to that
+rule is if the bug is publicly known, in which case the preference is to
+release the fix as soon as it's available.
+
+Whilst embargoed information may be shared with trusted individuals in
+order to develop a fix, such information will not be published alongside
+the fix or on any other disclosure channel without the permission of the
+reporter.  This includes but is not limited to the original bug report
+and followup discussions (if any), exploits, CVE information or the
+identity of the reporter.
+
+In other words our only interest is in getting bugs fixed.  All other
+information submitted to the security list and any followup discussions
+of the report are treated confidentially even after the embargo has been
+lifted, in perpetuity.
 
 Coordination
 ------------
@@ -68,7 +79,7 @@ may delay the bug handling. If a reporte
 assigned ahead of public disclosure, they will need to contact the private
 linux-distros list, described above. When such a CVE identifier is known
 before a patch is provided, it is desirable to mention it in the commit
-message, though.
+message if the reporter agrees.
 
 Non-disclosure agreements
 -------------------------


