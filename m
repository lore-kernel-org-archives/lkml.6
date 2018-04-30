Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZojYInzHsjMkHmccSmnMEvUxK7ucJ+1K1TgtixsP5RokyMFuBjxCHhjWEJGIbxngaj4+zxP
ARC-Seal: i=1; a=rsa-sha256; t=1525116475; cv=none;
        d=google.com; s=arc-20160816;
        b=XlKZ/aLltPmVvY3VDTdk4KUHrVcwA2NhyhHUaHYJwI60JNGJgFOKTBZBOgtcOFsUxY
         l0RLPdiDsecNnHabDHea2Faef+0OCGML6T3ZM7GjHGCkqi9F0/Ir9gIsoxMUPyxmiRFI
         bYiSoEo+v3xyeSplMjjf3lB67duvx4b8N2c8ifWDFI0s0rEKwDLq8Ulau4T7D8snk+sy
         vHG/RKZjcBiAWYFymogj9ooN0wEKc4I8txHdMPjPq7MUdzzg0XCXpknBt/Q7gnE/A+oB
         oOkbxTgr8mGtGm6A9BLbAkjReUh1YY+zCernMMfUtlNv3SV9z6tPc5BjfdDM229q9Pzr
         h4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=U8AL+esncVy81y8sgG1a+f5V4ZmOqnpXoJ7O8jrYHkk=;
        b=WfmQxR6XfEaWZeOCK3G8VJILzmPaQN1X0fcZwWinmLX+F216n0xCIPuhjBghSfE6JX
         sbOv773AjPjtpJVp5McqggLrZ7FUnJg9lpLtYfNY4lKDwFHWH6UZ6ab5ieE6plJ6E2R9
         g8NaZ26ejgxmXNCGFLJ19MbEfQHxYpQE6f9UpdThc9bCeYmX3E1Uu7LIIxaixiia5/HV
         rKESq6QvgSlQHE0c1aY6XJxvS29p79mNCsZ6VulZuTKhgIPPaT7fywmfA04JYNeeGgJ5
         oLjGI8cLNaFHkWjRz/8qqLx4T4hxF0Xfi4JESWDKeW7gLiuKPBf7RVXhkHQYs6y3opoK
         C7hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43FD22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Greg Hackmann <ghackmann@google.com>,
	Adam Wallis <awallis@codeaurora.org>,
	Mathias Nyman <mathias.nyman@intel.com>
Subject: [PATCH 4.16 013/113] Revert "xhci: plat: Register shutdown for xhci_plat"
Date: Mon, 30 Apr 2018 12:23:44 -0700
Message-Id: <20180430184015.633047576@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200532982913146?=
X-GMAIL-MSGID: =?utf-8?q?1599200532982913146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit c20f53c58261b121d0989e147368803b9773b413 upstream.

This reverts commit b07c12517f2aed0add8ce18146bb426b14099392

It is incomplete and causes hangs on devices when shutting down.  It
needs a much more "complete" fix in order to work properly.  As that fix
has not been merged, revert this patch for now before it causes any more
problems.

Cc: Greg Hackmann <ghackmann@google.com>
Cc: Adam Wallis <awallis@codeaurora.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-plat.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -419,7 +419,6 @@ MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_
 static struct platform_driver usb_xhci_driver = {
 	.probe	= xhci_plat_probe,
 	.remove	= xhci_plat_remove,
-	.shutdown	= usb_hcd_platform_shutdown,
 	.driver	= {
 		.name = "xhci-hcd",
 		.pm = &xhci_plat_pm_ops,
