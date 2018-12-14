Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB80C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C15208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rf7XRa3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C15208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeLNNBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:01:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45084 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLNNBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:01:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so5181167wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 05:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eR9uYqeuJyN5e2VWkmKkgWCJntXUaglKsOhKlriosWo=;
        b=Rf7XRa3GMBHzFXpiAS+HwX7psrhGETZdyMwNipBZV3J5STZ1TffpXLIBB0atoJKa9w
         x5GjVVpIBmxQZ0xdjb0JjEF6Y3yEk30Va0altB4h7vq4u/wuLDis7esaQEKpKN0yevFB
         asfcfCuIwRXnTW786JemsYQjQiP+HE+JE9A2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eR9uYqeuJyN5e2VWkmKkgWCJntXUaglKsOhKlriosWo=;
        b=Cu8fNY2DxfMoK8Vhh2r+KB0SvK4ZQZm6cl4rlR73C/yI8KYN8s5D9EUDeKkxCO/EFf
         ceSTPBkUyuYtnhYIlSUdOB+3JikI8Ui1EEuuXSTH/ea6UkUpQP6g/ZDP+fp0UesBmRGX
         kHHIpcWGpudceCkgbK12g/K5+Yt5MkCIsyzktSkIQJ8K+MqXWFKJbpyKAes8q69llISV
         dQPNZAnlOX2n4G9DbGxCnxxu4GaiSkqygPsNqtPewADY5TXicN2xk0vsvcNQa1jmYA1r
         Ny3EHTaE41qHGzZVlVuwbEsZL2xwixDfgkD6nA5EAl/KLBBE2RH777mlqT/M1ZZmz8YX
         VQ0Q==
X-Gm-Message-State: AA+aEWbtAS3M75WZ2qExWFJVnzK1tja/IsoHiUQYkU3s5m7BrCgIcvQS
        BqH1lBllnJ77NGYwc6whPE2Y8w==
X-Google-Smtp-Source: AFSGD/VTZqf1KBanPmidoIlQjAz+GUlT/Mfe6U0a4UzF08efXzsTgMMNC6r+kWjkeiTzEmBF4s56HA==
X-Received: by 2002:adf:900f:: with SMTP id h15mr2551854wrh.18.1544792497967;
        Fri, 14 Dec 2018 05:01:37 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id y34sm11597078wrd.68.2018.12.14.05.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 05:01:37 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
Subject: [PATCH] checkpatch: add Co-Developed-by to signature tags
Date:   Fri, 14 Dec 2018 14:01:34 +0100
Message-Id: <1544792494-15485-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Documentation/process/submitting-patches, Co-developed-by is a
valid signature.

This commit removes the warning.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93e84c9..cab515f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -468,6 +468,7 @@ our $logFunctions = qr{(?x:
 
 our $signature_tags = qr{(?xi:
 	Signed-off-by:|
+	Co-Developed-by:|
 	Acked-by:|
 	Tested-by:|
 	Reviewed-by:|
-- 
2.7.4

