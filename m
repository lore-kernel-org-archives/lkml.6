Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpiI/GR/TGq2i1pV2OtQAj3yyf6DutEQbVyPtcoyWG+HtmOLlnbZ4et7jGpzVOsuV9ztWHb
ARC-Seal: i=1; a=rsa-sha256; t=1527155663; cv=none;
        d=google.com; s=arc-20160816;
        b=FJrXYTjH0k+ZLTSPHqt4JtIheajQ7yE026VqYlCuU/mKlCsrUFLpjVya6NF6Z+U6IQ
         ywig6TTmaqnJo6xBVfa3OFCP9rxxdshQ/wFXwlFn9XCY+Hx21gC4Kz09ofE5jblUbCG0
         h/uTekwzqqCG7btXD1nuKGPucYbsI3ZVWl3xjGY6cGPl4F8gtFadswdbgdFnb7ydyZVm
         G03pnYARC8C/81ytcHNfb6+nr7ygwc3JpUIoWY1YUW7UUuqr0VORnbdhYeSwhLGKH1xk
         x2JiuFBNzfr2Ave2NJllReKLaQCXIXdaXh11+mqCVaJ0XLZ923I9aupW59ZiZ2u5YUvm
         pX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=XXWlA3xJJpo5UUywVsJ92OqUVPh93WBhjN1+DXZcWfU=;
        b=zsxOJfaSMlQb0jxeaa/rWA2YvZB2MwUd1vPCPVJGI/d+MYu13uL0/ZTPTy0/McgsPI
         V+yDKfVBEcfuso0nb2Ygvam4GAtqr1oOWpFFKpUG2koyge6nYQsI0BMGfVpDBv5qH2iK
         kZUdb2cwz25OGy+AuAn0cZTLgIx3ExGQrOQUIQ7OseNsFo8k2nkpTTQ8lLMQ5+z7Xjfh
         I+MPybDRmIqlqDb0T2sL0FWhptg8gvTp6gynKAAd8QqrPYDIdiN6Go3NHQOm/tHBnqJx
         D/WBNgSBODbpZcHR6/g74TPwdcnWWAgp6M5p+qIq8fDoiQTg50QqG7C5G1Lm/UKc0MMo
         PRcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=arQRMlis;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=arQRMlis;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thinh Nguyen <thinhn@synopsys.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 070/165] usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields
Date: Thu, 24 May 2018 11:37:56 +0200
Message-Id: <20180524093624.848187934@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338397422467721?=
X-GMAIL-MSGID: =?utf-8?q?1601338777342701995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -249,6 +249,8 @@
 #define DWC3_GUSB3PIPECTL_TX_DEEPH(n)	((n) << 1)
 
 /* Global TX Fifo Size Register */
+#define DWC31_GTXFIFOSIZ_TXFRAMNUM	BIT(15)		/* DWC_usb31 only */
+#define DWC31_GTXFIFOSIZ_TXFDEF(n)	((n) & 0x7fff)	/* DWC_usb31 only */
 #define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
 #define DWC3_GTXFIFOSIZ_TXFSTADDR(n)	((n) & 0xffff0000)
 
