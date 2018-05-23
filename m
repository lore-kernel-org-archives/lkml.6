Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-64675-1527078747-2-12187756965506431154
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527078747; b=PYg3hDq2b3mXPBVnsAUfiDSFJrPTiP5zgA7wkiajn2pZfrujKz
    AXX5JOIHrWQPnBSiQoOl0B2RGqz5hdCH1cc/qI0lvBuoOU+E9PTJIpGGDdbFhr3U
    ZgIvHEAEsIga95sw/0H1hwKUVoUdYspB1lHOGARB5amo/TQis72kXiKsmri0wZ3p
    +vn+SjfKEpKRKV5tXOXtohlKdTzkBaJ0ygkjl5/EEhPUlUfE7JGv14Not1jNStQK
    cTZ+YWKzafY3wSDn8ml7nA2+J796X1YoEhjMz0bTGvAzs/sf2S0bLYLMZOhicrxd
    QuDWOzo5GH+xhSPwrtzhj7DHNLV5d38JfuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527078747;
    bh=U01klOlooLdKqkXLi9WPj8wKbR4NPdQuRj2VGFu2Ilc=; b=Qz3iMbPYR0YY
    nPejHX2XV2XTa7n9jfZwhX47nAY6FOJ9atSR6dRkQi8CjOhT148qoo4MzcMuVLTt
    gSKvYTcZ+bKlAVwPA2RJsJoUw/2AP/N0CSrtLJfxzGwfd6jvhunCgSsi3H1ePohM
    AyQITaoHIL7H1oGVLoMZ+CMsJ/5bS2Qzfdjv25UwnjsOz9k4kOowP5udCybsGdgb
    I4KTBtHR56EoiJCipSsH1dg8hHVTArRPXXjy90lqZLklI7R2CvoIxW3f+OqIfNBY
    RV8lh1byedfhWpRIHNCHxSUmUMmwuZEuBnf6zfvNmJEsqf2n0T8qzmRVYizFmz8C
    nydG/QYXlQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com
    header.i=@virtuozzo.com header.b=AqmcTsJe x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=virtuozzo.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com
      header.i=@virtuozzo.com header.b=AqmcTsJe x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=virtuozzo.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMZAk9cm6gdqwd+Frsa2nuj6oFIX9paZqYNUySY0Bdv6jExedW9msFljlEZGUVMnG37w+R+/GO/nKoxiZVTvJFg2LQZfhaDXYW9ulAHuii953MidY31j
    mswfXQDPkCqu3wjytpr1KVfT2JoPklpPk5Au7BBZ93Om/KEFRjAKiYP38U9ZVbv0uL3IhfmfEVyr3ieL1VDBK3/4KwlyxqReoZ+c3QoStW8hz5RgawdQ2OAw
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=dhh_qWxcV0sA:10 a=Tgzm40sRGssA:10 a=2TtQ-EmcicUA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=tpEzL2_AlxEA:10 a=TYBLyS7eAAAA:8 a=VwQbUJbxAAAA:8
    a=yrUavuK9UgdF_e-BGcIA:9 a=QEXdDO2ut3YA:10 a=zvYvwCWiE4KgVXXeO06c:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932083AbeEWMcX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 08:32:23 -0400
