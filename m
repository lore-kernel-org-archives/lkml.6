Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E01C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95682183C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95682183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbeHMKT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:19:28 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32787 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbeHMKT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:19:26 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w7D7c1P0014639;
        Mon, 13 Aug 2018 09:38:01 +0200
Date:   Mon, 13 Aug 2018 09:38:01 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: provide more details about security bug reporting
Message-ID: <20180813073801.GA14633@1wt.eu>
References: <20180812132325.GA1608@1wt.eu>
 <82b1e47a-07ea-7104-65e2-1964ec325af0@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <82b1e47a-07ea-7104-65e2-1964ec325af0@infradead.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Randy,

On Sun, Aug 12, 2018 at 09:14:29AM -0700, Randy Dunlap wrote:
> I have a few corrections/comments below.

Thanks a lot, I've addressed them in the attached version. Linus,
please take this one instead.

(...)
> +Analysing a report takes a lot of time, and while sometimes it's
> +better to conclude to a wrong alert because there is nothing to fix,
> 
>        "to conclude to a wrong alert" needs some fixing, but I don't know what...

I changed this one to :

     "to conclude the report was a false alarm"

Cheers,
Willy

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-docs-provide-more-details-about-security-bug-reporti.patch"

From 46fe159d0a657994c352dac0b0af0ca3d57ca970 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Fri, 10 Aug 2018 16:36:04 +0200
Subject: [PATCH] docs: provide more details about security bug reporting

The analysis, disclosure and crediting parts were completed a bit to
add clarification about what types of reports are expected, what the
reporter may expect in terms of disclosure, and how reporters are
credited for their discovery.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/admin-guide/security-bugs.rst | 81 +++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index 30491d9..98c4d0e 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -26,6 +26,51 @@ information is helpful.  Any exploit code is very helpful and will not
 be released without consent from the reporter unless it has already been
 made public.
 
+Analysis
+--------
+
+Sometimes a bug will be very well understood by some of the security
+officers who will propose to you a patch to test.  Please be prepared
+to receive more questions and to provide answers on a timely basis.
+There is little chance a bug will get fixed if you send an incomplete
+report and disappear for two weeks.  It is also possible that some of
+the officers will conclude that the behaviour you observed is normal
+and expected, that it is bogus but doesn't present an imminent
+security risk and should rather be discussed on public lists, or that
+it does indeed represent a risk, but that the risk of breakage induced
+by fixing it outweighs the risks of the bug being exploited.  In such
+situations, it is possible that you will be requested to post your
+report to another more suitable place.
+
+Analysing a report takes a lot of time, and while sometimes it's better
+to conclude that a report was a false alarm because there is nothing to
+fix, it also is annoying if it is discovered that the reporter should
+have found it by himself, because the time lost on this analysis was not
+spent on another one.  This can happen all the time to be wrong about
+a report, but please be careful not to do this too often or your
+reports may not be taken seriously in the end.
+
+As a rule of thumb, it is recommended not to post messages suggesting
+that a bug may exist somewhere.  Since the security team manages
+imminent and important risks, bugs reported there must be based on
+facts and not on beliefs.  It is fine to report a panic message saying
+"I just got this, I don't know how it happened but it scares me", it is
+not fine to say "I ran my new automated analysis tool which thinks a
+check is missing here, could someone knowledgeable in this area please
+double-check".  The security team's role is not to have opinions on
+your beliefs but to spot the right people to help fix a real problem.
+
+Very often, some maintainers will be brought to the discussion as the
+analysis progresses. Most of the time these people will not have received
+the initial e-mail, and they're discovering the issue late.  So please do
+not get upset if they ask questions that were already addressed or which
+were present in the initial report.
+
+Also, don't consider the bug fixed until the fix is merged.  It can
+happen that a fix proposed by one of the security officers doesn't suit
+a subsystem maintainer and that it has to be reworked differently,
+possibly after a public discussion.
+
 Disclosure
 ----------
 
@@ -44,6 +89,25 @@ timeframe varies from immediate (esp. if it's already publicly known bug)
 to a few weeks.  As a basic default policy, we expect report date to
 release date to be on the order of 7 days.
 
+There is no point threatening to make a report public after XX days
+without a response because usually what you will end up with is a fix
+that is merged much earlier than what you possibly expected, for example
+if you promised to someone not to publish it before a certain date.
+Please just understand that the security team's goal is for your bug to
+be fixed as fast as possible and not to sleep on it.
+
+If you report a particularly complex issue that you intend to discuss
+at a conference a few weeks or months later, you cannot really expect
+from the security team to find a solution in time and at the same time
+to refrain from disclosing the issue to a broader audience or
+releasing the fix.  So at the very least you will have to take your
+dispositions to deal with a disclosure which happens much earlier than
+your public talk about the issue.  Also if you only sent an early
+notification about a forthcoming problem that is not yet fully
+disclosed, you must not expect the security officers to ping you again
+later about the issue; you are responsible for reloading the
+discussion at the right moment once all elements are gathered.
+
 Coordination
 ------------
 
@@ -59,6 +123,23 @@ include linux-distros from the start. In this case, remember to prefix
 the email Subject line with "[vs]" as described in the linux-distros wiki:
 <http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
 
+Crediting the reporter
+----------------------
+
+The security team has a great respect for reporters' work and wants to
+encourage high-quality reports that help fix real issues.  As such, the
+reporter will usually be asked who must be credited for reporting the
+bug before writing the final patch.  It is often not well perceived to
+send a report and start by explaining whom to credit for the report, as
+experience shows that people who focus a bit too much on being properly
+credited when they don't know yet if what they found is a valid bug tend
+not to provide the highest quality reports nor to interact the best with
+the team.  So the best way to be properly credited is to provide a patch
+with an appropriate commit message along with the analysis.  The second
+best way is to stay humble and participate with the rest of the team to
+the bug fixing session.  It will bring you a lot of respect and will help
+your future reports get more attention.
+
 CVE assignment
 --------------
 
-- 
1.7.12.1


--EeQfGwPcQSOJBaQU--
