Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/H+OYCIsxJNcI6cit08JSUTrqo/Ueo8V4cS0GDh/LCAFEzPaIaiBo3oFVHLqmGTLUVL/xx
ARC-Seal: i=1; a=rsa-sha256; t=1523021815; cv=none;
        d=google.com; s=arc-20160816;
        b=OfdUXQ0K2aBGJVALLLYz4b2mQOFVCkEL9bgnZyMaP0SFAIGM0C4YM/fKaoZs2hFryq
         zVO7qTReVuQ5YwWUkfV2UIgotsRNZxyEodjkv0MLzll2kpVib2kiqHbBOPl90WcGw1Tk
         FcIUFkZISrvO1jO+nA/Pnjhb1XqtDmbkPLWuq564t0sW90lc4Cf1x+Xy7UcbcWMqYBe7
         I2VLFn86Mh/EJL5O7vPUw96nNKBsw8S8wIGZ5y2pqI7nEaNLe1Qerm3t2vID99KMZzo+
         NbcJNFxwXj84Eh2erAoF8YsyxTSIXV+3c+X/VUglstZ+CPre8QSuLE0aTpSkis2R0VzW
         uFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EnWJnhg1gSL85ZYtjP6BAeW/WqdBldzTBK/sADetxqY=;
        b=p7ImhPTGTVi8KG9cVqsO2+3HJzaZaNnl5rA+UyyZTdBl/kurBjsj8A5R0cTVJJBDBR
         nj89MiosPQufCLX9p7CXo1OorJStlsuDdinzI3jEVZynAjXHJfCGa3yH1lcpFDBUZ3aC
         sJVziNnh6AAinytwUiJUzrn2pzsfhOeH6cr7u3nphOyMYKnysAFHtEbOA7/fKw+loMxY
         Qfuj/Ez/zUpvH9PuLYQaMpy56hAjSPEcKpKXvunpq+QnSsl9LohkCO4x8wHtzzeTWCVB
         3vkUa6pqTWr7e2SNLBRP6Qbf8+axWnRz7t38M8B7lorFcFI8pkJSu3rskSloFgHkG8jg
         VAyg==
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
Subject: [PATCH 4.9 097/102] Revert "ARM: dts: am335x-pepper: Fix the audio CODECs reset pin"
Date: Fri,  6 Apr 2018 15:24:18 +0200
Message-Id: <20180406084345.033645683@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003618153570477?=
X-GMAIL-MSGID: =?utf-8?q?1597004123767660341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 272b5eef085c23cd71eec30fe040fb1592682508 which was
comit e153db03c6b7a035c797bcdf35262586f003ee93 upstream.

It requires a driver that was not merged until 4.16, so remove it from
this stable tree as it is pointless.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am335x-pepper.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -139,7 +139,7 @@
 &audio_codec {
 	status = "okay";
 
-	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	gpio-reset = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	AVDD-supply = <&ldo3_reg>;
 	IOVDD-supply = <&ldo3_reg>;
 	DRVDD-supply = <&ldo3_reg>;
