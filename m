Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELshXnMV6bJPxxGo7xEh5l9EsCXEZYrnlYDR225xJVyadE6vhz15o3yVEnwI0CBNaIvd3jfU
ARC-Seal: i=1; a=rsa-sha256; t=1521800269; cv=none;
        d=google.com; s=arc-20160816;
        b=hN7mDZOqgFXTZ/5bV2lnlhJE+w17xE2JTHH7Nx7jz7zojdA+o0vpQebZvTQ58d5nV9
         F4EdLZw1ZJGAwVypCRT2xM8DNbrVBUSBi/MWJD5tunNPq1EfqHAPjE3xWLwvBMPE6KFx
         7Y7tadw6NVDUTqmdGEcn0/PnpJXg4Sh1uh/gs5L0ZY6I2Q0D3vFnxRkgObKJgQo3TvaS
         KHwERXALOvfBQ8Y5qKn5eonPDho9e0A9FQDur9zi8R0h/N27sIBN73Orq83MQwwNVv8b
         wZC2Njw7EE0U1pY0YtYZYMXI+du3C5b/OVaYma0bKjr15Er5hGF3636Cgb+mvGI2z4hC
         Po/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AvEBSKqZ+xbyLvbOYQc64oNcReaBeyp2RNqAyT86Wuw=;
        b=H9Zvhf1sBorMYk+D3y0pOLvR8qPltKlSrrMUKrAESKtZRB2EUow2xvDgcR9VyAbIsv
         qpFxyst/v3VINAMFyHDxyMyCjoBPwZK6lzz2wl6t9RoRKrwoYxr9Zu0z6LL5KpMPTd4x
         2NzNtIRMmCAXoJl3/+kBu26FFMvE4X7vYc/eN6iXXlJ7I9POJNEFwUiCT9bl0H2U99p2
         LRP8IA+3/mALgdoVr3du3z4h55DWkZ6+nNWwQnVGU8UA9GPDU5cAxWbtN8MrhJ8f/Kww
         gzdHQo+LftdLGEIAAB4/Br0NlCaFOtNgeR3ZtgHHCD+34SOGVms7Dt+48sdGW8VIhd1G
         40OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Santeri Toivonen <santeri.toivonen@vatsul.com>,
	"Darren Hart (VMware)" <dvhart@infradead.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 01/47] platform/x86: asus-nb-wmi: Add wapf4 quirk for the X302UA
Date: Fri, 23 Mar 2018 10:54:52 +0100
Message-Id: <20180323094248.196351259@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722399849110125?=
X-GMAIL-MSGID: =?utf-8?q?1595723239021137420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Santeri Toivonen <santeri.toivonen@vatsul.com>


[ Upstream commit f35823619db8bbaa2afea8705f239c3cecb9d22f ]

Asus laptop X302UA starts up with Wi-Fi disabled,
without a way to enable it. Set wapf=4 to fix the problem.

Signed-off-by: Santeri Toivonen <santeri.toivonen@vatsul.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/asus-nb-wmi.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -101,6 +101,15 @@ static const struct dmi_system_id asus_q
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "ASUSTeK COMPUTER INC. X302UA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X302UA"),
+		},
+		.driver_data = &quirk_asus_wapf4,
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "ASUSTeK COMPUTER INC. X401U",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
