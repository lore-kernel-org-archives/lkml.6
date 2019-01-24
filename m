Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D4EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A0A218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="z8qWe5zT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfAXJvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:51:37 -0500
Received: from mail-eopbgr780085.outbound.protection.outlook.com ([40.107.78.85]:47552
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfAXJvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ7Wan/jMWADw3k3x5OzHA60v7pd78F8SDhLDyZPNe8=;
 b=z8qWe5zTbyC/Fk5H9CbceAucOgicf6Gjpu38pwdoYuFFV85yKoRAGoOGXpoAL9in5MCsmdZREbYLLlFfbhu3jvPkNq0vktNT/pGeSRVGC4eKNZuvcVovWXq2t8/PL+wYwfovHpW3EuA4DE6HQcLYp7RbrFCnKoxwNZHlz5rnTEE=
Received: from MWHPR02CA0051.namprd02.prod.outlook.com (2603:10b6:301:60::40)
 by CY4PR0201MB3507.namprd02.prod.outlook.com (2603:10b6:910:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.31; Thu, 24 Jan
 2019 09:49:41 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by MWHPR02CA0051.outlook.office365.com
 (2603:10b6:301:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.17 via Frontend
 Transport; Thu, 24 Jan 2019 09:49:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Thu, 24 Jan 2019 09:49:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56309 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gmbdk-000068-7s; Thu, 24 Jan 2019 01:49:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gmbdf-0004AF-3n; Thu, 24 Jan 2019 01:49:35 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0O9nPIv002350;
        Thu, 24 Jan 2019 01:49:25 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gmbdU-00048k-QI; Thu, 24 Jan 2019 01:49:25 -0800
Subject: Re: [PATCH v3 1/3] firmware: xilinx: Add reset API's
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <jollys@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
References: <20190125074654.10950-1-nava.manne@xilinx.com>
 <20190125074654.10950-2-nava.manne@xilinx.com>
 <1548322989.6014.4.camel@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <e0f6e1d3-e443-040e-8c07-79359e2af37a@xilinx.com>
Date:   Thu, 24 Jan 2019 10:49:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548322989.6014.4.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(199004)(189003)(336012)(58126008)(6246003)(478600001)(2906002)(426003)(36386004)(50466002)(110136005)(106002)(39060400002)(8936002)(36756003)(64126003)(9786002)(81156014)(8676002)(230700001)(305945005)(316002)(81166006)(65826007)(65806001)(476003)(65956001)(2616005)(11346002)(47776003)(126002)(446003)(486006)(31696002)(2201001)(44832011)(76176011)(186003)(356004)(6666004)(23676004)(31686004)(4744005)(2486003)(229853002)(63266004)(77096007)(26005)(106466001)(921003)(107986001)(5001870100001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3507;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT023;1:8KvlsyXk7vyBtiT9kaWvdm6vZSBKEL+7KX6vZStL1ZJVhR5XKLeTq6t4EyluLU3aI3o32IEg+40DziXlD1MNzxhgDaUGBZFtIWPHGkViIy+VF0nYNj4KdiVqoHSdAUpl5YtRODcUkm/0v+4L4t2sEl0A1q3nsZxdUqwWZFRX+6Y=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97707355-646d-4abf-9efd-08d681e142e4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY4PR0201MB3507;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;3:HY51p4LARC3kqJ1YDWtp9JvtMawcAha7OHR8BqVKjlJSJ3kMUWUydV6OV8aQ0jLDlNAYMGvb7x2H7s6Hu1Ty1CFAe1G4r0OaYsrPJfjIgEVyHk8smCYPR4j7xo+DscjriHI1bDGmSubWMAd71vuaqZ9dEap089rUP5Bx2HR+fbBTHnYnlraures9ShKE+K2JQx/V5rsLsrm8n7J79uHfkyV/jOmI5xDxkShI18h8kmDQSvwGVLnMSl4jVgey3Q3JKyXe15FqXMRHnDgKyFFFZ2QskObuUKiJM+HK8HQJBmGTQaH0KBcRjGYxlbp8CY5/VfhkcLOjh31C5f4nhTtYyY5zugHmLfPL0GzPO8t+brczlrybV76um8GtAlVbyXND;25:BpDYwvgmfcI5042bLJXm1oISFde+AFv/aYYC6WNB8djBrKZREFX18q4xKG24zdguD/OZpQfldaGKTfMTb0Jm9jGnMFQOM+Js201E4NH6DweTFjBhNZb1XjlX/7UMsyHYtWcN1Hv2u5Q+BcBgRk6QqVQWQASuyiGHLGgNJ3Q5gxdCwwV0SCm2QyFt81uiEHhF/URbPGM97NzMd3dZKhsqrdOQXiaNnDKfOl+Z4sfhdLMX0VooFk0nfqI9FBTAYHojbW0X3iGkyAHVgobtRZvCh1FlO9ivhFiOfDhzA6BQuaXDML7eFFihDFLE3+FRd0WT0TRr0+5uhDMsJAXH5+zIWg==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3507:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;31:H1ffmWsSTDm3hR0uQNhLi3eZBP/GGdaxXPVCvjFC8AEmdarWbdqSSeHkOx8QjRfRNgZ5GfO7X/SaE10Tk+R3ARZPzcSiEhHA6aueBTdJL3OesmrZJ+CIbQN9Mj+dyHb6jpaHJiAEni3QGggkUaYCImGN+Uhz7znxdTxMxxECqAfZQKQ39lmfKxFVlHSYj2/w+6FfvEa8dN6E0opyDUFSnT2F966Qi5rrmA0Wrz3StVA=;20:LdvrfR1Z7M/NZNI9pIAf9wLiKQD+k684JUb763YP6s0eCtIHymsYev/zxrWLnDIEBAwsocAgsZiFVa4jwbFXefR0GFuaNN6duzNCjip2xd4TxtX90yK7vxaiP0GM7VUiX7i4yz1Gt13A7iWvIA6pEqHjkdu4wEd4iXaUudu9rY0sBleOyH86Gbso62FrXL/2hrrI5ZedlVrXy5CuD/OyOksRBpSfxyV0q9aWh04As2eit7XXa2rgx+wPWJ4v++c33FvbxzsSed9bIHjDukVwkPHJCCs/2B26SGA2nIJyhenRN9ZfX50gKvFRmsJsRJb7ukxGIgVxG67m63U+ja6J+p5oHW3O6pz62Al3iHeJ20HJzSNkFQK5kDufEyscAzH5N+trFRTi27w5Zxl9bz5d7Wz1mNIfEG2C4JtzaLf0P6MUsFuMntkYEoQCmgROw2BtiuVRd6HboK5KIfMYde9XK9aJJAX6ACHC6/j73ZRBVMIHZUIhiqMSaN2MumAdUe4p
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3507656A1C8AA70590470A77C69A0@CY4PR0201MB3507.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;4:0goI0nw7ssblWYdKxu9N0cMeGagXV65gkuMco/fugceoT2eV5Cdy/ks+VD5uK4qaeRjOLWqzENbKRCOqkRt9m3iVph8kIpMzZmnZBEnD2RSc7YOBhdHtCc/23Xo3eX7OzaRhuWwe38sXMY6xbwOEiYKxp2n+4Xy3JIgInEJ2k9u117ahT1OsV/z/29DHeRdUqZFw6ehzdKQ4KCahr2v6t7L4Dq8ZgvS6ujv2jDQfnstA2AsI9pY/4dn4o1PmYaqYQNwDkNeuIdo/lk9TNu2UvKrFW2TpPKRbaeyqjz27ydA=
X-Forefront-PRVS: 0927AA37C7
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyMDFNQjM1MDc7MjM6RWRvR29hOTRnWVFRSzZZbmlsUE5uQ285?=
 =?utf-8?B?WnVucHBoN2NPZ3d3ei96dHZKZFh0L1RjU2docHVYNHVMb0VlaEtLVDRyM255?=
 =?utf-8?B?WHhYTTEvREp0TzQrejlTNlR3T1BlMk8rZFpKeGVzQ3ljekpqOEtFNjBWRnFN?=
 =?utf-8?B?VW1aN1lqMStOeHJ3K3RKa0JaazRRV2dCUzBZbFhRc0Y5YkQ0VDVOcVArb0x0?=
 =?utf-8?B?eHVkVGNLc0psd2M1OEtHSDBULzhVV3Fud3dhSWphOXo3bWFOYUFrSWhYL1FE?=
 =?utf-8?B?SW9BZENHK3dxVlZicEs1eW01VXh6Uk9CS2pCVUt4QkNLaWJYSmtXaldiWVc1?=
 =?utf-8?B?V01sbzkza04wY2t1ZjV3cVpwV2F6Wnl6ZittZTAwUkxreEp2TUE5aEsrNmJU?=
 =?utf-8?B?TlBRS08zMlZZSGRTa2Y0N3FFbFNBL0N3cGpOTmhvVG9qSTExaTNjc2pHZDlE?=
 =?utf-8?B?STJ6cnNVYWRDbWQyOUJqbWZIakllcDgwQlhtbWtHMDlaT3kwcjRLTGcxcVVq?=
 =?utf-8?B?c2ZGNHdFN1pkUWIrMHVleGdJaURCL01CWEYxYnh1WHBZSXVja0NHaUNXWHc4?=
 =?utf-8?B?aFJsTEUwZzFuK1pUOTZBWms5cUEvcEl6OUZtMFZnYVQ1QjAwT014ZVRWa1N0?=
 =?utf-8?B?THU4Qi92QU9sRzNuWkJDVTlhd3JQdHgreHRjU3Jwc2VrU0ovSVNrbTFuZ0pV?=
 =?utf-8?B?SCt4ckRQcXVBL3phZGg4M2NEK0Q2U0xFNEpuMDlyOUJNeEQxWU43V1Bkb0gr?=
 =?utf-8?B?Z0V5dUhGMitiWWIwQndudFE3M0h3WlNPY1c5V0xzMFh6WGVWNFcyZFJTa2s5?=
 =?utf-8?B?dkhqUW5IRjk4UFAwRHdKK3VVYXFyVTA5ZWo5WUcxbHBXU0YxU0swVlRlY1NV?=
 =?utf-8?B?dmZKRVhMVytnc2QvcDJqczVNZTJSeG5WQ2FhYmErYVQ0L2Nia0ZOQ3paUTI1?=
 =?utf-8?B?M24zWjB4U1F3VXJwVHJ2MG05bW9QOUJGUHNXMHlJc2l0UWhKVTdQaDBRNDcr?=
 =?utf-8?B?TERaVVUzVzlQU202d3prY0g5b3Mwdk1QSVdGL2N0VHY3WW1nTUgveXFHaTE0?=
 =?utf-8?B?MGVGTVRvTG1Da0JhZ2prK1ZFblQ3dEtqVEtVelVzRWlRbFloY1dLUjN3NDY1?=
 =?utf-8?B?c2I0SkFqK0k2bkZrYUZ6RG5RNy9xWmorbUh3czhsL2YvZkNLYyt6ejZ5S1R0?=
 =?utf-8?B?Nk1kaXI0QjNQVURJc2l3d29STmlXRnU3amg2RWFrYVRJUmt5UnVWakwzeEhG?=
 =?utf-8?B?U3pSNHN0NzcxWXJlTEsxVG11MEEvQlZ0YzM1SUlBWjJSYk50eTZ5TEFyWGRl?=
 =?utf-8?B?Y29uSU1PTTlQSCt1NUgrczZNcEZZM3V1YTNTaXQrSys0UDl5TGo1cVA0dW5W?=
 =?utf-8?B?RWs0Mk5ueW1JZDgwcncwMG5mTitxMmxhWGJUN3NISEJIdHp2R25oSDFHVytZ?=
 =?utf-8?B?M0QwaWlqL1JCNW9HVzNLUFVJWXozMmtGV21UY3NsV1dibk1iWG1wV1JOb1d6?=
 =?utf-8?B?dUVVdndya2Y3UGQybWJHMFVmZnp3TUV3aUhaQUtOWVF0b1IxemtuM2tyNmw1?=
 =?utf-8?B?WW1TSGkzeHMwSTFOMTlvVjI3dThkUzF0R2lza1VGN25PTXJWaDF2ckdOemR2?=
 =?utf-8?B?eG5rejVYZWU1MTZJMkpHRFJGaGFFWkJHMVladnZjYjNJYlk1Y2VLZ0VlYzhL?=
 =?utf-8?B?b21CODJmN1VWMlBZSFhEeU5Zclc3L2JsaGlVUUpuTTBzM0NVS0tmT3NjQmQ4?=
 =?utf-8?B?SDdYVWpjYmhQdEFJZUFYT1QxU0gvWVdTRjFueUZtZ2xZZ3A4T3BXYkw2TjY4?=
 =?utf-8?B?OGE0Z1ZOOXMrSStSRW9tMGcrWCtaSW9wWFl3aUkrdlJaekJOUT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: QSOLkUfOjvPEfxMzhUgEUgVK7rpIbFHG5EALsz1brRtEa5aQZB8czeI04dXpHLeR/vzAwD/V9Oi1a8uar0eikmMjegQD/3BhSxA8LLHGf7kXMRO7enAoLQE4RmLbY0PKdRKOvBRhXXmvziHPlSPB1rx/MCiQdUM3G9i6T8xFRKY6Fr2LZkAFGwUQiDn1sO3ATcCCXyeFEqK0YVkdmf9vBcZmVw3Z6rsIyG/vN5c++qiyVeCx2YnQq6x1OcrP0lz0W8ApUusvriRRMuTm+vnab36abtZeJAzZqfay/kcBNksJTpLbsIbznsrcyKNTh7IAVnxP3+dTuyoqpk9AQXRbvGXtDN+Ic1EQPwhw/3/Z6j0iSBYqXd7XzRM1CHXDBgUbab97u9KeX3L59YUorcFFzCNR3sxiOWc0mum9PLmH84M=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;6:XWQS6qZJgS0paoXv73Hxw0ZMkm4WLJxH7mh1DuZBfReW3lQfz8yejxh2GW1Z1cNlfyofc7tZdfkbzZDIywuPxe1P81A6HAF6JrOsXSYKNFiTrugJvH+ljZmYkVnCA5hLFk1h+ACwb73YaH/W35jetgUEDVZ50w+RaLqXW/pkzATx1RrB6SVq9+Rp7Mm4WvlgfGdTNy6Ztq0KzMqeYrBDhs8iyr1R9Tmm5DGieccDQyrBJNczEg7kuTpcpWiEaCTtactAtBJp/jYQagDA3KDkQ5XZhMIVEtCcUWBSIfxWht5gsI1hzZ2fXisG2fdGgYGAnK8r7kPqvYPSDW3mfVRK5atrGc3GiExDGmKarmhbXFSYwWZIC59ZhvkFbxPCGeXY+yYaWNYkvVLisc9fM4Ct+kH6zJoeOT3d/6qbNkIAr+HBnAFjJjJverkSx5zZo0yespYjuO9LkF8PbJz/NRKMdQ==;5:/QjEPPBC6MZkKY32AueOFzMEMLlbKEPUQIjA1kpPwiIiDNHxoXn3WQ2C07G557WSigR8m2dNpLq24cgL8qIPJKQ5xLKtkF7ujaG669nDi+njuOv2qlGiDueVg2OOrqaPtIi2JujVXP47a7uNdYdQPrrLER/YfWA60wORB2EiLMqQqkNICjLNHvu/pNzv6INB93zmFSD1t4Y3IrNhPIj2aA==;7:mSJVBd8r0cV32Sbe3YuvY34OE2YPasL+6RpFkMIKYJKMKcIofiNV5oVlwAkDTXyEYhCxggLvbSMPrpVMBOYuNySH+ihkrMSmplVFuMz2NtBddOMgYrr5sbEDt9oQz/a86DF1qvYbHoefCoJz6BWWrw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2019 09:49:40.6438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97707355-646d-4abf-9efd-08d681e142e4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 01. 19 10:43, Philipp Zabel wrote:
> On Fri, 2019-01-25 at 13:16 +0530, Nava kishore Manne wrote:
>> This Patch Adds reset API's to support release, assert
>> and status functionalities by using firmware interface.
>>
>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> 
> Michal, Should I merge this through the reset tree together with the
> reset driver?

It would be better if this goes via my tree. There is at least one
series which also touches the same parts in these files that's why there
will be collisions.

If you can review that I will take it via my tree and arm-soc guys to
mainline.

Thanks,
Michal
