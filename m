Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524840425-2-2711487032040203378
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840424; b=MxW3V/k3gNriHYr7N2wvINlTUr7czYJYJPBjEYCpZsrcAOjvI+
    3TabaXvIHWevA89YOfRXjR+gZbf7QamAJnxzJVyGDJ/eIq1Cv0iYIYbe3nc3wUgs
    CrHqmU9D768ruSlpr+kIsB0x+/z44J0SeWhEU+cVzbHxw1bEYrK0Eu6fbQAiLHMT
    O3PQ27hXeB6x04Y8G95PBh+Sb2+2uIgGDILmoMq5PnZNg/9RM6s9hoNBzUp5Lhfq
    rBqQRm2XS04oHDTKcyJE4i4AxKHGsER+Yq4/IPpS8dA+oDGAGGcHLo9N0Aq6CoLd
    t2R/vNhqH0bIk+bUTIcjYao22Z+T0wNdxLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840424; bh=7KAsq27tAWrKqLHGiosVPTRxuEP4SX
    cUGa0svriYqxY=; b=KYXcKcLkzEA9/y/wZMuOI6dGCj8u84UVKgRkFOn8mFpzmE
    4UUFcym2QppRvT4A4IUtMjumHe5woISIVLBSUd/PgDxF3OwEKcfBYvnsmZUCFlua
    OouC96efu+JyMjVS3GMFK4CHWMWqXL8ohri4agWLZt+U4e4D841chDTWPJidvW02
    8bN/VdxUWVUZR1FIC6anmFNMDoIc/rIyOT9gaKtRXId+w3dM9V0LCRenl+JghUp/
    +MjINB6xStdv2XaZKfU/dQ2p3aiWpoFvIE9z4UzNyvNSsQVSXMDf3MuVAePGbEGI
    ID886pAtwTTz+xx33PmI0CAwTakBXztVt5R8fwoQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfE3drT6Dv8rZrv5QLd85k/w3vBqsd4BBbK+BVXze/nW2Be+KM4wNMzhB6NmqMFqpovEd/WOCLyH+Dr5leeMkNEUzjm7NlAmuf2N37BfCHR/vkHFTLzol
    NydXzMzNprcbrwXV6VL6KYwGQGS0EcLzo+Spn5z68dZpx2MXHjxnP+McrRpuRhhriyYWNyiso9L90TccUYWaMSk1vhHEuNs4ZQ192ZKEy41GuPDrpJbbpymg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=Ex9tJC92AAAA:8 a=ag1SF4gXAAAA:8 a=96pqjHWoFhPGAXgsrgIA:9
    a=QEXdDO2ut3YA:10 a=UswdIN6Ny3sFqGNMsUNj:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934388AbeD0OH5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934104AbeD0OH4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:07:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CEA21892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 4.14 52/80] s390: Replace IS_ENABLED(EXPOLINE_*) with IS_ENABLED(CONFIG_EXPOLINE_*)
Date: Fri, 27 Apr 2018 15:58:45 +0200
Message-Id: <20180427135735.582445900@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


From: Eugeniu Rosca <erosca@de.adit-jv.com>

[ Upstream commit 2cb370d615e9fbed9e95ed222c2c8f337181aa90 ]

I've accidentally stumbled upon the IS_ENABLED(EXPOLINE_*) lines, which
obviously always evaluate to false. Fix this.

Fixes: f19fbd5ed642 ("s390: introduce execute-trampolines for branches")
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/nospec-branch.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -3,8 +3,8 @@
 #include <asm/facility.h>
 #include <asm/nospec-branch.h>
 
-int nospec_call_disable = IS_ENABLED(EXPOLINE_OFF);
-int nospec_return_disable = !IS_ENABLED(EXPOLINE_FULL);
+int nospec_call_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
+int nospec_return_disable = !IS_ENABLED(CONFIG_EXPOLINE_FULL);
 
 static int __init nospectre_v2_setup_early(char *str)
 {
