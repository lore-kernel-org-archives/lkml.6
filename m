Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCB5C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC912146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8EYQUV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC912146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeIMEPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:15:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44094 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeIMEPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:15:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id d131-v6so2178419qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=PMBhSsUTwZQfsvYWSUIflvFWLLu4tkrVGV+SyhSri1Y=;
        b=K8EYQUV6Y4+Mr42NG7nL2JIlVboS6BsvhVX6I9qovcI5n95zUw3jcbGnc8Zz7Exhgg
         cmfjUgDWkUuc01mxnfMRIAKLRU1OTzLMltgh2quQC/RPa8yjxzDFJGpPQbnfd7GaiSjU
         vvwYPW+PT00pLh6KGgtz4mRwtkLDi0V5uLwuSnmYEXC7kJIz34YRDCseYzwi/wfBGexj
         0zkfBcGy3CbpIWvl6NLanynodq4N4UIpvS+H1/NEU3zSAqnECKpxNmswdAsLWwBUtsaB
         lVMp/98KBHWBT1KFmfRjlAnSNrUOPkWcdrpfB41n4Ij9m4QswX/uRnrFojPEMlqZUxqc
         jpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=PMBhSsUTwZQfsvYWSUIflvFWLLu4tkrVGV+SyhSri1Y=;
        b=NZxCDOBLYugYEY3iPkygFuCRM8jeh4QVmocpd9cR/fE4n15u9244oMJPiIxGpd4URT
         T1wGndbVZpBiHW7Y7btO5RFj8ikhvnZD4zLVLEKnMbrnKFRkUHiN/cuJoxluaVLSFWdF
         WbFDO7ES2uKjWjJGFqgzAS77JMuyPAt0GKcBZsiuTrfftHadwUaLXrGLXzYjdFzMnbOS
         9oY3BkXLdfJPV62G0QbdFcwfNCseeY6F6dtSYhcF83mwk33MNVZhhtJJusDCk5s59+d7
         HUquTxj7tRimFfZWkK8EdMaIS3020YdV4ELUJgX4+D9U/0VyNKNE9rKiROX2iHA9EIyC
         YqKw==
X-Gm-Message-State: APzg51CUs9pUG5SDt6a2NIgjJlMmg8PqSMjxA5Ir2KF5DUsBnwYSndpg
        2BnXhgJ3JXrkSy57+lv1mOww5Qju
X-Google-Smtp-Source: ANB0VdYC5p+eWj2iQ8Of79dz3/zb2oOEAGjUEVbzLdLf+4wLWcKr1kxoGGNvtQbpaSUCeCKKRnKBMw==
X-Received: by 2002:a37:c392:: with SMTP id r18-v6mr3290762qkl.56.1536793747455;
        Wed, 12 Sep 2018 16:09:07 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id y47-v6sm1596191qtk.27.2018.09.12.16.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 16:09:06 -0700 (PDT)
Date:   Wed, 12 Sep 2018 20:09:02 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] Optimize tests and remove shadowed local variable.
Message-ID: <20180912230902.GA9625@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes an unnecessary shadowed local variable (start).
Optimize test of isdigit:
- If isalpha returns true, isdigit will return false, so no need to test.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 scripts/asn1_compiler.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
index c146020fc783..a0056df4e358 100644
--- a/scripts/asn1_compiler.c
+++ b/scripts/asn1_compiler.c
@@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
 
 			/* Handle string tokens */
 			if (isalpha(*p)) {
-				const char **dir, *start = p;
+				const char **dir;
 
 				/* Can be a directive, type name or element
 				 * name.  Find the end of the name.
@@ -454,10 +454,10 @@ static void tokenise(char *buffer, char *end)
 
 				tokens[tix++].token_type = TOKEN_TYPE_NAME;
 				continue;
-			}
 
-			/* Handle numbers */
-			if (isdigit(*p)) {
+			} else if (isdigit(*p)) {
+				/* Handle numbers */
+
 				/* Find the end of the number */
 				q = p + 1;
 				while (q < nl && (isdigit(*q)))
-- 
2.19.0

