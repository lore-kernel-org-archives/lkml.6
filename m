Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E15F21480
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E15F21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbeHWRjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:39:15 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47033 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbeHWRjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:39:15 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MNQ45-1fmXpx1VVZ-006vWg; Thu, 23 Aug 2018 16:09:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Seth Arnold <seth.arnold@canonical.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: remove unused label
Date:   Thu, 23 Aug 2018 16:09:02 +0200
Message-Id: <20180823140917.3060915-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:grJHwwJTlK0rHz1G6OtWa7dTqG4vghsaujpdwcJpZn2z+yg/OfB
 U6XF1K03gwB5EApMxlnJhsCc3e86uIB4p0cwCnvguGW94gnvn2jOXwledMKrZqoiNSPnNci
 xDbRQDGNJaqqLGqoe5wFjLFEWPjBtymUdiXrlRlWvf9b6G5ypOcEwnEeTeNbcKVIZb1msTh
 P9Cr1l5r5yjrb0bOGrQZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fHQrGI7movw=:qYT0u/CFnx96h5Ae9EES1h
 5xes1BjBYGCWrSGVppGs8/2G32NiW5K1E8Vc2GD6CLMPYZA6l+0wok0U7+bRPeczoJ+tW1UTg
 c2c6Jaa4eIkISc/WltTLu5CeHlyIrLti4GCmRpgQJ5s0oKwtAL56PPBDRzM41UuND2DBt4dI3
 H+7xtG69EsFDJy0t2M4nrd0CtMXyqYkjeJKKj+vshXBTU2gHEosCoW+YD+f8B1pTqU8MNOPd7
 Vzf2z5blFuF9T77Xbco05ssjj3Fe/aJ1aPXEcvm+veN29jMsOJeohZAxPVIANOf8u0gjaXnVr
 YdKLufeHHx2TacJ7OZ81h5joXtIkLk9ECfpKgD2c0g3CnblZFQ7kGxsfdqLhZI7MNbosVO2xF
 Rafs5xg+6GIQjz1D7rw+t0WMa2r6vsEJ+n3dL1xMOq8tBMOuXMPyoIK3kPQO4KfPFkJz0pPg9
 RIm+aUzN+EWd75+sjdyO9mLQOZGHtWmyscnnd30hiPiha+imtLKyupvkHGEdsUdhCfCpHkShU
 657CjXYx/kuvDddQmbZv8piic2lIgB8svWKQ640UsJwShAxgYMCeTULggO0Zb1PuKXAhQxojd
 1Cv90D2wNKStSp0o2jxc5ER32nprrN14kOONbspJAh0j0QB/O8dTnn4sbzUeakjro94pnp8sb
 385KrojIk4jd9qKTDJZFZXOYMPx6CzAM+HaYmL0oeeTZUBMpSKgrynGfqX6xQNvHcoqM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the corresponding 'goto' was removed, we get a warning
for the 'fail' label:

security/apparmor/policy_unpack.c: In function 'unpack_dfa':
security/apparmor/policy_unpack.c:426:1: error: label 'fail' defined but not used [-Werror=unused-label]

Fixes: fb5841091f28 ("apparmor: remove no-op permission check in policy_unpack")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/apparmor/policy_unpack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 3647b5834ace..96d8cf68ce65 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -423,7 +423,6 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
 
 	return dfa;
 
-fail:
 	aa_put_dfa(dfa);
 	return ERR_PTR(-EPROTO);
 }
-- 
2.18.0

