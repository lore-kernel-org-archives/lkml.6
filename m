Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx492MW/wpPuGO9V+tAaKmPAku7Xl43FfujvbsSij/NVDWHsevpZK9q/dRoomAfxmeHJWOetz
ARC-Seal: i=1; a=rsa-sha256; t=1523399216; cv=none;
        d=google.com; s=arc-20160816;
        b=IIbMLeEDQ9SMQoAF3cJHuhiwEV2TMGV3saC/+seQY1DjPRnmGtiJ1hBH0RVaXT6RDO
         ppbkhwB9RT00SQZU+VCkzLfLmGDT+GC7MNgesQq+4/7I3ZmfFx2rt/GMHsuR+tPoTX/D
         8FYzq6PfurWQIVsoYDrLqAA642jPtifaaMTsRp9Za6hqRaLWGMQAK5w33LAg+GOJoBom
         R5jUcqFbi9HferZnio/cp+/etnGxtfeE9xWC5nQtbKPthgdWpuHNplFwaGvIxRhiV35b
         w89dA+QmP/t037ojVKFBYjW1LB4k6jUcHE+DYwkokzprmjoSHObZTaujihnTtKTL6nZc
         wxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EdIIF2t2aJ5OmVED48tnPx2F5abXPpHv6xwGDJ1F1uk=;
        b=iQd/iEYc8tAzitBENmH+U+xkxSL83RiLcjBvX6VRW/fLNC2QwCAdQbFBajWBnsY7RH
         go4HKA/mqUGTc2P0b4MxGpzZGQG7g/9kuPbd5ZbCZfWgMdSJxdEvFgQdTzIRHdyaYD/I
         W2iSomMZvuTADe0lqZnS9ZDf08Svh2scTyWhF8w4VgjySjxYIxcFH+0Q0xT6qJUX6PN1
         9wMRPucR1sThQgdmhpXOnmZ5tlPl5KjQAEN8bgCxMQ71lsQe7Om1qkXnt2dRWmAEJZ1k
         zim2VMQSwuqfH/mA7Bephbjr65Ggp+ubl7Fv0bUh3sOODR5GRM2bgKCDPRm6vfacqOxz
         Tx4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Eduardo Valentin <edubezval@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 028/168] thermal/drivers/hisi: Remove bogus const from function return type
Date: Wed, 11 Apr 2018 00:22:50 +0200
Message-Id: <20180410212801.398898652@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399856875382469?=
X-GMAIL-MSGID: =?utf-8?q?1597399856875382469?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>


[ Upstream commit d0ecbbbe518e1b256fcda1770ec06a5a1a058567 ]

With gcc-4.1.2:

    drivers/thermal/hisi_thermal.c: In function ‘hisi_thermal_probe’:
    drivers/thermal/hisi_thermal.c:530: warning: type qualifiers ignored on function return type

Remove the "const" keyword to fix this.

Fixes: a160a465297362c5 ("thermal/drivers/hisi: Prepare to add support for other hisi platforms")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/hisi_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -527,7 +527,7 @@ static void hisi_thermal_toggle_sensor(s
 static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
-	int const (*platform_probe)(struct hisi_thermal_data *);
+	int (*platform_probe)(struct hisi_thermal_data *);
 	struct device *dev = &pdev->dev;
 	int ret;
 
