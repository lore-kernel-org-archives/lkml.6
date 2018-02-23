Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2251WFkuU0iMtdcTV06GZ24mD1mkrDCqQoTp2AFasGh7pQZ59hO1tAn6+hAZIm+aOo8lyS66
ARC-Seal: i=1; a=rsa-sha256; t=1519411120; cv=none;
        d=google.com; s=arc-20160816;
        b=ocfKUW1KT2rNaf5yBt4aZRxoLr6syKfNwbhNvPeqci9GR6YcVmW1bfCB5svADwC3zD
         ABkJQqNUWJb9x7KLgzlET6+axz6sbx8sLp7jzllgkT4YedynWqySmULeoV3HnBmI3cRG
         cWNSBj6T8/Aj8xcWt+qjTK5tDpsoPmavurkvTdrIacB4dNksjYjcZ56BdcUtASEaCPuO
         vwvS81+EHPm9FszdlKTTER9lndPG5dACbEBuRVRMHnF/og/ydrW9QN9+9ue5GBeAifcZ
         sm2fa8CVwCrsIRkGndveAT4azaIdNexDqiJsHV7nQlg30TCSw28DyP4iQbWhuP0wUo3o
         AvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tPW34p73PA6s7B8JYTG6+p309lTdiMsIuzbv48ORb2U=;
        b=m1pT1td9aViAWITV7dD9d0kS0fHqlI8I4+kmtJfNIv16JSo54jwq8x2ClyJwmmBM2j
         r2YFGwMJ+qp0X9gt8CMBo1NjhsvUTfxTuZ1KWNeaf/9Z9Qi2uNloBeM5PGeVxCvLiXiZ
         2R2oa1qbqXTxAXSeUwmrcKPkHflYG+o1CPU3kSnkfBOSTt+0QNkgsCiqY0Zg/lLJaDjd
         5EeMi4sijFtGYrV1q+Xz9x2PZiuyjHQsGBI5/jvhj4YYEoGfb6qYbPjtq+dHh/2VLYBV
         yYSFEpRiNp0uzB5M1s8HghNAOGI65wNxHb/3T3HYA/UQx7TpL9qf1xGJk5/bTG03lphm
         +Fiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 4.4 129/193] staging: unisys: visorinput depends on INPUT
Date: Fri, 23 Feb 2018 19:26:02 +0100
Message-Id: <20180223170346.093070420@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218034232227739?=
X-GMAIL-MSGID: =?utf-8?q?1593218034232227739?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

commit 82ddecfe8de54331bafe2d0ff526739fd0980190 upstream.

Fix build errors by limiting UNISYS_VISORINPUT to the INPUT kconfig
setting.

drivers/built-in.o: In function `visorinput_remove':
visorinput.c:(.text+0x20802e): undefined reference to `input_unregister_device'
drivers/built-in.o: In function `visorinput_probe':
visorinput.c:(.text+0x208177): undefined reference to `input_allocate_device'
visorinput.c:(.text+0x208241): undefined reference to `input_register_device'
visorinput.c:(.text+0x20824d): undefined reference to `input_free_device'
visorinput.c:(.text+0x208286): undefined reference to `input_allocate_device'
visorinput.c:(.text+0x208302): undefined reference to `input_set_abs_params'
visorinput.c:(.text+0x20831a): undefined reference to `input_set_abs_params'
visorinput.c:(.text+0x20833f): undefined reference to `input_register_device'
visorinput.c:(.text+0x20834b): undefined reference to `input_free_device'
visorinput.c:(.text+0x20835f): undefined reference to `input_set_capability'
drivers/built-in.o: In function `visorinput_channel_interrupt':
visorinput.c:(.text+0x20851e): undefined reference to `input_event'
visorinput.c:(.text+0x20862c): undefined reference to `input_event'
drivers/built-in.o: In function `input_report_key':
visorinput.c:(.text+0x207fd1): undefined reference to `input_event'
drivers/built-in.o: In function `input_sync':
visorinput.c:(.text+0x207fdc): undefined reference to `input_event'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/unisys/visorinput/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/unisys/visorinput/Kconfig
+++ b/drivers/staging/unisys/visorinput/Kconfig
@@ -4,7 +4,7 @@
 
 config UNISYS_VISORINPUT
 	tristate "Unisys visorinput driver"
-	depends on UNISYSSPAR && UNISYS_VISORBUS && FB
+	depends on UNISYSSPAR && UNISYS_VISORBUS && FB && INPUT
 	---help---
 	If you say Y here, you will enable the Unisys visorinput driver.
 