Received: from mail-db5eur01on0104.outbound.protection.outlook.com ([104.47.2.104]:22888
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932081AbeEWMcV (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 23 May 2018 08:32:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] mm/kasan: Don't vfree() nonexistent vm_area.
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <12c9e499-9c11-d248-6a3f-14ec8c4e07f1@molgen.mpg.de>
 <20180201163349.8700-1-aryabinin@virtuozzo.com>
 <4fc394ae-65e8-7c51-112a-81bee0fb8429@virtuozzo.com>
 <20180522140305.5e0f8c62dcc2d735ed4ee84c@linux-foundation.org>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <dabee6ab-3a7a-51cd-3b86-5468718e0390@virtuozzo.com>
Date: Wed, 23 May 2018 15:33:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522140305.5e0f8c62dcc2d735ed4ee84c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0701CA0078.eurprd07.prod.outlook.com
 (2603:10a6:3:64::22) To VI1PR08MB3263.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3263;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;3:GQKOVPMTOVehZIze3vTeKzWs1AwHnucXGZuK3XGFjNHxhEB0g099COLcvAKCl/2nQ7Wx2IAoTLpVtIIoy87DaxB7cRvQV15crxWZEe2uF+TlCzeK7J7jJ/uQrHtWjVLsh6bdJqExZULMl5KtFxU0AVn5b77jmvnnA2Pe4u4kJj1WkL6Xq2qkSKfsvZm+xQWGQd8DajfwlpCx35Ij1tSrsJMJdrOOzEvNpCTkIrAYk/jqzluyQUd0WjsYXamYMUhD;25:iVKsSELP3XWFTyXgThHTx6S5gvFrbjF7SNkIukYZX0YelGHOiGrUPXqMYRWjJSzu1NfL8eODWbFv4STmxyOFtjsSRgQNps2Qq4TenscEEG2Wubli+ueQZ8ze2aZ6xyuCpDFwniZ56iLPK3ObrosNSVamGRWN195YGLi6T0mzpafX8BU0WsDFZ4gT60dxdvXx1cpffw0mces1TojHkw83NKpbWZ9d8PxSqGcd4NGx+1E3BaSUC2VmR/Juo9bdrzwo2/XPlDai8EwrQAPgEchJR4wgmHCgSWHZ6A/6pJt/W5jqgGyJTrR7BQ+ACxtB0QCPR9Cc6wfWn849zDVImL4Z/Q==;31:oSOt18SUj8qeJ6+nwSqQ032oS06v3VikdRPAREqtUEPRtCvAqxhMqw0CzHNXS09ajyrKnVzMSFPvTchKl8VBqUduEfhvbSKr+FOWbYs7cWrNoumTKkLnw4M+sajNxaoJu5xuiPusc8ysW9D0DMyFMtIWDKTTn0oec/A5fYQ44VyquBl0vA/G8yvSVmD3Eym3eXFioKUaNEafejv9j5j2AAEOlznvuz1LS/Mwdmzuu2g=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3263:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;20:/XEIoy1lHgcRFyWv2c1VxjpYOjnr6dIvUpkq+thSIwRE85ey5IlLMtTXMU5znCZympLHYmG02jybHTTeK8uWfSbx4I02+LOvAGPwsyAYgaDKSleIJVOwW+mdJCJ4ShjBVRSh3xnJ/mWa2LMf903Fw8dMJo2aUl6/ndryU+8958pskHytEphZQRt+sPOvzUOiQyYZ1BseN9ct9qNUj1KmpICLmD0j2uNyOqErAkpJgT5XnWeuOxvCUQBqyggai9RQXbrpJas9O8exQVhcfSLydaL1yyqsnill8hiJGLjXAZSjZ9DhvLQ2Euc4Qf3JD9W4qoJ9sUOM4TfIypQDFqTlyv5X49GETmm1J5ShBvYxOVJKJGa45iNXsv2fVb+k9qp6C45lZlqIhiwLOyiLoKq+COzqCn8v9oSq71pqYjfP741PGNhxyQpBPpN0ULkIWMBsAQFS/f643pOEvAhFqdaTQL4Nq42w+I6awqM0iGm3sk72ktTjhFd9ejZ+wCniSL+U;4:MNjRsQm7PbS0HLxq/FcvkFxSpLsE2ei8pvUeDT9nYZGqNAAxCaiAWOSPwk9lG691SpzR9CFdjYwqqxzjFnwvyVAHWm5hpNpSbImFU58/WOfzO8lYJcnTOanC82IhniSvP0B77DCrUm1B/sdayflC9KW72ccW8QIPmHGG7nAGGYHyUBbG2Gvr5vk/29+TFdUZqqoiXXOZnW9+uE2TBJJf0bBs+Y+ABEM5ROS3GjT5tjyMrBJBqTFsTu8TU3nyqKqPESAv6rIE7fXY/vqswtQSHoM5jaz1uiEoCdqTYGQmDbpn3LQLj3IdCccKI9A4uurKxuk6NddjrDTnnVByUOYcmZNPhPcPvIMJ7B2knYqptVk=
X-Microsoft-Antispam-PRVS: <VI1PR08MB326393443EF22D85E226D68DB06B0@VI1PR08MB3263.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3263;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3263;
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(396003)(39850400004)(366004)(39380400002)(189003)(199004)(31696002)(4326008)(25786009)(54906003)(86362001)(575784001)(52116002)(52146003)(2486003)(55236004)(229853002)(76176011)(6486002)(230700001)(6246003)(16526019)(316002)(3846002)(6116002)(53936002)(16576012)(58126008)(36756003)(186003)(77096007)(68736007)(8936002)(81166006)(81156014)(5660300001)(26005)(65826007)(93886005)(7736002)(8676002)(97736004)(478600001)(305945005)(23676004)(66066001)(386003)(53546011)(65956001)(50466002)(65806001)(105586002)(6916009)(106356001)(31686004)(6666003)(956004)(2616005)(486006)(446003)(11346002)(2906002)(47776003)(476003)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3263;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjYzOzIzOnEzNmFJTFlrUUV5WUtPMm5Dc1pHd3czSXd5?=
 =?utf-8?B?OUVjVXZyZjM3Nks3UzZHdEJTRGZ1cmViQlREejdjVy8yNzJSdU9NZmhZenNC?=
 =?utf-8?B?TGxJR1U4U3ZPdWg2Zmh5QTd3b1ZUSWhBdUgvK05Sb3ZvS0toamF6UzYvYzQy?=
 =?utf-8?B?MkF4WjFTZTBRRElJaExmbjVhR056UCt4RTNEWFJ6ODZGdUx4SDJ5OFFjKzgw?=
 =?utf-8?B?T3Zaa1B4em5sWmpVaDFyV3hPaGpQQzM2b3JnaGN6TzRpSEpCR0dkMlJwNjM0?=
 =?utf-8?B?OW8vbnlESkVJVjF1QU9tNlo4SFpZUDNJdkRwNXpaV0h1dWJ5UStaOFVCYU8z?=
 =?utf-8?B?RVMxMVBPOEFvUzhxYkVNM050WWFSSHVBMzRCbU1FQVRTWmk0STZvS0tqL3N0?=
 =?utf-8?B?TWUwZlFHblV3bElvL0F1V2o5Y3F2TDU5S29tSFhwaE1pMTVIMXdDaUYwUjVB?=
 =?utf-8?B?SmFxdjB5YTRoUkpCaE9lWENPSUhYaWlLTm1aeXdlWWlOZ3lDRmw1TTNCK0U4?=
 =?utf-8?B?UzBsYUk3cXc1SHdUTEswZUgvL3lKNHpZenFKQWMwdXJabS9wZERNbHN4UlBO?=
 =?utf-8?B?T3ZLYmpCRDF5R0pBcG56WFZxWHFaZ0RUNUVKalV4d3JDOVVKcVRiOVd3RmhB?=
 =?utf-8?B?TTZBOGtHQy81ZXp4NklQVHdDMUFDZ09pZFNzOVRRSTd0SGdvY3JubVdJNGsx?=
 =?utf-8?B?SXd1c1RzdzdQaHBoZmN1T0JSZTQwR3JrZGx4WHlPV3VXQ3ZUazllK0tvNzVj?=
 =?utf-8?B?RzBMRnIyZXQ2SVFwMGZBU0g5bUZqS3dxQU5EeW1uTEJSRUhqb1hyZ21qZEFR?=
 =?utf-8?B?bk1teDVhMCs5RmZadnpjUlhJTjg5L1VDSkpZYTB0czFaM3RXSS9JVlVqVTIx?=
 =?utf-8?B?WlpuSjl4bzdNOWlDQTV3dll3blUrTzJGL2VmSHlJNnIyL0E4WkQxUkhvaDd0?=
 =?utf-8?B?QnhoUTNLYzNqaUlGY0ZzRS8yMnBWNTNnaDhjUmFhdSt4OXlsMlFLZUZXYnQx?=
 =?utf-8?B?UFJWNVkyRVBUSmIrYVFFejJVNnhoUWxtQm5pTktmRzNKR3hSbGx2cHp4ZGNF?=
 =?utf-8?B?N25QREtFMjVvR25NdHkxTU9SQmJ0WjNSOFdlMzVHWlJoN2piZ3FzSTdmYlNt?=
 =?utf-8?B?TnZLV1lKYjVmK25HQXVDbDhKRXJyVXJONXY4SUI5WEl3VjVaUlk3VUdOeEhk?=
 =?utf-8?B?R3lWQ2JaYTUrU2xtVzkra1pQWnRJaTNJUksxc3pWbzc3ellJY2hQK044ZVRE?=
 =?utf-8?B?TnZoQUJkaWR6MzRZY3kxSHJuZ0pBS1hHZTUwNWJuWGVHWUNib2kyVytlYStM?=
 =?utf-8?B?RGZubHhuR21tTWJXdXNVNnNibDZtUFRVNXE3UHIvMWZhc0Jta1JQZ0JEMnJY?=
 =?utf-8?B?Tkh6YStrcUhEY21aR05neUplWHBJRnNIMnBBQWcvR2VxdjBFcFJNZEcwa3JS?=
 =?utf-8?B?enIvZzhQTmxGdnFQYS9Rc3dhQStaZUNqcDhoaHRBeXNHeGVYOUF5Sk9TdjFq?=
 =?utf-8?B?aURCdm1RZHBJNkpTaVJhZkp6Y2tCSmtYL1J4Y1pnMVpGOHFBeG5nTHErWGNl?=
 =?utf-8?B?eWxlZnpLYm40S2FMWlVrV2xDVHdhSnpuTzA4NUMvM1NJaXZPNmFySVVXdlk0?=
 =?utf-8?B?ekZvNVFQTW9Bc0xCZ3FTVGZTRU94dHNBRVFQSTVFZWV6dVg5MkJMT1VQRUV3?=
 =?utf-8?B?a1lLK0QxQStROEZabXRzdndSRUdHM2YzaEFod1JRUFFpN3N6OWFKcnlvbWUw?=
 =?utf-8?B?MTNoNkhscTkxdWtCOGJDZmVCbXN4aXgycU9YS2lJYlpiemowSmVpdzNsejBS?=
 =?utf-8?B?SXp5MEpxQTRYVXVYY1JIMnhJMUh0TWYyWjBuWTVwNVJpQWUwM1NtQXB4b2h1?=
 =?utf-8?B?ZlpteExpYS90YmNqZGp2TUNsSFkxaGorZ091SjdOR2U4bTZQaldWNWhmOHcv?=
 =?utf-8?B?SzNHSEVYenRhZ0dPanhtVWJNblVvSGxoc2tjeVM1Rm9Db3pRdlVKc3NxQ1Va?=
 =?utf-8?B?eTRyMEVZL2VBcG5hRlBGS2ZKOHlxZ1hhNmtub0dvcXZvYU84QVpPanRXT25j?=
 =?utf-8?Q?nGCs=3D?=
X-Microsoft-Antispam-Message-Info: vVOhtKQhyYp1fZtJhSd2Y6YfCmwKyAQDPL2jWjiNDcyfRruuF6yZzAK6FOpq6+oeArmubAAOvVzIo15Xomvsj7iv0jT7+ceUkHoNKt+/QadRhcAs1y4baOszMFmN2LkgR/lfJ95rNX9nSpY57vFE1UYf2RFOyOM/02AmILgYzww/f0WI8Q7iFJapoUzdJJJb
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;6:KoSZn4Xg1JUkuYMmY9C3+PSz1EuMth8/FlN22GZkwZ4BX59EGLZOVLzfokHIhhtv6KBr19IKZvAVFPkuv64m6kbk6K2MuYyd4plzXRclAu0Vsj9kL6Zj4ZEH1a/HTwIYsJdZN2EU2lFEZVw6lTvbu0qu+QqGWIRpojXswGAXEpDUJm1leQ4YNGtIzsHX/KHXUoTLX0j6101ZDxSQn3kO+eEIveEfo/2R3IzLxXCOquihHes3UYixXaQs9ROe6Q/qQOMuY2eWWPOqe5hUaT8yKtj9rzadLfg5n5jUVeLg96S7YNYAFk7Hylgjjb8+tuMZ3C+71ZlHeUCDFlcARbL/+alIwPKJ6ZehTLfeEBlqWzkp89ruA045gr13AOAYNF9H4A+WRp2BdWLANDbtHAEejpiuRVSSppXLZgnJYjXnojrgMGo8lgNPaWtUuTtERhEoPWSsQthvDg+cqY6ErSmIyg==;5:uDoJqeA31+V1mvqelpUKuxZs8lxCcujni2SiC9VvcrsLG46Dz76Vrge9gah3Kkt1mEBhUPOP5CIIaT/uycA+B4a9r4MGoVskSYjL/IhpA8ObYq6HoYZwJELwPME9aZBVnsxc2eSDnpMSnLyMqp+HAwWK8rEovELmb/Tg60xwCTs=;24:UyzVdsW18iiYvvMkkkZDGIX5R0PN4KnuvLIZuQmkq1Ap1oMJMfbMJj1ffRLcsgK+XzUg9peye+C/RjFV9IUHnyg2EJpRK/LzpAx0uEaieNA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;7:/AQjvdPLOT+K6HZkrvfeuFMSYPBSPZVHV7vYTK/d9Z2RFnIUajMe2OmEVoVaQcI4pwLQYAPiaMeoe+xj0dUG38uk4ljVbiL9kP6PDFTQ8+QcwG+j4gX6jx+WwEyh3Hz2cKTdXqTrSENwlt8KALSa5XF0yRrNnlAWnkU/sE/PB6Qkzn6qaheuSHj56/wbORSwXLYuyc7vCpf3iwUKEGCe9UGMHJ/bHrxMoE3M67PqOLLz+lVXhkgUfBA2YFMJz+8A;20:EC/18PC3Pa8Z7yNQdl/Xvgzv8ElwVFWYxQTxt3gpntl2iSqzEG+xykv01Jxscm7JJtrd9l4UzyJ55dTFpQXfpNjA6a1QtY2yn0ahh0uqST7ncOcPbi38PRLiK9TIxpUcTiG1x68FkSOH5z0BIqPM0kt0GbHh4c/9wSlxJJ3hmM4=
X-MS-Office365-Filtering-Correlation-Id: c8a73caf-b2ae-4b93-311a-08d5c0a93959
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 12:32:17.9445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a73caf-b2ae-4b93-311a-08d5c0a93959
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3263
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/23/2018 12:03 AM, Andrew Morton wrote:
> On Tue, 22 May 2018 19:44:06 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> 
>>> Obviously we can't call vfree() to free memory that wasn't allocated via
>>> vmalloc(). Use find_vm_area() to see if we can call vfree().
>>>
>>> Unfortunately it's a bit tricky to properly unmap and free shadow allocated
>>> during boot, so we'll have to keep it. If memory will come online again
>>> that shadow will be reused.
>>>
>>> Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
>>> Reported-by: Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>
>>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>
>> This seems stuck in -mm. Andrew, can we proceed?
> 
> OK.
> 
> Should there be a code comment explaining the situation that Matthew
> asked about?  It's rather obscure.
> 

Ok. Here is my attempt to improve the situation. If something is still not clear,
I'm open to suggestions.



From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] mm-kasan-dont-vfree-nonexistent-vm_area-fix

