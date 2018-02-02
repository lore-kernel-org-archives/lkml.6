Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226NgKZx8obqyP53pYao9Qs87ecwQesEBcx2XSoJLcWLpSKm0IdVtSCGHZJ/vFG0MwtDMOJK
ARC-Seal: i=1; a=rsa-sha256; t=1517591276; cv=none;
        d=google.com; s=arc-20160816;
        b=ubBJFl5XF08seX0yKhIJCvdkK4xWxWSJr9YQrwgHJWWNJMt5+qoiTEYHgNX3pb3YLE
         ZdgWWQGKXTlGDNUmN0BTSVpmg/6/WPOT3LfUCpLAHt+89DIO748NJ/MoJ50IbrPQhURg
         Od5ngMqFpC+S8ikX/msowcqa1kb/rfLGN8Koi+Hdt5Xa2CE/yh/UpTMFrQTcNf3aJ8+p
         GsGmU97yDWx/r2MQvgo4ciZQoLeiRDKRcRcVZzj3+FHDrpvKXY5NmNW+LZOXk2bSMbPA
         QChgkT0xMVPBKUifKj5snDte5ImV9p/jEjQ76jrpOAGgTOaeYgBzjlEtcFUG9sjxHKpA
         zeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d7E21M/QLGpjTlGIO2tk7wsRz5DA0agWZ0BcA7HuCBQ=;
        b=jYwfuyvSbeWCML+X0uRPTa/fHcd7LrUPmxYZ+M1R2nQNSJCH0djXcfDFsul9Dj/xjX
         OTMAlAe0Z0xcu8fmCye1Swa1iBFnS7FocPhg4Cn4I92oEyep5kcCwWD+xIobamoMmfcx
         fo+Z2AW3P/94UPr/JquE7sH/48Zsm2vlk/PlvWiHE+/bLc2u10RcYJGtVO8MgRdcpn69
         GoVH+JIhykXc9wHkVV8R/THMJ1zUMb1iGBTZ8h2z7Fq7V7Wj5Zh1WdUWhJF8lV6Q8uG8
         O1EomxDLoqAkkqbym5FXBKkSbbuxGtXDvcg6f4MRB9RHCHet2Q8c7vVm6dTio7o4sWDk
         2XoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 023/156] gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  2 Feb 2018 17:56:44 +0100
Message-Id: <20180202140841.369317238@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309288396481657?=
X-GMAIL-MSGID: =?utf-8?q?1591309790079264863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 97b03136e1b637d7a9d2274c099e44ecf23f1103 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-iop.o
see include/linux/module.h for more information

This adds the license as "GPL", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-iop.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpio/gpio-iop.c
+++ b/drivers/gpio/gpio-iop.c
@@ -58,3 +58,7 @@ static int __init iop3xx_gpio_init(void)
 	return platform_driver_register(&iop3xx_gpio_driver);
 }
 arch_initcall(iop3xx_gpio_init);
+
+MODULE_DESCRIPTION("GPIO handling for Intel IOP3xx processors");
+MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
+MODULE_LICENSE("GPL");
