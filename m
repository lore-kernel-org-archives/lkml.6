Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F57E13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187E720892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cpR7rnrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187E720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeG3NzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:55:09 -0400
Received: from mail-ve1eur01on0086.outbound.protection.outlook.com ([104.47.1.86]:11601
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727474AbeG3NzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhpS4ddULotS1HbCrr9XPj0jJ9EBccu0y66sbkc1gZk=;
 b=cpR7rnrd0VU1RmL9SSMimnOLufBtnqZ5HQPiT1izlijrPSRqmQC7RM2afN8PzEfRrZ+G+boQg4oowzc1+yJ2Cr2llNxa2AxTvJymv+h5vZ4U5Y+qQB0zoLcXUQBH3U5lBeWOXM1uX+lIxfL4WUAIaUEjG8zOGKK1hfZETAYr3Hw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Antonio.NinoDiaz@arm.com; 
Received: from [10.4.12.219] (217.140.96.140) by
 DB6PR0801MB1943.eurprd08.prod.outlook.com (2603:10a6:4:75::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Mon, 30 Jul 2018 12:20:21 +0000
Subject: Re: [PATCH] get_maintainer: Allow usage outside of kernel tree
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <04452ac6-1575-f612-72c6-6ea88e70a9d5@arm.com>
 <20180726153946.3d81bf367cef7fe241bb3741@linux-foundation.org>
 <bb5ceade84df0a3c067eac2deabd6d62acd24fa0.camel@perches.com>
From:   Antonio Nino Diaz <antonio.ninodiaz@arm.com>
Message-ID: <29894e4c-2b43-cc33-4ac9-c509b9d32c0c@arm.com>
Date:   Mon, 30 Jul 2018 13:20:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bb5ceade84df0a3c067eac2deabd6d62acd24fa0.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: LO2P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::21) To DB6PR0801MB1943.eurprd08.prod.outlook.com
 (2603:10a6:4:75::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71e23eb9-3528-41de-ba57-08d5f616d1d0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1943;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1943;3:6Y9qgT3/APs64xrMbWQ2ZOgw9AG5En460U6IcYuyP5XZc+dxKdEMnpQ7Q44qQBWo13jsUcj5fwdfr+8WYFCg4EcDdK6vKyl6JwVPDlpLA0OLOCR9rRwynJtlDFDXuvAVC2oqbxW+EkFvWyDKF+yC7APbJImJtht0jN1qYrjWGF/Qo4P1aWP5jqe7rjL/nSUpwIg45o2Yy8LQ6AhRPtBFe3VS+ZAPWxwUJEnIHslQNNtih+pshfjpszVE1OslfQzJ;25:5300KKtUR5uEQdHhK5KZRQ91Vf00JdgrqoSgZL6Ps8ONmDurcG+fP6cURo4KselcwvVYybE6kUWGVEXRMJp3AjG0w/sKeMETqffLHBQkgKBkhZ+Gc4Y29pm3moWMbj+oBW0x/0AwfstRORbqVl7zm7PlR8H6LKPc8s8ymqqov+aLDv+ah3oAEg4XHJiuoNXN+GuC9eO0VL4TQFgCtTVcPnMCkwneVApx2ENFvK3x6VHmN72J5965VQ6Y7BcC0Fhs8DnQTJVMcB8n/+0r1NOslG2d4FaoTBVqqGhZQ+7uBEnWiFoEb85gdIrHOtSmJ55StwPcB2G56z2v9ClZJch4ww==;31:t4SsZHycN1oxRaIEQ41EXPHAVFCTdkkRrVvYQC48IP66Bs9onamJhyGDwIwZFrYjTf0/3Hl5rwo/ZNlLDxuccm4X0vwAjbnxL/nPPQdt6gT5lau+tuQ/nSuRI1Yes0llzwCYYiAwTtsLg8qqK78hvFWHrKkGOG5sdtLnAIH28BoxTySKp9+3NTFLISVBpsH7qnDO6YZqUeTmGq/Gho6FFhmI4OJyHwtxN7HKSIVZnKg=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1943:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1943;20:bjhHhE1FGQPcZKIbVKNSvmnZN3kzH9zmgmUZGWavn1rNJO8cLn3qKmNlRj5H0GdJopkBRhKJakBkNXrk2TK4HKdPeqrU0zfRJUbotpeN1fFG3RL4epGkNisgTUqwJHxKipACcSQCt5lg58O/8v9v5wzMkqjr9aL/w8+mZ+KQnBK7X7xJRhZYQj7cN7bBPzCcDKpKN5m3XzGEVb/Cb2/oGe2Sglrbt+lv2nCA+I2XfjYS5hcBLMX7mICNkpwXRsnfygx6lDSPC3O8OkFYzS7krO1AE5phIV2IegltmTea7lQUkH7nWAOkzPe+0sW9rILCmf42TYhLcPzEZtVIGHuzZitgPwLxnayaBOKIoS6+19nzmvJMIBR9CXNp9F6/2QyThWXsoaDmjZ6rPwlo87zyyygE3+E6tlghocbVGCbnmaH7MVFgDIasJfgTlo/zHLU/tVZNaXtirm1BU4+ubNu02pUZOkBNjwecyRKf4dLmPCHoADT5jfceYUxZoswKPkZP;4:RISDnByy6rU5c4pE2sNza2xN6dLzbbPQjK56loyfdLzporTXLkREgmwlZOBRxh7dmceZCn3Q3bnEIsfYW3oK1rNKnpWDiBDl4u9gzvsV0B0ytlLaANyRKVb78hlUGRgWiCrCjTAUIxgvskHN/sW0qwcHZMJU7nA9FSKlABcWotG3g3mPZzD7leNwHGP0oww+ARYgSrqW3ZssZ0lfN8VYpBNuyGg/Mn+n848N247nHhF5+yf3j1HlmE2Lg9qdejSBb1IGyvBvqTsK/5oFjBJayaSJHt2rt172rjjOKWG1Gxm2Yjcbnq/lEAF7NclsYm9VM2R64SZXaDomgLXwK2lzny9082/rXRUrCSQHL6oy9jBbhsJfhhqBLA1J9geoHlyHLMmSrfyzIoYyuLlgkQlI907+j3H8IfsrD3IEOq3nut8=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB194385D3B78113B7300C8656892F0@DB6PR0801MB1943.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(180628864354917)(223705240517415)(5213294742642);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1943;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1943;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(396003)(346002)(136003)(376002)(189003)(199004)(40434004)(8936002)(14444005)(316002)(110136005)(76176011)(68736007)(52146003)(5024004)(23676004)(2486003)(52116002)(58126008)(72206003)(3846002)(36756003)(2906002)(2616005)(956004)(6246003)(486006)(97736004)(64126003)(16576012)(86362001)(6116002)(53936002)(8746002)(65806001)(66066001)(65956001)(229853002)(6486002)(31696002)(81166006)(8676002)(386003)(31686004)(53546011)(77096007)(26005)(186003)(16526019)(50466002)(7736002)(65826007)(4326008)(305945005)(446003)(81156014)(11346002)(47776003)(5660300001)(478600001)(476003)(25786009)(105586002)(106356001)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1943;H:[10.4.12.219];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjE5NDM7MjM6UW5BZWYwZnZQNStpT09Tb3JyVDRVTWJs?=
 =?utf-8?B?d2YrWDBBQW9FUzBxdWFOMDhZRzlGQWZjU2hWVWIyV1VUb2dTMGtrejVmc2No?=
 =?utf-8?B?K0NMWE1BVG1TdENuNFhJcEJmZ0UyY00rRHlPUU1NSmo3MkI4cVJZTmRXRkEw?=
 =?utf-8?B?dEVnMWZsZXFub095ZmhZYkpFS29mSjZOTmRXRUZMOGg1QW5QbmNMU0k1eFFh?=
 =?utf-8?B?eVYvcHNmWm0ydDFZc3NHYzJ2QXZZQ1d6K3pUVmFKNUh5SzhNcjN6VkZEdTkv?=
 =?utf-8?B?YTRJeCs0SDhkWXVzWG9kMVdMWEh6M0Y2czlOR2dIVEhabE9VT2tEaGxlbjh4?=
 =?utf-8?B?UTlJMGVxRlg1SHJZaEdHdFhNTUZRU3Ridm5yQ0dQaThnOE52aHBWTEdybzhY?=
 =?utf-8?B?ZFF0MFVaUndSSnJXNEp1djI1T2JwRXJOSVMzWFVaTEduWVU3RkI3ZnQ0RFZU?=
 =?utf-8?B?QWVlSFBPT2t5aWhXMVA4UnRMVGtxSWpBa2hIaFhmV1FPdW9RMTN6MThEbmZx?=
 =?utf-8?B?NnBOb1FObzNzVG1FNmhkbVlnM1NMbFVOMzcyejNEU1Yvc2lUNUVwbXA1VThp?=
 =?utf-8?B?ekxFakhVTlJpalVqYnlJWW13c3czY015RDFMcVNlMUVnNVZheGUzdEVaVFFz?=
 =?utf-8?B?MHJ3MzA4VDZGYnh3U1BxRDZNWXJ4RzZnbEQ1K01nZ1lZaXFSM2pVbkdjcEtE?=
 =?utf-8?B?R1Q4YXRJK1RVdVFXRGF6eHJvMENtUkdXd0hDMWMvTmxqSlcydW0rTDgzS1BU?=
 =?utf-8?B?eTJjUSs0ekI0UUZ1YzUwZ0E1Rm5za3IrTjB3NlJackZUdzlqWUFYN08zOERz?=
 =?utf-8?B?Vi9XY25qckYzVlBrajRSRS81QkswcThVM2w0RGF4RmNRNk5SVDBxZWl0WXJM?=
 =?utf-8?B?MmxOcm41a2dSUEtjREVtbzFFMzFlakpvMXZLOE84Y3V4cEJZQnZQbENQbDV3?=
 =?utf-8?B?WGNrQ1d3WlBmUkYxK3E4T3ovZGgzWUVqcVB6YStPNEl1eEUwdjF0Qk1qUm9J?=
 =?utf-8?B?VVl0cG5XVHJLZGRrUmlpUWpVT2ZkTGtRUE8yZW8vSkROUDFWeDJ6dWlsbmRj?=
 =?utf-8?B?UFI1QVlldUZPbHF3RFByS1YxTG5RbWZiTDhlbTExZWcwckxkeEZFck1GRmpw?=
 =?utf-8?B?cjFzeFJ0eHgvN1JjNGYrQkVPOFBjN0t0ZDRJd3JmYVIrTVFrWEF1d2NkMFpn?=
 =?utf-8?B?Yzc0S28xNGhWcHI2Uzc2Sy9hT053K0hDZHFFZlJ3R2xNLzJ2akYyYWZvMWp3?=
 =?utf-8?B?ZzJpdk90eGgrSFd4K2tKU1d2clZGM3hOczYrdkZrV1hiek5FdGxHczk1RG9j?=
 =?utf-8?B?UWRhb2tLdGFnOGJKdEdFaWprbmpFTk9pOWtNRVIwcURPUStXSXM3V0hJZ1Nk?=
 =?utf-8?B?Zmd2Y09IVnZieGV0Rk5kT1FHelhuVVc1TFBKSkVXM01kWktDN0YwQ2xkMTNk?=
 =?utf-8?B?T3pzSlhuazd0NVU2VTBkZTlJZXdpVU9OeFE4cG9VUE5MaFhEV1U5anRPeStu?=
 =?utf-8?B?SEZZYTNtcWxQUFJ2VHF1TnNJOXFVZDlVTGVXbFNTbWdtbzdBaDFoTTY4d0Jl?=
 =?utf-8?B?N0dNMGhhczJhR1RTR0xNMWNLNUV6Sy9lTHFvRVQxZjVxekVoZi96bHRWTnJx?=
 =?utf-8?B?QU4wZzBpWFUzZXR3TFJzRkJXNVE4S2JOMldkR3dFbE16T2x0eTdxa1Fwajln?=
 =?utf-8?B?V3N0WWRsbnNpcVhhK2lNbGpDOXprVmR0V1R1aG50Z0RRZzB4VVk5RzVvVVFu?=
 =?utf-8?B?RjNiWkpBZ0VPbzRrZTdTb2dRYzdneWU1Y3hnZWgwODNqcGdmVld6eC9jVktr?=
 =?utf-8?B?ZS9XaFRmemVZYjUyalNPWTRwQTd6QTRQdW1SWTV4MlM2amo4cGluem1meThR?=
 =?utf-8?B?cmNoNStXWEQxZDBYRmxiTnpuMnl4d2NhcCsrMU1BOUxRU25WTEQrT2NyWkdN?=
 =?utf-8?B?dlhZVkxudnlmQ0toTnB6Z0lEREV4M1NDRU9rZ3IwUDREc0dlWGhuZUp6K0hj?=
 =?utf-8?B?ZDFzTy84dDJxcVNWSVBSREhxYWNrUUVpNGVxZWFnPT0=?=
X-Microsoft-Antispam-Message-Info: XLrWj/LIpJa47QOcQCYLwkTI9eqIjIucKaHMjZ95VcGbuvCIiCYBo4Y5bGc0DDpfFwpj9JEFEudXgnncVJEkohJg6MtcukY4T2fbBKw18hdgYPBuubj2lU1h7BKIjdzyu58QNHX80kYBL6pRSMxdq0BV0NHtjDN9gCct8snUJmjsYQpboIgcsUsbJ5hm5U9Jd4bABys+8dMy0etBGX1TK5rOnxFTf0p7VnS4ODKVqhNbyz+JJzfXB5HpdU3NTDunJ4a1/lUTrZNycTgjBPnYukZPNEDHGbkGezTPpDx0GY2MiC840K0sKSqMdPslLJFHEoqhhbMUtHTuqpcE3lwcYVhMfW6hS9aJnB3c/resTRc=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1943;6:9avfGKyrMztpa/0/M2T2dwnX6tv8lC6FXX+vKniEvMJ3ufgAUD5HbdPL0/mIRdHutDRxx+HU9Vdw12vnZFy/6CF2hivFtccem3f+sclJuO71sLlv2oyQpcOtUZbiBGQ2sqUV7ZBfXH5VdkpkbkqikE0sSvxV4brAdBSddTE0OIgGw0AyIsQKkbFrDWQkYq/B4Cr4FUhgLslSu1PgsSzTJbU+kUK5GfW+KkENMoD7NlAPfSXzndcD2t8HHOfNkq6h6VAdwuIMCm0bOjHPXBVIJygQakTFVjJwXWnRcDGDGosqAl2Cbl6mfhpSD/Dkn7LrqsffU/JkSQiq96H8Xjl6kbRzDFwYU2hPp6r2KKnT/DQ3kV7UVj+WxoV2Ksjw8UZmHTHS64bEmBUD4ByaCIZ4IFPVOhl67xT88N9xoPDgCTEglki5tolr6Lclf62lNRy4jR8qwKOKvNj3uAIx1Xw9Kw==;5:FMH+h187w5qSY8AWLU8m+ZYvblqrU827X5vFWGtfcu+f6ncFe0w8wElLJFC+7DnlXsDjHSjKbJMXNR40Z2/h4WNGpYG7HCwq0rH1xE4lL2S1KwgPFokkUMrZuwpxFVqhIOBn4mlsf0GeEp1OZ+XBFnE4NUySQ9N2/9TjyiScGtk=;7:UDlF9viN7pt+cpEf2uo27wSK4lne5UOHAjZqhIeazDNhuF3f5CdYqYAl47DxDxq+D4VET0CYzWslQDWOegPEvAv7jxkcoOAXO92I/JOZxSoEqj32jqTewQqYpBw8w2Vo5X84b2qQLHWPZ+U4/q+fyCAPl3SDvMm1xQC/1F1mrX4+v97GoNWxnB0roANCyaGyZSjWKxB0qxdSM8ZZvxI/khFFbQ4X4ddknL9AY1RXRNK+XkgU7oa3Da7ev/ut4W8p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 12:20:21.0748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e23eb9-3528-41de-ba57-08d5f616d1d0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for accepting the patch!

And also thanks for warning me about the tabs. The client is not the proble=
m,
I've been told that the change is made by the server. There are some issues=
 with
the default email server that the people that regularly work with the kerne=
l
know, but I didn't until after sending the patch, which is quite annoying..=
.
I'll make sure that this doesn't happen again.

On 07/27/2018 01:56 AM, Joe Perches wrote:
> On Thu, 2018-07-26 at 15:39 -0700, Andrew Morton wrote:
>> On Tue, 26 Jun 2018 11:07:03 +0100 Antonio Nino Diaz <antonio.ninodiaz@a=
rm.com> wrote:
>>
>>> Add option '--no-tree' to get_maintainer.pl script to allow using this
>>> script in projects that aren't the Linux kernel if they use the same
>>> format for their MAINTAINERS file. This command is also available in
>>> checkpatch.pl, for example.
>>>
>>
>> Seems OK to me?
>
> Me too. (modulo the spaces)
>
>> Please note that your email client is converting tabs to spaces.
>>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
