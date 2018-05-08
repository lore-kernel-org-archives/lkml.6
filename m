Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqsfpMYOc7hIKGdJoS2PmN2MtzdDw5dC3TGBE700cP2lEaS+OxAG9BCWHO39wdOVuvZrtS1
ARC-Seal: i=1; a=rsa-sha256; t=1525767455; cv=none;
        d=google.com; s=arc-20160816;
        b=Q0hngZyBTHqUJIQQn6y8WsoYbyLXdkvZoHcL1LQnRwWXujlqTb+xnO2p4KfTTw2nKn
         JS+UU7me3FE4GiHJv1IEHj2AvO19GebmfyZlXfTis4fnMENc/xjT4anGug9i44ZvHwbU
         ULtrbfQgi6l4slpDjaEJzqIuLU51cI/OfWHlEsw2BEwiWHkL0TiC0dtGU9dwuKQcL4Uu
         zY3n1qkwLvSGS2C0Pug6sGFhixma7BH5hjowGkzO57VnUWLbnr2Q4C+8jvH77vM6xGPc
         WkXFZ44EJqfdV8nMPIhIzWJGHOvbjjtfaF2kudWWg96wE31pA9h+RY+PKmTPerl9OU+e
         959A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0OSRzI97SFIimAM7aX8JLvPL+rBORVo1yhQSJt/zJD4=;
        b=ZO2CZraVODdKrD1PvfeogIU44Xs1GHGkW/IEaKMe25HPBWipRnLr9fdWYOI1WcuRaZ
         syZMT1BsHk4j7ZgHiwALFjJTixr39hT3pqujhVIDjf63fnxI7e8dB8OT+yVBPrTKsStu
         1j1krcE14UreAcmHU15riZ8ZSmbS34OCEaZJCo6POsuDbcVwRWn7vg+miGyd5t4gURly
         hbWwfTzeGNcEUjt64k8MKA7l0QbDQKgfvBBRjNjtNemjNfDdnmrCbBzbCq9trWhGrKKJ
         jtfrH+S/zLSyY7Wf5LJaADC4ZDY9ABjX0w9zzF4jMBarHJ1MxneZTZ3jfdAJ/bKI1giZ
         hgbA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HzPghz/z;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HzPghz/z;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vittorio Gambaletta <linuxbugs@vittgam.net>,
	Salvatore Bellizzi <lkml@seppia.net>,
	Guenter Roeck <groeck@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 14/32] Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromebook Pro
Date: Tue,  8 May 2018 10:10:54 +0200
Message-Id: <20180508074011.039911191@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882773685082917?=
X-GMAIL-MSGID: =?utf-8?q?1599883135647183431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vittorio Gambaletta (VittGam) <linuxbugs@vittgam.net>

commit f372b81101e6895252298e563d634d5e44ae81e7 upstream.

This patch adds the correct platform data information for the Caroline
Chromebook, so that the mouse button does not get stuck in pressed state
after the first click.

The Samus button keymap and platform data definition are the correct
ones for Caroline, so they have been reused here.

Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
Tested-by: Guenter Roeck <groeck@chromium.org>
Cc: stable@vger.kernel.org
[dtor: adjusted vendor spelling to match shipping firmware]
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/touchscreen/atmel_mxt_ts.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3028,6 +3028,15 @@ static const struct dmi_system_id mxt_dm
 		.driver_data = samus_platform_data,
 	},
 	{
+		/* Samsung Chromebook Pro */
+		.ident = "Samsung Chromebook Pro",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
+		},
+		.driver_data = samus_platform_data,
+	},
+	{
 		/* Other Google Chromebooks */
 		.ident = "Chromebook",
 		.matches = {
