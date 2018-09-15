Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B431ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 11:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0EA2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 11:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="m8TuNPly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0EA2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeIOQyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 12:54:19 -0400
Received: from mail-eopbgr20128.outbound.protection.outlook.com ([40.107.2.128]:57312
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeIOQyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 12:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TaqoiQrX+AtfDzWGqZBul9dSTMA3ttsFkNSoXnKHA8=;
 b=m8TuNPlyg2rpr3MYXv/mh8YRcc+T5tOc8PMDMNk01hjzaYpvBYwwTYqArAWo5q8BvrO2Av0tto1TtU3lfCOZPEKstUfjs2mKQEnCu4FN1GFeFxBeVUoKuwO0kbN9yTGtN9rwTkZT38JerKTzI++0JvIP7Y/HogxaBpBSUIDGq08=
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2458.eurprd02.prod.outlook.com (2603:10a6:3:81::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.18; Sat, 15 Sep 2018 11:35:32 +0000
Subject: Re: [PATCH -next] iio: potentiometer: mcp4531: merge calls to
 of_match_device and of_device_get_match_data
To:     YueHaibing <yuehaibing@huawei.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20180915105430.24052-1-yuehaibing@huawei.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <2e1acb79-cc13-bf11-86e0-5e813921f589@axentia.se>
Date:   Sat, 15 Sep 2018 13:35:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180915105430.24052-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::19)
 To HE1PR0201MB2458.eurprd02.prod.outlook.com (2603:10a6:3:81::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e28827e-4723-44bd-5c8d-08d61aff58c4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;3:0lZ1OiaWbkxdbHHVNrRFj9pmDHeWolw67xDFKrQiZOtqcDuisXImzayoM1ClWrNSPHu5txvky2nOuoD+DNHmcGXtynRa0+ukb2XdzOeMjKhIZV8di9J4lnxz02AUrs3+lDIA/oj656ud09Cpx/uvzLkH/ComJkWsfAKMTlHDjPzytWEmKmz8V8NX66N8tUnZ25K+IZOklrJZDmdJE30JfyyvQdTH+zAtdAsVmVM4ZwIiKNdiyABtbNswcfRFWE1m;25:a3aJw0L4FqmtlmVusGQ47Pk6BnM8iEt5HyswOC9AqN4zQq11OOKaxFus6GMRF++GEcEn4vGsJRMripssISkN/5/OdNlL7TmenA1B4lyP8d7XYpRgbAg3dcUufA3qIbqjCx65uIoDnGAjl/FS2IrmZfVOs392OpTfcfQduHNsB3ZKjuJkiyOkNAYsFax8zCeJTATGGpBJM7RID0GzpymZEyQj2zxV9a995P2yyz8U13+fK7ERpX9I+lu5BofANY5Z5SL0Nu8IucNAL8JcR3yoh+5o6v2pwAncAqAjtbUltXlc6YBAAm4nAtSPUVSZb8dB1uZKEXKlh6MoXuHd4vUJKQ==;31:het/WJkao8Am2h6Wx7/D+G7Ne1o7WKorovhhoCeAA7j3tPE6N3A0utIQR6Gfcru68ohjaPv9OyP2LxPjlxOxLiSnn13EELfn+D0XXeWH0dN+44e3Wk7cLkDDDIJF6FR+asijvukx1KnJwLhpFOXa8oCegYM6scsID/tBe0nSBq6KjXANi0XZZpIvKIpHlHpPghzIjmhkemlohMBbeTBI9xmD3+IGQPmRw1Th4Ystbwo=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2458:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2458052D04E8841F25665EC1BC180@HE1PR0201MB2458.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6043046)(201708071742011)(7699050)(76991041);SRVR:HE1PR0201MB2458;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;4:E+bGWs6cMyvVCaV8Nq1XN6QA3IrhGXBFYfk4YXUPf0TMEs5kzyGV1RZpd20oUUgOAtchHUUZ8l5AA8BZIFFfsSL0anz9oC64dbn/9EGgEHESOczD5dMDiXmtOxPbQvV+bO4djZ9h1yOrrr9Il5QXcoyahiCSfQwjwMaUi/nhnRhBOcp3KAYC28dEGCZBY0nPIvBScKonUSjgYBuDZ29Dqds/5RW2A3vdx+k7WkzyoYGCfzKSQhzDP8w1BHJ1D0CSJhMzqA1aUxH9GWwWfLXA7PSJ7ASU40H5+mymFoBZpkuwh8fM0zPhMCjDlsYTk+ZQ
X-Forefront-PRVS: 0796EBEDE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(396003)(346002)(366004)(136003)(39830400003)(189003)(199004)(36756003)(31686004)(65826007)(7736002)(25786009)(86362001)(6346003)(508600001)(3260700006)(3846002)(6666003)(106356001)(305945005)(6116002)(8676002)(2906002)(31696002)(316002)(4326008)(26005)(66066001)(77096007)(74482002)(11346002)(65806001)(230700001)(6246003)(58126008)(105586002)(16576012)(8936002)(229853002)(2486003)(76176011)(186003)(65956001)(52146003)(36916002)(23676004)(6486002)(117156002)(64126003)(97736004)(47776003)(68736007)(50466002)(446003)(486006)(956004)(16526019)(2616005)(81166006)(53936002)(386003)(5660300001)(53546011)(52116002)(81156014)(476003)(14444005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2458;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTg7MjM6bVEvWkc1UHJ1R054T2lQbjZVRTJ0dnhp?=
 =?utf-8?B?eUg5UjBmdlZOMXBreXRQMGJneW05SUoxWWFRb3lGSWhGWG1XcTNtTDY2UG4z?=
 =?utf-8?B?T051eWdFN2hOZFJDYTl4WVZxOFhPTTNTYStYN1U1ZHdXK2hVMk55cG9LQ0Rz?=
 =?utf-8?B?ODRoVklZeHdDU0FpVUdzOG9hamdKSjVBSkdjTU12NGxaSkV4b1NpeFV5SGZZ?=
 =?utf-8?B?MW5kNzRWWU10cDBuS2NYaW9QME1KYTNDeWZXZ2JNdTZMdStROXR2Mzd3ZFUx?=
 =?utf-8?B?OXpmWjVoSFd1a1U5dE1xeVROT3hXcjJVS3hNTDBkc3JsZXhEdVpVNW1lWWtQ?=
 =?utf-8?B?ZlhuWWtwVmFVMCs1V3BDUHVKUldrT015TWdKNEFNNC9aNVZVVFpqUlUrMlVw?=
 =?utf-8?B?MDlQSGZIVkdjMjJsTHpnS2ZER0tPc0t5UjJwZFR3VElrZkt0UXBuNlR1YWxi?=
 =?utf-8?B?VTNnUkNsT0FsUmR5UlF6eUs5NGdxZm13Q0dyUHNYSGRsQ1h1RkFacVF3dFBY?=
 =?utf-8?B?cmNHakFaNkRSb0RCNkxmYzJFclVVNHJJQmFrcis0azV2VjBKQWkzQ0U5cnRS?=
 =?utf-8?B?MThMZ3d2Y1FSTW14c20xYVJSblp5UWJBczVIZlZKR1hvd3pzU3JqS1oyUWQ0?=
 =?utf-8?B?cVl3WlAwVW45Y2lPSUVLZkVaRGFNZXNMdWhHNVB4UHUyWDRLU0FSUjdkcE5w?=
 =?utf-8?B?MEdTdEh3b2tGS3hRNERZYWlZaWpVTzh6bkJXUEhCYmFZYXE5UXhhdVlVMTgx?=
 =?utf-8?B?ZHVGZnMrY3ZnZisvK1ZxVnhVclJRVDQzd1lYc0JHUmx1WXpNeCswZldCS09S?=
 =?utf-8?B?eUJ0TEVJdm9jSU9WWGMrL3o2NXljUHIzLzlEWUR6TnZOczVUV0RVR3Y0QlJU?=
 =?utf-8?B?dFNVVTZyZ1piWCtESlBocjI2Snl3TXNTbUFLVGNDbjJuRnlLUzZCVlphemx0?=
 =?utf-8?B?bXpMR1BJU1RoVU5mR3JBMmNWNDczZVY0MjF4dG9RT2NVV3hQOFI0M1FCVU5t?=
 =?utf-8?B?M3ltNFk0bnRUV3BVbkROTnFPbVBvQzhiY0tZdU11TFIrdVJ0VHBCak0vT3Fv?=
 =?utf-8?B?RjZGSEJPT2hVbjJoSVJlVUM1QWROWmw1VzFMYnkwTGJVODBGbjNac3dQc0o3?=
 =?utf-8?B?KzlNUzRzVGtYbEdNK09jMUp2UUxsMWlRRExTbjBneGpaUzlTaW9sTWkrS3Nw?=
 =?utf-8?B?L29PNDJmOWwrSmNvMVlQRC82WGRNbTlxNXRjM2VSdmFkckZzWENkbUFjQXlC?=
 =?utf-8?B?OWZVY3U4VWh4RUk4Y3lwZ0hTQ2p0VEhkM3NIRDBuRHJUVFRIMGNvbkNWalYr?=
 =?utf-8?B?TUR6YnMrQ002eHJ0ZmtwaGF5MDgzZkc2Ym9DRVdabDExMEs2a3lwYzlnZWps?=
 =?utf-8?B?WTUzRWNKeC9kNHMyWno5cTdobDZQY0RmQXVLSjdzSWo0enh0aHlxNjZ4UEMr?=
 =?utf-8?B?MUs4OEVrVThJa1lLcy9NVVgvSGpoUXNuMnFjcHJ5Uy9lcXdQVmNUc3RMaDFV?=
 =?utf-8?B?dHg4dTBEWTUvZVNJaHVEakVoS1UvQVo3MGNzU2JyaXIwZ1BIdytuMHUyV1pJ?=
 =?utf-8?B?UXFIejBWaW9udXNoVTdKNThtRmFGUE50ZEtjUWd5emRCdEJseWJoU0FSNVJr?=
 =?utf-8?B?c01QemtPdm1NSnJVSHVQVWtyanMxOTBxUFJPOE1aYmZOdXh4NnBkYWZmamZn?=
 =?utf-8?B?NFFPbzFoYTB2NG1ISk05d3JpL3h3YUEzSG14SEdpei81K1YzV2wwUGNQSWtB?=
 =?utf-8?B?MmFZdXh0ZFFSdXNsb2t3OGRKRzRNdGNjdUlMZjM5NHF5alh3UFZNNXdQZXVi?=
 =?utf-8?B?WFQvWDdocXRuSWxRNlMybk1qZGlWYllVWFNVUnY0Tk5tTEQ2cDk0aHdpQ056?=
 =?utf-8?B?ZjE5WXZBNnhNOEkzOU5VWTF2TFFld2RVZ0pOck1GQkQySVk0SE41WVJVMkFC?=
 =?utf-8?B?dUEyeFErc0plNnRZSlYxbjJUc2RhZzBWYUVoZ3NFMExpS2ZLOU02RnN4Rm1o?=
 =?utf-8?B?a093YkNXQmV3ZDZBcDRZcWwzVUJEQys2NmRyejkwbXpaL3hrSWZtQ3M0U3dr?=
 =?utf-8?Q?Ip994y2GuRfCPSMd+C4txSmLM5Z?=
X-Microsoft-Antispam-Message-Info: X4GE8AZ9DNTLzZJ4o8WhEO552guemf96sMu/PhNXaVOrZTbCwgWmbdTEYRwnxoO0lfVl8NQKnNNTHW/rc0CCvsXV5GrOAtzc7UnOtS3z+yDsENLiSVhNzeVrJIYtnISpWTT6TsujCYhaCq3vDjnK7TTMu/yykpOYmBn3rTsYoDtr7glosaOC7ycbOUGsCY4YQH9RRG+0M2f5JFfVX9mK4s106ixwxYfQlVXUJ6Ak48AluMOmhQGg75tW2Zrj+B3kbxSRWmzyEh/XAqBEp1rzPfEQm8aJo0rOhBU4Zg2/ywewvOo2PpOooJv1ZWfIDJiY+flTfrR8DldypIt+kr0H1oT5oPKQX4F/Bl8caTnL5A4=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;6:Kw9HrSSdFroQFWu/zxkOiD5lxjX7/1DJEOkGPUrh+J4LpossTYnEz3LcXAwvd/0+BFNDEOhDl9d5mEEzTbs5EASLZhOCMwFrSYkpo3Xl2id0Q7J8aUHarqLyxfdU30vz3c1tUDm/7mXICSFm9szAnlSOYJ1F8WfSXi0JXLMjwYWB8VDPE/5Xsez9szVjSwDGfjXIl3aS5WSqLi4LDwxCiwcamLh6pxBrGVXsNtccWOiwdPhE5/PrHsEphyWiXgSrCpD+Zv29nFJO/Y1kHPzW18TYmPz+TTFGVIlH/Bq17OaTZ5PPoAFrG0pksp7in9j0S9Hd6SBRxbRO7GkidSXHV2+E/u8hUU7YC48ZRG3LDmnlnrP5Yf1a/xPjaCdM9b8TYD0/170i/h2B0wiAuHUrUsRwxXlPlqIfE5o+Ux4VOOtjY7pOQa8690lSC8zribgfMdVnEToO1LAS0zB/ZZvj7Q==;5:RJjGX3a3TJxtllLYluDXmCni1h4lkSmYRLqOV6GcZSsVn11jZq96TXFQUUHQTnIZGJ1AV4PR/9Tvbc8t0mg4tw8nEz08BujX5yNltI9eJJZCH2IXpuCFJAlWzZ0uSC0fXagBntObaav+fuV9PxbJG5ymeeiJZ+l1tgxHPM5HCek=;7:FX3a6Dd5/tPBsZpLJNhh4te8zYZkcKYiOpJ4uZTkrLsX4I+jEZxOpekBuC+lBU+j/tcQXYJ1tg02FuksLuZ9H6adyR6fybTC07V0n5++lvdEug4Mep8OcYE1D7tSV8Jzefnxr3zmqxhJTjcd34+uQ74hIYBN1+wS35tOSuKUnuYiuKK/I7nx3SZUv+zG/mah3XzZGOCNCKhnnAO0Mkna9kXsVVoYLeNhUzGwJoe88I8DnWMVWPX6zAoBbfe+3mZ4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2018 11:35:32.5678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e28827e-4723-44bd-5c8d-08d61aff58c4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-15 12:54, YueHaibing wrote:
> Drop call to of_match_device, which is subsumed by the subsequent
> call to of_device_get_match_data.  The code becomes simpler, and a
> temporary variable can be dropped.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
