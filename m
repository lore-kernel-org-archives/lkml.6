Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2259ICEmvktFvitDz1ZdkqxK+ZvUUnxHkBLU6OF3/R4z8HVkrd71UW9JFzjIfHbxxsPK1FbT
ARC-Seal: i=1; a=rsa-sha256; t=1517591070; cv=none;
        d=google.com; s=arc-20160816;
        b=kLZ+uEQCq39OjQWI+2F+elp9e3EbRclxv5G82gwCSvJqj/icV9jZDCwLZ9eNeuwbzN
         Plimd+JholXYkACM7K5bFNtucTut4LarbkIVYP5EeZgEZ3LIkydIeQWSMVb+Vwrz+lSo
         ozueG3dLgTzDDHgWqZF66KOPk6nkZpagql7PNctgb1YWhbHCG3pIpIVGb6kdLOkZ9/V0
         W27bGJhojMxfQaj3UzEbDCAbPZ3yS5KPyXUOCX2yZzef3Vw+C5Ja85vw431BzfCogfy9
         iNgP/gk7Yze76+EEcHzJzjaEpVk5BLKaUdjih/p0znDaDIaUkjRzdZRoDX/H+uCDcRdH
         ul8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X75YnOr2/A+GHdGGpEbLrhmOdr2uNFqoLaN3bD+PweQ=;
        b=diGAEMO8KBDEpGCCADw4uWTMwQdJs3NhjyLU2pLNf2uD3aFItvmDYrC5OJHFgPhxAT
         QC+Hp9l1XLXlt0Fdh9yiznrG7QFRykHrbOHzc8qascZE+EsWFJbyanfgTqv1CmFKqhV6
         svGuklkBstOTxPngQBlw99tJCjPmQWYD9v6/HzXcg5klgVr7vOeIUFAeQzyg3Z2kekvX
         JoMwo/jUNo4DToD5e4duxO3EDS4knuHEQtnAE/L23fYpj2qtIybfkqlgldFmk1cMlKjR
         XjwvOLHIGwBlMzzrWQce0dzdM9/C6Gpy6gAV/zP2G4xospE/eeelLeph4F+ZJcczpvOm
         4gQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Alban Bedel <albeu@free.fr>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 14/86] gpio: ath79: add missing MODULE_DESCRIPTION/LICENSE
Date: Fri,  2 Feb 2018 17:57:34 +0100
Message-Id: <20180202140824.179988975@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309290648693598?=
X-GMAIL-MSGID: =?utf-8?q?1591309574442180645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 539340f37e6d6ed4cd93e8e18c9b2e4eafd4b842 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-ath79.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION is also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Acked-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-ath79.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -323,3 +323,6 @@ static struct platform_driver ath79_gpio
 };
 
 module_platform_driver(ath79_gpio_driver);
+
+MODULE_DESCRIPTION("Atheros AR71XX/AR724X/AR913X GPIO API support");
+MODULE_LICENSE("GPL v2");
