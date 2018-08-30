Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05E8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A64C20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnPsXFMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A64C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeH3RHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:07:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43535 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbeH3RHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:07:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so6454933edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 06:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=i1mvplLlOCL9jwKYBcVYkW35b+HzqAg2bbkR+Jen/mU=;
        b=MnPsXFMwnjSIEyIC2j1iql7T5TzbgJeB4cbgmYE+TyEYhouXR+Mi5+ddf6gD/yk70K
         QqV1R7xx80+ynJBG7yb+tIaSUy9BY309cboHJMsbZm44Sam7z7F3kYRR2E9ucUtNiTtp
         gAaT/dE9V/SCo1X0DbJkVooWyAnLFKbeSGJ+enHSCOHkF0u2ghdbnlaTq4qLwQTC8EaP
         UNcn7eOHQbItRbxi45lkku41ftNdtjQtI4r/tTFAbJEi+tezOAm3WnYFM4EFqSDFUcEK
         GSvOn/YcjY8nT5hCoZGGLW+mKyu4mIR6Q2nUMzK1668OJMW2uslf59V7/l2aNS7rTzDR
         OOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=i1mvplLlOCL9jwKYBcVYkW35b+HzqAg2bbkR+Jen/mU=;
        b=DXlVDDOiR0jOdiMd1vVV1SKbeBEWp2CqndOW/i++ckl9pIBbafAx+KZjTsBsScRzIL
         wcC+lxB/31bycxSsvEKWv6BvbOgXdFTMdZFRAqesAVa6kDYJulj7eX9JmaeTRrwnUoE9
         Rxk7whH66xPSauFgzMOuevxnYoPv8zOyquMoprz5KEIrBszwB9FCJeWeYY8Vq8uaJcpn
         ecNteN/ka+7PLVPUN4ZP2T86x7SiViKDvr21/6uox0ttwbvopRddy/+L9eEQALFi5ZGx
         Vv1MzHdfFbop2vV9v2XczotC8iXsTDMeSkwtbt5PjtCjyx5AhPrV6rZcyCv8FVyivGJg
         44rw==
X-Gm-Message-State: APzg51DKBtdcxu2B3mJ6NJyfipFmMbjbUm6ug/Ql+xvEFWKYIlVNitTw
        dTeJn9d3HTsd+Ns9ctJy5jxmk38=
X-Google-Smtp-Source: ANB0VdYUgUfQfamrjZTl0IiurAl2+jJs38/ZKMG3ANEYo/YsA+LTFltja3lkTOss4Yc5o1FdHUKD1g==
X-Received: by 2002:a50:a1c6:: with SMTP id 64-v6mr12503731edk.309.1535634336704;
        Thu, 30 Aug 2018 06:05:36 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id x22-v6sm2931565edb.8.2018.08.30.06.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 06:05:36 -0700 (PDT)
Date:   Thu, 30 Aug 2018 16:05:34 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org
Subject: uNNw: wrapping integer annotations
Message-ID: <20180830130534.GA31044@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LWN wrote:
> Marking places where unsigned overflow is expected is needed; it would be
> nice to get those annotations put into the kernel, Cook said.

Let's discuss the most important part -- naming :^)

In my opinion, signed universe should _not_ get anything before specific
examples are presented where the value is in fact can be negative and
can overflow.

As for size_t/uintptr_t/..., they can be added as usize_w Rust-style
or left until someone presents a usecase

--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -119,6 +119,18 @@ typedef s64			int64_t;
 #define aligned_be64		__aligned_be64
 #define aligned_le64		__aligned_le64
 
+#ifdef __CHECKER__	// change to sanitizer define
+#define __wrap __attribute__((whatever))
+#else
+#define __wrap
+#endif
+/* wrapping is OK */
+typedef u8 __wrap u8w;
+typedef u16 __wrap u16w;
+typedef u32 __wrap u32w;
+typedef u64 __wrap u64w;
+typedef unsigned long __wrap unsigned_long_w;	// name sucks but consistently so
+
 /**
  * The type used for indexing onto a disc or disc partition.
  *
