Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2264C/6baAA2TAFl7rIg0aeyu7vLadx6GxClg70+73Ahv1UdkEeXuj22FuABX7xY/K/LfEn0
ARC-Seal: i=1; a=rsa-sha256; t=1519217844; cv=none;
        d=google.com; s=arc-20160816;
        b=S3IGIJU/gAUKUGuOc8JjieJiji3liixmGsYGP4zZFoaHKcOPfxGt2ZwdI0Ot9rcULE
         nVpjI8imhdGgbnRQsSVDWV/sUzzx2H26pG+AcBq8KSv+3ZUZn2oXUWXfr4vf+wI4dmBU
         PfSJcKMnvbHqvMDo2kfQ916/+rBc/PEb9GCnmY+8f1+A+1Gz6+psx35fMNgvdj0l8ImP
         62OYWvK8b56Rsgrk+Fub5/3aM6OekAY/GKsThj+6WMm65YYRWbmdKwAnrLnUj/K4KZiE
         bdy3cYmZB+MskkhzpQhfCN2EIn1FXyxxwNf9tWS2vcE9VA3m6Mmnp0KbXbDOMNvTYMzO
         WyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LpxRs/R8EcJAinuTKNxL/sWcUPXFwtK9YaTnjEhBSoA=;
        b=ws3UwS6f68Sj4IH/ndcgaR1SB2m/OAux0bw0Rop4P93Ms+Zbt+bwuMaWkC6zNiJt6J
         FcZRol26aCtcUJ7jiZy4fntiUj60xuebLLY/hp/cxEjDAJxnSfRkAzk58E11U1OC9KP7
         QHsPNqFT+lPsYUsdAUMxFUGxGAbIA/KRV0P2ovr+HIufn1cwhu7wSFti7u8yYpBC1B0Z
         VsL7dbcbVPAb2L7kZcwr4mueTkRHASM8YqAwkPCtHLrqq8Nd95aGeKcoPY+evel+sb5P
         WZCZqbSotxT1QJ9ghlfonnmWPAD+/Grfhl2bRCMpJbXamQbzDQ35f4riTEXU5QuvoTk3
         QvyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.9 74/77] ARM: dts: Delete bogus reference to the charlcd
Date: Wed, 21 Feb 2018 13:49:23 +0100
Message-Id: <20180221124435.298913391@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015371067841542?=
X-GMAIL-MSGID: =?utf-8?q?1593015371067841542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit 586b2a4befad88cd87b372a1cea01e58c6811ea9 upstream.

The EB MP board probably has a character LCD but the board manual does
not really state which IRQ it has assigned to this device. The invalid
assignment was a mistake by me during submission of the DTSI where I was
looking for the reference, didn't find it and didn't fill it in.

Delete this for now: it can probably be fixed but that requires access
to the actual board for some trial-and-error experiments.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi |    5 -----
 1 file changed, 5 deletions(-)

--- a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
+++ b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
@@ -150,11 +150,6 @@
 	interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-&charlcd {
-	interrupt-parent = <&intc>;
-	interrupts = <0  IRQ_TYPE_LEVEL_HIGH>;
-};
-
 &serial0 {
 	interrupt-parent = <&intc>;
 	interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
