Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OkEYFt0uGVv1KAAAmS7hNA
	; Thu, 07 Jun 2018 13:11:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 136C9608B8; Thu,  7 Jun 2018 13:11:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="st1aesCS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 608D0601C3;
	Thu,  7 Jun 2018 13:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 608D0601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932456AbeFGNLZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:11:25 -0400
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:37440
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753028AbeFGNLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRptz5k3X4gBDmlHK8gsGa93mnfni45jrTT1ck+WtXk=;
 b=st1aesCS5FgQPUBpceYJJyG84PyFbEmvNe4BBVhsGV4R+BqxxpPxm4bH++qn5QPB7JJK2PfOGCgGAsQHHrzpZ1WTDgV/bnxOkE31AnEvQM/HFQ8ITl3t+c9qSwp3b06gxoqwQtk+YgI55Qrrw4Y2WQC63pXC6uFzIAQj+1JOxuQ=
Received: from MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15)
 by BYAPR03MB3415.namprd03.prod.outlook.com (2603:10b6:a02:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.14; Thu, 7 Jun
 2018 13:11:19 +0000
Received: from BY2FFO11FD028.protection.gbl (2a01:111:f400:7c0c::128) by
 MWHPR03CA0005.outlook.office365.com (2603:10b6:300:117::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.841.15 via Frontend Transport; Thu, 7 Jun 2018 13:11:19 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD028.mail.protection.outlook.com (10.1.15.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.820.5
 via Frontend Transport; Thu, 7 Jun 2018 13:11:19 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w57DBHrx012575
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Thu, 7 Jun 2018 06:11:18 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 7 Jun 2018
 09:11:17 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Date: Thu, 7 Jun 2018 16:11:05 +0300
Message-ID: <1528377065-647-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(59450400001)(77096007)(8676002)(8936002)(106002)(107886003)(1720100001)(478600001)(7416002)(5660300001)(7636002)(72206003)(5820100001)(966005)(305945005)(50466002)(36756003)(356003)(4326008)(246002)(54906003)(110136005)(316002)(6666003)(47776003)(2870700001)(486006)(106466001)(2201001)(476003)(126002)(336012)(50226002)(44832011)(2616005)(6306002)(7696005)(53416004)(8666007)(2906002)(26005)(426003)(23676004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3415;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD028;1:A5qJssvKNXyKZSvoWxkVvleD7ex9Cj4KZYhjvShwaCnLS3GX1FI0IGowPUMpTYYZzDZ9KXzJobz6tTFz87i5t46nUP9piS3JoGKNsMdRlx8x7cNGaZ0AZvUwJ4fDnEvE
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BYAPR03MB3415;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3415;3:ukSQsLlKO1EIx619uxc/D/zy1Vik8lvfA6IcSVNn5kzV/jwzzlzBMlAF3DqzaK67e2HTEhtfh7sLAqAAxSb8u52BkKnOI/ZtG1bkIq9z1P3tGb638RfVUt/caQtTmNO2GMp6/XHkt9sEBXIWP4U5+8pUsznk/4biWaWaaAnP0art9xRQ6lQ+oMPdXnIL2QLV98bI0pBRz53fCHupgGnxvPgCWyrmVNaHBHmfbvmitrBlv7FVz/DjNSTYY8Y/XVK2F6g8etOECGqR7exFbS8ssaR6o3EccEgtR4X7xwbYlFebqvfynKmkRLLrqhfASQStJrPO7EzJTglKREDR3j4WcyxLp8mRsIWIB5uFRZXzAuw=;25:etjsqw8iB8TYg8T2OV0u8Nx4WZNYjssbitRyhAOD4J7Fj4ZDEfmSNNSC2BKHkVnSp+MelVwVJCE0457zmA73N+4wkpiXlFw8cSPfh1nyGZcTUUPyIvjI1tRI2HofZB2jMUs2I7n5lvnBScx74CtJoGmdo9+K6d7JcyGMzGSstOUJX/DPtTylkCTxxn+UiwiJkaiXvZFC5iIhO7amT/+w7Fe+9cfppMyThGZGlpSKb8GdrFDx1XnUt2gjdQi2slY7i0TSA2CB2woh+oDJq32DCuDaWsdl3zz78UoxXPiFRyRT6wma5Oo50pNLxdLSfSlU0GkDKg8oHrges/EaeqUN9g==
X-MS-TrafficTypeDiagnostic: BYAPR03MB3415:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3415;31:+KFXoFjzZ1AGxluE2ICLLymaFNVuG27/JxfnO4az31nOLwESYQepGZPvGO5zeuHAFfOOcVq81prwZy+e8/KzJgkCs3ob0iQ2G/vyTexguC4EE07mOLBTjdGWVrSkwESLivRKNPuJYF5z+9AUhACs1R6K127xSZZGHRy4cSNhbfdeeXJhR+nZ8YdSpsPvuWFOJ5jZJ/JnGX6ORppJwYiuO+w4c308rvhTKC594mEKACI=;20:KZdRSB9H39dBNPf0WELjFeznIKj4HVKmGTAVEMNDe+2g7FpTOz50OTq9ZdMJV1DbNzCsAPcZxKc4/oSQzFnJY2l9zIBEmHcDuqI60slAMqlZl3e2lBVYP1xsuuNrEkoklHk5jO++nFLYoR11fBhSivUrvgD7MWNnvbv/ITVyBZ/sFvoew1sVTIAzAryHh0n1GRBy769deO1mPyns/fbCpRadTiveJsAf4lCcSnQOmbX/9qppoZXPbJ7e45MyApf5Av/013GRj2cd01vttjZQLf3TaYCl54pJ2uzVyf2Yw4PBJGOXbEPjy4+QE96l2Yy6uQHZXvwOk2Ukk/oqwE6nFeSPf4YZIzear55mqpPWD7BgRVZF1R48+VZc5boyc+SMx2j9b+1c8rcJB7UyT4u9/gVViU3eKvL03b5tDECl3sr5uRdExeRaJge7eu4V41TzbNPUmZNtDzscmgsuhzj2f4u9IN1Mk06FS2iLqHxeSM62F/0n4hYbsKsgoMs5Y9kH
X-Microsoft-Antispam-PRVS: <BYAPR03MB3415251A2C2A7ECC1A720E239D640@BYAPR03MB3415.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(95692535739014)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR03MB3415;BCL:0;PCL:0;RULEID:;SRVR:BYAPR03MB3415;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3415;4:suKG+h0gYrXyfiLSeca1Fl09sTZlJM/U92etau/yoi5W+QuTjUmCnqP1W7IMCADZA4RtgGYFwxCLrHfwxb43GiakRmTtVMQGo7c99UfE/qrDREtXQj4/6hdcUBZG8SQmzHBr++7PYXyVMn8dBE+HFr9HS7/gDf26Zoy9VDsebAC8ijqzfra10QzMv+MYr/np9FbbdwStRnEh4Be/1tsYrGkBhEf7OUDlFmVZsyOb0rghyDDQrHVqHHf90aj16LrQDVUqln723DHtBPXv0TGti5DhqtLV/ZJ/vIs8pJqbPwgRc2kWZiefmCeQNoIMxje340h32aBTLyrXx6AehALsS3EIhff/l9On7ziN0eoSiSk7IU0qh7OFUMEvrDC2jakb17mM5RZ5g1hoLH9xF6pf8hlrdPw1aS0hzZxY0kpjzkc=
X-Forefront-PRVS: 06968FD8C4
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAzTUIzNDE1OzIzOjhuLzMvd0ZsSkloUHVyek9oYzhNZTc0OU40?=
 =?utf-8?B?ZUszaTNQakRtZXBqV1NsclVMdnlVcG4xU1FMUWJSZW9IN1ZYMkQ5TVVLTkNZ?=
 =?utf-8?B?eDI5NzJGRkd0c1VUVEVKWWRPbGpIUWI4L0dTLzlocnVzemwwTG8yendCS2Zk?=
 =?utf-8?B?bk12ZE95b2N2STRJaU9YYTRkSnExZEx2T1ZBVGdBYTZRRUFpNGR3TitscFN5?=
 =?utf-8?B?cjBEb3B1VnlhWFpqdFQ4UGNKRDcvWjkxZVdtVnpUMHBMZ1BBem5PaElLRGxJ?=
 =?utf-8?B?RXgrcDV5VWxEVEFHRkNqT0ExUHFBQ2kvbStPTFhoZzJVSkxSTWlKNis2VVA1?=
 =?utf-8?B?c3hObWRseE9RaW1JcVE0Zk1XbWFHZjJqL3ZmWWt0aENCVkRSTEZDeWpuNkNS?=
 =?utf-8?B?LzY4UUNwNEpVeW1xcVljNDZhRmNqYk0zOWlNSFJGRDRMVjFWQlltd3kvYUpr?=
 =?utf-8?B?RjdsMXdSMnlzV3c5VUpmRThxYnhPUHZZT1I1c2ZWMzU0TEVBNmpTQnhhcStu?=
 =?utf-8?B?VGFreXdrdEVnc3JKZitJb05aeiszQ3MzNnZJNkdOQlQ0eHRUb0hTdVhCMGVa?=
 =?utf-8?B?OHFzTDJxT3ZpQWdIV3dJcElGb25Qc2YwRWJnUmNzdzgxdGZObjdYK2xPMGVq?=
 =?utf-8?B?UFVKS1lERFdlblRXSml6SjNXd3hieTljbnRuQzJmVFNlVTAvUGYrVzBTdXND?=
 =?utf-8?B?Z1ZMdkNRRFBKVGhmM0RwTDlwcjZkM1VhaUN2SnhtTUpvYlVrR3poNkthUXY0?=
 =?utf-8?B?V1krOTRkZWZ0TW1rRkNac0Y5QnFRNFltNHRQNnBjUkQyejFFZTQ5WDdKY1V1?=
 =?utf-8?B?WkM2YzlvdEdGUGZCWUJvZXlWajV1YmxwdlFlUGhJOTl5cEt5N1JCMkxyTVN3?=
 =?utf-8?B?SDgzV0Q2ZVhrZjBKVFQxYzZXU3BHY3VSMmpmQk9FaWVSWmtybmVWN1h6L25l?=
 =?utf-8?B?WTFyUGYzY212Zy9oY0dxRnRES3c1WURicnZtcnJjV0VOb0laL2syRGRKTXNo?=
 =?utf-8?B?OXNURTJaRVc4dTJxQ1dkc085elZmVXRzazFFN3EzUUNDS2lnVHorSGZRNGxv?=
 =?utf-8?B?S1MzVFNwYi90VlZQOG5MaDU2bzZxYWpEU0xhUFVNaTA0NnU5YktIeDJMSzZ6?=
 =?utf-8?B?em1YWS9xWm8xandYMjJYTTJ2cWRlSHl2TXJYUmpNeHAwbEhEZ0JveTRsdVBn?=
 =?utf-8?B?R0ZmcWlaNmZYdGZyNkxxSU1EZVNoc1ViOGpsMnpmcFV4NDg4cFZ0em9zR0xn?=
 =?utf-8?B?d01KZHJWSTB0dzQ0RkQ0YXZVTDY3VitBM1Qvek8zcjNCUFNjdmJJTzRjV2xB?=
 =?utf-8?B?MXhaMllvbjJPVHNCbmUyWEs2aG1uWS9YYmNPZ2dJK2pZQnpJRU1TT1NYQS9Z?=
 =?utf-8?B?RDFEVVllMCtVbklQQ2V5MGZuUmV5Vk12UzBleVF2eVc1bkhTS3U5SEJpN0I0?=
 =?utf-8?B?T0h0WDljQktPWWRISDNOUTN6TlhWSWcwdUZONEttdUM0SG1jbnpjQ1U1THUv?=
 =?utf-8?B?MVZzUkZaTnEwUlVwYTEvMzNlcFUxTi9WeDhTTlRLUDZNMStDOU16aHh3VEox?=
 =?utf-8?Q?D/Ip/tF1gT/7PM8UaRP9CpcYoxcWK8C7aZZGpKJ0IZ2Y=3D?=
X-Microsoft-Antispam-Message-Info: HGkEVOW5eDnnCvkifF9fDgotqdpWdhGHj5NmrprGBj+79hQZNrEvPVC/qXMHR+O7k/xgHkVT8HUFM+wRIZM0a6ilRDwFrKRy+8Lj1uQCw3pwxO14fhXlTTF3pPRVRvDFsj8jd6WRAxf7xEKIURfpY2AdJTY2gNFJwpVMwHrzr0fuztsxQJgggy/yr8jszYNo
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3415;6:zUrQPGOk40qNN9k45hoTwPxcmlqDjQHEHyAIhPmzcLz8RX/mKxor3bdfhM/TuwccL3VYNI7sREcJoeuY9YMm7ibiivwrMXjeju8Whde26k2OqrWZrUHGxGVvsWdbCXYpNpFiJHMo7jdeg0eCFGnKt5U27CbtDYUnMd5Nruezpdfw1om8JO+rqg3uflu99so9hWsdQPAgy/hnSnfna9rUb3c6ZiHeCYdPLI9gY8VAuRRLl7xk0RKaaeCVWrz2tzB3TOVUJu6bRWQkUSrBc6baj9dZRNqvkjE8Q+zRBOrseVQq9kjKlccUnctp2hV2alsGnj63c6x/YeF5v0t1d5Qrpusx8jDMOW0BmW4S8rjpn7ugmOgLSOrqRNhw80Gx2Op79O7JlkPOWq8qbZQsavz2bwUHxavRaaDpp+JHQv0VkFYiv0LVvsmnMHsvk+hy0bPkcA6egGud1sOy6Jgw5hbWkA==;5:8tzKzfOAu2MvlgUO0JbQK3pqNrhVfO3/tOC8s92ON1U+oQ5oOAUGzflHxgeAyeukC6JUH7FT5nWmOD0oy5aswFwQc6aodQL1vCKob0PjgLoGDx2WQ1wn4WNGKDCbSoWGCYCFgOTEr6NBFi/Ay9uV9cjYG54RcwYnWpqTt1ywjl0=;24:r5PXc3ryQjksNsJb6ZxGRs7htdwRjGE81lPC4iqdm+d/beDsoqWwLScWYfGGkRdwPNuN4GHHx1adYA1kW23Hd8AaTrCzB+oYVAi7eUxlLJA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3415;7:FLwO71pARRcgJSDVsvsersSVx2kTJskqy8TTh8GaVV8xmOX7cNCNObVc/todI3fuLhrxxjDmWIihp7ZyxgfwRYH/7xhSrL32rQmhijoLBj6as2GOs/CIZxspu8jLtKRxOdCZCTuScJT7zCBT5lFpnb15Ngug4KwWcm9XksO/kFO+bbH1ln0E4fDOyFVZKqgdhei8gxgQar74d3vEM4M8c/WV5DZN8rfY2gideFYS80lpffFJGYy3EuYJMI/ObFx5
X-MS-Office365-Filtering-Correlation-Id: c1e162f1-4776-4d90-1463-08d5cc7828c3
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 13:11:19.1844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e162f1-4776-4d90-1463-08d5cc7828c3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Nothing changed, just to follow the patch set version.

 .../devicetree/bindings/iio/dac/ad5758.txt         | 84 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
new file mode 100644
index 0000000..75fff6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
@@ -0,0 +1,84 @@
+Analog Devices AD5758 DAC device driver
+
+Required properties for the AD5758:
+	- compatible: Must be "adi,ad5758"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use (< 50000000)
+	- spi-cpha: is the only mode that is supported
+
+Optional properties:
+
+ - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
+		   The following values are currently supported:
+		   	* 0: DC-to-DC converter powered off
+			* 1: DPC current mode
+			* 2: DPC voltage mode
+			* 3: PPC current mode
+
+ - adi,dc-dc-ilim: The dc-to-dc converter current limit
+		   The following values are currently supported [mA]:
+		   	* 150
+			* 200
+			* 250
+			* 300
+			* 350
+			* 400
+
+ - adi,slew: Array of slewrate settings should contain 3 fields:
+	1: Should be either 0 or 1 in order to enable or disable slewrate.
+	2: Slew rate clock:
+		Valid values for the slew rate update frequency [Hz]:
+		* 240000
+		* 200000
+		* 150000
+		* 128000
+		* 64000
+		* 32000
+		* 16000
+		* 8000
+		* 4000
+		* 2000
+		* 1000
+		* 512
+		* 256
+		* 128
+		* 64
+		* 16
+	3: Slew rate step:
+		Defines by how much the output value changes at each update.
+		Valid values for the step size LSBs:
+		* 4
+		* 12
+		* 64
+		* 120
+		* 256
+		* 500
+		* 1820
+		* 2048
+
+ - adi,range: The output range
+	      The following values are currently supported:
+	      	* 0: 0 V to 5 V voltage range
+		* 1: 0 V to 10 V voltage range
+		* 2: ±5 V voltage range
+		* 3: ±10 V voltage range
+		* 8: 0 mA to 20 mA current range
+		* 9: 0 mA to 24 mA current range
+		* 10: 4 mA to 20 mA current range
+		* 11: ±20 mA current range
+		* 12: ±24 mA current range
+		* 13: −1 mA to +22 mA current range
+
+AD5758 Example:
+
+	ad5758@0 {
+		compatible = "adi,ad5758";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpha;
+
+		adi,dc-dc-mode = <2>;
+		adi,dc-dc-ilim = <200>;
+		adi,slew = <1 200000 12>;
+		adi,range = <1>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1993779..f640146 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -808,6 +808,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/dac/ad5758.c
+F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4
