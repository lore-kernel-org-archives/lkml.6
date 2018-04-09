Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523245813-2-17140051068981672943
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
    1523245813; b=d8oXdWIsW1e3M7pIv32vQbGWdvBnAj+K8kA/mBm+gZYdQ/w2Sl
    pn+LGC9IeSbDdKgGn+AOJ+QkfvfmwGbXCe9N7bU+cbpAp/lR7fSa4+A+Zcmb1zw2
    /ISKDLNnea9AMlQpDN4W/P+Pg6U7ziqhi9IWuThqefkBRGu3bCjU3pzYpXDtchWp
    nXUNHgdwSaH4fMLVOt8gFOgYn6sS5NQ+0ePCDGiNa4Ehsju2vU5lLpy5Sf3s0fZD
    rZ5Vkt5IDBJq41kLOBfm9BRlZQ432QP7kzs4t6Ea6FDVoR3SpXuy0UYBydd4lGxc
    sgtiUYxKTsRN5fUwfZrhO5T4zw8ClljchJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245813; bh=4S/+i+SbJG
    xtZjeE8m8h3LR/uZqTvCFeAGCivq0q/Ng=; b=VjaLyyCxEeDnhxiDfyhVsqdl0I
    Yr4MKUYaaK13S2nUBd//Wq21UtzLR0z0DIdxRj834f9Doxw1vO3Wc5TBYCnpB32G
    JcEAVUOs8dnZg9mqrutkINRf2PtuZ3x7cib3TmkWmlEqyXN/cP0/oU9gKvap3Jh4
    39SAXap2PSc7L08GIBOluVoEvY/2CaIuZc4YI6tfAHqamASgsHnw0B+LUCUyfGrx
    3G6/ZEtKdzJ406Aj1ROMTHYd7yUdvz9veEfKO953SCn2NMnbSnMG0SU1u3TzZQOm
    0ekn6sNOrOXtGwHQ/dl03N5ox1GwW/SpBrgNtgeXqAVJkQ6tMzwn9gPlo9mQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gJXNAwjC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gJXNAwjC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMXx1ETZv4KBLi1yGKP1Lh7ZbXX7rxC6HiodWgg0xDIalrllLsL8eNslnTEtJ27Y2uS+36Y9V8KUejJMGOv45izlc01DBzNwwc90oY0/IrNXoaXZxXEy
    Z2cJwLl0lTdmkKcyJj7I1GloFY7SQ+jQcIZGxchJXCSq8KNHxqfKt+dilX5pJvGzVEmza5NIM7qZgz0qZccwDvbs4fnByQ9/h7bLrgTEvIdwdod0aRfj/grN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=O-mhGO4gxEug2gm9yakA:9 a=IHtxeMSv5_HvZ_Ze:21 a=3yXupeBVGe-ocoZQ:21
    a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754687AbeDIDtd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:49:33 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:20288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754058AbeDIATa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 108/189] ibmvnic: Wait for device response
 when changing MAC
Thread-Topic: [PATCH AUTOSEL for 4.15 108/189] ibmvnic: Wait for device
 response when changing MAC
Thread-Index: AQHTz5g+WAl5T0NJUUCbXtMDE8bouw==
Date: Mon, 9 Apr 2018 00:18:11 +0000
Message-ID: <20180409001637.162453-108-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:+hXRQZA+RM0dlzmtQlmAxRBvEVZ4bvP+mQxSfPF7w/88u09XE3/4F2dhgGFtB4jG57DZTrFFu6fqq5nu+JCDj0Qzfv0DCsCn9PiAPShF86nQblC+iDBCsQb3rZ53l4YnXT+EmmwRd6BmiVhJCkqbWalulPrDkovPTjoDJ0qnbrRi5gSOkKpbpQ0Y8QMq7RA7oP8Uz5cIva2QduIGxUnNFzZLTd3Mv40sG6Bo+y6vnIU14WdMjE+g/jxBTnG6MB6Z;20:jJ2hXW1t4nh5NwxwQmepRdubSmcn9pD9HxttdIA/2p7J3zoN7QCFwTZZREPd5d6whIDmWOicUr/ghrBqkAMiM8jGqCxxqlYqMCgAqA+dJeBpFX20UxfPK4whGPPz73u2jPuCzNzaC4CG9VfewEAjUiCFfSjEE6u0kaP80OdNGjk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 765e86d9-aa95-46db-eb82-08d59daf8c38
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10634A8BF617295188B38D4BFBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: J26HAUor7fZ1vh9ggcMiA05x9xjfa1R4GBnv2KNdE2p51c2OYDe8y2akdC/o1EODEBSf9SBI9f30yE/zesc7QniGjsdRzQ7NL1li1K1o/CT/zgEi8WPga5U/OSkFE/0yl3JfZC+cz1Vv5cr+hbOUUFQfLZmwvTCq1TlsPb7pdhQpyJahtuz70zW5wN0P9CSeYN4GX547Q+uI2M+m9xmyYUaCNJ1TKTnrGCiidQt1S88kpEbasSOPq9krJwEz42qNKbaEkoF/epIUCv11XMKYQXnxM4jyNjEiekX+wvrpF+/6FovnDqoZ6Yi1NAUZb9zZhLqVsx25RaekErZmStTeGjw1XqXc0TAtUKqqQVB1VZ5vud9nJqEExGx1AHjgaVcPqwou7ZyDtpWffJxQyc3f6ADCYKdq7ti+wOSnep+hZIA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765e86d9-aa95-46db-eb82-08d59daf8c38
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:11.1311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

