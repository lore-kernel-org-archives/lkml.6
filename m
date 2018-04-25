Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488755-1524652445-2-13972867468956895740
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
    1524652445; b=Omk8H+kOMgnPiHrVUU3LXNlCYETRAIe2nsqQk3FqgoMyOeS+CU
    x4ZICLxCK/5IL4dRxNYFjS+jhSECLn5O7KU0Dy+JO53e/kGUVxvRH/TzgMXHiE6L
    DybzgsNR/MqG1BGr2M4LRxsrq7mMqQQPrnFGxQEw3IsMffPuYsMsZvpaMmxC+OEK
    i+lvzwM+N5cKRtcpa7HBybqnws0IgV3Tm/R6pA0XPl0lZI2CswQBylzyXxKDzP6q
    BVecMDLBqLm9S7K3L1c3YxTgAXoFI29tPn2hvTFT+AqMhot4UJdNkHRnlnrb2xYL
    af+cRmxtzfSB7zJtmEWVNVHDVjS8AujvQYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652445; bh=1JXe20jiquOTRU/UN44RHKw2+drU0q
    1lr5PkXoPoUSE=; b=D0YG5555pXXxMNH26td2lO56oW9Tj+6XIH9tb2Fr7/EyOF
    eKSd2mN6eRDT74PYXfo/xzqwtu3mSjGnPd4/VGOD/nhQbVQDv9r+/BKzJWcqFps4
    f44mpsy0YitzIHPVDLhzYki3cCPgL/D1oMGFEamGwyV3I1gN8uMFqw3TO0jWNLmh
    ngpKEmxwJteE/gcmJXHcT17DuXu4qXcvi7e5GJv3EAMMBJlgD9A+tZ58x9Csws4L
    Alq0MHa8Q+Kqn4hJqYFUrBj6+iWJoemlE1Lh9a/CoAS5n2BBQudG/REd7DTAWij0
    FoB+4dZjT6D+quGoCuu6aFmq8JFFXJCt5pYF6moQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfNSfkOjW49sQvQWAcmhdGOJOB4v09N861f0N7+DB88j122NneF+ONX5rqV94KnnBzDjbmBNj/njJYWV/UAYslByMbtC2Jve5PdCbCUnBpJ7v5GEVdmMM
    25VehtVq8xfrcuHj46JNvai/ci2gHcIUeSjXCsz+tQ+dPDBdXCFGUd1U4Z8tp/rx5IRpxyp0VZuqPIikIxc/5/TgS42dlOJozIoJMMrY0wCdY+xrllXd18gZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8
    a=dihGPPrMb8lbbuB8swMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbeDYKeB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:34:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50722 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeDYKdv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:33:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.16 01/26] cifs: smbd: Check for iov length on sending the last iov
Date: Wed, 25 Apr 2018 12:33:10 +0200
Message-Id: <20180425103314.903215581@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

commit ab60ee7bf9a84954f50a66a3d835860e80f99b7f upstream.

When sending the last iov that breaks into smaller buffers to fit the
transfer size, it's necessary to check if this is the last iov.

If this is the latest iov, stop and proceed to send pages.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smbdirect.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2194,6 +2194,8 @@ int smbd_send(struct smbd_connection *in
 						goto done;
 				}
 				i++;
+				if (i == rqst->rq_nvec)
+					break;
 			}
 			start = i;
 			buflen = 0;
