Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518419337; cv=none;
        d=google.com; s=arc-20160816;
        b=wDaySqyCfE9Le1Ho2UATAKtfMgYthwkf0Zs5qISq8SBBoqHuHfhnBjxo7fbci4aPqu
         YaRHtlwHuc9C5Gc/jAklpyfK7gEKDFDAzF3qT8ojQUKjJG5u4ZdL+ZGG1tdaZFzzqfZu
         hOVncJZKY5OBM4iNuOI8b88JZmHWMusPsemzwspg9TsWzbTl5DwesK50L4JOipr3V47M
         /zvfEuRd9L/X379BSZDbhjZEzKdbIYE5QsBpSgW/AfdxExmD9sGZXksA9vJA9MSsYk0b
         9OHCk6hUizIhd6pwUP2DGWwlHdAj2lhTcYys6T8A6ne6agjE1w4Bo7UoKeRdUvtIE1vR
         QtZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=8YHTC/TJz/aDJnqT7j+3W3CeiJY5mlUg5jarll5BsFQ=;
        b=LhbR2zR/89fFUUITqWFX+J9E1ZAVeuXc7VeXoTHup44+hdK+5q6dW8GEj4aj4MtKNw
         4QO1pqaM1rdMwNleEFVuap0VqZab8VIWldhGBtrlhnv3ApangVLg1oSna1V8j1RhoiTT
         D2VvsBOAtMM77yddvSI7n6Ho7NRX23uw+BEuRMUs3h9JqaN2HkPY6AB5DBfMBOhxllwW
         ZKIkQtAwLqomxB/XyUH6S2S4oX2hqgr35cbmlk9S04BLwfOGNkosdYKb9MDqdJIYTGhB
         T6u7BIdZkDz5Hsiy/OXNeA+IWVVTwhaqAiINg2PwKY9HVGyA3tDVrSHPo3ONWMHD6uvz
         VYxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gYufp9jz;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gYufp9jz;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x225VkarY8NM3gOhXWyiTgVN0KrADJO44eAPfB4LYTP7q0p9nPIzcnvEZlSJRg3YoC14LzmfJgA==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Lee Jones <lee.jones@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>,
	Cyril Bur <cyrilbur@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Lei YU <mine260309@gmail.com>
Subject: [PATCH 0/3] misc: aspeed-lpc-ctrl fixes
Date: Mon, 12 Feb 2018 17:38:44 +1030
Message-Id: <20180212070847.32387-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178074769314227?=
X-GMAIL-MSGID: =?utf-8?q?1592178074769314227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These patches were developed when testing upstream Linux with OpenBMC on
Romulus. We need to ensure the LPC clock is enabled, now that the clock
driver turns off any unused clocks. We also need to enable the LPC
firmware cycles bit as we do not intend to upstream any mach-aspeed
hacks.

There was no existing binding document for the LPC host interface
controller, so I wrote one that includes the required clock description.

Joel Stanley (3):
  dt-bindings: aspeed-lpc: Document LPC Host Interface Controller
  misc: aspeed-lpc: Request and enable LPC clock
  misc: aspeed-lpc-ctrl: Enable FWH and A2H bridge cycles

 .../devicetree/bindings/mfd/aspeed-lpc.txt         | 40 ++++++++++++++++++++
 drivers/misc/aspeed-lpc-ctrl.c                     | 44 +++++++++++++++++++---
 2 files changed, 79 insertions(+), 5 deletions(-)

-- 
2.15.1
