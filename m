Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+TPuoKpcbaAAcbPMOYjuFxnanH1yDfaoeq1FHZqq2rWERii44wpdgEuJwOhdUtzH/66//z
ARC-Seal: i=1; a=rsa-sha256; t=1523021499; cv=none;
        d=google.com; s=arc-20160816;
        b=qcWDXoeWlOjo1emV8P7AsZvqsrwzhyU3sWVHy5iWGar5h889MSXcMdnsw8cUaqS037
         +vlpL8H0KynvDrOJof40aWNDVA03biaOjvrbSYMy3uoAty+ahLr8yncY/qDQEJaLR8WU
         awD+SwMQpWpoQXArUE1ltgx4RiOM8QpVvfBogXQZ3auD0ecSuZKiiUjXudmzs+G3aFq2
         pZmC4FGU9Z5ZecqhjHcTniapPoySa5whv1d2foHob1tIr+jwGlLjGJlDt23fnQf9RJ0s
         AHfosPdpvFoOPPF36zxIjU6x9jnuv8vc6KS/nTISpyDq+bqWAryLOfPRzDpu1xhHvRcp
         cgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yipzZkVLafB/kqs1Wjx4l1uLktJNuVZo5jkTOjPeE9Q=;
        b=QHwf4Rl6SP3ybcodfaHNg7h5ANlv2Jgfuq/wNEFlXvy4t1H117+Gp56rBADlMYY3XD
         Zmt5Qdic4JnzxlohKLusu9zi8MiquSQCb0f8/bVZf9E21mOqg80kNrs83Pjq9R7vJtRi
         pHQAbfn1pn+P6+oXYEAEndXl2xVDTGoszzMcMkEsHeeE0QA7CG6bw+TRoz6HTFg/ljkI
         aoLA3Ssa9+tlXmI4aPMYCEv+3017hb/V6t3F9hLSyzERGN/h+/+CJ+JP42KmNsAyrigX
         MdLZcelQm2yJPEQY+29oJwsQBwG/38TpJ61x/DNXgRLMTb/omCrtD+CU4ng7IhszxzHl
         eNcw==
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
Subject: [PATCH 4.4 59/72] ARM: dts: dra7: Add power hold and power controller properties to palmas
Date: Fri,  6 Apr 2018 15:24:00 +0200
Message-Id: <20180406084310.302233873@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003638265179776?=
X-GMAIL-MSGID: =?utf-8?q?1597003791543896941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -410,6 +410,8 @@
 	tps659038: tps659038@58 {
 		compatible = "ti,tps659038";
 		reg = <0x58>;
+		ti,palmas-override-powerhold;
+		ti,system-power-controller;
 
 		tps659038_pmic {
 			compatible = "ti,tps659038-pmic";
