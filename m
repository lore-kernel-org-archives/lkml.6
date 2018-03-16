Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvVG912aegyBSSD2XW3XbJqxsFjv1c3d5OVXI03lzmdwffuYJWOzs2JjPTuznvMJ7QyXn+d
ARC-Seal: i=1; a=rsa-sha256; t=1521214850; cv=none;
        d=google.com; s=arc-20160816;
        b=be5l/wG974HNJg/Y4qNYCstlqD4zfMzxrdcCLzzzr4NTqosO87PjbxsmUWceaQip1O
         M/C1yvl+u41tlji2DmdTYYzfveafBm4tKDdXt5YJJshomDPWLRUuN4DE8cVmN6AoOJ5f
         GUbCsI0Si2JQctqjIuarW2GntGTV8yBrnFzuhXZC1jFJXiZmyiKRR/wt0Ie1eHw2RH5u
         IFZo0fFewUY5R5fCl6iHFr07RxHvIj4tcBmlD2cyqrDYhIZu7s6MvRxa2GrwiCyRBpPC
         QPswBCJjwVAiphHWhUPJ3RGmgKFXXh4ADaXWsQei4JDMJGenTvkN6PFqUgOyVu4mnmSv
         NXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/lplLsmXmAiNY0CXkhhuLIbsDXj5PRGCmj5zP6QoFKI=;
        b=caneEFWgAYrA5NZviDesXVmsGBJzPOiPkmpBl1U80mKnrAx4VdT/jJGDrxLQIaDjT5
         StCJNQMv1FFhSXhWlmnlfIuyGyU1lgDpXbpeU+rEF9TSlbkaAq8YdnUAlS7KnoTwuawO
         rPyZ1gZwDoTlTGLjogosgPvxG7I4v0TjDJNKhzCKylMBrltaiBo6dVNn9tovHCE+W12E
         T3f9Zl3HjOKpLgPds3X+HCSSgV+OVBwhqszgB/mcRVvgttfhqE6uJazmsvvXSnfHKiCz
         2Y2Zjbd2MTTKkIJs8CU0+alpoFpcH7JB3r9sFA0G4A8Coz0gartFAyZw5n5NWGgFOOEH
         QRsg==
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
Subject: [PATCH 4.15 006/128] usb: host: xhci-rcar: add support for r8a77965
Date: Fri, 16 Mar 2018 16:22:27 +0100
Message-Id: <20180316152336.527969308@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109024955266276?=
X-GMAIL-MSGID: =?utf-8?q?1595109382651283728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -83,6 +83,10 @@ static const struct soc_device_attribute
 		.soc_id = "r8a7796",
 		.data = (void *)RCAR_XHCI_FIRMWARE_V3,
 	},
+	{
+		.soc_id = "r8a77965",
+		.data = (void *)RCAR_XHCI_FIRMWARE_V3,
+	},
 	{ /* sentinel */ },
 };
 
