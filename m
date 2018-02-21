Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226GnS9aq5KZP7qleLUIa+La+nigUvntP5j50y4z80wiTDzkJY+8qGITY1yENpkrHdxnLk9a
ARC-Seal: i=1; a=rsa-sha256; t=1519217938; cv=none;
        d=google.com; s=arc-20160816;
        b=QlLEB+eHir8/3jyWlK4RbsJpow6xu4YG/3omTKbLnj5nECXpoOeN1QpPcn9+hqVEsp
         wQSNXd3FZkf9c6obSD391okHOy2YHYKBagff+DpnopJxupGRRYcGNm03tT+qSZ2Mn2Hm
         O6p+d7Sj3QXEFK1emfiqvlC4WXL6urBCzEhz8z9sGvRO+8J5IoA+UIdJ+hQVB0t5tjpf
         +OMqKk+4Wa30RBOJv+WvxZXcoxfsKDNy/8z5uisCTIQSRtwwVsDx94Ws/HfqzgaBxRCt
         AHt1s6Vmw4Srum1V65U7ItLyTj2D7tcUcYlMAhcaFJbC0gEd9bNPu1Vbf9o19eFUI+tf
         lOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e/Y9GEuLta352g8qepvVK8n9RomIsGV9JA5Uq9tPRD0=;
        b=0HaEXP4TKjwh1p719JsBPnYwE37V9h8XyfK32w5qzrXUpmz7cXfQFmJHO9tl3rcH6h
         sjpV7/QiuflTncue3RRt2WP1AOJN4pRPhHBb/91/y5Ky2xpJPTjfJglqtBe9hE++Ngg8
         UA0Ms06pObDNZ736mOQt7Gqj8QuTGPZYGCwbkISSnSMCohZ/i+p+2aukE7NAo7Xk7jOd
         vQYrlWea7+f0+CC1qb/Nk3C/BGbgKN13HmeSoa5g6zolNErryKmEsY66ptA3lnXIXhur
         2vYc3D0xOoft0ls3l8Ylehm1WtINF1GQqRM+zFVWNKYkiX09LhWpIrNk5OE7/5AjPftF
         9+FQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4.14 030/167] arm: dts: mt7623: fix card detection issue on bananapi-r2
Date: Wed, 21 Feb 2018 13:47:21 +0100
Message-Id: <20180221124526.242817777@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015469218852122?=
X-GMAIL-MSGID: =?utf-8?q?1593015469218852122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

commit b96a696fb2a8dd1ee4e6cfee48dcac270fc53287 upstream.

Fix that bananapi-r2 booting from SD-card would fail since incorrect
polarity is applied to the previous setup with GPIO_ACTIVE_HIGH.

Cc: stable@vger.kernel.org
Fixes: 0eed8d097612 ("arm: dts: mt7623: Add SD-card and EMMC to bananapi-r2")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -204,7 +204,7 @@
 	bus-width = <4>;
 	max-frequency = <50000000>;
 	cap-sd-highspeed;
-	cd-gpios = <&pio 261 0>;
+	cd-gpios = <&pio 261 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&mt6323_vmch_reg>;
 	vqmmc-supply = <&mt6323_vio18_reg>;
 };
