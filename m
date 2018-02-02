Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227j83q3j42xhOw0Tn7wW++rsBDuInVEtSVdv0WE78dFDU6t/QX3DL/xvyBOXLYUPQxN06Tq
ARC-Seal: i=1; a=rsa-sha256; t=1517590922; cv=none;
        d=google.com; s=arc-20160816;
        b=cPYvi/tePzVmkaCpZBGPl6UNau5zpqpalsQfxuzzj+w9w1VAB/THOz/67c1Ah3V16Z
         4HMtB4kz1On3PC7nQRW4BxFKH5vk7pnpqyLTYGPQiNbV/J2X1ktxkEpQ+JJVppsYHBnu
         4BGN3Wj824uFolsdqfFIPnEBSU8Ddx6jNxIyo4GeGnRb1Eckx6SVVANJH4WGpAd1Muhi
         qIl6eOsaaa3H2kn/YUnEg0JE018IsmiQJ2mUfbPC3JkOIXyeHI4Qd+99ucOFH9ZESjnM
         vEYtX8yT2CBceOZFVk0vmfs9Tu2KrmakkSjl8UZaVA75a+uLSqRlrnvj9Cna9WTN4gRf
         Nhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PwIPVIk97i8rExDhUBrSssCZSKHB744B3takM1+hZVE=;
        b=OWUoAsa3fTntHp2KQqUoAoJnKXLKFqv+L6o3RSANPlZZGgC1RDa6ZZ0Dat3D2lll5R
         tG4cOpboSPnM0jViLiwj3Gx8uA4xb/ebRsJhVWt3BQ26KG/tATRCUaMZ70ANeiBICDU4
         udowwBdyMFAUCByuhg3mHDcp1fqW42KWWARbS/WQt6XOal+sEFwa/CT9lCggZ5edJaOJ
         MMUZHY13GKZ2VBunPsA/2fS5FAPL8sERkyWQHNOQ44BVFyjPVG6qfn5Plc0n9nMxBRVM
         udo9dlVoQBji7/tt97WXAxt76atIKSXgY7BrRmvMSjk3m5+/HpFDuTgg2hokhClSK3yC
         Q2lQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.4 58/67] CDC-ACM: apply quirk for card reader
Date: Fri,  2 Feb 2018 17:58:27 +0100
Message-Id: <20180202140821.697319656@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309418514762445?=
X-GMAIL-MSGID: =?utf-8?q?1591309418514762445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1695,6 +1695,9 @@ static const struct usb_device_id acm_id
 	{ USB_DEVICE(0x0ace, 0x1611), /* ZyDAS 56K USB MODEM - new version */
 	.driver_info = SINGLE_RX_URB, /* firmware bug */
 	},
+	{ USB_DEVICE(0x11ca, 0x0201), /* VeriFone Mx870 Gadget Serial */
+	.driver_info = SINGLE_RX_URB,
+	},
 	{ USB_DEVICE(0x22b8, 0x7000), /* Motorola Q Phone */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
