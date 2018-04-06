Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523021859-6-12014946197898033327
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021859; b=SlHC5ObV+jPqavnZzbIWuuGu4JsU584LOyEhmNcE7Zofb44kMi
    UGsE7ZcPga8zMX/jyiXiMeAs+bInYxBPg5P+Wlh3WppNd2wx3Uo6to7JfL9ChPdD
    l7HcCB/286suhj5/vtsusQq7eSDApNIOQrV4/l03kGhaRvxkE/h+XavY8QDVIlG0
    bq7198ffZJO/raweRpRw1FD2be+wEOpPLGQbcPhdGVIDoXuDYAmkPt6q9EzPc8au
    SxIs//D1h9YQao61aTB947urT4nGczKUdz+b44+OA6TQyz99IhRakbaw2uv+O9mG
    TZ0248UBtQIZBRoIaObacmkKe6OdPm+IdUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021859; bh=7xmF2HzUa2Mzvqpk8nDLoCqDNY4O00
    53JiYHLhpU0TY=; b=sa5ZqBjVX6dxZStgprifai2hDpGounj6qMu44eYAg/f1Q6
    1i5pNBWh9OgUprpUS2Lk8G2K49bO4AIsl3U3yZsL5moXccRGdFYuAme5jhDxallK
    HrAlTb6QOqp9oQ8NS/inYr4IVSi4NohDu9BnT1lr91L99S2DYThd7i3pD5CJrpa2
    IUC537S9kOKL2cyTWXns59q9K0HDN/PEhTelnEAeyn0FHSRpFtSU0RLGzTFIiSNc
    Y+l9YEBOywy6F7sUR6ni5zLWyTs9IvMXsPi3HxOO5vr9FhmeZy1maPtg0DpQVeo6
    7i9dNQ8uHLLXaz88903J7wYGvSGNduWVckjPJGmA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE+uaYZ3rpQP1jCMWS3A1OqZ3P1FoZLUHluJ2UmFmnt688ONM7YwGDjqisrn4l9r0mkQfOwR0NB6wkOvainIvNTd8cIkR1t6mI4iZXtM0WM8yWEfelfP
    f1qzdkyDmWNxMqK+HFJhc7rBbzd1lBNYfKF7pZQS0S2XrOCgfzpkUnCKGXhfEFp+IeLxzOaWywtNDJgy0V9K+9TOvycJeimxzKExbDdZ0ekihs0zkYgk9dYA
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8
    a=0WtUairGdEF_BEUKMhkA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932278AbeDFNhg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:37:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32884 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeDFNhe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:37:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Hackmann <ghackmann@google.com>,
        Alex Shi <alex.shi@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 074/102] arm64: Force KPTI to be disabled on Cavium ThunderX
Date: Fri,  6 Apr 2018 15:23:55 +0200
Message-Id: <20180406084341.914967207@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 6dc52b15c4a4 upstream.

Cavium ThunderX's erratum 27456 results in a corruption of icache
entries that are loaded from memory that is mapped as non-global
(i.e. ASID-tagged).

As KPTI is based on memory being mapped non-global, let's prevent
it from kicking in if this erratum is detected.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[will: Update comment]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[Alex: use cpus_have_cap as cpus_have_const_cap doesn't exist in v4.9]
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -753,12 +753,23 @@ static int __kpti_forced; /* 0: not forc
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int __unused)
 {
+	char const *str = "command line option";
 	u64 pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
 
-	/* Forced on command line? */
+	/*
+	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
+	 * ThunderX leads to apparent I-cache corruption of kernel text, which
+	 * ends as well as you might imagine. Don't even try.
+	 */
+	if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_27456)) {
+		str = "ARM64_WORKAROUND_CAVIUM_27456";
+		__kpti_forced = -1;
+	}
+
+	/* Forced? */
 	if (__kpti_forced) {
-		pr_info_once("kernel page table isolation forced %s by command line option\n",
-			     __kpti_forced > 0 ? "ON" : "OFF");
+		pr_info_once("kernel page table isolation forced %s by %s\n",
+			     __kpti_forced > 0 ? "ON" : "OFF", str);
 		return __kpti_forced > 0;
 	}
 
