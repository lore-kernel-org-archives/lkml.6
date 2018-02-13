Return-Path: <elfring@users.sourceforge.net>
X-Google-Smtp-Source: AH8x227/XchWQUT1fiCMuaGir/AZg6xbux2QNAUcRZ88VWyMGPivhTl/zWk+dEKRN9OgF0IF3ibm
ARC-Seal: i=1; a=rsa-sha256; t=1518553595; cv=none;
        d=google.com; s=arc-20160816;
        b=RX9PNhLv37MxnYG/x+h9w4DJU268fVAc8JvvictOH1gdMlK/iHcunsMr+1S8wECgYt
         UVf2SNERzJ+fxQfYlLik4DZHYIriA9XuthcSmvGCCi3bpqY9ADpaDna6swZ4R4fRkj7P
         jViwAOobcdMkGP1XcY3kDEbJKH9coaL8cPIt3CobdqIiEkZzA8RmjslbhNjmV6oe4bSp
         OwE0k8T4gzorY9tn5E/j20iSqCjKHImaeNTnJ/NDHhtOIHJRYiZgxQJpGphxMhd2NLBc
         JOX5nW7qE4mkgF3VKx7vhgFjvcPhU2RCaqhcmWcnqCP1RmNZ4+CCM9uKFCBtP809H/nf
         T+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :arc-authentication-results;
        bh=LA+hxH8cgDsX6IFyoIEjQEBqJcPKFZIrtDogTR5Qosk=;
        b=oBRPNNCxP7DiciVH/zhZ79e+Pqqrk23qIIaEIARt1k86nfFDdw/RIMad27SaPNa6uk
         syB0PQ7/yjpbnxh34bwpmsxXptX7viNj/WeUE2PorUtE6SpqiIRcYjGYoKWX0yg8rCX8
         TjvY7w3IWrghDjHCE+lnN0to1YjGnn4VHlVQxyhFET399Fd87RCAGC/KBAPZN/khCzZ+
         QgXSnYuRWMclS/sPXAQs2GL+ZzG5cL7MJ5Io5AW9rFqvPdLzhbLYV4gf991yf/ubYqrK
         JEPjLsjidfdK8OeNc5sOyVqvCLPmxALaRp0kCMg+ZJV9Q5kQDhjUXAfRH0vbiSRzoHFU
         U92Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.15.14 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.15.14 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Subject: [PATCH 2/2] dma/ppc4xx: Improve a size determination in
 ppc440spe_adma_alloc_chan_resources()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <4d9b3ca7-e1bd-42f9-5933-550146812f1e@users.sourceforge.net>
Message-ID: <f6cc6095-0ec6-e9c4-176a-cd6af8c7ec4b@users.sourceforge.net>
Date: Tue, 13 Feb 2018 21:26:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4d9b3ca7-e1bd-42f9-5933-550146812f1e@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/dytd3Ygm+m7e4L94+FKJ10wySgUMj5WZkv4IQUtpaXjsyJ/IHE
 /4JZlKDYcmAWL8cENVK7NT63K/x0tBtQJguDnTocABTzxix+ZOrSo7crxTQJr7Kr4TpVRRd
 c8eoNno2bAYB0bJ9a39XriNnyGx1+fdQJ8BwJ4UUXlAKpeub+twRn0iOyGuncXh3XnTjmbL
 zBzsLgvg/Siu0f3/A7ABg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M1OIfSY7lgU=:BHz7Nvm1l9ffp5FXAEVBT3
 +yxsXOLClsvEO4XKwkK1N2XCfXg8JMK5bszbkm5n7Uu+jW/KsZb6/LpRLJBRu3t1JIpe7vcqO
 IpQH0KRTpgw0AXieY2BMU8ceQAzsJkoI6f/y3nYRRmakMVhfhl7kcDabxjPYecwK1uiNO5/j3
 8lxGYVblmCeUMCh++2INJkGvwGfXDI4QGvxiN12iu0Zfe/N1VMfGNwX47WpH3T19ZKzRbVpSM
 fEQYMxw3XnthXpLH8rwIPMz8p2CYBKmqywLQvIIbTs9FgJOv4saz74mJGEpai6aORP1c4xmVl
 EJvTxOEuTh/3YvhQy8BV/bMvgrhBpMHKGeJC/shwDKRzNzfar5AjQNmPjKg2x8TknGj+2pwJu
 DBpXwMZgTfEK65/x+tc19G6+yH9tlR8bCX9zrngFJz0ObFVRZNSKf1DNqkKND5vF6uY6OGBtM
 +xTic1At9aUV3MebpX74TN12Cq93pOa+tIby5dsJQoG7ZFMU/dn+2mKfFZgphPkuRQ0j8A08G
 TjdH+2ej3dNK2C6kyKcldl+x5QD3MsXCxVBMz5iX7JyPy8jgp5mNZVbuQ2zphXOsFNWWxFNJG
 CpO9xKuL5Zm6tquQO1ZNk9DbzXnLqH9FzMbXTvAAsqZ3orzWjSIY2cyw6EZFpWuQXmfaVB3JV
 HSCrw7IvjVrq9ul1mc02tArZsGc0xY7ArG5475LVmqWIIscuGXj8Ln81vnYMMIWEGeX45pzxs
 kWcIiolmYAmWntBia25HDe2Keh1cVYQGamt3QCXwwI1G/+A2WZZf1P+3pb9E3FqUSCULGNxns
 azXgv5l4w0cWO5upYf8QSUOzONwI1g7NuXGQwjhfvfvF/9OI+A=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318854522614602?=
X-GMAIL-MSGID: =?utf-8?q?1592318854522614602?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Feb 2018 20:54:30 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ppc4xx/adma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index f4033367d59b..27ea48a2c1dc 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -1795,8 +1795,7 @@ static int ppc440spe_adma_alloc_chan_resources(struct dma_chan *chan)
 		db_sz = sizeof(struct xor_cb);
 
 	for (; i < (ppc440spe_chan->device->pool_size / db_sz); i++) {
-		slot = kzalloc(sizeof(struct ppc440spe_adma_desc_slot),
-			       GFP_KERNEL);
+		slot = kzalloc(sizeof(*slot), GFP_KERNEL);
 		if (!slot) {
 			printk(KERN_INFO "SPE ADMA Channel only initialized"
 				" %d descriptor slots", i--);
-- 
2.16.1
