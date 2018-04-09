Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235251-2-6353655295417575487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235250; b=bIPikQ3KXLWNqxKtvk5mpEjQWEx+pzxhcEbrvh3Y65HUqN3O9R
    MY7hYGTKHMdl3sngqf4PBTZjHlmUYuGOtRYh1hj/wQMVfqYyR0E9glXNgte+ZD7N
    jhTUOPCVRjhYVDFqiG2ynMNq38otKUJMXBWLYvJ5nX+/jY+FfkFiifQIxRn4hrwy
    bC5o51zBMHNiHz7pyUQF1o+L0JmPtzf+zw36HHKNCQaFNPTbEGuKKRwGaLfJgQqU
    C6sG97HD/69BXPpdzD2+NN65CfAo5NEeLTEaoXfwQEGeA+kWRKMFT0fJkFYORftE
    nJUFpVx1gblOGlT9kEABylESYNWalMnEO5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235250; bh=LGr8exQCQf
    PSJwJr6bX8GoKRQKSwVHxf+qrVwsZdmd0=; b=A1LFmltHApdpxKbGsTe8+H7tZ0
    ake0v/znD7K4nKDMVDXp6QkcoSr+BFS9JcYDxiUT/nftTlS7o9l9N7jcp32Zkf0e
    gAMjV1pb74BXrh0bbJd9jowN7R55ewoAhrqAWK+hjiXo47VxrJY2Gbx1aEDLY1s6
    6cXVbrxajG5iIokJkQwUb5RJE1bdY3Sq6gZKk9SWG3gVrHwnvL5DOWVvRXXz/6Ua
    i1BPS8ItwHoogQBshq69iYet/v1nA8OG3W7mPKpqb9d/C8c1S70px6y48rYBPc6W
    5KBAVsFJel4DBLFIhnxW+QDt/0mNRETzc8pF6Lq/EqjaRsESvx86INS3r0Qg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DtYnq9aT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DtYnq9aT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOAp6ZwuqJf53K6W2btfE5yPgOMT9mUVfMe6XmNfI5+76KhvQAg7Aq5pyG34bSIqXT80McXIpew5aWA8AQSFXFc/jT9hJFoqYtwk6eL8R3mLS89uf+86
    FQCFOxCdRGEzlZaozR7k7+T+roRHBV+VTRk5zNDK9kaYca6AQwz2z0IAcIPhchSdzkpUATBTDk0t0PfepYwYRCY/YFARBN9XxmV1tlVcESB9bv1lplmJzDxT
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=rbF3Xw_BdXdx--86PCgA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933376AbeDIAlL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:41:11 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:64040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933320AbeDIAk3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 048/101] scsi: bnx2i: missing error code in
 bnx2i_ep_connect()
Thread-Topic: [PATCH AUTOSEL for 3.18 048/101] scsi: bnx2i: missing error code
 in bnx2i_ep_connect()
Thread-Index: AQHTz5q6VAtsljCLQEq78QFUriNBVg==
Date: Mon, 9 Apr 2018 00:35:58 +0000
Message-ID: <20180409003505.164715-48-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:gtsd/qgCwcCmo6hMlYOC60UMgLMy7dnWN9GnA7V9w4I665AUOBb1XemeauCUYdksGY9rSF70lFclJ3TY6C9XBxgHYIAnlnMYQxGnnPagdZCAv0oIGGocd3Kp0ULH5YScMtiVOOvyEVXccPeMUrOZwZijusS12YD0tOJXtPuJe/Y9xag7+Jxj+NCpBCBr/Et6LyKhW7VMrScreRWXFRA0If4TZkxxz1bwF8ZV5ts6DFwtMK7z0NLpYul6D3LhAmvK;20:f76ywugYwNd38tSxWK3tj4AkLqLtUPct7JMhC0URnpg+x4dnTyMCN1WUcvdXxf6hGrAigx3fd4o/niLKv4ZnHvTI+N+kMFJ8ZtD5K2S5E4SrEyqenzeA9Y0WlpVysCKzwdDboaLJSEcWvXjXbZdCHauq/XM3dXfmgSCyjfs6wpw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 023cab0a-fdd8-4562-b89c-08d59db27b9a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870749B0AA436B1AECAF856FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(15760500003)(22452003)(3846002)(86362001)(36756003)(575784001)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(486006)(59450400001)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: RnVoJbuxR+AR1PcPOTe47UBYlvwJyAfdZZedek+UX18+uDrxPtlpOAyVKpiP1K5mXtlQCSPqFTUksBAG9fKVkwbHIP4gRqyT+EwPO7zIRaoov4v9LUXFu1zGCVxA8msbbwiJhwbqUVgJvnSEsPqMroJQ1dh7uc3C4PdS8FCNrVNnVZpviyCU67es5PCRSPS304v5kgpiWv7vRWXLCmNCvtT9Ps510cUBcLP3PlPoJ7Se27u+R9+m04UMRZ9hVHTOZT2PKEbfTfO4prUkSjku9i2X0C/tbR9U5scVW6W3q7tDCMfgnLem6N2VUaDCDu+yDytunaUHnVVJLtz8FHPmi89FDoj7xKK6B+WRi/vxAZesfWNu1wf9ArJuNYCUFzxoDvr3RqJ29QTRKEAjKcqqzr0W7srp5hFNhqt8wgT7LtY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023cab0a-fdd8-4562-b89c-08d59db27b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:58.3922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 1d32a62c74b3bcb69822b0f4745af5410cfec3a7 ]

If bnx2i_map_ep_dbell_regs() then we accidentally return NULL instead of
an error pointer.  It results in a NULL dereference in
iscsi_if_ep_connect().

Fixes: cf4e6363859d ("[SCSI] bnx2i: Add bnx2i iSCSI driver.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/bnx2i/bnx2i_iscsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_is=
csi.c
index 7a36388822aa..6644618ac85c 100644
--- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
+++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
@@ -1907,7 +1907,8 @@ static struct iscsi_endpoint *bnx2i_ep_connect(struct=
 Scsi_Host *shost,
=20
 	bnx2i_ep_active_list_add(hba, bnx2i_ep);
=20
-	if (bnx2i_map_ep_dbell_regs(bnx2i_ep))
+	rc =3D bnx2i_map_ep_dbell_regs(bnx2i_ep);
+	if (rc)
 		goto del_active_ep;
=20
 	mutex_unlock(&hba->net_dev_lock);
--=20
2.15.1
