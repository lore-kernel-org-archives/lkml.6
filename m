Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1645646-1522222016-2-15388276383172797160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522222016; b=OB9DoA+cTtnm+e6NbAxdNDpED/S3Qqq2LFBzfkohHYAsR4j
    Oj3oksCyQ7YS3LOJRPqBXa/1YG90SsefWP6hPM+Qsy/vsHhRbaMsutZ71j3hYTCl
    yIDxlBZHNv8RhWcQpzLM0hyn+9moN2lNGDW9psaucmR0xPguQClgsbZZyTFWENRO
    ePDbjT67v1XZPqrFNJfbht9k4B1L9yUB/gSNFokFAvII5We08V1QMrxyEqzrFJQV
    lRlFKQ7MHjYKOHgqwiNgYcI5mdoUFYCvyyHv/Cp5O9HWnvsGVh4XJ+pNNPgf+wiU
    xVpmV7v1tVXHJ2ktiRo+LFzfjhY7L2HpySjGK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1522222016; bh=lAaz2spc3urlPjpVVWJBOAIDzw
    sI3GpiOfS7VUFraUk=; b=pqzOgbkzNv+fST62UPz2V6u0JJeuV733WQ4Y83xsdh
    m2pQMn1Jkc2N2nyG0TwQ20idbtyEvOLkrRLDXHHlb3BtXVa4AKWwNhPqhHsw2AHw
    H2sNvc6fiIX0MJDHR0UQbEthqxvNyyO5HjAJv/3fv+dccNjaXFmlbOh+LaVNrEy/
    H8wz02St2UoXjJAFdBp+riyLBnWGHyOKvQsZKIlOpt01ZcMyXIm5BPbJ3ZlXg4Jp
    jhm7wTbkYqdMQC0cBpHQeMha6ZvUzgjrxST4yi7kGu5BKDQ/rKHLkPCZVWDJ0rYu
    yF3fkevYLQVuujsTS70EOmvsqHbsmEmBfldRsqdNwp9Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=jj7CJXAj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=jj7CJXAj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNrYnPNAVgDEa2V3Ow0lKwpU/n2lD6qijod6BmnnzXy0qmKnoynx8CPQxSNQQ/w2n4OofOxip3ix4HisgORY5VnDS4uHkvSc3tmRbgBqZ0k5l34pAQh3
    4FEm95PPqk2l2xhfcBolwayC97K1u22TP5y9wVVESLnPgqNTmVW157o2OzXQSE0KCG+4cc5C/5RCd8/fOwY2oBbtjP6yPJ7dCoYAYZdLzmafVKg2n2LRhQJ0
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=JfrnYn6hAAAA:8
    a=VwQbUJbxAAAA:8 a=Q_ZgEdtvpROYoHcL15IA:9 a=x8gzFH9gYPwA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeC1H0w (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:26:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeC1H0v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:26:51 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: io_pgetevents & aio fsync V2
Date: Wed, 28 Mar 2018 09:26:33 +0200
Message-Id: <20180328072639.16885-1-hch@lst.de>
X-Mailer: git-send-email 2.14.2
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

this patch adds workqueue based fsync offload.  Version of this
patch have been floating around for a couple years, but we now
have a user with seastar used by ScyllaDB (who sponsored this
work) that really wants this in addition to the aio poll support.
More details are in the patch itself.

Because the iocb types have been defined sine day one (and probably
were supported by RHEL3) libaio already supports these calls as-is.

This also pulls in the aio cleanups and io_pgetevents support previously
submitted and review as part of the aio poll series.  The aio poll
series will be resubmitted on top of this series

A git tree is available here:

    git://git.infradead.org/users/hch/vfs.git aio-fsync.3

Gitweb:

    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-fsync.3

Changes since V1:
 - remove a BUG_ON_ONE(is_sync_kiocb(kiocb));
 - moved cancellation patches to the poll series
 - improve a list_empty check
