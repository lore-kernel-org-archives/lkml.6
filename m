Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrUbeH/1mOgDSZlnGYseldTpLu3fjaujROgc94SGhAsy5zIHUqF7/nDWCG4Npoj8FH11++A
ARC-Seal: i=1; a=rsa-sha256; t=1525767471; cv=none;
        d=google.com; s=arc-20160816;
        b=XgTUMJTDaT0pX91Cydi7Lq8qsUfvN/QB0IbCGjg1Cp3T7ZF4jApero0tZ57jG7cAOQ
         vdgGU9B+Rvs2oBvf5ddI/rcrdcGPgAAnVxJ1u9ciSLjumKWT+Y8MT4p/njnS+eVm+hSp
         kjdk3MdFyILDQPTafnfFUI8LybRLcM7WiHux+QKKrS89sp7juXCBzQ6e6BOjvi50t7Og
         w+zZ9QaAQtX37D6Es4mZS1SWpuoNGXu3aszkjMKrICWGXCFFiIouG/3d8kH08NxE+wLy
         p5mr0vvGI7M31ryYqEKVGuz2nk5x1mjtXMCSACw0OpKM2t7c++mb69UjxepP6uERAEGZ
         LEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xBmVRsyZZpvueGna5ztE50x6JwJdbtF1e72bAqM4AXE=;
        b=G+26ceqMICpjaGwXpcQN4bLXnfrhyuMyFmuqF/GnuJr9HvnNjLynYsqV/LHUVP+MNf
         6yfiqr0wFmL0MWkR/pTQfnKGMC/+w52F5JBcNZ9j5NGS6kYI1P0CC43YL/ytDKlRYEXV
         82ss5f0oYkr34J9S4G68Dcck0+XurG+RqAVKrKcq0RoL5a1WsvU/TbRBFqjeCORBHIc8
         t9u0M23e5xjPTimtrYCNxCwXJ5WU+TwTkVme38ykPABP7m9lsMpPvWLZQDzlrza++0Di
         Dl9SoLkhA4uEfrxM/5pGfdtdkRRbCcggKUPpKQZTaatprW/V+391J5o/9rVYlIUZEwHC
         EZSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=j6LMJfK/;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=j6LMJfK/;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 28/32] USB: serial: option: adding support for ublox R410M
Date: Tue,  8 May 2018 10:11:08 +0200
Message-Id: <20180508074013.219992824@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882907525716192?=
X-GMAIL-MSGID: =?utf-8?q?1599883151323912865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SZ Lin (林上智) <sz.lin@moxa.com>

commit 4205cb01f6e9ef2ae6daa7be4e8ac1edeb4c9d64 upstream.

This patch adds support for ublox R410M PID 0x90b2 USB modem to option
driver, this module supports LTE Cat M1 / NB1.

Interface layout:
0: QCDM/DIAG
1: ADB
2: AT
3: RMNET

Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -236,6 +236,8 @@ static void option_instat_callback(struc
 /* These Quectel products use Qualcomm's vendor ID */
 #define QUECTEL_PRODUCT_UC20			0x9003
 #define QUECTEL_PRODUCT_UC15			0x9090
+/* These u-blox products use Qualcomm's vendor ID */
+#define UBLOX_PRODUCT_R410M			0x90b2
 /* These Yuga products use Qualcomm's vendor ID */
 #define YUGA_PRODUCT_CLM920_NC5			0x9625
 
@@ -1068,6 +1070,9 @@ static const struct usb_device_id option
 	/* Yuga products use Qualcomm vendor ID */
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, YUGA_PRODUCT_CLM920_NC5),
 	  .driver_info = RSVD(1) | RSVD(4) },
+	/* u-blox products using Qualcomm vendor ID */
+	{ USB_DEVICE(QUALCOMM_VENDOR_ID, UBLOX_PRODUCT_R410M),
+	  .driver_info = RSVD(1) | RSVD(3) },
 	/* Quectel products using Quectel vendor ID */
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC21),
 	  .driver_info = RSVD(4) },
