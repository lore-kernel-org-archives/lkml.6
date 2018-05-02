Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-873245-1525271925-2-10435179590377374795
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
    1525271925; b=alXOhTXZwXxXvR73faP1P8xCG+1zxfbPsb2mva2LaKX3oIZN3r
    ocpAljOwOP3mQizc76wWtGEa84dCndCtaEyTPcKW3uNk1kvRfD+XzRP9HXuHswuD
    yqfZSjOmTLbDSZvCdLPHjIxrPXGorgVkuFY+xNjF895pST0wHL+YdXpIZjKGFYXw
    NKCRw97sy2OFnQB97igjrwd01K0q96Wx0AZ2xZ26lc4kGizMX8frkZuY6GLs9s7G
    SnkDYcmpGjUM7CKkR26yC5gbQusuWS/Tbi2aCWjxfSMzunkNVayNHyFTl5jGN32O
    l44sjoZ+or2L4FrfQlTRdvtZWdf6/qwccBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525271925; bh=4KslvGs/Nf5av+KBJ9nkJc0scGEbXc
    5bKLLSUmPtHRY=; b=K2t/gzGB8GBo7mmPFlibvgxV8doPxGz5QdiaWtboYPuvHt
    cG9eAtYDMuxMX12upsvO+PwodrFT87VPGFoNuvzgOh+edfumGvfpB7mrTj8siH+o
    4mRqdl4ODE/cU0oLKysFOXhABQ9GTxxeEDmlVpFreSkowRi3ktpCynhS8Bu/V0K7
    9qqy2JG/aeej9p5u5VbXs/dfFG80vSzax9bYq4whqQ2/Vfo7yz8SxxsfiRKM1PcI
    TkCfEMWjggd+GepKk4hUBjHKC+ARF60XeYM3/XLMLHyf8vj6kWsi7ZEnaran5wEK
    3L/OWkVUjCZmAddUZVkGFr+UvEYcvveoBVTDIA8g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfGm2NXuRNbKhIUVbewucdSBcuLR4TqOnnYu2AaSSJUVsvEM+b+EMO01Mk4h8tW0PScb7KZjoOjAevkzGPadrvTYZ/kXs7ETwDFJNzZ/O/8eUG5RF+J0R
    PqFyWaHd7KoOlTvZy6825bQ5gBnCXQOpjXTepns5WsGc8lRdSwUxs+iDcEJdYWTXbt3+R42Pf5KwoYN2Ai8xZWop56+w+AkmHTISZLR9Bx+CC/HTU+ZIT4K/
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=xI3QqhJHLw-kyKY4pjkA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeEBOik (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 10:38:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:18983 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbeEBOik (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 10:38:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="55373932"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-kernel@vger.kernel.org (open list),
        tpmdd-devel@lists.sourceforge.net (moderated list:TPM DEVICE DRIVER)
Subject: [PATCH 0/2] fixes for 4.9.96
Date: Wed,  2 May 2018 17:38:27 +0300
Message-Id: <20180502143830.3534-1-jarkko.sakkinen@linux.intel.com>
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
 drivers/char/tpm/tpm.h           | 2 ++
 drivers/char/tpm/tpm_of.c        | 3 +++
 3 files changed, 12 insertions(+)

-- 
2.17.0
