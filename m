Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159316-2-3679802989693220765
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enfr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159315; b=btbJcJrK6pn5Sh+L1L5webTETc0DwXGq+wHo9SrEzKaiOzfGrP
    tIrr3TUJGZ0dYUVLeM7Ye+8f3TmNOsEJ5E2B5Nw6s0Vv9A7WB3fJfKS2NoG+mmVw
    oQkWUAfDDcTUUk4nKH1X9op/+d3CA6ci8C3zX+xOBlOema8l1Ot2iD3C8JFo4rtk
    e9QwTlzKW9XGC/Y6QxGr7qwnmIvzD5At/Qb91OYCL+iN2Z6640JLGGRniKFApIXj
    1v6/GddFILxTATS5pq32KZiKkWmK3VShuiihmmoHzeRHw7SNIqqKuAek9Y5MSXoF
    +LB3g/XefXtpfMlAy3B4edWfWijoBzJQKPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159315; bh=n9uSzW/WuGQu29Zt+d0VvdLVkICn38
    92n5NuteWXqIY=; b=HdYZ2m4JY6+ufH04YZNA+9lXAW8zqVb0a8kfQc3PJAk6dN
    P+ftBPhlj/1YCy2GSFfJMbcjOg/dXBRTSuR/yLYukqmVepJnL/ZfwzaShi+breu3
    yUaxi9OnX8MRTA5G0023UM6R/OjJfo1L+ncVqRrodCZI+xPcF2nd1SfcUXUGNvqt
    IgnZ9oHzNRsWCMeD9doeJa53XPsKgHR7/WhoRFJDCzCJDns8XOPxZY4QKI39m+D3
    NEPcVJ4Ym/lxDUvR1ZOIfw0aOe2ZfQXohoXc79aaPuP0U9fDDYj3fFiXgZs8UeVo
    N8ymLe9r7LwUzpSXg+mjNBGBYdE++BDlfsOYCYpQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=FdSQTX5P x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=FdSQTX5P x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEGl5TBbnWPoPSCn7pis8WEEzWgO0etaAz9DzM2kcBEwGevYXKQC4wSgEzSAeOeU2wmCE4kQobBLMe0m0CRcC8SmHKFoB086Kgqcaqa8q+yjNnbxj5ln
    /f0Te2/gYv75Gm4mo/eofLvLG9g1M/NDIErH+eDRfVlej0EmAd6/Q43ELfpDimnuYBv8atIBXXWVmIl/YmstbtteaETLTSdIVWwgUowb/Xs0HKwpEbCCS+9u
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=NXlBA2qRaL4NBMo5rs0A:9 a=TLV9n937QN4VAHxZ:21
    a=aXV4Ic71RibZEedW:21 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968195AbeEXJ4n (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968435AbeEXJ4l (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianchao Wang <jianchao.w.wang@oracle.com>,
        Chris Leech <cleech@redhat.com>, Lee Duncan <lduncan@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 114/165] scsi: iscsi_tcp: set BDI_CAP_STABLE_WRITES when data digest enabled
Date: Thu, 24 May 2018 11:38:40 +0200
Message-Id: <20180524093626.631443000@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianchao Wang <jianchao.w.wang@oracle.com>

[ Upstream commit 89d0c804392bb962553f23dc4c119d11b6bd1675 ]

iscsi tcp will first send out data, then calculate and send data
digest. If we don't have BDI_CAP_STABLE_WRITES, the page cache will be
written in spite of the on going writeback. Consequently, wrong digest
will be got and sent to target.

To fix this, set BDI_CAP_STABLE_WRITES when data digest is enabled
in iscsi_tcp .slave_configure callback.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Acked-by: Chris Leech <cleech@redhat.com>
Acked-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/iscsi_tcp.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -37,6 +37,7 @@
 #include <linux/kfifo.h>
 #include <linux/scatterlist.h>
 #include <linux/module.h>
+#include <linux/backing-dev.h>
 #include <net/tcp.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
@@ -952,6 +953,13 @@ static int iscsi_sw_tcp_slave_alloc(stru
 
 static int iscsi_sw_tcp_slave_configure(struct scsi_device *sdev)
 {
+	struct iscsi_sw_tcp_host *tcp_sw_host = iscsi_host_priv(sdev->host);
+	struct iscsi_session *session = tcp_sw_host->session;
+	struct iscsi_conn *conn = session->leadconn;
+
+	if (conn->datadgst_en)
+		sdev->request_queue->backing_dev_info->capabilities
+			|= BDI_CAP_STABLE_WRITES;
 	blk_queue_bounce_limit(sdev->request_queue, BLK_BOUNCE_ANY);
 	blk_queue_dma_alignment(sdev->request_queue, 0);
 	return 0;
