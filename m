Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241114-2-13888849107114945759
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
    1523241113; b=v0zm+DGB2bm/jYUypvpNPsJEl4mKMFR1A3ZllYc7V8Mxp1PYiG
    wQWwm39Djkae+O9E2hr0cUlB6qvDzgIeti1/pPk00dCpb/6KYY5wcIrJoT24cvnv
    LLv+w2LvIY19ZVB8f30FFWdg6YejJrgRZcXm/cM/eQ0aqiUrFWs2SQYm8G2MvghA
    SDhw7kozySExqiTP+mz93Lk5lGcAmCLFDsN3sGtUyyGvQurYa6N3Y0PJogf/Z/IQ
    1gWaxNMfP3r2UlqUhGFkqITx38XeRdTD2hKgQO7d1I7w3cmCJPJLJUrQO1jFe+2p
    9mLAzL0X5jkiOXBMOP7B3xWmXT7KBphh9+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241113; bh=RE1htkhaDR
    57IPzGSt98RC5O75rpGOwPf0pBMrJpc2U=; b=J741FXUdf80H8x0u8ol/zKXtSG
    AIaDVw4yfHXFcfeWFHen8piTExAJrJNaRGnsq4+/rRuj5zWSQTkCnR7OdP9/bUe5
    sjvddMM+3US1uajPz8cfhWQDO3ajO0acUfKNm8tck1hrU5g0IWQ3+hHoArbjpQoy
    HwsbmvhAPfJZGwDsSiYsfDuU8ugiJ9vHpfnuIsvmgIczsW9JSDqWhbgpyX/PbCs+
    NsjuZhbaeR+Gj5C4mkLuBJ3BKMLE7HgFc02weOAHC16RF7OlvR6fssQxaIt5J/Db
    FrU+xxRIoIyWGU4F+sm1NGv0y+1UCB1wm0djZNlan3okEKkpZOLuCzJoaFXg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AGR0HMnC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AGR0HMnC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBA3r2nh71MbhKsfTjAW5lLkJZETQk8kU3GH/c9cPw0ObwWn1IYqrUn6GSAnVhoFbsgBBH/0UGQg/JArqzILUJNNxwTaE4OSlFrcK2y4nO9FZWU2hCNU
    exyCmC8lcuvKLqWztQVJ7VjoBHrF6xo8OYKKacdgHQ2mzjbpl5uErvAp5l8iftKJtftm0+H9yABFI6I6V240oQ+NUtRMdSu6TY8s6yWI1Z8093kjNZmBtb5c
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=ooZx4ZqJhFOSvjGlQLIA:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757702AbeDICbe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:31:34 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:61393
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754724AbeDIA2U (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jeff Mahoney <jeffm@suse.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 070/293] ixgbe: pci_set_drvdata must be called
 before register_netdev
Thread-Topic: [PATCH AUTOSEL for 4.9 070/293] ixgbe: pci_set_drvdata must be
 called before register_netdev
Thread-Index: AQHTz5kHlOqupPkrr0yWqwlQsr/7/g==
Date: Mon, 9 Apr 2018 00:23:48 +0000
Message-ID: <20180409002239.163177-70-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:5/kIwxQ/oLJ3UAEZThoBjQwfh2Ji1mo56jKGTdTkQqEvSl4ElilPjBvgERy6xOeB2QDOxoV0C8YKMKeuEtzJruXDxHQ0enxyjP4v2p98JYmAbuiSnzULQjbNLyaSDidZjmrNH5/4dKbBueN1vsMN/7SGTQJbyZlPnkSkRjqJnanLBY0XevaSiNBXik1+7FpyJ6LbXPzdZFdqiVIQ3x8CbTdNjGelYGO8UK6aGKxpIrJb7kS344wqcqSD41tlbbvO;20:SQxTXKb6qTWj+Op46xVj87ghPjC5m1YxChBql7Bl9eGR68M/7cOuN5n4qg8Fm93r/M8gno1yHF7wtKvzONT19AmRTGyqco7dsvY9wcgAzdyjJZUm7mNeoS6+qUSSAVHfqOuE+Xj5YoONcKfbDbmxVZcGcGKcXMxKrJRmLR3/95w=
X-MS-Office365-Filtering-Correlation-Id: ee2311b9-2fed-4ff7-3c13-08d59db0c6f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871F5EFCA2F6EA65B307E2FFBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(575784001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(6666003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: tyaTs7nUCYLH1k9G4Fb2HLvVDH/nMeRstJQcyPPiae3oL5ZzMmYpXsGDtUjztR5Ta+xnKMQJdQ7L2Kf2m4Yz5msffWF3OfqC8wHR0fmUVmI1pEXQWumK2SYRiqPm5EtYGw32vi9wOVLXF4og4Ihx3j3Vxyj7glGjef6UfDppBRTSY5ZJBOQ09NAGROtpVq/Ra8MZKUb0x1ANfUg2RqrlkES0BSJq/wcHDmOnBG5UXIqa+DStq0uCbqtC5m3alSRTRvRTAfvxN9qDsy+FqwuRrbkf2jR3md+TPXgde40i1nNKeRE3DOB1HWbkq2E12pLVRTMaSjDqXmYsfUYjbfSR2/H7+UnoEgGnwJ+rmYAbeJ5vqUaMBngILLYFhUqb8BbVTf/Ng/q+mi8kpbpSCkKBC7n3VWT+P6mbnRimzxwReAY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2311b9-2fed-4ff7-3c13-08d59db0c6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:48.1124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index 4856cf83f9e4..d2e3f8b73849 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9758,11 +9758,11 @@ skip_sriov:
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
