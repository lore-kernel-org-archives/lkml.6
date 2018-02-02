Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22401NAm3VE1fIhuonug4lAiGwoLV5frJjX3wvuDolTF49irRyWglqSQegl0mst93DTBzP7d
ARC-Seal: i=1; a=rsa-sha256; t=1517591067; cv=none;
        d=google.com; s=arc-20160816;
        b=IrQxriGJmacCXYpPHUIFv6WvCj7AIN6gk58g2l9qCR7Do5wtVc93PI6CC363Rfkgfx
         pdSTz1VvaMfJrOxL16gX6xEgddEVeLFXCQxbRSxx3IqSirLu+IBZqf0Zn1wi6Byn+iKj
         7AzORqyLuiztSyk5Plihdx0Hka169RHL0YqKLdU2sMc7VJLyg+Opnw97R5vzFhXLYtyT
         SZe9tW3RFkofZvFXO3GancyqY0waR6zDxHRO18I5xde6KDU2I2dqD3aeqoEN/haxiKL+
         K8adp1tvaG/Sx+PZjJjBfXUY3kvkJXl1LxkTDaDGeU1kx5fP7/ECnUbTSe+2QRyMhNdd
         kQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tYSE9x/aRF/N9HBM9XG9Hy26GoTTOTGE+as3p+Op2WM=;
        b=EvAhCsJ/G8PxSbZuvngEy6E7Oom1lEPgWB3u/sLV79CnlmtHXffwkeResXp1Yzslqi
         HALKjjQP5Dc+Aj01x3pkBR5GBjQoHUnfpJkVYO6XZnl4I8/phNKqe3zJYT/GfcLDW+Ju
         apjZEerYBDiFGdn459ZsvLJavu9WRByAPryYrospU6V7JhNjzua2TKzTemi8mjJAIoUh
         EROAcplSnVtCHgmurDdxuysY5n9hV2UxoBgsMfthNhnQTnCamwH6nUYjJMYSiq4GAeNA
         xOgbMiJo/Ri/JTL+1eyNl3HNHRtOw01dPvy7QjyLYY4DaWRI6QBKQWCpD3vDl5u8eoqb
         cEfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Meyer <thomas@m3y3r.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 40/86] auxdisplay: img-ascii-lcd: Only build on archs that have IOMEM
Date: Fri,  2 Feb 2018 17:58:00 +0100
Message-Id: <20180202140826.081448104@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309570942204976?=
X-GMAIL-MSGID: =?utf-8?q?1591309570942204976?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Meyer <thomas@m3y3r.de>


[ Upstream commit 141cbfba1d0502006463aa80f57c64086226af1a ]

This avoids the MODPOST error:

  ERROR: "devm_ioremap_resource" [drivers/auxdisplay/img-ascii-lcd.ko] undefined!

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/auxdisplay/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -121,6 +121,7 @@ config CFAG12864B_RATE
 
 config IMG_ASCII_LCD
 	tristate "Imagination Technologies ASCII LCD Display"
+	depends on HAS_IOMEM
 	default y if MIPS_MALTA || MIPS_SEAD3
 	select SYSCON
 	help
