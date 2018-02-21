Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226lOyocrYN65eJA4Ffnm7XTWdSyjTDu0nm80UofcbX7wf87Z+o+bsi/3OQ6L/dlzscxoAVE
ARC-Seal: i=1; a=rsa-sha256; t=1519217992; cv=none;
        d=google.com; s=arc-20160816;
        b=EnGCGnNT/UgVV0iddhTnP2pBk+W0oNnlxwKb3TTl9ylA1t4BL4T5osLbYRyDIv+u3n
         f4R1xYACi0PNBVFU9tH8f0LKWtRtHFLiWplfdPvN8KSIT/TihAgqHEkL/2t5/vM7iye8
         HoSnYqwguJgEuIntLVWoFRV8Jq2YgMwv257rKPVIK96IBJtzvW+vDzcTe3nn+VYYvgJH
         /bw+bGgR2kMwMzDWRCn+OKyxBk5JRMw1fV4DXpK+BByMsJkyV33OonuHmwOtojY1DsiC
         5l+gobngoqQQIsHrrLCQz9h6AbX4ZhVzv3Pz4SU26Tkljj5zCz/XfAGdcWu8MTr63H6A
         UPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8pG28BDNIYkaf2sykl3PlJ1ChYOA4GUUy4FQN4Yhn5o=;
        b=XzmJMuTJ7s9FL3UBGqK0oNgrSCqCwNLuz28v7DbMgea8KCF1dtOyJW2l4pw0mJ/Rwb
         zq3bVqYIkNHUGGDlrTrrIQex8eQi9Ed5207YGwq3WwWTPKSCn8lZVcy4GpzdCW7ikLLm
         RadJ3X4tP9sLHQNCl9cOeTXwlW2CS3JylUALOoiiVzCPD2FVbS+n5/GvArU/JH7QIpxd
         UB4hZr0491tXo0HAv1FJgle0slVaKExDZ51CGG/h1BPQErZ5iLozvhoAQbrlGsJioBUR
         6Q45dkAuTmAF82Pg703YH3rKgT+UUh0wq50djsUhxuXvi1JCRqHvHN5x33FPJAaRc3TI
         vJTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.14 033/167] arm: spear13xx: Fix spics gpio controllers warning
Date: Wed, 21 Feb 2018 13:47:24 +0100
Message-Id: <20180221124526.418946181@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014666669772873?=
X-GMAIL-MSGID: =?utf-8?q?1593015525696044158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit f8975cb1b8a36d0839b6365235778dd9df1d04ca upstream.

This fixes the following warning by also sending the flags argument for
gpio controllers:

Property 'cs-gpios', cell 6 is not a phandle reference in
/ahb/apb/spi@e0100000

Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
Cc: stable@vger.kernel.org # v3.8+
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/spear1310-evb.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -349,7 +349,7 @@
 			spi0: spi@e0100000 {
 				status = "okay";
 				num-cs = <3>;
-				cs-gpios = <&gpio1 7 0>, <&spics 0>, <&spics 1>;
+				cs-gpios = <&gpio1 7 0>, <&spics 0 0>, <&spics 1 0>;
 
 				stmpe610@0 {
 					compatible = "st,stmpe610";
