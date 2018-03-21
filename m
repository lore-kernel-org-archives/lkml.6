Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeCUIKD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:10:03 -0400
Received: from mail-db5eur01on0103.outbound.protection.outlook.com ([104.47.2.103]:58688
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751597AbeCUIJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:09:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 3/3] i2c: mux: pca9541: prepare for PCA9641 support
To: Vladimir Zapolskiy <vz@mleia.com>, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Ken Chen <chen.kenyy@inventec.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, joel@jms.id.au,
        linux-i2c@vger.kernel.org
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-4-peda@axentia.se>
 <bc464354-660a-00ed-e713-eec987407695@mleia.com>
 <3cfc6e53-a86d-8ef1-b83d-9f3c1b3d7b9c@roeck-us.net>
 <67f0b5fb-5df7-0354-bfd6-5969b6fc7bb1@mleia.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <7ad08be1-fe73-061f-b0ad-e29a4a074506@axentia.se>
Date: Wed, 21 Mar 2018 09:09:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <67f0b5fb-5df7-0354-bfd6-5969b6fc7bb1@mleia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::12) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb9d89d9-717d-4f39-cff9-08d58f032150
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:Vwlb+5V4fSdb7nHnVpMuF+n9U3cYjDRyju0C7Wz1ROcfQBS1GMDuNfVH/usT71icnoc6PRmQcxmKle3Gz8CpWRizgB16Dp8wfw/Gpv3dcXDM+09/XExyHDm0sLK9/C8B7cowZE/7F30LRl9cr15XoeDfjxhkwqHM71+TzzLrjTI04sr7B56zuEHISXOVHDZyORzyq1YbqRtzLpQrfFbhFNJmclI8wbW+hHqKsVUCds3miuAnKmGjYr1FD8EdUY6e;25:PQu0I7cHZ55AYHVV4M272GInkmFzMpC76VSaHR+h8lxYo7iyc7XLUdiHSXhWjFcfWIKHF5hML8DtmH81FZZdXIAUZ3jqkpZyDIheRHIpsLHzlT/6aiOYlG55AuuqbEmlQe4wXXipSglPRY0I7JiIkbM3RWZHZX/CvNXUkFSMGj6UqIMpOfdmUCuH9MX5RycqMiKFxgnO3dZ9hrvV0QccHHAMVvnT06wIgInjTtgLPnlyl46pTd7TQ2YrZuFNt12qHNLkJgDSRRFNztxri6oRoliUD0K6O4hIWWBzeB21f2csZ0iRWrKTq39MQt+5nJ0HpgYn1Pv5HLHtM7sNxeQSzQ==;31:DVLQLO6lFE66Gy8f10C9X4fSKA+1XIu9yu6jXDRplsJ38DBBiqavgujra1cYMF8lzCFMHwEhUks0OpTRfvKp7idcE5fPifnPaIDlz+Uz48hPB6bZXCUA3feIJv4XsfyGE85dkl3/FHRtdYSllv/Ct4ZmnUpQTCVN+Zi56z5nWGq7TgJ0Ruwe7y+hqYAgD2oIqYVoXC6NV8/QGE4gzXARTpw4777pqcaQWDQJ1g80Wks=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB276994ECABC05427E6948AEEBCAA0@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501320)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:nY1YTjB73DKvTCf3OS6artsUQw/bxQy6DJuGbZBeP6brxAlq80T7Dfy6EG3c+bPMfVMRApk1WZWZQq7UsY0pZMebmGQNsx+KS//kc3hlU1cao5IhbRBloPTMiIKNOiKoFanepeurlqLRV9hCbbGUkRQHH68LIB7fn/Tsrn2Hm1uPf3mTo5RfnqZe71JkK7oeN99Utn4DMXkOATaWMwLEZvrrckk63f7m2WySzhVDiWBsfy9yGR5Wyl5y7F7Eo+UD5XMJHlTWbf03AS/bYVTlyA==
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(396003)(39830400003)(376002)(366004)(189003)(199004)(377424004)(53546011)(386003)(229853002)(8676002)(6116002)(4326008)(26005)(50466002)(52116002)(76176011)(6246003)(66066001)(65956001)(65806001)(117156002)(86362001)(2906002)(65826007)(58126008)(16526019)(305945005)(5660300001)(186003)(8936002)(3846002)(81166006)(81156014)(77096007)(93886005)(25786009)(3260700006)(16576012)(68736007)(6666003)(110136005)(230700001)(6486002)(36756003)(2950100002)(7736002)(74482002)(97736004)(106356001)(64126003)(478600001)(53936002)(31696002)(52146003)(36916002)(2486003)(23676004)(316002)(31686004)(47776003)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3Njk7MjM6MzlobWY5MTJBY3NRaFc3UFBKSXc4VnZq?=
 =?utf-8?B?NE5yM1pUVDV3SysyWVJvR0FnaCtuaGFNeDBqLzdFc0lwK2dvUjVTMmFYUE90?=
 =?utf-8?B?TDc3MHYycGVyRklFNkNVckVyYVhBdlBRMDBILzdlK0pMQUV0Y1lSbHdUSGNm?=
 =?utf-8?B?TWdYamJwUExlTm1Sa2I1dXRDRm04dVcvNGQvRTAzR2FneXIwRlJJOVUvQkcx?=
 =?utf-8?B?SmFObkJWME1nSEgrTzJtSWgwa3BMWmpwYjR0UW0vY0JiYXRSVWZDVnBLYXE2?=
 =?utf-8?B?SXdNWjJvZFh5bFdsaVk4OERHZzBKRm1NVHk3SUlEck9pTG5MU2ZobmtRclNv?=
 =?utf-8?B?ZjFGTEpaRmJuNWo3dW9NM0M3MVkvUllpQWhpRVczV3h4Z2VYZm5jdVVyVnJw?=
 =?utf-8?B?QS91L0dLU29CRmJJVHo2NWxKTGl3UmpBZzZJSElyV3VpYk8rOHF6NWZoMURG?=
 =?utf-8?B?bmJTblZwNHdDTWtZS1Y4Y1VmeVdBSS9hbXA5N0F1YWRLRVJNd2VYWWtEdVRm?=
 =?utf-8?B?NkU5WlZteXk4NWIycndqNy85Mm5CdFNyMDZFK3hDc0FMVGJXUU9maVlndGk0?=
 =?utf-8?B?VHBFU25lQndRUGdDRFB5eEl2Qk9lSGxoSDJLSHFTRk5JTm9hUnM4cXVFczJi?=
 =?utf-8?B?ZC9jZ3lKZFJjKzZCTjRxNWZLd1dZUjJxcCs4V3pMSU1pUm1TeUw2ZGFvWDJ1?=
 =?utf-8?B?SDQ5ZVRaaDdEbFNWaDVBRXowL0wrMTBSS1o4US8yQkNudis2NUN0U1hyRDFE?=
 =?utf-8?B?N0wvak15TjNwVnBCK2FkYklJN0dIcmZzZDZmTmxPeThJbzZrRWEycGVSRzVh?=
 =?utf-8?B?U2JEMnE5N0dGQjNYQmFFbFNYTHlDaUxhWUZkbGpWYUJkRE9PVklDMmE3eGx0?=
 =?utf-8?B?cWtLWk45QUtGMWlKTk9kUXFUZnl6c1hQbGNLbnNndHFoNWcydlQranhrUllU?=
 =?utf-8?B?YnlIclRmWFR5R2EwYWxoVFlNajA2K1o5SnBCM1ZMck9tYTFpakVTUWFlK2No?=
 =?utf-8?B?bEVZWmxhV0dxY1JLby9jcENVRUZmTFNLZVhsNmpnaWN1cUVJU2dWQmlUZ0Y4?=
 =?utf-8?B?Yi84bHZVZWhqdWJjVzBXY2FEeEEwaS9SaWMxV2tDMDZhWE9UTFNZMm90WlBv?=
 =?utf-8?B?QUtBQkllR1E0enM1eFlMcU5sMVlacWt4ajB1OWk5Umh3a1l1ZmtHL0V1cHNj?=
 =?utf-8?B?RllGMmNCTHZkeWI2Z25HNDdiT1BaTGJFbHlwckhyMjNXMjhqaFpuVjFILzJt?=
 =?utf-8?B?WGxtUHl6VEtpOHlVa2F0TVdrUnBOM0FkeVhST3JkbVZYdXZMb3ZhNmkzUUl5?=
 =?utf-8?B?dEJCaTRFeE0yZWxUUzVZVG5SUmpleGMyN214Qmk2cFJLOEUvaGpucEtObnE1?=
 =?utf-8?B?N3FDbFRwUzdERVhQSUs5QVdTTk9TQVNZT2gzWU9CdjBHUlg5NDJhR2JwRlV2?=
 =?utf-8?B?bFdNM3NOL3IwYTJRZWV0TDFLL0RvaHJucGFUS3ZEV1QvejhrYlc5Y0lKb1N2?=
 =?utf-8?B?Tk5rZ3R1Ukg3bGE0M0dsWnBSRFlxQnYrcVNxYSswR25XMGRnNFhqL0JwM0Rp?=
 =?utf-8?B?TUszNEoxc3h2dnpJZWlTTDEwY0I0cTdQR2Z0T3cwUkd3T21nUG5qRUFNd3Z4?=
 =?utf-8?B?WVRacG1FZi9SRm4wQko2cEZMQ21LV1JmUlZRMDFBTWdOVkxHSXRrTXZlVHRJ?=
 =?utf-8?B?SzZXN29HL1oxV2IyNzVVWHhLM1VKOE1XSkdERHZaYyttSFk4eFFDZTBkaWhu?=
 =?utf-8?B?cVNUcVQ2eFg5K3pnb21tZDAxb0NZQUN1N3Z5VzkvcDVhaTU5KzBaMklVRkJC?=
 =?utf-8?B?VUZMNWJKamdHcWx4cXhVOHdVMDlIQjByOHcxN2tjSVVsNHA1Yi9yTGJrZXo2?=
 =?utf-8?B?NVlyaWN3bHlNay9VTWo2Z2htQkVqdlAvaTNNSWtVVFNpTHFscFVhWmg3bFlV?=
 =?utf-8?B?SDA1Y3I0VGNGb3o2TEtzSFRSVzJ4djZDWlRISkVRYURxZkFyWFZHM29xK0Q2?=
 =?utf-8?B?NGJSR012OStESWplNzhESEoxVzNoeTJoVHczdWFRPT0=?=
