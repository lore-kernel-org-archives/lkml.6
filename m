Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485416-2-4540915159095030673
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485415; b=dzAZKjgX2MEdbFpZomOs39Uz9WH83dy6yuJFev+a80Npkp3
    4PAOrOdadgfPSrH/a0mdcut2yzLDRFbxBCHxzIuQkFfKvjXwDCa4+t9YOalw7Zz7
    bsRzV9tgXVzX5eNu4HolmbAW9X17ciHAky4iosZnUPbDsRKxQm/HR8BA/4sVnvck
    yr5hoR+DNEfzK5TUgJW7eIErYBs5Q+aUyCkLFSfU3G9LcfAHcF8teINMXt911DqW
    h9NLkvx0mH+Ts7w4uYHzr0WB2NrSb74zx847TxRh2qFWronZoBOvAq4GFP3RCIzz
    eHocpkgRLYm1YYXjsxtnrrq2EUHh+wZUJC+1nXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485415; bh=SNTLoZ
    +e8aVwSMSRI3h4keBKX8IMwbNsXQxDxDmdSRk=; b=DwYBJxdxLPZTPdyn0+1Ny4
    W7DI4Kth184GjPW+w8WP3Mr1dplm2qvP5eFcd5Lbru+gFX8LAgn87z3xVIg6bhHI
    BwdiEinfMwiyCNspLwWCapHUuK2VmhG9RvjAszcsNDn/I3pyK5ixIueU8nQyNEx8
    lnjEp0wBsAcfmDlyL5MqFR2+9ebn9RGsrZr2RdRlIoqzmd5wB0ruhXqOtKZweLag
    +xho46ZCcO2sa5D+rY8mrqcpv7xlAQZaBJtj0TbvThhJ5KG8vv6IuIq4djxgyc+d
    CO2M6pnUy6HQW9kVjAXkW/fC1go/3XYfY1GqLGjmJOBCEDgIHfYofdc+hKpA737Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mHTDic7o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mHTDic7o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966029AbeCHFDb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:03:31 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965335AbeCHFDX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dmitry Monakhov <dmonakhov@openvz.org>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 136/190] tcm_fileio: Prevent information leak
 for short reads
Thread-Topic: [PATCH AUTOSEL for 4.9 136/190] tcm_fileio: Prevent information
 leak for short reads
Thread-Index: AQHTtppKYv0hraXTFUu3G6ixUROU5g==
Date: Thu, 8 Mar 2018 04:59:51 +0000
Message-ID: <20180308045810.8041-136-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:V6bYlmWpuQoGuQ/sScHtJY4qw/LtJc5B9OxlgerU8HJs8tEzF2CSg2586wjoCYnJpHBnFwXMHKK5aHroQsjVJZVJxdBB8ucMbMlveHVSRSd7JOAJHetU4k3Ije/Ac7RLKDYBbxzcFIWmSoOBX4kA1g+aFGSNSglPgwNg4v2tCVuqbCoPy9csemeFSNy20xYoLKWy66iyCxVv/ThAi2bB7lzXF8wD21S1rBU2IswCzbTLiXA7+eOAcM8yRFJAjF/g;20:sVEM6w6N0kinpr5sdSEQ6JW4IwCdk/Wepl4vNdX4nBRL5ihS6Nk5ewgXgt8JMyfSSBMBvkW4Qr9UiNX2UzjAdtPMF6fML0/dYNrCWbnOd+8J46r6zb6B5xBxC1K1kVmEvB5DVhCv587njame1JM9S/v4yOH3fV2F8g5y1sJP0SY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cacebebc-e4e4-475a-53f2-08d584b1e722
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013DADAC80760346082EF71FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(6306002)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(575784001)(966005)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: W8LzOKj+fLCQeSi4S00UU2YCg5hupS4Jzr8W2VqZl1XmOTPTIGG+Xn57OQdtMRd/F+Hlq62vjWHBmyBnTNX39Dc0fJyL5QK82Ijofa2qi1zMr958FiKl1OOfwA8x3aj1+ZO3NsP0YOhjJBgoir6sRhJumOLpEo9dZt2Tao8Scntaxs/+nOh6nmQaw7HlaTeB8PI7si2DHYMsEL5AE8rMTKuxlK/g4l5H8C0JNHOlOxiYT2SRlKtXi4C9SDELhXh3dEcKhryEhUOC7ShpgQUuU6l3ZtkEPO5ZzytVtu/KR8hN7Km+7ebRtNl8idvdnFUQprwtRJQtE1WmL9kwQhJ9Ig==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacebebc-e4e4-475a-53f2-08d584b1e722
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:51.7915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index 97928b42ad62..57a3d3936364 100644
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
