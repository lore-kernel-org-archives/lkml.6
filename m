Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1111812-1522476750-2-11299017021464522904
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roennl, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476749; b=YhIvinGS5uxgBIQkUKXPJfE8H1yTTR1ZiKzyVexEGrd5fdGlpa
    IsPH795ETNJLb2a4nf36otnrMNMuhbwGyZx34hKV6ySK8gC6Umvxrh1siJ/1nSlv
    g5nB2cVEnxRDP7RWUK5JDoAD1w1MzBmNQMkiKYO4H4I+iyx/36vYLxz3LM5+HVZw
    S/Q4beeYYyoGGBHJknjZccC+NxqInPkEiUUFRDGgC2/rMMrpelaoWtKpoatt9QtT
    SAuZ6cavkiZEVk+ti9nfFAReRvJJ1HJp0EFOugJzjiXt27iPCCI65feaitDteT3U
    xmrbzcLgmTkQFJaLyAW2EQVI6alYO1SUWxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476749; bh=kAYsj
    cr11Ls6LjMV5bAB47RNQkILpdYDiZUnM1gmyrQ=; b=QEBKE8Pqi1+cK/E3T+yUt
    Y0RqB80OGgMbw2M02D4vhWH2FMPUY36tvmN7U/q7YVKR9AsoQSkrpazApBDrxhOy
    jR7bDkh1eM7bn4N8PmGx59VGIYYtUAcE+FVY+tj5IhODR9/fV/2QTSXNZ3s5kyE0
    8klNPmvIfvX10kNebpdFDaxTAEiPZxZZ11LfbTBrjS2Kv6+hGVyegBAhDemjvClM
    Q/TRJFA29oI4rGoTlA7BiYIS9/MDkF4IGx5obtwY/vzZWqq/qDEfflbQEbMBcut4
    b5g1hIKe0kn3laC+5foIIIvhfoFaEFLfCuZ1iPs956uAo4vp1h4RWpCVYmJob26j
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD4x/dshWfX7uhKFP0UygqM7K9Is7KY9dzbNvuZPQZS9xsUEqJEzvFVoPNV4gDSOkPw0TzM+CwbjlP1XektW/Vaf57vL27KTxsVIhZDlMbfqYSDEn6GJ
    XOJGrsdO3eRyR9TV7l3u9uoGPirV5DSqWRZ3teWFmWg9Wp50V7WyKukUJXipJ+7w1vglkVHIAaYzoj/u2wwcMOb9xP7WWF2fxsqUFOIzbYhiiZRiZ/HlClgt
    S5OmOrtEbNI2gCT2E3X/gw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=pF25iSm20u65bnAoCTEA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 72/75] staging: ks7010: Change 'device_open_status' to a
 bool.
Date: Fri, 30 Mar 2018 23:08:52 -0700
Message-Id: <20180331060855.9452-72-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:07KXeRymXRbOlm6hr7xQFsz1T1H1oML5QChMxj033rtMNuU0qdP
 Ye7iUt6gaw7CzpRkPDO8g4lxmLAv1hssNsQRddoFG/OeL64vNXTTZNVlOL2N1HwBVNRK1bd
 LQsFTvlcW6U7aCGbIGRVJLLCAGEIZel7V/Jkj+fX22Go7xq8C//rhJil3tW/JLVWIs8Euf4
 xxN937wMNsFiajXr5GWPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f7V0elybVtQ=:q7J9P7kf9f9cjQGUsC6pzC
 IijGhsjWQPIJio1rDCJDZAVuA4hG/xxxur8JDZ+eDMpMZgVmYqgrxk6ZOyaCjkbHhfuc6Fwfu
 HaNSklEvkKudYxS5RADC2Kne2HjEzWl/h6YBMnLsiNwuNmjyuf0dm4wxRB3YdLYDfMfx9kGH8
 TIAIIvBu8N9KPPztJ5nC+M5zNAnGyMh46+nLZpj7qp6/Ll9m1nejBWYUfM0PL8Lebf0x/L4xN
 3EmUh0bpXF4LfvQNy/wiVddB1yta8+1dpb+wT1WjYD05nGiwXM6U9QY2cFO77Udo8BxIy2kSx
 d/iAhQxx4+yke8aIFMwyWuAQq6PCcJ8/eCyFFarqRYYrU0QNWlqmP+mWPDQivdsWApc5hosy1
 l3kv/PrWDchB7sRzfdUYCspOvZcJWyz6NQZl259uNMsdm4fX9efCU/XaslXE19XD97gvVj6/D
 +9psYU0whQeRml76eSdsdQ9MnnjTDqx2gTBwX9wtbTUoXuGb47bToKxDCa9/dEU84amctUANJ
 KS8FpSqlQ7HU4LCdPTXpNzNvJMvt/wA1x+42rQGC+w+SAh0IqVBKCFBosHnf1oxHqnClkyNyC
 bjyE7wynsKseHjjsn+Q9A7ljdaC2VIToerlTcyTaNbLY3eyxg5Uy0pr3hrg6WbYUN8Rfboc9I
 fdyZJRIYeEqJdYZlEuzD4qzGN/9OExR4ZxWRUGMzpc7645ps+Epo523JLMcI6TcbLI30awIUS
 DIW4e5nDELTgNWRM9E/02EJjHGeCytE58OZbXQ==
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The 'device_open_status' member of 'struct ks_wlan_private' is only
ever set to zero or one, so it makes more sense for it to be a bool
instead of an int.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h     | 2 +-
 drivers/staging/ks7010/ks_wlan_net.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 012e0fe2b60d..91231de5404f 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -441,7 +441,7 @@ struct ks_wlan_private {
 	unsigned int need_commit;	/* for ioctl */
 
 	/* DeviceIoControl */
-	int device_open_status;
+	bool device_open_status;
 	atomic_t event_count;
 	atomic_t rec_count;
 	int dev_count;
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index afbc472baa05..e1773e57cbb0 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2871,10 +2871,9 @@ int ks_wlan_net_start(struct net_device *dev)
 
 	priv = netdev_priv(dev);
 	priv->mac_address_valid = false;
+	priv->device_open_status = true;
 	priv->need_commit = 0;
 
-	priv->device_open_status = 1;
-
 	/* phy information update timer */
 	atomic_set(&update_phyinfo, 0);
 	timer_setup(&update_phyinfo_timer, ks_wlan_update_phyinfo_timeout, 0);
@@ -2893,7 +2892,7 @@ int ks_wlan_net_stop(struct net_device *dev)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
-	priv->device_open_status = 0;
+	priv->device_open_status = false;
 	del_timer_sync(&update_phyinfo_timer);
 
 	if (netif_running(dev))
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
