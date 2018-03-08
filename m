Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485398-2-9272350382450639000
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485398; b=p6mTiBnB4kv3Dhed4Vtc2kDD/ZGnY6+P0ruO+MEyjdYmwwX
    JTMOSIgL55FxwygvjQh9LFoIl+s6NMRaREURpPNgcOzlloo/JBqo95YScYfGIIuN
    NeN98o8s3Rm1gGys5pznt61mr1KNikBizHMHEluFdSbGTxxSq4O0fg294/dHGEr7
    lMChsMlWh9bTaQcZF447VIzJHBi+uS4W9CEvDj2jBYbt83JvTgQX+7YKUPShTmlb
    YvmKmWVIWmFTCcrAdLlqZAmvbZ+iU8Lq/c+Suv1cwGIMJkVIQe1yadSp5N7liOFj
    u0FKrV8WPvY31WRp4oys1cwxPX/vxrTijHsIJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485398; bh=PQ1aEq
    v9mEFnwVWKEXrYS4yhKCmT+qw3C/m7/qnsLAk=; b=avjWbXvqubsgsq5IvVoM3Z
    9jhMVRljgp8W67s4/U33ya5L9wGfocwfzivzuVWpcjC59DrfRG18anCR7rQ5BhwW
    n03nnMmE4ACtRKaVHHlsWBzZMwwcRKp3ShRrSo8tgSmIuCHXPh7ilG6rej4a6ops
    iGoX8zaU7YQ/BBNrAvLBAzIco05e1cq2Hlp8c+IK83M+Z0tsFvytWqR2eQO8QoRq
    muoTonVK9mpwXca0rc0r1r7Cu+shWDZtgUSfB9kNdsOaKUtmTD2+fyvI1u4lQQAU
    lW1z7PA5wL1Ptz+B1qgSlBMPXr3DUSxV4QjUsjFnkJrBMpNhUR+YiJTEKDEuyJYA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n9OFox3A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n9OFox3A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965952AbeCHFDD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:03:03 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:54752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965929AbeCHFDA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 126/190] qed: Unlock on error in
 qed_vf_pf_acquire()
Thread-Topic: [PATCH AUTOSEL for 4.9 126/190] qed: Unlock on error in
 qed_vf_pf_acquire()
Thread-Index: AQHTtppHtWEhKuSi3UC6TilOOhLybw==
Date: Thu, 8 Mar 2018 04:59:47 +0000
Message-ID: <20180308045810.8041-126-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;20:lKu5QdS9bt6QxPMtFp93zGJdFOD00pRc+oSaLqzdVHfdC+r4kKFseIH8AeLj+q8QLAdCqwijDFGoHYAROZ7qes6Sjze31CcovM5Xe4hBdmZCXSGR4BBtJMVhpAR2GGdDqEBrABdjfMoVNyHKdPs42yaF1DcJm4IifFRtlTMDZ/M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a101c5fa-f03f-45fd-e960-08d584b1dbc1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013203506019004821EF687FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(575784001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ct4sx7P4eEc4b+nm1FgLU43+c/m1I2oxW3Mmw/UP7r7tvv9ChfuiVHc+NmGiYBfooYAai6toyOP8nkIaFFkZAG8iaZWWzUDkKauqasL4kSni06xiiPAtXgG62TNVNAGNf/O4im/imfOWzcHVuT5WK0QD9pEfcbbpwRtAG1TdzKDUJWnlg0FYxmj4oj9AYyjm+aCCTy+prcO7/YSi+u8rNQeK5Wse4wnRHOnEbX2AaS6SJQblEevvE9l/xLZ8BDtVArqiDZbLbT5nzn5YMWfVcT7WOujMZkkVpCm+i9YgOMhD+AuQQnj3WNHs9dEbwxbuu3SoJviD4Eq8h4g2XcHK/w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a101c5fa-f03f-45fd-e960-08d584b1dbc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:47.1693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 66117a9d9a8ca948680d6554769ef9e88f936954 ]

My static checker complains that we're holding a mutex on this error
path.  Let's goto exit instead of returning directly.

Fixes: b0bccb69eba3 ("qed: Change locking scheme for VF channel")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/etherne=
t/qlogic/qed/qed_vf.c
index abf5bf11f865..0645124a887b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -204,7 +204,7 @@ static int qed_vf_pf_acquire(struct qed_hwfn *p_hwfn)
 		/* send acquire request */
 		rc =3D qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
 		if (rc)
-			return rc;
+			goto exit;
=20
 		/* copy acquire response from buffer to p_hwfn */
 		memcpy(&p_iov->acquire_resp, resp, sizeof(p_iov->acquire_resp));
--=20
2.14.1
