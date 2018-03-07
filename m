Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuBcJZet0c9eOsgxZBd6zgfFoFYYaWbQ4kDbYns+fHMSv5LzDviO203t3mC9shadobmwvOW
ARC-Seal: i=1; a=rsa-sha256; t=1520451869; cv=none;
        d=google.com; s=arc-20160816;
        b=KHrpFT/+UO6ngwNAzWmXGPLtMQZVXdw0aAvwqM2jbNWMoBV4EM1Iwko3ALdr/fjPlU
         jVqtnX0qr0ReOzzz/XrHmVs+0LNi4Ayc5pxO4ytqzc4Ua/QiOrUiiGVl//UsUyB4JfNk
         /1WTMPHBoARuoP5qdIOBzHkfNtppD9L7PoG6RxCXqerfknBK9rTcPYWo2sRukXxgtFj/
         fvFxx/zkdTFaAiU6gioxWkEXpgcurL0g55CgstJ9uykcauC5z9Jd//hk5xBxbfI8j7IV
         sDRH9Zuk3/BThrZ7SSnL3pZcPfR3NywgfWun3TrOEXiyTjbVZ9tZr4JZ9KCXdWI0JoKH
         grlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Zr17cgz5iC8bGwnAuURhRSM5S58dPBB0v9/4TZywsuQ=;
        b=lqTe3vrijj5PO3E3FSsrSr4flBD1NndyUue4KVduQDc9KLD8nzAMhVPieAwMiLiNVr
         T4DYbX2IpvkEY6sKIBeWu3Ed0dS7mecwcrExcCGC6bTjXoGNb7HaIvYp136xQUUV8mz3
         5uW1SHOVmmVSBmU2xI3ohbtNV0MWjS3wappDFJY07fn8C+NMkTPpehBv2UBDbI4kcQHH
         LqljNeBfqtl5+0I/BfidJEfDSgyMTAlMY/SZkxSp63m2Vc6Ld+qAx4Eh0KXp94Ir3ger
         8vu5iWgyAQ8bU7Pz2MwlXAe+Vjl0eEd1b38yOj3UGBqvw+LltUR32mm4oL0wQ4Mm2XFG
         SdeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Schultz <d.schultz@phytec.de>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.15 108/122] ARM: dts: rockchip: Remove 1.8 GHz operation point from phycore som
Date: Wed,  7 Mar 2018 11:38:40 -0800
Message-Id: <20180307191745.198396494@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309339325517996?=
X-GMAIL-MSGID: =?utf-8?q?1594309339325517996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Schultz <d.schultz@phytec.de>

commit 5ce0bad4ccd04c8a989e94d3c89e4e796ac22e48 upstream.

Rockchip recommends to run the CPU cores only with operations points of
1.6 GHz or lower.

Removed the cpu0 node with too high operation points and use the default
values instead.

Fixes: 903d31e34628 ("ARM: dts: rockchip: Add support for phyCORE-RK3288 SoM")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/rk3288-phycore-som.dtsi |   20 --------------------
 1 file changed, 20 deletions(-)

--- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
@@ -110,26 +110,6 @@
 	};
 };
 
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-	operating-points = <
-		/* KHz    uV */
-		1800000	1400000
-		1608000	1350000
-		1512000 1300000
-		1416000 1200000
-		1200000 1100000
-		1008000 1050000
-		 816000 1000000
-		 696000  950000
-		 600000  900000
-		 408000  900000
-		 312000  900000
-		 216000  900000
-		 126000  900000
-	>;
-};
-
 &emmc {
 	status = "okay";
 	bus-width = <8>;
