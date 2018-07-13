Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736F0ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15478208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="bcckn5at"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15478208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeGMJdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:33:40 -0400
Received: from mail-by2nam01on0086.outbound.protection.outlook.com ([104.47.34.86]:4416
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbeGMJdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X3cUfvSngwTGXXltAjCxfzHyLmQZHB1DMkODyVl0aA=;
 b=bcckn5at2iwnVs7LBmJqq1kkA+cBKR7UhcT9XJoKtO4RLIHuQGjq7dbbRR7jl9FO78n4Jy9JNzEgqPF631ZOyAfQkIsD8HE5RfT5TmrFvQDXZHvEd3gvIKPdztz4TyLpdOUfH4tGZf1bXbJwGPu8WDirkbyRL7VMCB5YKvDRE98=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2630.namprd03.prod.outlook.com (2603:10b6:903:75::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Fri, 13 Jul 2018 09:19:35 +0000
Date:   Fri, 13 Jul 2018 17:17:12 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 0/3] arm64: dts: add Synaptics AS370 SoC support
Message-ID: <20180713171712.05f58a74@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: PR0P264CA0002.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::14)
 To CY4PR03MB2630.namprd03.prod.outlook.com (2603:10b6:903:75::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec073470-4480-490f-d25a-08d5e8a1c706
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2630;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;3:gyGI28QEgqzU+cHEu3tgqi6OAhz7/wfwmkO/Y3sJbBO2UliY/2VOjoyaz9ERvuQd0L905DMbFkcaCFm6BrrTFBYSVDw0quXNJ05Phx3nI1qjleqfKicd1D/h+BrIGNUmAdMOCruUo46KuMEcdWyLOWXEzCbkbqLPL/4SwStbQ8IAbjhqgmJIxV9JqHzN3HEkw2YVU3yeLmWfHq/SSeQgJ8ZMD9a1TmR5s5ej1va0XT939CjOPVfF8TZtixaVGeum;25:zW1MbtT5qQR5pDkdoIo5XoPam/1pK7qW/3J8NaOp/y39SPV0diTGkLW9zBrJZzQm7PCzvnZVPuRj7gETZTHApdICvoqRSHMvjeiOXygl6sdO4w9AXCV/o5EsLePDRShwxX0F0ulkbRI0srMSjEfnv06t4Of2FP8VQ0g9uP7U6wLz2Hl1HiYcFBWmrg4ADSUm8L+U5p3Qx7z93sCl3O3IFJi2zwS72Ew/E6JCx4b67J2lfu+kbiO9X6A7ZM4DaaxtNTRwRVfXarYrm3lF5x6pC5msjoOoshiUmVwYGXvuyVGTlpDo6WEszsIxsL4o67IabLNwxIPWybVxwVzFxSE0Lw==;31:FmT/j5PViLuP4qhnN/OuYul9UFI7q0dtheuuu/M1/eJv4ADvq2cDTUw3jt3RmMGSQ39N5//C5C2dPgzc9Pl1Lx7R7VIR8tz9Kl+yxiBoOxCRCiszN4X5iAS37RIHAProyO9PzTNyNNPKxzva5fMDsiy4ZZTsqPqeZLnOZD0MT6LhH5JcGY3/6/j/SITi/YFGXB89gjOp0llWm8wPI97hc9f8gV4EPfK7jI8PAZWnz4Q=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2630:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;20:QLI6u+uiavWzLUp3bEhyFcAGHunmurVCS6pjcxIT+ROl+iJIVqF8oaTOCtPRSTkK+mXCnMOp0Yy1iei6mm9JmxizJJGzctW3h641YtXC1CRoSK6TxB8mIFKSPKvBg3UV8XlpjJ+AvLR8CzZS+RCOATMkRENefiARSqZ1FkS/mVKRvYJ8G3JCxgC58jOc1UAb0W17apprhRFDPnz5DqaEnxX8LCFg6PMN00mnMMAkajt11cOdIq9U88rFAyy03F4xqLuFNz+Pm/MVc0z+T8Ehy26bv70H+4zwygByc3JwAScLseehS0jCHIDcnyUcPVSP4T0jIZzfOjj0mlf1iBY9VHivAoBzRlmSdj6venSS4iIyI1rWA5gZohviIO5LU1ZkuTpr5TcEtbaHwJVRmhnlDW7mhKvbf6f+OgLThFl9sxnMc4WTKW9ITpM39a+1r0ZQa5YQhdaZ1nWgVDby0euMB8s+1TL9naPrOj6Ay8G527AN8JVM1DiVXOczMKZC2bHG;4:FbIx38NTdYYCeGn5iU93uyWWuivdv3hiYGDxQoVjtT3L6TiKeQ+2Znd+HS8qNguSHQjow6k6H115u/X1iFOF2Pz/A9bzwVtLQds7Pv3viuikODsxqbnmZO3Rvz83FdzOkOHUobXjnrdUvNffl4Uk86ebc9gY1RJmsvHyOzWKcRqnZ/DDXpEf0v4ePlCtpR1mGkJY27S5u5+E4RvY4RHxj36pf3H+ON2vm5QqGU80HhQy2Kl+J4HjokSZHCXRF/JoFDcSaW9MxVYaOHLYpA1AlA==
X-Microsoft-Antispam-PRVS: <CY4PR03MB2630CEBFAC8B098621ADFC78ED580@CY4PR03MB2630.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2630;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2630;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(189003)(50226002)(476003)(81156014)(956004)(23726003)(6116002)(8936002)(2906002)(1076002)(68736007)(81166006)(3846002)(14444005)(9686003)(8676002)(478600001)(305945005)(6666003)(7736002)(486006)(55016002)(72206003)(66066001)(5660300001)(25786009)(47776003)(26005)(105586002)(52116002)(53936002)(86362001)(33896004)(4326008)(6506007)(386003)(230700001)(186003)(7696005)(106356001)(16526019)(39060400002)(50466002)(110136005)(316002)(97736004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2630;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2630;23:m99YOZTfmuQkZjLtYj1wfmmDedjS0Q5tA4yiLN69o?=
 =?us-ascii?Q?Ta/0lv34nYSlu1UmLacb4NY+EqfR5UUz5fx+KMcrGBciNpBJzcLmUe0fpD5B?=
 =?us-ascii?Q?d5ohIYTlXzrzkR4ivhrHjmL7245I0xfQsYnp3sAGmPqEyf4X/WuPpj6jT6Pb?=
 =?us-ascii?Q?ZOKduhNwCwxIP77VdCVb6JSczRyw2vuYKruM7O0iiasP0GbYD845b/z7IWGa?=
 =?us-ascii?Q?h6F4RfTwq+Cc0lMQew0A91JT40QZw3DXpoDr7mElBq7O7mYkosG4fDkeuhpO?=
 =?us-ascii?Q?Uy32WIGEzK79qYwnp7R2SSujw4UX/kMMQ9yVm1gWaqHrZhTHfurbYjQ+iTUf?=
 =?us-ascii?Q?zoReMFCo+5bh2c/FOJ2w0i76iqkzTKMwlvS7xev1ZOSOi5zoaj0LkrJ5RV8E?=
 =?us-ascii?Q?JzcUTztY6FkwQdbcZ7WGPcCEhmiaOSIPpiUXt5UsNXRbbPxX6JWjFABEBCvi?=
 =?us-ascii?Q?Zwfm4qeA+Ku2+Mw55MBGztqDUofmndZJQQdNemaW8aP1WRu1mYadFGphcJ/a?=
 =?us-ascii?Q?N69lxT4IleCb/GF6Ns6X9EEkuDMpLgJl4XnFJTWjltC3gms/70Gofe5ZqJqJ?=
 =?us-ascii?Q?td3Vu91OvkbHKGsbNMkji2JPtStmq9FYDtjK7xefoolA+CezdnVgS6smjL7A?=
 =?us-ascii?Q?44p1uTXZXQ7us6XX7ay52KUKsLwgxOBEFj/nmxUPnJdyPbxMXOwSVQVBapfB?=
 =?us-ascii?Q?h5BI/AfS/31/988MwL2iD++5b+EN6dD7Ndkco+Tfw1aS019WJnYuXOYjJcOy?=
 =?us-ascii?Q?hCbU7MhsHGW4SmCguWK1b5+NGD1rtiZ+M7OEUebPY8UKnCSrA/yVz5vno3xj?=
 =?us-ascii?Q?0YQnzk3LMTjyf3C8DJaXj118UFKq02aT4eAkZlZjl+GnvaKBdf3Ye+9wIF1Y?=
 =?us-ascii?Q?kGtxUuZ/aZdMdcnfLOM77AhdxNJ5pq4lMVibBqdJ3s26X5WO7P3Xox4myKV9?=
 =?us-ascii?Q?Bnl9T+8yBID68KOhb2znzQUj0TI4Nl7VYLOzGscfEONV/T/QzgVWe6nWiKuy?=
 =?us-ascii?Q?glm6Mxsc26N8aIdSVtXnNT2XOiGF9WtD7bAmkqvd20krSNpDjP2cFtRcPFdR?=
 =?us-ascii?Q?94ZvSgzd93O2HFatjl/pQT8iOsNLquEugMy25Ip0YUaZGoGc1Nej7nOC9KjL?=
 =?us-ascii?Q?mmjMaBqAxqhXzHJ63/L7WmWXR5oQz78YQy1DEj97zk+Ip70XAMpco/LxjWOr?=
 =?us-ascii?Q?6tsjVIr3q+4nXgrrHW2/ZFNIpcPbTqGOO+S?=
X-Microsoft-Antispam-Message-Info: CeLb6kIk4IL0vt7fEr82VCK0CC1pKt3qmF10kT4jeU0AvPjATI2/tEodAPPRi607OVSulaY4Wtmhhi94xaGE/AAhzRwcp+iWBRdTDpnZ4qb88WbzSXfvxCxXTHqvcMDNOw9zMVWtYdROCR2jJKc316VG1VmX4tBDEKuZDVOP0uxbptqDapFPOYCgOTqwQhWWooq6W7FUqRoqdU1kovJY3CI+QeFNXG78vi3cAjcNwxbIEZPcZIWzQ1XCIulFpac1esg4hx+vAMdc7/+B42QxSR8rz4qNr2zaYKKZkiW6s4uA9DxtTg0jjl7OmaN9DEfO77sSP64M2qIf/QLzj8qOrn2haKy2FdMfHi90m6Sj0vA=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;6:oxHsRFd5WOdntQTlJ0wLoExmvJgS4cFlfDBGNQefcyIXksC0Gn9DVM/guvNBSgrvb3ED46t5wzfvid0DBHX++cAhy+TI6FyHorv+0+LF+mn+OVtnmLeZEZEx/EEclH697VTu1wI5yzQnbmITS82t2uxtRwC0/yi8TDG8K9lk5QMH5BiYu159zbDxUjt70iQ1Ja2fxbnFHctvTLexJBVecpL5wm86tOovpGX8PC58egUuXaPiMLScuqWGt8xyqxPsxXgWzDNm9/Cs9DEeJ0mIMMsvidtCqhheA5VAhNj752Z/XEdlMfxp2WhiCxf0Fzseo6HIeXDC9FMtfBym0Grn+n9DLFYco+Dc9IcFz9Ow5mtj3MaJFG1V7SsaY4wQii9A5L1pDyCUUFEQUfeFdbJuvFJCljD+jqivxDHThup6XNF5QXg7yCsod3loBlzyJ8aGPqwfXYptARcvHfWUBKcXHQ==;5:zPBtQP9Zo21JFPz7dXMF10dV81nk4ndifJfeg/LjxB6WBRRTmpJQc4o6djecNkZb4d3w+R+DvPuh0EUa+nwm2kb0Kuzxrzh4LvI0QVLXMEE7VaRaq0T484KLLRZORjG1SB/LpFlF5RelYJBKDliE6/SYt0Vc6OymzLgKTm4u5qU=;24:BHVdGG2nRksXf8m5g/B1mDRS1wLEfFVz5bfL8Ern7KKckm1kU/ooVFVlzxZuHoyNckWBeAgTICEbGSofOsUz3TC0j43tDJFI9JYGG1um4nk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;7:fbeiO4IONQVRVqyy9QXi5rJQklDYQamHOTRaui2lbUJM2k0AP2eY2eSkQtoqR4sBvyg2n/5SY261OsDLsxaXFsaMLC3af0gupM39U0h4F4lje4h206dpFSwHtyFZljAlEkWWDtoLPyiOR7hOlpkJ+yuidYKfGPGPYCSU2HRvDw6zYc4SalxZYadpwF9Njcj7b5cf+Zr9LboT9HX5H5JOzz8ElFVVxtDgxrJrP/poUr71iV3lbyfv2J9xiQGczfCo
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 09:19:35.3867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec073470-4480-490f-d25a-08d5e8a1c706
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial dtsi file for Synaptics AS370 SoC.

patch1 moves berlin binding to syna.txt.
patch2 add dt-binding for the AS370 SoC.
patch3 add the initial dtsi file for the SoC.

Jisheng Zhang (3):
  dt-bindings: arm: move berlin binding documentation to syna.txt
  dt-bindings: arm: syna: add support for the AS370 SoC
  arm64: dts: synaptics: add dtsi file for Synaptics AS370 SoC

 .../{marvell/marvell,berlin.txt => syna.txt}  |   6 +-
 arch/arm64/boot/dts/synaptics/as370.dtsi      | 177 ++++++++++++++++++
 2 files changed, 182 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/arm/{marvell/marvell,berlin.txt => syna.txt} (94%)
 create mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi

-- 
2.18.0

