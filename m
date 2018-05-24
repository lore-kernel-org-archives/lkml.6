Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqYOVQ4XEhGByGfAJ0oCEnTt1P2QCWpsC0rMxcPyeRzaiyDdyHmi+29ids3H4T9RkRU1cBa
ARC-Seal: i=1; a=rsa-sha256; t=1527156264; cv=none;
        d=google.com; s=arc-20160816;
        b=TUzkjVRc279lp7lSIxNHrFzxMOdSra8KeT5Hxgltmawe52r6tac6Zv5yhIxnFScykn
         W2+ySOncBgPXLeAa1wBiWldwqNOe3Lja8Ju+qdwwU+UR+5ZvAbJ1UQmTjGi4OVxsk9GW
         7TZEDx0Pwt1mffiM1tlHepVZHzwkb1zUPItcMiuqaUmqCk37CKLE0lsrs9xV4uFoHPK8
         321zdro56FbmOIOMnxI7X7TvbnpEZcrXvTIi5126FDimfWgPyZoxVZhHfMc5EvPUtYPS
         +XZmv/HWKGVJufaY+u6rDzUZayBD9HF4HhvEtEuSZwARwog+xBfM7hD+JWfsXbd94UaG
         r0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=tCDCpTjLyf62Bc7++RAlcwfoKzwh525oGyLfPL1b774=;
        b=JZSU8pPD45Gnxa3vAi7yTwOhBSMbLw7yGYbLoAcivEtnfGAoZOKG1K4h8awZQ2tTFh
         8MK/Fu+S9SYtwnfFgOdayjG5Hz82AP/vro7wZVYiPGvi1XMXm4npgVxohtfIbM2X0XIk
         wKyy58tK2kCUrQ4wgGm79t0x+SvcaFyRB4l+3szpWcLQOK24INfQu7SdUQf1T2cw2iq7
         jM5yNS//5n/J7QraB1iu0dgOrJK88hymylqs8SPheUEGInB6EAsV+mmabm/rPyxxCwLk
         Ppw1yoHbJiIYpcejxYc+xt3Hu2jqQBMK4ZT/W9xS11np2g0h456Uc9DVEINJ15cNOV76
         l8jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vYuHWdfw;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vYuHWdfw;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 123/161] clk: hisilicon: mark wdt_mux_p[] as const
Date: Thu, 24 May 2018 11:39:08 +0200
Message-Id: <20180524093033.021891453@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338938407671650?=
X-GMAIL-MSGID: =?utf-8?q?1601339407321637747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit df934cbcbff7afbc024bf05f02615917c61f6470 ]

The symbol is in the __initconst section but not marked init, which
caused a warning when building with LTO.

This makes it 'const' as was obviously intended.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: c80dfd9bf54e ("clk: hisilicon: add CRG driver for Hi3516CV300 SoC")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/hisilicon/crg-hi3516cv300.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -204,7 +204,7 @@ static const struct hisi_crg_funcs hi351
 /* hi3516CV300 sysctrl CRG */
 #define HI3516CV300_SYSCTRL_NR_CLKS 16
 
-static const char *wdt_mux_p[] __initconst = { "3m", "apb" };
+static const char *const wdt_mux_p[] __initconst = { "3m", "apb" };
 static u32 wdt_mux_table[] = {0, 1};
 
 static const struct hisi_mux_clock hi3516cv300_sysctrl_mux_clks[] = {
