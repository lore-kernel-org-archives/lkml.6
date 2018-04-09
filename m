Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234038-2-17306118652016526093
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
    1523234038; b=WZsTi6c0pgX+ItVH0S8bYaMYjMVtAOhCbkxVyMScoxnSu/vFRN
    BIqp+oTaV3NY+pIqn+34hiq3n3LFvaUFVQbKzO/02zF32ieenqTbUbnnVZDTS7pD
    L+18gYulAhrNKZU6Y19EJlBNhpBtAn/OT4+/zpmXfniG+M9RqTj8pG9ptxNLD2c4
    NI9EPnzzyzmE6sDh8909EdUMNvhkhzP54um5EFXbL3fSLV1dWe5RhrFQdU2iKhYX
    Gk7V45D/vCYCxl8Ogp7YQXgbZqpE06qfFfh18ah04W6jOS2bIlMg3XjVbiMJGw9U
    jqGs75MvA9bRnu4kgf9iWZArGUZPIMvu1pJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234038; bh=o6i6NxikyC
    YzG5gwDU3ArcqFn0amgAmUHa+4QIfGvY4=; b=IQiJp96cNJtEPC745hdyRUg+og
    6A4Xfjt/Epeu7g+1xnVBt6QMqT0QR20fgixyTFMILs1vXldiMCRtt/Ejo7HFN+XF
    Zk5j28zRoV5gz6WV6W9sFzMS1UNvhHNZFEWANyp8qg9qpyVKVqVFngEREKOUFxlT
    oReGPZfabTVrdvdOofkZzpPVftEsOzmriO5ljSys6onXoCTTjA2ltryBC9pigK0z
    o0a1QI5e1VN/76KNXfNHOPFhnmC7VKiAqk8zvzARTTxLc+9iql3dxHih1xIkvnpo
    2WQs+1pr11vmIX95b9YrHqt1UVnKy9jc4m02T74pboC/7imaB54yZ+ttGCcQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BI9/XJRG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BI9/XJRG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJiTt58QediLHFGPsQmbB8VozNRdNyUsmufIfi6e72s3j5mX4NEkDiEOdBjKokaq5DNj/dH20k/Z1BPK9n0cyiqATeO+IrUo8vOu5flqF9nhp5mkExX0
    OMTZ6oELIC77b1r0bqkEijGJmQgAeEFp7zorVzo6+fieyQt9kt5NZkERQXzTxgXU0AouRE/Ay0CTrMNXzbcmQyk7m6DTaBwsvvGJpMWaJQhPtqeURxrVWBLK
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gXLdhW2jAAAA:8 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=98M8BWyZpLcfewlxYQQA:9 a=uLeawkheiNOiJFPd:21
    a=yCE3bErIF824xLa6:21 a=wPNLvfGTeEIA:10 a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932331AbeDIAdz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:33:55 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:18358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932333AbeDIAdt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Logan Gunthorpe <logang@deltatee.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 250/293] ntb_transport: Fix bug with
 max_mw_size parameter
Thread-Topic: [PATCH AUTOSEL for 4.9 250/293] ntb_transport: Fix bug with
 max_mw_size parameter
Thread-Index: AQHTz5la5tJSyZyLx0e/Em5sBnsPhg==
Date: Mon, 9 Apr 2018 00:26:07 +0000
Message-ID: <20180409002239.163177-250-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:4fJK/EMTCoAB1duIEmARBb7DSvbFs6Y7WfA+t+OR3W6QMy4Vem1ZlekW9q1e6s0WHY6Mm6NhOqQZ1ppdYEn4NclzUhT5ekVEhAWirnaaEJAixkT7H9rVq3EYimMvAoQzvgxmsw9vg0qdlMhVYc/k4ymHiABADIpqy0VsSdZSxjp22uNqdBRM57pr54Bn3VRMW/XLaiPnd0O+qqNfP31M6dta/L6fnqXcpQ9/8Bi0THhHsZR84LUXHC14x+9vf5jk;20:AMlXcDHXGWOUEhMqJ6v2G76W9jLgwPyBY9RH4xsI/r001JiUIOHGNZQ6e4evKy3G1wFrEVFVxq/U71md9v+gx7k+XqBShOZE81/zK0q3TPK6SBkNisJgF6yoZa+1FQDVggBiTXnrriN02OG4gWMD6uuzN7EU1GPo7x8HBRVYP5k=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d6cb08b-f805-4699-1162-08d59db18e84
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806B1D55A62671E08630FCDFBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(56004941905204)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(575784001)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +dN448zINdQYl27dDlkILGioHugAuYhUAzydl+1v7+RUb9WMUxkUGMX428nVqN+44fXeu5bTYc/1QCYRe0kfiyMrIgh21ZWgEXyzTY+LycxvJuuSRVLPIUvwQTZ2YF4yWYyzy6x67gN6zIojFnIEEpEtVKzbvLpt4jz3Far0uICSGBs6X4qnlsd408nwhdZ3s9QXMziEM35LVcJqZ+O+Xi5BLoAOH0uWs8YEFjvAUIxSWbdI35jUbFjPy8Rb1b9i5Zqbpf5F26O9CJw7XrIXL8guHMA7D5GcXXDzvFnj67HrPYgmBfjDBOrcJMLBEgS9dXc5QkJ/hMe5dVKoYqHX9WzClVZ/5IGJ5fuU9AyS6Dajd2WPSGzV9tq56m74IyDolU+eJ6k+1dVlwyaeCpkWYccOXnGbJ5dN0U6pFvzH0Pw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6cb08b-f805-4699-1162-08d59db18e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:07.6600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit cbd27448faff4843ac4b66cc71445a10623ff48d ]

When using the max_mw_size parameter of ntb_transport to limit the size of
the Memory windows, communication cannot be established and the queues
freeze.

This is because the mw_size that's reported to the peer is correctly
limited but the size used locally is not. So the MW is initialized
with a buffer smaller than the window but the TX side is using the
full window. This means the TX side will be writing to a region of the
window that points nowhere.

This is easily fixed by applying the same limit to tx_size in
ntb_transport_init_queue().

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ntb/ntb_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 24222a5d8df2..da95bd8f0f72 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -996,6 +996,9 @@ static int ntb_transport_init_queue(struct ntb_transpor=
t_ctx *nt,
 	mw_base =3D nt->mw_vec[mw_num].phys_addr;
 	mw_size =3D nt->mw_vec[mw_num].phys_size;
=20
+	if (max_mw_size && mw_size > max_mw_size)
+		mw_size =3D max_mw_size;
+
 	tx_size =3D (unsigned int)mw_size / num_qps_mw;
 	qp_offset =3D tx_size * (qp_num / mw_count);
=20
--=20
2.15.1
