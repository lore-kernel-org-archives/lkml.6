Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbeCGLIq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:08:46 -0500
Received: from mail-by2nam01on0060.outbound.protection.outlook.com ([104.47.34.60]:3888
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751050AbeCGLIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:08:45 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com;
From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        peterz@infradead.org, mingo@redhat.com, wcohen@redhat.com,
        john.garry@huawei.com, Will.Deacon@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, Robert.Richter@cavium.com,
        gpkulkarni@gklkml16.com
Subject: [PATCH] perf vendor events arm64: Enable JSON events for ThunderX2 B0
Date: Wed,  7 Mar 2018 16:38:03 +0530
Message-Id: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BMXPR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::20) To SN2PR07MB2574.namprd07.prod.outlook.com
 (2603:10b6:804:7::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8b08873-f877-44e0-3500-08d5841bc9a2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR07MB2574;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2574;3:uejHxYukLO58UbzCDfsX4mDf6A/5NNVyHe9TqLgwPSugHhbblW64iopYX94hoJfmDdZVYA7gn70/u6c102ySO2yMzdsRn59FPkwTgxVtB4XQ5sPWfiU0ETl4s1E8XseDugYdt8UuTA0rX728z0mptmxVxbX/NbGVCh7LDfl6K3chNPVqvb4Wa8Fh7EFMNy7nJOO2wUr9C6nXv0OcMIHpdVdMMvfTgQtCfPFUE98pJr5gUOfNgqffS5MokHw5UEHE;25:daE9Cq1RSSuuFjHoo1eCNoGoz23cehw36TyCDudOGauY8K69DGKWWuCGs/1y/Hd5qJ2s+V/11lHp29yENyksUQX6cuJviYiQPQixza6Nbsai7XUsIDQjFwyW+MGgMlHR6ZnzeKBi3ZJp1Buf/LdYLD3mxjxwMYspgGl+J+vUCa/nQ2bXmZ0JWmBPOE3f1a1bgM2zX6yInPz7ak6XcXJO5l+dM9q+LKzoOpZdY04paYrbo99Q5wG+AyjMEnyHU5BC+QB0YQKPWvp9DeCfSlae/vr+phhzYcGXtYYcMFm8b0XiefkmeurfEJKMcDYK2fQISnRdBt8lknf2tXyyRJBk7Q==;31:fLkElsKsf0bo9gBJV34HMGfFdCQqovCHVfDp/enplnufxxhJpvvZKTO/TPJRRoyqw85hcgw0fAsm5TdCI0ujXuTrO/YAWp83HBFJOEJZxmhkkNOCdGaBya2wGeCEcU9y3N0PMPiIMhxamDAysX03SxKL8pUvTWu2dq/0jE9rpCBrIUIsmAEV5aL+oWQkpY+LFIKqLk/LDlrdiSWRvproEQroSpUTUx3NPENqyY9HBl4=
X-MS-TrafficTypeDiagnostic: SN2PR07MB2574:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2574;20:PD+stViy5pxmZ2hr0mGj+n9GI1lgBSU5gQmptNfpIrZlZZY4JRkEIXiGk4TdG92mP+BG3/RmBaBxk7fxGtA0GJ1VDOrjJ4RqOtfxrO84tJMAT8H1dN/AplTlBGA1QvGQN+mH/F9UAMo5tQUOTbhlWpwx6XENa9Hb+L70n6wu3NplzTd0VLOFvPeuNu1AaHmUb2M0z8L9tGajWCeCuJHoNf9S5+94iAAGb9XJ+/uKceC9IV0vDwC3Idho8G/TI0BfaVhcmuIreq5wFHjdEyRdOslEY2mnqoGthS2wg7xg+LJGqB9Cn9IaYOE38+ImI5I4THDF9ZAJwSzqENmobTGSsCNyEs9iRXpWQudhdqqnI6pAayuZMqSOsKY1GDhD7pERMDGmXNHi1rWxyqI4VggNV1WoZAbQ8UNOpW26duUFz4raRbvenqOwAgsaVLrIsHMnEqIaOMaUwqkKApspVfBNm5gpE/IEL8a19bJPfQbi7qFieN5DnsiYYsTZkUS3+/xi;4:w5AW8DZhtjg1B9aKZPOspnIWfCA4jRZDatgxqagKwWIkEM33D3nhdsRvzIrbkAELaSvLxXYIFmI8wrXWYwADgPIAoUExOz3HE7WoOyS6y8K0sNSz/vRJRSOO6vcr8lGJk/G3XRAJFandaASc33Q1R4TSO49aNZdVRuvi64+LZGDVwmpQ0VjTLk8RRtMWTwbpK8exX9TvV0d3Sfw1G5mBG950T+KoIC+WZI2wZUSU2JAjLDsI/cguQsDMcdcGQEveECJExxdHXkSypp57tk4KXw==
X-Microsoft-Antispam-PRVS: <SN2PR07MB2574934917B9861AED4B30B283D80@SN2PR07MB2574.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041288)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:SN2PR07MB2574;BCL:0;PCL:0;RULEID:;SRVR:SN2PR07MB2574;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39380400002)(39850400004)(199004)(189003)(50226002)(8676002)(81166006)(81156014)(8936002)(105586002)(7696005)(106356001)(51416003)(52116002)(66066001)(16586007)(68736007)(316002)(1076002)(2906002)(6116002)(3846002)(97736004)(25786009)(48376002)(5660300001)(50466002)(86362001)(575784001)(6486002)(5009440100003)(1857600001)(6512007)(7416002)(47776003)(186003)(4326008)(478600001)(16526019)(26005)(305945005)(53936002)(36756003)(7736002)(6666003)(72206003)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR07MB2574;H:mypc.cavium.com.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR07MB2574;23:8tgbm8p+1aq63ci5QRbDxs7TO7/QgZcz5pjGwhV2e?=
 =?us-ascii?Q?XXki/mzsqasFKM/BerFiLhQsIof37zd4dfJLZZme1G0g7PsUOFk7UzYBW5AO?=
 =?us-ascii?Q?5D7n4QcPDExzxxsiQvhzOruP/X6V+FxcThHFB7S5lRzQi6f5P2tt4mhCR3OD?=
 =?us-ascii?Q?C06AnAj+C4ZlXk0+nsgp5eKD5ONixW2T4+8bvgCSgfWjWSkIIB0Q5Tu30Gnu?=
 =?us-ascii?Q?cppguV2pPeOPcfFTRLhRMeAzDFPGrwB3FHYRmbTDn/APGLbnAqHEK3wRhYS4?=
 =?us-ascii?Q?fBYadR0Q5Cm2r0rKPH+iYfcuu3+jjwZx5esjChfdgFqw5+GGZ6yon19mXz0W?=
 =?us-ascii?Q?aT7r2tyZDHYS937fjsRRKU9Vs5hH9FvpMaNKQ7psgills/lU6CYGHwRQtk66?=
 =?us-ascii?Q?a30JVWuTv2BQH+KzaXMlRm2MoiedElXWKpCN1JgK94LBSURHThQK8WHPpLJ7?=
 =?us-ascii?Q?VWEGGxc6hDIZmglDYpy4ZWg5AbK1PDVbVOS8ETdgNhQmpHvd+nWJi4DzMEsT?=
 =?us-ascii?Q?4uvcPEZvzezzdOIf4+SNVD1YL7S4kQg/hckNtFo5WcOjU6z6zd5e4Hq7DaRA?=
 =?us-ascii?Q?KCR0pcSBlkEDRgs5Iyn2xmWrp4+cs+6rsFJMKxLPBkar0M1wkCy13+j7Od3d?=
 =?us-ascii?Q?6/8/tct1OLhsyWPDavDUNO8MRcuRdM/T6fn9GUGY0r/x2t9+I8xDv89SeZpU?=
 =?us-ascii?Q?6I99huN6AV3HkCy4yJx6ytr9dmFYyZxNDD71wOwc801Cnabr9NfTCIRuQTJ+?=
 =?us-ascii?Q?vGZJnANVXYCVrEz5m+ywIWFRk47yc4i3yWgeJ8GJDKCSWqPeuuFrJgm7ftJh?=
 =?us-ascii?Q?+jSJXfJeytHvMiDmQDnmPLXi5LJMXQTEke+w3O1nwKycEe54Svc4ihmONWap?=
 =?us-ascii?Q?r+bnv/HV/U5KAC8+y/unUUrNU5ONeoC82Sd4uL0doa65rswWf/LgR9tLLPJu?=
 =?us-ascii?Q?EG6lwUvFfUmSRHSTYvdH4EESbTQai0X+k0+EHpdHv/ol8cAQY81XmLaxHeVB?=
 =?us-ascii?Q?+bEx4ma3zltAl59/KWGV9gAfpUH1JUr952e1Kuc8Cu3y92PjGfUkg4aEZMlo?=
 =?us-ascii?Q?BwsdzT2uGZDYLJaJau0Uv3xHjI2ZwUGLHd5sJsHK4LIY7kPnZnHiX44yjJ2+?=
 =?us-ascii?Q?NaoVRdRLU9F2bMTHODIZw+sI9GLOEaFLg9vrcd8bqZ5O4tKImBc18ghtsUdx?=
 =?us-ascii?Q?CAhjeZPbJ/dZb0=3D?=
