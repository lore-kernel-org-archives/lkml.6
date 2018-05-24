Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrd1/i9eDO6Sta+GOqL8SxX63RFB6wjTj9ph0qr5o2xyim9DQzkpXk1Uef8fCWl6jzb5rAq
ARC-Seal: i=1; a=rsa-sha256; t=1527156206; cv=none;
        d=google.com; s=arc-20160816;
        b=Vslz2G2vZc3Q6kVBD7cGIH9rARAk6iEf7AzTklWMosrutiGlnzN/ywzQYool0MMlC+
         BR8dOWuBan1pvDbFX+/eDG6U/Ap0Gq+xB37r9Jydt6febrfh+yI7nWoVtC0WhNwrrQm8
         dbP32qmXCKppIBRoUBaxNbWYzhEXspDhzdk+7IpBQEyRe+m3UO4FJB2Xoc2HBbRgS9Z6
         uwQ/jeMS9P5CdZ/9MpwLehh0EsmHFOrumTwHYuUvKnSjfEjWMGFkf5yF1UtWtMoiXGQl
         4DLWPWCp2cUG5XIFE4BJ1CwOkcWWEi5JPwLvatXAhrEHADxzugiynkBwfmK03t6MhCZm
         nWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=iKU+qw0cjX3bK/hmhSo8hxcYAShXzZ1vm96XvOKR9lY=;
        b=ua2xPCs3JHurzC0N4k5arnWyDkX4cO+f5JiQwRhASprVpJwNB4KCBeVH3mMwrNq4W/
         9mQAlTl10zh9Tgk9W60Z7+G+QoRKhrzOH6p/oXBDOiDQrdt5quGdMbddnDeLfvMxkkbV
         rLUv+kp2hog16syS9DM4USGzD79NQGhLHyGtYRWfFzbpb5wtrFJGrhD8R9Z6IzFitBGS
         6XROR5NM6HHOC1hgdvVW+ha/QzLvLUNC8wsOtpl/aJNs1qlrsdA7NULbCs/sAcNn+5qJ
         ei4eJq4Xq8wmAKllchXDLWf+6sWfR260lXjJ3Jy0ezfGvH0cBONw9iX/R7L55ALdwCYy
         iJ2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OQCNAo5p;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OQCNAo5p;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thinh Nguyen <thinhn@synopsys.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 069/161] usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields
Date: Thu, 24 May 2018 11:38:14 +0200
Message-Id: <20180524093026.758618412@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338397422467721?=
X-GMAIL-MSGID: =?utf-8?q?1601339346712332781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit 0cab8d26d6e5e053b2bed3356992aaa71dc93628 ]

Update two GTXFIFOSIZ bit fields for the DWC_usb31 controller. TXFDEP
is a 15-bit value instead of 16-bit value, and bit 15 is TXFRAMNUM.

The GTXFIFOSIZ register for DWC_usb31 is as follows:
 +-------+-----------+----------------------------------+
 | BITS  | Name      | Description                      |
 +=======+===========+==================================+
 | 31:16 | TXFSTADDR | Transmit FIFOn RAM Start Address |
 | 15    | TXFRAMNUM | Asynchronous/Periodic TXFIFO     |
 | 14:0  | TXFDEP    | TXFIFO Depth                     |
 +-------+-----------+----------------------------------+

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -241,6 +241,8 @@
 #define DWC3_GUSB3PIPECTL_TX_DEEPH(n)	((n) << 1)
 
 /* Global TX Fifo Size Register */
+#define DWC31_GTXFIFOSIZ_TXFRAMNUM	BIT(15)		/* DWC_usb31 only */
+#define DWC31_GTXFIFOSIZ_TXFDEF(n)	((n) & 0x7fff)	/* DWC_usb31 only */
 #define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
 #define DWC3_GTXFIFOSIZ_TXFSTADDR(n)	((n) & 0xffff0000)
 
