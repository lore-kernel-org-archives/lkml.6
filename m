Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5027C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A017420842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4Va9T/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A017420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932632AbeGILtb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:49:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34878 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754433AbeGILt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:49:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so1426343wrt.2;
        Mon, 09 Jul 2018 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kFTXQaRhjI3Nk/xtEAwgDm+mZ7U1Fv2jEqBzEFo+tug=;
        b=Z4Va9T/tZBoXaRev4xJQDDJjIwdI3K/UK7wmiKlirh8GQAOLBIs1q+so2PsbPfIlh0
         A+n1cmCclHAIl561OvNW+4auNB+x2xrSaeTKhncffdTMutvEm3pqkR/in22ZFBbHObm/
         hHwBR2DLNwnR+FkuIVkT2MCSAm8AjRpUGPS6HWfoLYliVoJiqJx23KgG5SUVfzpA53/u
         UOHxdsRsh4yxTcSD3YB85QjNJb5gnKWyK9+fV1vcAvAgfC2O3vG4gULdZWEQ/VOJQG1v
         4HRrWlVIyXfgrO61SEIywUAiO4IqTqRj1M6MJspAJ1TTePv8KJhgUth9L8KlMno9QUoM
         NW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kFTXQaRhjI3Nk/xtEAwgDm+mZ7U1Fv2jEqBzEFo+tug=;
        b=mMciO1v2LAX8rRxEsyx9qF0hublsDhXUwy4bhl4yThHUIj6d3i/yfif9GHkoO9Yt4x
         Kt1EI/r11x4cwgxjT6mnHD0xolCe+o8qdGpJgDmaJD77kR77R/jWZMX3TmnHV41ZCCeR
         M0bP+WexfHhYqCCBP7TENI5XCDW/Y19/ygZ7gxy0GQNvd8lNefT26/fhCJ1g6sv1VlFd
         31JbwJdz/M3FYn/Tw4wwnwl5m9l0QyMaOfKhnU/q0B6drsVVNETLnAlUF0l5numi/RaL
         aE6oJrJuQmsr/P0aINjgFfvK3qY/QtHU+/ivl5es50nPFAFcDSaR6b3XVjdGGcrHfZ+F
         Idzw==
X-Gm-Message-State: APt69E3IV0GfN8LSirutE9qV9gymYD8dcEcTfp2dq9sO2sSlVWp4tCIZ
        1D9+m9PeKQS2w9Xsf3Kslx+VnFc4
X-Google-Smtp-Source: AAOMgpdOgwBvyF05Zu8Q3oRN8xDXxf4WXoxyv/B89bbpemihpM7a4ExKDMN9CwYyp/8NetKE56P6FA==
X-Received: by 2002:a5d:5641:: with SMTP id j1-v6mr15226928wrw.209.1531136968303;
        Mon, 09 Jul 2018 04:49:28 -0700 (PDT)
Received: from msi-8775.fritz.box (p200300EC43C483007ADD4582C6297BE1.dip0.t-ipconnect.de. [2003:ec:43c4:8300:7add:4582:c629:7be1])
        by smtp.gmail.com with ESMTPSA id w21-v6sm18871140wmw.29.2018.07.09.04.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:49:27 -0700 (PDT)
From:   Tobias Tefke <tobias.tefke@gmail.com>
X-Google-Original-From: Tobias Tefke <tobias.tefke@tutanota.com>
To:     tobias.tefke@tutanota.com, ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: remove unnecessary condition in bpf_check()
Date:   Mon,  9 Jul 2018 13:48:37 +0200
Message-Id: <20180709114837.23864-1-tobias.tefke@tutanota.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the label skip_full_check the function sanitize_dead_code()
is being called if the return value equals zero.
After that call there is another condition checking
if the return value equals zero.
If this condition evaluates to true,
check_max_stack_depth() is being called.
However, sanitize_dead_code() has no return value.
Therefore the return value of bpf_check() is still the same
and the condition can be removed.

Signed-off-by: Tobias Tefke <tobias.tefke@tutanota.com>
---
 kernel/bpf/verifier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e2bf834f13a..b022d0a85427 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5935,11 +5935,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr)
 	while (!pop_stack(env, NULL, NULL));
 	free_states(env);
 
-	if (ret == 0)
+	if (ret == 0) {
 		sanitize_dead_code(env);
-
-	if (ret == 0)
 		ret = check_max_stack_depth(env);
+	}
 
 	if (ret == 0)
 		/* program is valid, convert *(u32*)(ctx + off) accesses */
-- 
2.18.0

