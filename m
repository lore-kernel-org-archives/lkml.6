Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBC2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BBE2177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otSGccgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BBE2177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbeHCTDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:03:03 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:54828 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeHCTDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:03:03 -0400
Received: by mail-it0-f73.google.com with SMTP id l8-v6so5851835ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=00MaZTx54LTz/cRjPC80NodenSgJXON2iMw0KJ/UXsU=;
        b=otSGccgQET2hLwAFuYbv7EsI+Azkg0K+I8rXuaHA82tBdYe8fcF+uG5pPJfcThSTv4
         acxv55j6ZtsiutJmZ+Wvd8MPhXFOzCJX962+U7o+6S4zIumwtzKsRYg3FYxSSUSRTVi8
         5N5/QKLgP1q1n/d/g02VXMvsnqbbrV85CTWdfS/1rsfJfqt9SrMRXqve1lDlOCnftIVr
         mCKhiCZnlwaeojGiiPwJjIaPSBPGIuWYERMf/CZKRAQj85mlscl7ahExiPjIS4VfLetg
         1PZavdQI4Ilr1lgTymG60M2qKR3dq7LVAjWIe2rOJmKkUQZTmwTQN5BQCTpwP6scBQt2
         7vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=00MaZTx54LTz/cRjPC80NodenSgJXON2iMw0KJ/UXsU=;
        b=DNLyMqLwsKya5Irh14o5CalwhSJKf4SvlIm2ty+uoZovGFEWK/tCeNGpjYGDqlrj2M
         j1/Y640Ioba7sQ7mbl6p5cACKRSjRg4+DnUq8JNwze6+ComXX4i2MftlVU4o9STUsQhs
         /emYJU30ZTbwHc1v0yH9VZvHb1CjvFQ5jpR+FCuf306BYfvu8ZeG/QIF4vgewo20brt4
         90uwAbxiblzqL4XG5XS/HE/sg98c0Rc+sCWv1velwFbeVWUsXlyiRY9f0p1OD7u5WaMq
         vbcqiPeg7ilvavOJ3fEE1Ripmqk33EyxntrzTVf70w+Z4Ic6PK7Oxec8wrgpitVWbTZi
         au9Q==
X-Gm-Message-State: AOUpUlFIpbill9BUdw1nJSISGn5mv4agpdi+4JMjwP0zJkaWoJQwk671
        MYe640+ejMPwzf7AuOAwp1mBjimmDZtNkfVTilQ=
X-Google-Smtp-Source: AAOMgpdcSCPjQBiVpw7AXW30qvKh7bkNywpLOP9fYOTNx/vgXUDLy/mQW8gGNoRfiRZJQZa/525su43VYW5K5psiqbg=
X-Received: by 2002:a24:9f03:: with SMTP id c3-v6mr3833761ite.9.1533315953848;
 Fri, 03 Aug 2018 10:05:53 -0700 (PDT)
Date:   Fri,  3 Aug 2018 10:05:50 -0700
In-Reply-To: <CAKwvOdmBtzkca-C1YpB_OYVyqFFi3P_Q8DJPaKr96DFZF0e6Hg@mail.gmail.com>
Message-Id: <20180803170550.164688-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAKwvOdmBtzkca-C1YpB_OYVyqFFi3P_Q8DJPaKr96DFZF0e6Hg@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] x86/irqflags: provide a declaration for native_save_fl
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     x86@kernel.org, jgross@suse.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org, jdelvare@suse.de,
        astrachan@google.com, mka@chromium.org, arnd@arndb.de,
        tstellar@redhat.com, sedat.dilek@gmail.com,
        David.Laight@aculab.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes commit d0a8d9378d16 ("x86/paravirt: Make native_save_fl() extern
inline").

It was reported that the above commit was causing users of gcc < 4.9 to
observe -Werror=missing-prototypes errors.

Indeed, it seems that:
extern inline unsigned long native_save_fl(void) { return 0; }

compiled with -Werror=missing-prototypes produces this warning in gcc <
4.9, but not gcc >= 4.9.

Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
Reported-by: David Laight <david.laight@aculab.com>
Reported-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/irqflags.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c4fc17220df9..c14f2a74b2be 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -13,6 +13,8 @@
  * Interrupt control:
  */
 
+/* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
+extern inline unsigned long native_save_fl(void);
 extern inline unsigned long native_save_fl(void)
 {
 	unsigned long flags;
-- 
2.18.0.597.ga71716f1ad-goog

