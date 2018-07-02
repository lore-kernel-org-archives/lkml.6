Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8E0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EBA23FE5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevasonline.onmicrosoft.com header.i=@prevasonline.onmicrosoft.com header.b="Bm8itSDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EBA23FE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prevas.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030344AbeGBKnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:43:32 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com ([40.107.2.115]:53408
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753383AbeGBKn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevasonline.onmicrosoft.com; s=selector1-prevas-dk;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJIGTao7F5uxF2lf5+uGxayKsYgh50hUbYI/jX40LJM=;
 b=Bm8itSDX6qUHNDVFhHm3B8tK5VsSYxY1TUUPAXWF5i7NkCnHbWfNeyhKn9Ds7ebBEbRQ2JihFCwoCWnlRZTEa9CF97MApHNnePrRwcCplYpsAwmCHUdM62otWHZM2+lvhHSiKX1cy7jJaHEv6J8Dygl6WmD4VsXuCWDdz+KwM0I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sean.Nyekjaer@prevas.dk; 
Received: from [172.16.11.62] (81.216.59.226) by
 DB6PR1001MB1397.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Mon, 2 Jul 2018 10:43:23 +0000
Subject: Re: [PATCH] iio: dac: remove redundant variable 'shift'
To:     Colin King <colin.king@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702102435.16724-1-colin.king@canonical.com>
From:   =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <62141c55-575a-d068-360a-e0ea53df6f17@prevas.dk>
Date:   Mon, 2 Jul 2018 12:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702102435.16724-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: DB6PR0902CA0035.eurprd09.prod.outlook.com
 (2603:10a6:6:2::48) To DB6PR1001MB1397.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:b5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e05bdd03-e5f1-4418-6fd3-08d5e008a2c8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR1001MB1397;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1397;3:cpMa/LOYB3mcBxUhN8LpBREH/YUgoRrGu1TvgKdWIft3gvtYnsT6SGRAVz4eRxtmXpUaMr0FsRgwZQsukGAiiUMBwEbMIlvEcUB3rjR88gwb7ERZDmFDZDgCMzaIhXeM9HQJzgNOW1yksPIpk8zdJStdR6zjoVJ0eZlkd+X+JLDlfnKXwQEmeykEd9u4w0nelfa13jTe06lhsPsUpBaVARHFFBwuIm6lsT/rS9b2B9K+uyt8ZCquh8s2j9pNuzv/;25:lLvwmUNooVyntfD5y1daSUPBRWx0YeZ4ZzoCEd6Vyst/3kjEPvBxIQIQHysOZGP/Y4bGNr41FZvt0dIPUx/vSSUZK5+EByxG9x/SGR+X7Y8e9tvF2za+XqR5GMfZwTfua3866OVlcP9nHqj4dFZw5UL7XPmY+SawfoMJY372Z9pTGR7orr/8RQFkt1QR8nDsQ4cbI0VRn6q67GzTDntSTZYiLVK8uYrS/TwhgGPdzF2GmaeBsuEdH15lyPa4J9QjGu/HAy1hhP/jz50yD+23LJT2u3xKjgBMbLh7n9UFO+V+6mZPVhkLnNyC0TcuMjSXiOp4xdbMktpRUF09NCp6/A==;31:aPkNgEHzHFDvqkJjRYd2RZui1GUNMvc18MhGoZPMvKL0cyZKn0fyhKT1H8H0hymb+ah+vo9ulUT1glUg/ELvXmMVzQGsNuU5cF5cgxLgjp1DJeE/yq4DpJd2/LT+ndpFMQ/uK5Oa/ZuMykT+CyxtSZ8kN2wjsvqEGdZgCOL+g4wLXEruri9Z9n70cPwSv6G7FFBlveiYmQjKg2EHRIV4gfF1GFZ99lSE4+7JtPeI6Lc=
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1397:
X-Microsoft-Antispam-PRVS: <DB6PR1001MB139768882162E24ECB1AD7FFEA430@DB6PR1001MB1397.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR1001MB1397;BCL:0;PCL:0;RULEID:;SRVR:DB6PR1001MB1397;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1397;4:XEGaIDkEXsDtv5wXXlm+h861OX9KP+qODkZ76cWzXyGgwLIHKRmnm84TLB9I8Opf8ptfpl+yAGaWk/I05RDG1rlaX9ZtPhpx4GabqRCTVMLXjIqwKYKILyl9Fugx5YtUJ5ujtRhveAqT+xIMqsCbUpwf9Ej9LH603LGGpBoqD+Z0DAKsufumerrmFaOa0VrM9DoXouHO/axj6Q6nf54EGoReRAEtAB67YhJux5emnjKmIWc2SJuNkgvZYqicT+XFzkgyZoJAoUpzlXceYpgBjz07r8qpkAySti1qEbbh8O25M+sQCPzyjqcQ0d6py75y
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(39850400004)(346002)(396003)(366004)(376002)(189003)(199004)(4326008)(64126003)(66066001)(31686004)(478600001)(47776003)(14444005)(65806001)(486006)(72206003)(65956001)(97736004)(50466002)(956004)(476003)(2486003)(6486002)(76176011)(52116002)(446003)(31696002)(52146003)(2616005)(386003)(11346002)(53546011)(23676004)(2870700001)(68736007)(86362001)(67846002)(5660300001)(110136005)(229853002)(65826007)(6246003)(16526019)(8976002)(58126008)(77096007)(8936002)(25786009)(316002)(26005)(81156014)(74482002)(105586002)(16576012)(305945005)(2906002)(8676002)(106356001)(6116002)(36756003)(81166006)(3846002)(7736002)(53936002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR1001MB1397;H:[172.16.11.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: prevas.dk does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjEwMDFNQjEzOTc7MjM6Mk5yMTNzZUZtS2FZMEd0RmJXL1Z3ckY2?=
 =?utf-8?B?YmMzN1kzdElEd25DUVJUbzBXZU1LN0RBMEZIR0VXMC9obGF2R295aHpCSmNJ?=
 =?utf-8?B?VGdxbzlIVklCNFVOSEROQ2E1elVKNXYyK00veG0yVTREMC83RXNBS3QwU0hP?=
 =?utf-8?B?VW5jcXNQSzBHUTVPVncvNS9pNjN1dUFRU0M5cWVuRTNEUjNWaXlyaXVnbkk1?=
 =?utf-8?B?RW1ZYzZHL1pZMUV0UUh5K2U1UEsvcDFqV0dSMjdwVHhNVmxOMWJROHNKL3VP?=
 =?utf-8?B?MXE1eWhTM3luODRhUUloMU04dFk1b2RFUVpDMnNDSXZQQlVjTGUrQ1FPb0lH?=
 =?utf-8?B?dXhDM1AvdDBWR2pYWHJUN01WTiswaCtYbzZwZEZPcFFBZnhiQW0yL2xBUUcy?=
 =?utf-8?B?dDNvb2hQb3dLSmJVL1JCSnArTURhaGZSc2RVYnBjOTFOaGI1RDd3bnZ3NnBw?=
 =?utf-8?B?ZzQwL0VVa0MvbGJKd3docHJEN0REa2Z0ajlMSTBSVnV0M2tJd3lHNWtwSGU0?=
 =?utf-8?B?RGgwdEppbzk4OENqaDU3anRTcWJ5QjhXVG00R2VGR2FVM1lRRjlTV2Y0Yzc0?=
 =?utf-8?B?TnlkZ3pJWGVSRTBNSXo1UkpDUDYzUElydjNFNUZPWEJTZW1jOUxpVGNKRjZr?=
 =?utf-8?B?c2dWUXV1ZTBlVUJmTWxGWFZtbEhwRDlsV3NnVTFCQnRQZFFYUG5LSkQ5UHJE?=
 =?utf-8?B?VHliNkJ1YzFpazFhMVJJS1BTdis5RXFyWm42RHM5blFBM1VUZmlCa29iWGor?=
 =?utf-8?B?eFVzcDRNZGNKTVoxU1NYTTExWVhGVWdER2g5T3kyNjMvL0w2WFkxdGZSeWNo?=
 =?utf-8?B?SG1DMTJTbG5TZTJRNTZPSHRJUkxMcWRLWGVNU0lrRS9kZHY1cE5JaVVGVUNK?=
 =?utf-8?B?Y1hVcWhrWTFJcVNUY0hpV3pNVDlKMUZxV2c0QUdpclBpYWsrOFNsZGw1aWRj?=
 =?utf-8?B?ZzBMbHBRWTA0UVlSR2xaVGtZcVNhSzZOOWZMRHRPVHFwVDliaytXdTRLWTM3?=
 =?utf-8?B?L3R4d2xvK0Mwemw3bjlLNkpudktPemoyRHphL2JBaUg2am83UHQxNnZjNTR2?=
 =?utf-8?B?M0Vsak5sZG5nWXEwUE8yT3FCeXRPQWEwUmNKOFlBWVpzWjI5d1BJT1NkZUdw?=
 =?utf-8?B?Nm02ZDNMdFViMjdXZnMyTk1US0NLYXZtN2cwMDY0SjU5d0dlQ084MmgzUWRz?=
 =?utf-8?B?QmNZRlZZdG5yZi84bnRQdmg4bUtrVEwzV2p5anA5UEY0Q1MyYU5rV0NRSDly?=
 =?utf-8?B?Y3A5bDZ1cDBTYkN2SzgwRjJMZDZrRDVEVHlyQldPc3Mvd2R6Y1F2RTNrNlFZ?=
 =?utf-8?B?MW9NL2hpdFU4QmEvVVo4cmQvV010dFMzcnpYc3dHTzNmTXRXZzVkeThjU243?=
 =?utf-8?B?SkJ4dy9ndVI1MlZGREx2azFVUjYrZVcwSUJUYS95Qnl6UXdMN3NvNUVDYlh4?=
 =?utf-8?B?UXlHQ3pjRzR2OW5IMDFuWkJNZ1hYMHk2VlZzaE5oMVFjWC8xS09DN095RXA0?=
 =?utf-8?B?TEs3bWlnRGI2TGIrQUtudFJZU1ZFcFEzZWYzM2ZEZ0drUG1FNi9zSDI3Qyty?=
 =?utf-8?B?M0k3WlNOUjJ3ZVlYc0loT2RCMWVvK01pejlucGZSSVFocjNUajZYU3RiaFR0?=
 =?utf-8?B?OG9UeXhVTUpWdVZua0hXd1Q2a3pxVW53TnRzbWM2eDFVanJGUThRVGRwaFl2?=
 =?utf-8?B?WU5GMVpwWkk2Zm1xTnBSaWRLbUFpeUJzV1hlQkd1ZnhlMTZrcTdrZWpKSTFV?=
 =?utf-8?B?cGJpNFlBTWUvWU5IaEhwMk5objZISWF6U3BMMlNEYVIyT2NtenBUcFhmOWdu?=
 =?utf-8?B?OUdHZVJ2ckkwQ29LNWROVDhlTnJsS3UyZStaWWxiTm5qVU81MGY0dnpGc0I2?=
 =?utf-8?B?V3UzWENVdW1zRkRjdTNUYUNvaWxGMHNjWjJWNGhwdEpqdTdNbWRTYUVXUUZj?=
 =?utf-8?B?WW1UV1BxS3dwZkc1b2ZwQlJiZHlhcGZDZGhTN1RmVUxpMTFvNlFJZ1pqd1h4?=
 =?utf-8?B?aktpODF4Z1drbXJ6ZFlhcVhJL2oyQ2I4UW84NG93PT0=?=
X-Microsoft-Antispam-Message-Info: Hixp6T2GZibT1IeLddNQVaSR3avGikPioLuapvbkKJTc3kul17n6ncj8JQFkNesNM7dsz9lruU+jHZ+TKcQER0j9aCHpWsveIfxAUBUFhEak9NiSPFDR4j6j4adqJVcrF0/jGCEUBYvbnh/BfCMr/9NbeFRlqN7NL9hFogfTx0cBG90RYy58K39+L25P6bkWUpXja9EQK5eO5/C1jCe7kaCX+tnV2wHDNjtbnk8RXEMV5Q0LPUNfio39OnRwfpMJD0Ua2mienmIrUQUEQQ2C4pC0YwCXnP1HdO9zI/guMSwRLstYuBG7mnIUS2m7TBOL38fztV5HODaWkeu9NWVK1nw5x5rq/HeKezhLf+hpZDw=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1397;6:MRSEsQzaRUeCRvYtbbSlHhGFOgCE2gt/cncvcP3DhF5ERxw7z6lBRNBr6gA8KJXxbN31ADoWsF4PhQWH5aggQJ1t/dcltqj6QbTqaUQfcKnnT15YmL9IyNVrtsoTW9PlOH+rPH2fFrPwjIlXqb1+JyDUSGWMKJ78JgrYD05XAp2IYcD9OV34IBWva0bGfEqlIRt2iU7dI0l2TWLYYw5uVFjLPYWScVdkoSmK6c8y6T6zBNJbJTiCgi0dZ6hKymCWaXQTZhlcqF/jSsYQLVMubx2qkUgo8R3H5rVk6AZvGOxknAPNlGQxnX0dnvK2Pc378EMJAbYrgBqArSDf0WFkphqoCNPYdAdBBOjrk6Dc9CDIA6UtqNDhyXxrfmWGz7Tje6mOODZ6leKCMKdKqrEIW/l0bKYW+nBv6l91C77xtugzml1uuJebYcO8fmrTalN0XEemJ1+i9EAH/Rlfh8fC+g==;5:R3PJgVrixV9fXomOjwvdFrm7oHHnQHN5Tq/K7eQ80heQoaXtCXPTI1E2GfV78tDO22kL7jByPd2K7zrk3UJ4ovTTCKQ90sKAas3zHbnb9lX+glEKE2/enb9T1cWCkvPX3mPMJhM2ULtvdHUw1Wpm1A/dt6d3hlUQsplr5t+94RA=;24:pZ/B5seysqHybxWtpg1jHPiAZyISCLBd++hBoW+kUSO+P+LO7G6U7n7RrglZsPvGj+FSSgcRQ3+fnnNJmv+P7w3VTVMJqcfNnuryQpZtoEc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1397;7:0Cr1ypNl/PB/ksc08N2eXipAigjlVQuJOlKTG0Kbhi6AaVYpPyDyyAHZhsnBOKBJFyF/Jhgh42EPVCV5757csC4pkwqMNTTL3TyBz1czGzbmMmeEbpfPG6w88/ms1JRCmymEw7zKc+6CnzF79LgTXsho76Dp9mHZlbZ0ozioNI520x6iky2mx4ok1hRb8FvHT2J7w1gzKS6wfVqnCbYQaSG90glcoQFmYvNEUmssg9lHv5vnRGINy0/DeLOgDYOi
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 10:43:23.2053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e05bdd03-e5f1-4418-6fd3-08d5e008a2c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-07-02 12:24, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable shift is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up two clang warnings:
> warning: variable ‘shift’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>

Good catch :-)

BR
/Sean
