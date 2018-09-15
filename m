Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C7BECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 11:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A1E208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 11:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="OchkwRji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A1E208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIOQx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 12:53:57 -0400
Received: from mail-eopbgr50121.outbound.protection.outlook.com ([40.107.5.121]:5088
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeIOQx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 12:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMuaBDwX6TOLGdw7V8ueMMDVi2o8TyJ7prZkHpbh+S4=;
 b=OchkwRjiGl2BpfjcsIMYmFlejaSvT7GR/dmA9/9tCUiFxVjDqvxtdrqKpE7F87MGRuJ92KCvu9J2hwyxbf94sbxjr31PDD6GV8lTNxikQD745/f7eDFVzRyI0seb70x2lfRKDBtqdNxti7+acLmzaT4jTklWhJAhP39Nvuv/rNs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2461.eurprd02.prod.outlook.com (2603:10a6:800:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Sat, 15 Sep
 2018 11:35:10 +0000
Subject: Re: [PATCH -next] iio: potentiometer: mcp4018: merge calls to
 of_match_device and of_device_get_match_data
To:     YueHaibing <yuehaibing@huawei.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20180915105241.22584-1-yuehaibing@huawei.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9f3c9f9a-6bb4-19ba-65ad-53f7edd2af20@axentia.se>
Date:   Sat, 15 Sep 2018 13:35:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180915105241.22584-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::12)
 To VI1PR0201MB2461.eurprd02.prod.outlook.com (2603:10a6:800:54::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0bb3cb5-a92a-4aa0-bae9-08d61aff4be4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;3:cPkRi7LyAKWHk+YqMxlEMNvqDGWoiMqo38pZCIVGj2814PbcHemGOUgpJ54wrPg+v3knMVHh/RqBMiL1W9S25HkoOKzUcJC31BfTQVSSphZ4hqKLjeSDpEnX/aOr3uGhsKAnv+EmKiNWCjTWq2CaoGNTj85SU4rJAtIp4IgWqySlPAlsJIDDA+yUbgz07Kh8SLhzQ9pBFA6n/x1UhOhI2KSEPSeVZJbgGg0KlD72xVFPeGeqB91ldVZNj8DcojfN;25:fHH1ABQydij0h+PhpszPdWV5xqK+EQti+Z0kko7/Y9afdPTumLn1B5ZavYSVKzpfzii2YZkUV0jKCUAur6vm8/9t7n7xHlKfJ+kBeZWt//dhtfbbttUGOV+42UPswVIOZe8wmRfUz6DQrbHXhuDFiIO4pvVyQth7ot2cVqBj8Myv2yZ2gTZ5Bz33TN3s6Gfx4gukk+P54F7HEBZDiv5nvJd7S+HPeoWnK2KRiBoD7KaTaljx7Uq1BBhNjD3XomWuIODYt1Ot48chTmJRiIzsRdICbhJSiGYd6PT5/UA2/G1D0cK5hULUy+vyYSBAkP17qyQRXl5knKCqUZPk0KZ+tA==;31:YcLugr+paP8AgfLwSefVre+NghVP443SvEfCXe1RXYhWBRAb/1yoUUhqBSjhuindNftSEfCpkCey0MUfEHlxJQ+ksvdd5lBJ4gHp3sWI8S/ohDlLOHN7Ct1HUySbckAh6gLk+bxEeTY7WiX6Jj3jcDuxWhO7iE0QzYc4pvhtGxcFzJkRHlBkj9cy0LoSItOw0Tur33TlpzyfGZ2ADL2ht8xMb1nDlE9TQgB/a/JqjsI=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2461:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2461BD125A76E0A600474547BC180@VI1PR0201MB2461.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6043046)(201708071742011)(7699050);SRVR:VI1PR0201MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;4:g6SZR9Xj66Y4J07mABpdehyWrmTuez6aBH9htXyvLty3XtcwN63qZgVVqg8hgDROcLrnmtlsv+b9yFtvl+3No2mDywdtWNkZUkLM8mYZKSQ92Bv8FLE5NkYY77UG+b2VZBkHxwCaiF0k4/mpJ43mI8XJegK/yh7yuuadQUBr8DbStRach/eEyIENMUg55stZrHQUZxi/BtZdFK95VAmYwjaYGQGi8L+v160Gjug5e9AXGjfBuZXb9/ECQ738Iol29Hog/8LHqrR9RCUz8BuiqbpyZDxROkG0VejSGlS7fytzQ16N7R1Z+UErqwNRqol9
X-Forefront-PRVS: 0796EBEDE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(366004)(396003)(39830400003)(376002)(346002)(199004)(189003)(105586002)(2486003)(53546011)(4326008)(6486002)(8936002)(2616005)(386003)(11346002)(316002)(36756003)(16576012)(476003)(58126008)(74482002)(81166006)(6246003)(66066001)(8676002)(52116002)(23676004)(106356001)(65956001)(956004)(65806001)(486006)(47776003)(6666003)(3260700006)(508600001)(229853002)(52146003)(117156002)(25786009)(77096007)(76176011)(50466002)(86362001)(2906002)(230700001)(68736007)(26005)(3846002)(53936002)(65826007)(6116002)(97736004)(5660300001)(186003)(305945005)(14444005)(31696002)(81156014)(36916002)(7736002)(16526019)(446003)(31686004)(64126003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2461;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjE7MjM6b0s0RmZoZlVqUHhQVDl5QXh0d3l5NCs5?=
 =?utf-8?B?OU1DTTVDajRmaEd0TEw1c0FKS3RBMnQ2aVdRNnBvNk1HaDhpL0NPZGgvU29p?=
 =?utf-8?B?eE03RmRHYjhXWHNQaTJoeFVqNW9IcWRDT0pmd3VvUHlGRUZ6MkdydkpuVkxF?=
 =?utf-8?B?cmlXSHZVbldUc2tBUU1vbWxmZDEyMThZR1hWWTBCU1RKQ1BNK01iMSsxR1R4?=
 =?utf-8?B?ajBubEk3TVFSaG0rZENndTJqR0F5UzU3azVIYmsrak5DSHZPdXBFVFdMLzZv?=
 =?utf-8?B?TWZhWEpUMGxRSUR2U3pwU21sa0xHWHdEVXNCM0w0aXl3SEE2V005MDIxV0Vo?=
 =?utf-8?B?UGJsOWxYeEQ3dTRsMnFqak9uVlRGMkNKV2ZENmFuVDBXMHk1RTNJNDF6TXBu?=
 =?utf-8?B?K0I3bi9ReGpmM0tzTWx1YlEzaHVoRktieUNpSGxWaERiVngxNWRBMHJ1bjJ2?=
 =?utf-8?B?RnF2LytJUWtmWDVHTE8zTldHSGZPTUxkL1MxRy9vSTdiUFlzZHViREJORUda?=
 =?utf-8?B?bi9PcVEvOVR2RjkwQjdrZ2h5Um5TSmpmVXVkMU9nTEZJWDNQVU82ZmZ3bmN5?=
 =?utf-8?B?RkpVMDFTVkp3R2J0WXB6UEhOSngwNndMQnRXK0NlbTBHRmhsVDhjUkE5M0s2?=
 =?utf-8?B?bGNLMGNvQ1ZXRDJTRlhGdnRMTHdCYW0rU3dkQjJpQjlTMmFYQ2dHS1VYUVMz?=
 =?utf-8?B?cTZRS0RCcTdJLzc3N0lmcmVPOXpUU0VkREVRUzhyeGx4UmNOaGNVbFBhTnNP?=
 =?utf-8?B?Y2tqVnZyK21CWVIxY2cvenNsU1lUSGRpRUF1Ri9lNUFiejI1dXJXbEVoNkVp?=
 =?utf-8?B?TWJVK29SNDNyWXY2RHh3bk1oMVB6L0xtc3Iyd3I5Q3Q2WVNmNXQ3V0xKaHJV?=
 =?utf-8?B?VStZQmx0YlFOeGhBUTk3Z2VSK0FnaVpDMk9KQXM4RGZsZU4xRlVlNzVkYnpR?=
 =?utf-8?B?OFhweXpwcWtjNjN1THhhSjNHYjhaVlBYMS9FMnVtN3lNSDh3Vko2UlQxRDZY?=
 =?utf-8?B?dTJjOHFqbzBHR3h1MFNiQWtnWGVZQlE0OHFMakxxcTZlUjJlSGtkbFZUSlcy?=
 =?utf-8?B?QzRHdkErRzVTRjdRa3FxaHRPRFNVcXZ6ZDRzWk1jYzBpVWZ5bS9RYzZjb0FW?=
 =?utf-8?B?ZW5TT0ozSUdMMnNkU0VTVS95bVdjVmNxWDhqRXArUnJVdXlIRmEwU0x5cUkx?=
 =?utf-8?B?WDhDL0FESzh6ZnQzckx5ZFFUM3JFVEZDdkVXNGpNRzl0aTBjcmdhdEd5Wjho?=
 =?utf-8?B?QlJwMHl1TGNXcmh1NXUvSGc5MGpIWkdDa0ZlTEZHSThHZzNtcE41ZmpFNWVF?=
 =?utf-8?B?eE8xUlhxN0VTaU00SU44bmZrZnFRcjc5SGkvS0lhelphZDY3aEx0Y2tyMG84?=
 =?utf-8?B?M1pPdUQrNmhWUVd4QkFqTVdITS8vSnhFMm0zNSt4aHRQenJFNklnNzNyMk5O?=
 =?utf-8?B?M3kyL2F2ZjVEZXlGakdiNFhDTytLQzhaVC9lLzdHNEU2R1NNUm53bFlyQ3Zp?=
 =?utf-8?B?eTMxME1OWUwyc29teEtMUm5hQ1V1VWJneW1MZWprZ0hKc3VkSTBtN1NGdjFU?=
 =?utf-8?B?QUtaQ3Q2TWp4MUlhMUhVRXJGTVU0U050NWVnSWJkaC9wSzQrTlk5SlpRL2FT?=
 =?utf-8?B?YXY4eld0d0NRVU01ekR4NW9UNkd1UEowbWFNb0NXcGt4eHBuejRFQ2Jobm1x?=
 =?utf-8?B?Tk00VmNBZk5MUFh4cVlOVU9Ba2dTTWNIeUN3ZS85Z1dFbzdMQTUzaXBITW9L?=
 =?utf-8?B?TU5hTFNidUlNUktZcnNYRmtCTW4vRWtzaDFwSkR5YWtWY29GM3ZiNVhyd2gv?=
 =?utf-8?B?TGFDU2lCaE1wY21WYnRwaVl4ckV2c3dBdDlsUEJRY0JKQzZSL0xCWkRHTlFL?=
 =?utf-8?B?dXpqYnlOODNGVjhZLzBKTDZpd1BiWTJVVDFzNnd2bmdweXpxVDBlMmx0RGxI?=
 =?utf-8?B?MTdIZ1AzVEJRMEpEcEVtam1mTlNTeittcjJzL3U5R1MxUi9DNDE4ajJYMFZa?=
 =?utf-8?B?c0s4eTJ1MEF0TzVML0FkWVh6RXdPR3g1NDhxQXhSb0V3ZVlaZlkzNmxza21W?=
 =?utf-8?Q?YQnm0g=3D?=
X-Microsoft-Antispam-Message-Info: 3EjNnyP8DJ92GhmsJBxEJxQeIXnkD1InB6b0+51oYCD2M87lknBiKa6Cvilb1hmronPAlvkrraZXVMY2y/hhae55LRP5fbAg4wDlC6OKY9TsvU/EomyB161pnVPhFvOdzh+F0aXmIcDkvm+viNnhEjFoGrCS5AOY63rkdTMDOsKXXjz7EqV+YpI3OPQmCGUPGyjjdIMYI4Il/LZ0dbG7n/xeSzT9gh4awj8VvqSuRcSSZ0RH4CGju2YNiwFG9e2TkFYCOcHwQkP83PqwXCjWnW1FM/auOrVsXCY6l8ZK1sWuuQaJni18cdDwzDnatDv6Nqqk8o6tKJ0KGJXSi0drpL1skHe0w5pmTrA4+O3fbvw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;6:pg03nmGAdJA90jjt4D7US92oihgaTd+rC+XvBpsFr5LfBPP2WppnkmBazNv39WOtEav6AAEJW8SuKgRAZHCNmK8v1+ckNEa/C9cOGvM5xTtmmx7PkjkMYvr5GXEPQWWnioOZize3ZJcqatOYrXBACwpGWSM+UFuOkJj5xu7BL7HeraNdCxuCcsYP/dE2Rft6Q7TWNFIQtyFrrIL6aO+Reavbyk7L0Ue6QDIpNz1wtnHDaKToLT5cyEzwx/zXKIiQuNkVNS1Hm7RjB2t5XmOcg6bY6qQFQAYkYow+xX2i+sEQvwzLY9uWxTNgtQRFsoLC7iJDmA1OguKF7axIpwg048MlygqVhUNsu2nYum6eXtnOtV9+44gUrA+iX4XB/e6SL7T5xQshDJOsgWfcIgjsJ9w3Ld3SBfIaHmW871hbVEtJOKuyoXmqCgEXin95sUvNVNqHkHilmLmwsw4BCoSwpg==;5:XgUBTYB7UD0FZCLNnIivrUWYK0iFEDrBkGGIXgKMay3Ooeg2wFVwgg56zviu84/EILdSLFtih01AeeqEPn20Wq5teMZZrgK43vwK2rh9iX9xaIYZ4scJAi633NW37hLbmPRcQ5nUxrdczbnaUQOVezPIJUFm6FUudIL0GIChS7Q=;7:EAItxtiwBEXG28gF5uy3BQqanho/DVhePQGj7Uy8UCp3dFIfZjGWKWPltfClSSF5Z1I6XY8WvDiNOoma2fkM6o6aOWBsF+iDDvwSl+Ym+gFChXg3X48SAuWuyX0QVoExl52p2PsnRkmxcsTNfdw0XRN+Ph/jghFQomcSQ3tbXJnIbdKf5jhv1zbKFZWvhrNlEiuccEGAnVuMrzoXNXuq8HLftI7auWfYUlhzZjSGrI+tC2UCojvwdshwEPKG227F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2018 11:35:10.5652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bb3cb5-a92a-4aa0-bae9-08d61aff4be4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-15 12:52, YueHaibing wrote:
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
