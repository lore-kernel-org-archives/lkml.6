Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224DbHz9ziGi6dk/q19zCyo+ZSoac/PUAD36cLehcIr8Dz0Z0lmPSrNFyr00rYIhcRbwrCoa
ARC-Seal: i=1; a=rsa-sha256; t=1517591758; cv=none;
        d=google.com; s=arc-20160816;
        b=mGW77qVqo+msa5qu51Ec4rGMTjq6tbSxrWWNuDEgCAoQE8mj+y5EmDK6uTGJi56a/5
         WA5LuJen7kcbm3xcJPrBWCITtEGNo7ZKeGPAYHCQVG8H02ZVFkeCuK0kT8flbx5RynbA
         Mz8wfRh4cCknfP0TRQgO8OwhoA7dovcsdWCeq+/QUA85eIRl+/2XmYfBskrQP3eDMK1n
         IiyAudxndzdNR79bgsYeo3lIaE/61kMWYOwfc1l/QyA3y89WMBIGtsr/uoEoCnNh0acn
         f5Jo8VbNXPh3b9dzCQCa5iU0MQAs045KEWWO6jlJ0Hvd1P+HUA/GjsbuYxMldKzboFlC
         l7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Xv0Hh5m2WzJIJF/v8EgOiEDHlAP67E2OnD49Q/GOzj4=;
        b=gyhx1KmWWUd29tRTrQfvfiXCOvdNqvC3AKDUe6TVXiNPVugN3/gRaHbydha3fdtILq
         9WJdymLSTOzLMP5qtH6dx+eB3nrrm1zFurCHNyY4h5Co4tHphVBSjGNtAs+eBCTMOSJm
         nRLALRc3SlRfXwAAC1fZ1IiotpZXeVQd0zQbIjVADuuIo1R+xUCiO/dFw1rcreR8VVCr
         JbrrKZgwT3WneaYj0sEALZ5hDEN5kXYwrCs4/aSYiSkoa8eO5gk162oJYiL5i81rL2M7
         rn1fsRtqNhBAhRuUjFrIl18kaNZv5G+mP+FBRmdmTcjSjhOOEeiF9YTmR1Ogi7f9MpIZ
         1c7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.15 34/55] CDC-ACM: apply quirk for card reader
Date: Fri,  2 Feb 2018 17:58:52 +0100
Message-Id: <20180202140829.560351348@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309418514762445?=
X-GMAIL-MSGID: =?utf-8?q?1591310296282018513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit df1cc78a52491f71d8170d513d0f6f114faa1bda upstream.

This devices drops random bytes from messages if you talk to it
too fast.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1752,6 +1752,9 @@ static const struct usb_device_id acm_id
 	{ USB_DEVICE(0x0ace, 0x1611), /* ZyDAS 56K USB MODEM - new version */
 	.driver_info = SINGLE_RX_URB, /* firmware bug */
 	},
+	{ USB_DEVICE(0x11ca, 0x0201), /* VeriFone Mx870 Gadget Serial */
+	.driver_info = SINGLE_RX_URB,
+	},
 	{ USB_DEVICE(0x22b8, 0x7000), /* Motorola Q Phone */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
