Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523480327-2-778921244761337993
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
    1523480327; b=OOw189BnZ/BSBgu02FgJg5+Qr8yzxqERS7zBZtU2dQpWgGjPu+
    WkgfFUyRVrfJEEcOQopdZ3qM1d/AmhtgrEK7gjCgcOxaCXyPms05VaEUq6xlPuG4
    pX77MnlfL7JBJSli4AK6e9THQkfqUhk0X8caCFVeKIGeN0N9gyxAwzQN4L67Jh7j
    CADKOVeNgOOhDAIsMXwkxU91NwqzwrKCHF6+COhtrso+0wle0IDdXeOqmrEbJuvO
    lfvMNPXMT7AjVUrzFI1VeyDnJIEUsyU6t0ewejjLjG0Ko1susfWQnv7VH5TlKjzE
    ZiOaclP8xUvOt8F5npLZJlrsw/e2G27bwisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480327; bh=br1mlNl9rn7MEDBYLxZgDGK+W8jDHg
    J23iOyD85W8q4=; b=Tu5IjQddQ0IGsFwduUw9AMChj127Jqu3Gh4JTV+gdLMVii
    P2BGukJykJN+LqZhZ2Eu+ljN3Pwkuy4mNxMIXSikwBXWiDj8QVkCMoUeGe426Ntg
    lrUYSZJ/Ivnees58x0ywAyP1KTTisPpBTi0VCSbfIpHh0itTiQ3MIiKz1DxRrPHv
    xzdKztUcmCS0u0Gh+G//8fLnM1TeoApwi3ga3a/WQXvSfax+7so5Y7ECfAr5BCyg
    9RerJPslVvo6m6eoWvHmPNqbf3NQrKXx//AFdrRiFhWoPXk5yLY4ffpg/we+Aa9R
    Y8zrM8+lXBEh/Y4BrVyE/JGNnS+SeAMbKQCU5kDQ==
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
X-CM-Envelope: MS4wfD2rqIutveVvy062QVjAgw8Olx3skmgNw1wWwWZMMZFAEPVuiUfvJjKqYOE08aHXbMw3EgXXRgeBKNuIPLj884jRzF4uAEX13mVjPTAKZYBWcRKvD5HG
    9r7262BZrLEQ2EVPZ+X5AQXB9uKmiYzQYc1vKkVARB2w7ZLUADnxrvrtYfXb8KZdiW26hUOpJjlK56QC+23UucguwD4dDpTRIK1L4JQGi9isMCQrcg7G2jHv
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VZJtwKKvAAAA:8 a=JDjsHSkAAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=RYaEpqiKWCezV3X8amEA:9 a=QEXdDO2ut3YA:10 a=vzdIw8kzLcqZOxdJCU6L:22
    a=dseMxAR1CDlncBZeV_se:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932179AbeDKSoL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:44:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57840 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbeDKSoJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 019/190] NFSv4.1: Work around a Linux server bug...
Date: Wed, 11 Apr 2018 20:34:25 +0200
Message-Id: <20180411183551.233575658@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit f4b23de3dda1536590787c9e5c3d16b8738ab108 ]

It turns out the Linux server has a bug in its implementation of
supattr_exclcreat; it returns the set of all attributes, whether
or not they are supported by minor version 1.
In order to avoid a regression, we therefore apply the supported_attrs
as a mask on top of whatever the server sent us.

Reported-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3025,6 +3025,7 @@ static int _nfs4_server_capabilities(str
 		.rpc_resp = &res,
 	};
 	int status;
+	int i;
 
 	bitmask[0] = FATTR4_WORD0_SUPPORTED_ATTRS |
 		     FATTR4_WORD0_FH_EXPIRE_TYPE |
@@ -3090,8 +3091,13 @@ static int _nfs4_server_capabilities(str
 		server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
 		server->cache_consistency_bitmask[1] &= FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
 		server->cache_consistency_bitmask[2] = 0;
+
+		/* Avoid a regression due to buggy server */
+		for (i = 0; i < ARRAY_SIZE(res.exclcreat_bitmask); i++)
+			res.exclcreat_bitmask[i] &= res.attr_bitmask[i];
 		memcpy(server->exclcreat_bitmask, res.exclcreat_bitmask,
 			sizeof(server->exclcreat_bitmask));
+
 		server->acl_bitmask = res.acl_bitmask;
 		server->fh_expire_type = res.fh_expire_type;
 	}
