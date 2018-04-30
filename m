Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo4z3kD1x2tFkqZks5ILP9gMshf5ywZkk7Ds+QX2v+nV3mUlePyXb80ITapv4VkofDgsEXs
ARC-Seal: i=1; a=rsa-sha256; t=1525116417; cv=none;
        d=google.com; s=arc-20160816;
        b=cZlzVxKQgSzvHU7rNMqLd5b0G6zLOMgdbI8iv/0IEWXlTO14avkY3E+LprSKAFLvyO
         hPI4+NMx6ixMU5lCl24B80RAm6zhpNsuSTYyAYrPScriBGcbYJNA8NGkpTCyZc9+Pupu
         deyBF0q2ltpUeMm33iBQ6Ow/7TNkfslOSyCiqo5uAmyhZWR1qBapPljz5SUpzyaNT5q6
         IJAI1jfReIp/gzHtOU1BtbHWkh/JUfv7W0WeJMNfjy+lRSjwUbuJQjgssA5CjrTFvfMo
         Sw+24XX9iejzn44MC7FSE1QkADtlssspdV6L5WUV6aEzR7vqYvm+MOHthiXUbMwg/KZC
         8iXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=FAlYpAnWdwFlb07jWajGDtPkKIVorhMjFTM2Qt4r3OM=;
        b=U9Ados3B7CYk+/crwkErWBa7e4/mvYl6VU12B31NbPWzCDl48Bk/n9D9ZRJzARUCI1
         2TPjUpmaRBsQcPNShY3wk4kheg37RK0cPhdDadYzVCa/8Wem6U9lnV6sY5b9cGH3XRD8
         QCNPnMMvIHJkr/+NYvieHOr/Cp4z6M7r2M0jwzjgRdrB5FBtfUVUwQhjBU3hsDtwzI+E
         pANNy9WO2l/Jbcy95MA9iGb8zxhZOoZlsbH+JvZuS6Uh3k9n7gxHnyx+Q3KYJPNVqJYi
         GgSy2N//EbEXCTkmx0KGdIqF6L9p4TDU9y0wKLcNtLxSdPjAk+K90a4qo4gCRb/luaWK
         M+lA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45B122DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Greg Hackmann <ghackmann@google.com>,
	Adam Wallis <awallis@codeaurora.org>,
	Mathias Nyman <mathias.nyman@intel.com>
Subject: [PATCH 4.14 13/91] Revert "xhci: plat: Register shutdown for xhci_plat"
Date: Mon, 30 Apr 2018 12:23:55 -0700
Message-Id: <20180430184004.907340690@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200532982913146?=
X-GMAIL-MSGID: =?utf-8?q?1599200472363010949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -423,7 +423,6 @@ MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_
 static struct platform_driver usb_xhci_driver = {
 	.probe	= xhci_plat_probe,
 	.remove	= xhci_plat_remove,
-	.shutdown	= usb_hcd_platform_shutdown,
 	.driver	= {
 		.name = "xhci-hcd",
 		.pm = &xhci_plat_pm_ops,
