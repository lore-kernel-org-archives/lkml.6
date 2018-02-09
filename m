Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeBITcg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:32:36 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38800 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbeBITce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:32:34 -0500
X-Google-Smtp-Source: AH8x22704sN008A+U32/WPKroJKYJk0Mxbrfdo+um9WOFNHYbkkGOLlT7+/l9MgUd3ONBgr3DUoLng==
Date: Fri, 9 Feb 2018 20:32:25 +0100
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
Subject: Re: [PATCH 1/7] watchdog: sama5d4: make use of timeout-secs provided
 in devicetree
Message-ID: <20180209193225.GA1932@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209192724.1227-2-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The summary email did not make it for some reason.

However.
All these drivers is using watchdog_init_timeout() to set timeout.
If the timeout-parameter is set to an valid value, it will allways pick
that and not even consider if timeout-secs is set in devicetree.

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
