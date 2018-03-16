Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtXxp0Q57AFuHHJ6H1YXQRZJiDu0sRC4WHRGKwO9pvKeV5pGyisRTSsMhbjR4PK5pTYVagS
ARC-Seal: i=1; a=rsa-sha256; t=1521214562; cv=none;
        d=google.com; s=arc-20160816;
        b=HSbiPKsLBt6mbltIbCVl1Z4EkH/e6upOrGic+CT0UQp3VkVGPIAEN9aS3JPJ1O6Cix
         07lfQJxiu/31I/mj6AJPVVH0MBxOL6HNqJpkmASH6+fdgdPx9YiBUkNxlR0YO4tSrDBx
         EkjupC6UiB6CvQWkSNf3J9h/5Kuo55OjfcAggpzgNFaoaMmVnbCbP6xeyFL7DKdPO1GH
         1warLhSeEdTJ0iRHSg3v6rXXtUTLGlhcFI9yy8arU4akmOAplypY2BtyqyB4GCOc8sIr
         g79MReeakedzWfcGpiBEL9r3uPx1BcxGlJPH3rTqNJTX6fNjDLYskn+1VmImKL1yarqg
         T+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jZGaqy+QZmKu1tDBq0muQrGXBzf8I5ZIFbnXk8OcfqQ=;
        b=pZPu0iExMfVO3l6nZ44R4q1GEbJqY2StPJCYR1J47bo8o0nmWbJ1m3J6cTH7RaEf8e
         WJg7uunyme/MUn281ZKex5bdsT4lkzodrB6O735khWwfXA8rdTvEOHQsW4pCqv803qrN
         Zt2vyOmZ6MkHBLBRvsgqCxKYrNOAvzXTAA9Slcf/zuy7vlbio8Fx+FsMd1vjbFmwiuCY
         NxFe/nwF9pPilhsFcU5qzuFRCGVLFaqP9XKbT2jMcVKLVDc7B2D3y3iiWidbrtTQcHjL
         Md6KYM6EOZdlAXDesq1FR8OyZzfSQTRNNOnL/f2WHb/t3umSFshykDi/qNpr+zD30HYq
         x9+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Andrew F. Davis" <afd@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 050/109] ARM: dts: am335x-pepper: Fix the audio CODECs reset pin
Date: Fri, 16 Mar 2018 16:23:19 +0100
Message-Id: <20180316152332.677849618@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109081244207453?=
X-GMAIL-MSGID: =?utf-8?q?1595109081244207453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Andrew F. Davis" <afd@ti.com>


[ Upstream commit e153db03c6b7a035c797bcdf35262586f003ee93 ]

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

Fixes: 4341881d0562 ("ARM: dts: Add devicetree for Gumstix Pepper board")

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am335x-pepper.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -139,7 +139,7 @@
 &audio_codec {
 	status = "okay";
 
-	gpio-reset = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	AVDD-supply = <&ldo3_reg>;
 	IOVDD-supply = <&ldo3_reg>;
 	DRVDD-supply = <&ldo3_reg>;
