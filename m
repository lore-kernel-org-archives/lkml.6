Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/bdKnuH2Vzr3dNjXLjJbQlUQ/WgSuAWMinIwHExuq84fpPOnHLPitRkHEYCGOf+WP7x88B
ARC-Seal: i=1; a=rsa-sha256; t=1523021501; cv=none;
        d=google.com; s=arc-20160816;
        b=hEp544WfAiptN1Nv8SD93kxqjbbmBMQZdY/cZBcWk2HlOayMiskMwDhKy4YT1QDYuc
         rKLMUAZzGqUnZ5EdhzmkGOjtx6JwWmcUc95ErTfvdX5RhH0sDQTG2os4rbOONF1vDcg6
         40JciQEFow8zNX5RjmA6nYuLlMNs9p9fEAGcAf0QH7easmFo9WwWz4zcH3tfSRIJWM2Z
         R0lkI9NUl9Va0hhcK0WODuSbx6jQu7O1SjX/lxNbEiaLBywkjaXFZ/PWJRj9xmiuwlQy
         zGEdAK0Ftn/X4KRkJUTxnB7THn2g2m1WymYwNOahFRnU+MdX1mU7SRINTFCwnVNihpvN
         vepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iUYchiO3gvDED5Bqdu6CCtpELBIhOrzD+2eveuYNBPQ=;
        b=L2Lu4y1oostlHaixuMfWwEi90JTx4rAffmaJNjtRvjPnAPLsO0fPPzxM0SbDL4/UXE
         RXxzXPFDWEJIiqfKL17Ib/sziqpuriJv4810j1igcPOY/uc5DBPrzD6Ag5+Ic0M3WuPj
         liQjjxCC/fitlriuhhw3yWUx1brRFQQAkNWBnmH1nd88Q8KpDk+y0hxYPbtdirBrxqBD
         dwLrY9GmxHhtFCbhKH5SOjVfkRDeVefTh2eRVo8QzLOHMIxgGRgIQ0YGSZjXnAbgkNgL
         ZIonm1En3KMpU/eLRnI+rT34uEmem5+gFpDiEhy6pJl3R6hEu+Q3Y3ba00WRcAUivnDu
         R8WQ==
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
Subject: [PATCH 4.4 60/72] ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property
Date: Fri,  6 Apr 2018 15:24:01 +0200
Message-Id: <20180406084310.392890129@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003794128655610?=
X-GMAIL-MSGID: =?utf-8?q?1597003794128655610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keerthy <j-keerthy@ti.com>

commit 1f166499ce006b3770a3166122eda64e160736ab upstream.

The PMICs have POWERHOLD set by default which prevents PMIC shutdown
even on DEV_CTRL On bit set to 0 as the Powerhold has higher priority.
So to enable pmic power off this property lets one over ride the default
value and enable pmic power off.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -411,6 +411,7 @@
 		interrupt-controller;
 
 		ti,system-power-controller;
+		ti,palmas-override-powerhold;
 
 		tps659038_pmic {
 			compatible = "ti,tps659038-pmic";
