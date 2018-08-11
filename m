Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDB0C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A5B223E6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPw0Tz0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A5B223E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHKLNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 07:13:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39740 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeHKLNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 07:13:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so8881644lji.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 01:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XbnXujNJw7aH+RdjV088rtentPGBRXGxsTZCnSE8ygs=;
        b=kPw0Tz0pUz5YqGwl5jeue4A3MUbjwZySreh7LlAHMpT151udhByWnaJZdOA+1p0k1C
         wsjTdhbAuKXhQ15OIdkgNvpkiux1z14Ikz/q8sIlnUhcwZ3L15273GY9bZkDThs8eyKu
         NX/3nXBc4TSSOYNVlSkiTyypDUF6ZeZwUFOWcrum0uIRzTHXELVYrkIGN9ct2IHB2KwY
         2xKHk3SccpZuPZOLjIPOiiQKkz8KFMgUv7eRkOc0wMrjrrm19ouxyqEqxrIGKAheMGV0
         +jCL7CZkeksjO01+NapNXr32/TNDL3mfAG0IrOMUBt4LIyoqjuTBUUfz82uf1BPZbio+
         C9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XbnXujNJw7aH+RdjV088rtentPGBRXGxsTZCnSE8ygs=;
        b=ZLEk0Prj4vyy+Sm8rv327/1yoUmVJ9uc+HNfP+iWhsgxNEpUCSlnF+WKhjz2xiHXxO
         4IqOtuUPY/tXXorp5xdVA79VdT0kGpOc+hF6R53X3c56Or4NZ3u1i7aTSEhoGfg3AV2C
         Jo0g4WzXFrwWLDcqImTUpufDJwqxq7AL9na040mk3jNy49Vn3tzbDaEn2OX/GsYYDDwF
         8JkgX00PExTqTot3QV+LjWd5j6unPjSSg50+ILlcJQq8VNtSaeN8v3qwoHzMgeAPlBRh
         TwWO1t73iMEIiW4WlKIeo7Gov6gjpRlyR6ErzzW83+s7ZPjQ2pM6h6mpfV5G5v2f5Tu2
         drLQ==
X-Gm-Message-State: AOUpUlGf1V5TOWSsbOj5W45ebLuQUo+8XkIbaw80aToU909w+jvsRcuY
        uOwbdGBUNVMnfv/vVYF43ZI=
X-Google-Smtp-Source: AA+uWPxr4vvjMozxLz84Z1H9XxWODvnNdnlDgb/joQuBt3L83+5YPTwYDKDdrFqgEEqB1HC1HEiEgQ==
X-Received: by 2002:a2e:557:: with SMTP id 84-v6mr7300926ljf.152.1533976772048;
        Sat, 11 Aug 2018 01:39:32 -0700 (PDT)
Received: from pc-sasha.localdomain (213-227-222-226.static.vega-ua.net. [213.227.222.226])
        by smtp.gmail.com with ESMTPSA id j64-v6sm2328063lfe.56.2018.08.11.01.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 01:39:31 -0700 (PDT)
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
To:     jolsa@kernel.org, acme@kernel.org
Cc:     mingo@kernel.org, namhyung@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, a.p.zijlstra@chello.nl,
        linux-kernel@vger.kernel.org, alexander.kapshuk@gmail.com
Subject: [PATCH] perf tools: Fix check-headers.sh AND list path of execution
Date:   Sat, 11 Aug 2018 11:39:15 +0300
Message-Id: <20180811083915.17471-1-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723070145.GB7523@krava>
References: <20180723070145.GB7523@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '||' path of execution in the 'test' block of the check_2() function
may also be taken if file2 does not exist, in which case the warning
message about the ABI headers being different would still be printed
where it should not be.  See below.

% file1=file1; file2=file2
% cmd="echo diff $file1 $file2"
% test -f $file2 &&
eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file1'
differs from latest version at '$file2'" >&2
Warning: Kernel ABI header at 'tools/file1' differs from latest
version at 'file2'

The proposed patch converts the code following the '&&' operator into a
compound list to be executed in the current process environment only if
file2 does exist. Should the files being compared differ, a diff command
to compare the files concerned is printed on standard output. E.g.

diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
---
 tools/perf/check-headers.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index de28466c0186..ea48aa6f8d19 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -67,8 +67,12 @@ check_2 () {
 
   cmd="diff $* $file1 $file2 > /dev/null"
 
-  test -f $file2 &&
-  eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
+  test -f $file2 && {
+    eval $cmd || {
+      echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
+      echo diff -u tools/$file $file
+    }
+  }
 }
 
 check () {
-- 
2.18.0

