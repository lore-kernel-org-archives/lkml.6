Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-373521-1521123402-5-7896728514030341061
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521123402; b=NlopFq5JFUmO8vjeRn4DXiqSmHV3f4fNUrly7WfHR6C3lw/
    JV0cgHHfgwtDBXJnlmFoBFCzi55g0gNiZ9xK0gDBB4Np8MyIsCzJ52pp9y8OSYuh
    CNDOf1nadYvjOlGuYu2yc+r17bEpghMry838m1CMUDu+WK3QCfIuoHrCyGDa6Rn3
    mM0yxt0NQtQ8w+W7Iom6+mTqGcgsjW01pBIkg9rNU+ZaZrqhrAyqZ3MXMbOTO0IT
    k/GBsLMa40RtHGq0clO75GLdQUS47LsPwbCDQEQ0kn+W0wL7m/odTxgsDwCvWPRv
    cnT4WiCy3E9fHPL+2FJNm2ifZPI6sS4hMXqUz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521123402; bh=kisFl6oLe+QHkC6d+v1L/6/4Tk
    zexHZOiNdjvB4xpdo=; b=bRR+yHtxWSFGL93cOZ9GtLxUhNlcbXeB++ER89Tv0M
    LAm9oB1o46PW02zlOFOBpe637tuXzsc5FSfTrpYpIWxtEyuw6ambqP9uoS4RnHtO
    BBG3kvlBB+Qv+6070fpG9VxmtKpvAth8Cl+Ubjb+o0hQNt7EuRJzGGIYjGn+FiDI
    WJcD/gIxSNkYDoH6mdcopSRtTEavtAEfXALq2k3tNqJfdcGYGIxDg1P3ALrhUZFf
    O566InZ4nstILnWmFq+PGIu5IQPaQhJkbuRQyh7w9Agk9hZlG1xVjRGTQVKHnNnG
    8CZMJY1BYZL8C0cLFKaZTOWjunitGI4LpttXtZIo8ilA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=H3L6RjKH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=H3L6RjKH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeCOOQj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 10:16:39 -0400
Received: from 8bytes.org ([81.169.241.247]:42814 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751535AbeCOOQi (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 15 Mar 2018 10:16:38 -0400
Date: Thu, 15 Mar 2018 15:16:36 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "# v4 . 4+" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix a potential memory leak
Message-ID: <20180315141636.cel3dqr4pzxfgtb3@8bytes.org>
References: <1519450947-9760-1-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519450947-9760-1-git-send-email-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 24, 2018 at 01:42:27PM +0800, Lu Baolu wrote:
> A memory block was allocated in intel_svm_bind_mm() but never freed
> in a failure path. This patch fixes this by free it to avoid memory
> leakage.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Applied, thanks.
