Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B37C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C74208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="beqR9sWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C74208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeK0KxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:53:00 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:35616
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727725AbeK0Kw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543276626; bh=3u9R9GyCFBDGOshX42y2/d53w6/c/YWPzQ9YJX8JK0o=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=beqR9sWYG4P40la0QKd9DjfrtbGL2ravnp98JKuw+KDujbTyZjYpTRvXfGGbXdWuuiDvObjUBMIzs/f1vmDEThCbOqCF7MVNQLR71wpBZGUmkyjVR67TdR2xeXIXZJQU08HZ3d6+UaVbX4Qs35fTpRGsETnJTKcTluDVYWQ7IDBzbWNlz5/LpgM1y3JNng1FLoFqzyLzjSiwR/ifonQeCrPS5lPEsKA9Lg9PmGPQk5DgTOhUj0t8TAerJOl7CNtq0wJQEKd3BrjY2Pt5DiczbwJsxoaArbin/26chvnB1GjxDBXj7in9jD/uOr1Nj/f15yCByP0JM9uovEgrdhwuJA==
X-YMail-OSG: wV_VxM4VM1mFVFV3WCrVT84wyUbUP3QxBitvUllHLQeqeglqbDAdsdE_kBk3XN7
 vRiMFuTDe.lMZCuYgYewvLVPzaCXuDrZ0cComlfVOomsMn7J6uCDPSLmQl5w6JtwmfiyS7OTn8yx
 j7hLAtxAgNiKa2fEDOp74hOoErWbELRBHFeNmnLIqCtfV4S.enBK851rAtwVkRP1iy_Oi7Daxz9l
 6a9EqIXddwXM1JdUUQlDh9srV0peFhowR0aCq6OmEBXord7kMHH02lDPrPmi_7qKAt1gkQrtChN7
 voxu435cnpaexO01kSt40MeYZeKz4bTadP5kDdqQY2beB_r07LzqpKON4ItvWF_m018bD5vbn_mM
 f1BuIXJKekypSqPxXaMPWDY49aokcztTwi1W6F_ZHtWW7fqjI6x3XGYVgUN2PbQCqM1e5Int3W5U
 GTQ_RONiLlMdvOiiKgUl_RROeG9irn7USBn5O5MHdQ108inx43z5.t4srrGRW1XYB_Ff3npE5KrD
 lSp0ruOHoYH9N68QTNi3h4Cp5pSz9wIag1Goa5CAptG_ctvAvSsk.QpdfAGn_45O_hWDuZWlh9Pk
 cquWDNc8apC5fOStw1Uni1BYphnTOJ6aGi9n4RDUmDz4yZ775a7Zs3NXJK03wTfPVyNfbYQlOhbt
 Huc6hzEwFQzS3gBXsZh.VgEm0w2mEp8enmFLrvhLkPRikMdYEnY9Qr5NkbVZVuHHWvRVL8rAzAcx
 lGHX9jVmBjHnpw.h3sgd3i3hF9HVL4T51LPSkiv7y88lm_mBFGXI7xBVLDSduVbW3sodG9PtLbg1
 0jnA7cpQFDZfI3uXKR1ruqaIRjlXI1sNEjrVwTpAV7CvQhoq7dNC6RClY3un4aVvDS_Ugv9H0Y5T
 MUW65_lWOMCLN_sacRbHmZ1L9xpitC7R9xfE0JrLgnciEM8PemIbRzir9HwLJkqpC6lf9W6GtODK
 aVjOS34jrWbt_B1h2.Ors.F77CBWihh7LTt1ZSZvapacuqDsOB9FHftmHCA2_d_Bzi.mZJKLjUt4
 Vkxxo34YRBnvPTDUJhYhN2FjDgH9FoEs3Ho4_Q95KoR8_VFmrMzbNmXN3mQP59jX3HNzYZGQ2yle
 RWfsq00BZyxPg96AfQEkSpLTrrs3dfmetl9htXw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:57:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4ab9a22a8175d9218d86768033f8d9bd;
          Mon, 26 Nov 2018 23:57:04 +0000 (UTC)
Subject: [PATCH v5 38/38] TOMOYO: Update LSM flags to no longer be exclusive
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
Message-ID: <02dd3038-09e8-34e8-ed57-8888788d17d2@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:57:01 -0800
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

With blob sharing in place, TOMOYO is no longer an exclusive LSM, so it
can operate separately now. Mark it as such.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/tomoyo/tomoyo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 9094cf41a247..066c0daf0efc 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -577,7 +577,7 @@ static int __init tomoyo_init(void)
 DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
 	.enabled = &tomoyo_enabled,
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &tomoyo_blob_sizes,
 	.init = tomoyo_init,
 };
-- 
2.14.5


