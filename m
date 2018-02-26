Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387443-1519633685-2-1090473951371950554
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633685; b=QVlGyR3ozCShmylALnsPCOBtw9D/uflVDO8T8wVXJWGc9r/
    Lj95tlhUZ0JEtNvrwVkNKHqgn0mNthHERZlstliLX37tODoncAAQJZw4CjBprFc7
    NS0t4CNdigIytjONHRd4GswnQwyEK/4yRpnVLv4tYd3jtgrrIqgPSj57tsJZQTfO
    oO4wT7RoQnSb2/bKzQy5K44CmT/jLsaWP+/1do2brP5IoevmW5f9iF4LKxqiQEEh
    m8DoyaJQ9ZXQ5jKKwvTi/jez5anl315OpMp0ZqH3gOKem0kUDWd8f89feOeAC5tS
    BFeaG63Kq7TFooC75isIjMrXU9gFgdlxPD83uWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633685;
    bh=V4bM2YvsCwu18ZG/KjQ3BYGqsjNxEw8lX9Jc6LRIgdo=; b=mN72bID3KuSB
    TZhi8ggpWAeSdNw0HQ2T+sjx/K9ykgttUz0N+AwqUN3XOXyyODm+sRnhVKoLIIfE
    5cByaVdCFHQijgBus383UKRmCZQK2YF4fg1Nr025+Dc6ayZMAYHlqn01BWx9bJLi
    S2T4uL0hr7OPpT0duleToTXHYhz4g7cvtclK5e7FXPgkGntqraJvp/eXlJ8oQCcs
    piIt3NtdOBNFkHsYKvYGyZ+mEQFx5hisZDbmfpkh2mTimtJPfQX7EC55Eafa1ytO
    ovxFYGlorkb++Gt6weQFF0aN+a/RQPO2vFKEHycnrZwap+SqB/udyUy+sa13nsEx
    74ZZtqkVQw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=KE6Jdb94 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DnCXcE7q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=KE6Jdb94 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DnCXcE7q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeBZI17 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:27:59 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35047 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeBZI14 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:27:56 -0500
X-Google-Smtp-Source: AH8x225CPNDG3fT3WHgUM6nCiKIdeEWnqeI2Jilw/Ijb2gUwrxPdyRQCgECG9tmhMoSVWmGzevitVQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 52/52] arm64: Add README describing the branch
Date: Mon, 26 Feb 2018 16:20:26 +0800
Message-Id: <1519633227-29832-53-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

Provide some basic guidance about this branch, its layout and how we plan
to deploy changes in the future.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 SPECTRE-MELTDOWN-MITIGATIONS.README | 41 +++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 SPECTRE-MELTDOWN-MITIGATIONS.README

diff --git a/SPECTRE-MELTDOWN-MITIGATIONS.README b/SPECTRE-MELTDOWN-MITIGATIONS.README
new file mode 100644
index 0000000..7b71b81
--- /dev/null
+++ b/SPECTRE-MELTDOWN-MITIGATIONS.README
@@ -0,0 +1,41 @@
+INTRODUCTION
+============
+
+This branch is based on the v4.15 release of Linux and contains arm64
+mitigations against the cache speculation side-channels described at
+http://www.arm.com/security-update and commonly referred to as "Spectre" and
+"Meltdown". Mitigations against variant 2 are also included for the 32-bit
+armv7 architecture.
+
+
+LAYOUT
+======
+
+Each commit contains a subject prefix which clearly identifies the variant
+which it is attempting to mitigate against:
+
+  [Variant 1/Spectre-v1]
+  [Variant 2/Spectre-v2]
+  [Variant 3/Meltdown]
+
+The commit message begins with a reference to the upstream commit ID. The
+arm64 patches are targeting the v4.16 release of Linux and so the upstream
+commit IDs may not appear in mainline releases prior to v4.16, although they
+should still be accurate.
+
+
+NOTES TO INTEGRATORS
+====================
+
+Please note that this branch is intended to be used as the basis for backport
+efforts into stable and distribution kernels. It is not intended to be
+integrated directly into production kernels and will consequently be frozen
+when v4.16 is released after which it *WILL NOT RECEIVE FURTHER UPDATES*.
+
+Subsequent fixes and mitigation work will be queued in the mainline kernel
+and CC'd to the stable trees as per the usual kernel development process.
+Integrators are advised to track these trees as closely as possible.
+
+The patches here are intended to be specific to the arm/arm64 architectures
+and therefore mitigation efforts elsewhere in the kernel (for example, in the
+eBPF subsystem) are not included as part of this branch.
-- 
2.7.4
