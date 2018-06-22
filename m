Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E7BC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38366246F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VphZ9n79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38366246F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934194AbeFVRyy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:54:54 -0400
Received: from sonic313-20.consmr.mail.bf2.yahoo.com ([74.6.133.194]:34650
        "EHLO sonic313-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933468AbeFVRyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1529690091; bh=Nzo5ZcP7cLROwCrd37cQ9udGP3UUxxzL4GZoRl4XjOo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=VphZ9n79mE2QKLqnV7PR4m1eb/fGyRAxlYeWvMO3oUl28ZmVfgVrKm3sOy0Yy1BHFiYnUIyX7HI0SnYGaLuzXj3hJ48gHnBKArqnHltgvCwF4UHuYc0lka7Lqphxq3ei6UIlMq+y9IsQ24kFJR8oZPtVZo6GI+YyP3cB7NgwiUWw5eIE50+fUjGsvmEDzCb/4P7/NOJptEbx1ofCdyzrL1dJdKMpXR097JWwmpsSxDPhU5SugK9P8+i/iDATlHVmDC3dTYoNHqjOZw9Lcmh9JFnIYpbSFXBk6BIY6plDEc2pbVGkrTwTjV8pe0zGfhUWutDhyPTVkw+FtJ+7lirJCQ==
X-YMail-OSG: 01mGWVAVM1m8kgKbQBgZmRtSyx19w7GJAcA2Bt6kuSDD2zCNTmzb.N73dLjY2hT
 rt6M5WXvh_73n_OxJdQTQ08DNFJ1DJxHF_TzBeYdDHzQgcAz6HylEyVBCarx4HH_wWpdLAeVFirV
 WHQdTyg_FqvtA1cIIY1bBbPQt4P9WiVWeTHX7LIY6NCnWHqWim6XmYnDROtWMuPGBeybbpuIVffF
 zjB28T3IUCl286.EUssDG8Bok_3edsHUECfzY0E8OtBbtn5HsUzYCo6ak7CVCAHl4AQDN2TUUX64
 3mFkBfM3HGFh2xeI4T4wGaWzi_FT5biK3HyMQRN8FpVoI_LEXC_Ds57a58219uUDEF0nY.JewwIP
 5Hatz.29tdiMvV8hsTAESgNhVtMed9bWzi1Rc1RY_p5Eu8brL60LEKAtqTpBXDEUkTuIQd8lKFpV
 nwwQ8aMVfBS.NdFkR2y.zVflaSHw02DnjVKl5GlFXNXZLSwpU0jwVrqEI1ljpr19EYBu7Mra7ec6
 lwj_zP4BzPNrHjGanxbYn5yepqdqwSyDhjj.bllnksFjz_xuj58ZKGaIPr_JyKfvgxcNX3bz.nEK
 3Pf3.Z2u0CTH5Se7cY8308NzC53j4Aqv8_iv6BhKNRoQ.QniZK0H.fSzWgoHuT3xwaONKgRa8I7f
 hO.mQ3clfV8G2BK5wCzDii9txV0fdFYT_Imztl5kqGlr1Vif.QPahqJJrH2TZ88embS22GSE0Wjj
 1tYQERjBUpkosUyvXb.Pm0xaGiBCmYU98NPlfTvceLDfJagW26xG8EBAwEMX3m_Oln2Ha4vv1sE4
 OIdQk.lwLbuRFVAfyYtcMkhvfqXFX9jlRgVNaF90HzTuvSRJkgDb8o4RAMiPLuQcntMhG8e.tMdR
 6sDRgFn3ST32WCP.ul8WG5nkzpiT9FISeMPRpOcuf98O.4lyxSIXfg9eTfUf5ZVqcaNZgQyinlwS
 7920YRTuCIglQrlBGCjB7wL2G.bVn2BIGNZCsu6n7T_Yw
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Fri, 22 Jun 2018 17:54:51 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 45fe987c79f10dd991ccc001b786dbc6;
          Fri, 22 Jun 2018 17:54:47 +0000 (UTC)
Subject: [PATCH] Smack: Mark inode instant in smack_task_to_inode
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
References: <020be8a4-961b-b92f-7ee9-3c439d629338@schaufler-ca.com>
 <20180622145259.GZ30522@ZenIV.linux.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b1bccdb2-032f-cdd6-5303-be8412629d4d@schaufler-ca.com>
Date:   Fri, 22 Jun 2018 10:54:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622145259.GZ30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smack: Mark inode instant in smack_task_to_inode

/proc clean-up in commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188
resulted in smack_task_to_inode() being called before smack_d_instantiate.
This resulted in the smk_inode value being ignored, even while present
for files in /proc/self. Marking the inode as instant here fixes that.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7ad226018f51..19de675d4504 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2296,6 +2296,7 @@ static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 	struct smack_known *skp = smk_of_task_struct(p);
 
 	isp->smk_inode = skp;
+	isp->smk_flags |= SMK_INODE_INSTANT;
 }
 
 /*

