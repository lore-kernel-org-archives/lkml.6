Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C10B2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMgT6DiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C10B2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeKNCxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:53:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51736 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKNCxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:53:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id w7-v6so12661814wmc.1;
        Tue, 13 Nov 2018 08:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hbhl4siY9JkEirGFQPRa5NX0OSFRMB8BIebI/HoFUX0=;
        b=rMgT6DiVfd7P554qGFlXcKB4+iZf5qmMLcPSIEIywkxZbfEKqxHnvKJuP1ODzelUAZ
         57uyv7J8vc/rRrg8bhMbEpWEd8YNI+M0NSgQ9CqeJ8cBEGVEvXDbjUWxtLBhLRtUcb/W
         yQqWZ1QE3H8BxAVyAE+kEA/0d3Hvc0ivY5MVFAclcfbXbg6mJfcGNx8dPc7f6JRSerPP
         S2m6jdp083sAOIgGrvDhNyEPDhRadNQYwoRRPP8SzCRHk43OKTvjHbXiGTrgQJeRh1C4
         caEMtL+bHKjBMwGoZEA/ZdXYu3qFp4LFEv9GjoZm7H6wjfHJFqSKi8ZzY07ZYf5liAVG
         cKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hbhl4siY9JkEirGFQPRa5NX0OSFRMB8BIebI/HoFUX0=;
        b=WqCSF/f3S04Tj1ljDEYPV29OMRYxI6DDMNcAQwkEMMPx6cykNNMkFi/17xdJ3j9MnG
         g5V8yfVA8+viAC9Gek/5VcldIzqq53nqRGbMdEgE2SYtazrfKq5snzEmf+6hShpsjt1f
         aoBHaax+BYNfRGJnrEKrDliqH7TQhQSBY3//tqaYSKyogSh5pOTbo0uNC5UlX+0TlDpb
         0pZtvgJannUa11rgcDFSsK2UjEE26ys+ySITLs0VPdh1TiPbl3F1MMmIB4y+Qy89170d
         ZxchrRAhgtLZ1ilbi4+FEeY9jtT5A0/npsRZL+sjchknCp57LygGxDrW6KTI335T+HUS
         Rnbw==
X-Gm-Message-State: AGRZ1gJo56PgMQMpGZTLgqcGacoKRn7cyKb0i6YsW7NUD9AEYVa0eXO9
        JDoVE+GNwpI4CdwegDr6Xw==
X-Google-Smtp-Source: AJdET5f7ano9rBOThf+3gfLJVAAz1beZNW5CA92/lKKasb3NIjNykIE3DhC7OINCh3iZt47TtK2pvg==
X-Received: by 2002:a1c:9690:: with SMTP id y138-v6mr3788196wmd.67.1542128089847;
        Tue, 13 Nov 2018 08:54:49 -0800 (PST)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id n131-v6sm22141432wmd.7.2018.11.13.08.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 08:54:49 -0800 (PST)
Date:   Tue, 13 Nov 2018 19:54:46 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: [PATCH v2] proc: fixup map_files test on arm
Message-ID: <20181113165446.GA28157@avx2>
References: <20181110184920.GA18252@avx2>
 <1541904527.857883.1572718104.2AE8D0DA@webmail.messagingengine.com>
 <20181112141456.GA15690@avx2>
 <20181112155559.GV13195@uranus.lan>
 <f1805813-62b7-8572-d906-bc49b62d1bf3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1805813-62b7-8572-d906-bc49b62d1bf3@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://bugs.linaro.org/show_bug.cgi?id=3782

Turns out arm doesn't allow to map address 0, so try minimum virtual
address instead.

Reported-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Tested-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-self-map-files-002.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -13,7 +13,7 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
-/* Test readlink /proc/self/map_files/... with address 0. */
+/* Test readlink /proc/self/map_files/... with minimum address. */
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -47,6 +47,11 @@ static void fail(const char *fmt, unsigned long a, unsigned long b)
 int main(void)
 {
 	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
+#ifdef __arm__
+	unsigned long va = 2 * PAGE_SIZE;
+#else
+	unsigned long va = 0;
+#endif
 	void *p;
 	int fd;
 	unsigned long a, b;
@@ -55,7 +60,7 @@ int main(void)
 	if (fd == -1)
 		return 1;
 
-	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
+	p = mmap((void *)va, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
 	if (p == MAP_FAILED) {
 		if (errno == EPERM)
 			return 2;
