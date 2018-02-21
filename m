Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225lSpm+9SqcrJUTr6hzrVpDHAP07DU5Xwx3l6D2aG5zk7srdUsov0WG4Qz8QcW1idycluuA
ARC-Seal: i=1; a=rsa-sha256; t=1519217933; cv=none;
        d=google.com; s=arc-20160816;
        b=QahrSme3TDbBVUwKUOwm234n6otOZrq7SbQBelyM+9YI4ihmgPtPzI8FWZlrobPAJu
         ebxAeHoLGgEeQwBNS6w51fdtZo57sub/HIA5jOpLDU5NV7ZX6tIlRd+N/ZrfoFynP4nR
         nLgULI39SbeK7bcH9XufLeLk4WK/e8YAXd2CBbMKLnK9s+FcocaBgWhnJS6Mptz9Mj5+
         A+ZGfilZBkKE1DpFJ7cZfCht3TCG3SEAc98QJgq/alxn31s/QO+A58zi8LhMMadmRoZu
         WLnteE1ghFXSHktRItizXOnd4AhBCC7oTvyCu9ayahWqQp1kErxohd/Gi54dfpcZAY2n
         nXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aMFy2vM5uw0lqNJU8+eB7zlvB4QMSz3I+Uu2GQ/qHnM=;
        b=my0gQ2CRY0lfZ5/qpd1Gcv9rA7vbvvU0+Xg5m9MR8lCAFtF32LiMk5KhpZZEdSPbkU
         YU5sC+R8VYVAlXNd68oxU0x27lvAQ75nQ3Nw6PU8D3dgEpP8F2dVYPvo3Z7poY4bfPE9
         rNOGrovxiOZQRzucK7MTy/3qLclGf2SVVoSAv8UwoGAAqHGxwP7DLIJAT2DP/NCV1TxQ
         eeexKJA67uul0CwJyz25R3RjROkCADb1k20PTa5qmpF1HWWurWAig//c+IiON2VS23Lt
         vqAm0w8uTnz13RL7tA6MQSCxnhc/yH8KqBZhDaM62ZbxfXLJcIFEx4L7tx/IiHsuIaa1
         14ew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 029/167] ARM: dts: nomadik: add interrupt-parent for clcd
Date: Wed, 21 Feb 2018 13:47:20 +0100
Message-Id: <20180221124526.180332443@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015335603363699?=
X-GMAIL-MSGID: =?utf-8?q?1593015463168361944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit e8bfa0422469cdfc86be3f525f621b1d44d2481b upstream.

The clcd device is lacking an interrupt-parent property, which makes
the interrupt unusable and shows up as a warning with the latest
dtc version:

arch/arm/boot/dts/ste-nomadik-s8815.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd@10120000
arch/arm/boot/dts/ste-nomadik-nhk15.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd@10120000

I looked up the old board files and found that this interrupt has
the same irqchip as all the other on-chip device, it just needs one
extra line.

Fixes: 17470b7da11c ("ARM: dts: add the CLCD LCD display to the NHK15")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -750,6 +750,7 @@
 			reg = <0x10120000 0x1000>;
 			interrupt-names = "combined";
 			interrupts = <14>;
+			interrupt-parent = <&vica>;
 			clocks = <&clcdclk>, <&hclkclcd>;
 			clock-names = "clcdclk", "apb_pclk";
 			status = "disabled";
