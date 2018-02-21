Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ACRgTLJgXDuCCfrxkIkkm6LeASi1fB+Y+K4GLuQmJ24E5YHudSiMS1xX7GBiaOSj8JdTP
ARC-Seal: i=1; a=rsa-sha256; t=1519218308; cv=none;
        d=google.com; s=arc-20160816;
        b=PXt8eDk1YNFGPg74pS5g3aDhjZ8KCnzcdPVju8QsgW7Vwny7fzA16T/G3aMCRFy1wa
         I41Rybo14KB6glpqRDlgNkxQHRLoeD1tnGouPR0zqCKIlTqI8ELk+5SliPpk+npMUzIi
         OQMBwd7fLEvV3eydrjsfYFuvueCUm+1mFuV7yxGhK44lJqw5gbk/CRwsH54mBobM9p6F
         qqV7gRljn9oRrISyixzirIUxEnghRZCzfNmKemqkzm7lP+V30IpWBxmWY1FZ9vNKwMh3
         9q7QW9Qq/XFAgcrcii3AUJ+WELQBQUmj7kAY6+y95sg8DevyBtFXpw94t6KFNjPu2gKU
         seiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3+QWrlBy4VKamJgx5GYmUc3YMATJa215m7HaEoZP6Io=;
        b=BM3LZTgjNOryLVoZm6V49Fs0TblL5v8b5pVzU110NP/7dHA7bHnpC6dtNY9/lo54ml
         P//14qyY/N2WWxIOvhSzfxpVwI43kVUyARcCcsC5LdlxDXIRreWjd9yQ9MeQWfR3OH3Z
         VeJWCY3ljCsbhdsBoQjyBqowFUnMeXUTDKDB8xuLDD0yVsPHH4ZCUGTqgbN3GXQBjabr
         YXNnpQE/D5HmDX1r+HnSeUg0uf7qT2yRSi/03opL/NNqRcL2GVuc5IQSl/FCyhB5Guwo
         NiPvXP7WaUlgZ+vENvpKBiemDPbJg1DZY6FQ6Q85e22TkYcAqb/I1S5HWp2KYcuLZWE/
         BQ1Q==
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
Subject: [PATCH 4.14 161/167] ARM: dts: Delete bogus reference to the charlcd
Date: Wed, 21 Feb 2018 13:49:32 +0100
Message-Id: <20180221124533.656958090@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015371067841542?=
X-GMAIL-MSGID: =?utf-8?q?1593015856197680874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
