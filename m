Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A090C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E81520663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692576;
	bh=WplPyyw0KekGck4mzTQDS7ucuW3EVP5MoU+JuTAi/W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XzVHG1ewATtBnVV0tB2hdikqQdSJysB/HZ2rMvlDK/HV5E6txcqVupLo2eaPuBapx
	 O60ykAq5a8gpcQ+Y3ws7xLhpkE5d3+ZytLGNJ5gnCPN6FbGGSPZiHHwX1TvplDpRXY
	 66LoiQvzdkQsVaHM0GTdWGsXnzVoRwxEsipi/AJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbfA1QWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:22:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389263AbfA1QWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:22:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 934A420663;
        Mon, 28 Jan 2019 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692566;
        bh=WplPyyw0KekGck4mzTQDS7ucuW3EVP5MoU+JuTAi/W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIN2OpRe+uHfDRr6ezILnoR83ddSywC/aGBnaXmBeQxW4kML+txRyjsW7AZVgy//o
         Ctdu8HQRIx2S/fg0aeWg4wkr/EkqrFiD045w7jny/Vkh1mSqSM9BSM5JS/+sYK00Vq
         qZgq+lIWLn3lZ0/foMQY8vkPsiIryOFfYKZ2rwyU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 068/107] scsi: smartpqi: correct host serial num for ssa
Date:   Mon, 28 Jan 2019 11:19:08 -0500
Message-Id: <20190128161947.57405-68-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>

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

