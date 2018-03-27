Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133288-1522172441-2-13533376193514413155
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522172440; b=lr+NzqLXp300qYMs8i2hrj7e1IhE+rlUV8ETPqFxKDZiVaq
    4qxXXuf8nGIlT88cbhmkkFr2fj7GFK9F3VaE6QxvYBfKZtEXz82Fbv16c6rPTkUR
    qyyktmrH3ceuseWsXDXkpBTQ52niD2BQ08Anmip449sF2s01en1HZm9nEgnO6VCp
    /cvOtCB4y03878lGhz5ie7CHgQZFhe4qSpo4y5WirKB5Hoe/yEdRe62vT2QzwMnr
    X9Qa+kWomtqpkCqb+3QzzTD7sDxBmWg+cqptDDXi83gkSOuh6m1ZpnpFJR60hv/f
    Tgl61IlFg0MWM2AD53DflMBbN5iFxYrLhY4kLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172440; bh=iR2MJUciydcRUCd9a+XL/WU4Gg
    SiW4Y22nXmTi42b5g=; b=Aom5Whi/Z9qoMzkU1bfwO+5AtUbsUjXo8PMowsg5oy
    /6k8CbO8riv2EMU1WHd9mBmRtfIDDWoDkm77VSFf1hfDP6qmR58ZGnSmJqQsRhtF
    ACklBwZJwq5h0kK6Kn1zPR6RvJIXMETvOyBjEjqiSXwTEhfnCGMpGnJ+ha+3VCyd
    o4JvgnKzNC1tUgcEmMHBFKU0U3mj2drbmf85Y5UYYpibXZe8+K5KOq0aIoe1f92l
    d3SxH23bNR6TIIlWk27ASflKd8cVF/CDauQ8XIKX8BKwqdmtgv0/CDdVHpdouIqm
    8P/BHI5THtge1hoEvTQ3eGOp1pbrtheoNke5XbeGL9VA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBC4LR0FETVMhBRrnQLnYMJTiH6vjAuuQaqWKek+1j72vxM3Czi54tYfIQ71kM5AZz84FH2gA7XgujFVOIoI1JR3KOZVya1HFCnLJ13Tn7zhLZ6FgSOx
    XlsJlvwUCy8QQzEXP0JgPn4tiQlycqcqGow6i6r5JasLcYL9VhP4P0LkQqoaQszoDCOmsXbFnekBCm9tLFqQQxl3NP23ZJEqlfDvMXI8jtJ5VZzRJs/n5JzF
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8
    a=R3cCniW1keC_MRnGN_oA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeC0QeJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:34:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754152AbeC0QeI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:34:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 016/101] mmc: core: Fix tracepoint print of blk_addr and blksz
Date: Tue, 27 Mar 2018 18:26:48 +0200
Message-Id: <20180327162750.969140247@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit c658dc58c7eaa8569ceb0edd1ddbdfda84fe8aa5 upstream.

Swap the positions of blk_addr and blksz in the tracepoint print arguments
so that they match the print format.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: d2f82254e4e8 ("mmc: core: Add members to mmc_request and mmc_data for CQE's")
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/trace/events/mmc.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/trace/events/mmc.h
+++ b/include/trace/events/mmc.h
@@ -86,8 +86,8 @@ TRACE_EVENT(mmc_request_start,
 		  __entry->stop_flags, __entry->stop_retries,
 		  __entry->sbc_opcode, __entry->sbc_arg,
 		  __entry->sbc_flags, __entry->sbc_retries,
-		  __entry->blocks, __entry->blk_addr,
-		  __entry->blksz, __entry->data_flags, __entry->tag,
+		  __entry->blocks, __entry->blksz,
+		  __entry->blk_addr, __entry->data_flags, __entry->tag,
 		  __entry->can_retune, __entry->doing_retune,
 		  __entry->retune_now, __entry->need_retune,
 		  __entry->hold_retune, __entry->retune_period)
