Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EA7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C122520880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK3PVyyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfBTVSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:18:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40750 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBTVSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:18:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so27663582wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 13:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=OS7hLu22rv7ygoytKqf9NhPYJbA9/ds/CFjit/n58QA=;
        b=kK3PVyyXWfZ6auaxYXdTjfcqVxa7xeZMJ9z57CkBrq6ED1lzDGelggdhOc7tHPHWXj
         WbmNjS0Qp0UaBTr+aZvRzQm9LJi3xDIvpHQ1ilUKgBhFb6AcTZ0rpVxgNat6YapGx6wQ
         ochQJVL61qCd933iHMAlw1qc0EzLD3NU1Ky4D/B3vtHByYr4hJ2LULK6w0Z0KkDtC7Em
         Zjes9icCYLrQ7qSloNbKabcx2MLtKIX3XChC0kBkmG6S2Yupr2eTHWLuNv7hXQKAi6YN
         e2ig54xks+/sesegZuILmi7m3ALWUr5wZ7SYZDqFe1RalJrGmPtp37Ab4lVFC2Y+80hA
         giOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=OS7hLu22rv7ygoytKqf9NhPYJbA9/ds/CFjit/n58QA=;
        b=rRI2jyssUi7hf2OL7hqaxF518dWMm8JHn0GszWHA8Zv0TOAtPPUntBvNhjNOnS9Z+O
         KTbhADwRXWrbeiaj05XF9jrymCmbUfarSaphGF182qPDP8fBq/wK9cffIOqP0J1Kfrpr
         LOLmv2R4GEK8QProNK4K0uipuR9d8cr9L1TOZEFGJRnFKcpfY5w3zB51eHS3Gtwn5YVA
         zg0z0V8erItcK8c7Rqrr0R5ukvZAFCY+3FyGLyfSVl1/FNt5pjIYj6YNPyAQNYSPsex8
         VLIrfoGyUHbRI80heppDxwhS3G23NwhCaabEj3jrjkaPIjaSWBZgbrmRoMeUtMt7DRwh
         3HcA==
X-Gm-Message-State: AHQUAubX4/OE/uWawZTM3vuEFQOLxLQcvnEv7bXiWU7N+CPOvPTOoDNY
        EBRr4JYD++aPo5roouN6ijcRTD/5
X-Google-Smtp-Source: AHgI3IZoRWnukzU381EHBqAJvC6GDtFgsRewa8fySEJyXCIOhzEG7i2cQEETf2Oz9Fma9GgBSZzHvw==
X-Received: by 2002:a5d:4f86:: with SMTP id d6mr21226499wru.89.1550697515647;
        Wed, 20 Feb 2019 13:18:35 -0800 (PST)
Received: from localhost (etr91-1-88-171-250-234.fbx.proxad.net. [88.171.250.234])
        by smtp.gmail.com with ESMTPSA id o8sm8578831wma.1.2019.02.20.13.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 13:18:34 -0800 (PST)
Date:   Wed, 20 Feb 2019 22:18:34 +0100
From:   =?utf-8?B?QXVyw6lsaWVu?= Cedeyn <aurelien.cedeyn@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, akpm@linux-foundation.org, corbet@lwn.net,
        gregkh@linuxfoundation.org
Subject: [PATCH] scripts/spdxcheck.py: fix C++ comment style detection
Message-ID: <9b8ba571688ec58361a502dc93693b2bfb1752dc.1550692590.git.aurelien.cedeyn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the last commit to support the SuperH boot code files, we have the
following regression:

$ ./scripts/checkpatch.pl -f <(echo '/* SPDX-License-Identifier: MIT */')
WARNING: 'SPDX-License-Identifier: MIT */' is not supported in LICENSES/..
+/* SPDX-License-Identifier: MIT */

total: 0 errors, 1 warnings, 1 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
mechanically convert to the typical style using --fix or --fix-inplace.

/dev/fd/63 has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

This is not obvious, but spdxcheck.py is launched in checkpatch.pl with :
    ...
    } elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
        my $spdx_license = $1;
        if (!is_SPDX_License_valid($spdx_license)) {
            WARN("SPDX_LICENSE_TAG",
                 "'$spdx_license' is not supported in LICENSES/...\n" . \
                 $herecurr);
        }
    ...
    sub is_SPDX_License_valid {
        my ($license) = @_;
        ...
        my $status = `cd "$root_path"; echo "$license" |
                      python scripts/spdxcheck.py -`;
        ...
    }

The first chars before 'SPDX-License-Identifier:' are ignored.
This commit fixes this regression.

Fixes:959b49687838 (scripts/spdxcheck.py: Handle special quotation mark comments)
Signed-off-by:Aurélien Cedeyn <aurelien.cedeyn@gmail.com>
---
 scripts/spdxcheck.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 3fb020c..4fe392e 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -177,7 +177,7 @@ class id_parser(object):
                     continue
                 expr = line.split(':')[1].strip()
                 # Remove trailing comment closure
-                if line.startswith('/*'):
+                if line.strip().endswith('*/'):
                     expr = expr.rstrip('*/').strip()
                 # Special case for SH magic boot code files
                 if line.startswith('LIST \"'):
-- 
2.7.4
