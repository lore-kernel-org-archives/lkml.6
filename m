Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1857324-1522093302-2-10779748207512317311
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522093301; b=Xc7eTFqd9tmq3H4mQZkEX5tLu54vslt/FJcz3TCwjmSEiRn
    p0xd/1pnL8Mmadzi3UEeMq4/lIsUBxb30WtODNjUeUWM8cHbozn0E7DhL3rGHtH4
    yLpOLnXapTIxPHSkr8OITUA0XxRTIcJOlPWOMnMRzKM2MK9X1gdvaxT88bVOCcm9
    fehdqGMrnRhtlEkYi2nopeJVOkJyaD40oeA3txvsr6zKRFpoEOuYnoJp8c97U3pg
    14FS4SwkG/Nc2ezxmeHuIZ4eZD4IYM1sy7NTc6oYlbzDCw83N08Wl4oD/RQXjJ9P
    4L96v+5xcj8L6NH/+c1nYjTg2RzpkDJcEIdXliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522093301; bh=A
    TofWMGds2z+ZH+iHokYRY9DmMwt0ZPHFV3badZZ4I4=; b=CuF9hEL3zZX+UmNm9
    p3opurrPPMKe+ynjjKdrCtJBKNaq5rKJTVFo1nkgt28tJW0hc5sW8yDg8PMwr2xg
    jBzxd2KqFOpI1oBXPzwMgODKPCJVAxylHmMMOuRQolaCQANlKXteFYDGQEyHdv7h
    VryFveqA8hO6dTASLX8SlwKuMlJJcp7jvZne2izznqEnYWtOHhMHufq0Q4YLTdOP
    B5oEsij5svq4gB2JCwbdlocUJEQDwl/mRsuCA1LOs5fHy4MFfKZYNDXxXSD08d1X
    UCJmRR6SwXtrDLPT4FQDbELoZeHpvJtrry96oMrdEwoL4fcdQoI9wvYUfemDYoUz
    zWszw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHgDKdM1kdXbbPC4vr5FaxfHICUZ3HQ1v3k45VYEbwH+eAn7b+QOPblshlcPgfDz8ER+5X9AM6lVNTtTvOPN1I10u6h3s6MWRPK/kjqPi9fySTrVeaHY
    NoQoGhSyoQ4cKCCVYe7dWiPUrUS5OTR19NngsoU6ngGr2kMpvEnEnO7AwbRAFLEQb1PT7InhJLC8wsqC6uv+DXP/cTQUeThcH1PDC0cbdUiGaiMoLurcIIHI
    9+Nw+y1O8WHESa7OnFSsew==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=DfNHnWVPAAAA:8
    a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8 a=ll9BbRn1J-IGHmDfoLIA:9 a=CjuIK1q_8ugA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.48,365,1517871600"; d="scan'208";a="320051576"
Date: Mon, 26 Mar 2018 21:41:30 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Colin Ian King <colin.king@canonical.com>
Subject: [PATCH] staging: wilc1000: fix memdup.cocci warnings
Message-ID: <alpine.DEB.2.20.1803262138530.2423@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ganesh Krishna <ganesh.krishna@microchip.com>, kbuild-all@01.org,
 Aditya Shankar <aditya.shankar@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fengguang Wu <fengguang.wu@intel.com>

drivers/staging/wilc1000/host_interface.c:946:32-39: WARNING opportunity for kmemdup
drivers/staging/wilc1000/host_interface.c:970:30-37: WARNING opportunity for kmemdup

 Use kmemdup rather than duplicating its implementation

Generated by: scripts/coccinelle/api/memdup.cocci

Fixes: aaea2164bdff ("staging: wilc1000: check for kmalloc allocation failures")
CC: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
staging-next
head:   12a0148711a440f5b7111f95a34dfce88cdb47d6
commit: aaea2164bdff39697d0f1ec69dcae62632e37974 [400/412] staging:
wilc1000: check for kmalloc allocation failures

In the first hunk, should 6 be ETH_ALEN?

 host_interface.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -943,12 +943,12 @@ static s32 handle_connect(struct wilc_vi
 	}

 	if (conn_attr->bssid) {
-		hif_drv->usr_conn_req.bssid = kmalloc(6, GFP_KERNEL);
+		hif_drv->usr_conn_req.bssid = kmemdup(conn_attr->bssid, 6,
+						      GFP_KERNEL);
 		if (!hif_drv->usr_conn_req.bssid) {
 			result = -ENOMEM;
 			goto error;
 		}
-		memcpy(hif_drv->usr_conn_req.bssid, conn_attr->bssid, 6);
 	}

 	hif_drv->usr_conn_req.ssid_len = conn_attr->ssid_len;
@@ -967,15 +967,13 @@ static s32 handle_connect(struct wilc_vi

 	hif_drv->usr_conn_req.ies_len = conn_attr->ies_len;
 	if (conn_attr->ies) {
-		hif_drv->usr_conn_req.ies = kmalloc(conn_attr->ies_len,
+		hif_drv->usr_conn_req.ies = kmemdup(conn_attr->ies,
+						    conn_attr->ies_len,
 						    GFP_KERNEL);
 		if (!hif_drv->usr_conn_req.ies) {
 			result = -ENOMEM;
 			goto error;
 		}
-		memcpy(hif_drv->usr_conn_req.ies,
-		       conn_attr->ies,
-		       conn_attr->ies_len);
 	}

 	hif_drv->usr_conn_req.security = conn_attr->security;
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
