Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB6EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0AD213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Vv+oDbGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0AD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeK0KXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:23:42 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:42999
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727415AbeK0KXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543274875; bh=uAsv0IIeDWSBnAMhoEuAjy66Q65DNfoetbmf/Y4U8Ws=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Vv+oDbGt6fv+Z0GzAncTzpPLUgB1s/WrJOkqTVOQ8y7OLpOci6wwLj+NxAOBohmcHgkqqMSmZ7CvD8wYbk0klI9cputrVrf6lHeB7uaAdV1/z6co/RhR+eu3HS1tmEhQo6z4Xs0FjMnUwQsSH1mZxIOxtMV5CPVpV4iOJO4y+7BdeUWcVdV/KlhmvV4Lf8sM9z3304T8wQWu1LyHsF93S9P051gV/AjAAQN6VguKn8FEaQ7STyBK/4GEwgA/tXkovgu38IHGZkHQy6YjsrOlolve6cftPtSrJhLQSOgYHVluT3t9zl4Q4MjZtEV0rXGN8tfaljXQdwOsP+N20bjn0Q==
X-YMail-OSG: Nj.aEXIVM1lUXF02v81_KH.zP1WeFBOlEm4HBVY9SelHVnfAuIZvsG78agi8mkd
 8zgi8Zqs92zwbuFR_P2b2UxT3GXTXsK3NQn5BeON4BSB8kvc_alDbpbtIrzBBJBy583TRUMXU1eN
 LRd3y599IVYMK_BJS_EO14Su8OaWXRiaSPv7zC.EJQTeFxZMM6l7nGh4Wn_zbiq.y1fCy4BbIeqF
 ON5Laoq1euO_M3GEcadMYviaGc8geHLFZvBBqbri4fR91A7y7k4ud1YqOC34Z7dymPm3YeiwCIzj
 KXaynErXdn.ye5HkJEPh7ZsgK9XtBFAdeXYi1dfRNxemKGD3B2HxgO8EAR1SYgOOLfSTuKolIbCL
 bNPMpR223fIJfb9o0NaLDphXYgHTw.xQF8E1N4DVjZ00rfuyvA3HdTERpfcv9rzCO65hXtnNhfCn
 kyFlQNZQo.c1R9_H4a2yOubfHb6vLQtBvjybI9OwU_UcuaN9ZYHU_dRS7vXVDSkxsLy5fmfRUxhu
 kiSpwr_HMkdVCK6tUSNFM3RMtDBn7PLY4Th35DdGJEpfLX8veRr3GVWqF6hXmiQWnw9kTnnxRBYY
 aibpGNd0NDKWsqag.2jfDVGVmGtjcCdUrJ_z9ZF4SYxe_zwPiPiV3IXu_29jJu2d0dv_RWWMxJLT
 0flmRtYohdY4pDz1jGDLk2oiRx_nRQUIg_wzaaM2ENddTq.n2xcqo39j2CXNY0ErnjCiaCs7RtaB
 ouEMHLpTub72FYyVNQIE8NTt9WNSHZFx8MZSPbkapePuTneAbCo4pPNK1kxqyW2agtwhBmD7am6f
 YWUTAbrBTT5O3XMd7eiKxewqYhwTUJ0cRWGE.C2hH3ECdCyOcuS6CmqotlQTZWI63au_vNTwxW95
 aZmtXZbPqZb7lgZJ7Dm.iWAMZIfj6hKtCYqaQetLdJDQCwqXokevll1.vXVKo7cCyjLQAT8unuSa
 OPajpEYYPnIh3CYEQm3k77KY7Ehs89sNCY12Yy7FtUuta293Ym5EaS54W0Hhzbbm2g6aGlJyiBHB
 z2QHDtHY9MhA6obP3bYn2CFD1nNj0W9yGaaLcyicS_YOS5jhT8zVLHiSnSMF1.u_iNZ6ExqfR6Wq
 MYclnfJ4Y8px_lp7CbHs30FtwcDVR.rwk2emkaBfq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:27:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70cf2dfb53e39d77ff97b153171fb3f4;
          Mon, 26 Nov 2018 23:27:52 +0000 (UTC)
Subject: [PATCH v5 02/38] LSM: Provide separate ordered initialization
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
Message-ID: <163ac5dd-b78f-15d9-79c8-5adbe3fa100c@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:27:49 -0800
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

This provides a place for ordered LSMs to be initialized, separate from
the "major" LSMs. This is mainly a copy/paste from major_lsm_init() to
ordered_lsm_init(), but it will change drastically in later patches.

What is not obvious in the patch is that this change moves the integrity
LSM from major_lsm_init() into ordered_lsm_init(), since it is not marked
with the LSM_FLAG_LEGACY_MAJOR. As it is the only LSM in the "ordered"
list, there is no reordering yet created.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/security.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/security/security.c b/security/security.c
index 04d173eb93f6..0688dfd57e95 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,12 +52,30 @@ static __initdata bool debug;
 			pr_info(__VA_ARGS__);			\
 	} while (0)
 
+static void __init ordered_lsm_init(void)
+{
+	struct lsm_info *lsm;
+	int ret;
+
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
+			continue;
+
+		init_debug("initializing %s\n", lsm->name);
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+	}
+}
+
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
 	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+			continue;
+
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
 		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
@@ -87,6 +105,9 @@ int __init security_init(void)
 	yama_add_hooks();
 	loadpin_add_hooks();
 
+	/* Load LSMs in specified order. */
+	ordered_lsm_init();
+
 	/*
 	 * Load all the remaining security modules.
 	 */
-- 
2.14.5


