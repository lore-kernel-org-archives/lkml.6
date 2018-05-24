Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527159354-2-15640331650151652521
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
    1527159354; b=Cz1Wx1Gbjq7XYQUYlVYyIL6X/+f786RmWLJLRWHxOcxNl2I+TD
    u1RkI6/cbuRDHLDwTq3A/GgnnoQGaowAlAb6dgcr7Wh/nm7dANtnRf5t4e18IRy4
    UO3RH4ViZfdDPtH6TtJ2Hp15FCghNLEBNLXPFUg6FKcL/T+gWTYjhhHItxW28PSA
    NwEga83Kp2wcIFqDSfAzL0XiYah+Q4dgL6NvOG8r2pZ2rviGZ+U+Hm+1aE+mr9oM
    HcGTiZGa5wG1SdJMcSr28TFiVvin1Mwn9P2c3tvNj0zRMzQMyRBEOzvLOMuUOyGF
    669HEPJU9aAf74W7H8Yp0T3N20dC4m6uVK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159354; bh=MBrwpTyzXemIviL2VHOgEwFiTL5xq8
    YiOiEWde1ybWI=; b=cdeVNhoRFbG0gnNkbbSvyFPsSXNFF2bXHFo8j65t5ehxPT
    Ajz67aUgTctV+nWwQlqd78oUHKI8M+s+EgJ+ofeYL9TLclc8CPrD+SNmp/A43Te8
    9iVYya3/cAtEn9S0Neye9jlcBNQuIlG4eDQcoyd967SzIbEK9Pjzj7NzfYNT08xg
    mFzw+K2l5cicgBzGhlzo6BHWl9Vjy/3EI9HOh2yL7ptGUsqXF1zErSs5WhgH0TpB
    FBOz3xt2QLL4rc21ntmJDNz7t/VpJTn5AdkPJlfE8kKSjjMiH9GAFXEtJCOWRIxA
    isMB531JrCjVaOnBvqT4WsPvLe1wg4F10FhWBUag==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=E6+nVaTL x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=E6+nVaTL x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJddbqGye5oW8psLwZdo/YwTBqFL8G5R3GBU8AEaFsuwPyiS8nyzB65mvkm22/rQI6X09Fgj6xP1LtOitYwM3u+OpGMpzri6DClGUzLCiJfNg4552jGx
    A6GSMV/8AvKRBfXPcd6PAFPrQuU865aqU/blrf+wtYHFEsVM3SVEe0CulylW11iRtT2JzsJ3CbXei4ymsmcaXJGXf9oUKnyzQJKnVV2Re2fw8EnYhrZM+5gO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=MGvQ25dQLus8sB2lK0gA:9
    a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032683AbeEXKzd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030314AbeEXJ4f (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 086/165] staging: lustre: fix bug in osc_enter_cache_try
Date: Thu, 24 May 2018 11:38:12 +0200
Message-Id: <20180524093625.495660379@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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
@@ -190,7 +190,7 @@ struct client_obd {
 	struct sptlrpc_flavor    cl_flvr_mgc;   /* fixed flavor of mgc->mgs */
 
 	/* the grant values are protected by loi_list_lock below */
-	unsigned long		 cl_dirty_pages;	/* all _dirty_ in pahges */
+	unsigned long		 cl_dirty_pages;	/* all _dirty_ in pages */
 	unsigned long		 cl_dirty_max_pages;	/* allowed w/o rpc */
 	unsigned long		 cl_dirty_transit;	/* dirty synchronous */
 	unsigned long		 cl_avail_grant;	/* bytes of credit for ost */
--- a/drivers/staging/lustre/lustre/osc/osc_cache.c
+++ b/drivers/staging/lustre/lustre/osc/osc_cache.c
@@ -1528,7 +1528,7 @@ static int osc_enter_cache_try(struct cl
 	if (rc < 0)
 		return 0;
 
-	if (cli->cl_dirty_pages <= cli->cl_dirty_max_pages &&
+	if (cli->cl_dirty_pages < cli->cl_dirty_max_pages &&
 	    atomic_long_read(&obd_dirty_pages) + 1 <= obd_max_dirty_pages) {
 		osc_consume_write_grant(cli, &oap->oap_brw_page);
 		if (transient) {
