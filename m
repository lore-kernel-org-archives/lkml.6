Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477669-2-6280591551522116031
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
    1523477667; b=Jy2rTrJ2fRPAa7/S9K752YccGTzyrQmKqtYUiGSuPha2PmukAs
    D427W3uLbPikrUcZddz7MhfnI77l5ONU6whse0lzWFNmKegn2dExc8J5F53bEr00
    /ug2ccFqw6+e/ELm5BjOj1N9ptnDB8O13+4Ac9srEOMFQvuqNJA9zKAPNdpSdlQn
    IKLLnABfHN/evjLS5lieIOb5TA/33pJHisA99ucLDlsBDv62qutI1pJunsQiziGb
    WA/84BfOlJ6NmimupPW9Jlovw/HAb2DwL1OPEEj0H6H/UmHhYqI3qMaQ8dAtR3tO
    U5Hl/vuVBIejQokDkx57Uhim2pXKNN/bDCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477667; bh=pY6guMryDh+RSCv+ur6/j9+98YcRuN
    xdSJyLLWNR0Q8=; b=Otfv0VP2txXTv/+X9fhgEsrpPsfdkyVxswbZcv55t+51xK
    I68XcrZ2tVS0xAA+Cw9dK2guwM8D2+4Y7XO8f+wsFicT1zmutHArUpXoDErgoOGS
    hJBuAO/DGXIjAOyxf13RZTmESAq6w4T68iupRxJMrduWx8+5T0sIMarmNeEXSN73
    PWv8PSQSnM09q85rjcXAZPPq0D9yP/aMtXqRBZHuis4OQFB69cAJAxZ8DvTbXUW0
    +VVsdgZOcwVa9XbpW9XfHCBUJimvCyvb9Ktc0ntlMt/iTHwqS3KhwPoi5WhhOELb
    yhZadIOJYWtWrgEkhSwGxpjyWLs13qLAjWP6I33g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfEcf9B/Icab2+EhWY9cG0zmIC291E2Mef+IYU2drjEwqppiTps+4nTR9ONnyebnCXx9ChG3YOBMN2n1dJ3PPe1fDdufGm/5Vf32oPoUZ0XTns0Mo/uln
    yDxsv/l6mbePgOhPxSdKAE5fuQiR3uGDSooT+jpGet5Ab5bkXhrsq49iwy6WdQiGInfX74+IVjgP3O5TJbvmbw6NCx5qoPiJFwJm8eFMqheosQ+T0niT/TtC
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VZJtwKKvAAAA:8 a=JDjsHSkAAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=RYaEpqiKWCezV3X8amEA:9 a=QEXdDO2ut3YA:10 a=vzdIw8kzLcqZOxdJCU6L:22
    a=dseMxAR1CDlncBZeV_se:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbeDKSxg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:53:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933299AbeDKSxf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 026/310] NFSv4.1: Work around a Linux server bug...
Date: Wed, 11 Apr 2018 20:32:45 +0200
Message-Id: <20180411183623.421918196@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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
@@ -3300,6 +3300,7 @@ static int _nfs4_server_capabilities(str
 		.rpc_resp = &res,
 	};
 	int status;
+	int i;
 
 	bitmask[0] = FATTR4_WORD0_SUPPORTED_ATTRS |
 		     FATTR4_WORD0_FH_EXPIRE_TYPE |
@@ -3365,8 +3366,13 @@ static int _nfs4_server_capabilities(str
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
