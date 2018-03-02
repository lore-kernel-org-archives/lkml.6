Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELunIVr/5Ji/gTS85/mWd2MC0wA1moVY9kq0ZPNkPFN7Nev4iihbQuglBzL/7+m9bN8qAt2n
ARC-Seal: i=1; a=rsa-sha256; t=1519981008; cv=none;
        d=google.com; s=arc-20160816;
        b=cUYhZKCQpDBMo67ujusho7plfA1g9LM8aLvsu23VUlVtGyuokcLuuT/LZY4qodr5g8
         XQdjr1NbRgqtK+X1VQePWg9RvVq0RniNR4bkd3Uw6/slcDuHf2R8APagAYlsPyq+abCM
         UqgzLgjOd768Ajn7jCkyMKZoRzN/wFZ1nbkc//kUWPGJjEK+JbGl5zADxdb29eyW3RvJ
         V5xz753MwlBSXryOqv4lkRn5gnTAAewm9buSUcX5U3l2PUk+2w2UjkVISslL5hcb5qVK
         8oMXjjKsERDyfrM/8k5DJ4bJ4ZI7HdA93OblzwlG5pVxAVT9gJWGbCogW8VbuQcCqEaG
         O9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d+KzfOp2yLJTv2t8g/Li1jIsK7qKvSVs8DlS+nPstMo=;
        b=gGQBA0RCgJDSXwIf/x8e4PVL44wmxCrGQHz5CI3nST4QEEE5Z7XncacL8U9EJbLRd9
         nz8C9s3je3119+nr6AZqk3WWyK0UVuTrJXJ5Sz8UyOWgeWNVj/5eoZ7eHmAKyR2WmsZS
         fRvNEKe4lEemqPbeSEk6cmrkqSw+DRI4WAcFTUwkiUMxIZIQBaNY5VQ+62V7ApsZaM6L
         jPYKH4iqwWBqNtl2FMwSD7Z9v/Lr/Xj6eumSS/K/VT8kzZuYfjerbNtEr+9s3kHgTPHj
         fEZu0niQdy8oEzbezTg1PPaupczbJ3kUbBnfmD8xCXlzhRPRhTCnLatNXZijM4LsTig2
         tDrw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 23/56] ARM: dts: ls1021a: fix incorrect clock references
Date: Fri,  2 Mar 2018 09:51:09 +0100
Message-Id: <20180302084450.773262714@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815442527336344?=
X-GMAIL-MSGID: =?utf-8?q?1593815605404811408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 506e8a912661c97b41adc8a286b875d01323ec45 ]

dtc warns about two 'clocks' properties that have an extraneous '1'
at the end:

arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Property 'clocks', cell 1 is not a phandle reference in /soc/i2c@2180000/mux@77/i2c@4/sgtl5000@2a
arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller@1400000 or bad phandle (referred from /soc/i2c@2180000/mux@77/i2c@4/sgtl5000@2a:clocks[1])
Property 'clocks', cell 1 is not a phandle reference in /soc/i2c@2190000/sgtl5000@a
arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller@1400000 or bad phandle (referred from /soc/i2c@2190000/sgtl5000@a:clocks[1])

The clocks that get referenced here are fixed-rate, so they do not
take any argument, and dtc interprets the next cell as a phandle, which
is invalid.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/ls1021a-qds.dts |    2 +-
 arch/arm/boot/dts/ls1021a-twr.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -215,7 +215,7 @@
 				reg = <0x2a>;
 				VDDA-supply = <&reg_3p3v>;
 				VDDIO-supply = <&reg_3p3v>;
-				clocks = <&sys_mclk 1>;
+				clocks = <&sys_mclk>;
 			};
 		};
 	};
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -187,7 +187,7 @@
 		reg = <0x0a>;
 		VDDA-supply = <&reg_3p3v>;
 		VDDIO-supply = <&reg_3p3v>;
-		clocks = <&sys_mclk 1>;
+		clocks = <&sys_mclk>;
 	};
 };
 
