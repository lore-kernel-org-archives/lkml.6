Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3076317-1524575923-2-15716744687177142244
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES da, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524575922; b=lPpoUR8LS14SbDisHSbzYGLmd+BfsVdqHv56JDESuJsqFVz60/
    dnVUUPMHy30HiVw90IaWA+XT03R6Ef3RwzumoXMgRNscxPmyfmIk+SydRDJUV4il
    kHIfRnsY1C71j+r2rJiI463stVdl4KynKy0Rhn8L8BGsN/eqhX0qpLfw7aFp8ENk
    95dbheMjNQNsaJ7rozZV6uLEQQIm1TwcOf3Y88sHFfkrAYlRLe4XJNJLDb0OLJpv
    k2DpQWu6V1bLlT/u1QnPosWWGPhTuquJaDbyAxW5CtT/v3Gy704Gxborhtx+j6KU
    6e8tZacM389WYNEFRLjI6laNSSoihsdvPFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524575922; bh=jXWHD
    7YlVuwo4qgnvuATtPWw4F9tEI/rpovQ69/HFRs=; b=iam4aWWVOZRAf+YCc4+ah
    LM3qnsnMD0nTw6V6N+rCZ19YYIEUelpFfNTRUpKt9Zede/wsSwaDND684Vw8+QZB
    Jyfx2T8J6cP7F5hBKvbX/CEsFt7BL2zMf0yn3TnAppkDg+VB0HSAsagmZd7fkDRU
    wpbxwAFROV9XzDthyYbQJsemC5XQY1KLeyTfGY+E8wp8yeyTtcFf6nql88vWi2xR
    RlijkornwqGUOzmQbKQa+YHurO7giu7zd4Tu87t4X1tq+PqL/9BCNixhhKdyBY77
    87at0bw8o28NX/vl/+1fz6R5cqH4LBOd36vOFPJO8OXcoW38w1u3zATFPcC5ihyH
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=EheQWSn5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oQzYh8Jd;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=EheQWSn5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oQzYh8Jd;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF2WfCKDejLPfh/Yquq8MD1OthqwLUAJ+vyOMFdh3SjjvsD9R1FzrQw1bpF2WBFEkTe3oLiH6M1vIRniCEIxYpI20IAvThgMy8ZpvtAbD9U+X4hfKSwt
    t7akvJ5onL/MQbPEgPHSULnhR21MUpTCO4HjKUaWw18A41t6uPfs3tEUd3Up72XoSXNBULOFvf9UKn6oOn4s2yrAGSH6kdIAOd/gh6CAAJCw81ROLadQPV8W
    u/769vyf2be/aK77UO6L5Q==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=UWLGKgljVrAA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=w9j5uuQj-3BbXOR1XwgA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+usLigI9Mln6iNVLfrNXVcQQJYc1U1lEwDW/K70wTmJBl1ucr8d8t6k3gPeJuZicuqphznvg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] staging: visornic: fix visornic_xmit()'s return type
Date: Tue, 24 Apr 2018 15:18:31 +0200
Message-Id: <20180424131833.5266-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: devel@driverdev.osuosl.org, Tim Sell <timothy.sell@unisys.com>,
 David Binder <david.binder@unisys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sparmaintainer@unisys.com,
 Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>,
 Charles Daniels <cdaniels@fastmail.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/staging/unisys/visornic/visornic_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
index 92dceb557..f734e835b 100644
--- a/drivers/staging/unisys/visornic/visornic_main.c
+++ b/drivers/staging/unisys/visornic/visornic_main.c
@@ -849,7 +849,7 @@ static bool vnic_hit_low_watermark(struct visornic_devdata *devdata,
  *
  * Return: NETDEV_TX_OK.
  */
-static int visornic_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t visornic_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct visornic_devdata *devdata;
 	int len, firstfraglen, padlen;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
