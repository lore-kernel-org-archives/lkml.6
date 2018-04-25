Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653380-2-13589853234833604151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653380; b=GYdW+F50biNRJqD3UXRJwLF8okgZuvvh6vGAk8YcQbf9q5OBog
    PkKcIwNLuukRF7kvw1CAKmrTYT8QdD5A6rk8VXdYkW0DpJvjPB/cJWggd1zSsegW
    irM7MZSTH9cxznMHlKV+j4bHtvLum6rFCtcIxVAtXDk9G4oV1EhaScURHRyXz5nU
    2N8469Ed3zy1FW7gJLPj3JhTMeZsEeLCx0E0pobI2U7KtWzQv60BxtK32NRazlz1
    5hKN2ONSihgCsxlChMZuZIP5arJrAUvkhRdT3IsGN2wLbWAs6wCVb+3VRAWDIIa3
    MTP9DZ+SFFanDpUVcsR+T0KTotFSRaT79kEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1524653380; bh=C53uAeA01MknPciu3/Vbkij3rqosUI
    /hI8tfBvu2zgM=; b=O6QKso/yZ5EHKxuoA00Smb8DZf9gpQ22IPaVx1zsipucv+
    m7DaulSbC5SUa6gcbh6kn4442OObny5cPPT1GW8TkaJVre5p+PXm0KKeed7AxnGR
    3CWBmnjYi9CR7yB4Qfdz8Lnm/ZqW4vXHZK5Gxmqq3u6USI9yx1k0BAi7uqnRuM7I
    kF8E05Vdt9ls0KfLvkF+2bZR8+jPc6dmw93adnKaeOlm05tl9dTTfDHXt4cVMrWw
    OYEw83COr2bNWKTCTWsqolJjgKk/brhB9Ky7LwRzD2fNDDFqj8CDgf/A1R29z+tj
    XdyA6ojQ5xt0xPWWJ80MfZtDAVaaMikqVmO0I+hg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfJXaTPaHFHeYJg2Gi1Fes4TYMDbiGWiNBHVmKTX2TGIt6kKsbZfGHR2ChwzJrDpMBe/Z1cI6up81wzyPi0k2u5DSHThTtpiVsBSUcSt07oTVWxNZ4Ihx
    i+3sEskV4PGpHFlw86TT3YFgfw8KnmfL/KtWAoXLXSoZAbVUotRF3ED+fJeXksXt2QbyMfhkLRnK6hMhYhDVOpc0hGaQzhYucm9I0IqthmUs3t8dRTIiW3Hr
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yejipxqSkx7wmXssaf8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeDYKtY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:49:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:7844 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754402AbeDYKoj (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 25 Apr 2018 06:44:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="50675449"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 0/3] v4.16 tpmdd backports
Date: Wed, 25 Apr 2018 13:44:20 +0300
Message-Id: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"tpm: add retry logic" caused merge conflicts so I picked couple of
other fixes in order to get it apply cleanly.

James Bottomley (1):
  tpm: add retry logic

Tomas Winkler (1):
  tpm: cmd_ready command can be issued only after granting locality

Winkler, Tomas (1):
  tpm: tpm-interface: fix tpm_transmit/_cmd kdoc

 drivers/char/tpm/tpm-interface.c | 131 ++++++++++++++++++++++++-------
 drivers/char/tpm/tpm.h           |   1 +
 drivers/char/tpm/tpm_crb.c       | 108 +++++++++++++++++--------
 drivers/char/tpm/tpm_tis_core.c  |   4 +-
 include/linux/tpm.h              |   2 +-
 5 files changed, 183 insertions(+), 63 deletions(-)

-- 
2.17.0
