Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70798ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA39206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA39206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeGQRbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:31:10 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43948 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729671AbeGQRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:31:10 -0400
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w6HGvagH018469
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:57:36 -0400
Received: from mail-qk0-f199.google.com (mail-qk0-f199.google.com [209.85.220.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w6HGvV9S010911
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:57:36 -0400
Received: by mail-qk0-f199.google.com with SMTP id 17-v6so1340802qkz.15
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 09:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=LtVku/iuck+D5WG5Ro4sIvNmREvameSM9cOdfPJuUAE=;
        b=G/17FAuNnecZKliMFZ8pMVzUJCgUB+XANGWr7gzour5MmgAU21Jg1hTEj4KDa6krm8
         LciTxxMA45n0mU+4fZEK62RlGYidkbRBOH+QQhhWIqDVKbxeD598intSNwNJjgDh9p2X
         3nbXrBQvuXlOjc6qUDXptVSNRCjlJG0QQjaRsn5W1eGlW+dm7YqrIa0TCHx5xtUIqgob
         KN660soDfBHZ2Z9Y2EOZhydz+DqLZInCpGOZPsY9CrMEDSzV5qVDi55yqEICqde7eEmA
         tMmcFDc9VSw4oYrStO29UPHZh52LLpwQ3iZLzUamWTNchPmLf0SjeBJ+mygDsvUHjnSv
         ozzg==
X-Gm-Message-State: AOUpUlEVBTVAhKcOQ71M1rhCR+6/dzz7C/QE+X5UkAoFXegIJNg8FlHN
        BpeTrwT0oK6JtSvImFKaMoEHkhHfM0JXaSXEqxFwgQO3eQWlMmm0w0rDXMdAC3dFYtInBHRYnxE
        isoUVAXChWFUBjlksMJSo1quk/G44TERkT1s=
X-Received: by 2002:a37:6393:: with SMTP id x141-v6mr2341551qkb.318.1531846651693;
        Tue, 17 Jul 2018 09:57:31 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpdpiNgvm6shMF4qL/Yf2bto6cOEuUd7mdXbqGEQORhoVFUWKjpsRzFTyyZn/mpKw+qbW7RMnQ==
X-Received: by 2002:a37:6393:: with SMTP id x141-v6mr2341537qkb.318.1531846651542;
        Tue, 17 Jul 2018 09:57:31 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2607:b400:24:0:40a6:3022:e8ef:6dd0])
        by smtp.gmail.com with ESMTPSA id k38-v6sm1341653qtc.45.2018.07.17.09.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 09:57:30 -0700 (PDT)
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PATCH scripts/kernel-doc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 17 Jul 2018 12:57:29 -0400
Message-ID: <50400.1531846649@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a warning whinge from Perl introduced by "scripts: kernel-doc: parse next structs/unions"

Unescaped left brace in regex is deprecated here (and will be fatal in Perl 5.32), passed through in regex; marked by <-- HERE in m/({ <-- HERE [^\{\}]*})/ at ./scripts/kernel-doc line 1155.
Unescaped left brace in regex is deprecated here (and will be fatal in Perl 5.32), passed through in regex; marked by <-- HERE in m/({ <-- HERE )/ at ./scripts/kernel-doc line 1179.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 0057d8eafcc1..31a34ced55a3 100755
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

