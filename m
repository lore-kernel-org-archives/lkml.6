Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AIpwx49S571MONAT6szL9sSplBG8NjV2pm92mYPCQ/XWVFf+6Ochb22xKtGKB2PRdWE0YjsLpXx5
ARC-Seal: i=1; a=rsa-sha256; t=1523366515; cv=none;
        d=google.com; s=arc-20160816;
        b=NN94VzN2a/lJ9/f7JW4w9YcSLViUM/e2FQim8Y06R+dq+/uErKrpAddKYCSvnVAKyS
         UBBGs66i9UJELDuQ8mvQf+SLrl1f/OqWu0rLivTMQcHTSvIdZEEeM9oQLmN0PaRgachF
         4bsDv+QEFIyvbvqnVwnKLzPs+LRnf0BU91hWPyU2vgzuz6e8+d1gkjvTa/EOOc7XRx9L
         3nhDHhC4GbNl8yq2fz2uQMdl5Jz0k6bLB5TUWJzEDaqd2+ZBFkOFdvsdtKzkOMG8G4Q0
         ntHtJ+2UTrOpQMQCm79cnI5xfof/wy/VaqKUaze/Z2aiMTcT4YKjdHQOhLHcIA/T+RVF
         p5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Rbwjun/hwkbq2k5N9x3Wws82bJjfMZrU05+p81FdV4I=;
        b=JtKtCQlcuvfRb6ZlrN2RF5wDOMf1Dn1JItk+97oWZ4x5rUkWNJkzyxvwKBSv6zXeJI
         srhHDFGgEtc2zsvdAQ/nQA0/BHofyeji9F5ldC/G1wiokhntVU+td9I4isId4KNOm99m
         2e6YYeBX7DioscVMf7IstRDFW8Zw+Vj9wzBw3xb+RTslbX5oJcGPCGrYLOXLFY03HpGX
         8cv+1zqoNSLM77qBSegl2uj2/YdV52iGFQyslF4tslCMsmamICcUZwciF/MnbwQQHEo7
         x/vUSsE3VxPngV3/iW5eup5YiY4t+0uruAUA3gZXPhsc6EZ5PZH/XUbYhv7opf5NMLdG
         pKvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/4]  ARM: amba: driver_override improvements and fixes
Date: Tue, 10 Apr 2018 15:21:42 +0200
Message-Id: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365567140567705?=
X-GMAIL-MSGID: =?utf-8?q?1597365567140567705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

	Hi Greg,

This patch series contains improvements to driver_override handling in
the AMBA bus driver, including two bugfixes that are based on similar
fixes for the PCI and platform buses, and which Todd Kjos would like to
get into the android common branches to fix possible double free.

Changes compared to v1:
  - RMK stepped down as amba maintainer.

Thanks!

Geert Uytterhoeven (4):
  ARM: amba: Make driver_override output consistent with other buses
  ARM: amba: Fix race condition with driver_override
  ARM: amba: Don't read past the end of sysfs "driver_override" buffer
  ARM: amba: Fix wrong indentation in driver_override_store()

 drivers/amba/bus.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
