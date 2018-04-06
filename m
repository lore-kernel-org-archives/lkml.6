Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx495gIEit/THPqH/6r5imYnV+59klSkeccMq+iSwhZ0ckx2bPuuLVbzBxQ+JGdzIKWCGG4Ol
ARC-Seal: i=1; a=rsa-sha256; t=1523021469; cv=none;
        d=google.com; s=arc-20160816;
        b=QDV8Uov8IUXCoIOl2zLd/oON20pWQcP5jZmtTFgUXQDnK2Z5cpPnRbAkk/HTknOaEG
         vmNR+25xGdqfrQXuHHDdFsu4F+UGX3Qr4CwIJe10cgyWBQrJ+BmjPhFk5JPyEpE0dYxW
         OiwUpKVcafE8jYp43P3HkRjoEbuvMVI/sJXpDDCQp1V+yhHtsH5epvHpPSWU7M0x93cy
         RoVQKt6xxUcVvN8q7NDkSLcDa+WMt3kbSgpkPVFRFPg4VJGsBSAZzX9XypoQi00lbxuy
         GL9mSzhIZI8WltOI0qpltUtw1OXERXUeh6A+k1S6l+5HBtWt1+293me1FHDJpoeEHtc8
         vYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JQoUYrI6hP0j1h8xsq0kOA/3KeIGWCuUZHEYNSKXVho=;
        b=TUD54GNo/nbAZEm9iXkKPVals9DIfwGmxx/f4CWCAI9K8s+4h2xCGA1U8RksNQoxb8
         nb76wb02238BfSfUO7yevyiaz7NijGCMT90TBZcIlAmtbSqGB2FYqYHlyisKLhIs0r7q
         iRCsocKVkVf23V+FM0WAwYY35KMAdODAAW1Uh0dP3EOq9W4iu50/Aai597vajc8AsOx9
         SWbRow/toJ5EU3PMPQV7U9hCZqj469kEBZHG3Rcx6b696KXEP4uGP3y/e+I5lrGiHS0K
         BIFqRTiqThrVCeeOGy2XXSXGZbIeJqgJ3mBKVsc2UuiPVUViCYanjl4IUdn3TDiEIfQe
         RFfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Mike Snitzer <snitzer@redhat.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 15/72] dm ioctl: remove double parentheses
Date: Fri,  6 Apr 2018 15:23:16 +0200
Message-Id: <20180406084306.347751349@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003760341389885?=
X-GMAIL-MSGID: =?utf-8?q?1597003760341389885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit e36215d87f301f9567c8c99fd34e6c3521a94ddf upstream.

The extra pair of parantheses is not needed and causes clang to generate
warnings about the DM_DEV_CREATE_CMD comparison in validate_params().

Also remove another double parentheses that doesn't cause a warning.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-ioctl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1773,12 +1773,12 @@ static int validate_params(uint cmd, str
 	    cmd == DM_LIST_VERSIONS_CMD)
 		return 0;
 
-	if ((cmd == DM_DEV_CREATE_CMD)) {
+	if (cmd == DM_DEV_CREATE_CMD) {
 		if (!*param->name) {
 			DMWARN("name not supplied when creating device");
 			return -EINVAL;
 		}
-	} else if ((*param->uuid && *param->name)) {
+	} else if (*param->uuid && *param->name) {
 		DMWARN("only supply one of name or uuid, cmd(%u)", cmd);
 		return -EINVAL;
 	}
