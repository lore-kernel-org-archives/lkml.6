Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527164034-2-8474425676833887506
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164034; b=Se/GnzWxRkgt3h/TYmhclLWQ7l3RSKFsby3ldm3gTGicOvI3WZ
    tm+NStfMt3nyjwpxGj0epYAgE8P3Fdx7/Bu7+q5pNQB3sC3qfJ5XnJjf86Wx3UGU
    IXS5KRY4923hfbE0ObmIAhkzH+lYZqVprT2xnwteMdZDhTJFYWC7XOZM0JKSRT0j
    geOOtnj/JFgEdrK7CJemn1+wPxhMyFXnsEhKhdv33kmkd8OBcwjXIIg3JvkCUbLL
    t+Gk+u4EBpSnXANlje4haKzbGyWkbtH4vqWMvQ5hQ+C/JaBiT/5v0T+PQabrnOWC
    ET6Zp691RnGGVOhrFJyPDVW0vyZEW/ovQ7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164034; bh=X9xmIvPedLr5PaVdlOVW2IrBsbWaqx
    nw+CVQ4+0aJ+0=; b=D1YJF/SxsfWLj/pq95gy47hHjvWgsHAJT1gdhpzg2zCSJm
    HAVPgOzxQkRGg/D6hkXJNCfZ95cGLtpMZYx2KyXjIXHHhK4UVgDj2sgGYJYHlIAP
    kHA/xlFi+ZUqBIe6D3FK5SsjTXiZqqLEOBDgYvKljYStKW56iauAgDxr9qF3ftqd
    pan08x7NdZOtulJDhHdhumHLD15y7uzJ9diqCMJFHPiqu48k3CQ8Haym7Nc5KVC4
    i5+By7LbU9NBnQXY/h45QP+0i3ye1TGJ7aEDfYTZUOekTetzQAcn8mJ2z7ulgueZ
    m+OIS2uw7UmpVYN8cMttWc5F1sJCmJNIwGNWp3ew==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=L98vx8og x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=L98vx8og x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJEESk4Z0HBzXw2y9JY0Vy2Lwqcx6EpNXsoHtBcRC8E3BThnuZa7QYBsBhd+CqIQuyqnxOu2Np2QgnijT+PxLDGyELs3IeQFngTp1VVAlzH/XED1If2w
    zlsI2WNEA6epfMCdoSO3IIhp/eOSKRLKFVgiN8Nz1I4nfK+uhpdcf/ZQiGY4yCGjyZnASjE7VwBTVj7zCUEJ6J1JLQhLyChDe9VuBXSFhj8ToRmIE+p2x7Z9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=4TZh19kg0DandrCSKIsA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966489AbeEXMNh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966031AbeEXJmm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 3.18 24/45] usbip: usbip_host: delete device from busid_table after rebind
Date: Thu, 24 May 2018 11:38:32 +0200
Message-Id: <20180524093123.749172171@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -201,6 +201,9 @@ static ssize_t rebind_store(struct devic
 	if (!bid)
 		return -ENODEV;
 
+	/* mark the device for deletion so probe ignores it during rescan */
+	bid->status = STUB_BUSID_OTHER;
+
 	/* device_attach() callers should hold parent lock for USB */
 	if (bid->udev->dev.parent)
 		device_lock(bid->udev->dev.parent);
@@ -212,6 +215,9 @@ static ssize_t rebind_store(struct devic
 		return ret;
 	}
 
+	/* delete device from busid_table */
+	del_match_busid((char *) buf);
+
 	return count;
 }
 
