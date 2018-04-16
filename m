Return-Path: <michel.pollet@bp.renesas.com>
X-Google-Smtp-Source: AIpwx49ZDhKVIfvuD+sIRMZFR1Fx8vrnKMwptjrrAWONWfsRGEg1Fs9T2NYGpGbKXr0YWxgODp97
ARC-Seal: i=1; a=rsa-sha256; t=1523871583; cv=none;
        d=google.com; s=arc-20160816;
        b=VsS7c3HnZtIPW4PxqE9x58tikVmEx0Ke7G9iilFHZAL9KLBfdlL9iCNT+gVlSoMrb+
         mnMzfh7N+lx4XLeTJxF4RLXbdCr7aCgk2DmdopcRCbl0eRfpr4NyohCmwSeU6012XG2p
         AG+SNo/u8kph28LdpCnGFdf6wcEemFI+ImiSXgPnlSfwHDpAX+u4KAPOG3xhC3Ub8nji
         ANu0bAFHE/AyabIsOld2cD35SzgfVFIWBxwNGsKC+noZahAHiZc9NfVwDBTNFyJ8kjnY
         irst/oabmLHDM9605tsdo6Umwz0qR0/Y+RYNbs+iSQ+MP44BzEgQuYeU2a0TmyGuoK6i
         aAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=JwMnCJQHVy9RzvDEDWPrSH3kdKyOrCGun3nqjLowEPY=;
        b=Oka2B1eI5LuWp22uA7cP48vdZekFAeYeH/y7XodV72bbEarR7/NzbNTXkl3wC2eFvh
         XTAl9Z3Oa0sYu5fLu5QMDMmR8GAVybgMGXHz42cTEIVYeOXetzmC0mPckXJjgD1mZv+/
         e0SJxmABFn5Hyc0AMGcXnHXidMghjLHniQQIkOCtmfhBYKOiIvEKFg1BsCwUD2aJKaje
         gV/o/lRj5cF0ymOrsQHjU/K+iifXDTGvH9HKIKFJO0abpEfxPfUJJ3xHPpqPCpfowZAe
         fhCUP+TxhFadBvJcVgEGCn4etgiOs9zpeoTp/37mPzyMYjQWzOgKLTYAE1Ai2oUuL0J6
         TWTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of michel.pollet@bp.renesas.com designates 210.160.252.173 as permitted sender) smtp.mailfrom=michel.pollet@bp.renesas.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of michel.pollet@bp.renesas.com designates 210.160.252.173 as permitted sender) smtp.mailfrom=michel.pollet@bp.renesas.com
X-IronPort-AV: E=Sophos;i="5.48,459,1517842800";
   d="scan'208";a="278331327"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com,
	buserror+upstream@gmail.com,
	Michel Pollet <michel.pollet@bp.renesas.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Rajendra Nayak <rnayak@codeaurora.org>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Juri Lelli <juri.lelli@arm.com>,
	Frank Rowand <frank.rowand@sony.com>,
	Carlo Caione <carlo@endlessm.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC 0/3] Renesas RZ/N1D SMP enabler
Date: Mon, 16 Apr 2018 10:34:55 +0100
Message-Id: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597895169505919827?=
X-GMAIL-MSGID: =?utf-8?q?1597895169505919827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

*Warning -- this requires the base RZ/N1 support patches already posted *

This is a tentative patch series for enabling the second CA7 of the RZ/N1D.
It's based on a spin_table method, and it reuses the same binding property
as that driver.

One question is: Do i have to document it separately, or is it sufficiently
clear?

Michel Pollet (3):
  dt-bindings: cpu: Add Renesas RZ/N1D SMP enable method.
  ARM: dts: Renesas RZ/N1D SMP enable method
  arm: shmobile: Add the RZ/N1D SMP enabler driver.

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/r9a06g032.dtsi               |  2 +
 arch/arm/mach-shmobile/Makefile                |  1 +
 arch/arm/mach-shmobile/smp-r9a06g032.c         | 87 ++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c

-- 
2.7.4
