Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486936-2-15692946278499530405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486936; b=R3He2dhsaMJgS6c373Ttp8ypwBPAeHy/2WrwuCZhvCNdxsI
    tCns97T/F9FPdG7rYm3hwl5BFfl/cx9kthDmSBNVI+71NgwYrUuMcikw9qoODOdh
    CtRadodzFBenQgcdYztzGw1P8LRnb39LR+gfoSv/U1yyQZxPmie1PJyO3u2EZpTm
    GJXgCl+4ODjW3dv3oktxPvitLDovxxucyF2mjGfDmpxGQ+fL2LLjYXH112zZLDzd
    SAiWfasC1lKc9Sfst4NCwYFyowlTJ2Ibt6LoXL/QuOKKb5lmbFNWv7AYmpL8zMmP
    rnM/SwRMIPUI2iEq2CEzUtvOBX4oFqKj2HDE+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486936; bh=D+/hFk
    iIKszQHu2Gu23Ckig+0ebr1IxY2KwvXftPPBw=; b=PnKNe//GAxHcbUGJb8IWWv
    xUpFt6/JS/TyXzgJM8fN3iY0BLvLYPZlR7AfoTHuwL0CbQdIqkBhzYMb2pXy5a83
    Q7Rl54p2Ss8+FsFkQVtuvk+sdKSAPG91BM78SGSnw3ik11lMtzV1MfvYwGrrOhW4
    WXs9qg23XR4D6siyUoU3K9LQ6RC2JY3V8cigGkx2oH2FPPpCEbzq7tI9V4k7B7ic
    RME/xuSSRbLcvTzuz879W9FoTBTLdf5A9t9/Mitr3JCFNWDR0Has5ePiyWpV1tfl
    BYobpYUWd95zpyKHq7HeivzXtOX2xnegftHTes0x9tXlchb0AQAF8VFqL4UV7BYw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AWeWmBC3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AWeWmBC3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966551AbeCHF2d (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:28:33 -0500
Received: from mail-bn3nam01on0133.outbound.protection.outlook.com ([104.47.33.133]:8306
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966496AbeCHFHC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dmitry Monakhov <dmonakhov@openvz.org>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 070/101] tcm_fileio: Prevent information leak
 for short reads
Thread-Topic: [PATCH AUTOSEL for 4.4 070/101] tcm_fileio: Prevent information
 leak for short reads
Thread-Index: AQHTtpqXDMwTl3183EuIdTXhA5N+8Q==
Date: Thu, 8 Mar 2018 05:02:01 +0000
Message-ID: <20180308050023.8548-70-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:yEeXui94czD0/5o0b/ZxnlUvwtC+R+LcFnxrWaI4m5dR0JdOFjD3MDHToycUxKh+nPfUYUTZj2Yo/+nGReGMQeTiB75ngYpUkkiPNDf5/jz25vk6Y046gyR9dj4ZEz/OsciD3GRsjYUAbtXn4gY5oRkaGdf4oE47V69ywaYOGBEW8wM88v/fguVGK9LVSiijjwZUF0wCQM5aYsBApZq39RxLdLc1SSSkIFeqN4fV77Y32yjRnNNpUQhLhYFOL0EG;20:ZGzRArVMvG61+j7Pcy+4hR6/vwEa5sz8PwtDiaEIUxBI+gckNz0k09YzdaIthI1xnF5hYcLeBsf/vKrR9w9xa2+FyI85y6rbqR7NzrxD95t68JiS2ZlkfVjFtzWxX7o4b0T79cdqWvjejSAVJV3VYFsdG8S5I3Q8fsDYOHXlHzc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a71e3fa8-cb65-43d9-bf4a-08d584b269d5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10774501EA07CD753C39E66DFBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(575784001)(6506007)(59450400001)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(6306002)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(966005)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: SG+6Wso7Or2oht/CdI9BQzYes+2U0N1zoJq1L4vr0chUBz9u53d3YY/s4rYCE6jsV7P6+qpTox3PyRJzRpxeAFFlmz65lfl+MArILqvM1oe6arsb18BtZtAangwRPHRclk7LwBHeWVYVj8OOGbOA6kAjeWiSLWoYHkNjmReEhFsq15EQzX2hg2QkbU/xIkabV8vZV6L//4+lWmMMQd20PyfoVusgqHRCRJJgDRLBRabl1jG7aQ6jiQcoSHnuBmwU70+qvJqnAw6yFT7X5eoMp7PsbadtoxHhVph5RhZIavkT4E3FigrnvmGbtmJgDWexxGy/Gor8zBrGHyKddOPh9A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71e3fa8-cb65-43d9-bf4a-08d584b269d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:01.3192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Monakhov <dmonakhov@openvz.org>

[ Upstream commit f11b55d13563e9428c88c873f4f03a6bef11ec0a ]

If we failed to read data from backing file (probably because some one
truncate file under us), we must zerofill cmd's data, otherwise it will
be returned as is. Most likely cmd's data are unitialized pages from
page cache. This result in information leak.

(Change BUG_ON into -EINVAL se_cmd failure - nab)

testcase: https://github.com/dmonakhov/xfstests/commit/e11a1b7b907ca67b1be5=
1a1594025600767366d5
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/target/target_core_file.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core=
_file.c
index 2e35db7f4aac..c15af2fcf2ba 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -276,12 +276,11 @@ static int fd_do_rw(struct se_cmd *cmd, struct file *=
fd,
 	else
 		ret =3D vfs_iter_read(fd, &iter, &pos);
=20
-	kfree(bvec);
-
 	if (is_write) {
 		if (ret < 0 || ret !=3D data_length) {
 			pr_err("%s() write returned %d\n", __func__, ret);
-			return (ret < 0 ? ret : -EINVAL);
+			if (ret >=3D 0)
+				ret =3D -EINVAL;
 		}
 	} else {
 		/*
@@ -294,17 +293,29 @@ static int fd_do_rw(struct se_cmd *cmd, struct file *=
fd,
 				pr_err("%s() returned %d, expecting %u for "
 						"S_ISBLK\n", __func__, ret,
 						data_length);
-				return (ret < 0 ? ret : -EINVAL);
+				if (ret >=3D 0)
+					ret =3D -EINVAL;
 			}
 		} else {
 			if (ret < 0) {
 				pr_err("%s() returned %d for non S_ISBLK\n",
 						__func__, ret);
-				return ret;
+			} else if (ret !=3D data_length) {
+				/*
+				 * Short read case:
+				 * Probably some one truncate file under us.
+				 * We must explicitly zero sg-pages to prevent
+				 * expose uninizialized pages to userspace.
+				 */
+				if (ret < data_length)
+					ret +=3D iov_iter_zero(data_length - ret, &iter);
+				else
+					ret =3D -EINVAL;
 			}
 		}
 	}
-	return 1;
+	kfree(bvec);
+	return ret;
 }
=20
 static sense_reason_t
--=20
2.14.1
