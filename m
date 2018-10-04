Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEE7C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294CD2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLj/OgUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294CD2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJDH5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:57:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55937 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeJDH5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:57:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so7368643wmb.5;
        Wed, 03 Oct 2018 18:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eASa/+NtUhUVczS8WjGVOOiTDAK0+qvlTHknzikWA9U=;
        b=PLj/OgUGZW6Tlr5fbAf2uXCZlh+hwBOy+4UP64x+c8aeb3I8THnarP0RrK4SKoQI5q
         z9V07HRPx7wJGDHMk9NmE1YijtFPthr0d5t99VzzMRX8IXsS87TjN70YRyi7sQ/EiDFE
         v7r+/mqp4HwwAtxnIFRidbxURag2PlNnD6o7o69z5Zh8lOWntM9eKGaFFjLOwCtytTbm
         dDSB1ozA2OoXOnguWDC6IJ+KZ5sHTn5UuWeaM57gippAlPBY4qb/CwuUp6RbxkaeRPb7
         r6C1CbiOYe4xs5Z4ABJiDUA+kiadi7eMcii+hEx/pnnsZVPRPv8UlOB+l7nZjtFcqDs0
         fBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eASa/+NtUhUVczS8WjGVOOiTDAK0+qvlTHknzikWA9U=;
        b=XaehLUyI/kFdl3OxKTtLZ7Z3Cx9EwlO8qgb4ZgrAT1UJmTHLZoUXncG/RAHc5UN5gt
         4eW8U0eGsLmKTvSznLDoKwMxSUvVrmDrvmvLe5A5vQPSWaIIOaWi2VgAbksu1eDK5eW6
         NzVQ8fhE14SPLXmEK9AUguUTC1kRpXRtLhtpxr0jwp4gx3WacfA0AunqUJaYeGgHHUl0
         Lw4mV3c36RU+whHo9gjFfpKaQZsAdhMbt8RtgWedpX7PqCW7BUnRzT5OJiBmILMzO82Q
         ypVdvngCWtYtJxMkA3vmclTZJ7QFKuvRZC4chZ+QeMweZ9iM9kqN5TIbWwEECKT5kdSW
         IAvw==
X-Gm-Message-State: ABuFfohxcUSFHcSZ2oCu2i278jdVWXRXGiNlZTLCfYiCBj6BC7ASwhJ5
        JZw8k79R9CJyzkvq32xpWKk=
X-Google-Smtp-Source: ACcGV60VCXd2AjgbqyZJ6WCNTuf6qeGkdyxX0tGV1g8RPUkQbdFdG6dJ+foBP5YCywqsOowtUJX2qw==
X-Received: by 2002:a1c:1c4e:: with SMTP id c75-v6mr3194684wmc.4.1538615184261;
        Wed, 03 Oct 2018 18:06:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l70-v6sm3996821wma.0.2018.10.03.18.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 18:06:23 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: iscsi_tcp: Explicitly cast param in iscsi_sw_tcp_host_get_param
Date:   Wed,  3 Oct 2018 18:06:15 -0700
Message-Id: <20181004010615.19782-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/scsi/iscsi_tcp.c:803:15: warning: implicit conversion from
enumeration type 'enum iscsi_host_param' to different enumeration type
'enum iscsi_param' [-Wenum-conversion]
                                                 &addr, param, buf);
                                                        ^~~~~
1 warning generated.

iscsi_conn_get_addr_param handles ISCSI_HOST_PARAM_IPADDRESS just fine
so add an explicit cast to iscsi_param to make it clear to Clang that
this is expected behavior.

Link: https://github.com/ClangBuiltLinux/linux/issues/153
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/iscsi_tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index b025a0b74341..23354f206533 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -800,7 +800,8 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
 			return rc;
 
 		return iscsi_conn_get_addr_param((struct sockaddr_storage *)
-						 &addr, param, buf);
+						 &addr,
+						 (enum iscsi_param)param, buf);
 	default:
 		return iscsi_host_get_param(shost, param, buf);
 	}
-- 
2.19.0

