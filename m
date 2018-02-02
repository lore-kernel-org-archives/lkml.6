Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224kjivJT7RI62+ad6ngWmPtPj+orpbYfohV95QhFiq1N67QOSDAa02iInDLY9X9jeXomG09
ARC-Seal: i=1; a=rsa-sha256; t=1517591533; cv=none;
        d=google.com; s=arc-20160816;
        b=R+I64s9bKf+XUcJ+UxcTjVpF2US+7m+mbx2Itr2OHGt1v3KXz4d0SWW4M7khTaLBV4
         e5ul4ArmihlOcmLyThhL4nQUFkQwC0pNS4R2IPaZBcvxyY/WYd6WTw6bzT0XT0wjavWm
         XRC6Ia/4XHMYYEORpIFdDc2erfmhFtZv+ZjrrlIqXObKBzp+DLOA7ZY4JneEFPkv174d
         9LU9H/Bk/tr/MvLKa8oMHrEShBYB8heG1dP8CYL9HVsya7d8z2MwFU/f5JQXA/Hz8QyZ
         6wFmKLRuVgSPikeO0b1R2YWmW7fXHrSWx/LmVohjzS6fYel1yEjItB5pGHVSIGMUdq9c
         s1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Lu/c/etmliPGLsg38biFZ6VU56oxhscPDIfFWPPur0I=;
        b=jd9heD56LCmruE97c4EyxCPIUwUk3PEc9HU0LG/JQ77u1wIWbwK1HuqOXxsuudSuoR
         VPUHgwbePWjeZlUGUgDf7qSvmLBhIS8Lv2ONYCxedQVp5qQ/YiTABxTsbZZlureALFC2
         8bQ/+hBNbxNSJfHu022EcHoHZ96VSHuaF8fltfWjodZkMhDCgGPaXuhQNN5JZULitKxD
         mA/NtOjrFLACr7IcPRO62LmhGOd/5kUQMrNgNY3HphKdogde3lQAt63ODF+QC73KAmrZ
         qenwWaQhpaqXjBtKVTQ1xng6AEKFW3ki89PvIy8+tGDnk7pQxC9rd683eyC9hvVYISPS
         qEMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 113/156] drm/omap: displays: panel-dpi: add backlight dependency
Date: Fri,  2 Feb 2018 17:58:14 +0100
Message-Id: <20180202140845.289730292@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310060084349704?=
X-GMAIL-MSGID: =?utf-8?q?1591310060084349704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 499ec0ed5eb2f6a7fcaab2dd66ffc5993484bda9 ]

The new backlight code causes a link failure when backlight
support itself is disabled:

drivers/gpu/drm/omapdrm/displays/panel-dpi.o: In function `panel_dpi_probe_of':
panel-dpi.c:(.text+0x35c): undefined reference to `of_find_backlight_by_node'

This adds a Kconfig dependency like we have for the other OMAP
display targets.

Fixes: 39135a305a0f ("drm/omap: displays: panel-dpi: Support for handling backlight devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/omapdrm/displays/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/omapdrm/displays/Kconfig
+++ b/drivers/gpu/drm/omapdrm/displays/Kconfig
@@ -35,6 +35,7 @@ config DRM_OMAP_CONNECTOR_ANALOG_TV
 
 config DRM_OMAP_PANEL_DPI
 	tristate "Generic DPI panel"
+	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Driver for generic DPI panels.
 
