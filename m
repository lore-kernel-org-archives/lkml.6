Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156148-5-3629435657596351827
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
    1527156145; b=XGj9tzyBmdSq32PYzbZGIHG5SLI2ZUC+KWuL3Ts8PxP9G1qj/t
    EdajASLGnRn4LT8pkUvu3B0p/4wDFEzlhn62mgjgGxmqkYAbQaWNoIiRBXXlFGIB
    EH0DsuPnkGoH7pgQ6/7oesG6FO0zYwsMidPEBsC47DoVEsvYz4pOs4HFyMAham3R
    WM2kY9kEB0o/V1zi0JdsHdGx2sZkEkBxh8flGUp1CIhIFrUYyQQ8Wk3ff+9t9CuZ
    nbWZs3MHnxwTdgpdoNckjigDFzaNwZY09y3lWJqauhef4OhyZaypyxP9BpWzbL7j
    DF2vivFUpMMRjHTjqUsAIzc32cvjSWGcfdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156145; bh=dLW7ZbkBtWZIGzx74pBtZAn5l4CKn/
    wnR0M2f0J2kKM=; b=MusxhoAJEDKfsuDmf1Kc0ur5ApOjwUJpiIArdxBI4Kc7iL
    lM2Dj8oKeWAEn+wCek8+SfrsXlF9JKaGHrhc+R/k/T+sMRoGov8Egh5HcbJYiyst
    5cBqKM1LbMVX7Mwjp2e0gB0CjKfOxgXIrAWWrbLDmf8QZYaC/Ok1OSVzxHAunpnp
    /eHdQJOAHhrruYyCYrvyseODzWun3KvHwAS1iqVFNvTSioqGrmHY8y6Xd8BFFe8H
    7v541ja6lXeOMlsZrF9TgYN4NwLMZh88GVh4CCgeFvsJQp+tJELusf2EI7wothGl
    hn7ApaS+ZpnBSJdc8gzclj/yhBdX8r1in2AYDvHw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=PZa++6MA x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=PZa++6MA x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEKsOK3gq3hP7zxFE8V8O1esbsypLyYJF6wFYb/yLci0BQSpYGFT65dqUje369BrKVnk9y4kqjrMqscQ+HSjyZk0RsmJOPpl/8m5loLIlCDXdYp++76S
    zSRejCljkpon1tvCpuj6w2Ad0N+QHA22SdRotNljI9up4B/qnRCkPwjlBA6SegYzR58FS+eDb7MbaLRNnmrWZHKkfLT8zc89SciUEJaunEdlu5ypSPXDPjzd
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=8T59DR07AAAA:8 a=pGLkceISAAAA:8 a=xNf9USuDAAAA:8 a=ag1SF4gXAAAA:8
    a=yMhMjlubAAAA:8 a=IvCaZrooO7ogT-dQfBAA:9 a=am8goDzG9P2-dyos:21
    a=PTmAhtiLbD1F0RJj:21 a=QEXdDO2ut3YA:10 a=nH4QB3FtVBqZfhiODIJV:22
    a=SEwjQc04WA-l_NiBhQ7s:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031081AbeEXKCT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030775AbeEXKCQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:02:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gianluigi Tiesi <sherpya@netfarm.it>,
        Borissh1983 <borissh1983@gmail.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 077/161] usbip: Correct maximum value of CONFIG_USBIP_VHCI_HC_PORTS
Date: Thu, 24 May 2018 11:38:22 +0200
Message-Id: <20180524093027.758983366@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

[ Upstream commit 351a8d4837ae0d61744e64262c3a80ab92ff3e42 ]

Now that usbip supports USB3, the maximum number of ports allowed
on a hub is 15 (USB_SS_MAXPORTS), not 31 (USB_MAXCHILDREN).

Reported-by: Gianluigi Tiesi <sherpya@netfarm.it>
Reported-by: Borissh1983 <borissh1983@gmail.com>
References: https://bugs.debian.org/878866
Fixes: 1c9de5bf4286 ("usbip: vhci-hcd: Add USB3 SuperSpeed support")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/usbip/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/usbip/Kconfig
+++ b/drivers/usb/usbip/Kconfig
@@ -27,7 +27,7 @@ config USBIP_VHCI_HCD
 
 config USBIP_VHCI_HC_PORTS
 	int "Number of ports per USB/IP virtual host controller"
-	range 1 31
+	range 1 15
 	default 8
 	depends on USBIP_VHCI_HCD
 	---help---
