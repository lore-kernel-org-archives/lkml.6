Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RnRyLM6qGFv/FwAAmS7hNA
	; Thu, 07 Jun 2018 03:47:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 97D45607F7; Thu,  7 Jun 2018 03:47:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af5BJJ16"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1438D60290;
	Thu,  7 Jun 2018 03:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1438D60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeFGDrX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 23:47:23 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39583 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbeFGDrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 23:47:22 -0400
Received: by mail-pf0-f195.google.com with SMTP id r11-v6so4176355pfl.6;
        Wed, 06 Jun 2018 20:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zkGy7N/l31tFPjFPGr2uEBCIrkJWG0gg3dIMvb5zlk8=;
        b=af5BJJ16lBo/rJfnEEbCtAeR3ndwi1/TJEVbCI4nxWw3pKtXtUAnaxT74F+L55CNsR
         gPyoUasu9llLNuOnSG7XBFYgSYHCO8Ra+580IX3dIYsxFiAUq1qIRwKO2CW0OHMGwnEv
         UZHk5i7DEv7qRI7XZ2aXRe+/z/h5zUMYX7GkyI/GFQc8bWbXRN3xSPjK1V3gZ98EvKPa
         vEDzHLRAFfkU1ExRzdmffFAZHZs1D5L9g99vGwE1UOSoDYnTnjkfzjQQDkBTe9qjEbB0
         zBe246qCANH4Cjo/gCFdJozqQw2j9CeutGweQf/vxcTsU7Odg8/gmZ0lfpLJ/gAXEgrC
         tJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zkGy7N/l31tFPjFPGr2uEBCIrkJWG0gg3dIMvb5zlk8=;
        b=b5YIztV+ZSOqTkAXFPRd2ns6CECJvTbMFH1JZd5ylWwcs7i9jxHiQzLk/cjZhhc5Vz
         QytSKcez/XSusf1vtadhH/k58CSDzTrPPBsbyqpm8Rv7wOMq8JO+ov1WQfHiF89kwlI4
         wWo2FJoO+2vwNc4ysKiRTnxmYjGj8S7bsfwRsxlz2kV7NKAv1Wk90YuAPevtUcP3DqV6
         NeiYKGgqOcwbhXAzVHh2V+sMYY81EEzw4yEazDiiP9P4ww1KltG+JUIYBhvaraTQk3uJ
         GkqOJN7DsV87dSpzfiYZwJepqKNI3BvLXo0U66fwATmoQjgZ2l1SKnYtIDQ61pEFuZov
         7N6w==
X-Gm-Message-State: APt69E0v0faOab4ehxQfu+m+zWJOmXdBspw69H1XzJDF1yULqQga9E0D
        fkTZt+7tZUtvYO2PUTO1QJWHkQ==
X-Google-Smtp-Source: ADUXVKKr1dS0FF9zW/oWdWzpdCh3bmJKUtlSd/8pkDH3pYWVYtblTuxA/VAIF1KZ6sOtiBOm6+Eosg==
X-Received: by 2002:a63:bc0a:: with SMTP id q10-v6mr206061pge.70.1528343241312;
        Wed, 06 Jun 2018 20:47:21 -0700 (PDT)
Received: from localhost.localdomain ([103.62.68.119])
        by smtp.googlemail.com with ESMTPSA id i11-v6sm8097055pgq.23.2018.06.06.20.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 20:47:20 -0700 (PDT)
From: Varsha Rao <rvarsha016@gmail.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH v2 0/2] message: fusion: Fix clang and checkpatch warnings
Date: Thu,  7 Jun 2018 09:17:07 +0530
Message-Id: <cover.1528342739.git.rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes extraneous parentheses clang warning and few
checkpatch issues.

Varsha Rao (2):
  message: fusion: Remove extra parentheses
  message: fusion: Replace NULL comparison

 drivers/message/fusion/mptbase.c | 50 ++++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

-- 
2.17.0
