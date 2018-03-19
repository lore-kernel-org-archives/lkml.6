Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtYmY0NOIwbjvLotJWb0eheBMVfuUUKwOT9GR4RR1lSoXQG2l/+8i5ctcxnkRjeM7AeZZus
ARC-Seal: i=1; a=rsa-sha256; t=1521483546; cv=none;
        d=google.com; s=arc-20160816;
        b=o7X5dJDC3JPI9ucnAbaAMvz3xHB4+USK0q0HTrXvJNsbMb2KeFoRvQkwmDk2IpJWn/
         caRafqPrtAxkZlvkR7un+El9alA0614ih41B6D9dKSo0x2v/hS5xVlI7GMN8gHjDbaGc
         p0WfPePfDDwWQZGs5K0IAis3s0mnzKw/+JcC89UFwi1/Acm7OzNEuue9gf39qlk20IG3
         ichAOcovuWs7P3q2u3lwRad51Cn45p7vSxfk9Ygn+XTbAVcwNdSKq+sZbCUMQ15Nap7l
         ldV1hOOeMOSKuUc9nVSDPAwQW5JHRKYqIUs1BNf+UmkcBqPvXqf208WtUl0hH/BcKM+B
         hd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5Ohu1JY1keE5Ay+XnYE6mY9rx+PGpi7kTVV2CcwN/Hg=;
        b=SYRzvsn0pYRWBfArAOuihTp3MLbKSNBBAYfgsk9LLxK+cQWPWEAAk+xfiTokh1weVk
         QAcDGL0TzobmW7ZgMlONv7Pyeuk2L+EMTqK1TsePD0bPuUfTgAcTyDsRWKaQJHK//aaW
         KJCQD014L9R8HkO3o57nbUeiZjPQdj74V+scy+tbhycJ6sM6ClvWOWkBGj58rAvrITFs
         Eox678tiII/Ccmz384EEUF1WxcGLIvl0Tevmk8S+uFKoRLVTS9jjTLKz3hJW8SRBgU//
         GCXjBzVXbCDbLHEWouoSluFZ49wb5Wth4OFoBuWzxAzIgHzZ/hMtrg9i/+uyeiGEqUML
         CqqQ==
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
Subject: [PATCH 4.9 008/241] ARM: dts: r8a7791: Remove unit-address and reg from integrated cache
Date: Mon, 19 Mar 2018 19:04:33 +0100
Message-Id: <20180319180751.520858371@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391130944659288?=
X-GMAIL-MSGID: =?utf-8?q?1595391130944659288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 5d6a2165abd4635ecf5ece3d02fe8677f00d32c5 ]

The Cortex-A15 cache controller is an integrated controller, and thus
the device node representing it should not have a unit-addresses or reg
property.

Fixes: 6f9314ce258c8504 ("ARM: dts: r8a7791: Fix W=1 dtc warnings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7791.dtsi |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -74,9 +74,8 @@
 			next-level-cache = <&L2_CA15>;
 		};
 
-		L2_CA15: cache-controller@0 {
+		L2_CA15: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			power-domains = <&sysc R8A7791_PD_CA15_SCU>;
 			cache-unified;
 			cache-level = <2>;
