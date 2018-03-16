Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvdDb/cNgznj0X/Kec8Ev1skSKUFLRvEv+qeg9FrK3u3MhGaiIs2tN/EV0uZCnl5APSX6nx
ARC-Seal: i=1; a=rsa-sha256; t=1521214717; cv=none;
        d=google.com; s=arc-20160816;
        b=sxHqYkAxERnI1rgUnCOT5zqepYJMd16+82M7UwvbiHRL2ECRMeDtTri2yvPit87VVe
         SS5o/cK4vqGcoIbb0BgPYyAouiUy+43/arX7xeZQ9TI8hiincaFVIjGPzAOemETE8bnC
         i+lDGI0hQV4hX73fP44rs2FoY1PMrKej8KIchs4KphwgFNaCr5mkuFj2T4M6tP34TMpW
         YEK2/c6abGvg5Sl+44xh8yqeM/hYfmiY35EaYUFQfOJNx+nuPFsI22frhjUJ04zFHIFO
         /Q1vHCfsLDORZ7k+fXreIU9mTWtNKvlt6N25++OZG0wbxH3zS0NXca7ncF3X3Vd98m4V
         Cfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IqOJXIm+jVUR9ePtCoMPTRHUC0j8deJl1vt2FwXaXkg=;
        b=QU966Wb12eBQ9LWLnmcnIrDwXNH+nIlOz6B6Zei4CLFeztPe1gRvZXVLqn6GN+WI4C
         c1+zthaEeFHXiXKaeIYwoYrmKWI/Wv1KiJ+HVvNDENvE3fBDeNGKrjTcS91Mv5Tu1QZ3
         jVMDTvh0PAwtk0d3/+PbvqtNuxmZ2Q3L/HQsyuBZ8qJzGLFi17V/CM/lN3IGaFyndCQO
         FlaWNYk+l8r/C6mti8ELRqqpF2CE3GBgdWo/JDjgMwKSU2tFHp5dtuyepFcBLPPi8hs/
         bifpjq+XV/itLfyw1E/WTj+QUqQWci0TFaUECwaYv8JZgr+FUK3zVmGX/o8kYsc9RV/W
         Q/xA==
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
Subject: [PATCH 4.14 068/109] pwm: stmpe: Fix wrong register offset for hwpwm=2 case
Date: Fri, 16 Mar 2018 16:23:37 +0100
Message-Id: <20180316152333.691702673@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109244339957459?=
X-GMAIL-MSGID: =?utf-8?q?1595109244339957459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
