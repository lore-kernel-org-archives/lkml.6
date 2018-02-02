Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225jp1ia+2KDVUc1jFwFXBDU1jIcGZn+7N3klett9lFhq8eK1YJIQAtjUpUYwpejfAEmhbfU
ARC-Seal: i=1; a=rsa-sha256; t=1517590794; cv=none;
        d=google.com; s=arc-20160816;
        b=xP1HTV/o5GcOK5AXIwssRAYrhZhTaQVAQtbmGXFTr1Fh9Xv0ubDUKZ9YBJZ3L2GHkF
         19UiJU/PocOxq22QeteZJR2/gNDq7rg1p2qCgSDqmg5MQN2wSoEMQy0G+Ve0bYe6S3Yr
         ZrfiP65DZKaDIRNfAlkPsyhae9kDmvSsyQUHaT+CCiYo61FGzdfl2b7/qhOk20coQVjN
         lW4EM2E+8HKB1Dx4EL1uay18U7ZAjuDS0ESEpccnQrYwPQCJguV3CmpYnv5wD9vd2u1U
         M4tJ5vWUJLcAq/90sHMJaVXCDw5vMLSACM2TalzBpXdxbAEu1SM7Xas62r/I1SuVhOar
         Gm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yBeR4rL+rCzl6t+PXvleMTj0OnmERxeDBYMZgBS3DLw=;
        b=Ch5zxNym0yXHJ2krmUT10PyMZhDqWp7cPXu/4XK/ASjx0rCHSONSrJx/zEuwRjwS3t
         j3QIWTXlZC76D5uiFzxJCMkpD+izFUQzbOsqitkPEwACw6gJgWffAMKFAcPloSqAy3Ka
         jXQ8TVpgOXcZ3GL85geG4zt8vhohLbuYdCQKkElVU3/ur4z94SdJ3J7F5+8K8TMbtSBw
         YxDAzagmzTrca+gvkvTnQR2lHxX/aA69gS6AsN6sryPMaBtkYfoECpn1FYPFAlL2TbIW
         f3LhILRu3FqTPw1fhJmHTxJv4C00GLxkHUa42Tgmdt1CtnPjUA6LlERSlStIfxTUlvDv
         vlCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 4.4 16/67] power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  2 Feb 2018 17:57:45 +0100
Message-Id: <20180202140817.078588941@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309284971476790?=
X-GMAIL-MSGID: =?utf-8?q?1591309284971476790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 348c7cf5fcbcb68838255759d4cb45d039af36d2 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/reset/zx-reboot.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/power/reset/zx-reboot.c
+++ b/drivers/power/reset/zx-reboot.c
@@ -78,3 +78,7 @@ static struct platform_driver zx_reboot_
 	},
 };
 module_platform_driver(zx_reboot_driver);
+
+MODULE_DESCRIPTION("ZTE SoCs reset driver");
+MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
+MODULE_LICENSE("GPL v2");
