Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517680884-2-17742377336136382596
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680883; b=tI56vewu0sSUkLeddaZVgOa2eOI/1YTgI8eu80Ih7FjRrzS
    /c7ObHuLitBTXSJcL3gLD5qDM/EKhQ/tKFpeKCd4sLv6akK+zhsv4pO2RVxYcknU
    dyDjws/H9oCFwtRbDUIdS3BNyJgxEbteDXS0D8UOMDl9inIkoUJyMftxamm5YKb7
    zQm0Fk9kZuHyJvquV9vfxf6TtU0lSVcUHJs8vpBcwEwdSol6RreefOZ3mCiKPNdc
    bc9ee3ScEt03R+uL85r2/vR5Awu4fmgjoQP/zgQwO3Nn569b8emJgNXy+4hWz4Y7
    G4DiO1jQ8o7UqI4v05xagjGeIcD4Bp4OeoTHUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680883; bh=T6meZv
    7+Fd/gQssU006hnnK7yvBEXyeGESA2Hgigl4E=; b=no7KJEtJ3G/3QBtW8fboyG
    QoIC//aYAdIigmSpto0W6vBn3GuL0z2bLYU67A4tZyr+1qLSWFg0VL/MELF1+GsA
    wBXiq0CUed+QoEO/rM+3kbIKUOvYjzbQT/dqRQbIfPvKgl7v83dnmitD3Z5Gr4i5
    D+VQofK9BqUkIGSXqwT7sIc5H+ATt6TQ5paX1SAp4eI8vYuPocjronc+VaUMO6Z1
    jO7mc2ZgsHTfSqaD0q52EoCAxV879TafKVXegQSFUdhrzTEgLGMTdXPtHEBDEiit
    NKhRV+PKZ6Fe9ECUINGQDIh9M2lMhsQSEtOIe1rp6DC/7+E8bxvs4TdYrJs0e7jw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jSGtThzW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jSGtThzW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbeBCSBN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:01:13 -0500
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:24267
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752708AbeBCSAh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:37 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 008/110] nvme-fc: remove double put reference
 if admin connect fails
Thread-Topic: [PATCH AUTOSEL for 4.14 008/110] nvme-fc: remove double put
 reference if admin connect fails
Thread-Index: AQHTnRjgYDi4pzVI+U6qcp7RPUIqAQ==
Date: Sat, 3 Feb 2018 18:00:30 +0000
Message-ID: <20180203180015.29073-8-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;6:iNHfHT/0S+WbFcSGFNLm4byVjHlCCSPCsad4bAX05WLwYglagCpbR7zXRiZxycG/bqzTkD4F/HM+/bIFyWArOtuZv0lmzI5XHfiori9BCXtlZFMxkbNUKtOR51Kb2vpRkyuYgzuCW6KWGS5m0GrV6Kwf3TK32IyBSJ4QRDSkUIkuE3QrB9avYLeF0w4IDXA68Ur4GcxkiEyBV5XftoQlsCd7HV9jq4jVDp6ULIjj0Mb+c/2WVF184dyBwSsxPrurZu4SA3BcC5UKdyri1nvm6iZFXWLenPSWLdihXrgWrOlJxitmT91eozsca1jvpdnd+Nbe3ip7P3/35tu303suFxtxFLOrYMfAuSwBelMheaF50R3spGuMvHLpzeJBz4AD;5:3JAhRtBtGGYnSqXwJHM3NNQ4lPBzNqtaVDSWwyntDSpSVCVCLMjyf7FgApVtgI2cT7ztF+MkPrZX+Jj8CEEwvoD9ORDpWiqLJNda6OJcuitIWQ7pcsTDZTR2kFqDUuh76rG106ztAwBbFvLXQOIrR0CcM7DJeg/vMVieAM3ZkjQ=;24:/ZUcJk9Kn8Hzumy5bsod8QCfcrTtDKiNAKvnwt7pcnVYgzNzR2DP4xuco3Oa7Gf4PIwFNG0zquUqf0+Am++Upzd1Em9FxJE2SlkvzJOeiYI=;7:cjWyq7QD1vdZHzfVQLgU6JYkSiV1HatLdHDwPZ3DFMgLuI8LCskKq3arq4DI3mrH/KrWpyPtZyAbv88llbLXuIfSaCColXUBbnJofqI+sPQGzv7t2A86ukOqCp+VJF8ehhwajLrnfCqC8TYZ4F3g5LgtWSn4CmgliO8TkIuA/lVmtqO8bxuBlnicRfKp0jYTxh8UrBw78KTKXzQjpxmKNXZHmV9RVsYj1Ln1EDHUsFXoAXRUHtFH6GAYYvy/pZYL
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0d1a52f-bfc6-4c42-ce66-08d56b3004bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB1043B0C56F03B5311B08E156FBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(86362001)(97736004)(25786009)(22452003)(39060400002)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: OW9ihuocaG7b1t7Zzgh3eFrUcODoXxsdGiZGwsc2AVUYbZemfYg3JQQrL5XW5kJHwSW1+1iXfPutAmm/hp8SPg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d1a52f-bfc6-4c42-ce66-08d56b3004bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:30.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 4596e752db02d47038cd7c965419789ab15d1985 ]

There are two put references in the failure case of initial
create_association. The first put actually frees the controller, thus the
second put references freed memory.

Remove the unnecessary 2nd put.

Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/host/fc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3148d760d825..7deb7b5d8683 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2876,7 +2876,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctr=
l_options *opts,
=20
 		/* initiate nvme ctrl ref counting teardown */
 		nvme_uninit_ctrl(&ctrl->ctrl);
-		nvme_put_ctrl(&ctrl->ctrl);
=20
 		/* Remove core ctrl ref. */
 		nvme_put_ctrl(&ctrl->ctrl);
--=20
2.11.0
