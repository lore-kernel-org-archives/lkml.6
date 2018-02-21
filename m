Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225FWQmUuAOQ9hCKQjARHgnoBg/P9rE8Pr6UY+A2Clz6FzhkdQ2mlSLnfCc0t5I4to9VyyGO
ARC-Seal: i=1; a=rsa-sha256; t=1519217905; cv=none;
        d=google.com; s=arc-20160816;
        b=lI/F2nl8ZauDyXiVtKozWP698g5Iljks4R1e9BqsQMh1Smu60qfjL+LolBj4BoRL8z
         mOyPgc+w+0erB67tU/47UHP28qrT8RK7IBT3EHJ7qA63ofo/NqooGUyWY4eNBIzsjz9K
         3Q7uFHMoWN+ddZ2Frxtd5tTWhBUy4BT4c9+E3Hj9V69BBuwfG2EQxfTa51DPAgp4m0Gi
         XxG1EnyBGnNYJi33Ueg/ab6DyA5avg5YKN6o3uhuDFfJMDBnR2YnTif023oI8bhya4gd
         8LOEGNRzsd+Hum2WrI/16PKsC3vVY5Kzz+GqqNbvj8u5bocBz5xmrLqlGEiyGsqYN2AQ
         4Gyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IdjWK8RO/jHCLWOXnjWEw8CPSkHN/Ce1fJET/tlZI04=;
        b=dFUFlqRIi/kQPUqT6jSlDY7bDSrrGYaEu6ymcdF6Yne0N1yM2rR84In0NdLzn44LOe
         ZE/KeQ6NAGlnnOgVQ+IYvHZRKsA0PVtGZVDQBLNvtXiBbLg8yHkzagFx8ZWn7xnA3jn4
         CH8itFPwS/ZRIZLg1wigjrp67kkLT+HkXHA1Ux/VLbVoa7rzWOEZjZV725fmSSIqW2Zp
         SiKifR6KHj3riDKJiCK60y4SSYMg1x0Str0O+xJPtP/iJin+xR3TxB5oP91BQ9hi/MRA
         LMWciTa9O3o9Z2KLfaxln7KoWyJv8AiYWTIWTGouVRUGK5xRY+CzlprUmWCT9GCkr6HR
         Vqhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steffen Weber <steffen.weber@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 002/167] scsi: smartpqi: allow static build ("built-in")
Date: Wed, 21 Feb 2018 13:46:53 +0100
Message-Id: <20180221124524.768984272@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015175879199840?=
X-GMAIL-MSGID: =?utf-8?q?1593015434530680542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Weber <steffen.weber@gmail.com>

commit dc2db1dc5fb9ab3a43b305c2720fee5278dbee2a upstream.

If CONFIG_SCSI_SMARTPQI=y then don't build this driver as a module.

Signed-off-by: Steffen Weber <steffen.weber@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/smartpqi/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/smartpqi/Makefile
+++ b/drivers/scsi/smartpqi/Makefile
@@ -1,3 +1,3 @@
 ccflags-y += -I.
-obj-m		+= smartpqi.o
+obj-$(CONFIG_SCSI_SMARTPQI) += smartpqi.o
 smartpqi-objs := smartpqi_init.o smartpqi_sis.o smartpqi_sas_transport.o
