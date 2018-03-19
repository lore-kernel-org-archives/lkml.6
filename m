Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtiA1uvkisGyHGpvPHzCLQnTr5f1omqOVyl8A4OhSN7/IxVKe/yy7kb8V8k45f5VBw+CRV1
ARC-Seal: i=1; a=rsa-sha256; t=1521483747; cv=none;
        d=google.com; s=arc-20160816;
        b=ryk9TmCRk2Vyj6ejRofkyRqU8/u9G7ScYX6Us4PBEaLrB7IKQANd5W0YEeLZtoCv2H
         dkZb/YlRrQdF7Z2xwDf1ZWxhNz6Onwsjem6v7+6XlaPwzgrkcfnE6BxZm0Y68TB55ZsO
         3LL1D4ce0KkYw5fB93fk+wGMOftJzKnPcUTnb+b7NSR8zBUN4FWBLfRQZoNokOSgHpKE
         Hq+h6FIZjdP/BsQox2jT4tjPaROQam4PmKXY0ecdpXOBiy2f79ahDcEm5yT/Nz49tNlF
         4VK/YXJ/ZnEJ9ENx0A0iNjgqBqHaUBm4ShtP41b98sXyhQ/RubD133UBSvuPYrcRxXdV
         3/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ozXyUYdnL9/TEgriUhtYWIugrJQYwif9BSEfyoNCkrA=;
        b=KfSoYsg1XkEtkbhvQnUV9P8AdYA4SKAYB7f8DoE40KwqOMye7SnkmBuOI9xd1NKlh7
         I95ohMnwYYfIhVlP8ESAXFelfHCreBLswct+a/7OvOzsWHfk22Akz1rLlonTrlY8Gpxw
         E9L7TAA+H1elXcUicfOb2aos07k7gtXrGiy0FlzfUQ9yV4XisA3cZHQ7L6VyV5kdgl10
         B8Y2RQHjG5FqNJCRu6Ih/pQKlZBX9r6DUZVpNZS2WcdY8IkbOnBuEseUDI4MIoZbXD7j
         eQws5uktKXbS/kAweQJBW3hpS2H3af7VsPBu7f1YKbjxPpy6Va/2+O2ATZI63/7bGsWd
         MsIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Eric Anholt <eric@anholt.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 067/241] ARM: dts: bcm2835: add index to the ethernet alias
Date: Mon, 19 Mar 2018 19:05:32 +0100
Message-Id: <20180319180753.976719226@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391342305392366?=
X-GMAIL-MSGID: =?utf-8?q?1595391342305392366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baruch Siach <baruch@tkos.co.il>


[ Upstream commit 10b6c0c2e2bb8cd1be682f8d36ef597e3419cb88 ]

An alias name should have an index number even when it is the only of its type.
This allows U-Boot to add the local-mac-address property. Otherwise U-Boot
skips the alias.

Fixes: 6a93792774 ("ARM: bcm2835: dt: Add the ethernet to the device trees")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi |    2 +-
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
+++ b/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
@@ -1,6 +1,6 @@
 / {
 	aliases {
-		ethernet = &ethernet;
+		ethernet0 = &ethernet;
 	};
 };
 
--- a/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
+++ b/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
@@ -1,6 +1,6 @@
 / {
 	aliases {
-		ethernet = &ethernet;
+		ethernet0 = &ethernet;
 	};
 };
 
