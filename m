Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936349AbeE0JTB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 05:19:01 -0400
Received: from mail-db5eur01on0092.outbound.protection.outlook.com ([104.47.2.92]:12480
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934567AbeE0JS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 05:18:58 -0400
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Eugen Hristev <eugen.hristev@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
Date: Sun, 27 May 2018 11:18:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0045.eurprd07.prod.outlook.com
 (2603:10a6:7:66::31) To HE1PR0201MB2460.eurprd02.prod.outlook.com
 (2603:10a6:3:82::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:fpgFBPfxFXDk6XqV1rkn4zHknGC7Ar7qv1LKQcGhmJ6xtbYLddZMzfs5XYZakb3tv8vhjYq17+VdKcn7ZFEEUN8i1aX3welGwdxDCU4gQInBR5VsIjNXf4WTzW8Chf8nc/82h0M7VkILAYzsFq/QDv3OeXVmltqLNPaL3fBL24P0OAaAqDUk9EEig9nL5sdUjJ+5EZZZOBF3bHw+uMLckWy+GX6gS8TSjrhgRYQSHRuUG+6nJWXry+NmhqfcSkoQ;25:MUnM8ofY0fHER7VF+DjilRRQo1nXbqJFAAdYCTiyU9eDnklQwaHcWYvG3CeAunqX2m7yMts1mz/LuNhJUWLnMTs55VrjYBRUF5ZUSM8UOQtf06eDlYCbbvAf8NI6I9JPxAZ83AEAL10uC8OG0pUO6j7H1w3vmUZCvzZGghGy78eiDlUa7srcImMjX5PPLCG1Q2kwgO4qyL8vr8Z7/OwcKXDTWAoAKZGjOltW+ShqYyB9wlu2jpG2mGAb0Jd5oqbUB/vbquhDh62fHFqRtdPILJBnS2cAv9+3GDk6qjxAI3uA+92lKu18NJugn76rFxo10bPMgNZkaFmUqiGPh6VUMg==;31:GsDFQ5d4AImXrYJHCxBXuSk7By6LwOQKFPcss9W8l6x42FhLt8fyeKFQ5XANZcWrWYSJqTpX13K05Mkp0y68H3QQTAHa20TFJjM25pIayUJqNfijLicqmWQiCBSDLgknhcy+4IYoV2GrPwfLavKn0HSKLUynjA8fLM2yxo3iLe4m847d8IUSnw+FvMLQRi9H/uDxVv1IHZs+Ixn91bM95Y1yz3GPhXPUR+OZs2DfR4A=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2460B8A34F928CBE1560665EBC6F0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:Pq1zu7AmSBmZkTkRsWktUJKonXP+NvhHNloqIqBOS+MEXh5PGqlJIn24wTduQ9tHgOxK8NX+2/CbzJEvi9NIXhQ1O3oIxqzC54TDdZ7t/5QB+XWa33jMQuLiBTESQSYu6xzmE30FhKqj7LL9G+cHPWKyZmmwvfCYdFyjwhia+94Ju09ZadE3iliKToHaT46XBSV6Vu91vXTF0Ulf1umTz6Zgd1UMnt7fuAz3gLn1B/u7YcTM+ZbIJ27P9cP/ErPL/7LreJ2yLXWEIw+YHQtl1w==
X-Forefront-PRVS: 0685122203
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39830400003)(39380400002)(346002)(376002)(366004)(377424004)(189003)(199004)(2616005)(386003)(53546011)(476003)(86362001)(7736002)(47776003)(39060400002)(5660300001)(2486003)(52146003)(23676004)(2906002)(956004)(97736004)(74482002)(36916002)(52116002)(230700001)(64126003)(76176011)(446003)(229853002)(11346002)(31696002)(50466002)(93886005)(65826007)(305945005)(3260700006)(186003)(25786009)(68736007)(16526019)(105586002)(478600001)(66066001)(6666003)(8936002)(117156002)(6246003)(7416002)(58126008)(81166006)(36756003)(53936002)(81156014)(16576012)(3846002)(6116002)(65956001)(486006)(31686004)(65806001)(26005)(4326008)(6486002)(316002)(106356001)(77096007)(8676002)(54906003)(110136005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NjA7MjM6NnF0MW9JUnE2MG1KVERYcEpwb1ZJT3Yx?=
 =?utf-8?B?UEY1ZktLYk1PdWJWOFBib2hDTCtsZ25kRmJGSEcyMDExL1lmdHBBWTczODlw?=
 =?utf-8?B?L2RoY2hvem9hUnJVRHo3Zmp1SXpyL3pmSkdIYXNSZGRBdktLWXJ4Y3R1dmtj?=
 =?utf-8?B?MWxmbDFOanZGaHJGTEZDaHordCtHNkV0azdMckdVY1lObVRMdVpiNEhoa21w?=
 =?utf-8?B?YWlqVHBaeTV2bzZURFpYMm4vNm41d2E0Y2FmanNmLzB3SVA3Ukd3WFA5cTF2?=
 =?utf-8?B?eHFkQ2luVWtBMUxVOWxUdld5MEVNRC9GK09qV3llb2NHTDFlQkg5cnNFcExL?=
 =?utf-8?B?bFl0SUticUxGcXY5TUY4UkRoTXlZN1ZOS24rVHRLNkNUZmg4U3Npcjd1SVo3?=
 =?utf-8?B?c2hycU94OFYrYjIxUStvY3pLcTU3V3pBSHdiVjJuSFY4dHI1NWlES1preGsr?=
 =?utf-8?B?ajA4NXJpdXhpYllsMTBrazJWWVdFaDFicGlzV1oxbVY2UXhrdksyZlJNUERy?=
 =?utf-8?B?VGdDenZRaEs1L3ZmREt2UW5iZkJzUlRoL2ZWZnJhdFk2M0F2RnJDMEllcXZn?=
 =?utf-8?B?eVQ2MUNLR2UwMVZRd1l2SEdURDE1RmFKbTdGQTIyaUNQRVBsZTV4cUJVMmFr?=
 =?utf-8?B?UFZZRjBSdXBIajdjRjdnY082Tm9GVXpDSFFnUU5JaTE5RnZlb2l2QUdGbll1?=
 =?utf-8?B?c0V1R1dSMExIOU5lN2gzcEgxQ1p1Z2wrMDJFRElQdjNuenlSV29ZUU9tdjBi?=
 =?utf-8?B?UXVQMml2d2VxTUxHMDBCNDRLSDBqTTNrRnJRbElSQlk3NXMzeFo5NStXVkhW?=
 =?utf-8?B?NjFhVm5VZEs1QmhzYzR5aVYrTVd0MnhNVXBoU2RJTnVxRjlSM0IvVGhlRGFR?=
 =?utf-8?B?MGl0OE9mcGtJQmlTdzRkdTBZTEtRZ0F6OXpZLzNPNHBPSjZtQVNxdVlYL3Vm?=
 =?utf-8?B?SjFyYi9kNGFtc2h5dEd0cnQ1SFlmbUZGMzNkcW9vajlOUTNOb0tlSDQwekFG?=
 =?utf-8?B?VjBRUjFkR0h5Q2dDUXFZZzJtZ2doTjBOWTFzbmhoUlNQdWJwdFYvQ0VYNU9q?=
 =?utf-8?B?SjJQRkNLNFh0YVlKaC9zdkZNamRiSnZLaVpWclNSa3BRNStKb085Wm9PZkl4?=
 =?utf-8?B?UGtjMTNZNVZwZVpkSEhNM0VCT0R4Q3A5ZFFYQXFQbE5RZVQ3cUNaa3lMUk9S?=
 =?utf-8?B?Z0ptZWZNS0hzT2Vra0g4ZGVVcDVjcnV1N2p6Y3VQVjlzOTBhcVhvdTg3V0ox?=
 =?utf-8?B?bHpuN3dmdFQ4UDE4K21DZWNaMGJ0WWF0a3NVWnRlYVIrRjhRYzhwRGRuT1pI?=
 =?utf-8?B?clVrOEhrbzNDRE9EM3gxeFBBVUdJSlROZFljc2xzQ1lpeHBSQkIxZUVtcTh4?=
 =?utf-8?B?TTRwTy9Pb01lTEc0R1ptZHVVU1NnNEVlQjlFRWY2NXJOUXRjdERpVUprWlhN?=
 =?utf-8?B?VDlWbitnUVJrVmZQZXdYNHFsZjdNNmowRFY2TXZ1WW5UTkc3N3NNbGFUWEVF?=
 =?utf-8?B?eHc3dGJSOGtRUW5naUprQUwrTEhhVERSLzRqSjJiVzlFZHMxTUdCZGJYV0xE?=
 =?utf-8?B?MGYyZ0lKZExKQldVTTZxQW5pU1hiWDNRWTVzQXpES05FZFNOTmhqamplSFJJ?=
 =?utf-8?B?WjBFWThOSUFTbVJySlJKdzZrWGtTajAyUEhyNU1FTGU0blU3WUJMQ1JpZWZl?=
 =?utf-8?B?TDZZT1JZdVdXbjdMTXNOQnBmblFnMHFPdVNDb2VOZFRsOGhzczBqS0lxMkg0?=
 =?utf-8?B?NTdPd2h5bTFOK2UyTlVqV3pQVXE4N2laTTl5WFk4UUE4R0ZtUDFiRm9PL0xP?=
 =?utf-8?B?V1ViYUZ4cjRPNEVGRjZIc2RyKzJvaXZoQThHZUp4ZmtNVVV4S1EralJPQ1lj?=
 =?utf-8?B?VzdQMHlhdjNjT0FGdm5nOTFGUnZoMVZnbll4M0ppMWNpWE5ac1JndTBkWG9Z?=
 =?utf-8?B?dVRXRVM0ajV4YitBaGthdFJSOTVGUEVqZjhQZkZnZU9ITU5HY3g0eWE2T1hn?=
 =?utf-8?B?QytVQ3B1Uy92M0dOOXZ1RXNRYXpaWXFtQVdSdkJiMWtLZThPNTk4RXQvcmZQ?=
 =?utf-8?B?TDZkUW1jekNlMnc5SklHbEp0a0txbEFWakFEVjdrTjVQVllvc3c3bkZNQ0ov?=
 =?utf-8?B?cmFodEZZcE52b092Q1lhejJ3dXF1UkFBMDBGNy9EUUpubStNSUVLeElrQmFM?=
 =?utf-8?Q?AcW5coNnXA9CXscEiCcSczf+Tr21W+Fvf7l1P4MUjJOE=3D?=
X-Microsoft-Antispam-Message-Info: dv8zqB73U5tgt0eNMyOQ4ognNKpmHzRz+SjZav8L0Ev1brciQvKjvsXS9NXAPsdwUXcQh0lTGaEdzP2TRcZTsC3r6BsSUX2qRdGeCqeBRqH3KNs+IQuTC47tO7OM3+thnQ819nGV0jtChkVIDKh4qeqfMBDu70tVZx9JYqIgCbFDaKc/RSkdQdVPPDDIIiQi
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:w+PSsn1fueju3PB/GGqOs8Pi+7AvEirwef8zSaK2HOdcNrZYZwFKbNnv4OF3w2mF81Fc7pCJZbVQ3w7w6OO66LdLiqebltG60cwB6M0REm1mz5JPSY2in+CTQWXstW4xqJVOcyWKtcZHgtSDlTPrWrwOJvq6ANykEyMIgPB1/8mu0mDtY0lGbO6cwTzCERw6PH85euwi417iYao1pVnODeY5zbDYz1db2lpeS/qXbh9YJpMPTyEdapNfxQ517dD+KRBnhLQaW2wz6RqllC3GffcKfpjdz7qUPvRcauU572URvG1PsetIxqULAy47E5joaC7VOy6mRehYv7hHyE0DYAVHWfcQCxHBukzv5DK1dml5QlGeoJnIEY6DbRXF3bKaivNUy5QuGwMuTTz6ccBzQg6RBL0+tHGgl+/jNdYEaw1GxJ56sbk3iLpQsyZ9tX8Tm4ADYXP96NLpQO+dNLn3ZA==;5:mSMnPHo+X8HcP7M0JTlPc5aYnpH2TEJMgU8Sn9n485DsU5mwhhD6wgB6nsv3Ll5DwYQWu6UsGwUgkH04FRjHHe7BKptP1L7FG8VQHlQcxydU14Lbh8/xV3S04RCm2Nzyi/W2jtTHYICjDndfP3+u+qf6QB+Pue3VaXpnon32/Os=;24:eOYpvGq1LUNsEKMTkoChEbCvTdNcpiiv8/I0rhjN7qXHLDlvRyBDJ5W4/hqtSGUoD58RPwwUCAW56V0+glSUIZAo0NnNreRo5ijKdduX3nI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:VOJj2oT+EER6gbIAW03GBmWUUEYXXU5tyRM04K0BM6NidYoCujFI41I9dD2y2mElHkd64XmQ8OWSf4u5fqiBaP7vrkJWVfkECqTgDC3fOI4ASmdLgXo8YPe5KXRsab7AZjtwdNvz0co2Gxa4qX2a2WKlF9rsFH+Q8cj7BI3cgMsjZTS8HKqLbSgDyvgd5PhCWEnl+2OKUlZNjGQ0bskZG+oIy4g59QNl4MNlmAX5OaSIGRFg5mb6iX+g+1UjzegT
X-MS-Office365-Filtering-Correlation-Id: 29e77b7f-b4e1-465c-02d3-08d5c3b2de5d
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2018 09:18:54.0963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e77b7f-b4e1-465c-02d3-08d5c3b2de5d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-25 16:51, Tudor Ambarus wrote:
> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
> (7th slave).

Exactly how do I accomplish that?

I can see how I can move the LCD between slave DDR port 2 and 3 by
selecting LCDC DMA master 8 or 9 (but according to the above it should
not matter). The big question is how I control what slave the NAND flash
is going to use? I find nothing in the datasheet, and the code is also
non-transparent enough for me to figure it out by myself without
throwing out this question first...

Cheers,
Peter