X-Microsoft-Antispam-Message-Info: 274kxODVDIZBR105WQfN0YSKrgc2oJ2gmtO6MxXpzWA1ljuM8fZf5qtSvAh1DtI0P6j4hjGCuDywOLDGEqheGUy/On2Ewkib1BUjq7Nv9rslbHHW9u9bNORWSXiAKfPv2PMwszrHwqRtC6jzutDAfGiMJ4lUyrXZpbYUU8p6Xy9gSQx1WFl+/yzwskmQlO2Y
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2574;6:ATb+IOYq/9BMq7da/qJm2o2ddh2Ro9jQrBpjh55VNJIfic5rNFQXEMUQfeEdqy7WXvPNYoUAnOFXgbG5LfixLoFdge1VtWTti2oxw0Nh3cz9/MoINs6X2frpnbgwJQ8VhY5raWjbx2iL/+t10rDN8XxfsGmG8cK7mgkgoQgp5J2W54/sY9HI6ah5rQrtebKK01kxS4cF2jOYumFED+cKiASMv+HJpWsqHDBce3g47D00YM02IPK6aU20DPhfq5l3SDI2dK+ODlPZ61W3CzjZR9y9nwcZ98rPtmJ1sMZ7m+H9zg2giQbzrY9Cu+BB5BrBFFJ033plNicuYpR4/QAME6dlSnXogDAXe4wx7CODaMc=;5:urhFGLLnQzDrdGQ0cG8n/PSomihVFumaQBOsNcXA0MPGvTwXOQRTbgSMyXPrZLeHCZBH0J1meQ1P1IMRbn5zy14N7Rt65f3h4z9tJLylbTmGUaTbgrb0TyAMiSUcNyXor1D2E50AKipANg0B3qf+DaDVL7GdfFtVBvgLHI6/uwM=;24:Y+zDAftVzljEyx7T30P8p9nob5UrCX3vBYDAjKB8j8UUJV4d2YSI84gosRA4QlIAqBSXZZ35jQF4MJYS5OwDlBtoMnODrkCKV40q/ZDqmbc=;7:2ptk86KXm9axxs8c4ckHvnOHUPVWqsNPPMzzlzbShgFXXaI4ymOs2w9c7jSIApbggKruCdXsi3MvbVLlzketbiFHHu+j+TQ5nnQ/RQ/artjQ8J3k9Oo5UBI19IT7RHbf6OLTxsnuOpoEY57gEp9JMaroPHPfe3VG4asOdiTPhFbBBXVAJMpmTQWtHRP2YvOuoytf82/5RaQWigZUJE8zxdfuFt3O16qFvRy98MKyv9B1qaY9OSiY4TaLrTocKBu6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 11:08:37.9935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b08873-f877-44e0-3500-08d5841bc9a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2574
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is MIDR change on ThunderX2 B0, adding an entry to mapfile
to enable JSON events for B0.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index e61c9ca..93c5d14 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,4 +13,5 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000420f5160,v1,cavium,core
+0x00000000430f0af0,v1,cavium,core
 0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
-- 
2.9.4
