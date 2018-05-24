Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162009-2-14852036733221882124
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162009; b=ZF+a5JSgl+QOEaHz7C3XLpzgqsTkG57xLsPYyygpYI+9AOIrez
    cDMqsRZBQDMzrZfueGFooMN90tv4Z3KcvxRvJ6naWoCPtKVrlWuKjCnby6Hm8prJ
    MxmJuGp6gi841IUSjZeGlsnONyWDjQ5AQTTjT7VBSJuspEDp1TFrhy5KOTJQDJl4
    nXOVBrwa/sPoHqAyj2b2urCq83x887L2//I1hUtNPaAQUN7z+/GkmDripXa8lGqf
    YNll5Ugr9dnYuTs9nEzUP8hWndKWl2sIO1XiVivR2otLs8YlmucHKfhsr+w7fMt7
    7djnI7NUek8brFnPM3vmtung5bc4Qm+DOU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162009; bh=UfsnIh6vCDDWxHJRWGPH09y91VtQIC
    g53fQ6Tqyix9A=; b=OGyy6HZH/wbf25N+2GZd5gD62QXAZMre37JhWB11NXIADI
    NKiH3w1a3EmcRRL54kL53EPaHiN19cIozFDsitq8dd1X0m0imFvpvBlJta+BmpaP
    3EkV2m7EZn/nLDKvfEZoG2a/jhKytEjcQMNVmJVa3a843pJGJn4mPl7sk2kWtFgD
    AVw65J3BXznAq2SMrUwzQe/RNk8Yrc72piWHhnuv+DfH9ee0iFVxqbNu/5rKm6qm
    cHiv4uwDok93A6mM6EQ8646RzcWD6Dt5gXlcSkSBeNDivRQoVYTWHWL2cNP7O97b
    kpG/uhhMf/TYMK2TK8HRctEc0li0uVsbHptPw3/Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=AMp24uQU x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=AMp24uQU x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK0HYjv0ZyI5/V5kaETMeOj4zc9k/bb68IsG9J0mnWTH0PFwjjerHgkLPPQ3ZtrcZWgb6/VMOtx7UOAX7sVlQWl/vgmJ1gOLpnxalOs/rIi0c5mvTdwK
    DGpM3FWE4W621SUHXBAEfxLWniFhbvGdJCxFBe/0QAVga8C2sPYwdvGCS4ZPqlZEZ0zY/elK25bE/1ZUf/xrYFBeBtrsR3OUs4g2xfiycu+MjBjCFReiX9Ht
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=MGvQ25dQLus8sB2lK0gA:9
    a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967004AbeEXJs6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967279AbeEXJsw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 47/96] staging: lustre: fix bug in osc_enter_cache_try
Date: Thu, 24 May 2018 11:38:30 +0200
Message-Id: <20180524093608.182210250@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

[ Upstream commit 2fab9faf9b27298c4536c1c1b14072ab18b8f80b ]

The lustre-release patch commit bdc5bb52c554 ("LU-4933 osc:
Automatically increase the max_dirty_mb") changed

-       if (cli->cl_dirty + PAGE_CACHE_SIZE <= cli->cl_dirty_max &&
+       if (cli->cl_dirty_pages < cli->cl_dirty_max_pages &&

When this patch landed in Linux a couple of years later, it landed as

-       if (cli->cl_dirty + PAGE_SIZE <= cli->cl_dirty_max &&
+       if (cli->cl_dirty_pages <= cli->cl_dirty_max_pages &&

which is clearly different ('<=' vs '<'), and allows cl_dirty_pages to
increase beyond cl_dirty_max_pages - which causes a latter assertion
to fails.

Fixes: 3147b268400a ("staging: lustre: osc: Automatically increase the max_dirty_mb")
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/lustre/lustre/include/obd.h   |    2 +-
 drivers/staging/lustre/lustre/osc/osc_cache.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/lustre/lustre/include/obd.h
+++ b/drivers/staging/lustre/lustre/include/obd.h
@@ -253,7 +253,7 @@ struct client_obd {
 	struct sptlrpc_flavor    cl_flvr_mgc;   /* fixed flavor of mgc->mgs */
 
 	/* the grant values are protected by loi_list_lock below */
-	unsigned long		 cl_dirty_pages;	/* all _dirty_ in pahges */
+	unsigned long		 cl_dirty_pages;	/* all _dirty_ in pages */
 	unsigned long		 cl_dirty_max_pages;	/* allowed w/o rpc */
 	unsigned long		 cl_dirty_transit;	/* dirty synchronous */
 	unsigned long		 cl_avail_grant;	/* bytes of credit for ost */
--- a/drivers/staging/lustre/lustre/osc/osc_cache.c
+++ b/drivers/staging/lustre/lustre/osc/osc_cache.c
@@ -1542,7 +1542,7 @@ static int osc_enter_cache_try(struct cl
 	if (rc < 0)
 		return 0;
 
-	if (cli->cl_dirty_pages <= cli->cl_dirty_max_pages &&
+	if (cli->cl_dirty_pages < cli->cl_dirty_max_pages &&
 	    atomic_long_read(&obd_dirty_pages) + 1 <= obd_max_dirty_pages) {
 		osc_consume_write_grant(cli, &oap->oap_brw_page);
 		if (transient) {
