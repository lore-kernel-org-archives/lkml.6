Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8606C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DC02082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DC02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeLJVBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:01:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37371 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbeLJVBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:01:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so5983013pfb.4;
        Mon, 10 Dec 2018 13:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbVT4vEFpi538QwR9NHw77jufxuR36QHiilzHNTPQuk=;
        b=EJYC5+cOMQWj+ZVoC55YDhvJptaw5rlOySE7y5PlxHRM3JRlToyTzmCe9kfNvTYiGO
         KrvHLUwbikRX8v7AM8dYbUVWUz25BdzOSf13EToNS5RD7hoVbIIhLaZEABrr1vszL85+
         eEFZ0XvnXjPFmZo3BC7ReZ7wwtG2G6vQycpMKH4DJpBtlK6feX5GTx6unElGx+5l9RGG
         kWHE/BBPiJiUcdT6+/MY+8SDRdertUzVpTZup6Uy248qo0tbnA+6Ra+simsIrHfNbXkg
         MhB/DGMgeBaJ2VCp3ecjCQ0yWv7kWwMZPodMvUpChjnOJRMh0xxRH6Tf5pCezeHFMqqL
         ACtA==
X-Gm-Message-State: AA+aEWb46PmaA6gUlO5N1Wm6Qwhg2gyjYwaDNVnwd6m5zXUfbqe85gka
        mdY/WL6twdbc1JP9RlNj30k=
X-Google-Smtp-Source: AFSGD/VuWLpuNMhVrQQdMQD1VCfEqpKVY2CfkzhBdiaS7JQX5gmUS93/irzi4hGsZCaKbVdrL37kwg==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr12370426pgb.242.1544475667998;
        Mon, 10 Dec 2018 13:01:07 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j21sm9196983pfn.175.2018.12.10.13.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 13:01:07 -0800 (PST)
Message-ID: <1544475666.185366.378.camel@acm.org>
Subject: Re: [PATCH] scsi: qla2xxx: fix unused function warning
From:   Bart Van Assche <bvanassche@acm.org>
To:     Arnd Bergmann <arnd@arndb.de>, qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <quinn.tran@cavium.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Darren Trapp <darren.trapp@cavium.com>,
        Bill Kuzeja <William.Kuzeja@stratus.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Dec 2018 13:01:06 -0800
In-Reply-To: <20181210205215.2703138-1-arnd@arndb.de>
References: <20181210205215.2703138-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 21:51 +-0100, Arnd Bergmann wrote:
+AD4 In what seems to be a mismatch between the scsi-fixes branch and
+AD4 the scsi-mkp/for-next branch, a newly introduced variable from
+AD4 one patch got obsoleted in another one:
+AD4 
+AD4 drivers/scsi/qla2xxx/qla+AF8-os.c: In function '+AF8AXw-qla2x00+AF8-abort+AF8-all+AF8-cmds':
+AD4 drivers/scsi/qla2xxx/qla+AF8-os.c:1791:11: error: unused variable 'status' +AFs--Werror+AD0-unused-variable+AF0
+AD4 
+AD4 Remove the variable again.
+AD4 
+AD4 Fixes: c4e521b654e1 (+ACI-scsi: qla2xxx: Split the +AF8AXw-qla2x00+AF8-abort+AF8-all+AF8-cmds() function+ACI)
+AD4 Fixes: f2ffd4e5bc7b (+ACI-scsi: qla2xxx: Timeouts occur on surprise removal of QLogic adapter+ACI)
+AD4 Signed-off-by: Arnd Bergmann +ADw-arnd+AEA-arndb.de+AD4
+AD4 ---
+AD4 Maybe check carefully that the merge in linux-next is otherwise correct
+AD4 ---
+AD4  drivers/scsi/qla2xxx/qla+AF8-os.c +AHw 2 +--
+AD4  1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/drivers/scsi/qla2xxx/qla+AF8-os.c b/drivers/scsi/qla2xxx/qla+AF8-os.c
+AD4 index 63c47bc7ae59..db331cb5ba3c 100644
+AD4 --- a/drivers/scsi/qla2xxx/qla+AF8-os.c
+AD4 +-+-+- b/drivers/scsi/qla2xxx/qla+AF8-os.c
+AD4 +AEAAQA -1788,7 +-1788,7 +AEAAQA static void qla2x00+AF8-abort+AF8-srb(struct qla+AF8-qpair +ACo-qp, srb+AF8-t +ACo-sp, const int res,
+AD4  static void
+AD4  +AF8AXw-qla2x00+AF8-abort+AF8-all+AF8-cmds(struct qla+AF8-qpair +ACo-qp, int res)
+AD4  +AHs
+AD4 -	int cnt, status+ADs
+AD4 +-	int cnt+ADs
+AD4  	unsigned long flags+ADs
+AD4  	srb+AF8-t +ACo-sp+ADs
+AD4  	scsi+AF8-qla+AF8-host+AF8-t +ACo-vha +AD0 qp-+AD4-vha+ADs

When I prepared commit c4e521b654e1 I verified that my patch did not produce any
warnings when building with W+AD0-1. So something must be wrong at your side. Did you
perhaps start from linux-next to prepare this patch? If so, please submit this
patch to Stephen Rothwell.

Bart.
