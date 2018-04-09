Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237595-2-11337766384779108948
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237594; b=lF8KI+oWWhauEGiwgNxGi8ibtMdYMUBd+dNM/238B4w0AnItoF
    Ww2lQ9MF2y/uoHGVdOV+0JA8O1k4eCeUuUlD3erZTylzfZu47lBPi+CrZkj53LDc
    txQpQsCBT5fWj2nvKBSZ34MjQtvpJATItfoIQJyoHZULf3Lnk4k6nanFkVeMVKkA
    MzV0BozndbT1CAxUe5M4n/j6y1dopha0ZbTtpuVvEam8QKEedyLRXClIKzmIz0jr
    eVxKT3owFPJP+jLT9jeGrB+FEE2kb06a73FbJTVvRoqlX2qN1dfec+tl8/31owtq
    zcRECNXAhqcy5ho0IkCmAlFlmf+Nbg6juWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237594; bh=LrxsDSqHVT
    nP36A/t749B3n8vfEbAGX5B52x1jTUtGM=; b=tmbJ8TRdvs77TZWnAh6WtwhiiV
    dGGVS0GwALbuuyjc55PTZGVRFtOvqugbG7k/nXNcZGgMmeW42U+US86KJ3Ax9V/j
    TJlTGwk+fhJD/aGbmOKUBB8Rgv2Baew8TlypequTMP5qh+EKdj6F6eh3T05I+a1R
    xq2xUnsN+5OWXbwbUi4wjqSxArKAjOgvC4Ar7OjzswuJrmMYMc9f8p8BQBsyyjaR
    C42hRyTp0mvYfYyNXxyMrTHLumLiFrjPvCWBHtq9SkCnQ/bBNXsyaeY90GA9fYc9
    IefgHAL+9food4jQnhj+A7Gm8coKecOUZOKRGhUd491nFnZIC4QpeIzXURLQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PleOd7HU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PleOd7HU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBiYE36jgkdz+wCYIcZ/vjeOSBOvs3zUGu5FLQ8G7EUgRIR2NjvHiplulkTMlI29ENy544CzBhGk/70iMQsoBnSCOCNFWTRyzA//4Y8NCd15oHNkT3GG
    diBrubr2Ohy0AWHSwXtcDurCBPJC05zSDcNunLb/3kr20y1J0DyZVB9byJs2+ekPMwOjkLYc0YXA0EnFK/Ak8cs7KPxYwTxOZlFmBG3Sp6CS1HuQQoZcIdbz
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=ooZx4ZqJhFOSvjGlQLIA:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756563AbeDIBcm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:32:42 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:45331
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756595AbeDIAfr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jeff Mahoney <jeffm@suse.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 035/162] ixgbe: pci_set_drvdata must be called
 before register_netdev
Thread-Topic: [PATCH AUTOSEL for 4.4 035/162] ixgbe: pci_set_drvdata must be
 called before register_netdev
Thread-Index: AQHTz5mhr/Cg5g2TlUiC4BbEpb4Lcg==
Date: Mon, 9 Apr 2018 00:28:07 +0000
Message-ID: <20180409002738.163941-35-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:19BDKApWVDjUeP/jtXDZ6FbCkXM1rH5ZOhUMnv7ROmBcIuHe+ICRC2aXkCG9VhuGzu5JGmTrnBxk7lgMuZsF8ELR1qS5/XHqDcjkALJ0Iq1IcnCjThZj+GWpJyrzwy2tEOyH/aSw/mrWjMQtQkk1lMsu93NkQzAWsA5Uc2bD7wma78VhUGKm2cUb9vuHtHwzcApk1KOvNvhVhGyxAuSdX+5JX/GYWOZ70wZGbbvnDXUB8+hR0g1EkL74PEXEQS/j;20:lsngJ/gBpgd5iQpeQxv1iePTYIg5DZU7CTsCfoX1Azp/EeSxbZB4rwEgT+7Xtm/ftNWdCR6bvRZGuFQSOxcNLYWmO2a6fAY09sPn1FW8U084yesBMKXcAR5oE7iK/P8JyDRbZbqdQ4x3CxjARrsyy79H0HS4jJGSrxbeMj+EkmI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f36b028-1d16-4ec0-a7b9-08d59db1d510
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07252FE2FCBAA505075455C7FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(575784001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tACQXp9dSXLCDPZLpMDMUPpY0CjZmRJGqmwfuRCeLEyG2syJJfgAvq4eeMoQB95hjqFoeqD13+YNBaEFFw5RETAs4XupdRsdGXGeTrNN2YXfWmApFkV5K/h5LmkFbt45LwOG1f7pb1C2POdMBXOmpBZrxOtw3QnlKX4GQC9O3TlmknaS3VS/nT6r1bR0vysuYE4SJr9LyvYW3kwFwIJyzsXR7JTGH22ZDRtrvdQO1DLJxU06qCpm3qWarqmOMyjTXFibS6azMll3/3bQk6Lwy8GaWWLNFZ8hb4RMNI4IrjaWR7VyCmxux/NkBBJNnvgrsnYksqqYlJiE/caRySLDe0ERJ6s/IDDDsH1kBk/FYyCjU34yCBVhQWVPSQaD6/8MO4jFrqgm+jppA5uKkpxQf22qhdTzG46DWVGKEPwmO30=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f36b028-1d16-4ec0-a7b9-08d59db1d510
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:07.8486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

[ Upstream commit a09c0fc3f5d775231f1884e0e66c495065a461ee ]

We call pci_set_drvdata immediately after calling register_netdev,
which leaves a window where tasks writing to the sriov_numvfs sysfs
attribute can sneak in and crash the kernel.  register_netdev cleans
up after itself so placing pci_set_drvdata immediately before it
should preserve the intent of commit 0fb6a55cc31f ("ixgbe: fix crash
on rmmod after probe fail").

Fixes: 0fb6a55cc31f ("ixgbe: fix crash on rmmod after probe fail")
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/et=
hernet/intel/ixgbe/ixgbe_main.c
index 3283e8e1f409..72faaf4411b5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8963,11 +8963,11 @@ skip_sriov:
 			   "hardware.\n");
 	}
 	strcpy(netdev->name, "eth%d");
+	pci_set_drvdata(pdev, adapter);
 	err =3D register_netdev(netdev);
 	if (err)
 		goto err_register;
=20
-	pci_set_drvdata(pdev, adapter);
=20
 	/* power down the optics for 82599 SFP+ fiber */
 	if (hw->mac.ops.disable_tx_laser)
--=20
2.15.1
