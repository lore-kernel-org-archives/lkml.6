Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243728-2-6444988960725777274
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
    1523243727; b=UjFGgV1QCCB+YxNInb58cVPJj0thtX3fZ2izaq1ZlfWPcsxc+h
    aonKCzXLFiv0uUxotreiHGc2uAMsR+FO/YT5x1v3pgxfst8GsOLttrpKHDK698zu
    /00co/GjO3e5hwhADKInWY/1Su590m9PB5nMm95a81+k71FkUhgq0vIuzKXBjHwV
    AsJlAMrOsD2m6oqQ6TiEoP9l21gvQnW3U4SKK5oB1QNJoUDoqZbzp3jxN7q+AkOy
    CL62mSKo37gU3eyG5STNUbpK3sDL2q0RHffWy1JnaKMOqS/gs5maAcn9XQMMBfaS
    YXsxRAsNToDFN2CRbsGyST3cSSe/R4aJkINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243727; bh=m8ixNJUDnB
    oYqC3YLBR9gNmirw+Cja9hUhW1V+7YEII=; b=si/yydbMPqpNli6djx0VoaxoGy
    c58FbhAg4kvhFxbDnZWh1+qS++zs9FKVp4jpzGj/IrqvEtBKlWlMK5dKACh/AOoT
    5nL5WHYyKFv+W/xobnA5782aiAMU0eEjfb6TexlehoXZzDy2FHn6Fppp7H0GNIip
    AVyGDXWr6RpWgqNyb6OuQ04sFVjODFRiGmDCfC55YH0lqGhCBMaC0mPiRvMeq3SZ
    FFMMu/zwVfqNNib9CeMzJrv0+R/OdgINpMXj9IkA87A89niC8nnwJw170pf4ezPI
    6huiBx2usRksF3YCO9SFc+7N3kfdJ3STXHeoy7MVwQaOfe3ynDYjC5fsE7rg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LLD73u76 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LLD73u76 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKtnaSXJUrcYXUr0SO2GFRZSUpoktlx0d3+G7BEXJqpZodYjfqqg9IPYW0cunyiZXUDDzxeXQx3MqCi1eoooYBKYq8xCIaQZmFkMBLWZcO+KzpP44CUq
    VBVmfgxKG9F0c6dD+99EwbCfDEIm7neeoqp0P6hpwh2QS+C2NyPBo8epLW73MHo9yBzKWHdofyXoTNZqpv1kUx0yEoN+aHSml+0PLQsHhmsr9sCdxYRIZyZU
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=K1sXOyfe0bMs6rlRlcsA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeDIDPV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:15:21 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754921AbeDIAXq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alan Brady <alan.brady@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 067/161] i40evf: ignore link up if not
 running
Thread-Topic: [PATCH AUTOSEL for 4.14 067/161] i40evf: ignore link up if not
 running
Thread-Index: AQHTz5iXrmnecz5cd0yLxKpD9m9/LA==
Date: Mon, 9 Apr 2018 00:20:40 +0000
Message-ID: <20180409001936.162706-67-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:0E+V/DkVH0pMT4xh2za3f3Nwj2PLjBxKCH1xuDxLl39ojLzjaL9Q7gn8Z3rJAxMJFWM/Xm4fp+qew1dzpOWtBF+u3pR7CwlBd3WnL6VIfikXtlfgnzLZvWflnm2cntnKZfgGU7zd6vHjIX4ELI/nxoF+zdjqmUleSnW+l8LahyokFB820SOP3QkaoCvd6cwuJYoyKhW5pN2LcFbb6pCKsmP1C2jlLMAyP8HPMqRnBDCXO+G21hgS84MPtX0uyLgH;20:LhUyEmzfPX53XPzASyeZWO2zN6uANxhczYkkhZecB51kFAQHg5Zmz2K6O36hjJwyiIu0KzrZxbFnnx0T1G6zdqx3W0EPVN7/NMSxIbd+h4YGQULSwoL82W26qoNzG7epx38QO6nWDwWCER9ZtfEiCT2eTK7eIfPOj8/XXkJ8e6Q=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ed5200b-8b36-4a6f-0231-08d59db02732
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB108065A36A88DF004A218429FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(6666003)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lnxP4tYvRck7IRkU8Ljh8bjslvRu/f7re5qUaqDByax9IJOxtUR6MFJ5noXDqLj4p4ERPrdBqxpTleuylfMQNp5CVVtPrhxzgCzccNJ6ldiwgbmEXd4/ZeDHJ/aCP9ov8fcc3VZcqg2S8G6Rna62dZyYz7cq5TbpNjYavuomSmbGP4PgeN81a/B1XH0UefShDEm3+5m5EwmFUapvzT2wGvYkE1Y1SEL8SUpbfyj/9aCAHHzvD3v2E0GocjeshxRX+6FhlIsBVH7YoyRJpphjk20apwHLceaN0IT+eNmnzFVLyQBSijayn3WlhipUu+sodvIzV1M3XKDrOzfUfq3mOZZ0TIWD1vtNJeUKP6+lizIt6hJ4YWJ9OhGlyZCTnP4ScG7lgfJYFkzKLwkCCj7TJV8i/iLkq2rEzdEuqr+pDJ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed5200b-8b36-4a6f-0231-08d59db02732
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:40.7222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Brady <alan.brady@intel.com>

[ Upstream commit e0346f9fcb6c636d2f870e6666de8781413f34ea ]

If we receive the link status message from PF with link up before queues
are actually enabled, it will trigger a TX hang.  This fixes the issue
by ignoring a link up message if the VF state is not yet in RUNNING
state.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 35 ++++++++++++++----=
----
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/=
net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 85876f4fb1fb..46bf11afba08 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -937,23 +937,34 @@ void i40evf_virtchnl_completion(struct i40evf_adapter=
 *adapter,
 	if (v_opcode =3D=3D VIRTCHNL_OP_EVENT) {
 		struct virtchnl_pf_event *vpe =3D
 			(struct virtchnl_pf_event *)msg;
+		bool link_up =3D vpe->event_data.link_event.link_status;
 		switch (vpe->event) {
 		case VIRTCHNL_EVENT_LINK_CHANGE:
 			adapter->link_speed =3D
 				vpe->event_data.link_event.link_speed;
-			if (adapter->link_up !=3D
-			    vpe->event_data.link_event.link_status) {
-				adapter->link_up =3D
-					vpe->event_data.link_event.link_status;
-				if (adapter->link_up) {
-					netif_tx_start_all_queues(netdev);
-					netif_carrier_on(netdev);
-				} else {
-					netif_tx_stop_all_queues(netdev);
-					netif_carrier_off(netdev);
-				}
-				i40evf_print_link_message(adapter);
+
+			/* we've already got the right link status, bail */
+			if (adapter->link_up =3D=3D link_up)
+				break;
+
+			/* If we get link up message and start queues before
+			 * our queues are configured it will trigger a TX hang.
+			 * In that case, just ignore the link status message,
+			 * we'll get another one after we enable queues and
+			 * actually prepared to send traffic.
+			 */
+			if (link_up && adapter->state !=3D __I40EVF_RUNNING)
+				break;
+
+			adapter->link_up =3D link_up;
+			if (link_up) {
+				netif_tx_start_all_queues(netdev);
+				netif_carrier_on(netdev);
+			} else {
+				netif_tx_stop_all_queues(netdev);
+				netif_carrier_off(netdev);
 			}
+			i40evf_print_link_message(adapter);
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
 			dev_info(&adapter->pdev->dev, "PF reset warning received\n");
--=20
2.15.1
