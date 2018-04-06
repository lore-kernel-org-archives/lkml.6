Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/+V+QbzsxrHimmAx/BQxPucUJYpgoOb1Nv4Ytc8nqF3yCT37oRSwSK6h5aRLgT+XT5E0AF
ARC-Seal: i=1; a=rsa-sha256; t=1523021788; cv=none;
        d=google.com; s=arc-20160816;
        b=Pea2UNg+m2ciVD0VgLhiToNkzZ6MO3vwOz3/oIZTzTegb2Rs49yIcgTQCSjYmG1RnE
         Ul7n/IfS4nNdTlzVNN1K6mbKy0QUNM33KBThBJL8YgyHh0NJlZflq+Ffsh0+df/ywTUK
         U5nrgFnKtcqgTkLSKmFGKnpkQMdT2syidQoFsRRVwkRWYrcHbuuZ3SyV8tJrjC1Ck4C+
         gkpS/eOTS9CAt00CH1Ix4u5kZIotXotT2FqHS6hheW6rIiK8HRc3rrrToX6W2Gy5AlbH
         yCAcaJtg3WaVMOZLt17wSkkp1sPvsonNzlRtBid1GKL0OMNHnG7rzLqoQhwVfeeeOreX
         ExqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cwK5VZC6vYAoTLPbUSemviAKrFRX2h14NEDRIKjnZdo=;
        b=XHGgS6ULF2pSpIWL14S0GRkhddpGeqtUwDSMh4JY8TGH22ForflsVhFUzDOEeFKvua
         bwnGR/ziKJPxhQTwo2hX2UuJCdAPruWHXRq9WGd1zuU+vwO0ko47Tt0gckQioZfIrA/B
         Zo37CkLo7iMQJcsKJOEtOcoE7yUIQVG/u26PDod9XiZAN8t368nJxtbzi4AuNmohka6H
         iwreU39vQV6OG2IDdk3MRLtkTER2LaeFZqnb4Qxdjs5SNt6VYHc849mC/aLi3HUXaGuh
         u7u+hZKCh8wk5D8ErpeK+QMAmIepVXlsuB5rXfUO4Vp0dnbmDEbwu+hD9QRRYO7hDowL
         JxQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Keerthy <j-keerthy@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 091/102] ARM: dts: dra7: Add power hold and power controller properties to palmas
Date: Fri,  6 Apr 2018 15:24:12 +0200
Message-Id: <20180406084344.305717777@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003638265179776?=
X-GMAIL-MSGID: =?utf-8?q?1597004094810606485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keerthy <j-keerthy@ti.com>

commit 7c62de5f3fc92291decc0dac5f36949bdc3fb575 upstream.

Add power hold and power controller properties to palmas node.
This is needed to shutdown pmic correctly on boards with
powerhold set.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/dra7-evm.dts |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -398,6 +398,8 @@
 	tps659038: tps659038@58 {
 		compatible = "ti,tps659038";
 		reg = <0x58>;
+		ti,palmas-override-powerhold;
+		ti,system-power-controller;
 
 		tps659038_pmic {
 			compatible = "ti,tps659038-pmic";
