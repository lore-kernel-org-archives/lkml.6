Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48c7hv5s0sYdJRVwgRS1g9wT0gNP5Poa+NyQr3Ago/B6BRMeO07DW4vOJVEeYg6hmzfYtkr
ARC-Seal: i=1; a=rsa-sha256; t=1523473321; cv=none;
        d=google.com; s=arc-20160816;
        b=yH7hajmP0Ay9QPyf4/J+MD49WB6zA7eln0jjnaIVukFQnYo3BwHh4QOlmNPk7hwZkx
         QJm99M0zOEim8aVlqlMmYg7xevY1dxQKEcsI7qqCBHcJHx9aUj0BdHbQFCOQoePa9vEC
         WemgF2xye1shBb1pGqmOiI6l+rJMKlJMuHfNq9SHwG+uLcTLvJ+sAXQUQGt5n3U21uqj
         +GUGhRwtrql5kWDVorVAiWlxiDZXQGyg1OteBy3WQ0F+6FdKhVwuKJh2e1X+wikto8kM
         il9TKNf+MyPQshBDNlcC0qJT3unQIjWZov2UHpEi0GrrcDv+pBA2unXbl5Kq+IG38kKN
         /1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ALxHA4HddK1ueULif65HfOj9Gle9DoKbX1HqvA+Y50Q=;
        b=DNemuWWJYwjxqNLl7F4nUBLkCFugtCIMXEPa6mUIlro7Qvebe4jExWjjkhwSFYlG57
         vmzPc/Zm0+q7dGyQYGS+3HJmP1ervIhO5VqMq2xHXUhXmfESWtSQxkxL9LjLFUO7Hulw
         JQ1bjgXJHbdrHQJu+lormRiMbmtvI0LD0AnrVDgGOq4yBT5vzDqgfBK1W5JazmsXR6/g
         kUGsjL5upWnISVubEGr2UroTKl96yvSLL+lXFaWuiX5z8vuwEwm35NraHr3ukcezD3Zv
         ZWkq6U0f/yXPFaDdKMKukYRFceWMMEr0HuHiYCcMlOuUo3OUI+lN9K5cIdxjypjpvq0x
         Vxjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christian Lamparter <chunkeey@googlemail.com>,
	Andy Gross <andy.gross@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 204/310] ARM: dts: qcom: ipq4019: fix i2c_0 node
Date: Wed, 11 Apr 2018 20:35:43 +0200
Message-Id: <20180411183631.350782387@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477561693653683?=
X-GMAIL-MSGID: =?utf-8?q?1597477561693653683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Lamparter <chunkeey@googlemail.com>


[ Upstream commit 650df439cfb96c303328935559b2d06127a5a0b0 ]

This patch fixes two typos in the i2c_0 node for the ipq4019.
The reg property length is just 0x600. The core clock is
GCC_BLSP1_QUP1_I2C_APPS_CLK. GCC_BLSP1_QUP2_I2C_APPS_CLK is
used by the second i2c.

Fixes: e76b4284b520ba3 ("qcom: ipq4019: add i2c node to ipq4019 SoC and DK01 device tree")
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -154,10 +154,10 @@
 
 		i2c_0: i2c@78b7000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x78b7000 0x6000>;
+			reg = <0x78b7000 0x600>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+				 <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>;
 			clock-names = "iface", "core";
 			#address-cells = <1>;
 			#size-cells = <0>;
