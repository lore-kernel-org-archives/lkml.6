Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAF7C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC2726FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Gvbeki5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC2726FD0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeF1GmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:42:22 -0400
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:38352
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751344AbeF1GmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lnsoUPvpDY/8HUan7SHkXqyLABdoVa9AuWevi3eL7Q=;
 b=Gvbeki5cgtOMsH1fxM0y0ChGqLWYoNOo+NTPNGZomi/k39mgWnuau2g0SaruO+x6XuW0NK2s1znkE3DhfcY7t84hoQmsho+/9Klun9m2qT6tHwNdjF23PVroc/FzqWvDjSjwzWir9a3No2uN0TMnZFqvaal2FbXlvASmoamRq/8=
Received: from BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47)
 by CO1PR02MB173.namprd02.prod.outlook.com (2a01:111:e400:101e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.906.20; Thu, 28
 Jun 2018 06:42:17 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN7PR02CA0034.outlook.office365.com
 (2603:10b6:408:20::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.20 via Frontend
 Transport; Thu, 28 Jun 2018 06:42:16 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 06:42:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYQdC-0003DU-Tp; Wed, 27 Jun 2018 23:42:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYQd6-0004K3-CI; Wed, 27 Jun 2018 23:42:08 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S6g03Y028585;
        Wed, 27 Jun 2018 23:42:00 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fYQcy-0004Hd-8z; Wed, 27 Jun 2018 23:42:00 -0700
Subject: Re: [RFC PATCH 5/5] arm: dts: zynq: remove "zynq" prefix from
 compatible property
To:     Luis Araneda <luaraneda@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-6-luaraneda@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <042f6632-f4f6-d278-9859-b8998468c3bf@xilinx.com>
Date:   Thu, 28 Jun 2018 08:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628054205.17737-6-luaraneda@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(438002)(199004)(189003)(31696002)(31686004)(9786002)(64126003)(77096007)(39060400002)(186003)(4326008)(47776003)(2906002)(2486003)(336012)(54906003)(65956001)(36386004)(229853002)(110136005)(58126008)(65806001)(230700001)(106002)(6346003)(53546011)(316002)(23676004)(63266004)(356003)(44832011)(2616005)(26005)(486006)(6246003)(575784001)(446003)(426003)(8936002)(5660300001)(36756003)(81156014)(11346002)(65826007)(476003)(8676002)(126002)(81166006)(6666003)(305945005)(76176011)(50466002)(106466001)(478600001)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR02MB173;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT022;1:N+DBWVE6cFvIRVcRiF4Ds0ar+DSlB67qEBpo05Sd8l/1NVoqUuE6bbb/qp5RU/CmF01m/rr6W5eWNVeJIy1L4ZDMsA+FihKHVGbXvs+3YGPXoetIH6S1XeUiyWVD5w9b
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0294ce35-9e3a-4ff6-045f-08d5dcc2499d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:CO1PR02MB173;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB173;3:yXGADToiV8nCVZ1DuA4ZTTZKMf+o/IK1sZpS+ITGFqx3jrBqgrSyVlgjA/IJsRoRnuZhvtF+mtTGpfNaYI9u6coAvbjbsvXW9oQBVhQ35Gt4F/1ApVqoM/zicMTybHwlhGusVsNQ85hDKR5I1NkdRw/l+/qjr6t5yf0PJLZ0CoIgYPE+cch3Ml/U9qrw0FI1QwOsLUH2Df8zkjhzIYhJ4MLSVMoLXeJQuCSisYyhebZBotZRWGwYIsn6fvFFr1i0xkx5BCEPECHHs0aKVtNyz+gjQR7iAtBQv05gnmvhU5ELqLFnNrk1544beEqDsdTv9Bun9/af48uang/C0FQk/cgQ/CiIUMq6cN4NRp5VDXM=;25:8Uzodzpj1hPfAvMR3BniSB2HHm94US+SyAWByZdAcOi69tnhp1wsl/DYWLKDg45jPMDLCxw4b0iNdl28atnYo/Pw4qy3TYzRj8iHj/R3Z5baADaGRzfs0W6dg9lvNcZrRXNNkBalVqtwNGAxM1/SCG7rvWo2tDbBEZMp69Sj/X73VZfqI906I+tNcPAc1GxjkqV7Sa2jO9L1PtwQE/+nf7kBart67EjclMa4Dui1DP4BIZmobDVhQxT6UK91uBAukF5nfDljJZZfTAOYiccru5B9vKS88LObhs/j1H3813inGOqZLRqPhUjUNPOnnqBnHmYWxVfFfLWXZkXQmMiIhQ==
X-MS-TrafficTypeDiagnostic: CO1PR02MB173:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB173;31:hRio9e5y3UNHWZPe94t8J4QNXRdc/BZ60OYn2YpeMMWSpO8z6FUaKxP6bKMlK0gLe50ZYoB74vcF1vTkovnZHLdWtGMqY811H+sRtWY2KMogEnQIKmmo3GVa7Z6fWc+9o9xB7FUfCNdL8x5GppKm+XLdkd4wK2WxlZJEslEL7iky6QKoxHazbbCfnoH5jvBuJ/IB124Rghew2RislR029XGuMRMG4WSkC30NXDDPXFA=;20:hzzPsXJj/txFofMZYa6UEoZDmKCinZ6VfgGCCI+AufZkxEw1+77F/96sSwQvEGjxogpiQCrXYUji3eZC0laeO7qqp5ZsuKkhV53c4MSQwcEhRon68OXkNa/yY7XoSTdIzIcNVdSbAr/usejbUnOr5Cr3HWH7ISVV7+UJIV3OCZi36OBo1TbDnrgds8zgaVTmpPFUC5fjDabdfOQpaKmJR309lpb1zJUhTlfHf12M8Ni9dOroEeixFMyKVfG0vuJxRLmLmRFj2/DiF//f6ZrF8X2TI5JfiUhPaXn1/l03YEFMsyD0GQ1/YFeFvRs6SQoAxtjIiTWFsvblnbHMAYi9Y18fejr+pZDnMYx5BdjyKJ4eDlR4J0ZfXWH5hbm1TnsOnC6VAJdw6UmdB4avAczQPSAeILjgyKjgNdNringTrawTcwEkLsgO+dbZH4B3jXHk82CNOaNc4Q+PT4RT/W1/RmQ3MzlSbWFpX4UoiXYyG5GGEIbdQjS2hv5LArmvx9Ya
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CO1PR02MB1735016E35D594D4D19A04DC64F0@CO1PR02MB173.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CO1PR02MB173;BCL:0;PCL:0;RULEID:;SRVR:CO1PR02MB173;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB173;4:j5/N07T9fkR3jz3sYd70UWSIVdw9eR0EJPQakna+Ao2toBUz5o54XkA8Z4D1QldYEnf4NtpK3Na+qlS4INbopKqgh9dwoN2qxeRDss2vnK/trtZVy3tk8grbzBuXlml5P03ftUqHWHQS7Lh0o9ppngsSqX5Wmtr0Hs0f8NxqEn1vq4V69G10ett8REc5i75BVk0gJxQlrJSe59om5VC2GyzAmVWRnXpRXYbukn0Y8tgLcFYWQMlUsCaKRzZ4MECBOa7OORxuho4JrzCxzzzwNbB8xaQ259KKAgMeCRWf4WD+4RpkVzs4+Xswli+nlADL
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDTzFQUjAyTUIxNzM7MjM6TXhxV2pBTEpxY3FRYkxSRG02bkJ1SFJXMHFQ?=
 =?utf-8?B?Si95Q2RnaklDWWFZZDQ0MGhoTlFJQ0JXdlZ3N1JpK01iWDROb2xFZUt0NEdH?=
 =?utf-8?B?NHdvWXhDclRKNVVRUDNFS0ZWUTRJcDgzNmUybmxpVEE3dHlxYnNRLytxaU9k?=
 =?utf-8?B?L2J5RUVwQlRoOStaL1FjWG05VUlvZ2xBcDdGOXF3MTN6YjAwOXN6R3R3eVhl?=
 =?utf-8?B?b2pEOUJYemRVa0NzWVkwQ1RYa1pjT2JvVHFjNncxM2FWUHBWOUFndWE4Yjdh?=
 =?utf-8?B?ekZCa2FqYTZkRGZydFhRakNLYTE2c29nZENsQnhjMmRWOFJmNXJVcXFnQlhx?=
 =?utf-8?B?SHpKUk54dUlVUy9TV0lpVWtRZlpURGZQVUo3cTFybDREVmFxOVduVWRBd0lP?=
 =?utf-8?B?UEN5a0JuQm9OL2U1ZlJaT0puR3pzcC9SWUV3R3o2d3VnMW03b1dPWi9TeFMw?=
 =?utf-8?B?cExpWEpxL214cllWOFBjdGlFZHUzUTRiZnlBeXpFNzVqa0lUUzRKdGhFdHN3?=
 =?utf-8?B?dXJRTGlDT0dVL0ZJT0c2MXB1TTRnREhBenNMMVVKVi9Gd25lY252Y0o4czkw?=
 =?utf-8?B?NDN2ZElXd1MvSEUwOUFwWm9Qd0llSGJLUUkyU3NJQzhzRTRNVldRQkZnbVJ0?=
 =?utf-8?B?MUpUM3FGUmlRalBYcDJxTlJ1NUhyY0NDTEVCcCtta2NPSUtqUm8rZ01LMTk4?=
 =?utf-8?B?ZW1lZHNTZFk4UTY5Y2t5cW9ESzJmWjR3RmFsVkhvVW43SDhCa2szc0pFR2Nr?=
 =?utf-8?B?TVA2R20zaVJNakRxT3N3TEdvaTF2ZmZDUDRnUEpOeWMvNXJNSFRCdGlkNXpT?=
 =?utf-8?B?cFlIUVRMSTVBTC93byt4aFppTTFTZ3JxSVNwVnR5cWtxcUk4V2YxaTZVa0xE?=
 =?utf-8?B?dHJ1WXFXTEp3ZDBDUEx6aHd2RTJtMmpFdGRxWmM3cEg1WVppU1RZZWF6a1dO?=
 =?utf-8?B?c0VWZUVLdXA0cmlKMDRMM0F1b0tCTnpjVGYrdm9vMFVZWk9tY25GdzAwQ2JB?=
 =?utf-8?B?dG9BaVVlekFhWjBmQnoyS0IxWG13a0hEeitKaFA3VHYyd2RTSzJqaktoRzY3?=
 =?utf-8?B?M0pRQk8va2VtaTFxYVgyTkRDMTFCOER0ZmhVSWtxM056VkJTM2JDbjFJZDVl?=
 =?utf-8?B?d3grakJvL3JhaXNoa1I2eVVCd25hUzJSY3JSMlEwZHVlTHQxbVVFRWxXN25n?=
 =?utf-8?B?dHg3WEVjM2FOVUZZcDR2TmlnNFIrSE8wNmpwNmVoQkdQL2xWOXU4bFJKOUpE?=
 =?utf-8?B?dHJONXhiV1IxRUo4MTMvQjgvUGN6MWZTTTVQSGZEZHhxSG9LSEkrU0cxcGJv?=
 =?utf-8?B?OHVQT2JNUE1MazR0TWpxRVhBcHRvWjhOb3ZZWUx0ZEYvNkRQa244dDNoRzZx?=
 =?utf-8?B?MDZISXpLZWVVR0JvRlM2MHdyQUt3bHNIcFlud1VpalJoRHdIbG8vT2hIcm5D?=
 =?utf-8?B?MjVuN0RBQm9Wazh4eFFsM0ZqcnhUa1pPcjdzcUFwUWxiYUwyNlYxaWVmUDJh?=
 =?utf-8?B?STFqNndkaEt2UzBmVGdnMGhpL2VtVmV2VmRMVHF5QWsyUW93YUNaSHd2TkZO?=
 =?utf-8?B?RDBRVjh2bG55M3EwWXlhdTBQUVRFOEZWRWplVDd2WmhKWThpemd0UldSNjlZ?=
 =?utf-8?B?RjRxZS8zMVJJdWRkclZTTFZQWmlLY2pzM3R2OEVkclZac3BZMm1uN05WRzZD?=
 =?utf-8?B?MmppUTJUdkNjb09oTTgxamFUTEVPVk0vVmxTeU95RGN5UWh4Y0wyNjd6ZFk5?=
 =?utf-8?B?ZEw3NG9rMUEyanBvczNibzdzU2JteEhiaWo0ZmRkZ21BUUlENlkrcktIZGhn?=
 =?utf-8?B?dHZQVExEQno1bVZiWmtmUlE4ZXRUZElPOFdDejB0UTY0RWhpcGRJTG45Tlh3?=
 =?utf-8?Q?a1sIAzli6M=3D?=
X-Microsoft-Antispam-Message-Info: uSZfaMU17xzbg0zR4OYoSkC8nuw9NuyWH+aoeuEMMiQaJPwQD7Cksi03n75DcIDRZk6RCGCxOTzymZ081clUO/fjhuwr2XlQ8PNNTd5s7ybQzwd1M7ye3mHtD1q+mWtdUMkxuQpkd1/wxm2mq2CuQBkinfPDd17vnERQh2st3kCcRUCJToTGcvnO4UfFEWS6c+ZFy6ClbGPLZiWvqa/YWy8quGmIGD3hTRIhlL4eXqp48bGsITtv3giaTUnVlZUCLqeyCux85TQPr0Y7U9fDkQ6nJ871mCsoccY3ESe/gK874ushFI4GgY8O4Prquj69rIY6rah8oKNjMBbBTybDdgLYZMAmoPdtLIQykWEADF4=
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB173;6:LATiBxive1pMsb40VL5RTdjGvNUe/6IXVXrt/mFtnVlP4pnhf297GqdMF/G0lZTMJ2E3W8JiGPYuBpjPRXABgPKUJGrfwF5pI6jiCK0svasYoDIyIBQOpW4uYuu2VSMs19OQ1QOuvR/NvTTg7pSzer6CQxlvaRMwo1DkTPe7UTiwxBbHkPwDqtq5c0B+5Qp7aq9wl3tm8pGAQanuhcJeidZ+GYcEaYddOhLEqLGU7LsVn+K1F+gEuC++tXvK99tYr2ZSWqSu/IpAaDTm1/N4+c9nCkkViR4E6ECkudwW0S3fj73Xi+ucvy2dHnpkM5CVTpYdxnNAAgPF/5ucGrIiUrxSR0oL33POwoDrO7rMACQsx20vOXUnmPfyUSc7VHqDHhe8z0+wVkOTqSqU4iiTvSJRcXn70/2Rlq5Hb8jE1rU3XVeyyvHZbsPCrsDxFJcsjADGy+cb5vBqsz1BQD5hvA==;5:MGo9uUbbAbHIi7RzJVP02ic9zVpDaVK1mbIZuLP59vjhQ9j/WrwEu75ude1sAl6eAyhEzztasp8SM4oHew/C0JNX5qwktekRNxXQMujWyPI0s6s0kW4ELOZeFNKzabs97GkCw9VMwHdX/+9NibudOaqPdNUuvsqY3bbFZ3s3AEw=;24:4uViMljEqQw566vM3ntuV+OhFuAVrYLraI1csFBfe3AN9Edg5o8kOdCgUDDXLed/8kjkynssMuh8d/gx/BaYTTZSw1UN44E7B4QU50avSM4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB173;7:GgnDh/zFwM41IWQb3n6CUlEzq9i2pYG+i88pKo6+ay1gmkPobMfFz6Cn72CS4qfX5VlG6cMJGrfmplTXkednjW8VnbTlbqA2lt3rWrCJotdt9GuU5jVBYty8wi185c8HQeC11tc8we0B++/BRD+kRFWwMXMAQ4J6bB6HHmGsIkZpKyfwXDAC/IJ6TsdObYJf9sNro7c61cGd0P0euWkNyDDg7YiHPdGiS+8mRVrr6tZvlXNHJ1//wJJS0Av1+J9I
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 06:42:15.5055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0294ce35-9e3a-4ff6-045f-08d5dcc2499d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.6.2018 07:42, Luis Araneda wrote:
> The value "zynq" isn't officially part of the model on any board.
> Additionally, the value is redundant as it's included in a
> subsequent value of the property.
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  .../devicetree/bindings/arm/xilinx.txt        | 22 +++++++++----------
>  arch/arm/boot/dts/zynq-cc108.dts              |  2 +-
>  arch/arm/boot/dts/zynq-microzed.dts           |  2 +-
>  arch/arm/boot/dts/zynq-zc702.dts              |  2 +-
>  arch/arm/boot/dts/zynq-zc706.dts              |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm010.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm011.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm012.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm013.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zedboard.dts           |  2 +-
>  arch/arm/boot/dts/zynq-zybo-z7.dts            |  2 +-
>  arch/arm/boot/dts/zynq-zybo.dts               |  2 +-
>  12 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index d10adc4d0..0785acce4 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -9,34 +9,34 @@ Required root node properties:
>  Additional compatible strings:
>  
>  - Xilinx CC108 board
> -  "xlnx,zynq-cc108"
> +  "xlnx,cc108"
>  
>  - Avnet MicroZed board
> -  "avnet,zynq-microzed"
> +  "avnet,microzed"
>  
>  - Adapteva Parallella board
>    "adapteva,parallella"
>  
>  - Xilinx ZC702 board
> -  "xlnx,zynq-zc702"
> +  "xlnx,zc702"
>  
>  - Xilinx ZC706 board
> -  "xlnx,zynq-zc706"
> +  "xlnx,zc706"
>  
>  - Xilinx ZC770 board, with different FMC cards
> -  "xlnx,zynq-zc770-xm010"
> -  "xlnx,zynq-zc770-xm011"
> -  "xlnx,zynq-zc770-xm012"
> -  "xlnx,zynq-zc770-xm013"
> +  "xlnx,zc770-xm010"
> +  "xlnx,zc770-xm011"
> +  "xlnx,zc770-xm012"
> +  "xlnx,zc770-xm013"
>  
>  - Avnet ZedBoard board
> -  "avnet,zynq-zedboard"
> +  "avnet,zedboard"
>  
>  - Digilent Zybo board
> -  "digilent,zynq-zybo"
> +  "digilent,zybo"
>  
>  - Digilent Zybo Z7 board
> -  "digilent,zynq-zybo-z7"
> +  "digilent,zybo-z7"
>  
>  ---------------------------------------------------------------
>  
> diff --git a/arch/arm/boot/dts/zynq-cc108.dts b/arch/arm/boot/dts/zynq-cc108.dts
> index 8b9ab9bba..ccff20099 100644
> --- a/arch/arm/boot/dts/zynq-cc108.dts
> +++ b/arch/arm/boot/dts/zynq-cc108.dts
> @@ -13,7 +13,7 @@
>  
>  / {
>  	model = "Xilinx CC108 board";
> -	compatible = "xlnx,zynq-cc108", "xlnx,zynq-7000";
> +	compatible = "xlnx,cc108", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
> index 3cc957428..ef55adb02 100644
> --- a/arch/arm/boot/dts/zynq-microzed.dts
> +++ b/arch/arm/boot/dts/zynq-microzed.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Avnet MicroZed board";
> -	compatible = "avnet,zynq-microzed", "xlnx,zynq-7000";
> +	compatible = "avnet,microzed", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index 3f84b94db..bd633a9bc 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Xilinx ZC702 board";
> -	compatible = "xlnx,zynq-zc702", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc702", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
> index a15908cac..f4805f01b 100644
> --- a/arch/arm/boot/dts/zynq-zc706.dts
> +++ b/arch/arm/boot/dts/zynq-zc706.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Xilinx ZC706 board";
> -	compatible = "xlnx,zynq-zc706", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc706", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm010.dts b/arch/arm/boot/dts/zynq-zc770-xm010.dts
> index 0e1bfdd34..21f457656 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm010.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm010.dts
> @@ -9,7 +9,7 @@
>  
>  / {
>  	model = "Xilinx ZC770 XM010 board";
> -	compatible = "xlnx,zynq-zc770-xm010", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc770-xm010", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm011.dts b/arch/arm/boot/dts/zynq-zc770-xm011.dts
> index b7f65862c..e4a0b2629 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm011.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm011.dts
> @@ -9,7 +9,7 @@
>  
>  / {
>  	model = "Xilinx ZC770 XM011 board";
> -	compatible = "xlnx,zynq-zc770-xm011", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc770-xm011", "xlnx,zynq-7000";
>  
>  	aliases {
>  		i2c0 = &i2c1;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm012.dts b/arch/arm/boot/dts/zynq-zc770-xm012.dts
> index d2359b789..d2ee09590 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm012.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm012.dts
> @@ -9,7 +9,7 @@
>  
>  / {
>  	model = "Xilinx ZC770 XM012 board";
> -	compatible = "xlnx,zynq-zc770-xm012", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc770-xm012", "xlnx,zynq-7000";
>  
>  	aliases {
>  		i2c0 = &i2c0;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts/zynq-zc770-xm013.dts
> index 651913f1a..9d6090ee4 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm013.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm013.dts
> @@ -9,7 +9,7 @@
>  
>  / {
>  	model = "Xilinx ZC770 XM013 board";
> -	compatible = "xlnx,zynq-zc770-xm013", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc770-xm013", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem1;
> diff --git a/arch/arm/boot/dts/zynq-zedboard.dts b/arch/arm/boot/dts/zynq-zedboard.dts
> index 540581c56..8a7894552 100644
> --- a/arch/arm/boot/dts/zynq-zedboard.dts
> +++ b/arch/arm/boot/dts/zynq-zedboard.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Avnet ZedBoard board";
> -	compatible = "avnet,zynq-zedboard", "xlnx,zynq-7000";
> +	compatible = "avnet,zedboard", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
> index be40be9b7..bcb633860 100644
> --- a/arch/arm/boot/dts/zynq-zybo-z7.dts
> +++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
> @@ -4,7 +4,7 @@
>  
>  / {
>  	model = "Digilent Zybo Z7 board";
> -	compatible = "digilent,zynq-zybo-z7", "xlnx,zynq-7000";
> +	compatible = "digilent,zybo-z7", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
> index 0439e9f1e..776d3d77d 100644
> --- a/arch/arm/boot/dts/zynq-zybo.dts
> +++ b/arch/arm/boot/dts/zynq-zybo.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Digilent Zybo board";
> -	compatible = "digilent,zynq-zybo", "xlnx,zynq-7000";
> +	compatible = "digilent,zybo", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> 

zynq name here is correct which is saying that hardblock is going to be
described. Without it it is suggesting that hardblock is not used and it
is for example on zybo with microblaze.

Thanks,
Michal

