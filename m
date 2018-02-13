Return-Path: <elfring@users.sourceforge.net>
X-Google-Smtp-Source: AH8x227by+QPwf9YpCGei1Vs/DfBhsefQXqVXvRtSqrJLjz0F3bhtCBzSFAN1Bu7/crFUH/o5qE6
ARC-Seal: i=1; a=rsa-sha256; t=1518553518; cv=none;
        d=google.com; s=arc-20160816;
        b=VNDasi6wM9zlkgDhpy4qn+Rj8Uh4WxdO/B0gBloomCMVCRVx8uX7mzPTUdYY+jWhck
         s1k/sL1OZzU23wP9KaPIi8Ta9F7iFvBgkxQ+ZclRPW77OfiGbCwUSvPxNEZR8kTtZYyO
         wuGWNWGOfiE/0WxwWgEBH0pi0O2dbL+5xjOry5bQr7gBYd8wtDDrqrjG/dIOuEXigh3l
         BbsGd7N3cd6WkfRhrh8O30QwnnURF87G5GxEV6Szw27DBpMUJweyoq6Fmkr6VkwFpKYm
         3QW1zvdPoP9UfRsNdm3VMKzT/HSZSEz9Jv4Al0Y4Mwcri3wt9BZtF0G3heqrSetssA+X
         +YKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :arc-authentication-results;
        bh=2g3nE/HKNfsGjpLj7RocvhJ7g/O+KwMeWM++yJxN8U4=;
        b=MapjWj9+/L2/v9GFT6Mwz+6lJHLDwZUCCQTrM1dkzs0DxslwZHbRWmMl4Ac6V9Zg8S
         CzTUMYaRG9uBBgUC3stTtdCKf2Cg/qyjI/EmrSanHhhvI7O3ghBZ60uetcNimDsFUEcf
         n/ZiXEsfTAtsST+rtjSqsZqd+OhiLDUofqrdSpgj/k/kC/a7nC+d5RShYsMJkqWbqYqT
         uR+nTB51SRedC4rcwJrYMnM61NvcxNtgUoCTL2/xI09YPCS2RIGNWt5PR96XuHll7qsE
         iKFC830zOcYY9iHr28isld64SCQ39oHaSFQa28OooAxGFgHAA97/YPukIRu23NZVe+ys
         7NGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.15.14 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.15.14 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Subject: [PATCH 1/2] dma/ppc4xx: Delete an error message for a failed memory
 allocation in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <4d9b3ca7-e1bd-42f9-5933-550146812f1e@users.sourceforge.net>
Message-ID: <ce6646e3-dfb5-2496-2a3a-d41de4802de6@users.sourceforge.net>
Date: Tue, 13 Feb 2018 21:25:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4d9b3ca7-e1bd-42f9-5933-550146812f1e@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Zmg/8+I2K5Jt9JM81WYjUHfzEjvuI6duxqBjtUp05y9PYHTfJS/
 qgEHgF33ZliSHKGv3NXLd18Ae7AvlltQcgzfOqpTgDmzhHx++z5V73sy+74sh2af97Mw+VI
 bPt8fS5vwvyvTReTNnxhQOL1zUKqkdlgeT73pN6LOS7xNjXlGKBhKqulI6PiV9LVd3tMZqF
 dCHaRVlR8g9DTGZpkhpkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:59g5f+wz5us=:sWHm9m82qWv/smSa29vq8W
 T8kGuiCV4PTH8bBY4G6soo8Rydl0quud4SvbjdSoMuYAcYgbwGoIs2uMxoiUHnRXnKDfaToBs
 zh4du/EVvxmnAxmNKrrbYVwHglIft4U9VY0TOg+SQuDDX6XkfS1aBA2+O3tPWCTrH/vm/j7Jo
 RICEddZ7lnB6L7H63U/KZnf3GCeGHzgw3Yv8ODrCMknH5td09BDk6ZrlNlc8MdTKLkZ9UPSkd
 g3xtNvgzWrRomdJ3xyHBZPwMnGJjtJl/SVfsEgYDgGPPw3TCKLn4QbwmJB+ooorTzMD9ytbYQ
 ynQbT1+KSpwqndebfnzEk86LFD8ZgnE11rLD0Jz3FJBHGmVauQRDDBaD85EeRy1s21EBU/fKH
 JC6kuwlK6upbwoUdhb+OWlpall+oXNt/fbc7YB6EDc2WoaAWPFcm4Z0MjfYK4Owfej4laHcF7
 eosPksmoZMlqAO6ugTUmGGvH72b01AUQ+BXu93+8NEiDBf6HP+9OfDrru/qfxFP8aqLSrnP93
 DafM37NLCtDUajKHdue29qUizDtfmOdcPzaC0K9CxRU7j3kAuCaJSTo/ERBJwdzvtcgpqCHKf
 AHokxyHeCzaQGUVGtxIiGtYpNscJhCFkcFmH/nawA3dXUES7N07PsUduoqnPFWcjqf16hYX5e
 2nQGOW1okUbb75DkcLAlwa/O/h0Qy3jGYd/b5oVENIozSilXiz9P9sjII/Jxif9Ac7DZW9ilo
 yU4eB+wUnaMldJLmbNLmY70PZ3hcVwOfAD9TdFekbDViYkbM7aKhDs5o6nwXoy9+QCxJgErOw
 jaGYSAWks3aQVq36F4RbcdXemAl69vbUeTHmM1aAqsslq3e2U0=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318774436342324?=
X-GMAIL-MSGID: =?utf-8?q?1592318774436342324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Feb 2018 20:42:40 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ppc4xx/adma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 4cf0d4d0cecf..f4033367d59b 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4183,7 +4183,6 @@ static int ppc440spe_adma_probe(struct platform_device *ofdev)
 		INIT_LIST_HEAD(&ref->node);
 		list_add_tail(&ref->node, &ppc440spe_adma_chan_list);
 	} else {
-		dev_err(&ofdev->dev, "failed to allocate channel reference!\n");
 		ret = -ENOMEM;
 		goto err_ref_alloc;
 	}
@@ -4468,7 +4467,6 @@ static int ppc440spe_configure_raid_devices(void)
 	ppc440spe_dma_fifo_buf = kmalloc((DMA0_FIFO_SIZE + DMA1_FIFO_SIZE) << 1,
 					 GFP_KERNEL);
 	if (!ppc440spe_dma_fifo_buf) {
-		pr_err("%s: DMA FIFO buffer allocation failed.\n", __func__);
 		iounmap(i2o_reg);
 		dcr_unmap(i2o_dcr_host, dcr_len);
 		return -ENOMEM;
-- 
2.16.1
