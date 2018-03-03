Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsnn2TQxYSK+ccN66pXpfhPI9Dzimm4XMdBOZv+3E53F8KGnSfUZDeEMsf1C/vmunCPmFmf
ARC-Seal: i=1; a=rsa-sha256; t=1520116798; cv=none;
        d=google.com; s=arc-20160816;
        b=SbR1QS+jV0M4y7/eBhIhnMalqkTcYNmPzcRN4B8DvV3DpF7sr2Jwh5vIIlKKwaN0zF
         HKaVnLYnrf+jFu22QP0zY+LxQ23OC+X6T5Gg7IWnRHTh4Kx31HGREc4YTP8TQHZ44KMM
         pFw3tTZsFemrZR4kMR2jqpRwkbqo+oMsu70hF3e3h5ByN7hUVWKor9XckK0nntlPYNam
         dv7hC8msYdaj/CMCqzMcThriefKS77+NQrbiGCXL3jhlsGh19BGlKTLuiuruNkZIQelh
         vzyZ5xrVEi0QeYhwbaI6nD5aVGJUs5tLZD6QShKOiVaJvMA+U/FmfATDcf7fmybGym8G
         se4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=YkkXPJLpF49PeU2iHXDcOBLMUe0POoSbxa3BNLtwgzc=;
        b=XcFPs+aaqjzzrXaItZP9Pw/AokEYMkrUHskq1uwpgcQNjXJ4hXpmhCN4EP14qXiuPB
         d4CSfJtlO0juArq8i+ynlzD43sxUoE7mN1FaAOVypECTlp48xE7LFIrsfiZevSrTEPPs
         ok5dBHNupr4V2yMp+xncv+iFUNA/7B7hSdq+sAdvQESkGl1AUqEKeqLKAKdQQfJ1AnTB
         AnVYnregN7XykZHRgionbtUQHN+bkTh0Et9m1/TcqbwuymAuqe0BKgjViE8xPTCV25OG
         2gEse4p9h7uwhkjQPRpVyABK1vUmbQXXkU4SvNCKbY/Fhn79QNiCkC++PEvsMyM37eRq
         jPQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=j+aaIPB/;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.127 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=j+aaIPB/;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.127 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mike Leach <mike.leach@linaro.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 066/115] coresight: Fixes coresight DT parse
 to get correct output port ID.
Thread-Topic: [PATCH AUTOSEL for 4.4 066/115] coresight: Fixes coresight DT
 parse to get correct output port ID.
Thread-Index: AQHTsz9erMSu5g1a8UGB/UNXDTlQLg==
Date: Sat, 3 Mar 2018 22:31:27 +0000
Message-ID: <20180303223010.27106-66-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:cGrCP8uEcGJpkpdnRnT13/KxHfWJIwicW4E64uyGSPYBq8pKQZRu72tdxRZC9kuRTE+/2m88sYTJuubX+1pCuGAO5x4xDkcGfNwKvDhziFr5bc/bztrMQg0HXwvm+CrQw48z4se8cQJSJhRW2eGyK7KXsxOCRIdf33a46gcQvmMy8PaTqTOaMrNE2LmfdPxBFuu8VDQqZPaOKuNkOcvEbgA7XNACEUTLuHaATQN5/QZZDl4TdVNFd2JoOi23Ey/4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 944ff5ef-efb0-4622-d320-08d58157af64
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10333F4108207D21F97272C3FBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6512007)(6436002)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: CSIIYk1VwLiquF3KeexvKyhV9f16UtZGfBREnaOk/4T1uX3T0F92otfyC6VQC3J3OSSLs4nFmnH7Hd8lH2i03mtNTylvZZRpvrbrZYnh3janpfNVVr8IC/Zfj0Hd9dplI1lZ+h83g0QhWLZpyQQ6EGhqCN9klxG2C7EOeenhVUg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944ff5ef-efb0-4622-d320-08d58157af64
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:27.2447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957681084226533?=
X-GMAIL-MSGID: =?utf-8?q?1593957991888266761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mike Leach <mike.leach@linaro.org>

[ Upstream commit eeedc5421dd3b51de73e6106405c5c77f920f281 ]

Corrected to get the port numbering to allow programmable replicator driver
to operate correctly.

By convention, CoreSight devices number ports, not endpoints in
the .dts files:-

port {
     reg<N>
     endpoint {
     }
}

Existing code read endpoint number - always 0x0, rather than the correct
port number.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing=
/coresight/of_coresight.c
index b0973617826f..7d2bb1549608 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -150,7 +150,7 @@ struct coresight_platform_data *of_get_coresight_platfo=
rm_data(
 				continue;
=20
 			/* The local out port number */
-			pdata->outports[i] =3D endpoint.id;
+			pdata->outports[i] =3D endpoint.port;
=20
 			/*
 			 * Get a handle on the remote port and parent
--=20
2.14.1
