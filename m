Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv/WB2txt9MRQ9uS3suoS3KBCUvsM+9l8LU0IK1wSqhUQ88VZ+gNZlLJPdsM2LgYpAnv4ee
ARC-Seal: i=1; a=rsa-sha256; t=1521800324; cv=none;
        d=google.com; s=arc-20160816;
        b=B0xA+s4NVNWfx/6PCicYR61Occeoz5AA3blPZXN2cFoEb9LFQVdZPmZ0ry2FtwWj7x
         WNzdOnS5tgsAViEciC74iyDnJyiVuFfKlRlupIcjnxQod1X4F9fBOavhrHdB8KT7ffvt
         zZkQNGfi7ggjQLWos/5oQbwlkfYQvWfmyk7ZsSrKWGpzx8b4REglomyw04R6m4ohz9Wo
         j9u/qZn8jpQagv3bpQKHzTMvUUMLoiy4FfkCDCrwU2RcsQUW55KyRZ6pEmXfQHdjLQ8J
         xyg7DOX2M9+4dTC4E+p733r5XhyiNg165fk0U1lfzpg9sPLyTmTHXHIRLnR1C1pZj0Sv
         QLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RUTaNurPMc+IznNqKzThTkIBzwK2G0tCecARXrMfeaE=;
        b=BlLMF+yViYCLnxOpKcmsNE86Plrh5wkw1UskbuZQvleTYgpprly06crauuNBBdP/ly
         i7aCjFf4dNS6JEylQdPxI50Uyciy+jfPoqidsY8ryQMvPYGJQNg+5w9U6WBBIikG842R
         +0T54fKNTzF5sEW2RhK5sNWEAbZZgfr9Dlt+yiJsGMXa6JmOwF3ADUIeaUkJ1xCLhRRq
         krvj1xLk4KANvJDScCviiRLcqwBnfEGcR8DeE3gcvPJdNKongZ37ydimdR2PAWcZJSj/
         OjsklF3PiMbmxpcRexiApxTTMuGYu6dTzk1r33wxruRs7YNkV4LDe8dvdoePNWmg7xGR
         dq5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 28/47] ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
Date: Fri, 23 Mar 2018 10:55:19 +0100
Message-Id: <20180323094249.325117794@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722687748983513?=
X-GMAIL-MSGID: =?utf-8?q?1595723297454403813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kishon Vijay Abraham I <kishon@ti.com>


[ Upstream commit 2c949ce38f4e81d7487f165fa3b8f77d74a2a6c4 ]

The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should be
set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO in RC
mode. However in EP mode, the host system is not able to access the
MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/clockdomains7xx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -524,7 +524,7 @@ static struct clockdomain pcie_7xx_clkdm
 	.dep_bit	  = DRA7XX_PCIE_STATDEP_SHIFT,
 	.wkdep_srcs	  = pcie_wkup_sleep_deps,
 	.sleepdep_srcs	  = pcie_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain atl_7xx_clkdm = {
