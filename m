Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95760206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqen0wuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfAJEXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:23:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38608 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfAJEXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:23:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so10597306wml.3;
        Wed, 09 Jan 2019 20:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqX0rVPHii2lBkNIAiDC7sBkxbxQR0a9q1iDJSjqxlc=;
        b=Rqen0wuOTZdcHwhIBQKC3NfCebb22kcMUIBKJjYOy0rNOoFf6Nzo8GE1bRSxJQjM3m
         u1c+YnkOTiei1YT72J8OlWnYl8wA2wiKLDW6S3byk9y0GJeVQncKnRMWsoT3pRNUePFW
         c27MXDbObamUa2L1kIVbFFzfk/VYKmFgmfSMV+2OGVE8Y/8IMbv4QFt48vO/jboS57+2
         2Qx/Y+BGlpWQy1QoxeFWzHMs6eDAxf0/5rdVfxIm4Hd8VNA7epdgXyZ4T0M4+zweMwIm
         2X6XR/5s8VHUb6TDRbVTYj6Ns05oy4+xB2/00vGNxqG5dTT9Y2dtljffhjx8V2yYV3P4
         BoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqX0rVPHii2lBkNIAiDC7sBkxbxQR0a9q1iDJSjqxlc=;
        b=MTZs4edzoN/S66HuHiSM2z9E3OdghdwyOba1VGTg7XjM13j2tPYIdkNE4A9yir95yC
         jK611jTc5h8UDl4FgYnePLnJUS4M7UBYTdxL6PPrt1E0Qw273CgtPXrplblUgMg8mBoD
         u9rMljbZrk+EirGlR38QPw8+4OwwGRWEmTxzK+5eMV4ynl81CxRLF3ThqlU+B0kw4hv/
         xKCNJeKMk2IyyXvuGunWZ/Uml8IFu82cuXT2guAjYcca9UDoPLj0w47MpkSCCufMIbFC
         SaSzoSI1Zv1ZTkzO3Woy1kcn1j+xZ6ardwxleLc5/lyyqWFCP9jEgaMtIBQZEu3DkgUM
         lpDw==
X-Gm-Message-State: AJcUukf8Q9IwzM44cLqed6Cn086f5SnY9dbLT34AsED8ZCxNGeAgGPtR
        2V2W2axTa2sARdWD9B2OlmA=
X-Google-Smtp-Source: ALg8bN6NUzhMjMNUeJ9GUcxi661elHrpdgfTM/go1BxH+6ID8PPpiEPM6XooZkp4kkEb5Ru4kkptJw==
X-Received: by 2002:a1c:2787:: with SMTP id n129mr8450620wmn.128.1547094178308;
        Wed, 09 Jan 2019 20:22:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id o17sm31424404wmg.35.2019.01.09.20.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 20:22:57 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH] iavf: Use printf instead of gnu_printf for iavf_debug_d
Date:   Wed,  9 Jan 2019 21:21:57 -0700
Message-Id: <20190110042157.8445-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

In file included from drivers/net/ethernet/intel/iavf/iavf_main.c:4:
In file included from drivers/net/ethernet/intel/iavf/iavf.h:37:
In file included from drivers/net/ethernet/intel/iavf/iavf_type.h:8:
drivers/net/ethernet/intel/iavf/iavf_osdep.h:49:18: warning: 'format' attribute argument not supported: gnu_printf [-Wignored-attributes]
        __attribute__ ((format(gnu_printf, 3, 4)));
                        ^
1 warning generated.

We can convert from gnu_printf to printf without any side effects for
two reasons:

1. All iavf_debug instances use standard printf formats, as pointed out
   by Miguel Ojeda at the below link, meaning gnu_printf is not strictly
   required.

2. However, GCC has aliased printf to gnu_printf on Linux since at least
   2010 based on git history.

   From gcc/c-family/c-format.c:

   /* Attributes such as "printf" are equivalent to those such as
      "gnu_printf" unless this is overridden by a target.  */
   static const target_ovr_attr gnu_target_overrides_format_attributes[] =
   {
     { "gnu_printf",   "printf" },
     { "gnu_scanf",    "scanf" },
     { "gnu_strftime", "strftime" },
     { "gnu_strfmon",  "strfmon" },
     { NULL,           NULL }
   };

The mentioned override only happens on Windows (mingw32). Changing from
gnu_printf to printf is a no-op for GCC and stops Clang from warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/111
Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/intel/iavf/iavf_osdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_osdep.h b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
index e6e0b0328706..c90cafb526d0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_osdep.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
@@ -46,7 +46,7 @@ struct iavf_virt_mem {
 
 #define iavf_debug(h, m, s, ...)  iavf_debug_d(h, m, s, ##__VA_ARGS__)
 extern void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
-	__attribute__ ((format(gnu_printf, 3, 4)));
+	__printf(3, 4);
 
 typedef enum iavf_status_code iavf_status;
 #endif /* _IAVF_OSDEP_H_ */
-- 
2.20.1

