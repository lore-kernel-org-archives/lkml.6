Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934318AbeCEKkE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:40:04 -0500
Received: from mail-sn1nam01on0061.outbound.protection.outlook.com ([104.47.32.61]:18512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933405AbeCEKj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:39:59 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-crypto@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: doc - clarify hash callbacks state machine
Date: Mon, 5 Mar 2018 12:39:45 +0200
Message-ID: <20180305103945.3517-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131647199970549141;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(39380400002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(97736004)(6306002)(68736007)(5820100001)(26005)(59450400001)(110136005)(77096007)(106466001)(53936002)(54906003)(2906002)(6666003)(2870700001)(1857600001)(50226002)(104016004)(316002)(36756003)(23676004)(85426001)(305945005)(356003)(5660300001)(8676002)(50466002)(450100002)(966005)(336012)(86362001)(498600001)(4326008)(26826003)(105606002)(47776003)(81156014)(1076002)(8936002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0301MB1188;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD025;1:FkW/dONTFMmCeUvRpOdmlja6Nz2QK7Jn3tF+sPdQLtcvItrsAcy6LgXc5MRSMqPLS9qTHGlGIu4dvZ1lIMY9JrMJNswWiyAVpb5zFBOQtFXA/u6OtxrL+2AbrJS8TGWK
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a8ca409-a649-4249-fc3a-08d58285705f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BN3PR0301MB1188;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1188;3:/rY6Y/I1tpeJMWfuOHaaxr2ePoQRevSzkDmRPT72X9ArqghBqZFVpDlrBE60bDqqZtMsqrTJDdPgRK4xkbjwFVIEUtHvkx8xu3hzPwZr83vZhIel/vhogiCBA505G4jO/B44yqtOoCO0FROgNJkoBv8I6ywIo7kvHatEvef7Zsb/XhsSWP/C6jSkI3fTNSaY7Gcko70smTWRp4mUhRrkPELn/y1WJSrOZpm+vH1H5HcTHsWHkCIP8YM5MzNoLf/hzOfZwCIXRPe1LB8/d+Qv2GZRzW4hU48klzjVJrZVKqL7BLH0NbJBEZw4qkL2iTR8zRQTdv1xsU9kOmy4ST9qIoD/f75g5u2HDniRW2hx0NM=;25:jpEcLEDW1YonCxmr5KTEsd9e8Vp6zN/FpecBLruzDVKO4qWErUcGVuhFyx6FlqlRZciYoUc6BimEPrICRHPvAg1ukO9m/D1tEDkRYUygil8Q2vSRCjj2TLGU+oLkLhj8cwYoSbVeG96w+vNz+0rZFmyWW1efHRvQ+18om0vrv9Bo9jfHa8EqjPCdNS15YQpDKQ01k+uZmEcu50V5FTNVZ/48RmR5AUow38n3doaVd47L11Hknfol0hZG4ezQjpPxf20cm4WGjRvsXh+xz3RRiXXfo+em73hpoWgcDn71Ppc5pQPDQ3Bj37h8Tt/OCqECxlmRBHSncv067aCVY2+Y8g==
X-MS-TrafficTypeDiagnostic: BN3PR0301MB1188:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1188;31:IiGvUc31O22MiXf9RlxHh7q22LlgDtegC2Y+j4CJLLCp3hUXfsN8asmkBo+XJkq7wjGb0WgFDRmzxNDlrhGQPqhbIfhLvmQfqWge1MvjyLqdPcEJmstGAA+7c3Yi5f7HtUBqvvjZ1kyq58objrPpF9ZcF8ZuWZu7OKQLiwQR5iXsMmAN6rCj8YDzxXi9/6EOPWldTMVZNw71uwJm8yoYg3OXUGjYc7VNCHtFacB5qHU=;4:lf6SDbNsIfSiFCxnDvNRPG3WXIfKPVzvJos/hobEtPJwoml5tv+JuJ/RIm6adC0wyfnuXB96Pxc8ulapmAv15XoP3iBZzg0vAArHjqNkriLn1cUwncC1ockGc7Jw3Xh/G8h0Jo3/CETdNUX2PNX5+wPRzJbTzkoI+PdrZ2uq+A0UBKb6WYJha/3RRaBPkafxZAxC3y19uHZ/NJSX2Otrn+LJOUBUj3Q7TOAXZ3phA24qM2YyqToqf+7bhN1r2gIJ36GPpA+EQNaf+DC+TATPrcLyczvjLk/AdLuEqEHW2EVql5gSfhifCTKfw97MoVgPthuzYLHU22QIzJrBLd/i/3z+MrqNaZnjoy0zqzoc9Y0=
X-Microsoft-Antispam-PRVS: <BN3PR0301MB1188D740A652A8A7062E789998DA0@BN3PR0301MB1188.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(6055026)(6096035)(20161123563025)(20161123556025)(20161123565025)(20161123561025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BN3PR0301MB1188;BCL:0;PCL:0;RULEID:(400006);SRVR:BN3PR0301MB1188;
X-Forefront-PRVS: 06022AA85F
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjAzMDFNQjExODg7MjM6aEQ4Ympob3N0QXRkNDdjOW5Ib1pIcm1h?=
 =?utf-8?B?MmhuVXZGVVBuWEU3NGpzMUcrYmRFbzVwalJtTkhIeXQ1dmR3b0tDeUpqS0s2?=
 =?utf-8?B?bWlIcUJ1bU82OXRqVkNXTFh6djFFRysvR1NCYzVySnNFQzJFYUVoZWNRUEs2?=
 =?utf-8?B?N21pYU8vSG1PQzdaem1yYXo0QW5tb2hDNHg1eGdiUGdlZFQrRUdxU2E5Ym1r?=
 =?utf-8?B?d1QvU0NwcDZlY0xEM0tJTjY2VUZsNE9zWEIwTTVBcVhWRzlReFB0TzF1L1hN?=
 =?utf-8?B?TmVpZUg2N3BUZU9QSS9JcHVyQTB4VkEvR01JY2s5RHVmY001TXpDL3RWZWVN?=
 =?utf-8?B?cFpzb3A4TzJrL0UxT2pUaVVkdDJpTlNPbzVFeGYyOERWQjB1ZTNnTjJJWXMv?=
 =?utf-8?B?alRVLzdDM3NSREJHMCtrclEwdjZ1ZkJlYkJlRmllQmNUWXdGQVVKYWVidGxy?=
 =?utf-8?B?SVZQUWpMWXRlU3hDLzF0NzZSV0diOTVDNVVnRHRSQ0tIQVBDT3UwcDRzSVhS?=
 =?utf-8?B?VUxNVkREazRyQjNsTEZrQlRob0NaV015S1J4Tk0vZTI0UU5VaG12UnIxMW4z?=
 =?utf-8?B?ZmlqL0dlbjJkYWx1VmlPRyt5S0Ftb01UOUZzeFhESlFma1JJdDlNYWQxZmNj?=
 =?utf-8?B?RHFvNGNFL0pXeVQ4Z3pLY0kra2I0RzVzanJ6Vms4UCsyZlhaWE1xbjNkcjNZ?=
 =?utf-8?B?Q3oxQ1lOaVlkKzRGMGswRnBicTNZblduYWExUEZ4SkVURHVVMm9KRkxCZkFF?=
 =?utf-8?B?VDJMc0ZUN2Z5azFna0ptSllPc2pxT3piTm9lTXI1WVRTMENqZGJMdUhFQTBt?=
 =?utf-8?B?VVdHbzFPOXBXT3RHandwaEhuQXp6MlluYWVFYXhxNXE3dDhyaXZPVTYwNFda?=
 =?utf-8?B?QzZvM3pPaHk3Qm1ITlZ3d1VCSllFbTZ6Z0lVeHo2VnpGM2ZKOG54WlhrSzZX?=
 =?utf-8?B?aTBnTUt4cnBCS1BHWVd6bjB5bHRJNFZXclpuQ3c1elBrY1RxT3orSkppRGVN?=
 =?utf-8?B?T21xamtDcm5ZZ1hEL2M4OXREbUdIbklHS2lvb1o2RVd6c0R6WW4yeVVnYkJL?=
 =?utf-8?B?WkVkRVZHd3Y0eEEreDVzb3N6VkJWZjJmNGNPV2hZTHlwRHl4Nlh0bFh6NDAv?=
 =?utf-8?B?UlF5OVJ3RStVcm1mT3FhUkVLY1B1d2Z1bTQyaCsrb2pMMVRkSTBxVGR2MEZo?=
 =?utf-8?B?dUN0Mkswc01tbWlRa0E5Ykdoak5vMWxUR0llYWU3ak9EMVJsYkEwcmlNNUhB?=
 =?utf-8?B?dXFQWHdVamE0RXRobFBla3NFclM5eFlQckVqSU03UU5CaG1lNm1BVDF0b2pP?=
 =?utf-8?B?S0VoRUxjTStJVTFPRFdBZHRWSTY0UDFmZEpKSlBDTVJqRzRlVkVHanZhSG4r?=
 =?utf-8?B?Tk1hWHU4TE5DSlBhVHMvejcwL3RZNEhhRm95QjdsSzhyZXZ1TWtpSFltQTBO?=
 =?utf-8?B?QURrYlJtaVptQnQyR1p0WlhNZHRiTjZpbW0xQTE3eXNRK2hmR1d0RTBPK1RE?=
 =?utf-8?B?N3JxNnpFRjRqUEM1cUJrUk4xOERRcHgzM2NiekhRcjFFU0hEWVBnM1ZKbW9S?=
 =?utf-8?B?S3NacFgxUGhUSFR0VmFMNktnclNMUWpSa1gvOElVTkt5VnFSQlVldCt5MXB3?=
 =?utf-8?Q?Y=3D?=
X-Microsoft-Antispam-Message-Info: qvd0tXxtYtY0EupZoMzV0YWa1kM9oW66OSAPzVbb11tE3vgFrLliAl2qhMlun7djBes2UekiFPS1dAJRMgSj94SjSkloBK/a4azN2uYmT8v9IFsttjLMhOw/3ERvKgMOmijE9/KjsM2PAZnD3FjWqHNiaCoODxyoYYzKSlfyWZHF+aWTGb4n3j+xn2p57gGm
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1188;6:VLtOgnG+JiDU4abgwrKCulK01G1wCDAEKPmx3me9HVgFcehK9qWhqw1+mj+bKnfmnhpI5PZ8h04fLSLqpPAmiXd9L/kYBCZy5ow2CkERZGKBqZykRHQo3SH4Im3CKIe8I226eQilCyGGte+JfCLwuEp9NiJNCUAjvoY2vOGwOjdGSw4E9tHrN0bfSRwGLmLBt7uIdYaYOSTpY+XyEyVs6RkGWPGTGNgUb/fO1KvSP7KzHPSBqEG7FzVSTWge3xWy6kkL50CNY02dAua0tdw0oBMjp6gUlE7aZmyeCtZC39fdSiKQ2LNTJaeoleNm8IHEUDVasqkJcz0f2PiUHAhsOIw5zNhOckFDSJAhRjC0IFs=;5:uEDW5qFSf4BZVhlUH71SwTAqdY69j0mQCO0oKYO1ziDuELKMhlJJmTuI14dup8YNMrpPA+BG8JqhRwBQmBgYtM2/ro4TGQaf/Oio+7SEQd5tpsfVXcjt/kkczTYVYZlKsMPn+oU20DjIbLK5UFjkC++nkeB9VEiZqvNTnthZnuM=;24:6GJwH0f4Pu11SoU4bVqJLm5x3hwBbCkBDKI1Zlg2jt3dOqmRfpw8kt5MedQfoXLAtn9i5pSUAS55AGBDYpLKIUNZLe65xA+sJCI6MqxfW/s=;7:7+15n5WD7f27UZy8qw4g2Hy2PaIHB7CiByrq4aGFbPHxdoMIuea8TfZv/EcheRtl/5X/RgwSWcQgFj0UmNtATErjx+Tl7utf+uJndXq8emfwpsTViHsmsmBlqAtIRyk845/6aymuh8yzqca0Yy2wIpaf0dizsfMIPJFRDhCOLv2X7ToOT1AJHWvnJUkHOQF3Byc5mvsGTy4Db37+QXJ5kWn/ZMWoq186wpSgHbnZ+/1XNIXHKAWX3Ck2XjCx1WTy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 10:39:56.8677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8ca409-a649-4249-fc3a-08d58285705f
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0301MB1188
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though it doesn't make too much sense, it is perfectly legal to:
- call .init() and then (as many times) .update()
- subseqently _not_ call any of .final(), .finup() or .export()

Update documentation since this is an important issue to consider
from resource management perspective.

Link: https://lkml.kernel.org/r/20180222114741.GA27631@gondor.apana.org.au
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 Documentation/crypto/devel-algos.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/crypto/devel-algos.rst b/Documentation/crypto/devel-algos.rst
index 66f50d32dcec..0f4617019227 100644
--- a/Documentation/crypto/devel-algos.rst
+++ b/Documentation/crypto/devel-algos.rst
@@ -236,6 +236,14 @@ when used from another part of the kernel.
                                |
                                '---------------> HASH2
 
+Note that it is perfectly legal to:
+- call .init() and then (as many times) .update()
+- subseqently _not_ call any of .final(), .finup() or .export()
+
+In other words mind the resource allocation and clean-up,
+since this basically means no resources can remain allocated
+after a call to .init() or .update().
+
 
 Specifics Of Asynchronous HASH Transformation
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.16.2
