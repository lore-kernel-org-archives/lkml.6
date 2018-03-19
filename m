Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsdcPJz0nCg2wd8tj03r6wv8l4w1E5w5KWglcl19Pfi1HxkN0yW3NliIbLUH0Ga55pxlDfP
ARC-Seal: i=1; a=rsa-sha256; t=1521483976; cv=none;
        d=google.com; s=arc-20160816;
        b=cJp9m35/peNfLU1pNbf9FeuThh21YFabnqUemfQTsPkcfhm9aCw8alKJF9211nyvwb
         ymaVlOwdh2rT4l7TFAKckzd02z6Bea/N0sfgrBi64FymVaY79yl5fVO8ffItR5EVA1Sa
         FkOidm2yE5tj3QwJm3LDYj6DJm+e/PlwP8Q7mRMNtO5ZuM2ePY3ytZ/lp+I1rG6unj+Z
         08zr2BeRAWgeRbvCJJGr06XZVKzXeHIyZTQr8GPCR5jkrS8NjRiLfaFFUxlwu+Sp5ZOE
         nsIfxtIvfWYQOaHqza5+uP4nEgvo/SyqVFAwVb95MHV2QveNpyr6pImdIWDlzWaMHyyU
         IV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r36Mp3VgBLM3fr3DxwIfi/UXkAy4ZwVIAHY0E0fbK98=;
        b=Dl7csaHHMzV4WikEtqnt2TmVlFt4TaPEi5Ox3AdFyw9wPXvUH2b4scygArdPyDRW8Y
         2+hBQGfmUuAScR+fPD06kOnY44kZBefe18JEpoCfX2FwO2TI4Z7JZ2l0RsS3M0O6cIPG
         LrQH7CL6658r17NbbJCL5TVBrXhNuZLVLVmeCByKAmgUeXcvgcNCmVSqNqj+LOMSBwGr
         FnNT5SUO3vBLYeOji9njWIROdnp+BcCPQ4xV6uKAqi6lgzTdSubTF3Fg9314pT3zoVTF
         hibPgMtbyuYTw/03JP3b2FH57OqMUaKD08dgBByeSp/MfK4+Cqtkn3g2/14f18/9EkNN
         enZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Axel Lin <axel.lin@ingics.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 187/241] pwm: stmpe: Fix wrong register offset for hwpwm=2 case
Date: Mon, 19 Mar 2018 19:07:32 +0100
Message-Id: <20180319180758.893342042@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391581941121821?=
X-GMAIL-MSGID: =?utf-8?q?1595391581941121821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Axel Lin <axel.lin@ingics.com>


[ Upstream commit 8472b529e113e0863ea064fdee51bf73c3f86fd6 ]

Fix trivial copy/paste bug.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Fixes: ef1f09eca74a ("pwm: Add a driver for the STMPE PWM")
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pwm/pwm-stmpe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -145,7 +145,7 @@ static int stmpe_24xx_pwm_config(struct
 		break;
 
 	case 2:
-		offset = STMPE24XX_PWMIC1;
+		offset = STMPE24XX_PWMIC2;
 		break;
 
 	default:
