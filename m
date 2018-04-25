Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653278-2-3545803352066168207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653278; b=b1RrYTxvPGxv8/hTpIgr3SmEetKexweuCI+imK8cFyy5/OJqKg
    oGdawe0NlLmRlXPDiBBa8Kb5IhxIDfjwiT5uO5eWegkVqFawTwOF2iAy9fuTI+Os
    8NOy1LK8oB1dmJ70RR0CeoN7ZgRk8peFrpQ6QInmUjPS6VEfYTZEviB67pOeM36T
    wuEE7a8pA/mfmCkk0ATB1Oj1GEC0o9hvRutvhS8P5/YcfD7fIev5/kAoxhAsBp4h
    m4eOjvh/+yf47GrT+YaVHuGtWG4qi0ckbYjiJPBqQ6qhje81AgI7RTcA+iJ7algu
    Ou+B5ysvT7hXSl6qWwqUXTwbA9M19QbSCz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524653278; bh=
    dQjerI71q9443YsEPi537jUqkZ9OtTIIMrbDPPN8108=; b=aX128Sa8Qj0U1RzG
    m/zmQhKjG5/0jWBMUe1yjK8vmFwpjLmduu8juOjC2b5aXIaX9rI13lrQnJs8ojpV
    yHLZBvNMy1RCsH74J+edCZ9a234L2S+46NggUOpQgjY7G7nyb6f4Rk5e7s2iZyIo
    axyHsuk0PrMpc1S8uLHBybdplbL+pDEbvuUBAHv5+mfYviT6INFZi8OrarOl7shX
    TNI5uZKWgmpDwYx5d11CH+klhWZaupji8yZQ0lXy1I4LBTluK0Pi5r0FDNMnXPLe
    JtKH07ozjkpRa8orjMYQI8v4kHobyn+rxdzc5D+qdLcibUDsrZ5N6CB32oGa33v1
    OLy88g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOj0MOd84j3xSfTsBME4qvxgGpaYcY1SSVcAkzt3tdSi+Ym7hmJVz9krFzp8PUYVWQTIpAcZa7F47d3FqbY3V1npQCin/bzNi2utsnCzHa58oNESioku
    ZGIgirRaH7m4j0odfFwtajT3wVIhHU/TGUJRlLMvAUHgSP1j9tsLdbvgyFP53qi3hUd5IwvROlPhrzscK/fBQML2pMWq+UFhRUB6I6SwY2dh4ApfuQIItqxg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=FEeHt_vjRH2InpSF00QA:9 a=lTf-MbnGypo9pSK-:21 a=Mo-yE5oDzZXVbwnL:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754458AbeDYKoy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:44:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:7853 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754452AbeDYKov (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 25 Apr 2018 06:44:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="223203184"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] tpm: tpm-interface: fix tpm_transmit/_cmd kdoc
Date: Wed, 25 Apr 2018 13:44:22 +0300
Message-Id: <20180425104425.5803-3-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
References: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Winkler, Tomas" <tomas.winkler@intel.com>

commit 65520d46a4adbf7f23bbb6d9b1773513f7bc7821 upstream

Fix tmp_ -> tpm_ typo and add reference to 'space' parameter
in kdoc for tpm_transmit and tpm_transmit_cmd functions.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 0091eccdaf8d..f71352cf7552 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -400,9 +400,10 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
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
@@ -544,10 +545,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
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
-- 
2.17.0
