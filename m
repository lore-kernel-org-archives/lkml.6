Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt6WXEUZb1LF6zLPoLStC8H4vw/VocbqTrKyuOuNDQk83PGSxsgvFDD0pkR0URMhO/avVo7
ARC-Seal: i=1; a=rsa-sha256; t=1521214508; cv=none;
        d=google.com; s=arc-20160816;
        b=KqkHIU9XK1XX5+SMi75bfpJ25vNBIGMh6znhpepB9u56aOjYy5jOBECMwcqBcG7yVa
         bO5QU2k55K1fp0KI5Vhmr+3yIFuxs5p+4mLsqZ52A/iQrcVYVlEnoSjHhJgKrDKA/kjg
         JloGpK3QDOG3baa35UFqhqzMoUIBqHwfNF2NASTL/yVfYmN0qAd1cE+qTrU77s8bHYF0
         z+pdcdig29LOVXxT04sOgaXZ2tgmloP4nVT/vT4f4bV/dojN4R9YDQ1eASX+mBqmTbWz
         bDvfgcosg15FNWBuJTB5z/juI2K+ToNpbwo+yLMIUkE4kUp4T9LPXw+Fnx6/QEkXfhbv
         4C/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CknbOVSbEtcZ/QNKmpzlxKXcNUJzt+7XW0ErshXPRiQ=;
        b=YtuxR7iBbS66Vt1FfepRNaIU3dXeolf986gTTvrgRfzq74mIhdB31WqNo0vj4Osgrt
         l9mAeMuuaetNCDKDxjMuRzcAtJgiFEIeLZnYcJTUg3itPbZ1jdDes0Lt2nP5qCFcgK0n
         /ZmbFy8NcP6pq2OgCS9OcgAREdJPJ1AoE8gJGR9ZNk4AB+kUsLmQIpYad5EGEpoOnnRR
         2V9lcIQtbBMWLhGUtekmlqTN6qMpfksjfFni9a2ZIgVAkmmn2NnfMG9Kxmw8qOUXArat
         Cj1NsCwoolgEHxis52zMUtd+TH78uEsw9HiKlChV2KQrJuoiv25JgvSDWMjcksJuoclE
         VQ4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 4.14 008/109] usb: host: xhci-rcar: add support for r8a77965
Date: Fri, 16 Mar 2018 16:22:37 +0100
Message-Id: <20180316152330.291889287@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109024955266276?=
X-GMAIL-MSGID: =?utf-8?q?1595109024955266276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 015dbeb2282030bf56762e21d25f09422edfd750 upstream.

This patch adds support for r8a77965 (R-Car M3-N).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/usb/usb-xhci.txt |    1 +
 drivers/usb/host/xhci-rcar.c                       |    4 ++++
 2 files changed, 5 insertions(+)

--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -12,6 +12,7 @@ Required properties:
     - "renesas,xhci-r8a7793" for r8a7793 SoC
     - "renesas,xhci-r8a7795" for r8a7795 SoC
     - "renesas,xhci-r8a7796" for r8a7796 SoC
+    - "renesas,xhci-r8a77965" for r8a77965 SoC
     - "renesas,rcar-gen2-xhci" for a generic R-Car Gen2 compatible device
     - "renesas,rcar-gen3-xhci" for a generic R-Car Gen3 compatible device
     - "xhci-platform" (deprecated)
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -86,6 +86,10 @@ static const struct soc_device_attribute
 		.soc_id = "r8a7796",
 		.data = (void *)RCAR_XHCI_FIRMWARE_V3,
 	},
+	{
+		.soc_id = "r8a77965",
+		.data = (void *)RCAR_XHCI_FIRMWARE_V3,
+	},
 	{ /* sentinel */ },
 };
 
