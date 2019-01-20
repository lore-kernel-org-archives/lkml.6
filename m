Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CEFC7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96C92085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIHOgyAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfATQKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:10:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44393 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfATQKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:10:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so8312356pgr.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 08:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1WWJjUjcuN+cxTA2X+ExTunRwwM2gczNYtCdyAn5d0I=;
        b=oIHOgyAQB2iqY2AiLbn9xdLo9B2WxJNCEUAT4wpPYopqsiJ3Vp/D3GDQHi5EyQc+i+
         0bbhTrQLdjtx0y5VMt1/6yI0f4b1180GsK0kWkbqzzA7ZRLqqzGrMNxaUmjo+Eg05Iv5
         0lyxc6TrbiueVlp5D9659XrQE05ukerzSyVUxUoYZnRHEbl/75dCmxRZTWBd7OoH0Yez
         UKnHDMvkqqik0PD9VDXIM/nft0nfyi5w9Qi8blHGg955Yv+J+ePltTPa0w8NnHs6W1xS
         FiTNUMqQosBYpaz+iGLDhNPbWpxiphJ4JxybRQGHh37bSdkF11mTZzRfb85LgoMsr/Ax
         m24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1WWJjUjcuN+cxTA2X+ExTunRwwM2gczNYtCdyAn5d0I=;
        b=iQpJhDG2h86UAN1X48gDF19PnXu9RhkxOFzdjqAfNKm6L4obcySjLGTsiVDufx9+7/
         lhRn4ELZ2KC4ZCpeotHrxcOaw3Nmh04I1x749Xs0ON7xMRUC18ZvC4BoNm7cEIbxUSih
         dY+YpVT49LY2GcOm0SVW9bsxIIpENO68n5YIM/CMCox4al/eaYgfe/Lo8nX8uDPFREdY
         KJaycJC7JQuiZA21ENMUchEpxNr7A3rMjiUdNyilYhsz06fb1D0jJBgG2IvKk8ySfW70
         eIB4QWty5xtLl5HKJxqDURr3fp/2Nyp01K4LHBkGt0xMf6TZI1Rc4xYU6lu+3uq0SF2c
         Lb6g==
X-Gm-Message-State: AJcUukf10l3/ebxzOnC47td/QFhqv4n5PwH9JdyC6BIOgNRvRTIKas6K
        b7gmI77YO6S6Tdurkg8LS2JTkrY8IvQ=
X-Google-Smtp-Source: ALg8bN7LZYcW/XldTLWw9IS1lfaMOCoa5nP2tFnndeFH4mygJZ5+OdLIRvka4WZKOhR+eTFYlWzB5g==
X-Received: by 2002:a63:960a:: with SMTP id c10mr24843425pge.106.1548000644236;
        Sun, 20 Jan 2019 08:10:44 -0800 (PST)
Received: from bhar12345-VirtualBox ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id z10sm14123163pfg.120.2019.01.20.08.10.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Jan 2019 08:10:43 -0800 (PST)
Date:   Sun, 20 Jan 2019 21:40:39 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: netlogic: replace ---help--- with help in Kconfig
Message-ID: <20190120161039.GA2808@bhar.linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: prefer 'help' over '---help---' for new help texts

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/netlogic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/netlogic/Kconfig b/drivers/staging/netlogic/Kconfig
index d660de5..c25a00d 100644
--- a/drivers/staging/netlogic/Kconfig
+++ b/drivers/staging/netlogic/Kconfig
@@ -2,6 +2,6 @@ config NETLOGIC_XLR_NET
 	tristate "Netlogic XLR/XLS network device"
 	depends on CPU_XLR
 	select PHYLIB
-	---help---
+	help
 	This driver support Netlogic XLR/XLS on chip gigabit
 	Ethernet.
-- 
2.7.4

