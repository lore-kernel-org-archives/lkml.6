Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519025076; cv=none;
        d=google.com; s=arc-20160816;
        b=df2pyPdyUcWgveH3K1qAKhD80m80H4WH12+eR3lgqYgdmV7XDWgNlhdLOjko865Fl0
         QUiLNo6jz61LYLTN1XIvacXtjucpaIrva9V2spDDEFp7owU57hHkFC30uX1lmE+/2AHe
         QhbwXuCVsVpmOwyZMCLPhbfcI+3dU6NwAI1SHmeQ5zgd/PvcV3gz6ozumeeXr/m8rrYd
         C56KrUTgUZsFMvKiyDQjhc6XZYCL0EpPWL/s9Edm54h1OWqLKWL6qxMgrSJl2IO58DiX
         Qo0WSRrZGIXpw9X6+kQqlNiWBrSmdMFzVS9ZHx2AumcV5Sr0/DpfxBGR08yX7qc7U4FP
         7wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=fn+wXaUNvCXH16FVRPi+EMYio95eCRXfuLIEpfxjqGw=;
        b=NBTIuT9ON+C5rxtIzFwDnpGTXzUGJ9wZmZBtiMi8ts+cUOL+E15gZeI1KwVlIs7Nro
         GW4HHE5lYRY8iur/uZuABL+MRd88uuPogZN5IHr9cLgU2xUPkX766/GZN3Few/5gD4MF
         Rad6VD8hZNbgQYBS2VH96Id46dAm7ATiI/UwNzCFVTLZM4trgTHbtcw34f7FrKncEHIN
         qmCnDXQ53aGdHRMsmv2f8xgOnemV/UkRB+NbnHCwgxglPaHxRjB1Lq2lJxPZlhw47lXI
         Te2c33zUWjvc3GQHDdcf1E6jzLiVjxpA5ekQ1cBIuCJRX9dspNaWvvKfqkVAzSzdosw0
         1ZgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OCpMfFKU;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OCpMfFKU;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x225mCAsnV81FVGV2cirlLkmxjhoMenM6AS+BUk162H04p3RZbyd4f9VrZEdap5G8kuQ9yrHAkg==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Lee Jones <lee.jones@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>,
	Cyril Bur <cyrilbur@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Lei YU <mine260309@gmail.com>
Subject: [PATCH v2 0/3] misc: aspeed-lpc-ctrl fixes
Date: Mon, 19 Feb 2018 17:54:19 +1030
Message-Id: <20180219072422.22733-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592813238968192518?=
X-GMAIL-MSGID: =?utf-8?q?1592813238968192518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Once Andrew has acked the bindings I think this is ready to go.

v2: Fix binding layout and add Rob's ack

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

 .../devicetree/bindings/mfd/aspeed-lpc.txt         | 41 ++++++++++++++++++++
 drivers/misc/aspeed-lpc-ctrl.c                     | 44 +++++++++++++++++++---
 2 files changed, 80 insertions(+), 5 deletions(-)

-- 
2.15.1
