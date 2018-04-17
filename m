Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2581930-1523992738-2-15794021955739650220
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523992738; b=B/M6JsGgxE206pvqTal3wIh0r570heV92OFp5yVENhrWjtkVkb
    A9e683QAeZhcu5BWq8+E4/rFb0ikF8s3GvYbNkacNMc4icm7CU2Q5NG+ccdEm1Ue
    AUzCKDYCs6+Z2bSU7ioOyEI/85l3OwG6tRd6RS19ch6Gcmgm0WBuPtFovTVbfeGs
    gtx/eAHqGXsJCNRAXt8vsQEoYvCR2DtBKfsZNNDKBehqDUP+W5ckgOXGbwfnR6Wl
    2biWBGDNdJ46ydRLKqpaGVD0PjZbYf+hGqobQlUJh1fbDquH756gfSWfSvNlRuXF
    1BmgArFmW3lvuMasHYI+s42UBKpX8tBdAH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :reply-to:sender:list-id; s=fm2; t=1523992738; bh=xKSSNw5wKvfI62
    LCxk1wkOf7zqnEdN0DF0P08WhtG5o=; b=aBX3T30i/D+qJ1E/7tIV/d2v7kLf2H
    ksWiXeZz8A2sxHMyjXPfAGV+B7gPfQq0mzbjWEcBxOyrgKW0BoOj5uhUs1M9kH65
    pNkw9t32xOVBVT2O/0/qqfERseAOy5PEpxxT5eEe+rSCBAF2hB2xWmYOMOnLugDd
    sWz544tMjZaQH4qOzZDYWDR1/cTUndL241i5vyNFncA+kVVlh/KN6ZYnfbAD/O5z
    6qloVUCdx88tzFy8DG40fnXFu67dI0uwOYzXGE2CMHeUlhNgq1A78CYh32MbiW0L
    kGONQQwisjL8z0DMsDtThtiDFSz8fo6CQcuCllw2NUld7DKmSJUlPfXA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMKgH26WaB28PK9UlZZFzZJot3d2Z39eSDgsvdNvUqArIcXY7Dp0/2DyJL15nKd028karrJGguoIrm0dxpubC3QqKIE3LBYaccQzsZ60BhvIDIu0dUNu
    erv7CpOYMce1jVdE1vUNRzIeIw1NJ2hWA1r7oZuRIVJnvJt0uiGLlsRSQdUpzaWFjNLgaUp97bImDE5+gTzngDB4gmxXVoQn9LJRfzNHoMPhG2eOmqBwEk59
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wmH2h71lHiwA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=dihGPPrMb8lbbuB8swMA:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeDQTS2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 15:18:28 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:53544
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752096AbeDQTSZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 15:18:25 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>, stable@vger.kernel.org
Subject: [Patch v2 1/6] cifs: smbd: Check for iov length on sending the last iov
Date: Tue, 17 Apr 2018 12:17:05 -0700
Message-Id: <20180417191710.14855-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfFFyrHmGPBnp8v7gnOzs6TL6+PTuEYW9qQRTRaOW6pLf3JLYL3h7jsKrSwLAQzC8YqNzE9CGqmTR/njE8fC6VlaoYodhbiyOhurJ7kpsxknr1P4Jozj4
 TI6M7fL0Qwu8qWHnOmA2z+p/iVzjjNpolxiOqFq2B7CG4rLvnd1x1g0rgplXJCTb5rz3Khx5iTmtSPdyJtPnUkvR5IeEA4fMVmwZhcK36z9K1liePqlnnFgh
 YKDc6X4LU5Vb3AeVwUIau164vBT6hecDdW/8N1CtAfux16UKu9Piloe2lu998QsUDdLblXvGSSGmO8dpkDn92mpNh0iDykHYawVP77gjquesMPe2kmaD3kKS
 0zk6+njtwVzTCIX69y6qLqfBWsWLjvBlDUeqJyf73+gggsE1S0ZyIoxiMm8qGKvcXwJ18G7nuYoKap03O6qa2n19n3tXIi3nAKIFxQ9QyF6CjwJL0vw=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

When sending the last iov that breaks into smaller buffers to fit the
transfer size, it's necessary to check if this is the last iov.

If this is the latest iov, stop and proceed to send pages.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
---
 fs/cifs/smbdirect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 90e673c..b5c6c0d 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2197,6 +2197,8 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
 						goto done;
 				}
 				i++;
+				if (i == rqst->rq_nvec)
+					break;
 			}
 			start = i;
 			buflen = 0;
-- 
2.7.4
