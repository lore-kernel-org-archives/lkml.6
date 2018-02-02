Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224RlP03K5KsB3Gkh4t4Qrvb93N27RaeMizsIw/MqJAC+LUm692Hac41paOvGsPl24GCim08
ARC-Seal: i=1; a=rsa-sha256; t=1517591564; cv=none;
        d=google.com; s=arc-20160816;
        b=mgoPzb0BbRAqh5uCLynn6Awl/rUTfEpNuXDJvitKvK+hB9dwFriq/V3CzNdzFz4oVx
         wlG+jkaOMiz7eVgDrSPRkJaXDkYSChjy3ZO0aVmTZTdEv+FsCKzWyR3ajb/bh6X1dGLt
         GbjDctVl3AwQ2ascHEFwxNo6Hozozr/rhtnxdWPsIXOhspe289ACby6yVbhnBIhhOApD
         V/oMqbqRsEVm4aclI/q5eZ6IiVvmNO72b4OMRPEzYjmmcE7vEDG4Rh7HMf2sgpZkd1wm
         1UvDTU/fAp3nua4zqCHjGhMls/+Upd0DIUDV3STmXiSYj3ZBIg4BGX7apS/HM3Qk/oR8
         LJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AfpjDIA37vwHHY2odxTOqi17K6m0nVlTpHCVBgX8f70=;
        b=bEpdthf8eVrANoRllT170tIuMF6+hwx1TCbUXf5tarw7LfAlEAbp+j55D12dwHcloZ
         IE38EZzwpWm9WtA20+dXHq8fJgFP/eXOC9P6v0vvEqHn83Sw1bu2vlB5DR6wiEKoRd3L
         qUXPgDp3ZWD5suwtHodxz+kp9zUl+S2pJ0+i53yBA1F/Ebtqq95YJjzFP9qgk0x7hPHQ
         iyOWCdEL7ByGmRBf6EX8zaePpHgRpf7sMo/hap+iKr89M+zNt5MT3FODbShvD+Om4RlV
         Oj7VIPkdhYf4+TAAzf3hA7xYgiXqLgEvNgtIzJyumBmvkvmxVxSoga3fvwAaknZDauLO
         dWUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jon Mason <jon.mason@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 122/156] ARM: dts: NSP: Fix PPI interrupt types
Date: Fri,  2 Feb 2018 17:58:23 +0100
Message-Id: <20180202140845.697902239@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309648545488098?=
X-GMAIL-MSGID: =?utf-8?q?1591310091956093798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>


[ Upstream commit 5f1aa51c7a1eef1c5a60b8334e32c89904964245 ]

Booting a kernel results in the kernel warning us about the following
PPI interrupts configuration:
[    0.105127] smp: Bringing up secondary CPUs ...
[    0.110545] GIC: PPI11 is secure or misconfigured
[    0.110551] GIC: PPI13 is secure or misconfigured

Fix this by using the appropriate edge configuration for PPI11 and
PPI13, this is similar to what was fixed for Northstar (BCM5301X) in
commit 0e34079cd1f6 ("ARM: dts: BCM5301X: Correct GIC_PPI interrupt
flags").

Fixes: 7b2e987de207 ("ARM: NSP: add minimal Northstar Plus device tree")
Fixes: 1a9d53cabaf4 ("ARM: dts: NSP: Add TWD Support to DT")
Acked-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/bcm-nsp.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -85,7 +85,7 @@
 		timer@20200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x20200 0x100>;
-			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&periph_clk>;
 		};
 
@@ -93,7 +93,7 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x20600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_LEVEL_HIGH)>;
+						  IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&periph_clk>;
 		};
 