[ Upstream commit f813614f531114db796ad66ced75c5dc8db7aa3a ]

Wait for a response from the VNIC server before exiting after setting
the MAC address. The resolves an issue with bonding a VNIC client in
ALB or TLB modes. The bonding driver was changing the MAC address more
rapidly than the device could respond, causing the following errors.

"bond0: the hw address of slave eth2 is in use by the bond;
couldn't find a slave with a free hw address to give it
(this should not have happened)"

If the function waits until the change is finalized, these errors are
avoided.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/=
ibmvnic.c
index b65f5f3ac034..d4e87333bac2 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1543,15 +1543,19 @@ static int __ibmvnic_set_mac(struct net_device *net=
dev, struct sockaddr *p)
 	crq.change_mac_addr.first =3D IBMVNIC_CRQ_CMD;
 	crq.change_mac_addr.cmd =3D CHANGE_MAC_ADDR;
 	ether_addr_copy(&crq.change_mac_addr.mac_addr[0], addr->sa_data);
+
+	init_completion(&adapter->fw_done);
 	ibmvnic_send_crq(adapter, &crq);
+	wait_for_completion(&adapter->fw_done);
 	/* netdev->dev_addr is changed in handle_change_mac_rsp function */
-	return 0;
+	return adapter->fw_done_rc ? -EIO : 0;
 }
=20
 static int ibmvnic_set_mac(struct net_device *netdev, void *p)
 {
 	struct ibmvnic_adapter *adapter =3D netdev_priv(netdev);
 	struct sockaddr *addr =3D p;
+	int rc;
=20
 	if (adapter->state =3D=3D VNIC_PROBED) {
 		memcpy(&adapter->desired.mac, addr, sizeof(struct sockaddr));
@@ -1559,9 +1563,9 @@ static int ibmvnic_set_mac(struct net_device *netdev,=
 void *p)
 		return 0;
 	}
=20
-	__ibmvnic_set_mac(netdev, addr);
+	rc =3D __ibmvnic_set_mac(netdev, addr);
=20
-	return 0;
+	return rc;
 }
=20
 /**
@@ -3558,8 +3562,8 @@ static void handle_error_indication(union ibmvnic_crq=
 *crq,
 		ibmvnic_reset(adapter, VNIC_RESET_NON_FATAL);
 }
=20
-static void handle_change_mac_rsp(union ibmvnic_crq *crq,
-				  struct ibmvnic_adapter *adapter)
+static int handle_change_mac_rsp(union ibmvnic_crq *crq,
+				 struct ibmvnic_adapter *adapter)
 {
 	struct net_device *netdev =3D adapter->netdev;
 	struct device *dev =3D &adapter->vdev->dev;
@@ -3568,10 +3572,13 @@ static void handle_change_mac_rsp(union ibmvnic_crq=
 *crq,
 	rc =3D crq->change_mac_addr_rsp.rc.code;
 	if (rc) {
 		dev_err(dev, "Error %ld in CHANGE_MAC_ADDR_RSP\n", rc);
-		return;
+		goto out;
 	}
 	memcpy(netdev->dev_addr, &crq->change_mac_addr_rsp.mac_addr[0],
 	       ETH_ALEN);
+out:
+	complete(&adapter->fw_done);
+	return rc;
 }
=20
 static void handle_request_cap_rsp(union ibmvnic_crq *crq,
@@ -4031,7 +4038,7 @@ static void ibmvnic_handle_crq(union ibmvnic_crq *crq=
,
 		break;
 	case CHANGE_MAC_ADDR_RSP:
 		netdev_dbg(netdev, "Got MAC address change Response\n");
-		handle_change_mac_rsp(crq, adapter);
+		adapter->fw_done_rc =3D handle_change_mac_rsp(crq, adapter);
 		break;
 	case ERROR_INDICATION:
 		netdev_dbg(netdev, "Got Error Indication\n");
--=20
2.15.1
