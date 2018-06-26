Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65884C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BF826D65
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BF826D65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeFZP7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:59:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751894AbeFZP73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:59:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A858B83207;
        Tue, 26 Jun 2018 15:59:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-238.rdu2.redhat.com [10.10.120.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1003E2026E0E;
        Tue, 26 Jun 2018 15:59:27 +0000 (UTC)
Subject: [PATCH 0/3] KEYS: Miscellaneous fixes
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     dhowells@redhat.com, linux-security-module@vger.kernel.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 26 Jun 2018 16:59:27 +0100
Message-ID: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 26 Jun 2018 15:59:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 26 Jun 2018 15:59:28 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

Here's a bunch of miscellaneous fixes:

 (1) Fix the handling of the X.509 signature BIT STRING.

 (2) Fix a section declaration.

 (3) Fix rounding in KDF.

Could you pass these on to Linus please?

The patches can be found here tagged thusly:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	keys-fixes-20180626

and also on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes

David
---
Eric Biggers (1):
      dh key: fix rounding up KDF output length

Maciej S. Szmigiero (1):
      X.509: unpack RSA signatureValue field from BIT STRING

Nick Desaulniers (1):
      certs/blacklist: fix const confusion


 certs/blacklist.h                         |    2 +-
 crypto/asymmetric_keys/x509_cert_parser.c |    9 +++++++++
 security/keys/dh.c                        |    6 ++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

