Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/+fQEbLj5uS3DAeuatm4xBGmwGJJ6ehOXa8GZOitd/46KwS7mtVKKXS2EHpicdLA9viTqo
ARC-Seal: i=1; a=rsa-sha256; t=1523022021; cv=none;
        d=google.com; s=arc-20160816;
        b=gwREvDn+uYqvW9Nm5k29h12KCk3ZsltO1H9xD4n6CRyoeN62t16JPER3YUxImSBk4x
         BRsOQ+K1y9+LEQrzjit/g3qiC+B/O8oFTb5PoAQU4cB+NK4P3Bvcy046rlzw7B0gmf1Q
         YdM5QHNXSGyPcg5iJd6NnAkH7OCfz7z6k7Db0rNpJztmK/hylQJ5Yemq7vKasTG++Tru
         L47BAbaUPfCd9YJVrsCklo3wpLlcHqp4DxD07VVzbMYA2XORQ/HygKPEZhdWOOvEGUVN
         D3m24aRYcWq1ZVvX4aJb2Svg/JcrPxNadY1vjwJI7jcKlEQo7mtUSOvae2m6vArxZdm6
         PmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EXz7H9bQbKtiUkIx4/mmI1YJop9Xnnd9karW4Qq4g7M=;
        b=J7QRGYNeQtwTcnhyKsblLatLGOeS8OAlb9g45sbOU7semdpZfRKkDShqQaqkm9+X7N
         Ae/u2RJbiAAYhxkj2U6FkJB4fMe5DRNEsBSMnVKj0JzNtBew5mqryfIv8vDBHPK+YDdz
         OIQUQb2UOvp+AqZZE1aoFTm1tpZxqv0HjoMDJK9998J4mqwwtJbmhhvRB6nXPLgkNps7
         jtc0Sxvf8Q4l6k3QGBjW0/qFbP2uEq/JWNSx5tJjlwbXiu98Igwl+lIEHEYb9bXGf5k3
         65s7NFLnm24yXwKh+HWtf3LyCWmEbsJ/2tscNc5pugU/HL/RH4XzKFlVe6Z8bSae9q6I
         dJuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	"Andrew F. Davis" <afd@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 65/67] Revert "ARM: dts: omap3-n900: Fix the audio CODECs reset pin"
Date: Fri,  6 Apr 2018 15:24:35 +0200
Message-Id: <20180406084348.811607968@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003615276485458?=
X-GMAIL-MSGID: =?utf-8?q?1597004338838974665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 2f1f60c4b903f0f5464560783655ff74c9663a92 which was
commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057 upstream.

It requires a driver that was not merged until 4.16, so remove it from
this stable tree as it is pointless.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/omap3-n900.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -558,7 +558,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
 		ai3x-gpio-func = <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -575,7 +575,7 @@
 	tlv320aic3x_aux: tlv320aic3x@19 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x19>;
-		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
 
 		AVDD-supply = <&vmmc2>;
 		DRVDD-supply = <&vmmc2>;
