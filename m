Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C59AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636072077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636072077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbeICVuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:50:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46540 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbeICVuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:50:19 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0F595D01;
        Mon,  3 Sep 2018 17:29:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.18 001/123] PATCH scripts/kernel-doc
Date:   Mon,  3 Sep 2018 18:55:45 +0200
Message-Id: <20180903165719.557078764@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Valdis Kletnieks <valdis.kletnieks@vt.edu>

commit 701b3a3c0ac42630f74a5efba8545d61ac0e3293 upstream.

Fix a warning whinge from Perl introduced by "scripts: kernel-doc: parse next structs/unions"

Unescaped left brace in regex is deprecated here (and will be fatal in Perl 5.32), passed through in regex; marked by <-- HERE in m/({ <-- HERE [^\{\}]*})/ at ./scripts/kernel-doc line 1155.
Unescaped left brace in regex is deprecated here (and will be fatal in Perl 5.32), passed through in regex; marked by <-- HERE in m/({ <-- HERE )/ at ./scripts/kernel-doc line 1179.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/kernel-doc |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1152,7 +1152,7 @@ sub dump_struct($$) {
 	}
 
 	# Ignore other nested elements, like enums
-	$members =~ s/({[^\{\}]*})//g;
+	$members =~ s/(\{[^\{\}]*})//g;
 
 	create_parameterlist($members, ';', $file, $declaration_name);
 	check_sections($file, $declaration_name, $decl_type, $sectcheck, $struct_actual);
@@ -1176,7 +1176,7 @@ sub dump_struct($$) {
 			$declaration .= "\t" x $level;
 		}
 		$declaration .= "\t" . $clause . "\n";
-		$level++ if ($clause =~ m/({)/ && !($clause =~m/}/));
+		$level++ if ($clause =~ m/(\{)/ && !($clause =~m/}/));
 	}
 	output_declaration($declaration_name,
 			   'struct',


