Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F283C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C5E206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h6+df3n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfAJFB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 00:01:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44829 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfAJFB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 00:01:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so4308339pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 21:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5M6sfBcUuALS4QpXl3ADcEle0ghfyeqAIrTntjgOs3c=;
        b=h6+df3n96dwPXBcQjYwSibYNZU2COJ3rqjHEV+H4U+TweuqKVdeFaVow6VuELGzx/4
         nBY8qH/uLHgWlmyXnrpQoAWi+ZFLrS4n3gQD7yz2BaXambvPPuMc0ixukepQLnHKWdo2
         JNwERlan3Da7rKNrODXLHyqU+mgTF0bl4p5EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5M6sfBcUuALS4QpXl3ADcEle0ghfyeqAIrTntjgOs3c=;
        b=P5OVNMG9oS4GXs3uM1h3noS2+YK7tguwq+zrci0SP70eC9NI6JlbSFYsVEytkHkYDl
         jAff8JLRO72DWzVMVY8BzGMHT3awpV28e6UF/NPStlQ5M+Ym5HWwCtzbd9ox+y/I2Per
         0944JUa6swyZlN5/Rx3knfYfr7d5wW5oxOXcq+JaJliY2Xv/IDAS9hBuUvU7E9q2A4oa
         4P5Q6rhtbvFSJlxbWQ2iglhgSRERYVA2IB8xfX5pyZesBI0pMj8n+QNxk0xTeGaH1dgf
         fTvyOR7ueqJC0fcsD4yHRrd7WzLoVlTIX7zCOorViQSK8+d6vRmilRsWykSGUNFkVuXc
         3KZg==
X-Gm-Message-State: AJcUukf9OYjr3J+Cy+8ZVwA9+unCkkaGgMfadNE6UsgLswn70KPNcA/y
        KkJlcyPWLketsLdpz9bLxj/OR8chAQQx4w==
X-Google-Smtp-Source: ALg8bN5WCLk0wik2OP1unWWlzs+t1vrBk0IidznerxtDfmh3wdgHXdAvsV7OPYw2/6Rimo+QXiTQYQ==
X-Received: by 2002:a63:c10f:: with SMTP id w15mr7965509pgf.199.1547096487978;
        Wed, 09 Jan 2019 21:01:27 -0800 (PST)
Received: from eskimo.mtv.corp.google.com ([2620:15c:202:1:6dbc:1c37:db8f:1f99])
        by smtp.gmail.com with ESMTPSA id w88sm130946278pfk.11.2019.01.09.21.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 21:01:27 -0800 (PST)
From:   Vadim Bendebury <vbendeb@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, joe@perches.com,
        Vadim Bendebury <vbendeb@chromium.org>
Subject: [PATCH] checkpatch: allow reporting C99 style comments
Date:   Wed,  9 Jan 2019 21:01:17 -0800
Message-Id: <20190110050117.55349-1-vbendeb@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index b737ca9d7204..c5fe10934080 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -61,7 +61,6 @@ my $codespellfile = "/usr/share/codespell/dictionary.txt";
 my $conststructsfile = "$D/const_structs.checkpatch";
 my $typedefsfile = "";
 my $color = "auto";
-my $allow_c99_comments = 1;
 
 sub help {
 	my ($exitcode) = @_;
@@ -1250,6 +1249,8 @@ sub sanitise_line {
 	my $off = 0;
 	my $c;
 
+	my $allow_c99_comments = !defined $ignore_type{"C99_COMMENT_TOLERANCE"};
+
 	# Always copy over the diff marker.
 	$res = substr($line, 0, 1);
 
-- 
2.20.1.97.g81188d93c3-goog

