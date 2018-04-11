Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Z5nKJ25KdSSQgG/gljm3YD38WI2jRhCiWFXZNlj4pI3SJmmo6FLnOed9nwZUNcKVzstJS
ARC-Seal: i=1; a=rsa-sha256; t=1523473384; cv=none;
        d=google.com; s=arc-20160816;
        b=0Qm1xMOtG4K8apjgb4zn1a+AMTT//Y6zhy9e73a5U/vm/8ZLP9ctaiGcHIQ3l7CzGF
         hCw3tceXRrjj463LPaGrOowEnLVUWkC70oofFBy+0bKZ8YD6ATrXEk1qIPnz3G213ZW5
         jzl3yUlSnAUMXS2gMv0XbJ5BcpHSCKp1epoK1QFflGPMITq1Mwfw/KUPhcNh6zx+DsM5
         JaqqEwzqnFzadgRmYznzvjEumJ5HIpTYRW/wqiydHqw/UPwtgPFzy/MduifVgirhVYCk
         +dI3+ffc2ZvSLKGt5iyl8qnUFCccRZgAhcuZXuT/TF1+fYuPuGSNt1duJ0NXuOQBcoQW
         rsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Xmg8Qc3CJBc3qyOLVTMAquc1plTI0lF+CO+9IpHK8Gs=;
        b=Rx/iy3vLFbOdeQ1yoiYpmg5irlMAO2G1ajAYLRJdtL+J2Wf82CWsFsWIc1KIWZfile
         I3AIT+WufJOqaYI1uapKTD5P/42TZeEo6olsVclW45KqazJtXGt4Sji8ffv4hmkwbki6
         cuhWby2WhRcvYjZymmH3MZMJNE5QsQ2lucel9AZ82QK3Jalht4fCAmc4BlxM+MX8eMQw
         PrWTVITs2ggr87TBUoPAbBmg2lWSqnlxXPrEYVz8K++rFoeHrF4n5KHvGTRpmIGif12w
         8l0GwRuxjLch6qoqgOczxVccO+IPUKuuy5k5WJl685QvRay4BQUGpIGHCBET4TL9+LZ5
         1Qyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 229/310] pinctrl: meson-gxbb: remove non-existing pin GPIOX_22
Date: Wed, 11 Apr 2018 20:36:08 +0200
Message-Id: <20180411183632.363843287@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477627239525996?=
X-GMAIL-MSGID: =?utf-8?q?1597477627239525996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>


[ Upstream commit 4c8127cb523982e0a474ad80b14b665dc2f37b3b ]

After commit 34e61801a3b9 "pinctrl: meson-gxbb: Add missing GPIODV_18
pin entry" I started to get the following warning:

"meson-pinctrl c8834000.periphs:pinctrl@4b0: names 119 do not match
number of GPIOs 120"

It turned out that not the mentioned commit has a problem, it just
revealed another problem which had existed before.

There is no PIN GPIOX_22 on Meson GXBB.

Fixes: 468c234f9ed7 ("pinctrl: amlogic: Add support for Amlogic Meson GXBB SoC")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -138,7 +138,6 @@ static const struct pinctrl_pin_desc mes
 	MESON_PIN(GPIOX_19, EE_OFF),
 	MESON_PIN(GPIOX_20, EE_OFF),
 	MESON_PIN(GPIOX_21, EE_OFF),
-	MESON_PIN(GPIOX_22, EE_OFF),
 
 	MESON_PIN(GPIOCLK_0, EE_OFF),
 	MESON_PIN(GPIOCLK_1, EE_OFF),
