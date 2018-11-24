Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFBBC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E7D2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7u3F781"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E7D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeKXUXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 15:23:34 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38363 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeKXUXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 15:23:34 -0500
Received: by mail-wr1-f53.google.com with SMTP id v13so10832870wrw.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 01:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mdgkADSGunzT/TgLC29ha+YTFfAncqMVDWwTNEOKXdA=;
        b=E7u3F781imVIsXDL7Xp9YmgdFHo9ijdIccK+OPIG7CQptLnQCV5fzZ2J6adDuaas8Y
         XkgAmA17s2f7c9XGUkoXaN3vrTyhfF6SGPe3d48/aZOhhr/+B9fctxx+dbBlFddm2aX6
         e3g2EafswCWoCqP9M0h+hlpIyQre+b9mQPv129X8Di8Us67E38kLG5Dvc8CsgdM6x30j
         vWjbP+raQ2cwS83qIWUhedrkH3/rCe2ULkRK+OKoJnscBzJOGzv0XNFezHb8Bk2oeRLZ
         NWu0EH4dghTmofDzJJWTdhFsYLreEJfTqDD2W0kaKAMvBoVRSdNS2R8rgSRBX9AJIprI
         RWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mdgkADSGunzT/TgLC29ha+YTFfAncqMVDWwTNEOKXdA=;
        b=VJS7+ULlqoswRwUJ5cDcsw6fepCgBXS1Uacp7F2Vsk+rPYfkiLsE7UflSDBA9YdB3r
         6h2OgaQXtsx1biHP3eRRL2siZk9fy/VzCAvpLNDj0S5FFjJhe5ea1SuL4Sj18JjXP0wZ
         zv1vBRMnMDnbPV9lpcJI+RfapZVlO8X1pblw9RGNNXc4/+fMS+ulgF4YRkLIz2863vLQ
         rMBuZFFIDoXXSt8x8LqRILNwU5zC55ufwvgKOXzv9JQhCAuMCFpD6kWXs+XcXjsX022l
         sCmLm3f3NtPXSCv+Dne7uF7KApASVJ6lM9DnWyCSin91dBU2KaXQi3ykmUPVYzC48Zzz
         PT3g==
X-Gm-Message-State: AA+aEWae2wqDKhsOPHFuiMrSs1RrySybwL9diMJ/qQ3xD6lGAlY3Zp/s
        e+xPtgE4wnpxHfDGxjGiAf8Vy1w=
X-Google-Smtp-Source: AFSGD/V5+sf+2pgxZrYZmr3m8CHoSYi70dcchx+7K4cYg8loScE88fdsdIzZOYhvw0k7gHY8eyt03A==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr12947249wrs.268.1543052133277;
        Sat, 24 Nov 2018 01:35:33 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id x77sm12964997wme.19.2018.11.24.01.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 01:35:32 -0800 (PST)
Date:   Sat, 24 Nov 2018 12:35:30 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drop silly "static inline asmlinkage" from dump_stack()
Message-ID: <20181124093530.GE10969@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/printk.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -269,7 +269,7 @@ static inline void show_regs_print_info(const char *log_lvl)
 {
 }
 
-static inline asmlinkage void dump_stack(void)
+static inline void dump_stack(void)
 {
 }
 
