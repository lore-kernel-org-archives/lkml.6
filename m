Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2389728-1520277590-2-3699398339404308570
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520277589; b=hkevYW4G2kiuba1OFY9Om+uQVVRRYu7YvACUgwoXUcU2MuX
    2d4zPZWwQcbtFop46K/iJZ4m0XddrtlV80TpopKOAypRFMQletuaS/GZFYyxWSgk
    fQeVC8oOYSQ8chenxtYAJoKNF108T/Z0iAk3/LHZqDwQnQCdVyBS6IcLEJIveA0u
    mq3HCy2YWnyPVb66pVWcueYW2aeATqESxX4J2OUrUcLRg7qpsXgebsUuepvpFq6Z
    schKB1+NzZVmw19YOi/5DYWrCrCEPQcA1AdOE7bNIqMPI2QLdnRLZp8bVs954CQQ
    JyzJiJ98vp9Qo3MMlEbAhg/onYrcadVZc16QWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520277589; bh=H
    M8uCdnZ7xrnRv4hP+jX5K+5vxekFRdqQEOFAdCFQeY=; b=dKzVlO3Fv8W6DAQbP
    wI+XierdRzwcRAKAAVHjdbGA7GjFORoPX0di6zBHPVzPSLq0zLwU/YbmxTAnJtd/
    qqrHhSUcostysViQq6koBdLcsBnLHmEjWxB6gC+bJoP3KsCOvAp+CbeZo5xgWPMK
    X1jJF1XsJ1QtPgLu74Y87unV0sSwBVxtt1Bts1IYzPUVvLlUBtC7R4adkaS5p4zV
    aBlNIrcK44omXdOlhOoU57JYkkn+1SZ50DmBIZYKJw+3FZLKNUlZJHpke8epl10u
    WmHtDVCXeFEFflgGxlZCvpxEbaCYDPNoc89xD8Iq46+agtnK4ZHw060PqFWyWSps
    4FMjQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=brWzFzgm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UXMNUz3j;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=brWzFzgm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UXMNUz3j;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsWrkw/eikQdNokdHHysicFVbapU+N+4Y16N6j34ApYv0fQJWtrwt1VwUNZxJn7jPmPSJJHsQ==
From: Horatiu Vultur <hvultur@gmail.com>
To: netdev@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] Fix partial warnings of checkpatch.pl for ipx_route.c
Date: Mon,  5 Mar 2018 20:19:23 +0100
Message-Id: <1520277563-3825-1-git-send-email-hvultur@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: Horatiu Vultur <hvultur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix partial warnings of checkpatch.pl for ipx_route.c

Signed-off-by: Horatiu Vultur <hvultur@gmail.com>
---
 drivers/staging/ipx/ipx_route.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ipx/ipx_route.c b/drivers/staging/ipx/ipx_route.c
index 3cf93aa9..bd26fbb 100644
--- a/drivers/staging/ipx/ipx_route.c
+++ b/drivers/staging/ipx/ipx_route.c
@@ -71,8 +71,8 @@ int ipxrtr_add_route(__be32 network, struct ipx_interface *intrfc,
 			goto out_put;
 	}
 
-	rt->ir_net 	= network;
-	rt->ir_intrfc 	= intrfc;
+	rt->ir_net	= network;
+	rt->ir_intrfc	= intrfc;
 	if (!node) {
 		memset(rt->ir_router_node, '\0', IPX_NODE_LEN);
 		rt->ir_routed = 0;
@@ -207,7 +207,7 @@ int ipxrtr_route_packet(struct sock *sk, struct sockaddr_ipx *usipx,
 	ipx = ipx_hdr(skb);
 	ipx->ipx_pktsize = htons(len + sizeof(struct ipxhdr));
 	IPX_SKB_CB(skb)->ipx_tctrl = 0;
-	ipx->ipx_type 	 = usipx->sipx_type;
+	ipx->ipx_type	 = usipx->sipx_type;
 
 	IPX_SKB_CB(skb)->last_hop.index = -1;
 #ifdef CONFIG_IPX_INTERN
@@ -280,6 +280,7 @@ int ipxrtr_ioctl(unsigned int cmd, void __user *arg)
 		break;
 	case SIOCADDRT: {
 		struct ipx_route_definition f;
+
 		f.ipx_network		= st->sipx_network;
 		f.ipx_router_network	= sg->sipx_network;
 		memcpy(f.ipx_router_node, sg->sipx_node, IPX_NODE_LEN);
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
