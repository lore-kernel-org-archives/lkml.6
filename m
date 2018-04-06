Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/NqIrZfHfVSPuwVhnhGAr8kkZSl+2zvmK5kXd0AUtCtb60J6eXuPK7E5mAw2Jqz37PraTh
ARC-Seal: i=1; a=rsa-sha256; t=1523021353; cv=none;
        d=google.com; s=arc-20160816;
        b=l9RdQr1AUdGQMPcYGTS54grXdwVAP/Q/nBlVGjEnAtSxQpjPYWYBct6aZe6o/+H58u
         sFWTvBndrOll8DrRd0EAAacrctaAcHsPNyJ2ePHhukLmbEXZAKbdCdYF2eLEBehGgp+i
         4z7cnFkZT3yPeD03kPSAZ2EpNhkLB1oHC32sgSz3DTa/H5nwOT6Dvsfoe5yEWaaItVbS
         C4qf8VM2FZ64TZ56zChWqFJCnt62ono4Q3xP+zdVMYKp8Ac0oV13ZTUA4k+BWxc+WxdF
         X3ytqMmP2vFSgZD6FlXKM1aLqZ7cjCKgd64PkB1bvP7nZhY67rKBMvV50hkjzNeO9kqV
         uFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jMFExeydk5v9Bpdn4sI8/X9lH8a9EPoCr+iRUru5R4E=;
        b=EltLxC2RhhP2PChjrlv4r6HN5F3SQB114XbfG75R0bf/jYhZUx6hSEiu3xFU2UU/8o
         AAG3F/GV0eVpePj98O9bbz6xaozmI48V/CKEjj+9yJ7VqFU+EVPdATqv6sNVky+00dSr
         mCvsA4//9IHSiBhpOyi3P3UJ21PXX6uyfgklWb5HSy+idGEANDjLzeILLMlchvHEBLPQ
         49lNgqgu2xAjeT5sBQnn8OvY+akvoeKGFNBqYVeelkwohKEEB2sPLL7oSweVINKcS9Y5
         5aF9QgZ0LCG7jlKRw/ZzHhhbVf9zIfoqkkOkPJhZTiStHTTyCCiarPA/r/Lgug/e58ez
         pTDA==
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
Subject: [PATCH 3.18 89/93] ARM: dts: dra7: Add power hold and power controller properties to palmas
Date: Fri,  6 Apr 2018 15:23:58 +0200
Message-Id: <20180406084229.066190322@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003638265179776?=
X-GMAIL-MSGID: =?utf-8?q?1597003638265179776?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -182,6 +182,8 @@
 	tps659038: tps659038@58 {
 		compatible = "ti,tps659038";
 		reg = <0x58>;
+		ti,palmas-override-powerhold;
+		ti,system-power-controller;
 
 		tps659038_pmic {
 			compatible = "ti,tps659038-pmic";
