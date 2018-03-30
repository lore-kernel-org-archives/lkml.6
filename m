Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2915802-1522393948-2-5561761639074942504
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393948; b=eifJeLz3Z/zr8GEP+KMXsfxST6ZMM0wu1HD63lzsO7t1a3PbAC
    f/umfQII9ndT57+vRZIQCLdVoHFBdExwSF7gpgplD23fupI+ZkzYrsO/ssDV0XKN
    eeKebCi+N8kiAAnSBSXoYEcgiSHJPMOcIQjKOBal3ji5ew3JZGx5vVIQixKtc/8L
    I5rI/mjD9ZZAlMFEePC6PFoylNXL1ErvS/2oosSaEv6/SnfWq7Stgu4hJv4g8Xrk
    qdezNG/yk+BJImyPE0ipEVpGunCb6FqRi/HRN5MSFJV2uCqpCkusBgxNx2Ofp5Lq
    qhY7ggdEusThyKB01csiYmczBN+0lUgVxJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393948; bh=yC8pV
    v7ON3qvlKmU/0ZanaigtJqcQtOLiUrb673z/6E=; b=b/mdrnuxV6x4UPCI9HM91
    jjcgIVw7tdpUWuEBipzjvMqKMN1Z0rrMUYosg9deiZxrZLyAEyMpwfC7ddStECft
    kAdA5xCiC84OQHjARFA4l6NWSjNkW5uuv5ChIyPKAZjgO1sHZH1ahWS8H0Ibb5ri
    MBx1+tgH6DxeQq+5L6DoJ42M7akOhD5/a27eqAm9WGWVTXcD7Iiim/u33E+E7aVU
    axFvaipYci+auWTXXa30fQl1KHyqqPN+HbkEXe2hVg10L1swDns2z2icn5bhox6D
    VqEy0cVnFIQpira+QziGKTUpklQa/LggWSHCBM8toYdU7OwNNTohCl3Eb/qeMAKX
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDIj24tBprF2zYJ/wLGZRr6+OQ7P6XkQ91MzL5EknfRAml9tsLgyTWc10T677mPkjHE5KivV1OSIyvdk8zj7XEMQW3p+YlppQkFs0U4ZnkqU7XRw5jqG
    FP61kfUnUFRXPasgDM11EYSynT5gt6i81W4458BMEzcVFj8tBwz79OehNy3iEAzcvXCyCAQTxmn3y7s5Wx5GbrE0kMreoYgXiufBCfNUWnUdguG+viR0qFsQ
    MHwTnvxFt4v0wTdR3hUs1w==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=ZQYQ6Chp1jm9kK9O5HAA:9 a=fLWBjZiCSVLFb5tp:21 a=ptpy76S-AaUauMkt:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 68/76] staging: ks7010: Replace manual array copy with
 ether_addr_copy().
Date: Fri, 30 Mar 2018 00:08:31 -0700
Message-Id: <20180330070842.25224-68-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:0IZqPOfvkQPjsbk0spgOACdggLEW2dn/61TtrrQOTcIkiZ1ZplY
 V/w9ySfLZCxijrjQFREoaZsvvlohA3peX5c5xMKfFYnoPvSelq3egm2Xj4KogT5YZKz4u7R
 iJPpbIRL/Qonbe2AE9MvSzvFSAHXFQJ1+apVjqnak8rIlP4xs6LVw5lhlFJzN2EkWqjgF8r
 oKWuJ9v1cw4y/uMyjRUiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GTUXXy1/8d4=:Ivatb1pnN9HHXym03A9gYO
 /WZazDueKyENHwFyrBPe9f1QJZgrdvRUGZz7ga/4voxyh8SEq6l+z7+IOd1fLGsF2JVEfx0/i
 l2b99h8vDEOAN3U6ueEnu8d4h2zRvHPDYwp0oS0NIdvLuKubwAbHBriHPOc12RRDHfJQWyZ5j
 tYXBBmnFNSrNgNSGaOxc1TBvr5jOAvSs+i0hBXqmoRxNrPmBnty8fpTpNmhDjlof6hFIomv44
 wbFi1E5uN8V27XO5X1Xp6FTZ85nO9EmmMEjKP/NPXBBb92RaiuqOC2YRUOnVZhqXlfDS4gIh8
 G8T//1IBboPX/b5/6JEFgfQaegLK3gk2mXw9XJMwrUZ6CxunAMVR+WPXhcV8EOqRRl4x4jeJS
 GVsjl2/1ObzCOMRzMVVY0+RuA330ZK2Njlim/qoVmaTcxXHNqDqjRN0xn8opeLpSQN36Ra/jf
 Z8oHYSAvafkr9z9AsLAAtCda3wnooBiucPuZtCAy5yxLMtvf87lwD2GzBzZFrfHqEnDQ/dKU2
 8+M2OPSz2YT6ilgaOUbgMsBItlzoLWT31r36kVe9ewWIGmJnAZkfx5WpU/S8kOvhhUEEW87Ke
 UklawI00R2wDPfMfQprW5wl/ExstBK/qC2Woz9SxJS7Hx7a37mcw442vCIi4J2DJmp6haxiIv
 5bS/d9yEt3mueFu0Fco+gFPF8WeFVN1UpOqjk3uffBOJpQ3G2nT8NV95cNQRyaomxqvDIJmLy
 +ie3YNoCraOm5yyhaYPL5zHywXfJec3Hh4iDpg==
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

Copying the dummy HW address into the struct net_device doesn't need
to be done byte by byte; use ether_addr_copy() instead.
Additionally, dev->dev_addr is not eight bytes long.
ether_setup() sets the dev->addr_len to ETH_ALEN (defined as 6)
in the net core code.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 72a52c6f9fd2..d6bfbc1f8558 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2884,15 +2884,7 @@ int ks_wlan_net_start(struct net_device *dev)
 	timer_setup(&update_phyinfo_timer, ks_wlan_update_phyinfo_timeout, 0);
 
 	/* dummy address set */
-	memcpy(priv->eth_addr, dummy_addr, ETH_ALEN);
-	dev->dev_addr[0] = priv->eth_addr[0];
-	dev->dev_addr[1] = priv->eth_addr[1];
-	dev->dev_addr[2] = priv->eth_addr[2];
-	dev->dev_addr[3] = priv->eth_addr[3];
-	dev->dev_addr[4] = priv->eth_addr[4];
-	dev->dev_addr[5] = priv->eth_addr[5];
-	dev->dev_addr[6] = 0x00;
-	dev->dev_addr[7] = 0x00;
+	ether_addr_copy(dev->dev_addr, priv->eth_addr);
 
 	/* The ks_wlan-specific entries in the device structure. */
 	dev->netdev_ops = &ks_wlan_netdev_ops;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
