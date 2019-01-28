Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25098C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BE52082C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695616;
	bh=ByU0CnYWWvm0zjYZEkLcAN626c3YTu+/Pgl6NTi/sJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E2RlwVIpbALtnc+vzTao0qC/4Jk8xHrGvzv4z3gNk6Wy/CN3+FZCj5Nrhpkpp/FmC
	 gxwxUeiou6YB0UTCHKAxMrYls9PSL6mnFwZ3k0XtuWxpQGFCMdeb5T1ty5cbZyYy82
	 ZiB+MXLwDDDzzLU8DKEddFSJ14y3kctwzXkGnHX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbfA1RNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:13:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732381AbfA1QIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:08:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1069520989;
        Mon, 28 Jan 2019 16:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691702;
        bh=ByU0CnYWWvm0zjYZEkLcAN626c3YTu+/Pgl6NTi/sJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQB9jatcPwu5ddVi/Xk43XGzfwZv+tk6YdZ8L6M3MoJSter9tgjYTZYQT00NFLObc
         HlAvIl43NNNdm7C2Z36LpvTGueWAX2IwAoVYs4vPejLu/EgOg7edt2jYeCoykixPhY
         LPuilJYXe0OyHQbqRWOE1xJhZFg+xNGog26+OhPI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 190/258] scsi: smartpqi: correct host serial num for ssa
Date:   Mon, 28 Jan 2019 10:58:16 -0500
Message-Id: <20190128155924.51521-190-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index 8c1a232ac6bf..58eb0d31d8d9 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -653,6 +653,7 @@ struct bmic_host_wellness_driver_version {
 	u8	driver_version_tag[2];
 	__le16	driver_version_length;
 	char	driver_version[32];
+	u8	dont_write_tag[2];
 	u8	end_tag[2];
 };
 
@@ -682,6 +683,8 @@ static int pqi_write_driver_version_to_host_wellness(
 	strncpy(buffer->driver_version, "Linux " DRIVER_VERSION,
 		sizeof(buffer->driver_version) - 1);
 	buffer->driver_version[sizeof(buffer->driver_version) - 1] = '\0';
+	buffer->dont_write_tag[0] = 'D';
+	buffer->dont_write_tag[1] = 'W';
 	buffer->end_tag[0] = 'Z';
 	buffer->end_tag[1] = 'Z';
 
-- 
2.19.1

