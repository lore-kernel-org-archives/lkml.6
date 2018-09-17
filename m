Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF440ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C1F208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="afxL27A5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C1F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbeIQIpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:45:05 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:18657
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730471AbeIQIaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qNOokqUci/j/79yVXEmRVh6vJV9VvtNtb6oBehBEis=;
 b=afxL27A5mdpc1KV6O+/CMH24osuE5ehE2FZu2n7y4DADGZTumZobz09Y/BODiWpdaYL06JgKubSPmPNwkGuRDMgNHosLnKSH62v7PLdZNFxvvpJLKbbRKBgfUZty9Y9bEUuPlz8l2Gqrpk8Dww+SZUo9R1WO07udkdu0gV4Zo/4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 76/87] scsi: megaraid_sas: Update controller info
 during resume
Thread-Topic: [PATCH AUTOSEL 4.14 76/87] scsi: megaraid_sas: Update controller
 info during resume
Thread-Index: AQHUTjL49CBNghd+60uEtSAgL36Prw==
Date:   Mon, 17 Sep 2018 03:03:13 +0000
Message-ID: <20180917030220.245686-76-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:+IBTS/NWo+GwqUrJCUnbypcyO0OJ07E/TAW3E7y3ZHpeSyvo1IOONJKtkqGnTjIiVdeyNic2y2ikrWLf2ZxUDH8ZgGnpKyjct5wrfWVELo/G0ZHRtM8k0IkXvXmZ1kKMjq4vlHu6C2uh2lFQPwt5l6ecwZh1ilYRTXdYGbw88PkgVy4NPfBqWaAjNUZxPHJ1KM1uHa/CH1V1simXxQbggcSdUKwclY1qEQl6IX1rWwDfud/JPeSo3XqnRxexYSX5XVNZ58+Hf0ejydekL2oHHDa/7Dd1gLG4kPhuN9c9ztZ5P7LSIouMDXJwtzD3D1VZZTdeQd0QNe/zVnO8kBE+DtcAUxm6WrTMEuG1+w4A/Qao7Os08qfBA1dZU/pbjAs5eqhcO/SGOKCgfXTEObDDibW5XO9Vleqx/Zxq4MsbVeXjXKUI5wU16MXfeq9hs3yvZhYOggakj+LHOlf3Gyvj/g==;5:CNKvAEGN13rtpxYJldSWr+1uA0XO9uc+DjYdmXCJeGOCebdHrTQMuTKZWoAOK6bXUhcyYjflkeytweL/jgk/tWUTz97wd4PjobWwKgFDSBxoo2ED1ekGnX95i74cuR3EtobD06zukeBek9OLKtcuWQW2TcrfCh8wQDjDOMgLf1g=;7:GnetrvtPKqwJWi0vwSdlankrbFMgbGgmUCHIK8jXsPvJuTXo8j4lVjc3wqtZzR7ZqkV9bL3C72FR0/qsEQQPEbAUAIUsLryTd+cLuqqlP2NqwjvpqrhJJ97hIzXS/9uyhVv346az6pEAAK7vaYyD68ZYdHIiwiAbWAAnjwx0OJldNqTxaPNO+Faj7T4ZGm2GSdUjKAMeY8qDhu6VOPxRZGGoBvWqD/VStuuM6qhiTmo27nswLcf0hj8NumijbIGQ
x-ms-office365-filtering-correlation-id: 0a34c6bb-7ed8-43b9-c1fd-08d61c4a5ba0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB013356F7D62BDF28B1A6EF32FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(15650500001)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(14444005)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nFIW7RWMJwjNqdcWXCfYZ4rMGLAAyi43+H+xxkOUiPDOnBiQS2aVlz86k4NVjMNVI8BTUgWYOEJjYwr7tNFpGf5zaAdnFDFPslPQVU0S3WKytLL03x1ZP/8lLy7tDSrvQAWtT3ZXmYHzzynGD0DeHY1DH3jleFG2TRUL/cgumLcE6Nxc21MLNzDRwSsGSq7ArW9b6+B2O/2kwslaN1k/L0nXvynXe6n1eVgbv2WYkTf3t6/PoDi5s3NskbUlxjmE+c9StjZBEc4dG3SRwfqXHTiD26Y8vWO7v68FJ8yujkeWml4tAWegpNZX4uY07zHJKyTsYbaC17uwC9nQZIC/kUxpevpx8f94PGEllmVZlrE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a34c6bb-7ed8-43b9-c1fd-08d61c4a5ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:13.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

[ Upstream commit c3b10a55abc943a526aaecd7e860b15671beb906 ]

There is a possibility that firmware on the controller was upgraded before
system was suspended. During resume, driver needs to read updated
controller properties.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megar=
aid/megaraid_sas_base.c
index 985378e4bb6f..d55c365be238 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6597,6 +6597,9 @@ megasas_resume(struct pci_dev *pdev)
 			goto fail_init_mfi;
 	}
=20
+	if (megasas_get_ctrl_info(instance) !=3D DCMD_SUCCESS)
+		goto fail_init_mfi;
+
 	tasklet_init(&instance->isr_tasklet, instance->instancet->tasklet,
 		     (unsigned long)instance);
=20
--=20
2.17.1
