Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0C7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFB12086A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyY2aaHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfBVEcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 23:32:00 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38411 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBVEcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 23:32:00 -0500
Received: by mail-oi1-f173.google.com with SMTP id q81so765392oic.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 20:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7dNEDFNvNrkVSMReo583MYapWdajwbte+FAs+hpYFvA=;
        b=YyY2aaHYOy6B2K709i/BKGBw353s/nOQrcGE59AsE9V+ESBAAuZECmgLD5QLi3Kji/
         oukDD4G9ulyzyHoDxJ4mm00BKJUGXH8TV06L0saCTI+wJTXphBFuB5m/X/Dt/TwCWcaz
         XmIyymgdyJ0hV7VhM3KkZETaMac0iRE3BQP9hQ/vMW8MDlfw0rdO7EHa7wA3J0uJjxZc
         dGzQ6krbuvtNIrnFEMKLUytFcdQoU0Eq/WXXV2V4VVm0hkDOeVOU8Mmqc9DrHhKt4cs6
         0gGgjxOzPPoAmsDkpHw3sf/TN03J/wc9yQtY78P87Ntcqzr8XQltxT2GYwhMmrcx6b/M
         /jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7dNEDFNvNrkVSMReo583MYapWdajwbte+FAs+hpYFvA=;
        b=NJLzLqfrf19Kn9Z+4oSXVvZCPMt9pWka/Ed8+iWa6/ZtsTav/qWqy8AQL1awNrD3ET
         dBtQpB6eBcoLprQ0I5CrdnYzV2Qn7rZq917kFe7b4pmzyBAjSAFjzjPuNofcZrYebFws
         eh3wiCbOGz44LR8pQ39rfjKPulYwDTun9avUb+MCMjnKI6duvM1nI8ZR8VGphtmRTvmj
         EHwHfg4CqlS8XkCgBu8FoW5eLnAzxr3HvhSYgrYcsBzqX2+9Sb8wCZK2gEuxg9NaqQ/Q
         qi7xwKfxkWSDlQvYVDrYIg/d3SQWvqU9wlpQYEQW25nQgGYdZ+tu2Xgtk54257LtWi26
         oBNA==
X-Gm-Message-State: AHQUAuZ0zkd/b8A2i7vWfojO9jbaXb+dVaELcfvoJzZtj5I2izm/pgOK
        dS1U+nzhoIemJXT2Ot1VeJiJjWqLkmVFp2pWLAz3QY/qIQ8=
X-Google-Smtp-Source: AHgI3IYqCwT/aMTlrsiS3XjhzsyCdIfaMzDjoEQrGDASqhvw6Pn8iR+NUdpsD8uCBY6TiLTSDTFXbfPdFtUDuc1awXE=
X-Received: by 2002:aca:49d5:: with SMTP id w204mr1281480oia.154.1550809919194;
 Thu, 21 Feb 2019 20:31:59 -0800 (PST)
MIME-Version: 1.0
From:   Justin Capella <justincapella@gmail.com>
Date:   Thu, 21 Feb 2019 20:31:48 -0800
Message-ID: <CAMrEMU82QeGpUmhU7b1rGHo7-2bDvGv3kmmyKkYG+PHBfP5FDQ@mail.gmail.com>
Subject: [PATCH] Makefile INSTALL_HDR_PATH overriden
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpg: Signature made Thu 21 Feb 2019 08:02:55 PM PST
gpg:                using RSA key F6CC1F4DF325EACBBE2532481F299543498470BA
gpg:                issuer "justincapella@gmail.com"
gpg: Good signature from "Justin Capella <justincapella@gmail.com>" [ultimate]
Author: Justin Capella <justincapella@gmail.com>
Date:   Thu Feb 21 20:02:55 2019 -0800

    Allow configuration of headers install path, do not overwrite
INSTALL_HDR_PATH

diff --git a/Makefile b/Makefile
index 96c5335e7ee4..686e747ca2ab 100644
--- a/Makefile
+++ b/Makefile
@@ -1151,7 +1151,7 @@ headerdep:
 # Kernel headers

 #Default location for installed headers
-export INSTALL_HDR_PATH = $(objtree)/usr
+export INSTALL_HDR_PATH ?= $(objtree)/usr

 # If we do an all arch process set dst to include/arch-$(SRCARCH)
 hdr-dst = $(if $(KBUILD_HEADERS), dst=include/arch-$(SRCARCH), dst=include)
