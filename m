Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224r1htRixMCZERhb2VyEuC43MI/tKNqE2w7fvtjHcCz18ndozbEQDGM0fznZfZHqkdkxpjO
ARC-Seal: i=1; a=rsa-sha256; t=1519217140; cv=none;
        d=google.com; s=arc-20160816;
        b=gJ9VvckZ+9ZaAx2Z0qgznYTQvU7qJgm4R0G6DtpfqP59+jHWP4I37yzEf04sDBoCHI
         X0bpmKujYQYY6spuolNrwjL3FVh1Zugcvq40FGiY0Vk+WlxJMw4fynn6JPIJOKNkVEe1
         KCZ8eROejqJ0F65VM+DnHiMddi2K3B0tWIp78JgqUFg0ksdV9gAy4zpNFSHeDOTpz5iX
         AvZmPcMsaSZeGCVs70qTJgAkCimrqC5deZRTUL+Sm2qc/IJSMPfcvZWYyQujZ7zHbrbQ
         Q5H/ohqeukTmiqsSz2mtaBNgVTBFirmf9JOlrc1dM7Cma8vNf6cNAX6sk+nXTbDHSPDb
         CmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jhAQDFE8ar0SGrs8qiws2l02YCzdpm/lpwcCQDXOlac=;
        b=mZ18RlXHAVfxh8Moe0rCFvgr/Mh0NT2S/CgCLDyoo/j+bw6vtsOnLZDqXpqUx6BP5Z
         Iyz7i8MCim7g7tcx4kUU2d12IG68m+B9Y/ELnYbiirM42F76wI8a8lTSBx36Ka8s6lTR
         YAP/qkNc4+hMBT/+sactmguXMAopuDrCuloV0bOAqgjpalhzbRehufb+aCaQ4xfeFlTt
         eSHGHBqMzHnr4RbTcwUSjY8bmaUADnWFiuh14tgigxE6WgklMB4tW30GUpOI2TRySDbB
         W++cg6Y4S+AtcS9JhCQnu9/HrLVT+IBr9D6Gv17t/BkceX98FJeEbHlwTC/RPUqo//3h
         I2cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicolas Pitre <nico@linaro.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.4 17/33] console/dummy: leave .con_font_get set to NULL
Date: Wed, 21 Feb 2018 13:45:00 +0100
Message-Id: <20180221124410.520707607@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014631678388583?=
X-GMAIL-MSGID: =?utf-8?q?1593014631678388583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

commit 724ba8b30b044aa0d94b1cd374fc15806cdd6f18 upstream.

When this method is set, the caller expects struct console_font fields
to be properly initialized when it returns. Leave it unset otherwise
nonsensical (leaked kernel stack) values are returned to user space.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/console/dummycon.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -68,7 +68,6 @@ const struct consw dummy_con = {
     .con_switch =	DUMMY,
     .con_blank =	DUMMY,
     .con_font_set =	DUMMY,
-    .con_font_get =	DUMMY,
     .con_font_default =	DUMMY,
     .con_font_copy =	DUMMY,
     .con_set_palette =	DUMMY,
