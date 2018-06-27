Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AB4C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A13024418
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUMMcuQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A13024418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965686AbeF0Tsq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:48:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34132 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935134AbeF0Tso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:48:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id l15-v6so18876611wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KgaPNXg/jXGfbN5xAZm1ghwWBdz7x2P3VqFxglJq5Mo=;
        b=iUMMcuQZXPmbPEoLsNw69GpHhJRS+QU8IDSn87tieKsdlMGTqWHGmj+hvC9GUyDXEu
         qEzOYroTnzpCDdFv+4Vw6d6bJ8rPvAg6pybusdXwYGBfjq8bAAjVvgykXjcOoHQii5r3
         cnhm6huXEJMRuwfmH6awOKNT4CCFrRZTriqoDrjEOdvxYYtTV4y4EK+q3tjYT3oOHNJT
         rIdu/ko5Q2HenVRKFBiif2lOWfru/EG9tD5+79ocl5QY1LhJ4eWlFLXPW757FeUtjUWU
         EDjdKGAxIEGxMAP0RBFTnF9ciQL8R0e6nkjGeW/AO3a9qEvvzN5gmxnWamu/SOpgCZ4H
         kl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KgaPNXg/jXGfbN5xAZm1ghwWBdz7x2P3VqFxglJq5Mo=;
        b=m10CwnBpoC70p+nvcWi2PJaay22ba/5etuqma/wUdyj19M6K/aLEgjq5joqnNHu3us
         IJX22eW5/akf/qrAfz2gBIi4ozdXILHGLut3TmiY3Q3MHkjxs8L75p8Fd223J2jEygso
         PvI1W3Mc/NXRjTsBNz0xkltTosnt9GCdb8XKfvrlYRRipv3AQqTHNojhiH8sZWlq6e4d
         jx5KPFbBFeg99HTeGz3eHPMRdkh8zPC3jZZrqH2tt3xN5g2j3v6NWQvvxpi5gIBm0Aut
         VG+aSGioovcmkSxRIaqAAXupH+TgY5hyTnlQIC3iK6VURZc7QfuzRVS351QjRYE67h5z
         m+XQ==
X-Gm-Message-State: APt69E34d4L+cZM/mFhZk+Cq9+3ZNybkkSyFIBtZd5Mmy7o6HL3iYrCi
        HsHClNUNXOsYpjTDctLLSRvy
X-Google-Smtp-Source: AAOMgpeEk229cuOX2Mgs2kvGPlZijeH+xZjqeYyY8bvtMxqs4MKIdntiwtUTj6PyFsHcfzU00NTIsg==
X-Received: by 2002:a1c:a88a:: with SMTP id r132-v6mr4351174wme.31.1530128923775;
        Wed, 27 Jun 2018 12:48:43 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id d10-v6sm8150570wrj.38.2018.06.27.12.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 12:48:42 -0700 (PDT)
Date:   Wed, 27 Jun 2018 22:48:40 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: condemn myself to MAINTAINERS
Message-ID: <20180627194840.GA18113@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know I'll regret it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11481,6 +11481,15 @@ W:	http://wireless.kernel.org/en/users/Drivers/p54
 S:	Obsolete
 F:	drivers/net/wireless/intersil/prism54/
 
+PROC FILESYSTEM
+R:	Alexey Dobriyan <adobriyan@gmail.com>
+L:	linux-kernel@vger.kernel.org
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/proc/
+F:	include/linux/proc_fs.h
+F:	tools/testing/selftests/proc/
+
 PROC SYSCTL
 M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
