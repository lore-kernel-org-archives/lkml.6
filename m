Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D98C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081FF20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="e3rMM/ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081FF20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeJPWtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:49:07 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37010 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbeJPWtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:49:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EF5AB8EE2EC;
        Tue, 16 Oct 2018 07:58:17 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EnnaDtbTJMUy; Tue, 16 Oct 2018 07:58:17 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7C0868EE0BA;
        Tue, 16 Oct 2018 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539701897;
        bh=MrIPtkfqcpZu7upiqU3Uqp2cPoEhddnwZ95XelvsT0c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e3rMM/iiSMCBBxXfP/Ly+zks3fnFNpTHUl/xvw+POvqpcSq/UfIysiKYvJuuBqBS3
         50CerHtGqO9DnhkKeNtugaekhYp5A69NHgmy8XLbE2OTlGMn0c44VL0ewkawYE2XBh
         XQV6tRHB3GtRA5CCuGAln1EsxUaXZKCkcV4h/InM=
Message-ID: <1539701896.2805.7.camel@HansenPartnership.com>
Subject: [PATCH v3 1/3] code-of-conduct: Fix the ambiguity about collecting
 email addresses
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Oct 2018 07:58:16 -0700
In-Reply-To: <1539701820.2805.6.camel@HansenPartnership.com>
References: <1539701820.2805.6.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code of conduct has an ambiguity in the it considers publishing
private information such as email addresses unacceptable behaviour.  Since
the Linux kernel collects and publishes email addresses as part of the patch
process, add an exception clause for email addresses ordinarily collected by
the project to correct this ambiguity.

Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Shuah Khan <shuah@kernel.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Alan Cox <alan@llwyncelyn.cymru>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 Documentation/process/code-of-conduct.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index ab7c24b5478c..aa40e34e7785 100644
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
 
-- 
2.13.7

