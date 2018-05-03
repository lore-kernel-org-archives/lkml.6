Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2505978-1525351428-2-17222458171103597299
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
    1525351427; b=YsbbmxT2li/fpA6H1txR2s95cIkcEkUiUey2Ub9sSo95PtcFb1
    vZU4kiytsnWSFjqWMNxuj5L23OcDvtX1X087k2d3NYE4EvHHm1FxwRDhWcrPQPTx
    QPxKGVNeKU6tAXW1Ub41qWXdrOyzJ5Itn16C2Nux90juk7AUKO8DIVOGco04jiZ+
    Mannmun59sUBh9Vx4hnzSfNfKru86PseAdpUa64EbpDnqlWuFEnfDDqrsVB4jqGT
    AU/nYImw27aPejMkKTh8JIZSBwiGGZJgOWblxoerowpNMe8ON9wovX8aC2gW5BIs
    kdsx62wOOyoNpVgnKAQbqWIrwzp8r4ALw8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525351427; bh=1NrDXXP5T2Wv/vLQKqBx82j86OUFi1
    r7e736f3t4v2E=; b=WSMQcSh0q3YWdYneCeMJW+iHUeG0AW5EgSGTnFDEiBbJRs
    +LK+hmt9YYnrNuIX8Jmeh3iC1i+RytcXTSWPMBRAb+refQ39TYYD3qYI+YkZnWkO
    AHS0ya/t8GLvTesz3ZrZSDtJpqgwH0Hi58vKgiDkGwc1DoCzOA5p+z/Ci359KONG
    qmajNRxN2ws/YrQYpsRZKHwBTK6Oehjzfg9gYT9F6dD47LJyIg5h8yNro0KlcFM3
    ukZPgOXZLoixvKr5G0NlmXqk3x5fc6jo/vozMWG5/J12ivZFI2wdkbixief9q2sT
    b77IQWNEZq+dPn8utOOBwDEpkhHnjibdZ1kbn2Ww==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfACgXg7RCYILzjAudNOtJ2Og6uPFIwoBaleuEynyy8s+U0StwcoC2ySC3OOjOO2ChDa+FEz7czjRVNQ+2DjTOq/8zjY3CZ1D5RsNoUfcccmq3osChhBU
    AAIzce99S6ewhfrE0ivwwXOs6u7svvcc3RpoTxgjpG8Rg0LW1MCQ017wmlQYcYTzmlr6eBQz7eVmozHsSnHuwhq2i22Zb8mU+bjhJOeh7w3hsl0Sqe3rLhT9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=xI3QqhJHLw-kyKY4pjkA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbeECMnp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 08:43:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:64789 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeECMno (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 3 May 2018 08:43:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="42771594"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-kernel@vger.kernel.org (open list),
        tpmdd-devel@lists.sourceforge.net (moderated list:TPM DEVICE DRIVER)
Subject: [PATCH 0/2] fixes for v4.4
Date: Thu,  3 May 2018 15:43:32 +0300
Message-Id: <20180503124334.8468-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Decided to add Enric's commit because it is also a bug fix instead
of modifying Chris commit.

Chris Chiu (1):
  tpm: self test failure should not cause suspend to fail

Enric Balletbo i Serra (1):
  tpm: do not suspend/resume if power stays on

 drivers/char/tpm/tpm-interface.c | 7 +++++++
 drivers/char/tpm/tpm.h           | 1 +
 drivers/char/tpm/tpm_of.c        | 3 +++
 3 files changed, 11 insertions(+)

-- 
2.17.0
