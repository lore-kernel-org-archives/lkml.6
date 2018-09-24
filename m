Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1096AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA37208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA37208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbeIXSUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:20:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730063AbeIXSUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:20:20 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AACFE3082E24;
        Mon, 24 Sep 2018 12:18:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3C382010D7B;
        Mon, 24 Sep 2018 12:18:26 +0000 (UTC)
Subject: [PATCH 0/2] KEYS: Revert and replace incorrect UAPI fix
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, stable@vger.kernel.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephan Mueller <smueller@chronox.de>,
        Lubomir Rintel <lkundrak@v3.sk>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        lkundrak@v3.sk, rdunlap@infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Sep 2018 13:18:26 +0100
Message-ID: <153779150602.28003.4692837431529288988.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 24 Sep 2018 12:18:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

Here's a pair of fixes that need to go upstream asap, please:

 (1) Revert an incorrect fix to the keyrings UAPI for a C++ reserved word
     used as a struct member name.  This change being reverted breaks
     existing userspace code and is thus incorrect.

     Further, *neither* name is consistent with the one in the keyutils
     package public header.

 (2) Fix the problem by using a union to make the name from keyutils
     available in parallel and make the 'private' name unavailable in C++
     with cpp-conditionals.

David
---
David Howells (1):
      keys: Fix the use of the C++ keyword "private" in uapi/linux/keyctl.h

Lubomir Rintel (1):
      Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name"


 include/uapi/linux/keyctl.h |    7 ++++++-
 security/keys/dh.c          |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

