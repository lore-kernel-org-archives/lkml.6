Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C47EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780D920657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="huKJJN4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780D920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeH2Xwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:52:49 -0400
Received: from mail-eopbgr50110.outbound.protection.outlook.com ([40.107.5.110]:60144
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727676AbeH2Xwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMLd2EKIdcMfeHgYSH6rEkShK2B+Aq3H7uPW4692xSk=;
 b=huKJJN4vpHIbk26Pu6d2byczwifeXZ+XiDSInlh7pvLwnfAk5GnKZLb/1BZfUnhez9EKuP2V84TSFlxW6WaG5yutUeOngZBDSmGCiRS43SsN/9roWvNwF9lyzIg1c9y2VYnHkCdtNiPWyp5OeQf84LIOeEfxkXwkL14nRVWNJMk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2461.eurprd02.prod.outlook.com (2603:10a6:800:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 19:52:27 +0000
Subject: Re: [PATCH] i2c: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-21-robh@kernel.org>
 <3fa33583-f748-1708-2274-0a6f4e81004b@axentia.se>
 <CAL_JsqJcDdntsi3D=neU=Dhx0Xku_XPFC_OCLRb8V==HTtviBQ@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d2736c07-d653-a855-401d-120b0650ae79@axentia.se>
Date:   Wed, 29 Aug 2018 21:52:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJcDdntsi3D=neU=Dhx0Xku_XPFC_OCLRb8V==HTtviBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0047.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::15) To VI1PR0201MB2461.eurprd02.prod.outlook.com
 (2603:10a6:800:54::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: affe8068-ec3c-4f19-631b-08d60de8f345
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;3:uj/P/KFOmWfcya21FmbgQfl7zse7bOIWvEOE9jmDa4kgLxGiRcsxo8XqdilnGAZe8e+36EUkS3jNwi3Uho4S/lfnAOyxU+Nn6qyUVFldQAW0LMH86hSulsNs5g3FMeKyYAjDOcDx1Qm5IJyYFpdDS+caARLogJp3a6juUfJ04SjxjT8J8Uf5mcRDRhsHPzDJj1m1PpO9bI+9Omdr7dJGUlgvXvVs8G25Tp46ejNpnGOb0ma7BRk45SSMCff/hZrl;25:DG7CM/PN4tdo77jI//Gl8alT2ljcLTB6T73IAOyLHywF+xIFGJaagJdqaSvtLncpBdIZBg/TWoWLgyMvESPZplCJ7y5R9sZSuHgel3UMXBfGdkbqNXAOGLn9pAV8UFjVr8Q3qTNPnIAv0WrYRPv/4HGcBDbkDBjGoQR8UKiKazUdMZDkrwS+bhJPUSYBxAQ3AcUFY9yAFZNp7EKApkaSeZkVOnVS3ISS3Bykhj1Q6HEgmWUBsu98lS+Ww4j37neVDnMcXpe3gNG8/Ohw0QjxC4VsdTxDBqVUMwrgBqUpfB8H9ckY+i2TScQSOa1OlmrMZlW5XtbE+FtqEQ1K0X7YhA==;31:bWF5L9Kl6rs8PtRbCiO1iX6dVwuHfDimc+i9tOEVECcWzs0+cNHN9Z48bIf3phHyns4ZHvwVQ30uYdptotRqUdfhAOQVrTUeAsKBvNYP4r6Q5tO9U5C3eYFfE1mukzXY0QGuHNWGLc8LiL+nC/3VVe2jZWO6PTRbuEkM/qfK2bCQ7Bp+USP5XQ9QaBrH+TL0Qmhu7E3G+vVZESkcId5vUE+U9pjkaUVqCjBEnPzZUVg=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2461:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2461BA7A95C4714C71A3843EBC090@VI1PR0201MB2461.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(65623756079841);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;4:a+0NCRapJmEIDg9BSLIOhKBjhvk1raZ0715OCN//fWFf/P893tyfP/K+NYIn3ALXn0mWtDSKyPMRzv8HKqP9NWJUXGDOebUZkoaLYWESXhYu9qqd4pvaoDGNWZLZd7f8ctcateZQ8VlAxB28uwrS1O4SHy9Xxa60NyURWQCH4b2d15DFLMieZMzYp7ohAAwiiCLyJSkbDNRXFfXPWicFRuLqDnlsCCul5gkf6ep+V7AI8HyAl93yiyUbnKUy3KvZTIUC+LkBHrE42zTmY9U4fxp3hCTT105GjtcG9xhiIr9Bpso7unQqII7iPdTA7kaR4f/uYHJ1bHym2LA6y6TMVVIUgpXN4/BDaONtDHcaaOo=
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39830400003)(136003)(366004)(376002)(346002)(189003)(199004)(77096007)(76176011)(16526019)(446003)(956004)(23676004)(106356001)(26005)(386003)(2486003)(8936002)(186003)(53546011)(105586002)(31686004)(476003)(6486002)(486006)(8676002)(11346002)(81166006)(68736007)(117156002)(81156014)(31696002)(86362001)(4326008)(36756003)(2906002)(3846002)(230700001)(6916009)(305945005)(25786009)(6666003)(54906003)(52146003)(66066001)(93886005)(316002)(65806001)(47776003)(5660300001)(16576012)(7736002)(65826007)(74482002)(52116002)(6246003)(478600001)(6116002)(229853002)(36916002)(58126008)(50466002)(64126003)(97736004)(65956001)(2616005)(53936002)(3260700006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2461;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjE7MjM6WTdJS3c4c0dOME1Ga3dKMTJyY1ExamZB?=
 =?utf-8?B?S1YxOE9jcHFxdS9iS3h6cGFiei9aNnQ4M1VFcmVRaE1sdVlISWlRQlBjWUFu?=
 =?utf-8?B?R1B0ZnBwKzdYNDJDRlBJM05vQ0xKNVZZWElIMm9YUUFxWktEVWMwWlpjdzI2?=
 =?utf-8?B?Qk5EdGZIR0hPYzlLMnI1MUJ2YWVjb2Vnc0dPSDMvWStaNGllTGZmQjhiZFhZ?=
 =?utf-8?B?MEJzejhzTENaa0VKVDNOZXBoUWErNmdWL3hOaUN5a2txcXlERWRGTFVmVW5H?=
 =?utf-8?B?U0MyMkxhUmZsd0cweUd4akFnclhINDBBdVpXVzJhYkxvbXlZRGwvSVhpRUtv?=
 =?utf-8?B?LzhnQnZGOXIvaXNIOCs2ZDFaNHZRTFpZUjJXUEZaTnBQT2pzanRNaWFndk9x?=
 =?utf-8?B?eXhPemtuVnBzbmdrYlZ0SmxMYW5jL2c0ZThicit0VDI1b0ZaK01HTDViQjYv?=
 =?utf-8?B?TDFVajBDRmsvSkFIRUtqMmt6V1lGYWE4NDRVVVZJakEwWm5abDlDNVgwQ3R0?=
 =?utf-8?B?N3BTM1BWdS9CQjFFNFE3MHlkMnBUdEl6dVZvQ2ZqRUtsOGJmNGMrUldoNG02?=
 =?utf-8?B?VWY0WThUQ05zdG9TUVI4clhkOWRPcmE5ZlRNK2xMN2hFMHpOaWd5eklud1Vn?=
 =?utf-8?B?d1ZhdkdDSW5hS1NSbzBaZlV0ZURNU2RhYUJWVndxaXY3MS9UWk9rTzV0dkgr?=
 =?utf-8?B?bk01bzN5UU84MUpIdGZWMUw5YTMwaG42YXEzdXJCT0hTUDZJV2FaV0dVblJO?=
 =?utf-8?B?bDR5RHEyUlF0WEVyMUFQKzdyRlB1eitZaUZNOTJlRGl6UHRVajFORWtKNjVI?=
 =?utf-8?B?NmpJUEN5QnlRbFVYU3VURmVsQThSMzJUd0E1eVVwTDFiVU42eElVdTZxYVIr?=
 =?utf-8?B?N1ZwNmQyRE9ZUGY2Q3Brb1I3emFQWGE0WDloWUxYdkl6K28zY25Yd09LWFkx?=
 =?utf-8?B?NW5yaG5EY21EYU9VMW93NDFWeExDVEZiSFE2MUdrWTc2Vk1wa0g4NFJQcnNw?=
 =?utf-8?B?MHVCa2RuK1VaeXpCOFlUR1d0RFdMbXl3SnVQeHl6TTZ6TG10aHVoUVhFNzVw?=
 =?utf-8?B?TGRjRDV2SXN6SFRON0liSm9zelh1Qk1lbkl3YmV6YUtrL2dwK0ZkakFQNU9h?=
 =?utf-8?B?bERtMGpDY3lJTjVDRTN2MGJmcDJNYjBqU3FSZjhkdldEbDhnazhZT1VyZVdn?=
 =?utf-8?B?ZnViSFRaN1d6djlUM0tHckd2QjZYczNJaE1XZFoyOXhIOGFZOVU5N0VuQ1dR?=
 =?utf-8?B?YmdSM1ZROEVoaVQ4Mm5obWgwSVNFSlhOU0tLYXJMZGI1YlBmaUdOb2ZKeFky?=
 =?utf-8?B?ZmRRYnZpS1lLOWJ4dVp5MnllcUJrNE1TM3pham4rRk0rMnBZL2I5ZzFCNTJi?=
 =?utf-8?B?TzFFN1l3Mi9kdk5BVzJ2cjdId2VpODhlb1dRN3VlL2JualV2M0RWNDc1MWJ1?=
 =?utf-8?B?VjdzeTI1L0REWks0V3Q4WFdNcURwcVBRS0pPRFQ3UjhTMnJ4dUZ1c1pxVnJI?=
 =?utf-8?B?MmZRUytwQk8xN2ZkMmp4clBsZGQwbjFGclVNMkRZc2trS3ZNTW1GY25qbUhG?=
 =?utf-8?B?NU9VZFZaYmVndjgrOGpLaHVxbXNDNStWVW5oeFVuUkVuc1hzZ1VTZ2g1Z082?=
 =?utf-8?B?aE9FeUg1dWdJQnJGSnp0VVZWcnZIRmMxWkk5dkVodXh1bW1Mc0x1QnpnM1RX?=
 =?utf-8?B?TkQzNllZWU5IemFWSG9VQzNUOUZWajErOENib1dDY09yRCs1L1N5K21aeTVu?=
 =?utf-8?B?dTZRaUFRTVFoYVFnUFJxeUdwRFEyVERxOGoxdERlMnBmRklQckJhZEtvMG5a?=
 =?utf-8?B?T1VaMjZDeFVjRDlPbW4rNzViQ3l6R3Y0M1pvZFFEZGJORyt3M0dicDJlQzQ1?=
 =?utf-8?B?eFBEUmhUdUFiaFNLbElkKzNXV1RmNERYSVBNMDhnSmFDV0xMaFgxZmJKdkNp?=
 =?utf-8?B?ZEtySHI4T2puSjRLdXhCSHExanpGazYrWUFzZWUwMjI3Z1B1VFN0YjBGM2Jp?=
 =?utf-8?B?cm14VWRXeFBENVB0a3JvQ2luTkVzTWthMGR2aHhwTlp0cDRsb0lHRithOWlM?=
 =?utf-8?B?Z2tyWTY2SzgwcXVybmhtRC9nYXJoTTMvQjI3ejVYU0lnd0JVZHB5Wjljc2lO?=
 =?utf-8?B?UUpmQT09?=
X-Microsoft-Antispam-Message-Info: eymOLql7cr8LlyYFh1NMBA8yBVvOK7UPaepxE+qV9PDn3Gumvg84N0bcx/CS8A7zRAcD5LIO68rmiy+qW9SKaouS7H2GrKZ6y3jK3/ue8oaPV8i6cVvJwPT/cI962s62dJHf0LElat3LFNKdF0gYaZvKVHDhRleSHWnzJDJ+DoY6zcd/RZQKzK9sduZIE4Pe5/dl1CjjJ0Ynp5qCrqYg0DUytdR/aa2YD1Fuw9/97j3PP7ZMpTlMxQg+Zzs+BQSFZh/6SouLZSrZZ+YJ7hmT5XSDR3zwzs9q0W+cc9j0mIudDpDYItYvu5UNMzjo33T2Z8IAY5bpYGHE57f62xkloyfqYAHWtsPYg6HcOtPBGgI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;6:tZOz6DaJG8qsZY5+yJsYM3yx3U8OozajxXa1/TKgyjgqfUrHCziZwNpwAzt4mCz/zm1sUvuFAWisBS/AYga+tHP3AUjMOQ30WWLT63ycAV1e9R/ePXmuRQ8PCKp43mMgT5VEQrTWiHjNmVhviw+RyKOuEeCekKqEiLKCZzTNC8D4huSJcAupT3c/vDKZNXu2VMCs9icxeCpEBgzFtypJ1k11UcLDN2ImuFAfPTbi3zvMhOysSJ31IT8phtASinlnCGa+Rb7iao6RFTgwUHfh6Ecn9JzcEHctkNmwL+O26htA5EsliV+8ywCDbaJR8Qsh7liYipgLLrg/TV898jv8iiXXNrPNfZ0YZfzfScSHvgm76LN9S9JkI117b5f3ITNHphxP0jOnS7b6s8o9EbvlK1O6RHBtQgmyJJEn+9itAH6CsusexXwu2VEGWqaoM47/Jmsh83FMnRcqYc9JtmJUIw==;5:A2xFy2Cei/F+1o0ZS6A5gMhNRxNMVqznWNkD0RODAcJHeky+FEG6fLd558jmDVZN7S+9CrjwmMqRXrf5H3lenwDaLGCqeh/8cmDZXxdQGVrAtEkCoNdnQ5o+RT/esEMVOZOWl1sevmW3SIlDreGz+eBCgRrWnYlt0YHooEsXFxY=;7:VrJga3rTk5oYYY6T4c9XejIZwa0oKH0IXKe0vKPrQVDlqBsVY66B85Q+Fwgk6vS+6owRJeePLnlyUcwnPenetRKFDw0RUyWCTwUulgOOe+3drU2Rmv/Ap7zzXWWMjcfn4uHueyy9mDKZmfejf7N9FtKCykxz4k6HB1IP10UcyrRH3E+kJ3CtZ4Sqwjyz0Y6VrEwPO/OdGLxqTPS4U7BjzRCCW8BEZabpoOYrGpQiciM51nQJ5jfcfO6ab0IWpZPq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 19:52:27.8083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: affe8068-ec3c-4f19-631b-08d60de8f345
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-29 20:42, Rob Herring wrote:
> On Wed, Aug 29, 2018 at 1:03 PM Peter Rosin <peda@axentia.se> wrote:
>>
>> On 2018-08-28 03:52, Rob Herring wrote:
>>> In preparation to remove the node name pointer from struct device_node,
>>> convert printf users to use the %pOFn format specifier.
>>>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Peter Rosin <peda@axentia.se>
>>> Cc: linux-i2c@vger.kernel.org
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  drivers/i2c/busses/i2c-powermac.c | 15 ++++++++-------
>>>  drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
>>>  2 files changed, 10 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
>>> index f2a2067525ef..b706fd136ca5 100644
>>> --- a/drivers/i2c/busses/i2c-powermac.c
>>> +++ b/drivers/i2c/busses/i2c-powermac.c
>>> @@ -390,7 +390,6 @@ static int i2c_powermac_probe(struct platform_device *dev)
>>>       struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
>>>       struct device_node *parent = NULL;
>>
>> Lose the initializer...
> 
> That's pretty much unrelated though.

I disagree. If you remove the need for the initializer, it's very much
related to also remove the initializer.

> I'd have to write "Also, remove
> the unnecessary parent pointer init" in the commit message and we all
> know "Also" is a clue for belongs in a separate patch.

How about: "This makes the parent pointer initializer redundant, lose it."

See, no "Also" in there, and no separate patch needed. Or don't mention it
at all.

Cheers,
Peter
