Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuqFnDzsvUDq7B74MOeplKxrYddf9kTweA+XamnIsT11bJRWHuP2NK+coC3D9561d/4EVu9
ARC-Seal: i=1; a=rsa-sha256; t=1521215074; cv=none;
        d=google.com; s=arc-20160816;
        b=rtbRdLUWGNDkpKWK/Tgx2Df4LSwk9iDilN3tRfrSCftLeHk+Qetk5Cne7V2waPWOp1
         ZV0pLFcXqyq8/69ZRyX0k8zUc7D4rNjgq8+aeyVw+PStQ3NT400vrWBdPoZqNVAndqpO
         eTOs2qx79xH8z7fRt0zkOnyWEHo0PckR05NLLdX/uvfu6tQiFR7568hlWNx+QilCMGoB
         K/mch3YnvW6Sl32AwYGgtDDTdWEj6I/sVHApt6dGYnT2XmvSwfOnNVi77DE/L6Cc/7GX
         p03+7Ba9sNPrMMgtZ48NiEwF6Ynw2lDHEnaky1ELKOgPReeAYBDy0Owa76PTn79NLBKN
         zf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mB3SOO3TUVpMygA5cQK4yJ08XX06ykQ8QRA2XKyO7BM=;
        b=bOAdu8xZB1Ldiy5LF/h4dlsXcnJcLYL5rPNAR4UmlMqdN/PloLtqpnz3pIT9wwPtZS
         4nTA/QPQBdXlRHqjRwQlZbSLUnIC3ANFQp62PC2uRElMynLi/bkmU8XZw315m4y/0tdX
         KTPPTBlbzY/W09jpoqdM/llBR1cqrfn97rCAjYCthwmWgvlY/JF1CMMVAgV70J3fbUah
         Pu2mKJ+x/qDiynJyphmlnE23dbmxBtSOgpOyHeTH0mBLDvKftk+jdFUS32XSFszrdG3X
         bHkXdIpzYlNUOeOncByeckQmkZrDzo24VmirLV1rl5MNBW1VCD9t1fBD4s3VI+bzg0Me
         xa+w==
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
Subject: [PATCH 4.15 083/128] pwm: stmpe: Fix wrong register offset for hwpwm=2 case
Date: Fri, 16 Mar 2018 16:23:44 +0100
Message-Id: <20180316152340.756526353@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109244339957459?=
X-GMAIL-MSGID: =?utf-8?q?1595109617500003411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
