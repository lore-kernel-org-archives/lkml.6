Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EF3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8330420857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8330420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbeGaV5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:57:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732709AbeGaV5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:57:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 860174001389;
        Tue, 31 Jul 2018 20:15:22 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D27D215670D;
        Tue, 31 Jul 2018 20:15:20 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v4 5/6] start normalization containerid support
Date:   Tue, 31 Jul 2018 16:11:40 -0400
Message-Id: <1533067901-21817-6-git-send-email-rgb@redhat.com>
In-Reply-To: <1533067901-21817-1-git-send-email-rgb@redhat.com>
References: <1533067901-21817-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 20:15:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 20:15:22 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 auparse/normalize_record_map.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/auparse/normalize_record_map.h b/auparse/normalize_record_map.h
index 1507bb5..ea5b42b 100644
--- a/auparse/normalize_record_map.h
+++ b/auparse/normalize_record_map.h
@@ -25,6 +25,7 @@
 
 _S(AUDIT_USER, "sent-message")
 _S(AUDIT_LOGIN, "changed-login-id-to")
+_S(AUDIT_CONTAINER_OP, "changed-container-id-to")
 _S(AUDIT_USER_AUTH, "authenticated")
 _S(AUDIT_USER_ACCT, "was-authorized")
 _S(AUDIT_USER_MGMT, "modified-user-account")
-- 
1.8.3.1

