Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FB0C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBED222A9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898152;
	bh=Wjd3ijTYHk6zwxq6q7ETl11zPvXAapO7XhNZREhHkQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQhtrHRJxc2RES31hjJFxfEiKJKKbqlSR2jQkYEDQEn9UdF4awkCE5CBQ4PDVM9Z7
	 3VE+cZ419dRAgRLjaaIl/zPhP6/ADrBtM5HhRsZXunccGhirFt/wdSPz43MFfhf7ax
	 zeC94supGAZaeQ88Mz2OWxCCcU3CsZOWit7+V/6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391363AbfBKPHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbfBKPHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:07:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC3E222A7;
        Mon, 11 Feb 2019 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897642;
        bh=Wjd3ijTYHk6zwxq6q7ETl11zPvXAapO7XhNZREhHkQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdK0PcaZbQYo+xyMSg7B/FOK/kqP4fhLB0O2Aj3lKBZ8Zj2KlaUpHL8re2h5x+FZD
         cMvyOwu6L0vjLSbCj4bKn988OLD3+ZGoyL1I930gLjkHDdrBDL+We1G/XvXxRlcolN
         UdIqPmiISMsLoF5goQvEqErgjDWlNDoFqGJ94mBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Benesh <scott.benesh@microsemi.com>,
        Ajish Koshy <ajish.koshy@microsemi.com>,
        Murthy Bhat <murthy.bhat@microsemi.com>,
        Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
        Dave Carroll <david.carroll@microsemi.com>,
        Scott Teel <scott.teel@microsemi.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 065/137] scsi: smartpqi: correct host serial num for ssa
Date:   Mon, 11 Feb 2019 15:19:06 +0100
Message-Id: <20190211141818.011535447@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b2346b5030cf9458f30a84028d9fe904b8c942a7 ]

Reviewed-by: Scott Benesh <scott.benesh@microsemi.com>
Reviewed-by: Ajish Koshy <ajish.koshy@microsemi.com>
Reviewed-by: Murthy Bhat <murthy.bhat@microsemi.com>
Reviewed-by: Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index b2b969990a5d..9a208961cc0b 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -473,6 +473,7 @@ struct bmic_host_wellness_driver_version {
 	u8	driver_version_tag[2];
 	__le16	driver_version_length;
 	char	driver_version[32];
+	u8	dont_write_tag[2];
 	u8	end_tag[2];
 };
 
@@ -502,6 +503,8 @@ static int pqi_write_driver_version_to_host_wellness(
 	strncpy(buffer->driver_version, DRIVER_VERSION,
 		sizeof(buffer->driver_version) - 1);
 	buffer->driver_version[sizeof(buffer->driver_version) - 1] = '\0';
+	buffer->dont_write_tag[0] = 'D';
+	buffer->dont_write_tag[1] = 'W';
 	buffer->end_tag[0] = 'Z';
 	buffer->end_tag[1] = 'Z';
 
-- 
2.19.1



