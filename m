Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937518-4-4416905749965309237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_05 -0.5, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937518; b=jBtip0DrxNBbFNJkuj4VryibBV/4cn1brVqn1mLjmENRuw8pTm
    yRXLXOIWYSJqSbrp/ewtzKO94/tWhTX2UNT5ginU1tLWND8hS2o1+/zn/uX6tWFh
    7KoHXGs3kgLKrxx48CCtCNXDVTiAXfjgp3YPdaYA1iZbM4IlL4PqdtZMQQMJr2vY
    bG2et5s4u0+RtjiJbfddp494qDWff4tcdjSetPk09yuznW1yxrbwHtjPO2MwzHxK
    hbwBYK+SbwLymYjPZ+ClylgX8/EerdIxhAo+ryUcg8AZs2MgGmhaPKYn/etVtCAh
    HquGGe8rN99ZKJPQmWnhv/MD99WDTi39cgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937518; bh=JqT3G2MBqd+McInH/zuPX2+Uj796dt
    vwK+A/1fx/7iE=; b=TE88TYoggOQdltfVhuPvvZwSle5pOswl9A6AQnfHcjDu19
    P0gA4GktZ+idMHnfUr7Y6AaRzmhCVpfMaUVAJ0EgUaxxbmAyvOIPp+paW1jbLhu3
    VL38eiih8FL0fOQXq8hEzn+hRMp0Ang3FXqFuryTiNvXR56yrqRFTBFO4lzL+HYa
    Rr73gYYV+T1MHHEntVphgQN9qCadBw5DfqKS9nem9nCVnU8XB/6Qg7fC0ooSpnp6
    so0VDXZefAVJ4pwsBjLShV+09kLzhR/qdGrnrEl5nY8qOaJUHLJrMapkxWSwpaPT
    N14CxUb/fjIZe6Pw5w+LVgxB4zCHEj8CpLi6NFjg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=UyJe03sg x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=UyJe03sg x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLS1MscfcBHkR6V6xj6Fl4BpKDZBrd7aA+QtC1b9dZZ6rjGQk5zshuYYhsJkkdQDbcmyK7SMdZ7e49+sgz5HLQGEBVNEGFF3anGuv+ZwZJAIVfNlJPRA
    r8QizA4H+wnV8fpdK3ysKpHyDl0sPAj1E2ntNrja9iUAdrsewB8MQyzI4QI3SxXrxCySTm/Tx3TpQppMD8ScaUeNXgQkA+LvgRh5G/G4uU0ltTaldJA0c3QR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=4TZh19kg0DandrCSKIsA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeEUVSc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753549AbeEUVS3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:18:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.14 02/95] usbip: usbip_host: delete device from busid_table after rebind
Date: Mon, 21 May 2018 23:10:52 +0200
Message-Id: <20180521210447.696180574@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
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

From: Shuah Khan (Samsung OSG) <shuah@kernel.org>

commit 1e180f167d4e413afccbbb4a421b48b2de832549 upstream.

Device is left in the busid_table after unbind and rebind. Rebind
initiates usb bus scan and the original driver claims the device.
After rescan the device should be deleted from the busid_table as
it no longer belongs to usbip_host.

Fix it to delete the device after device_attach() succeeds.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_main.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -200,6 +200,9 @@ static ssize_t rebind_store(struct devic
 	if (!bid)
 		return -ENODEV;
 
+	/* mark the device for deletion so probe ignores it during rescan */
+	bid->status = STUB_BUSID_OTHER;
+
 	/* device_attach() callers should hold parent lock for USB */
 	if (bid->udev->dev.parent)
 		device_lock(bid->udev->dev.parent);
@@ -211,6 +214,9 @@ static ssize_t rebind_store(struct devic
 		return ret;
 	}
 
+	/* delete device from busid_table */
+	del_match_busid((char *) buf);
+
 	return count;
 }
 
