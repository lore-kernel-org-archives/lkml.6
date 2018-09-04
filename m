Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA14DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B76C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcfowLRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B76C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeIDIfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:35:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36328 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeIDIfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 04:35:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id e11-v6so986694plb.3;
        Mon, 03 Sep 2018 21:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8x2RgOxNUid/HmCMV/8mEDffJPA4KMaiIyr2BkIcWEk=;
        b=VcfowLRRsa7OQB4GvUWGLCg8Yr6P3JxoI8TgiqEf8CGHEGNh05tBXvOxXQEXSOLeC/
         qJClJlVz09C2UHbASdGgSnsfgxyzkKO7lzvv+EFYYSoPAvOKfXKfn0RNYrOmYHx1E4jt
         rTm4znnCg4cSYhrLBuHIplY4LJ55m1swLtrS9qlybX61wVNlCxWqKi9tBPt778CeLlN2
         am5GpOshvQRgvoyWQ+s1wCWyD+PnHjaOHOwYv80LGbx4in3M1RspUiulFeL15nMzLfWn
         0raI0riK5FCWMbL3N7EUBjA94wzYr3x/KQ2z5FlBeC2sAUUcwDERY2lTnjavJ6dxvdWM
         7Bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8x2RgOxNUid/HmCMV/8mEDffJPA4KMaiIyr2BkIcWEk=;
        b=hnqzrFaC8VDgOEoUo8/mYUJeytRPMPos5vBR388qdrjeJ0il2MD8NYoVH6fiXKiuXh
         GmhIH6S/eoYhXqmVZ++cnMci2WlsVTjhd3YRIFpLXApk/TNM7oK8Spugm8ZB3U5hmPFO
         lIr4qohYLLvOOSkGpuABp7HYlLRFar0zHcEX26Es0I82kPcxoGdqlfyHwgk4DMHpj+Ww
         y2K+dRg4oYEsUDTfo34gp3DPQ9PmUA1+T7+NUAAP7JgsBiwc4b2T2xwRtXUcU9F59apW
         8XHyk0C7Cyu1WZElcahYIlkTNcfqhmp2c2qLxIhax0KyJIOyGutlB3P9lVelI0aXLsVD
         vuHw==
X-Gm-Message-State: APzg51B9wTDpt2WG+NtGbLMDbdTdO39n8jrn4VJ8TWdq0USrBXEV7FmZ
        kGQ/G3VqLsrih5h9DOqQi+5uob7B
X-Google-Smtp-Source: ANB0VdaKxeD6ilp2MsmXahTh9xxEQ0wZimhSk9uIWILu1oOxFGjOJBfSv03nSRoYaXDWorITLeAzNQ==
X-Received: by 2002:a17:902:42a3:: with SMTP id h32-v6mr32138347pld.105.1536034322543;
        Mon, 03 Sep 2018 21:12:02 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.16.199])
        by smtp.gmail.com with ESMTPSA id q62-v6sm30352120pfi.185.2018.09.03.21.12.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 21:12:01 -0700 (PDT)
Date:   Tue, 4 Sep 2018 09:45:05 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        airlied@linux.ie, corbet@lwn.net
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Document/gpu: Use new vm_fault_t type
Message-ID: <20180904041505.GA2712@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have introduce new return type vm_fault_t for
fault handler. Update the document for the same.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Revert spaces added in v1

 Documentation/gpu/drm-mm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index 21b6b72..c3ae888 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -297,7 +297,7 @@ made up of several fields, the more interesting ones being:
 	struct vm_operations_struct {
 		void (*open)(struct vm_area_struct * area);
 		void (*close)(struct vm_area_struct * area);
-		int (*fault)(struct vm_fault *vmf);
+		vm_fault_t (*fault)(struct vm_fault *vmf);
 	};
 
 
-- 
1.9.1

