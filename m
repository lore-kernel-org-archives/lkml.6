Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4020C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B065421906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gwLehHkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391722AbeLUT2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:28:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36624 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeLUT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:28:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so6752151wmc.1;
        Fri, 21 Dec 2018 11:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xlPAfl0NmUFdW1Jt/sV/ILwPxGsPAHvaQH/3RMIXuM=;
        b=gwLehHkGKDKeBY60diHRiZ8WOcSRA2iJbuXNKN/CvPVyEEu0LJeWiL4siyou5/1qQJ
         OzwFBXf0DHAvsQhduPUEvRbajoZVLxt0JbFXQUCZQtl+xpmJdmDMPRMXRGrjB2id+SgS
         xBan7sKCaEiBAWT2Qt7SSD3Yi9pLPo9ONXcbsdQ2bmsEfnqj3oGUPDaMxXaerA9EtJzQ
         16RzHY0v5KMAzj2BLJnjPRPNfxA1tRzoU+l7jg2uG3bQg8hX3E9EAt0Z4vOIx7+YoQ3v
         knSB2JsmlfJHcWgsne2UWcWVZ9EvhNGDHocvrkDzvnPfWuM5yjCbfDcHH6jSnCNUCcj3
         /qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xlPAfl0NmUFdW1Jt/sV/ILwPxGsPAHvaQH/3RMIXuM=;
        b=DFvbgw7Tcmgamwpy8zWQZHiKisTWqFyzQW4CfSr+UQO88FmI4rNGFSEikUFJycTM9N
         vO8PfMQEQdon7pTVZELnHLYN/+Pc7fR6JdroRwWjzX8412n/rRkqL+jcrm9auVOBMZzC
         PlAurqtocck+4vsJ+Gi7zp/3A0MUhlJXopCT0Tms5FjxRYx/26BgmZVORJnvNjfWgvVZ
         +VhbQXbuYcKxTgCzsXxUiDTkwN2jyXYad4xDGIxzhR2a9kJOA+3Gxbmo/GZympOfR2Mp
         J1rhNXDeedjSpD/wMkD2F5R6BiL2bAKjvNev6Ww/6xb/t4fADM13InpsXFCsh+6pb6aK
         j+8A==
X-Gm-Message-State: AJcUukexKsgnFiZZgCogTsYrVG5rffgcVN2dGu3nGyUU1B8jG/syiJhv
        VNiKyEBXYIY/ZP7ASDcDZ3o=
X-Google-Smtp-Source: ALg8bN7Uql4FivQZAGRHwmyu2+aY+du6CbjziMeUT7/eV181XbAvy0KTLVOvl9FwX5+jkRjYIFBASA==
X-Received: by 2002:a1c:8acd:: with SMTP id m196mr4042285wmd.120.1545420520527;
        Fri, 21 Dec 2018 11:28:40 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD736340074910E90C26DA08A.dip0.t-ipconnect.de. [2003:dc:d736:3400:7491:e90:c26d:a08a])
        by smtp.googlemail.com with ESMTPSA id 1sm4436246wmx.48.2018.12.21.11.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:28:39 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com,
        jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] f2fs: fix sanity_check_raw_super on big endian machines
Date:   Fri, 21 Dec 2018 20:28:19 +0100
Message-Id: <20181221192820.26222-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Big endian machines (at least the one I have access to) cannot mount
f2fs filesystems anymore.
This is with Linux 4.14.89 but I suspect that 4.9.144 (and later) is
affected as well.

commit 0cfe75c5b01199 ("f2fs: enhance sanity_check_raw_super() to avoid
potential overflows") treats the "block_count" from struct
f2fs_super_block as 32-bit little endian value instead of a 64-bit
little endian value.

I tested this fix on top of Linux 4.14.49 but it seems that all stable
and mainline kernel versions are affected:
- 4.9.144 and later because 0cfe75c5b01199 was backported there
- 4.14.86 and later because 0cfe75c5b01199 was backported there
- 4.19
- 4.20-rcX


Martin Blumenstingl (1):
  f2fs: fix validation of the block count in sanity_check_raw_super

 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1

