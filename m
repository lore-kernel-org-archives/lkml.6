Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE26206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE26206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeG0CqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 22:46:14 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:39776 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731800AbeG0CqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 22:46:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8F285813F;
        Fri, 27 Jul 2018 01:26:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brain86_7596608fe0163
X-Filterd-Recvd-Size: 3117
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Jul 2018 01:26:47 +0000 (UTC)
Message-ID: <a13641bc42f2981e7997f4a1900d5a480cc2ee6d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Warn when a patch doesn't have a description
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, ckadabi@codeaurora.org,
        David Keitel <dkeitel@codeaurora.org>
Date:   Thu, 26 Jul 2018 18:26:46 -0700
In-Reply-To: <20180726150855.a9a3e81d5cdc4630c7f4ca2d@linux-foundation.org>
References: <1531518027-13318-1-git-send-email-pheragu@codeaurora.org>
         <6799952fbd3639c764c112bde961b5e00270a52d.camel@perches.com>
         <6ed46f85a7577e1d4a48e81f67fd7581@codeaurora.org>
         <1b099f4d8373aa583a17011992676bf0f3f09eee.camel@perches.com>
         <20180726150855.a9a3e81d5cdc4630c7f4ca2d@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-26 at 15:08 -0700, Andrew Morton wrote:
> On Wed, 25 Jul 2018 19:22:47 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > Potential patches should have a commit description.
> > Emit a warning when there isn't one.
[]
> I did this:
> 
> --- a/scripts/checkpatch.pl~checkpatch-warn-when-a-patch-doesnt-have-a-description-fix
> +++ a/scripts/checkpatch.pl
> @@ -2517,7 +2517,7 @@ sub process {
>  			if ($line !~ /^\s*$/) {
>  				$commit_log_lines++;	#could be a $signature
>  			}
> -		} else if ($has_commit_log && $commit_log_lines < 2) {
> +		} elsif ($has_commit_log && $commit_log_lines < 2) {
>  			WARN("COMMIT_MESSAGE",
>  			     "Missing commit description - Add an appropriate one\n");
>  			$commit_log_lines = 2;	#warn only once
> 
> But I worry that you didn't send out the version which you tested, so
> please check.

You're right, I inserted the wrong one.
Anyway, what you did is correct and that was the only change.
Thanks.

$ diff -urN cp_commit_log_lines.diff cp_commit_message.diff 
--- cp_commit_log_lines.diff	2018-07-13 17:06:29.115337477 -0700
+++ cp_commit_message.diff	2018-07-15 05:46:29.878805336 -0700
@@ -2,7 +2,7 @@
  1 file changed, 13 insertions(+)
 
 diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
-index b5c875d7132b..8b5f3dae31c9 100755
+index b5c875d7132b..4ccf84079ea4 100755
 --- a/scripts/checkpatch.pl
 +++ b/scripts/checkpatch.pl
 @@ -2240,6 +2240,7 @@ sub process {
@@ -23,7 +23,7 @@
 +			if ($line !~ /^\s*$/) {
 +				$commit_log_lines++;	#could be a $signature
 +			}
-+		} else if ($has_commit_log && $commit_log_lines < 2) {
++		} elsif ($has_commit_log && $commit_log_lines < 2) {
 +			WARN("COMMIT_MESSAGE",
 +			     "Missing commit description - Add an appropriate one\n");
 +			$commit_log_lines = 2;	#warn only once

