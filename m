Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49cnhZxX3tWUacTROr1TeuPOcOONCihZW9642SWA4vB06topdjt466PaJy1KePXvEsbvz6D
ARC-Seal: i=1; a=rsa-sha256; t=1524405841; cv=none;
        d=google.com; s=arc-20160816;
        b=MMlVtZ/GU7IjVl41kmiBTDuFsfw09OTwXVbZZ68gYxvAS1c0xtL5acY/WEE6sYIWyV
         Yfko+s3UHEF729UAQcJSYVo8hnOgikyuNbjq492N3p04SsHSFJ3fuM3UkFrtB7D9Em11
         iQ9iG1m6v8ZhhDEwK66s67+C0YUHo5h1qzK47o2QxPwud2dFgPAJZts/y3EXAFxPqhIY
         7Aadsk+jMbqmO2YJ/OgheitqVOvjLH3EEbe6tH+p8OJeiKaLYvtyB6KiZ5wZsiFqIzCQ
         y9cYzMiPKqiTS3N6S3ECblQpNannL8EuG3uW61MobyQMqzDitIMDa75PlZkz8brO3mnX
         wS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bb3xV8Y81LkGvoYRg110q7jLL2cTjj/uoi3K6uNUQDc=;
        b=PJsGz6pWYgCpVK22icfXBI+DQG/VwmuIokThcYe+/DVLQUtdHCW/2BT3s5ovMjoT1g
         g+II/E8GW7gwnisiNxkpuUMZE5Dck0RpNQf12jM0pMXj0OqBRbgYksyoRWkFhgRAasYT
         m5vYWcMY7bGCwhi/5O5Ha2aKNaiy3C785QM/SN3T7UzY8CGCIsT4NyhfY+FV6aidLFkh
         0+ScO2LhfZdvq5RQ4upxTAS/ogl+2F1w17DJxncrvCMwXMbe1eTwtClDp/SFFq5AdzXr
         pQ/C+auoFYyRZVnz3+6typAnv/y2HzxB3fDulv/qzy8wh1jvOI8AL0QX75CJjbolDA5D
         m8vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ellie Reeves <ellierevves@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4.14 018/164] ARM64: dts: meson: reduce odroid-c2 eMMC maximum rate
Date: Sun, 22 Apr 2018 15:51:25 +0200
Message-Id: <20180422135136.136774559@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454822136270258?=
X-GMAIL-MSGID: =?utf-8?q?1598455379232921907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

commit c04ffa71ff491220cac28f55237c9aad379a8656 upstream.

Different modules maybe installed by the user on the eMMC connector
of the odroid-c2. While the red modules are working without an issue,
it seems some black modules (apparently Samsung based) are having
issue at 200MHz

While the tuning algorithm introduced in v4.14 enables high speed modes
on every other tested designs, it seems a problem remains for this
particular combination of board and eMMC module.

Lowering the maximum frequency of the eMMC on this board until we can
figure out a better solution.

Fixes: d341ca88eead ("mmc: meson-gx: rework tuning function")
Suggested-by: Ellie Reeves <ellierevves@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -276,7 +276,7 @@
 	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
-	max-frequency = <200000000>;
+	max-frequency = <100000000>;
 	non-removable;
 	disable-wp;
 	cap-mmc-highspeed;
