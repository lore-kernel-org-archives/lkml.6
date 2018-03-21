Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3291645-1521617563-2-2179327839360819962
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521617563; b=TEPUPI7j6pRYH/uSidCok69Sk6WVrH5DLcYGM/fihBWxeTj
    jgzI/6wj9BEU0qURqoEQF2pWMD71+OVV/VoGCwkNbSIOYO96WNcQLMpfZigfgArw
    vaLm8Mjfdnc3JPbW3n663B3/DAzO9pnmpiIahS7u1RGUU650tiZ4RmvdLgpp69WU
    SMI9GwOuTIISVHak2gAWuyANweHoF4tEr2PwM/j3j9Q7CdGFFnnHsohC4zTFp4X8
    dpmXj6D2AYaT2lGcsTp/lzpp3X/oYqtDxhSQSlLhJMAME/+CnlIgMtjfOj2UA+Fm
    QcFHMTyls2rxxhMiCMKAJ3gSo0wGKqlKaRo+a9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521617563; bh=N6Xl/6CB5sC2T9SR0icv19QOTi
    k40oHYNnWIdvJEKcg=; b=EhTba/n6gAMyheFOBU+St6dklI6NsV/ZzFpfjQuTn/
    iq8akMKY1TbZ06iIyf/n78ScON/LwnFWB8LBG1WOHJeTlTs7+9ZI2Y7rhlNbnEQg
    wpDGB2GoXk3GMynF26YGZDziVDTXnXmFUdieoG1eZIKhNLBnH74kbp3rNFDoG7JL
    lvSnX3yQ7h8pRA8eex/05k46IYXMx1ruzkK3fkcM0IHM3sMfgyoK59PPIvG6ne/G
    HrrSqunSvjcnwx81rwQDTC06KHhzMZzExpig/6mHQWc7aEdAef8blr24lv1RQ256
    oBV+tSxtaEJQZa9kmVINRgq3AUbdfcmHPOudnKUp8fAA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Z4fQX1DA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Z4fQX1DA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeCUHcl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:32:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbeCUHck (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:32:40 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: io_pgetevents & aio fsync
Date: Wed, 21 Mar 2018 08:32:23 +0100
Message-Id: <20180321073232.13366-1-hch@lst.de>
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

    git://git.infradead.org/users/hch/vfs.git aio-fsync.2

Gitweb:

    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-fsync.2
