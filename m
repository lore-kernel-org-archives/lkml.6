Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-703119-1520227125-2-12112867579020911729
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227124; b=AM1+TC5IQjFWhfHdI9/yAgL3jyQij2m0M/hGCu6we2VCuk0
    4JIysftGjV51vpp8kLwY4crsb0OhC7JncBQeUSnfTUltqFXQmbt8hqjQP1gLNWCj
    s8rkd23xA9HQO0NwxVV1VEV/LFSH+RuLNTLmAi1huCPIEjwt6YoSGiOktzICgSGI
    9ylTpAf897YVDlPF09z41IJuxDGQZ41NSEJH2/KnnWgctS+z7R5jRY39F8by0A9N
    cTe7ZguplzFdJXUE4oJ5il+d3W4/bAoPOudXDPtjK5Z7BLmT9SpXNSvdTThsvOy1
    +zO8z2rRcWsyMa3MGIj/qkK9QxZwi1EZTQexmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:cc:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227124; bh=hlfnbbCV8SaO4HR5pUiEQn7MsHMhQTEO+1CcZMYV4EY=; b=b
    Spc47gBUOKGwv/UqYybE2igCsWvF74hzp0ASbqoWJ7/WatR/cQeyD8mVT45NS9GL
    3NnEKGLv3t/S1NEKKWFXYUNPmmDCgXwtvP0L7D+aaZukapaFcSMYBY+c+2QSDMuy
    Bo5X1E/3SsMeeaSBHNnXnS8p0/q60/TN8UzxvrQ4I1puEpwnQTQHgebOS9irha7s
    eUKKIZ9qBLn7Y2EQ/NLgZi0z5Ro6khnQbKWEUK8RZsjXNnXYcCUYe4V+tn0GGstZ
    z0lcdfxFlxgExbReQOuOXr3S8ntd5YLv8O66XljnjFV2ncbFhDQYUbQl3/NsfJlX
    76I9LoCk9bYmo/op7Zb3w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 02/12] hyper-v: use GFP_KERNEL for hv_context.hv_numa_map
Date: Sun,  4 Mar 2018 22:17:12 -0700
Message-Id: <20180305051722.19157-2-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051722.19157-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
 <20180305051722.19157-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfDch5AamIWLDIzqOgePNspxa5B1ze5PJbibwdrjSc3LyMWF2ZybMGi3dCzZ7J9zAtyWmyyIv1rKPJeoCszvBXIOdDLmw2oDbzJk/pVfza0ouxX4xKr/X
 X3knNurBSkIIxrmCdv3vUaGKcyJRdmxV0CoHNTxov+rAIi8S4a5NsDlp+adK1dUvCK5R4cB7H9FnGHPPgA0e9wGwdwY/4XxrCcqMf6oKOO7SKrQoBfivCC0K
 rBDWgt5Wvz1nuJ6O7GCrYsyuj9kQVebkCiB5lGYel/vvh3tJto6qJc5nLY/7Ymqf+lakPhrC+p74znwa8uRJywQkj88+v4tp4Bmc8l98dqADmZ+dFJ5jQJuq
 MEbb6Qxh7qC1uwkNnL37RhRHeAFuwFz3Mhvt1Gg1TNdaNyE9/kiTDv8nNe3iP6aWIcsL6Iqvb8bkfQX+QnQ54Wb8sk9fwnubFT6jrGNBoi1hf5Y8gZNx5MxX
 H7t8/gExlXC/VzwXFqg9uAY1jduLDde6B1sjmECskw+eMkWp0NXM8cFYsfGaIwh739NiEp8kxSzxPNqSF6a3qgav64Ooi8jQQWcuyfvnVXdSIinMqBeXyhEU
 9qX5VVVys4rA88TjVCwwwQIe
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: kys@microsoft.com
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jia-Ju Bai <baijiaju1990@gmail.com>

The kzalloc function is called with GFP_ATOMIC.
But according to driver call graph, it is not in atomic context,
namely no spinlock is held nor in an interrupt handler.

This GFP_ATOMIC is unnecessary, and replace with GFP_KERNEL.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index fe96aab9e794..b6cacc4cccf2 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -147,7 +147,7 @@ int hv_synic_alloc(void)
 	int cpu;
 
 	hv_context.hv_numa_map = kzalloc(sizeof(struct cpumask) * nr_node_ids,
-					 GFP_ATOMIC);
+					 GFP_KERNEL);
 	if (hv_context.hv_numa_map == NULL) {
 		pr_err("Unable to allocate NUMA map\n");
 		goto err;
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
