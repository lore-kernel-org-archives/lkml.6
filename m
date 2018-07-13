Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239B3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3F720873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="a2k2jF/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3F720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbeGMM5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:57:21 -0400
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:21328
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727482AbeGMM5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uk7dRHUP5+qoiGSOmN1LkN/BTL7wgRL3LVIAfTiWoU=;
 b=a2k2jF/vfYUpLHqnLioxtH1GEL3TAnF6wpcz3fRJ/fYUjdLLz1maTJvWiXcr4W5SVueLe1idXq7Lgjp3wB7QGizChyVj2z4IoR9Avh6DeP1yDyOm+qFAKVoR5susGrDe+c9id66SVsGbmZ97nxJpcYJ3yKUlhSHORf/JX2VzeZA=
Received: from CY4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:903:33::33)
 by DM2PR0301MB1232.namprd03.prod.outlook.com (2a01:111:e400:5020::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Fri, 13 Jul
 2018 12:27:41 +0000
Received: from BN1AFFO11FD009.protection.gbl (2a01:111:f400:7c10::190) by
 CY4PR03CA0023.outlook.office365.com (2603:10b6:903:33::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.952.18 via Frontend Transport; Fri, 13 Jul 2018 12:27:40 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD009.mail.protection.outlook.com (10.58.52.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.21
 via Frontend Transport; Fri, 13 Jul 2018 12:27:40 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w6DCReh7003082
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Fri, 13 Jul 2018 05:27:40 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS8.ad.analog.com
 (10.64.69.108) with Microsoft SMTP Server id 14.3.301.0; Fri, 13 Jul 2018
 08:27:40 -0400
Received: from mircea-Latitude-E6540.analog.com ([10.50.1.102]) by
 zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id w6DCRbJ1030444;      Fri, 13 Jul
 2018 08:27:38 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <peda@axentia.se>
CC:     <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
        <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 1/2] =?UTF-8?q?mux:adgs1408/1409:=20New=20driver=20for=20A?= =?UTF-8?q?nalog=20Devices=20ADGS1408/1409=20mux=20=E2=80=A6?=
Date:   Fri, 13 Jul 2018 15:27:38 +0300
Message-ID: <20180713122738.5888-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(1720100001)(5660300001)(106466001)(23676004)(2616005)(476003)(486006)(126002)(6916009)(86362001)(53416004)(7696005)(44832011)(426003)(47776003)(966005)(54906003)(106002)(316002)(6306002)(336012)(246002)(50226002)(2906002)(7636002)(8936002)(478600001)(2870700001)(305945005)(14444005)(356003)(5820100001)(50466002)(186003)(1076002)(72206003)(77096007)(26005)(36756003)(4326008)(107886003)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0301MB1232;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD009;1:L10VYyD8PABQzkbpJP8SHI45gv+LmV0K2qiSnmkeI6EmnabXGeVay/+t4Uqwk7SCqBUpe8Pz8EBuvvpsuPKpJcs7dtn47esG7fjze2q0uhfKf6fozHNEn09a3IBwm8XU
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 439bc155-3e3b-48f2-bf6f-08d5e8bc06c2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR0301MB1232;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB1232;3:dzyIdrzzBiYIhRy16z73M2l9RC0H8n+8k8LPthuSVH7ofxZgJaAWF2/jEgBMD2EZfIMRgJTDxLxo3plxU7Zj1wNEZAAZ7bGkrYas39JIbnO23qHZ+qzWQIdo2FRE3zEQfh/fqkWJLwkvTFF0vn4Ps9eW4sVaANsrVacjzYRxWz+bZ953Og7EJhSQlJWKrN75tbCuJZZ2cpEmGFSw/sEyFHXFkGIo2uePdV1DWbUEwg4V/tfYY6riUMjmprQ6w/XdWK7WbeMgw+MqnPkw9UzmO7xr36Q1qt2x1t/jUmcwpbFnxWw+dL/vJm95NCub9zQV9Cnvfe93mCE+zpnpvlBF6A==;25:KXobG64vGpnSDP63hmSu6wgQeT92ux5EZmZgfnndviMJfZwaoPqpP9JFHWbBVE6hRRm8C2OIL+MeOCQ2P/bfto/MD+XNtqMTdkBBB0LW9lEBz9DXjhVdJ9Mc/Wn5H2S0w8KcyS+nMNZN25vX2+9G+ipdCnoCSzDo6IZUScKDEA/lQdOmWf8Uq6AssEbjaKkVf/45X4o13ulQVqUfMEhYYHwEoE5SZ3G8x8N3F1JnOC6fVFgN9KsLURrw/blEHXlyiARln6G+ZakDJnc1XybcQlRGlQlaoPfgd5z9sPyvAha5dG7laZFbLEKSr9Ch/KujWDDY6hae/P5gDcThHyS0+A==;31:aAN/l0OxICs5mBhAKURpQm66X35zmo5yCr/2sWWgxs2tt6KlnoZvy+d8CLGfLFnmFF1pixidebFwIAjXcl5sSgqfNe+jtU4O4X+6zWW6wkrjnq7Z+YC3NgRsHHLN3kBRNgqIz4kOzmf3MNm4mm9BVUG9Kl2ZPYb/gjqWsoJ3A2b0/njwXsleicPQWqpfywh0Hb0ogBxUPSohhWZRI9Is69vi6V2IKBCoQh+duL2wiWU=
X-MS-TrafficTypeDiagnostic: DM2PR0301MB1232:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB1232;20:88y2E0WLEr7Lk2j7ZcVjg6yjbx4UXPG64wt14RBiGJ7E+uVajmOAn8RiPQguqs2qJQwoneXSv4AAjttaWzb3ZPSOk85mzlLxEOfvbWYKJvTOg1QTkbkfiIG26Jylz2mSOTDZlU/HRqNTcdIHQDa7ZY7iQ2d6cEcKtFYev5dNJSQBC6Irkncy68/Dqs0WP7EdSQNt6MFFJYmpWc9lHSAdiAiOKJ2TP4zS8DKQ7hDe2MDc5PPY1i6e5WjF7KK8EPR9Cj3Pb9ms8Tav19ZMisYi6EFXonaSST5thz2RY9GItOj+weYDyU5FIHM20OgpE/HCn6XzpOij+A+8iNVUge6f7FYPyb31MVFZCJKTsLkSyRV4zScXsJBcy6P4XKiRSbBi5UESjTkoud5PvALZdphyfuaazkwcnp0kbJIrGZI0N6hfT9kpjnqbA7+lV7gn6O2XkylFPdOerCQwFrD1cvM7ajcH+8zCTUvzexTsFkZkXKDU0wmwCANvqYRyYU4khh8S;4:M8BbHyai5HbWSvnSwwLOQFO+UhOfFyXf78fTd9F5XsbcN7aPLHxOnLt2Ddv/5832d8lW0VkSgVRkBdFRM530TyZYA6+OI3ndkm/NNOs9cn2g4pogzhPyMD0eptrnEwUVZ75lSL6e5V/PZ3X23Czsmvb24oX28320QZS/7h7xDb3aXbZ/DXsjXiBdnsk3R6ZSNb4xerV0wj4GJmFlo7ldxyApa+vNiDvyQGSf/h9I2YWfqFzZfER+ccKXmstLK+0h7bAARAYzBsNPJfEvt6vLCzwAn0RkoS2qzD8CowNVE6grcnIBKNH+iX4jXflLBOUNlq9BPXSlbiOsQcM4X/z6qrfPTTN1tEvyjR7aaUoAMcz1kdlruXjqaYfKyUbSvLAkllrXGwSZNqEE9u49rwi1Me2SJQh8kQhDpm3kQHv4nWk=
X-Microsoft-Antispam-PRVS: <DM2PR0301MB123294FFD4FEAA304038468481580@DM2PR0301MB1232.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(150906107787882)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM2PR0301MB1232;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0301MB1232;
X-Forefront-PRVS: 07326CFBC4
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjAzMDFNQjEyMzI7MjM6ZkF5L1oyRXU0RFdpakFHSEVDWXZVYXQ4?=
 =?utf-8?B?M0RaTFozemlqY1RnZmJBTGxrWVg5cERuNkIrcEF2MXFWNkZKTE5mTjQzUTUx?=
 =?utf-8?B?bXFlcXcvRVd2KzZPL1oxME0xdHV2L3gwQkk3dUlscW9IRGZyRXk0ZUhWV1RO?=
 =?utf-8?B?eUQvQTZ1UEd4aGZBb1BiT2h6WUprcGlQVG1yemIyZ1lmaU8wY0ljaXJvaHMw?=
 =?utf-8?B?TkFlZlNyaWFBcGF5UGwrYVRkRDRpaEI3NlRNOXRmNnFhN21DcGZLS3JBTGZk?=
 =?utf-8?B?NDRMQzJRK0hmY0w1ZkFkS1VFbVBXTzk4MFpCclFkemhGaEZac1BBRGFYK0Qw?=
 =?utf-8?B?R3BReDN5RHlCbjN4WnVLcGZ1T2xNbmJxdUlHdWlLU0g0R0pmcVFOTHdNRmZU?=
 =?utf-8?B?VVR5TWFSdisvbDJyYlpHTjFReVU4YzU3QURJUmNRNGJIRkpZaDg3N3VFeWJ4?=
 =?utf-8?B?VHpNMTl4ZXFKejQxRk5lSC9vVmFvYlB1ZjkwRFVlQmMwVFB5b093UldIVmIr?=
 =?utf-8?B?ZUNQSFVueGJhZThHWEs2NHNCeTFyS1RtaVJFTU1wN1BGL0JOdUZFVDErZnN3?=
 =?utf-8?B?OWtDVVVHQ2lzOWhSTnpjTEZjbDh5Y3FKSjRTR3ZvaisrRE8vQzZTNURVN1RU?=
 =?utf-8?B?WHhaeHNvaHdnZW1wTjNkSis4T1ovY2JXYjBVVTFzbjBVZVU2Z3hyU0Y0NXpm?=
 =?utf-8?B?ZlQ5R2d5eFIzQXRha0lXSnp6UzlqTG5UV09RZVQ0MHh1dmNDS0xIZG41WWY2?=
 =?utf-8?B?OW9wKytRbkJGK3o0c0pOajEraFRJdnZsZW9id3B2bWhZNVRuZm5JZDdScGZs?=
 =?utf-8?B?QXcvTmZJM0puTjVUSE1QNEgySHRpenVkUFRPOW5oUVhnbDV0QjB1NklRV255?=
 =?utf-8?B?WlRYdFBmdnROMHoxYmc0ZzhHUk9pcXg0cmVBd3BteWs5TTNqL3h6eXFPK1R5?=
 =?utf-8?B?VElTbzlyeHEyb2VuU1N3dzVacU43ZVlqcWkvQmxuN0ZtRkkyMURrQ3JVWlZk?=
 =?utf-8?B?R0ZCMzZNN0dRc3VtR0ZNRTJvd083ZnFRUjVrODhBTkxQOFVZRXF1UjFEN3B6?=
 =?utf-8?B?UWQ5Y1F5UzdBVlpUOFAxS3JEVzFDQ3ZWVEdMRGJmT1BSSCtFVW15WFU2THV3?=
 =?utf-8?B?aWs0bHlJUWtQUW50c2xTVnBtRWMweWM0U3JycmhhZmlLUnN2UjBGeGdMRUQv?=
 =?utf-8?B?WTVicVB5NkwrdjNHWFA0WjVVWmpLM3FCLzZ0STlxTCttd0NrRmVLUkx5N1Zm?=
 =?utf-8?B?MU1OMnhrVFE5dVhtRmZ5RlZYaWxGR2psTjB5WlVzMEl0TkdVVjRQT1psbVdM?=
 =?utf-8?B?ZSswV29LcWF0RVpMaE9TdnhVdXFLVHZtRWxyVmdaaC8yQ1ZtZGV2c1NMZkdE?=
 =?utf-8?B?Vks3b1oxWGF2S3ZPaU5kVEZxQ2RBS0tJVkJ3WXN2Y3hNdkFPZTg5RmV6clBN?=
 =?utf-8?B?dVY5UnlsVzZKenNXMW5JVWpYZUN5Qk43eWZTREtMb1JUaXozekFsMzFhYXM2?=
 =?utf-8?Q?gnWttm5wjPPSI7PAYc27JOS9XZE=3D?=
X-Microsoft-Antispam-Message-Info: 9V8ZkoiKqpr4owfgqgnj/MfFQBm/mbRz8t7/WfC+xpeXBiSRJeI3h4O4ljj6sugOnUK2a4aKuEwjUVquYUIicejJmkp6/Ykm/yJcExZZZimQhFjMOwfx0Ru5H63df8OhonOHVHpPCSVv3lz8buN11+P3+qEzxMEjRXtCek2dX24oyAgmQTf6vw7+ccFWelm0SEE4zVqp/D2JJsbFi/lQkLCDprFSuyYV4NtwwSgzCRI7t3wdkSQsxFFxyToxu2tPTkLrgYuM7eQcMl9zDjW4DDHQbLL+WHLr3Sofz3mzHu1G6+hqB3RI137h9eBb9xCDTWviURGy/VhexXvHuXC3LABiOuqpsrjaDUet8qpeW1A=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB1232;6:YfrJubG7B2SsGfvCg4Hcz8ANX/kqQhDfQJ8af0GDg9xT4vIM+c1QM4hM/7fe+0MSajecpTf9/qmi47rkeyzMoG6wrZr6KZ4EIf/FmjeH8qaJbxmUfGD49O/sVJxPMAHI8l99+sKZSQJnWRYcW3/sQZ3QLyKDJbfBPWyozVV2l5PMtPMsztXuL9Y3IOQfK2Ie/A1E94z/HOXP3y9z1r7itbEQskbJpYdIl5/KjnuQi/texKHmVcjO33fP61Bq7KM3PtZ0gSP9J2ek9XN7ZF9SwbXptVVX61GGUDz+6908wkf1rfJsj5xLI2G6PoQnVTy05oXVcfdGLR/wzaS6f94tYJfZY5Rb9H6P8SqtWQvwUgFQGj7wFq7XrPV4DY/8tZix8w7YJ1txt6NRgQW5IM8Si2e0tZhQjG7CHEAx3CS76oGqnr8mpKWHNgb2is8+FYbhmsq98+cGUvnwnal4jd1VsA==;5:mEGFdTS3UG2aDtdHkrZEb7OSPee/miFxJD0NluE/tunS9tZ5pvCF3YmxJjMgIznXupkuxmBwu5JscLmpkZ5cKlaOOwjaj0CVSu5Z5tBi1RxIs33sT03KlIMdiv9L+0Qwp/m2BBWkQSr9k1Ko8bJZOPSc3VvJ/GrMuiFZO+1BCHY=;24:X9sM2ms4DrZ8zMPSd1ajcxzP2egk++0eM90SgtmT2JctlERfsayJdiA40mp2z1GRFKZ1rgluIR+6Z5Sh1qTNW+asBUtUkaClubSv7FNP0IY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB1232;7:KT5xs+6YKS89//PtqnUNIzYrlsLAD8zkPpKgmSClY7vrFQfjnX0W75kHdbWAs7ZI1zuIESEJzwh4NRG/M+mxWEeZ5p6A7P6mkcq7o8OEE+4wbkexEu93DSK7HIeY54/Tm4Vd2X9eXeW4uJ+HEVwGq8esu/9Ri3gDoct+Iwpbsa5QSTruuzqDpNRRC1oaX/qOavzqRRzxQAIIsAhfqFxYv0YdnDHRGDb/AdwAPRUAL451h+Mr3724Ux3KsJ/AhiQL
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 12:27:40.6465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 439bc155-3e3b-48f2-bf6f-08d5e8bc06c2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0301MB1232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for Analog Device ADGS1408/09 SPI mux
controller.

The device is probed and set to a disabled state. It uses the new mux
controller framework.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 MAINTAINERS            |   7 +++
 drivers/mux/Kconfig    |  12 ++++
 drivers/mux/Makefile   |   2 +
 drivers/mux/adgs140x.c | 132 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 drivers/mux/adgs140x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 192d7f73fd01..7aa68f38ea4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -810,6 +810,13 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/ad9389b*
 
+ANALOG DEVICES INC ADGS1408 DRIVER
+M:	Mircea Caprioru <mircea.caprioru@analog.com>
+W:	http://wiki.analog.com/
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/mux/adgs140x.c
+
 ANALOG DEVICES INC ADV7180 DRIVER
 M:	Lars-Peter Clausen <lars@metafoo.de>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 6241678e99af..87b3fda56d8f 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -48,4 +48,16 @@ config MUX_MMIO
 	  To compile the driver as a module, choose M here: the module will
 	  be called mux-mmio.
 
+config MUX_ADGS140X
+	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
+	depends on SPI
+	help
+	  ADGS1408 and ADGS1409 4 independent single-pole/single-throw
+	  switches.
+
+	  The driver suports driving each switch independently.
+
+	  To compile the driver as a module, choose M here: the module will
+	  be called mux-ads140x.
+
 endmenu
diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
index c3d883955fd5..236e7738462a 100644
--- a/drivers/mux/Makefile
+++ b/drivers/mux/Makefile
@@ -5,10 +5,12 @@
 
 mux-core-objs			:= core.o
 mux-adg792a-objs		:= adg792a.o
+mux-adgs140x-objs		:= adgs140x.o
 mux-gpio-objs			:= gpio.o
 mux-mmio-objs			:= mmio.o
 
 obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
 obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
+obj-$(CONFIG_MUX_ADGS140X)	+= mux-adgs140x.o
 obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
 obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
diff --git a/drivers/mux/adgs140x.c b/drivers/mux/adgs140x.c
new file mode 100644
index 000000000000..13dd95acca20
--- /dev/null
+++ b/drivers/mux/adgs140x.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADG1408 SPI MUX driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/mux/driver.h>
+#include <linux/spi/spi.h>
+#include <linux/property.h>
+
+#define ADGS1408_SW_DATA       (0x01)
+#define ADGS1408_REG_READ(reg) ((reg) | 0x80)
+#define ADGS1408_DISABLE       (0x00)
+#define ADGS1408_MUX(state)    (((state) << 1) | 1)
+
+static int adgs140x_spi_reg_write(struct spi_device *spi,
+				u8 reg_addr, u8 reg_data)
+{
+	u8 tx_buf[2];
+
+	tx_buf[0] = reg_addr;
+	tx_buf[1] = reg_data;
+
+	return spi_write_then_read(spi, tx_buf, sizeof(tx_buf), NULL, 0);
+}
+
+static int adgs140x_set(struct mux_control *mux, int state)
+{
+	struct spi_device *spi = to_spi_device(mux->chip->dev.parent);
+	u8 reg;
+
+	if (state == MUX_IDLE_DISCONNECT)
+		reg = ADGS1408_DISABLE;
+	else
+		reg = ADGS1408_MUX(state);
+
+	return adgs140x_spi_reg_write(spi, ADGS1408_SW_DATA, reg);
+}
+
+static const struct mux_control_ops adgs140x_ops = {
+	.set = adgs140x_set,
+};
+
+static int adgs140x_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct mux_chip *mux_chip;
+	u32 idle_state[2];
+	u32 cells;
+	int ret;
+	int i;
+
+	ret = device_property_read_u32(dev, "#mux-control-cells", &cells);
+	if (ret < 0)
+		return ret;
+
+	if (cells >= 2)
+		return -EINVAL;
+
+	mux_chip = devm_mux_chip_alloc(dev, cells ? 2 : 1, 0);
+	if (IS_ERR(mux_chip))
+		return PTR_ERR(mux_chip);
+
+	mux_chip->ops = &adgs140x_ops;
+
+	ret = adgs140x_spi_reg_write(spi, ADGS1408_SW_DATA, ADGS1408_DISABLE);
+	if (ret < 0)
+		return ret;
+
+	ret = device_property_read_u32_array(dev, "idle-state",
+					     idle_state,
+					     mux_chip->controllers);
+	if (ret < 0) {
+		idle_state[0] = MUX_IDLE_AS_IS;
+		idle_state[1] = MUX_IDLE_AS_IS;
+	}
+
+	for (i = 0; i < mux_chip->controllers; ++i) {
+		struct mux_control *mux = &mux_chip->mux[i];
+
+		if (mux_chip->controllers == 1)
+			mux->states = 8;
+		else
+			mux->states = 4;
+
+		switch (idle_state[i]) {
+		case MUX_IDLE_DISCONNECT:
+		case MUX_IDLE_AS_IS:
+		case 0 ... 8:
+			mux->idle_state = idle_state[i];
+			break;
+		default:
+			dev_err(dev, "invalid idle-state %d\n", idle_state[i]);
+			return -EINVAL;
+		}
+	}
+
+	return devm_mux_chip_register(dev, mux_chip);
+}
+
+static const struct spi_device_id adgs140x_id[] = {
+	{ .name = "adgs1408", },
+	{ .name = "adgs1409", },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adgs140x_id);
+
+static const struct of_device_id adgs140x_of_match[] = {
+	{ .compatible = "adi,adgs1408", },
+	{ .compatible = "adi,adgs1409", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adgs140x_of_match);
+
+static struct spi_driver adgs140x_driver = {
+	.driver = {
+		.name = "adgs1408",
+		.of_match_table = of_match_ptr(adgs140x_of_match),
+	},
+	.probe = adgs140x_probe,
+	.id_table = adgs140x_id,
+};
+module_spi_driver(adgs140x_driver);
+
+MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADGS140x MUX driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

