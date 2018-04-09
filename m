Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244793-2-14498246218018543050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244793; b=Ym+UU1SuurYyUUDOqFNvmKRvYCMvHzS2fofb6vqlOYKK4j07aS
    I/K4s+GbRrrpz9p1wFWjsNRbsQsPOfPokQHbKNnL/+PVaqmZSFgq0ryR5h4vHBzV
    doFFapYIRfxdUpiOJrcfbeh1f5PxWNjQZol0BqkrwJFlVCbILOXYlaDrwCqblfM2
    Z6KBZkc0azcX8/L4hiEnX6PmWCl2u1MjizfiIxTMZPSXavP2gC9cI3lXU4v0pk2I
    WaSVifwK8mwF8yxjp9hJ45X8asQ93bsVaqKFP1gcStyXq8HfdFDYcpwnmiYiS6vG
    TGDd+mtx9Q/Mhrf67f0uD5JcmRSIo2dgc3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244793; bh=zro0/cGf8T
    aiKOrrmQPIDs9U1ApmnL51QbZCUcL50QY=; b=qJ9NgBs+e4U4k1tZ/dS6NM8uhA
    IG5AGEXFZqwlZasQgFmbxaXqzR3pAgO2CfZlla7GsLYkzfU1lLT0tdKM9Esz62Z4
    2n0ztaX1VlJhXpc0YUXXgO0NhhhHZx9dutBmcPaKyfpC5w5pIgBK82ZnORxb4YQJ
    DDD8ylZ44QIfTtJ9Jku3l5Hak56TUsK96H0ulSGALtfisRYAZEq5qmOY+j61xliP
    KxRx+M031Bo5+14O8zTYzNypU3DWKJKf3s8M28mhbOAELzVmXzkoU1KXFLlI93r4
    VVtBRIfJOUvxEKjP2NsiRC0FeB1D6ZHC/5EkrY7d6tWEfcn/rXhd8x0DZmoQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J7IOVL9v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J7IOVL9v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK61njCeg6D7RhYMD2J32LaQjqAKyFhyLO2jw2bG3Umo1Y2IUX8hgwUuD9banr0QMzD+9TUtti2oS5cXMIf6+pmEjU6N2FRczCSk309owL9ozsyUnK4+
    9/al2UWlE2m5apyW9QpRjbphS452cpMV/0CItGOWPnP0X1YFnEZKZCQpz4PllzeaCyskly5/UzLgq/s+/SIYRnf2V+0j7QaK08Xm7FGyChL8a5sOTCY8E9wd
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=QMMmC_yjGklOHjtiTxAA:9 a=r5vPk9-vxcbjEkJ1:21 a=MrfNF6HaerCAepFb:21
    a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbeDIDdK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:33:10 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:54803
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753116AbeDIAVT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 175/189] ibmvnic: Reset long term map ID
 counter
Thread-Topic: [PATCH AUTOSEL for 4.15 175/189] ibmvnic: Reset long term map ID
 counter
Thread-Index: AQHTz5hfCxkc3fyu5kikHArEmBOjcQ==
Date: Mon, 9 Apr 2018 00:19:07 +0000
Message-ID: <20180409001637.162453-175-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:jzahV3fHo+gGyOCTS1lXfF3IofTaEvDHxNpqjZFgWXlnvRKbsidd/36Cv2Ni1f/x7fjjUEgs7DaUQVKzNdZuwyOsSsXD8eiNmKzu3i9RKushxsFFVLeoBvCqHGAm0Ua1ym5osNi6y9ldi/CXFXfRoqRmWFh8vVDiUDCeV8Jzj3C8H5PxFP/eb13nh8NEB3EQmXLLOHhN70G0da+WL9sazbGJKz+8szlOFwYwIOYdX8zKnShpNlCoX9NJfUX/2OOX;20:HgsUc/jusb5b3aN5AOLt84b5faPyAGbeuy1SMjFF+fJKUBQuzmm0lOZMlskbOIFo2L6sDbEM0G9Jizj88bSMdbcaZWNnmscXhKobKb5m7lG1wCEjwqPxgeSpnDEtGeEBj464+fU4sv7d74ZJ2IDdpT+8kEGP+Cq6YwvWj73DHI4=
X-MS-Office365-Filtering-Correlation-Id: 59732049-acd9-49ce-2ace-08d59dafcd7b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125F47E2727CC39063717F1FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kwRkCR+96gGUXqc46844sU2ZbhDfUX9e5Xhld5CzbCxMjpCZJtXtN5Ar8yfqgzcSrsHH0oUEUrznZ9U1IQlMmMNBQNjXZ0dLseM/LiSmErUiH8td3StoeHMFCJ9C+cPBhQA4lEx+pe1Uhh+z8I7l0G/tDXgf64mY9CdpI/5bqDy/zZvAnbuLTNJUjMMzW3MSDV6qZn2q8M0J/cOjiIwKmy7omHB/QFp2lZKplqLdeyILlq5dmdVpSVQiGxVXyYuyV2ug0Tl8gQ4I9X7gnyMoM9I+9AHdEbLwXQ883Z6x1CPnehb6w/filbv5sKpYcVO3Z7lyM5G0/HK6dsys+WimiDfGLh8PCKw2RCxSS4TUva6FwfW90eit8WjDPYlxP+XnDDAkkSmzwG/XPtNUfz4daylVvaCXGM09X/1T+ip+gyw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59732049-acd9-49ce-2ace-08d59dafcd7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:07.5021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

[ Upstream commit faefaa97215a0c05105d7ae180fe1a3b5979ad1f ]

When allocating RX or TX buffer pools, the driver needs to provide a
unique mapping ID to firmware for each pool. This value is assigned
using a counter which is incremented after a new pool is created. The
ID can be an integer ranging from 1-255. When migrating to a device
that requests a different number of queues, this value was not being
reset properly. As a result, after enough migrations, the counter
exceeded the upper bound and pool creation failed. This is fixed by
resetting the counter to one in this case.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/=
ibmvnic.c
index 4ba49a98c689..297007678584 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1634,6 +1634,7 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 				return rc;
 		} else if (adapter->req_rx_queues !=3D old_num_rx_queues ||
 			   adapter->req_tx_queues !=3D old_num_tx_queues) {
+			adapter->map_id =3D 1;
 			release_rx_pools(adapter);
 			release_tx_pools(adapter);
 			init_rx_pools(netdev);
--=20
2.15.1
