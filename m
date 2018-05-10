Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2910789-1525994765-2-5490032833627851053
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
    1525994765; b=MjPBxYX2U2RiN3YH//3q9OoJLDUFhHjT8IuQAGAyfa4vIuplBC
    jPsQ9sdAWrktsKKqqDt15RimKiN9+13OmoEG6pr6CBpowMmHIH96VihhCaAuL9k8
    L7X6VMBrtgeePunCPVIo7BaYNqboBFxbFI1IZ1MOEwQbaFRsx2BtqtkOdzl0WR2t
    a9gJUiIOmZr6akLmruvepmbEZwCxfuiH1nftQFWVpYmfrYBiRZWVOEgWx1U+mz3B
    yL/nBiHWwKUsb6yDmgr9+Aw14ARbRNX+yjRqDq7s93TbJszUelmYrio4GH0NYdWJ
    MkTD8BxsKma+XkMlGfbIgQOEhPm9nrfqrROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject:sender
    :list-id; s=fm2; t=1525994765; bh=4wZEI6pGEz0D9gPm3jCgaslQupi8KO
    cFakUouOfcjSo=; b=GT/qO8cC7i2Y7ReFjhk+itmMnQsz0IpAw7hF0DfxOEY61c
    5S3yn7rw/wZmGNOQqPZcAaxxNzT5vtHYhH8eiK3Rl/6vISLCOjUOe556gSUXTxIM
    TA4OJ5zjq8J23mBELz2dp3/mLckzCwBCYAL9zuVHy+Nsmd4KNI6g0XSX9plxYx/C
    cfXwepqeDHLd3Xw2MRXsmbqauI1cW1DhMpRaB2bAD0vjZQUKs7QIgPguZ45E47JG
    oXzZq3VCje9ZbsfP273BSGqnxSUS7s7n+bjdIWOPjtJ5z7MrMgaWNbJr7Fx536Vi
    o+GvQv7gJMN9X4U7vsHWiiQxhwiCLkAYu2VTM2YQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAN61i1bmbPbzrQ+tc49EAixvR8foyiW5bOe+cEW38K95OcU1k21nN9EWNwYPkxi8cBj1LKie7nYemZCogzcmS+v0AY1m9dUOdsieF5crNX470XEEzfe
    37znA+ZnI6pHV1IxT1BG7E6h6dx8Ww0hZV7U05w/xikGQ4xtD8KTvzZEwS47RfIT4zA0N69tBfFkNNWK58GOsxFmjPl7/R7ozNkiRSA7YPBweUolei5h6Jg/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=Y31CU-GpLSuCC2eUXXAA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbeEJX0C (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 19:26:02 -0400
Received: from relay2.sgi.com ([192.48.180.65]:51894 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750751AbeEJX0B (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 10 May 2018 19:26:01 -0400
Message-Id: <20180510231832.035433756@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date: Thu, 10 May 2018 18:18:32 -0500
From: <mike.travis@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, jgross@suse.com,
        dan.j.williams@intel.com, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 0/3] x86/platform/UV: Update Memory Block Size Setting
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Update support for the UV kernel to accommodate Intel BIOS changes in
NVDIMM alignment, which caused UV BIOS to align the memory boundaries
on different blocks than the previous UV standard of 2GB.

-- 
