Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163595-2-9581729337024326989
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
    1527163595; b=nVWYczpOOS/CT53pSTlbD3AjkKgC7fWEBGvaCcSUDfneK3JI73
    VuVWmt0RUuFriukZM+SbpqA54OEQNTf5F/BiOExbkryVmAzYbOvcWfkrKZwHMxoG
    cqfK9FgR8G+jmB2uj3Gj6eaeB6gMHCo0VmuM848gL6otFYrqOEw5y78KWVpYVWfc
    y+nUYTWpfi+i79zBdwjI5jvymiqEXQPOxQTxpWKEfPPREa6YNMDclzGcjYYZpBGp
    LnfXyJ0SKPBWj5rNEIKFsBe1uHEMUiI518tyXa3NmdsSMuvYJONwpLoDMLG/aiQD
    MtGijeQGrrg/zvbN7ilUm1dU9ynbwZPYz34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163595; bh=QrcnSyySDUDazMUtAyGWtxXeVnJX8s
    F/bGy/LbFpfA8=; b=Aybbn4pnqn6TC/PEodYnwFTy/oEU+iMgsDhq1U1bYv4Te2
    gKAO4Q5KfAgtlPHMyeCoewx/YsZJkwrH7GGxvQ4x2N3e+9te8dVr4lAbB59ZeWb0
    30okANk1RcWar1fqBV92CW5q5SJvrP5OlsOQycIJNMMGUUWcNdwDsEHHgQpsb3Ko
    6CsBHqYqQztgmriPR+M4j+WBleBNEx6ABR/2SddE+APV4lxtzL+80m7F8D4qc8cj
    ASHD+Eh6jo2N6/oVrnNVe8eUw3lYy0e8Ko4hgEssfPNgEee+NSZig9btRAZveFXH
    Pedr2xa/pMa5u/qOuwsv3N8Oj3fiZkhXPebEYmew==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=SFezC+Pv x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=SFezC+Pv x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCesCWstGG1TzeFGMmJD+pbwFZbXAs6HsrIH9V8ib3HMRzxq9bfZNDTEnB8AL5nQj2G58zLvmFA1GR6U01WZfXX2AwibZlIPrAqQOEJy0O67al0NYMkf
    2jPZ/yKEw1Vo+0rpNdwD7l1h2YmyUg6FIlgbRGj4UxTNmNSKf6OSmUydwFd4N/I7OP3cMEJxWCnBjq4v3IomoW+CsQSZaJfMiArfW4zjsbYTu+8X4ChkRk4p
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=4TZh19kg0DandrCSKIsA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966692AbeEXMGQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966534AbeEXJoF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.4 34/92] usbip: usbip_host: delete device from busid_table after rebind
Date: Thu, 24 May 2018 11:38:11 +0200
Message-Id: <20180524093202.196011221@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
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
 
