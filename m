Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474421-1519218126-2-12584177639656778440
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218125; b=VoRuRN2tjmAcr/iSCwpDiwnEoilxmWVXuLJL8wQ1G7h8jq/
    gUDrmfNwSmpzXw3XrDsKcf0rpahNDNlAAC8cqdQogeO06RvOB/wH1V3OQEJLMvO2
    SB0yaopZ9xDBXIoZVwF3JyrTdD9RUInIiJm4l6K9+k25Gah+40h7unVhhRrqHQsq
    XqTQ0q9N3HBcou8tZsncN723omiiiTXrvkPq+jUAfWeQfuxeJ1YkqHzrgRX/7deV
    djhJcPaNwGrrFPff4kcXH4jwtgiSkOEUN0MJX9Q60jwZQU9yul3S80CKpuxb+IUc
    p7a8vNfn1m/Vh7JEYSq1cWCKEEWw0KVQ5dA/buw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218125; bh=oD9uRdfEugSVFeNj/YfA5/N9A1
    WcJ3k4PmCc8qekk3w=; b=VzqlDcZgq73bGJrlGNk5+aHAMEBAnuKWKwMcOfBAKn
    n+7rM6zG+oQAk+zMj45w6I648em924dffU7moncXfI7u/fNdC5b4A27ujxmlc5nP
    GngKwtBXkpqs88tPYXyG8qwGBj+Ga/9+s5SI6KhZomFsI5CmRiN6UlgNhG4Fi+OP
    pZ+pURn6Ny8vSPKIPUTklHWy4nCJMP+t401tnmGQcQxPqdY2B3gmIwkEapzlIBFf
    FBP/OQTZKqLkTqCWyXAJF443KiGIUkTZjJRoZl+2EV2mTL5ryw7Zp3yCEFWEbQzA
    c/tM/04XsdhMh17cL5VgXheqkxQP9KqIS+MxbbR2MDpg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935518AbeBUNCA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:02:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38704 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935515AbeBUNB6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:01:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rex Zhu <Rex.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 4.14 093/167] drm/amd/powerplay: Fix smu_table_entry.handle type
Date: Wed, 21 Feb 2018 13:48:24 +0100
Message-Id: <20180221124529.446598240@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
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

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

commit adab595d16abe48e9c097f000bf8921d35b28fb7 upstream.

The handle describes kernel logical address, should be
unsigned long and not uint32_t.
Fixes KASAN error and GFP on driver unload.

Reviewed-by: Rex Zhu <Rex.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h
@@ -40,7 +40,7 @@ struct smu_table_entry {
 	uint32_t table_addr_high;
 	uint32_t table_addr_low;
 	uint8_t *table;
-	uint32_t handle;
+	unsigned long handle;
 };
 
 struct smu_table_array {
