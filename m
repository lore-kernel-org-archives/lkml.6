Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC90208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZFu7Owfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC90208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeK0KaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:30:10 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:35726
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727652AbeK0KaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275261; bh=JESyzlEmAuMKC2MyqRiFUQ6TTYRfwx7Dj+XqdsOoILQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ZFu7Owfcd2Os4HBSe0CXkqcXFfGreYQYM+u7rgIMxeCcjRTuF+xMVLjzgkN1wyLwIV5qyZqmRKL9mvbAmhqgdxcqOXrJKpCLp9oB6pvFVj7QQkBGd4CNf07ikVC8lHerWyKKVw5qOYaLf/2zh6NPZJgxwft/upzlP0R8J/7m0JU7X82VJ4TPrpQfbomsxu5s+L8H87e3eynHZdsZI+TbYgmj3O7L0Y3hlymfc7pb3nrSPqFkT1/uua/QbP/Mt1o2tMFJ/j7oFiY3q+NU+OxmtGdi6i3QStjD0A/KozrA+HL+H5hXaRtm7ggPi5qcQCIlFkAzvDJPhhlKCGbjt+imFg==
X-YMail-OSG: PXkK3sAVM1lqOBToQKU08pPKpcSixDim7PTaNa8tdg11E9V9Ab3YZ6J2wetjrtR
 sVEsDDJ2yKQiHZI4sKRNCf3hEpvPhfGDozlbD_OP1sfdrkj1s7flfF.IOfd4CaemaxckjVKrtUCJ
 Fdx2o8lM7_f4PlLIkaOvCZOuhiFMchQOwnvjYiKkBlcSh.5Z6oCfr.ihQK1bLdhy.IktDqfzcmln
 H4CeZQ7gGpJKHuleYj0eEHDcQ0zeNnjh5tFLazorw0KyhPSUvhnLhbmxb5tBbRvboVlOR11Md5T0
 RbPRb6JepsVCdNx7ekyBIC_CoIVlYXqxqwn5MKEwtlKMUbrFsRBLtnlurfo3hqFGMHKWGoOYYxQD
 kEzuqevv9OZhPZZiOWUIwndwqHfYztuBLx7km5hOxZOGkZTUJvuQYhO76RmrBivYBRLcpzzkbOKF
 _JCpS5IqC6IYrFUNy6w5EndMBHt8BY3VBXz_TY8xrgv4ekTSBbUGR3eO2cVcNoRGKJ4a5hCIyH_9
 wwM4R3hzk.a6zJFc2uGI9Pbx3PZOuBgXf_zFRTvZudYKz9BpVmkSChZcEU9ccWGIGOeLs1p3eK1O
 s16OgBn2ifjIC0aOAdn3QHMA8v4vITaj.IZwztXn3j.Uc0F2cIdvT3AepjZIDctXGOmu625m.Gcj
 LT8K.BE3.77GD7psKGph.pMaK4LXTsnGJN3f5DOkya23AgECig6K5chqLdv0zCaz8IUl21xOpDNX
 mmyDVva07F1j0Ob5GEPV2zK.HLZexvxRKiBMQThL3gOI3Fu5rgRAIiIP1yANZx70QZgiO0iydTT4
 2E2DBTEAIotdEb1b2mRcsrBiOZeqoiifva.tvM6gcJS3q2ZfKKc7x3HE1YBS6_f_KJ43yTqVn63D
 jxZoMdEK5Jbe7L98.q07YcrZTOKOJAZD.Hn2bIjIWz_pDKmhiA4tKhQPn86CV9vQoDHAsTgS9heP
 amrHgbeg9bwYu5L1PH.DX7pkS2y9lEOF4pPBAij6af78XtH.Nq0KGxUEavGjd5sQiMBKYQ3Z3jlG
 rydcdrTWNTuscvr5NUhCmFL_oGaask_uYXwMFFXZ3L7X_Sah3jBjCWG_UAcLay6lNEJki9uCIHoW
 zfLQqNS2KyhQH7n8I.FpDVXfBPbrMtWAbZZP650bRsOI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:34:21 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6719886c9db44dc80f25d476093b10cb;
          Mon, 26 Nov 2018 23:34:18 +0000 (UTC)
Subject: [PATCH v5 10/38] LSM: Refactor "security=" in terms of enable/disable
To:     James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>
Cc:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2b7a343c-c433-6a87-84ee-5b69e966a908@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:34:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For what are marked as the Legacy Major LSMs, make them effectively
exclusive when selected on the "security=" boot parameter, to handle
the future case of when a previously major LSMs become non-exclusive
(e.g. when TOMOYO starts blob-sharing).

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/security/security.c b/security/security.c
index f4a7b7d52d71..a7889885585e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -129,14 +129,6 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	if (!is_enabled(lsm))
 		return false;
 
-	/* Skip major-specific checks if not a major LSM. */
-	if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
-		return true;
-
-	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_major_lsm) != 0)
-		return false;
-
 	return true;
 }
 
@@ -164,8 +156,28 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
+	/* Process "security=", if given. */
 	if (!chosen_major_lsm)
 		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
+	if (chosen_major_lsm) {
+		struct lsm_info *major;
+
+		/*
+		 * To match the original "security=" behavior, this
+		 * explicitly does NOT fallback to another Legacy Major
+		 * if the selected one was separately disabled: disable
+		 * all non-matching Legacy Major LSMs.
+		 */
+		for (major = __start_lsm_info; major < __end_lsm_info;
+		     major++) {
+			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			    strcmp(major->name, chosen_major_lsm) != 0) {
+				set_enabled(major, false);
+				init_debug("security=%s disabled: %s\n",
+					   chosen_major_lsm, major->name);
+			}
+		}
+	}
 
 	sep = kstrdup(order, GFP_KERNEL);
 	next = sep;
-- 
2.14.5


