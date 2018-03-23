Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELshfcXwfU4sEzUiD7iIEJrXr3eny8TzYrsijWgjpQ+u1U9cydmcfCKyAcIKFQlb67nDSQ/b
ARC-Seal: i=1; a=rsa-sha256; t=1521800158; cv=none;
        d=google.com; s=arc-20160816;
        b=OoaW9bnhmDfr5P15K2HlsnCFYZXcYo3wg1gR5flcu0l4IZvgoigjKgkCrOR3zrOKC/
         ETDMeiDuV3XaZ310wTOq3dLIbxb5kenq+C2+bsy92uyGK8Wf73NjeMSqy8hTTeBq4TAZ
         OWH3FJ4rtzBLR4PuD/vPG4WlKsdeODUBBx7T2WK2FhhlPZxLyXTwynUwyBj3oN3Npskw
         3yGb/bZmfmLV3Fl348EIc9w80YQp+lo3xDMtQpxxlHjgIo/bHLCMZK5DIgOdQHK2J3mp
         /EEw+/TQu5+6LFTs4zi4NF50UO7YnaqVtV/Rkx6VXC1vz3if8h2DfC25AoXQ0uEtflrF
         0T7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=I+SJ8UOrn9sFA/AIaUEExHUMr1poAMZE8mPdHei18Xg=;
        b=znZCKf5q6hCMopAiKVU6DgiOiN4HkWwcTSiDSHuPIXymPpVBKE+UckTyz4LUvX4vQu
         IPuqx8zUY/R6MCSEf+WHkdz7FwI2hO51ej5xbv7AWqhEJxqI4JMZWWB8VhklLVAgemn8
         PIunYg895Aoy/GPL2MEaUjvdAK3yILdLzymBbgU9qzoja3pC2LqFvwkop0Nv+EkV3zMv
         2VQHBrtmx5wMlFk2Auw58NlHEBMfAcrYDC0yHvTdSLI791w6JJR3N5IY+T18qIMpP5j4
         3hKg4fvK6BkO3N+gBV9fM58/AT5Isy8q8JtN44/u9yfVrRrxr7XlIud01RAKRvCRgS96
         9fnQ==
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
Subject: [PATCH 4.4 56/97] ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
Date: Fri, 23 Mar 2018 10:54:43 +0100
Message-Id: <20180323094200.787374788@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722687748983513?=
X-GMAIL-MSGID: =?utf-8?q?1595723122310679272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
