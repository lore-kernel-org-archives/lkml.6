Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuuYXLe8hELfR+PCGJ5K5keTy16hqk+NIPbrfMbL2/YNzrMsZMfweOgbItF/HMiiC2ZnYVm
ARC-Seal: i=1; a=rsa-sha256; t=1521483497; cv=none;
        d=google.com; s=arc-20160816;
        b=xyzLXEOHxAmbaAZUxr7O0DppHxJdgHiw9zgxTWMvCCiGt7Wtq3W54BBUBy2SvILSDI
         tWClOcx/mDV2+/Qs+Y0iykVncvdMjo9/dMn5mi1Ecetln7ll5SdGWppOJwgGOQQMQQ76
         17rMfBHU9cUsKjgV8Ri9turcd17bqZaGl+yqFiYZaflbnF3fqe7Nr42ulhM3QsDHiGyH
         Q74U+YMnbRiV7qO1GsT8XF6uJin4gDLBvNgmnoo7HYoh8nGj/z0X8k4DbbLEqRteZ12S
         h/cz6wGsINtwUSGTND09MAwW/J4bLHfTy4ivZCYCjIllvrjeGvVjsGUsPtuU7zoWWgas
         SuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9g8Fx519fOmxbvHoy9kNCtU/TMrqtgziZOuvNEQ9hCQ=;
        b=F8OztCrek+ihwmmvDoDZYwWqoXmOzNJDKII3RnQ1yVGlwjc9g5nFo7GMz2qEs8yvQP
         RblacVSfN8BBZycyQgYhydFmjUa7KC8gNqqVqDT3BUij9CRHE0hXRhxSbj/cthcNStzj
         HkRJnph7faGnqvOlDC7xVcFVon8o/fviTOTip6ZCimqdpw6xKFefgCLiyR5AWMtcnuvI
         H9R3PdKNkhL/rFXSze/KR7iLV0zjO6chSxmqwJOkBhxOeeGzJkrTIJ+LrLi8/neSGBXM
         fHw5fN9/+j//6nYvSnZ19W05GtJB6eRp0jPueKo7lJMmu55Krb8J7Xd02Z1iwWdCScXS
         kYWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 011/241] ARM: dts: r8a7794: Remove unit-address and reg from integrated cache
Date: Mon, 19 Mar 2018 19:04:36 +0100
Message-Id: <20180319180751.642291047@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391079364461963?=
X-GMAIL-MSGID: =?utf-8?q?1595391079364461963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 65d0b7ed40f8a3a41a0ac5ed5ca4d1874c6aaf2d ]

The Cortex-A7 cache controller is an integrated controller, and thus the
device node representing it should not have a unit-addresses or reg
property.

Fixes: 34ea4b4a827b4ee7 ("ARM: dts: r8a7794: Fix W=1 dtc warnings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7794.dtsi |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -56,9 +56,8 @@
 			next-level-cache = <&L2_CA7>;
 		};
 
-		L2_CA7: cache-controller@0 {
+		L2_CA7: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			power-domains = <&sysc R8A7794_PD_CA7_SCU>;
 			cache-unified;
 			cache-level = <2>;
