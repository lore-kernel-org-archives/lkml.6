Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA24AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703CF217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I6L7fLDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfAJWuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:50:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37311 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAJWuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:50:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so5829259plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PjA+rVOXmxc5D05RI4pQ+6fsK4qHYIl9a/rHkoavWRo=;
        b=I6L7fLDX7HVQ+WN8KHMiNuHmKHzAWIfOx5mRS1Y1hxxru5wNiFZly43TCRJZIOoyJr
         8juHcamB2QKyaaOv8SWbdWGu647V1YxDBTvPYLbHWRqsnyuKXQhAX3pMEM/hKJwVECKW
         07HpHoTLfF/jwqXKZqqZDGiOic0PGJ3VyJdL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PjA+rVOXmxc5D05RI4pQ+6fsK4qHYIl9a/rHkoavWRo=;
        b=O+yziP8UjqxMJbZF5bcsiply89b26psNohrCg4AZq2zzj/b5QOg7YrnMGBuiSqBpFb
         z6AFoNC8/l25L8jwbJnyW8pBcgiXAPlACZA6eKPQEzvQtMbOkoUld7deWzTVVq9/riER
         3JAznBXlPt63fDWY9hzkxTa6JBNgy5xCATgWRZocX9cV9lsAy4Lg16kkDpW7DVbqL7BI
         zL9tVaPiUycd8xyspwN7W8jYLpKvAJ68e5rCxKPT4ExHz0i3hG2v8Ooc8KEMWQ6XAUpJ
         N2JWBIPmAjb8HZZ0yxxsiXl2vTsDgzBNq9HU9MRanmdyHlUNP63YmUpx7bf9JAidtJqL
         /Tgg==
X-Gm-Message-State: AJcUukdVvxRsBhT3hxRA4qAOBBLOfMVcTqQC1UB3GyHnTnShSjeH8lU/
        Ho5Mx9ntuWNgo6JGJZ7idLV+XDqerr8=
X-Google-Smtp-Source: ALg8bN5utzxHWV8gdRjaXiOFrAKQa6YpeKyEiNPkGuq9bInsAESRDghOPpiRIcExZyisinUT0V/DYw==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr12008930plp.36.1547160601296;
        Thu, 10 Jan 2019 14:50:01 -0800 (PST)
Received: from localhost.localdomain ([2603:3024:1519:b800:147b:2e6d:d1a2:5d7])
        by smtp.gmail.com with ESMTPSA id 4sm125023402pfq.10.2019.01.10.14.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:50:00 -0800 (PST)
From:   Vadim Bendebury <vbendeb@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, joe@perches.com,
        Vadim Bendebury <vbendeb@chromium.org>
Subject: [PATCH] checkpatch: allow reporting C99 style comments
Date:   Thu, 10 Jan 2019 14:49:57 -0800
Message-Id: <20190110224957.25008-1-vbendeb@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110050117.55349-1-vbendeb@chromium.org>
References: <20190110050117.55349-1-vbendeb@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently C99 style comments are removed unconditionally before actual
patch validity check happens. This is a problem for some third party
projects which use checkpatch.pl but do not allow C99 style comments.

This patch adds yet another variable, named C99_COMMENT_TOLERANCE. If
it is included in the --ignore command line or config file options
list, C99 comments in the patch are reported as errors.

Tested by processing a patch with a C99 style comment, it passes the
check just fine unless '--ignore C99_COMMENT_TOLERANCE' is present in
.checkpatch.conf.

Signed-off-by: Vadim Bendebury <vbendeb@chromium.org>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b737ca9d7204..8a1aaeb8fa1b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -61,7 +61,7 @@ my $codespellfile = "/usr/share/codespell/dictionary.txt";
 my $conststructsfile = "$D/const_structs.checkpatch";
 my $typedefsfile = "";
 my $color = "auto";
-my $allow_c99_comments = 1;
+my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
 
 sub help {
 	my ($exitcode) = @_;
@@ -1011,6 +1011,7 @@ if ($git) {
 }
 
 my $vname;
+$allow_c99_comments = !defined $ignore_type{"C99_COMMENT_TOLERANCE"};
 for my $filename (@ARGV) {
 	my $FILE;
 	if ($git) {
-- 
2.17.1