X-Microsoft-Antispam-Message-Info: gcu3wqGNen7PQin5rsnvOBlrDDsJgnNB+hQeXQaAhmFcFqKennXNQDh/fXQAK42cxQ8KwjJ3yMF81KJiMJfTDoGNEhgo9cgiW8OP9MpgLOwW0pc2op4arv+p6uaDqPLDwAOKDKPh+elrZDGYcVmtzpZ9MSRbexjIJQ/748DvKMaRCyXCfnNvy5dctjhMnmxZ
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:hwOBtWOr6ixNJItKOmkPc+ppy7tTp14cXluHjoSIypcz/hCI9DWo6glpZJgpJiScv9vToEI6/b4asmMlN5wpZandHT87GZV3BH4HII2ezUgtYme+8fl/TnXzsOKeCJH9QEkDEcdOlK4W1h4JzqQCwopQ41RhGJW+Zw172x4qV2Skgji/izq/1fRp1i8gBMGbEr/1QMtwoADUGX7gTxei7MIIA9+VRHj9lT7B9LnlZCL2HtMlk8h2HMiSK3JK1iq3ezZZjdOwsRtBMoBadwR+uoXK9fO+mO4S4Shqgt2pm5kHMAC10m6r7JYZOm/2lJXjOer7DOkJBS2Cz5sawKP2Tc0jkXP2bP7xrY41kFF8wN04RImfllZKGTaFZvAZ1CKt2lBG4fsFJzYNX14xgfh8r1GXyDJfIvAEEV5Ku1GS3OuvqRDTQweXWsF84+8CmD3cxpMfybQJxru/T/LUOqSPwQ==;5:8oeBgmhGeGfNIPtSC/ZfmFy2kYsiqvnccp0zkmkD5etqBpJsTPXj2VuIlEkNa/nTSHK+1scOOgkH98nK+3q8LPa8QCDnYgdG3mwxQ4Qod1FSlfe0ZbI2LqRHCjxWCsKQv0xiu489Zve9HlfOf+Qb/6O3K94j9kfYf///Y1OjHYE=;24:jaV1QN0VcTFiCwD6wCBke2UeRIq9NNxrbE74FjE8q9QdVg4Cmiqg/5PP+S5CtIcVyvv1Y/zspotU4ZX+XdBMGbKqDErsDrJ/sqBx2XUJ12U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:zw2dqOf2Dham9iNq2X83ii1p/lHqtqQxGpEgcNus4OsTfzh3E9gp3MUDz5K+iAUSXLW7FZ5B/A0ROQMPUiZu1T9SLgS8ws/6oWMaE+hhDsT4P62Tn1ZYhk6cbOvSiNvFQazFwf6tUSuZhLjrEU0CRSV8s4eejoLaGONiWDXIzk+I2j6ePon91E7xBz6TQSHoEMH90KLk8XspDzqRKQEWNViI/C+X5oPT3Fulv80rwC+ibjxUA6VsgW3fiHalu7Ni
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 08:09:54.4307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9d89d9-717d-4f39-cff9-08d58f032150
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-21 08:01, Vladimir Zapolskiy wrote:
> On 03/21/2018 03:19 AM, Guenter Roeck wrote:
>> On 03/20/2018 04:17 PM, Vladimir Zapolskiy wrote:
>>> Hi Peter, Ken,
>>>
>>> On 03/20/2018 11:32 AM, Peter Rosin wrote:
>>>> Make the arbitrate and release_bus implementation chip specific.
>>>>
>>>
>>> by chance I took a look at the original implementation done by Ken, and
>>> I would say that this 3/3 change is an overkill as a too generic one.
>>> Is there any next observable extension? And do two abstracted (*arbitrate)
>>> and (*release_bus) cover it well? Probably no.
>>>
>>> At first it would be simpler to add a new chip id field into struct pca9541
>>> (struct rename would be needed of course), and do a selection of specific
>>> pca9x41_arbitrate() and pca9x41_release_bus() depending on it:
>>>
>>
>> FWIW, I very much prefer Peter's code. I think it is much cleaner.
> 
> Peter's code is generic, and it makes the change about 3 times longer in lines
> of code, and the following pca9641 change on top of it will be larger as well,
> because generalization requires service.
> 
> My main concern is that if such generalization is really needed in the driver.

I just did a comparison of what would happen if I took the same shortcuts
you did, and I got 18 new lines and 3 changed lines (and some moved lines
that could have been a separate patch). You have 12 new lines and 5 changed
lines.

So, the big difference is that I add the of_match_device call while you
do not. So, it looks like you are comparing apples and oranges. Do you
have a reason for not calling of_match_device? Or were you punting that
for the patch adding PCA9641 support? That's odd, because the point of
the patch is to prepare for smooth addition of that support.

Also, I think my code allows adding support for PCA9641 with only new
lines, while your version requires changing of code.

So, I'm rejecting your arguments that your patch is significantly simpler.
And while I'm obviously a tad bit biased, I do agree with Guenter that
my structure is cleaner.

Cheers,
Peter
