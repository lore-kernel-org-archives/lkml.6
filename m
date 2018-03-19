Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvN6u9sNzF0k1DEk0vErDDBH+qQgI8RDCmjAfzwAPoQt4K2jWhx7cc+OfWdCUHaaKTMlOUg
ARC-Seal: i=1; a=rsa-sha256; t=1521483548; cv=none;
        d=google.com; s=arc-20160816;
        b=0ShBFpG32is9DUn4kYleIjnzPKmIRG55hCQI/KyY4300Gu8CxZZA/fQt9UrNqq3ZBA
         ek/O9UujSHHZUA6vQcDPX+d0B0G3iURKNm+WXZKa4OwMhHER5xM7xQOcPEKQx9EV15Ps
         AqWjwGtRRIUT01LyW3FJaxzmnI/Ox+nkJZN5netVQDXM2GYAjaFtiWqWHgvB+Gzxn0+y
         eFF+uzbBeFzP95HDdqUEZOJK2ha6L6WrlPhS1Ud0bywdms4htsxrJeAn28QHInsjVNvt
         gjHay2SbZriwouBkqETQla2aufG5E9auJo/nYVRuPVpVJfeyWTm9qTqTzteNOpqa/glu
         /RGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tZoJR/mSiDSLhPaqBX4KDAR2vBhcxRt1nB+3LeahnwI=;
        b=e8wQVUBzBmOFMm+juCR3T5Buz/8N20RepYY0NAeMI9AcZoHgP8Tqm9nkXbyuTsnRVu
         zdZpXx/aJaUaUSjeRcmjEN9QS+zlWuxru2IrFtGjRc8zl3NEx0X63UHqpZr18HALERQM
         lkqxEp9HNtoS0iBxNzQyOrxvvPSBgK/daq/wvCjOwXpyyfGIShCRFRcxPy34TSQURd4a
         7MC540D1WTWeg15Q2RMUBMU8fn8uiv7BggBAzxmBcCZEEZ1p4cHb7XIlXLRLyufl6lyA
         nL2I2CD/YMGbQeBG2iY+/AxqOpRZkGjSwtyBrzbkVrjD3Gs00YyLHRdVgEmdeBBGjoND
         lD+w==
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
Subject: [PATCH 4.9 009/241] ARM: dts: r8a7792: Remove unit-address and reg from integrated cache
Date: Mon, 19 Mar 2018 19:04:34 +0100
Message-Id: <20180319180751.560981724@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391134061617095?=
X-GMAIL-MSGID: =?utf-8?q?1595391134061617095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit a0504f0880c11da301dc2b5a5135bd02376e367e ]

The Cortex-A15 cache controller is an integrated controller, and thus
the device node representing it should not have a unit-addresses or reg
property.

Fixes: 7c4163aae3d8e5b9 ("ARM: dts: r8a7792: initial SoC device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7792.dtsi |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -58,9 +58,8 @@
 			next-level-cache = <&L2_CA15>;
 		};
 
-		L2_CA15: cache-controller@0 {
+		L2_CA15: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			cache-unified;
 			cache-level = <2>;
 			power-domains = <&sysc R8A7792_PD_CA15_SCU>;
