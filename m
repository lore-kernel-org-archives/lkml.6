Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227shHnNu4GuLSPNiJFeYyjxcTzvx+4fa7JXmyPdivj/bQa7ZM1mTw2kpp0VMF2aKz77FsvH
ARC-Seal: i=1; a=rsa-sha256; t=1519217858; cv=none;
        d=google.com; s=arc-20160816;
        b=Po8IyBojg3Q5Xclnuw8Kqewd3NznzK/WNZJuKYIr5WbOtFqihP6NfPOFfWS9v8uSZv
         SR9CUWJENt+lG/q5kzDGt8Tz7qdCasuFiYH61y8HthCjT/QpbzNndR2B9MM4F0OrBHbE
         ABkN4IBDkXPufzbD/DHlDnMf3QBQ495M0cDJcLmyojspCfpHXa9Ef2R/d2lfoVzi5wMv
         PP5ikNAF6MVGY/krNtd4lmF6DB1LCMxlDgIQKFGR9+/6BXnlvTjOWCnGjs7VShHiqqBB
         ngJ/OgibjoHXVoEShbpAS6Fmw0KtPU39/QOGGbsXecltSE9p2H545Bu+rp66bcTcyagP
         6gxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r58Jd+Z+/Bqpwz26SW17aQOOG4OybgaT9z4vzM8Npxs=;
        b=efU2LUBcRJSpQoiec/F32X/Z45e9sC9rd3vmSIzltn5i3VKRtFXrPy2libysK9nLLB
         SbZeJVhfl1JVKFsxxWQr1sh9BsXrZ180VayhvPubbNJZXvtozt8+o1eB9T5/cJIKzVh5
         3LFk+OkVmRR3TtiXObx5X1TNDTkH/Sn+77wT82txwvXkMS/yhw0a2n++rxDj/s4MBA2a
         QkiRQwOHcfgbgF49mXvuTfZC4jZrKyJaNyYFa6sQ90lNmKyoEAnArYh0sP685u/K1qNA
         8bz3gF98Sindq9yZl8Wl0nZcpyI4s8R9O4zhKo++ptj09/10tNdYaFLtoroOCZ6E9UnN
         dlgw==
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
Subject: [PATCH 4.9 49/77] arm: spear13xx: Fix spics gpio controllers warning
Date: Wed, 21 Feb 2018 13:48:58 +0100
Message-Id: <20180221124434.262520347@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014666669772873?=
X-GMAIL-MSGID: =?utf-8?q?1593015385638510839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
