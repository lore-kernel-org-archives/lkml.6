Return-Path: <elfring@users.sourceforge.net>
X-Google-Smtp-Source: AH8x224DDp+aJyfy5kev1jzyU2zKeRR5LCGrQ0ktRUKs7rrIq05T/hrOo2AJJTdyyD2uylTj5Xun
ARC-Seal: i=1; a=rsa-sha256; t=1518553421; cv=none;
        d=google.com; s=arc-20160816;
        b=lbC3J0nMJYMxbWIqtua0areyrd2YXwByFQ6dnEfOEGG8jllUfQlgZ98Fg0HKX7Flie
         zFDCZwo2F9enlwcpbOzHEoE3OELlzOFXGlHlWWr7ML+24iIoJZ6SZlZ2PcDikP2kOvlE
         z/GmFtfBtIo2JDqILEn/vlgsLdxa9WyC6tPU2mJbSLZjDAcOnNF3SKVnqpOK2eL5keUf
         TOq1yjBvjgA5Zsdg4PmIp1LIeofHqdxz8REcANYrYvdhKUQXPzq3kKOV/fLyfQwqM+T/
         KPyxFowb7i/5H5k4ug/M7hk+SftWqvvuvrhzPQHJO5/or/LA2BoMZ9IxhL1ASh0OxkI+
         G7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:arc-authentication-results;
        bh=DsKSJj01qErV8gNCBgKJ1R0pgCVSToiG2WTOrIN6dpA=;
        b=PBZSQcR7bLaK0xdCW0O9ERc24bd1TG02EQydTCUAep5pN6OSqxRAUdsgo0DJ3FGYgv
         9ptzqfOYxsirE1TC8Py5iTdaWXktE6aSUZOtENywTtVzH1BgyiQNQwVF8cVNw503529c
         mw2DAyLZiIbSWj6L+SzjHIcjDv1KlJKLz3DaJvpC8ahWdsJH/VM0K2DXceKGU7LkOA5R
         +oZSYVOFXdlWk/LuXZPLnpW6RPoFRiG3ZClDEI6nz5FMHL/HYIe71vipp4G6PSM4IfBn
         GLL1O1Q5rLoLG6dxVqCYozyRxOZp43ZdMhp2bwaDMuxuxj4XZg3KDEeGN4VQFIYwqVg7
         q1Ww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.15.4 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.15.4 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
To: dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] DMA-PPC4xx: Adjustments for three function
 implementations
Message-ID: <4d9b3ca7-e1bd-42f9-5933-550146812f1e@users.sourceforge.net>
Date: Tue, 13 Feb 2018 21:23:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:N0Y1XUIieratTtjfLrxke1Y7dazh1DU08d2LGcqJ0yKTS8CxYwB
 P2jPZ01PQIND53J1G3N8Ij3WlEXf5+CTEVpQU4WQyuAOQlE+WqS3Z891YeJZP4uOmkk+YlF
 /iMc96DdgyPVfvw7N6yMEeAgBVTKNQLaP+Ryn/49Su7+g4MJAiGmBtqGSNKnDF3/5ID0/8S
 0tviDAJBm/Z+JXsIp0aew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2zj2uPmZdo8=:HnlYgpf1bzX8iVNIMbqAbU
 1iOhqyWo/RAXUpgiNUBZRoH5psiTLR/SH+d6jN6R5axMRJ2bwivbbkUzLDjKqQgCpuh4hlnw4
 KgVfE09Gdy2V/KDl2zpb7XbZb6Tg0VevOexL07JCS9BCYf7rRLM+l1RKA95Bgt+H9KLfuZIQp
 Qj6P9k4V91b2Rm8A05fwCIJqDMyzi6gjlxxJgUjIest76YiPEVRbzr43A8uEOYtvBZCPbdoau
 zFVxEe4aFdqH5Zcqyw3qFQCQBfRgRhpAd7OvuZ8EjJB/08aiQwSnqgGjlxl/nMhWFdNynx5Ow
 jG+ZhIBPAiJ3WIBudKtgm+GO6zZi1NheB2lE+lrNBvCok10ZGunVFM11I8gYq1H0wR7boYaNU
 olBOkFAeszF5dK9EmgKVrnHMMsCyPuPVBQ2CQo8PGfE/dsfrm5PD0XToRQ9Sjs5S87youvdEx
 JfXZNvyPvQoeQVRiKLJMGWInuy6xFpLBAcDPPefU4j8aUs7wuiqUJxo2V35BKkblV4GDgCtSL
 hu6W4ToLWsS35d0kZJLa1fC8uWGXKR/669fD/nRugFu574atE1r1AfCnUpAo9eVyMwkdrMDPq
 SY8m+jwMIR1Rjg+FDS5H0zDT42ahuwaKkVC9ThSf65HRW9N/B3U+bge1T0Vgnn4ZL+KOUfUD4
 FK6uAm26tJVRg7BQel9AkwNgrTH5OOAwXIj3pj/g35giXpjSMFL/02J+vlSv4UYefCeBA6O8g
 M5Q1sr6b/nxQATzii7VF4yWqc42xoGmb3wZketMr4chzrI0tHRC0J2VUFUIuF/sl1z6asWoU0
 cDwZ43B9iumrE6EKXF78Fm4rKWMULDjYjP1/hN/8UcqF21pbCs=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318672190098989?=
X-GMAIL-MSGID: =?utf-8?q?1592318672190098989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Feb 2018 21:16:42 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in two functions
  Improve a size determination in ppc440spe_adma_alloc_chan_resources()

 drivers/dma/ppc4xx/adma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
2.16.1
