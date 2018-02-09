Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeBIT2B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:28:01 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33402 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeBIT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:27:59 -0500
X-Google-Smtp-Source: AH8x2253ZAJgtyd99T5N4vZGeRTSTWMG/pQ2OkODtDA7EMkwj62VHN3YFIEe8JHpc+4JpprVPy3Y1Q==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/7] watchdog: make use of timeout-secs
Date: Fri,  9 Feb 2018 20:27:17 +0100
Message-Id: <20180209192724.1227-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these drivers is using watchdog_init_timeout() to set timeout.
If the timeout-parameter is set to an valid value, it will allways pick
that and not even consider if timeout-secs is set in the devicetree.

Most of the patches will just remove the initial value for
timeout-parameter.

Some of the drivers allready has documented device-tree-bindings for
timeout-secs (but will not work), add property for those which not.

I wrote a similiar (tested) patch for imx2 and simply did the same to these drivers.
These patches is *NOT* tested, so please review extra carefully.


Taken from Documentation/watchdog/watchdog-kernel-api.txt:
	The watchdog_init_timeout function allows you to initialize the timeout field
	using the module timeout parameter or by retrieving the timeout-sec property from
	the device tree (if the module timeout parameter is invalid). Best practice is
	to set the default timeout value as timeout value in the watchdog_device and
	then use this function to set the user "preferred" timeout value.


Best regards
Marcus Folkesson
