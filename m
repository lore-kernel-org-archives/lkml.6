Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FB5C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D1C219C6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uUTnJT1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D1C219C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeHLSxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 14:53:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56046 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbeHLSxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 14:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AlMI4xGuSz018TaHHDSTKFpc91p1R/kqSmlrcHDI9PY=; b=uUTnJT1LN2tUVZ1CZkd1mXQSke
        ezWtr0kOm73H9VdAXIE7kADszIWghNA/f2yvbniR+uAuIswVTf/K4VpZy1R27iPW89M4ohJOJNY2A
        HLA3pLM/UZuYYUOotw3K3qWHtpeOG0fUCWcXEtfjfyDb5N/AoF5JLRTQvKvFyOama3B/iCtZmDrSN
        Eh1IygymBN4GyqN4xwdTSoPOK+zPfoon1wKATZSIIL0RHqRju5Tia6yV3yAVS1aMECt02l4lVrrSz
        0zAl/3g0pUVZdFKWEGsAzgTtyg8Tn7LxyPljnat0V9y8K1eBGqlsEnYz2oHwfkZzDVKd8VbWN7KwF
        YOk+YgdA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fot0k-0000wn-Q8; Sun, 12 Aug 2018 16:14:36 +0000
Subject: Re: [PATCH] docs: provide more details about security bug reporting
To:     Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180812132325.GA1608@1wt.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <82b1e47a-07ea-7104-65e2-1964ec325af0@infradead.org>
Date:   Sun, 12 Aug 2018 09:14:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180812132325.GA1608@1wt.eu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2018 06:23 AM, Willy Tarreau wrote:
> Hi Linus,
> 
> please consider applying the attached patch to improve the doc on
> the security reporting process.
> 
> Thanks,
> Willy


Hi,

I have a few corrections/comments below.
They can be addressed later if the patch is being merged immediately.


~~~
 Documentation/admin-guide/security-bugs.rst | 81 +++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index 30491d9..91ecd48 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -26,6 +26,51 @@ information is helpful.  Any exploit code is very helpful and will not
 be released without consent from the reporter unless it has already been
 made public.
 
+Analysis
+--------
+
+Sometimes a bug will be very well understood by some of the security
+officers who will propose you a patch to test.  Please get prepared to

              will propose to you a patch to test.  Please be prepared to

+receiving extra questions and to provide answers on a timely basis.

 receive more questions and

+There is little chance a bug will get fixed if you send an incomplete
+report and disappear for two weeks.  It is also possible that some of
+the officers will conclude that the behaviour you observed is normal
+and expected, that it is bogus but doesn't present an imminent
+security risk and should rather be discussed on public lists, or that
+it does indeed represent a risk, but that the risk of breakage induced
+by fixing it outweights the risks of the bug being exploited.  In such

              outweighs

+situations, it is possible that you will be requested to post your
+report to another more suitable place.
+
+Analysing a report takes a lot of time, and while sometimes it's
+better to conclude to a wrong alert because there is nothing to fix,

       "to conclude to a wrong alert" needs some fixing, but I don't know what...

+it also is annoying if it is discovered that the reporter should have
+found it by himself, because the time lost on this analysis was not
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

-- 
~Randy
