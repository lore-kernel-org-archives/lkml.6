Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZon8SEUBn5YQHQ5SZA4pkQqAK602zThoChKJYFILFRsoQJymiuF7GgJRi2CSoOLBbIrzpSX
ARC-Seal: i=1; a=rsa-sha256; t=1527155702; cv=none;
        d=google.com; s=arc-20160816;
        b=ghBVLj34+8uojcLbq9bSSbjoBfHRVFUBk5+2mO+/2yUAmvBBZyC6juY9Q5aRjdKfrE
         HPgl7Dl6kBHY0wizYdiIhhxGNCRYqOBW/NBYU9ibt+5V28bQDCZJ2hNKNdXrHKZxKAEZ
         b+Cf/uKOOCNz8M4dN1hKvL8v/nP9k7vlgGuI1NX9jYumhpo4hzNlZpUx2Rpd4FQdoq9b
         eHUDNGhuAbR3isxNATVdlNRN36sitWzxssFmRep61TzFUao0ADDRC+uZcaTOF/d4r13N
         ecYoPa+BeHzeNw91pDcitRXajPGHohDTs6O7RP7rVZ/97WCfg0eukPh/Fx0WehQ0xtbz
         +1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=qtTi/cOXB1dfrCz19bWBsUqJEx+RCFb2Mbo0EZ6Ga3E=;
        b=z21+Hhye5yFQ0CLT5taDmfoQxSSQiq/ytCfd9scZ4/vLLF90xga/NNGGg8n8+KGVTR
         St1Mg4B6ue6yMj/UEtlly4LRgK8LBaR0tTc4Hafcd264HuFwOats4RqPxWm9GXqoVsyJ
         fI+Kssdx8XpEzTn1HoqIGyO+9S2PSPs1njyX+IUDPUJyqNtIqWZl8+SnkBgsG4Ju8Sg3
         qqSh0FHYjrKnsIT5oZLHYpX4BPDxSRqsn5JBbN734P1PH7MApIIYVT8ARxcqleX2PYIc
         rG5XttLy3HGy0fXudrlqSIMEFIiO8l5SjzkgAc+KWT+pGG4MN+CTiEhtZ4u17VayTQ0W
         qmRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EEEW4oLN;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EEEW4oLN;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gianluigi Tiesi <sherpya@netfarm.it>,
	Borissh1983 <borissh1983@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 078/165] usbip: Correct maximum value of CONFIG_USBIP_VHCI_HC_PORTS
Date: Thu, 24 May 2018 11:38:04 +0200
Message-Id: <20180524093625.181741410@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338817880044548?=
X-GMAIL-MSGID: =?utf-8?q?1601338817880044548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
