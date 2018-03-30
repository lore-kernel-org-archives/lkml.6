Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2915802-1522393773-5-4813581843570477048
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393773; b=ks/B2RojhYMRcxZzszSzK5GCRQDkFbJWRrvtAtdyVPVpqVZW+W
    rV49PY9u5FojKT36AfU6CuqcVG8fNjkvfQ+BzPYt9hMiaFEooKMExt7yghvDSqSO
    zMZ/GGgX8z8eFaaH9A+/SlPpRY1NrUGJf5dFjt3GWcwyzj71sAeP6A7H2GQ0REA4
    Aj4XMDZFydA/LW9gOWLV/Kx+yMWq4vy7vT8Pd8GedWDTpyyj87y13E9ms4bn+cYc
    e1Xj4gUgnFeG9xXxl3sItsgUjFWDvHGeLQVncKkRxtwdh0N2h8GpvTnowBJEJtwR
    1HPcCHv8bYbZPLuduxOV8Xgtnl5orLpRy6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393773; bh=48h23
    xVur+r0PZARS6u3DujJORxlKDyjvhj/1b6RJXI=; b=XJBgXKFR/FKMmM7ReZHO5
    5nDBRgnE3aO3al3khpubfz5Coy9XZY/6jD9+I+vpCXNUlbINqPn2DrF38HlZbzq5
    0GEoo73Ia8hDn62DAfd4WSioJd2+Uo6GUrYtlrh6Ne14+LQmb4swc1ijYZOLDqd8
    f8PnKDnWqGCAJg6FhgB1/6Q9heGrqL9Hg5DdgoaIpc8oI5LHDsGVi/SGDQdsYnzz
    56WwedUKxpdQqZ34L/LPV2indfNR6RlzYX6gOCgcbBmXIOeQHjaFtL9P8qn4s6Za
    y1CtNqs3WZ1JzuIzyLnbyhEmRE7ACElS8cGdXrP1J9GX0dmRKcAD/8WXbcHQc86C
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfOfvxGDWBsRsErEu1jxQsf9GZnjUaJhf/yTB92tSl3zUg3M6bgQ9eASmvoC4QvaQzBNE6yQQ3MSM5b082JP9/+FItsVu/RE3JSmcfmRtxYcC6aE4RbiR
    VDWY8GFBsrzP3ZVHeitbo9or3du78jfx8wLWxR5r5HmQMb0YdRD/iOXzIUPFdLMQULpayP8enYcveCC/lV0pxKVIFqGnN7smsC+WdvbK/JUOHpHGMKkjcn/V
    +gCsKLy2Ga8DF835PNZxPA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=bTZhXF_3Es1RlC27uLMA:9 a=J38sKhbewBX8-xsW:21 a=6n9lg6l9SQjj86zw:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 01/76] staging: ks7010: Use the ARRAY_SIZE() macro to
 calculate array sizes.
Date: Fri, 30 Mar 2018 00:07:24 -0700
Message-Id: <20180330070842.25224-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
X-Provags-ID: V03:K0:omegR1/TGFZiwu1arUqPAnu5CbpTGYWWe2Qz4dr1sn5yuNUzb7Q
 3GJnzYnubFcerAygZDpKYbA+wY0vbyyR8/6S5A0IS/K2cDgeRdCb1DWzAOjnXqerxQcCz7Q
 c8GtdK7igMwsS0f1SoZhLscF13rwl0OHjwuJZfhZnANx64DIlGHwZEzJpTkhQUzoPNlLeQx
 TY3yRjq2ONTWQ03mSbVHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jG6hTA4+q/w=:ZPymJRKsANDWBi4ThHhH8F
 jnaVkXMlB+mMDgwU9KzAGkIsZ+e9ChFp3WTwyhSz57BnnOZkXopecw5+dPSOZWFQNcydph8D8
 L2vCG+rn8PFP58unGp9scV6r6LWF8E9g9tA6G4LzdqCUAZQ6TPkE+2amo/AHdJ84+fugW8jrB
 WBbnrd0+5U0oh0yTDYEkUP/dRVHUiLU/yUZxcJTwowrq6Ra++AHmlzTc19QSoiIwY05j3nhn0
 QYUe0uyU0KD+sBDxUAjJb0LGiWQBXGVsGvoWuTLmPvuG5wuSoCcbeCY/F3ivLD25JjFAey9SC
 UN+bjSN/YoTaG7mSAyZLTNISYdH2WhgTrGtSj33lZuhy665lwiEnHgxq/OCaK3d3SNaSxKNZI
 IjFxn7Txq/tNBwZS2uPznXRbcX64zE4bvyKx7vR8ySXPkEcwIMK1gVzbu3Olv1BeGrGZvrVkb
 RDlxbSNSC5H9v3vpsV/FJOVanlgQ7DSvi59sZeRHf6dh+x+FjNumJN89z/nJ5lKbhQaJsjNLh
 xhK46l3WTR7QDY12DNc5EKbiNGc6NI6aArQ9YwZN9cjJ2VhGHWCP9fjkRElJ3Mn/UR8Lrdanp
 NJCDI2iBc2g5Y1fAdvsPwALRxn4lOyTqvcERfE0kgcbPjlcM3OhYzCWxy1rtfGjgEYIFFnyEg
 eLXUkV5wduERk51IUXLbU5pve7wN+qjNvUDT5lmrfPKXR0SZRuym93fp7EAXdhRZh271YIxg2
 n0TOcasFKXf5iC7JGZQiS0P+UR1mpm90tjrbgw==
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

This macro, provided in 'linux/kernel.h', will calculate the size
more succinctly than a division operation.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 9078e13b0d4a..533feef604a9 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2702,10 +2702,9 @@ static const iw_handler ks_wlan_private_handler[] = {
 };
 
 static const struct iw_handler_def ks_wlan_handler_def = {
-	.num_standard = sizeof(ks_wlan_handler) / sizeof(iw_handler),
-	.num_private = sizeof(ks_wlan_private_handler) / sizeof(iw_handler),
-	.num_private_args =
-	    sizeof(ks_wlan_private_args) / sizeof(struct iw_priv_args),
+	.num_standard = ARRAY_SIZE(ks_wlan_handler),
+	.num_private = ARRAY_SIZE(ks_wlan_private_handler),
+	.num_private_args = ARRAY_SIZE(ks_wlan_private_args),
 	.standard = (iw_handler *)ks_wlan_handler,
 	.private = (iw_handler *)ks_wlan_private_handler,
 	.private_args = (struct iw_priv_args *)ks_wlan_private_args,
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
