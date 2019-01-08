Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDD1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C85E218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+0Ia54X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfAHJ1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:27:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41594 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbfAHJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:27:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so2777632ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKWZrFGB2fy0hvkU+TdNt6WtCT+/Ni6C2ZMu+Ml6WUY=;
        b=M+0Ia54XDuUGFvSKsJv51akkZj2klbnLkb5VPfK36nrBR/4/a2cUVcWCIoUmpt40pW
         /rzjKIJ/GyVVEQw6R2CNIyz64nYNGPg/IIar/LtCFPsUpb+NECSexPvMnHMVLqyeqexM
         bs865UTcUvVLnykIpr+nGcjnYRWzMX7iVu5cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKWZrFGB2fy0hvkU+TdNt6WtCT+/Ni6C2ZMu+Ml6WUY=;
        b=GFvzEWNV/UeqOkgpR89jmiFu0vquq86/6N5Wv4S/f3g8IWqfEritpU3JYMALkc/67D
         Zn4W3l0jsemoUTrtj0/0FLxo6Jhruw6QVEhK/vu0hsIXvfsv1thEStYqsaYH378R3uHA
         OCC1nBTBI3UWiPR+q7GPpXIdeLj3g0XmYJRbUN7cOhGOKkXmBdRuswRrf8qizIe+bMIS
         3qwLYEg7G6lefGz7DoNy65BpDHwpWTaFWoRvSZhTwfpIutcRM5rWg5sZJm5n0eRa9Fqf
         v1zwPYLa5S8bN0t9R2YzyfmXDivx9bbsXVrEqts6sm4Y5G2qd04OCsMSGxB+AabCzPb3
         FuTA==
X-Gm-Message-State: AJcUukd2dOZgiPW7qRINkKsuAGxDJcQERdUVdZHholDyMJygCQLGNXJx
        c8hGziaeqaEzbq/9uqUJxtrC/A==
X-Google-Smtp-Source: ALg8bN7ofoJpLTk2p/ow9rJN0XSIyTUa5VssT88YWIglWuR8sk8IZtRAXxJBpNyNndsWKnWnRTHc8A==
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr655718ljd.21.1546939630590;
        Tue, 08 Jan 2019 01:27:10 -0800 (PST)
Received: from localhost ([79.102.2.92])
        by smtp.gmail.com with ESMTPSA id p23sm13078259lfh.47.2019.01.08.01.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 01:27:09 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/kvm: add missing executables to .gitignore
Date:   Tue,  8 Jan 2019 10:26:54 +0100
Message-Id: <20190108092654.13113-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 2a31b9db1535 ("kvm: introduce manual dirty log reprotect")
Fixes: 7edcb7343327 ("KVM: selftests: Add hyperv_cpuid test")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/kvm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 6210ba41c29e..51ffd8a8bc38 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -1,8 +1,10 @@
 /x86_64/cr4_cpuid_sync_test
 /x86_64/evmcs_test
+/x86_64/hyperv_cpuid
 /x86_64/platform_info_test
 /x86_64/set_sregs_test
 /x86_64/sync_regs_test
 /x86_64/vmx_tsc_adjust_test
 /x86_64/state_test
+/clear_dirty_log_test
 /dirty_log_test
-- 
2.20.1

