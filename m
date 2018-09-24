Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED54C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED592098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Zb8BI5Y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED592098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbeIXUvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:48 -0400
Received: from mail-eopbgr710090.outbound.protection.outlook.com ([40.107.71.90]:26752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733232AbeIXUvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpZYPCwHvAC8faTCdiAQ8l3fJv/zN6CbZbZ647gkYMU=;
 b=Zb8BI5Y/YltVih70J5foGeLZcjVd7FN3dRbjlJKwhCiWgtUKMjiuN9FDD7D1xBjC/fpd4KRPBFu3YlTagMdBgldeNPNYKk8V+t7x5ow0OeFVRKS0jGMl+lX61NBoUF+WqH2h413AwSgJpgP2oVhUhhU3aNeZVCJtI18xbFi1O0s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 49/76] ibmvnic: Include missing return code
 checks in reset function
Thread-Topic: [PATCH AUTOSEL 4.18 49/76] ibmvnic: Include missing return code
 checks in reset function
Thread-Index: AQHUVBWp0ex+DO1qz0aHz3C4Dk10vQ==
Date:   Mon, 24 Sep 2018 14:48:31 +0000
Message-ID: <20180924144751.164410-48-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:mArySbdySiH6gf11bV9R0w7q+KyyTZS/KQpyvGCTNY5vgzXYGcIZ5Axs4VKgc6NTKjP7eiTB4yYZWHP5NI6SmBK8V0dKmjgh9waUQUEIhAKTq04JcEMd7eOhk7trBU2M5DO9prs3RgJG8kR7bxmp1Hy4YS3xF0Nf+GvJXEH0TJH1bcKzo/Yz+jmjm8Hhm81XY1JeEcfrrAiIT2Cg77nhOqNfvjBjELP06WqGB1L5I6EfjPX48W2fxsjj30UyZ6Ze0ffZAdcIDZtbpsOmICmC/zALmpFkIB8eTYGb5JEwmtjXJP07zjXqs9O34eV2KYSOsHm9ypo34hPOsfZiVwtjUz6hNKuPkOK/1EQr67S0Vgtv+Xins+cKi/UrcTbKiS9sqa3PyvlUtThISxXthrJqZZNSDfAhYvyywPoFX/fRZri8pkEKYjihcQF8qgIhOAZDRqbax5837LF2Q0lFrbVvsA==;5:Pnx3R7gvzUkcF5TRDWQ7RF1hEVBSZNrS0NzFus+nDZB3/998WC21q3pj1UwEH8V2P/fKL3gp5ZPzgxCbva0zkISoGmkNbwJMcKaGhEpKa0Sjhse1H2jWnIUS1RD+NfAQfBcX1AGc5OHFdYC1KOPAAP+bR2N76SjyddWXdXZ1jwg=;7:/8kzUo12LarTMVmx7ccPxBUqrB0PKZvU8CG+sKVuliJsNUwxWYhIqQqq6av95SNJWPEwZrsLqm9Tr8XvHkUOfg/Hv2r69me92/WfDwPQ0ooHFLW+uMvYuvtIn7CAuwiubcQI/1YfbQ1Hxzq3XL0jK8yWO0HSkcfhZgrWHvoexZoSbtLcBVn5ANH3vBXQmfBsfE9QJf5h47fljyWh+2zuKNHYi+4b1dUQW8wrSIjyucbt1br0tPz80l0qrZZbNZVA
x-ms-office365-filtering-correlation-id: dff7af2a-480d-4353-1c96-08d6222cdbd6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855619FF2B63A6DD2A6B365FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(575784001)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f3LveGRDkUmTvIkbRPKcinq3X3Nu7daji3SbLqKFURvFsbCIhdGiurQkZ77avtkkdxmFzxtU5PTRbQD7xnO1b6LCNxkSFTNX+qM6jkJ4c1QG3s6JnaG5ykxEoMcd/vRBWUNy4bWUVZlDGWT5hkF0XCk84+cnqWxinCVJsNO20tKIHVbZK9st9/6TaINARM3bpP3hk49XT86gIBHFWDRox6dHOsqpJ3HR9xWji3MFa4S2RrHVzyLnr7vH37DSDZB5T2fNeNxYCGTfdp1RTNn10eGN1bZmAOYpapmuVH9jEnZSVPkls2RAHxWgGN+UF6nqhsdVPZ41/wpnLSor2gNs2EzbwYbStWIBh+0r5h/D2qE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff7af2a-480d-4353-1c96-08d6222cdbd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:31.7113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

[ Upstream commit f611a5b4a51fa36a0aa792be474f5d6aacaef7e3 ]

Check the return codes of these functions and halt reset
in case of failure. The driver will remain in a dormant state
until the next reset event, when device initialization will be
re-attempted.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/=
ibmvnic.c
index ffe7acbeaa22..d834308adf95 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1841,11 +1841,17 @@ static int do_reset(struct ibmvnic_adapter *adapter=
,
 			adapter->map_id =3D 1;
 			release_rx_pools(adapter);
 			release_tx_pools(adapter);
-			init_rx_pools(netdev);
-			init_tx_pools(netdev);
+			rc =3D init_rx_pools(netdev);
+			if (rc)
+				return rc;
+			rc =3D init_tx_pools(netdev);
+			if (rc)
+				return rc;
=20
 			release_napi(adapter);
-			init_napi(adapter);
+			rc =3D init_napi(adapter);
+			if (rc)
+				return rc;
 		} else {
 			rc =3D reset_tx_pools(adapter);
 			if (rc)
--=20
2.17.1
