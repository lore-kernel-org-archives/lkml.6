Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELude+bgTcwJi/jd/zmpYmk7prIg+YKtxPZck4JDkOeFTs6dXEufZoLmg0oGgRx4WxFrp1Lr
ARC-Seal: i=1; a=rsa-sha256; t=1521483677; cv=none;
        d=google.com; s=arc-20160816;
        b=xkmeJ9/7Nz+wxWniMYmAyerURK94f5ijA+Tq7ezWbBeQY7ZcEdTbbb7h9xhwFJ0i01
         eXnNuvSQiEHCvlOq5nWFpNWPKKCyE+hoVIU4vrP5jLjx9sUz87aaZXJPqz4zrA6fjYD0
         v6Aznf9SlFRwMW1pH6Ifm+hYpRCVwXyiECfss1F0qWWhgloCd5ThKhQv+R37L7dKojhM
         CGLRYbDNU4Of8B+2JVBzHUMQL74yhS0dzKKWJxlNEkgGgjjkfX89raQmWKg4I5JEKYQ9
         FSOmab0aLWOujR41H0G3whfaKP8ikn5KI7mBl1LVutr9aKaWIjp17m8ltaS3u9d5drIj
         Vj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oBlljR7fsklGHpnXhlYwhzZ0OxFRiMVdSGAY+lRUlRI=;
        b=acYnFMwop10my9XhEXW8RUG3u1mwMeSwW4mNfcNUPDdCEgjfEJx8VZAHleVfe4utL/
         7nvuMIyjz0VxNn42wOLEviYP+X+1hPoyrkbIQ3EDYxZSU87hM02lCm2wsj3fhyxhQJrZ
         AkyQEvqn8oS+fkjh7tB7NqqfFlOpwn7rd3YS7Skk8GWwg33nqCdYgP5CPkzkXiQMjwkf
         gFsyUEQ+k5ZEW683vAo9Mxqrhs/EXxrlEEqC6sB5EnmmnlI89xvy8YgeaXt1xt0VVmNv
         pEPyxd9yaNpnRfk0rz2TzfE4FlA7gMe8PbaxK/AEAPzWaLoQVWuDPQgQFb4IZFFKCfyk
         AXwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 077/241] ARM: dts: silk: Correct clock of DU1
Date: Mon, 19 Mar 2018 19:05:42 +0100
Message-Id: <20180319180754.390437873@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391268350395323?=
X-GMAIL-MSGID: =?utf-8?q?1595391268350395323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 403fe77e22eb72c962c3889efc9d4fa62e454737 ]

The second channel of the display unit uses a different module clock
than the first channel.

Fixes: 84e734f497cd48f6 ("ARM: dts: silk: add DU DT support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7794-silk.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -425,7 +425,7 @@
 	status = "okay";
 
 	clocks = <&mstp7_clks R8A7794_CLK_DU0>,
-		 <&mstp7_clks R8A7794_CLK_DU0>,
+		 <&mstp7_clks R8A7794_CLK_DU1>,
 		 <&x2_clk>, <&x3_clk>;
 	clock-names = "du.0", "du.1", "dclkin.0", "dclkin.1";
 
