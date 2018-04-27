Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524838259-2-6225313835413197853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524838258; b=jEVU7eJ2Gwg8YAoNq4vNXWYJ8bpbyZyP+CU2dVdhFdSqjRBPvb
    KPKiGJZO4rbbNKnor1jlDm44v5fN2QznapnyX6YwSCCxMJosH5KdA451uu4L3LmA
    YPMi9XLZRhaQIxZswa6Ec/g+C24xcTLBegwGJe+E63ue+pmiu7V0iEs18hVUR0AQ
    5QbNsgXhU2luMH/2IrBoNyLgHyyjviaF0KXcsaBak6fWFCLyAApesxP3snNbtiDg
    tCKBge9o5yzzNF0/PCf9uoRSWqZUtt2O1xDq/5Lhyopca9lgSGyeTI7E7DjXfpdn
    jp09S2xf/sjaPuO2qOmBdKgy8BLKMLH4y9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838258; bh=V0yy72tyCOldDZigSYawlcIPFgPody
    m2L6d3cUAZKac=; b=hmuZQKP+D82PGylR3qcsg7bk7hXP40DDJHyJUQMnbNVcQn
    W5Oei8vIj/4va3tlFLWyLxzv9OpPe3m/BjvBPwCkjc6PaQBTlqGn5xmP87Zg7ECR
    zyBRMHEjThx8TO4r2rAZpJ3wgV8yrH13+qU6+ilkcwSrq3HVu4aQaUELYucRiCSk
    ETFd81sbBZ4lQSYXkSP98JxzRiShx6hrmO+OHGDCSfnF1xx73OI/EMHlLMFRUsCu
    5GtPTvB6WL/L0+pdvr28gbThfhKBEndLqyQFz7AG8hEOjUkfRiNaptPpSMVF3pQC
    +91Jna6/FArde8EnJtPucOjIsXo1rok9U0Tm1MKQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPxZHhMKennjw+LqsF/CbWnHAnN8xvGP3Ber/6qrZPsnn9ej7RY2IJteA22M7dU6xOGPy33+07/xGNWG977RHowq3llsPDQLLrA24mx2Nv7cDvmj8tmI
    JaqbcC2DmznfZ/WhOj7tHX4CrwY/lxCg9x6MVcud/cuceX34SrBt3nSYWb+/W6V92IQOSs9zc8c1oKby1Mgo34zrO0e2N334TjIdLF1d7Ua5+GX9Q/8bzPua
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=tC2MrDdwHJ9IJMfzDlQA:9
    a=a8bObCe3Ve64oaBK:21 a=t5fh2m3Rl7sWGoQv:21 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934905AbeD0OKw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934799AbeD0OKu (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDC421864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.16 05/81] tpm: tpm-interface: fix tpm_transmit/_cmd kdoc
Date: Fri, 27 Apr 2018 15:58:07 +0200
Message-Id: <20180427135743.580494936@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Winkler, Tomas <tomas.winkler@intel.com>

commit 65520d46a4adbf7f23bbb6d9b1773513f7bc7821 upstream.

Fix tmp_ -> tpm_ typo and add reference to 'space' parameter
in kdoc for tpm_transmit and tpm_transmit_cmd functions.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -400,9 +400,10 @@ static void tpm_relinquish_locality(stru
 }
 
 /**
- * tmp_transmit - Internal kernel interface to transmit TPM commands.
+ * tpm_transmit - Internal kernel interface to transmit TPM commands.
  *
  * @chip: TPM chip to use
+ * @space: tpm space
  * @buf: TPM command buffer
  * @bufsiz: length of the TPM command buffer
  * @flags: tpm transmit flags - bitmap
@@ -544,10 +545,11 @@ out_no_locality:
 }
 
 /**
- * tmp_transmit_cmd - send a tpm command to the device
+ * tpm_transmit_cmd - send a tpm command to the device
  *    The function extracts tpm out header return code
  *
  * @chip: TPM chip to use
+ * @space: tpm space
  * @buf: TPM command buffer
  * @bufsiz: length of the buffer
  * @min_rsp_body_length: minimum expected length of response body
