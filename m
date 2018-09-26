Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA9EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBCC214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QsS66B0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBCC214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeI0EMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:12:09 -0400
Received: from sonic312-28.consmr.mail.gq1.yahoo.com ([98.137.69.209]:42621
        "EHLO sonic312-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbeI0EMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537999027; bh=buh1wpgQyK9cadodumxz/6f8+58oQVM1eQS5F4Ot6M0=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=QsS66B0L4Jvj1dy8nFXjffJJksY8EfDFVKufc5E6lq4OWjAGRfUWVyFPjmmZXn3nz9dKgiI07+HuZjSPY5o1vPgrkbJptytNw2adlJzjG9luZkssAwNljIhdHt/L03MSR/VgzZAbQ4KuzWf/GJGxNETNAhBJBZgYdCtHTVteYrSf+O9LtjkDVzdgGVA9Ad9mUAvX53CXhsZRnevfGD/qhBrVqA5rKgPMoQkiGadbUs2Yrn4Qxaqbd3uGT8OHcEHM752sTsmPXmN+LRcMectlNb8AdkEkoXaXexD6kXemqXoRwPr8Vd1VbtO+1vPdKX4hqUIrRlVme5bK/vB9tCLO7w==
X-YMail-OSG: QTk01qUVM1krAtSUvo7sqf1xyyLWivyUA3k3HZ4AwyI1wIeSrAEsGu4cr_aKwq0
 k73vdxrM_ZPiSyNm5YE.RgRnPH8AXgMZ5nYWWDApabJaJSyMQUHokJTsX1dd07WRRD30uIs9RCHe
 BwnPat_6QS3GzC3aLxC.r4_o9FSCoLm8qXYUZ.l1EuzlKckHqGq949.2yXYN.M9JQ4fk3SopEdQc
 IVyvm6iIeqbsLIaqzbUJdhJ6S1UtGWzAniYzgleQOho5DZ6nFBlH.bjQEIDBNJRe07sxgoCl4T.6
 _BjhGrk7inYMFN3_RN__TbYcqGZmOY.aqwlBBnG9xI98omND2LmdHtOUaqoLLeuIllUkzIu4WCB_
 4WV1jI3mV8oVG8XFIuL.89C.xdyaJ6TKHeGK9DTFZMYS_LAr0ilxEvsKo9oDD8Hp.QoTNZxdX.62
 ek.X0nVIW6EoBZidmnyC63wS1TG4lZH6WEYTwZRtM9E6GEe06cOAe9HXkUZRIIe8n4fZcVykTt1h
 RQ3WLb_G56MS_HvF4TsGeQZ7zda2ylGR32dFhj0bcPHsBM6KgPE07W7B7b51xpNYd5p0qizLxwdW
 J7SI89GuE9nrN_QExZz1tuCaBvow.9JGjE7Fjv_LyAtft8BjB2fZk5hjv7_WS1qE7_tjWIAjigoG
 E5odQBHfe5qZoVhWZCYw8pXGMyG5BwvTzgxICf2w4KIZ9tM2rIXYx4dYF1LG_XFCSIZa_rOJJHaD
 dE5Td_cZtGsImr6TA5P7uSoLKolM.YVrpn8tjWxsAQw4kjQYC_L55nh6y8wBHa_6kQIfwn5FnkN.
 LYcO4FWrnUlsjBwmc4ebFYyVB10he05GrHnUMTHCUuRWRkijQL3A8MPPoHMLhuX8DZoA7R_GGIF2
 bUeL.lOe_1GjzuP_mwNGpaweAC72MTct4dtprEzm.5miBDrVDLqTXN0vRDdl6kJsg0RY0ZPexw5b
 LjJkxyHyzNywr7LmVSrUQt1SRhcXodUTWiWj_Bq7bcpbxNJQPVqAQFW8nec2oi2OOPb3CviRYPh_
 o5w2K3BJwX4eID9096sGJX2bTEda6TaQMJbM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Wed, 26 Sep 2018 21:57:07 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 328016718fb28565db579b7bd63a67d4;
          Wed, 26 Sep 2018 21:57:03 +0000 (UTC)
Subject: [PATCH v4 20/19] LSM: Correct file blob free empty blob check
To:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <44210861-2830-2321-911d-8783f5f0b172@schaufler-ca.com>
Date:   Wed, 26 Sep 2018 14:57:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of checking if the kmem_cache for file blobs
has been initialized check if the blob is NULL. This
allows non-blob using modules to do other kinds of
clean up in the security_file_free hooks.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/security/security.c b/security/security.c
index e7c8506041f1..76f7dc49b63c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1202,14 +1202,13 @@ void security_file_free(struct file *file)
 {
 	void *blob;
 
-	if (!lsm_file_cache)
-		return;
-
 	call_void_hook(file_free_security, file);
 
 	blob = file->f_security;
-	file->f_security = NULL;
-	kmem_cache_free(lsm_file_cache, blob);
+	if (blob) {
+		file->f_security = NULL;
+		kmem_cache_free(lsm_file_cache, blob);
+	}
 }
 
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-- 
2.17.1


