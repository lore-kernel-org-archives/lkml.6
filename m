Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC12C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A837A20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="I/qJyCOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A837A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLGJSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:18:24 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:33886 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGJSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:18:23 -0500
Received: by mail-pg1-f181.google.com with SMTP id 17so1472531pgg.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tx2/lpvDJIR0iL63GyMQNSmgWLw618spwgoDPWAlz2A=;
        b=I/qJyCOPTCi+J6z0dSRfXy2AfWraPLZevQyfQKTcwaf3UcCBpK9yyOBqNHOfAuqGxs
         FqZ1zSmJkWpwW1TM7BsN0OoAuoXIBBSjn74vU7gArCmmJt5P0G6h/KRluolTQSBb0rbL
         Uj149GH9UjbAtHvGZ63z55BSe0dsnrawuRt91oK8+n9jawK1PWh7zBoVTs4WUO3bpvwT
         TaDLI71N+2Snfx/2qeCPfxt3adWPEfmAiVyOn3SMy87pIBVKnZnllDd8Jx6ffX6dbcdc
         BoI4GgZ0OftZ0s+SDNZySJbVX3K4zaG19oJ27dRVOKvAslLP1UQqNZ5Qaygjf+Kqsjvb
         6UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tx2/lpvDJIR0iL63GyMQNSmgWLw618spwgoDPWAlz2A=;
        b=BZ8+GjKkSAgOmFOsSC7CCCxob/+7O6U5YGM69zt7GA9xnmZeB+0JThE25LGpq5AE3l
         2XF6X7WVOSKnkuHFf15L724BGsKTGhXqhVPzULNfvhFR0AknK32Y8YQRkR14WRo1hhej
         gWGU/tKsmPtd8JcBIcfn4FnVqGxOkGf8HEb/EAY36PUH+DCJPAzYWokbFcqjEL+QRrNc
         VJtJgcoJYi7abPs2s+cFtixD23eVY6Zq7D/zmNMBopLKY8MJL3IgRIwJaeWDqrm8Jtls
         W0lrObvgYAgb6YHnxnu9gxqNTaa3cM3pt2mo9AaAX7pzbDcf7+TDm1TPWyiaXK2tX1al
         /O3Q==
X-Gm-Message-State: AA+aEWYZs/sqQky/pBQbteJDLFZ5K7LlsGW7dqhaPscZqArB0csyASng
        vlAVc0UscKlj5JF80YKVYtJwAQ==
X-Google-Smtp-Source: AFSGD/W7VdKFa07CoMeAd5ZZtJBDOSD4Ze0S5ES6SphzCjCFPGEHK+Tlp2o1gzHQs3d0RSFs0eG+3g==
X-Received: by 2002:aa7:810c:: with SMTP id b12mr1478917pfi.44.1544174302515;
        Fri, 07 Dec 2018 01:18:22 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id y1sm3480927pfe.9.2018.12.07.01.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 01:18:21 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>
Cc:     Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com, josh@wtmec.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v3 0/3] Add ALC294 quirks for ASUS laptops
Date:   Fri,  7 Dec 2018 17:17:10 +0800
Message-Id: <20181207091713.7483-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAPpJ_edVC+zgVrh3TwOL3NsM_6yeq-P0sgmX0L-5OE-QFDN3Zg@mail.gmail.com>
References: <CAPpJ_edVC+zgVrh3TwOL3NsM_6yeq-P0sgmX0L-5OE-QFDN3Zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Realtek ALC294 quirks for ASUS X542UN, UX533FD, UX433FN and UX333FA laptops.

Chris Chiu (1):
  ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN

Jian-Hong Pan (2):
  ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294
  ALSA: hda/realtek: Enable audio jacks of ASUS UX433FN/UX333FA with
    ALC294

 sound/pci/hda/patch_realtek.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

-- 
2.11.0

