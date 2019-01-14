Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C169C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DB220660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkE9ONLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfANIku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:40:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45186 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfANIku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:40:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so18196010ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tia2ltSvicA7t4H7Sb9ZU3S2L2tUXeOOk7qBWNokv5o=;
        b=jkE9ONLSDc9lSPk9I+O2VEoph+1Wgt66CxTWvqBCYedcXHq25D/xfB1LnHbcZ2LM3R
         210inoEDQZLqSZJHsY/E50yfzhz1YKzu3oJX38TjoWX/tvc42lpszOZupQcoXPh7TTEG
         XqMzR05Y7XOlPmvLYAWUa5CMMzjRRDESyoW8HdzmLLrKC2cIlqgvDYYdDcY2fraoE5rd
         B7gHHQZBozWXg90ePIcc/gWyz9z5ndeKTvw/A3YvFeESzm9h2M74dp9BT/5eKevjKh2t
         fyF5NP7ImRe4P3oIUs0X+RiGBeGMqyyWnaq9bkpT6wzkmsiN0uRqjWL1UUOQLRh2VADR
         X16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tia2ltSvicA7t4H7Sb9ZU3S2L2tUXeOOk7qBWNokv5o=;
        b=al3GOoEvmDW3791f6dxlcaTJ5zn6ieSTVHiG9NL15E2cU5rtRZC6NauFjpjlMCUeyv
         F0YgQAc9T8Uea45ycnjB9XKy3WHqf2OZq2udZF8tcDn0zRSnPs2WLE8yZD1KTn5XdrF1
         PiU02WTNP6/JZHFTk7plY4SVCuRealtpuzL9nY8dewLOXArjXYtZ/v44Om3JEwFkw3vf
         7zxWXfA1YWIv/+GACy9flrhapLNccdd+/6nYcLRkSdASyJ1Nxf/DSFyrMBqo/ssyHNl+
         hZBIXcp+jcsIzBTBErao388ZExrHuWGoJwJKiPhHts6Qic9GlxV/r+DYX3kKcLEn9EO/
         kzoQ==
X-Gm-Message-State: AJcUukdwTzfe7Uk6CXjT4ZEBK2JEQb8XgG3a9UpjcnJngsFcnXlP+lqs
        ekdapOpIuwBArgO1Qmm0x+766biUH10=
X-Google-Smtp-Source: ALg8bN4H/aaVNdp0NQwcpfRrEskduzWHy1oh8c1fACjj0QcKMAeUXmLYte0acBUwNdbpjpE0h/2frw==
X-Received: by 2002:a2e:2d4:: with SMTP id y81-v6mr13649552lje.62.1547455248224;
        Mon, 14 Jan 2019 00:40:48 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id t18sm15849964lft.93.2019.01.14.00.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 00:40:47 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 19FDD4608D7; Mon, 14 Jan 2019 11:40:47 +0300 (MSK)
Date:   Mon, 14 Jan 2019 11:40:47 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH next]: xarray: Fix typo in comment
Message-ID: <20190114084047.GE17906@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems copy and paste typo, not a big deal but still
for consistency sake better to fix.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 include/linux/xarray.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-next.git/include/linux/xarray.h
===================================================================
--- linux-next.git.orig/include/linux/xarray.h
+++ linux-next.git/include/linux/xarray.h
@@ -496,7 +496,7 @@ static inline void *xa_store_bh(struct x
 }
 
 /**
- * xa_store_irq() - Erase this entry from the XArray.
+ * xa_store_irq() - Store this entry in the XArray.
  * @xa: XArray.
  * @index: Index into array.
  * @entry: New entry.