Improve comments.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 mm/kasan/kasan.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 135ce2838c89..ea44dd0bc4e7 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -812,7 +812,7 @@ static bool shadow_mapped(unsigned long addr)
 	/*
 	 * We can't use pud_large() or pud_huge(), the first one
 	 * is arch-specific, the last one depend on HUGETLB_PAGE.
-	 * So let's abuse pud_bad(), if bud is bad it's has to
+	 * So let's abuse pud_bad(), if pud is bad than it's bad
 	 * because it's huge.
 	 */
 	if (pud_bad(*pud))
@@ -871,9 +871,16 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
 		struct vm_struct *vm;
 
 		/*
-		 * Only hot-added memory have vm_area. Freeing shadow
-		 * mapped during boot would be tricky, so we'll just
-		 * have to keep it.
+		 * shadow_start was either mapped during boot by kasan_init()
+		 * or during memory online by __vmalloc_node_range().
+		 * In the latter case we can use vfree() to free shadow.
+		 * Non-NULL result of the find_vm_area() will tell us if
+		 * that was the second case.
+		 *
+		 * Currently it's not possible to free shadow mapped
+		 * during boot by kasan_init(). It's because the code
+		 * to do that hasn't been written yet. So we'll just
+		 * leak the memory.
 		 */
 		vm = find_vm_area((void *)shadow_start);
 		if (vm)
-- 
2.16.1
