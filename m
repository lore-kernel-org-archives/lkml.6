Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF44C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EC821735
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="vhf/zzWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EC821735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934922AbeF1MPP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:15:15 -0400
Received: from mail-eopbgr690060.outbound.protection.outlook.com ([40.107.69.60]:38016
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753101AbeF1MPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y0rE9VCFJk2PjX3vkAFdiOFUDCK355NKAAgQnvyvvg=;
 b=vhf/zzWs5nSp6PAUK9XLJkiNcq9YiunQnHpnXrCNjXDr1qcAIzp43fX/7oLQIqPnqF4ualltpzgA1RzENVybJ5HjlQ8dvIYJI++vadOcOqY7q1P2Nxg3dJE/dJNJlCiTVscCnu7ZUmQWEkWwG/VOfBROAxvfPxRSHtuTi3AetvU=
Received: from MWHPR03CA0044.namprd03.prod.outlook.com (2603:10b6:301:3b::33)
 by BY2PR03MB556.namprd03.prod.outlook.com (2a01:111:e400:2c3a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Thu, 28 Jun
 2018 12:15:08 +0000
Received: from BN1BFFO11FD012.protection.gbl (2a01:111:f400:7c10::1:168) by
 MWHPR03CA0044.outlook.office365.com (2603:10b6:301:3b::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.884.21 via Frontend Transport; Thu, 28 Jun 2018 12:15:08 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD012.mail.protection.outlook.com (10.58.144.75) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.820.5
 via Frontend Transport; Thu, 28 Jun 2018 12:15:08 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w5SCF7T6006942
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 28 Jun 2018 05:15:07 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 28 Jun 2018
 08:15:07 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
CC:     <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v3 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Date:   Thu, 28 Jun 2018 15:14:33 +0300
Message-ID: <1530188073-28362-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(14444005)(2906002)(336012)(426003)(2870700001)(966005)(5820100001)(4326008)(7696005)(50466002)(5660300001)(23676004)(2616005)(476003)(486006)(6306002)(107886003)(2201001)(126002)(44832011)(6666003)(7416002)(246002)(356003)(106466001)(47776003)(305945005)(106002)(53416004)(72206003)(316002)(478600001)(54906003)(50226002)(8936002)(7636002)(186003)(77096007)(26005)(8676002)(1720100001)(6346003)(36756003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB556;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD012;1:ctD+KYAgP7gx4BiMzqSaxwRIBQKrrBodkCoL8zKRCtmakr++w9CtcZw8pMt34eY38pbDsHQwG0+gLRum07ceBnf80cwR4NYNgVY3XKXkrBR2eXt+Oa1xYncifapRCR8r
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f3d5321-8cf3-4690-beb6-08d5dcf0ca33
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR03MB556;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;3:YHkLh5YJS7EJ6qzJHCUpuluJyOZF5lUND5azOC3AZYkgbo/RUXVkx5X6gr8wt/4zYOluZwBqVXd5LGeoIs1Uq8DZAby7rYGK2HNLCSOcAJqASzsMi3rSUU51pvZbtq/KYNYyMw7NyWI9kMprcQ7ZgyTunbMKJ7KWF4Bbd47CKZ9zpknKEgw06dZDRAt7Idv6ZDnDd7Z3fkxQDKod8VW1QzWstYD/LYTs/JgkhOU8C5fmIBw7W5pJgq09mmYcCVCqZfxosXobqY1o09l+oQU1GVIdHrdYlAVzoYv9QBVrYBm9x5ElrIFRl0ggcGzw3MjwSEH9/bznAPiFFqL7J1p+SU2M8vbukyonxUgSLApal/8=;25:yotoraU7Sahk5gXedbCTytayZoQJPViN7MdSW+TeEEsR5oe/+u2pUjn9rnr0hcdoUyO7RYk8dYctWgF3//QY0W33hSkOoOK/c0iOdtfI967LGCSlmOW5SQAn5gUspgWHMBJzd+6/F27gyAQ3rjVDCH2DA+ihgdLwt/E3q4t5a8XwIa7MIRFQ5WcKy4LZeFA/qJejOULDlKRLJ2+1DF0SAi8rYdqal8YRIgzfH0kOKZlxFuZdZ70YOQHd7ei0+BR25REg8qRRYwY0cdYMR++7DRCvBuQnnwL5NeiqUQyVY70sbJGbo49tHUzG1kemHtWnVgPT2BS1SHUOkxEfBomTcAFS3F7Tdw6hXAkO7QkXF78=
X-MS-TrafficTypeDiagnostic: BY2PR03MB556:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;31:Zjx8yQUSCbGKqm16irwtJl2BeQ42OJ9OcqBmKuStDU2m2RGb+qwHxTv6woLq3QwNmr0fkfcoSvPY8Q/y/WUVEDhEowwEPvw9WJxZpl7IxBe77AQbR4afatyxF/zEn411t479TIUeOQ3oItk7yTJK2W4LLdso4yx9MJuowNz05c1duqmx9vlZw+TMlD1WiX757pZogd+sJTNIxfWm3zxuJ4QyHr/2+/ZJ8OJkQg1IrPI=;20:Tj5HbjkJZVex6jinzYeCBK34awNodUemFN4Zy7hFLe/ltRFP8e096ZDiUWQCzj55jovs5R5CbrRk5ahOCB4/ReIQ4w++c2PNto73E2dIWM0kG8uzryTZ4q77eGqN5JFHTZUOmzVN9eL9u3eZWOSpHA/e5NhB+NN0Iw/DsfW3sC64D78NWatEq+k/CiBVnBHPqZVxyRZPywR+GQmejJRKtGOdvV8m+UFZssrL2PhACPGbPF+pIYpM0pbajnXaC8k3mIfsBD/9DHRTgVrsq0Kjk88D4nfbHlWfkPjexLkiLVZXiN+Uf6izcnt6qqSEjAHAfyo7heEk9L9X8u026fztg+mi2957LZcwkjMh6aIkywFsKYLqtbGrITNz8GGgU0DA1/ujTrenMax6nEGR3fb0y9C5J3Z/5cKbM6axlKHEJWUYudiTYf9wGB6c+X7gXwgrAjFugPJ4FoRRkd34wrfbSTd0tNgrpElA6cymJ63puxxGUWjzyPcYOaBxmspwlhVg
X-Microsoft-Antispam-PRVS: <BY2PR03MB556FEBE3E36630421AA01B49D4F0@BY2PR03MB556.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR03MB556;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB556;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;4:w56gm6LMIbyRVz/6G73N0EF2toi0GeSw/BxsEbfyVRnDHc/z9TcMGM+rGxcrBS7k1cVZlrROYx/91xxhMBy4VbEpp+QzNLbEXjnJX7zp/9e6dc2QPl1g2HR3TNVK1Cv+myPLbcfhBohfI8n0IOsrJS7VePVQ3rdKuDeHMM4r635bNymtVlYB6vcqBHIo67nYcHSNNqqPrW0I5lnbgiwUjz5GQECSjifdEvH+t0YQyb6c4AVpCS0xy4XIuQ2/8A+zuZzNuTjI622kgieh3IKowgeE6nNLo4r8AOWtjJZB/iV+BqNc+yrSW2012XSSruPEjaIlMfYswp+NDMhN3gEJNZR3cyci9pH/wtz4xLnSrS4Y1KV1iiY7JRgkCAKF9sLO
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzTUI1NTY7MjM6Yi9FcDNUd25oOXErdWx3MkdiYzM5QnRXS2lP?=
 =?utf-8?B?amF0OWhUanlBSjhLNnJlZDhyK0x1STJVWGFRKzNWRVhVSnk0NGN5a3IxeVpF?=
 =?utf-8?B?MlZNYnhJNnBJMHhFNnAwcVBXaWZHalJOYitxOTc3Z3FWbUpRQzFmQm1xMGJm?=
 =?utf-8?B?STJQSkVna1VQeUU4UGNRcjdLM1I4TnVoSUJFL1c3WUNCdmZiVkpsRGZORWxZ?=
 =?utf-8?B?Sk84amtZMUZ3TjNpSXdHblgweTd6azVWZUFQQ1BvSStMWFlwTmZQWjhMRGU5?=
 =?utf-8?B?ZXdxTU1WY2NvU3orck9wckJieU1EYThZaEhheG1mVmx4NC9ua0liajFPcnlY?=
 =?utf-8?B?TGh2eVducjdtV2YwVnNqWWc1VkJUMDVDTjNrUGJsYlkzZzBQYmpBV0JySU9s?=
 =?utf-8?B?RG81ZzBpcDkzOGw1MlRqeWxpbzl1QXdpYzVEVURYdDcxZVkrMnlNa1U2cndo?=
 =?utf-8?B?aVhnT0tNcDlhdW1RVlN4M24rWEw1UmV2aGd5OFV3VEhSL2pXdWpVNWRqZU9x?=
 =?utf-8?B?K0hIVE8yUHZ5YjlvaGpPeVp5T2JITE5UTjE5VTdOZDhTMlF6REc5VHV0SFkx?=
 =?utf-8?B?VWpFWHd3S0tNVndTdERWNnBYUG1acHVoYlo5NTViajJtcGxvMllLcVZhTmcx?=
 =?utf-8?B?N3dOdEdlVzZKaWJXWXdsZE5DcUZnZkNiajB5SVlNUkREdldaRnRKVU42OGxL?=
 =?utf-8?B?aEFhTjNZaGEzZEQ5U2pYb3VjTjZjUWdsaC9KdEt3ZkpITFRUc2pzN2w1NWJD?=
 =?utf-8?B?eTRwRHl0Y2V6ZWVZQW1JNGdYdEovbG9vcjV5a3B3UmNacWY3c3lORlZWK3Uy?=
 =?utf-8?B?ZGE3TFJBVTg1cVYyZnRmS2d3Uy94OCtGNldSR05GZzlneFBBY1VtRHZpNlcz?=
 =?utf-8?B?YVM3S0JxazRnNGNDNGJXQ2gwVFdBTFlKVjBtc0hWcUV4Um1CVStnQVRxT3Zq?=
 =?utf-8?B?Nm5kbG53N0hTOHVZaHE5bHQ0cU9za3l4emtqRVVvYXNVZU44cER0Y0RhbEJW?=
 =?utf-8?B?Yy9tNC9NY1QxZjUxdHV2ajJmbTFLaXFDMGZtY1N6aFB4eUdJeTBtS3F5WUxK?=
 =?utf-8?B?a1BsV3dKN1pKeHVEbG92SU9SVnRCWGMxbjRQcVhLTjNCUlptWjBqQkx0T3dL?=
 =?utf-8?B?U1lqSkRISHJzM240R2Rac1pTWCtZVHI1TVlPRkdPNm9JaEFSNE5EMmtOUnlv?=
 =?utf-8?B?MkQrN3I0M1JSL3E0cmJNZkV3ZDFldkpneSszd2NSeWtFUFhDV3dTUXdIZUVL?=
 =?utf-8?B?Z3JkR2RYaEtteldYdVpBTnNCYnF1RHlBbXVIK2wzK0hZOTNZaXhTVlJMazNp?=
 =?utf-8?B?RzhZQnBQSG5sTGRzN2dVUWpveGxlMDBkSFVpK1ExVFNnRlFEd3pFSWcvS3VF?=
 =?utf-8?B?cHRQRTUvT0tHL3BpeldCeDZJa01aZG9EdCs0bXNLMjExUkFqcVNzdGhmYzBy?=
 =?utf-8?B?M2tXK0s4bUpRNDUvc1UxVysxZllQRmZtMGJCM2NQWWNUMUdnbUtteHlHRktY?=
 =?utf-8?B?Y0lYbE5aTFh3LzF0amZqZjVveTFzNEhnbnl5ck15YkRxTVRXa25pOTgrbisy?=
 =?utf-8?B?a0JRcWJoMDV4RVVmbThYTTRQM3ZRZz09?=
X-Microsoft-Antispam-Message-Info: fg7jB59a4bQ5svz1wUUbn2Smk9EgqimD0UFTio3MDmWdHqfS1QY+/+Jn2n+r3yEQ2SNs6fXD7rAsv2DHZa3RZMCxqTUG4A+ZKSTF4QZ/CfAMp/laFm4eDP7xgccK7x/0K8UE6GdyVhrXSMz3uDRkjZS2t6cuijyYCimIHX1agOvWuYVJZdBRZCOPTKzk05GWEI16ezje/wLSFSpyf9bZERoP3tWMxHS6uuQTXpAPpR2oexoSBP7w/J1nyCsQkL/WsPoicynO2jcU8p5BWhYGPk4s5k90YC28c4JTlEHHWKF38d2gp5JN+e/5pEVrIGuLi0q+ARzl8Gd/ci21GCSeEbwNJE4O/yjxeUTQONooxEs=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;6:sU9szWw2blg6wHW/paerx1ei0IW2bh0FNBfmdcvDZhBYbUaL+FcVQbNLelaH+lnqIrYpuPMM9TvtOgEKh4E6go3/hH+sDJRCVxH8/pHbpYZjv7EL1S58FvP9qUJXnImcfqCmPgBMYgOxwOVaXGATp+RKOoDjoJmpOpgHDfwHik7pnAtHuWbXD3Geb9MJd7yBO/oV9aqQ17fNQFAXaDkDs+2Ej3cvN3q+orLk5VGdiVZYhN8ioHV+kkriQ8j+0+viITEiW7ju1XmIWBVGbaXb5+n/9pUUGArza679ZQk+e554Y40epy/2uZSiQoYRaqW7jssbgmXJts3h9sxEXze4vY2WG507pv1lrd5ZnMX+WItjmMggVbwHa32jPCR5Ab4WJ9o8WeAFZpYo5nVzU6usAKNiOUNDixn2fJHq6bsCWRKAB4nlro47V3B9ToUNcOoBg6MqK1zdiXgM1dTmSxHTgw==;5:LkN0KTB0XvcPLluMC1zImSzPcJ7NQlxgxq6JglPAnmd9ovi5OUYGIxYT9WzmkzTqdCf2NWNgpE1V0kbHY0Z5ZFn6IrkQgXzHvgtcOa6zDr3jeKWCEnuYZ9xpdlFHmaD8kSjHKtSQ5CwjG3XyoQiOR9vz9bkIvCv57vZFZZ+jK7M=;24:EH65UTg2A1IjTm39R5rb2DiRdaNaOkkpHBbdT0MVWw07zMg5xbmChtBsexuIvpeSzoG4l8501pZpvFEh+NYq6zc7hft/rQb1DnTwrvE3ey0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB556;7:0YvCE4Zy7IaZuesxMSOX0to+3Ctt99DjVXPJtHWJYauPQxdSSXQO9rY/OKyrjbMq0dwL1x/Vmjzso9QutU3o+Sh0yN0or2K0jvjTkMOJJCLyK6py2X1tdvicW4kDyKmwPUE4WkK2l8Nuu5jp6rZ4DmPFnx7SYB2qjPZAQopSu4Trq1vJye0oT4Pkr6Y2S3ASC0SgeAjxVk++CCfJTlMlG0ewkYKq4v8DRpgBa75ROh4LbFQlbOF4AJogAr+p9zNo
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 12:15:08.3259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3d5321-8cf3-4690-beb6-08d5dcf0ca33
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB556
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v3:
	- AD5758 can be both a current and voltage output DAC. The
	  decision is made based on the DT and the channel type is set
	  during probe.
	- range was replaced by range-microvolt and range-microamp
	- dc-dc-mode, range-microvolt and range-microamp are required
	  properties.
	- Introduced a slew-time-us property from which slew rate clock
	  and slew rate step are calculated using a best match algorithm.
	- Added units in the name of the properties.
	- Offered more explanation for the various modes of operation.

Changes in v2:
	- Nothing changed, just to follow the patch set version.
 .../devicetree/bindings/iio/dac/ad5758.txt         | 73 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
new file mode 100644
index 0000000..797df9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
@@ -0,0 +1,73 @@
+Analog Devices AD5758 DAC device driver
+
+Required properties for the AD5758:
+	- compatible: Must be "adi,ad5758"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use (< 50000000)
+	- spi-cpha: is the only mode that is supported
+
+Required properties:
+
+ - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
+ 		   Dynamic Power Control (DPC)
+		   In this mode, the AD5758 circuitry senses the output voltage and
+		   dynamically regulates the supply voltage, VDPC+, to meet compliance
+		   requirements plus an optimized headroom voltage for the output buffer.
+
+		   Programmable Power Control (PPC)
+		   In this mode, the VDPC+ voltage is user-programmable to a fixed level
+		   that needs to accommodate the maximum output load required.
+
+		   The output of the DAC core is either converted to a current or voltage
+		   output at the VIOUT pin. Only one mode can be enabled at any one time.
+
+		   The following values are currently supported:
+			* 1: DPC current mode
+			* 2: DPC voltage mode
+			* 3: PPC current mode
+
+ Depending on the selected output mode (voltage or current) one of the two properties must
+ be present:
+
+ - adi,range-microvolt: Voltage output range
+ 		The array of voltage output ranges must contain two fields:
+	      	* <0 5000000>: 0 V to 5 V voltage range
+		* <0 10000000>: 0 V to 10 V voltage range
+		* <(-5000000) 5000000>: ±5 V voltage range
+		* <(-10000000) 10000000>: ±10 V voltage range
+ - adi,range-microamp: Current output range
+ 		The array of current output ranges must contain two fields:
+		* <0 20000>: 0 mA to 20 mA current range
+		* <0 24000>: 0 mA to 24 mA current range
+		* <4 24000>: 4 mA to 20 mA current range
+		* <(-20000) 20000>: ±20 mA current range
+		* <(-24000) 24000>: ±24 mA current range
+		* <(-1000) 22000>: −1 mA to +22 mA current range
+
+Optional properties:
+
+ - adi,dc-dc-ilim-microamp: The dc-to-dc converter current limit
+		   The following values are currently supported [uA]:
+		   	* 150000
+			* 200000
+			* 250000
+			* 300000
+			* 350000
+			* 400000
+
+ - adi,slew-time-us: The time it takes for the output to reach the full scale [uS]
+ 		     The supported range is between 133us up to 1023984375us
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
+		adi,range-microvolt = <0 10000000>;
+		adi,dc-dc-ilim-microamp = <200000>;
+		adi,slew-time-us = <125000>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 12d102d..60b1028 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -802,6 +802,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/dac/ad5758.c
+F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 
 ANALOG DEVICES INC AD5686 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.7.4

