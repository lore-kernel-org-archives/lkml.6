Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08935C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF87420C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Q4nK2J9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF87420C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeK0KeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:34:17 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:44812
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727667AbeK0KeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275507; bh=jV11Dho+W8jm+OTKCjoUEiJ1PzwrfCLcMmvEuAbflbk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Q4nK2J9KPexbdiAxFNCpJbLhYux6mtOzZBYhpYerRgCIT4T9lcs3efTtp+3xx2F4Y/ZLc1kWXFmP4f6hnfo52WVlGsHnUMEZmj1mlOiTJPkDKX2YH41ubKpc+IhcBS7fwDL63ooeBF8DsHMp1FpuBlXvnRhNcZYYfodgYKRopucujHdlEtnEznv8Z0vL4b7TpsohwVnpqR8QYtoOQ9c68j9HL4uljrJN8ogwJv/Q9MJmJRyotYTKidw/RrKpce3TjI8STRXdS6oyp692uf9Rp3TP4tlPVgldKX4YH8hynQRy/fXeebTz5dv/mFfEL3kK8HyeVI6c94fiDSUR3mWj2g==
X-YMail-OSG: jFRivIQVM1ngjnr4QdwflB1dsQegw.b6uPut84.dlAyrgrpmW3JCDFqY0hokOM_
 SsDeaCCt6MFl0GZY01K3stMOV_P9Gr8H9RDAH1KrD0oEG_P64zkL9LN7iH4TabnlkwDHeeCX.W6d
 T7C2UF37eEtbVRJ886M6xwPoTn2Vyfv_.PbhHcsABcj5vK.5.nItivY4jxK1m9jsALlUl7IH3emj
 XOGj.eS125E2xeYODtiD11zIAg3rp.dz4osmXzmEk6bKNq0SYGY0zEjbkFPtFmLAWhsGK5_BuA17
 71UEjaYEp7P512UPuFoyO._zqGvaEkVcBZqrQCOMdrG2cU.rpbsW5f18IXSK79ilRhsuZ8o8OwAQ
 b6ozR8A0akszzvHTdt_vFGxrazEetKwGISkckxkR.BcMuctm9Dho3O282EWx1xUpQRaMekhixfP8
 F0D3hOm8ZAeS7cy80nsE5coSyfqJ9y5K7_G0gEpanxXi76D0q1IHTLursuZuUJAqXDcSCldGc80U
 Rv3WUHjRqCzb.u04iDdvA2yIWF2RbQPZUJLMoLMv_b3_GrAZtoKwnt0jljp_7IeHitYxfrQdWsUO
 CEDGV_MWJR1ufKlXqem.7lnQMBDNQiQFem_c0RC.z0OzYCuene8T7Ni9Cs_6y73aQZfpQVchrGas
 IDJ1LRsKCTVvr1DwqPR3s8gnF6uz2_3sxh8LtFEv_2JV4B0kWKMv6L3y7oUY5IwfDo1j6vXJEpsa
 UMZTfFymHyxXZL3k2ZqvvodQDT.1iTDTRikhUHTphrQf.78Ao5ilsW5drWv1u7pXtkeKjNmzv6CQ
 .p21Nl6khkFqrVasqy4CN09k_jWjIJvl5_hXfxF4IGPF.U5oIXwMuJ47nrGTcmXihQt5sMWam3kz
 XRGHRtgKo61T13xvkiAvfO_R_7vgydFDTLSjHydf3K6.J6U030QysttTRc47UJzULA.yo7YoUUHV
 Yv7u9lwbThpYEYLF7CplCTBN9vUBWkwvd6OJCCCVK0bNCGxaiwoQVwco4W3IKpnokZv578EvJckM
 agJsyJyuVD5vZhXmGHCIZ7Hahh_Lc7zgOGUM3atgw4tsDb4ef4yGu10ZoLMwVlEcfmc7LkOpCUjX
 LJgAC6oAvYv4M.a8chUUMf4Rl.xOPfWqNpBP.Fw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:38:27 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp417.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 453e085596c4061cfe71d166fcd08f8b;
          Mon, 26 Nov 2018 23:38:23 +0000 (UTC)
Subject: [PATCH v5 15/38] LSM: Split LSM preparation from initialization
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
Message-ID: <ff5b9d6e-6c1a-cbde-a816-eaa4974d13d0@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:38:20 -0800
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

Since we already have to do a pass through the LSMs to figure out if
exclusive LSMs should be disabled after the first one is seen as enabled,
this splits the logic up a bit more cleanly. Now we do a full "prepare"
pass through the LSMs (which also allows for later use by the blob-sharing
code), before starting the LSM initialization pass.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/security/security.c b/security/security.c
index df71b54c1ba4..3fac0ff39944 100644
--- a/security/security.c
+++ b/security/security.c
@@ -139,22 +139,28 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	return true;
 }
 
-/* Check if LSM should be initialized. */
-static void __init maybe_initialize_lsm(struct lsm_info *lsm)
+/* Prepare LSM for initialization. */
+static void __init prepare_lsm(struct lsm_info *lsm)
 {
 	int enabled = lsm_allowed(lsm);
 
 	/* Record enablement (to handle any following exclusive LSMs). */
 	set_enabled(lsm, enabled);
 
-	/* If selected, initialize the LSM. */
+	/* If enabled, do pre-initialization work. */
 	if (enabled) {
-		int ret;
-
 		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
 			exclusive = lsm;
 			init_debug("exclusive chosen: %s\n", lsm->name);
 		}
+	}
+}
+
+/* Initialize a given LSM, if it is enabled. */
+static void __init initialize_lsm(struct lsm_info *lsm)
+{
+	if (is_enabled(lsm)) {
+		int ret;
 
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
@@ -240,7 +246,10 @@ static void __init ordered_lsm_init(void)
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
-		maybe_initialize_lsm(*lsm);
+		prepare_lsm(*lsm);
+
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		initialize_lsm(*lsm);
 
 	kfree(ordered_lsms);
 }
-- 
2.14.5


