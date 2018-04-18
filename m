Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/J5S40tqEB5DazJmOXmp1v7B5yXbZepb4Ana9He50zj0I3pIUwdk2QWBcfOFc02ZI2u/Sd
ARC-Seal: i=1; a=rsa-sha256; t=1524063754; cv=none;
        d=google.com; s=arc-20160816;
        b=tHw5reiLqZ+RpiLFSo6LmmvsZMI7YlEISO5T5+zbU9iUSVID0gD9fmL3mnPWHhmOCf
         Fle/to8TO9ME3VBwzY9DIHa/K+ruT8+ycZbv9pCRCP/5niu0QYxWvGN4ZD9ELnLMzviS
         k0xRxBtlpfnRlEbR2mqBVzA6409eL59MIhYUNmIrnJydM3MWQOU1JAnplYnExc+1pbvC
         RWoOx2XE3wXpnKrIE8ADhZso6RRDZsX/Ve9TVMfFv/n5OFgInNb1R28/65Cc3z7B4UgX
         mTBcglfirsOBncAMdNaO3AKt/QwTcsEi0mj+1nZQ+heeBS7n+EH2Bd9ccQRj5DxiTyuF
         +E+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=GXbxa+GddlsCPzaKUYunPkHEt6ttFSzK2DK5Cg+L+qk=;
        b=yn29ojqNxsZREkJMkvuCEKziq0mqBOLsLKjd2nrZZqL8tYNIiA8gT/DsjjMu6OmdVC
         vwPnLXrG0vsNEYjCy+otcsdlhysh/vqz2DZ06vLYPJJvtqzb3QjPuU4fdBCt7ZYPkej3
         G+3p7QFDbM8Nfe+lguh4Hj/kUUhiOU+IKYf1FBvSgGW4c2mo06kXP7XKlf2KzZQiCLgv
         qRmELzcduRY1LWt/3b8uI9me+vDp5vHipGAosgAxnuaeGQh3C/AyS5UpZHdXWqQSha/K
         NHoZY2ejThbWi9evqSbFlqtglnrpX18Rlkd1JNj7URXwBTWCpDVippqYzJ/MBJdqzlss
         nN0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=HfG7eNT3;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.139 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=HfG7eNT3;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.139 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Subject: Re: [PATCH v2 01/12] mm: Assign id to every memcg-aware shrinker
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org,
 wei.w.wang@intel.com
Cc: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
 gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
 mka@chromium.org, chris@chris-wilson.co.uk, longman@redhat.com,
 minchan@kernel.org, hillf.zj@alibaba-inc.com, ying.huang@intel.com,
 mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lirongqing@baidu.com,
 aryabinin@virtuozzo.com
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399118252.3456.17590357803686895373.stgit@localhost.localdomain>
 <201804182314.IIG86990.MFVJSFQLFOtHOO@I-love.SAKURA.ne.jp>
 <b544689c-718c-abda-889c-5ec5eb755854@virtuozzo.com>
 <201804182332.FAC65178.FLVJFMSOtHOFQO@I-love.SAKURA.ne.jp>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3a9fe2e8-284a-3d0a-8e75-617e9803e02c@virtuozzo.com>
Date: Wed, 18 Apr 2018 18:02:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804182332.FAC65178.FLVJFMSOtHOFQO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0052.eurprd09.prod.outlook.com
 (2603:10a6:7:15::41) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:YoNrbMSjJsomvPJNbZ1iaYTICjEGTM3U9rE+99uhVuNB3mkTPfB6/HT5TuLnD1rHEkPi2Joj/bWQNbABuQsdenJQIXo59I9393iXjOGhe7MfXNnui5FTI4InPWOUgnWMDdWGs0V7bQOej7/4CoMAz5ekHJ0s8ISungGzraOGh/GFvNdS31aHzJL/PgcrRMA2serU1OVE1maxtEy1qfXxMcW2DGTJGEfAD3ynCnhf9FjpQF3ikIDAIqmLtrN3rNoH;25:1cJ1XQI6o+/ESfI3vDx+5nlzdwpPdZMK4VsLDMkYO/YHVGt07XRtpQcfrNRRSJLp08g4C3DGL45XvNQECBacxuf8NncWMHbLaFXKsaJ2RS2fZX8IZULmtKNivmOPmnVlurTnek7Au5gkOwL/MCImRyywqZv4UKUYsUHrkQ+3/ICToia1n1m3m9HCQeSh2l1h4avhfYqSu42SzOvuWqnit7ZY39R5ovwrlqKHxa2FxEbMqtugWwhlTcQF2CwdNfnIvupCp0DdNhYdf1mwwOeblsBgmSaUuj8CHDHn8HkBGASbaD/bcLB9Q/YxkUU0e7ma7M5nARKbBvzMvxBfNep7UA==;31:HtoUbPbRx64Eo2LnXV4J8eVegn3LN3m8IMaWsRo0pvn9McUvArqdILtRFJ7L2nC9UwRNGPwi2DOEj3b+NTgS8RUa4qKN6MHltPyEXDJVkEnJ0hIsdrS3oatKexKKVc5tTgk01jL2qRG0gU7X098534+/DX6DUkCfRdzpD10mzykwZ8Z4eqqC34eSHEVNsuExn1oyPgwU+OyBQL+pxv/SdCvQL//sUMRjrVBGNjsqp28=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:uIgby55CwEdbt7KtxuwDYGGzE+qcfHemOptxKiyNch9+ug+N6gD1D9HjwVZkARGWhVmKpz0lNsIL5pv83cnQOrbqQ9UcgpGcZlUvkY8XBtgPSHZH7by3aa/qt5k6zGPaKJ0LEHQC9mKGZz4ecbGBxQAj/stoc+3ui1YC3Xdo8PSe5yY9WYQ07scDXF/nVky5QYeU6UN8mEBevDTaKxKhtpRqNMdKcr3vzhWUWSVtiSZuYUrHWmKNaoxfgYbzqfR7YZdU2KrydccpdDr5D+O0Da4gcIZBj8+iD0dkPjFjVr4stYfSGzAKOgxVsY6fGhsKM07bNXMKNbs0XjcQliPgq8HwFSvH6XA019SvDwEFEbx9zqZkUCY93W2cQNgcv78yOfJyiObunbh+MdRWjqgAQWFEhSKaiVWzzrtvpGFT2vSzZKFEw7oniwe+X3B9Hho9Vx/tJBYl1HhhPdeXHSshQKboKKyBN4KnDFpEc2ym3a3BFBu7HajyzM7dHZQtMg0M;4:FrHM7ylRi8P4L1MAUmB6KTi1dd0q/8bSQuVGHXFjY99HLQXHdT/fmq09AnU5AcqBTmzwDJtg3UsKepjxC9HKD34VDd/WTAsVxt0tUhNYSNQFk0HY2w5CxQ47FNxrI6Bh7U5oz85NoW0GXWl3tY6O0XhCZUOifij0Vn33oMvENtbkigMlqBcu8F/oIFCrxPsjvd/xZhHqvX5ZC0WQay+6RiYuBIRSUscbCI+X17kx+z8E/+8gCboPg2t9W75VLxqsLkiJYbcXP6kxyzdscQONGQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1330AB90FCE92B2D11D9AA3ECDB60@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39850400004)(39380400002)(376002)(346002)(366004)(65956001)(66066001)(25786009)(47776003)(478600001)(81166006)(8676002)(966005)(31686004)(106356001)(36756003)(64126003)(50466002)(6306002)(65806001)(8936002)(39060400002)(107886003)(6246003)(53936002)(31696002)(6666003)(5660300001)(86362001)(65826007)(77096007)(16576012)(7416002)(16526019)(305945005)(4326008)(52146003)(23676004)(26005)(7736002)(956004)(52116002)(476003)(58126008)(2906002)(76176011)(229853002)(446003)(53546011)(2616005)(93886005)(3846002)(316002)(2486003)(6116002)(6486002)(11346002)(386003)(230700001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6Q1pLdWVnUDNuSUduUlBJNGVyNXNuaml4?=
 =?utf-8?B?KzAxZyt3aXZkL29XakZ6NFpmTFBFK0I2bDRieDVKaGtKYTlsSXYxSk9ZSjNW?=
 =?utf-8?B?Zyt0c09Bek5VaUdjUC9rUkFGTThEekFHbzVCY3Q0RWVTcVpJYTdtaHU3RjZE?=
 =?utf-8?B?Vkk5TFRFL29tUU9XdDlhd3ZES0F1cGcwTE5jNG93dTJZblpKSndWNW9GM3lI?=
 =?utf-8?B?dEozQjRDTjNhSEZBTzRtY1QrRDdLWjBXOWpNWVJPMGRBVVk2a0Jwbkt2cUpq?=
 =?utf-8?B?V21xRFA2UFVwYjFhYSsxQm1xVXFIay9FcVh2djREcG5GSFJGWmh5cEJzK0VQ?=
 =?utf-8?B?bTlpdkZRM2N6YXpKSk4waW1td015NVcydm42TERxUUV2aDVIbXlFK1BLdS9w?=
 =?utf-8?B?K2V0WUE2a1hlSXMrOTRWOWk3MUlxcW0rTXIzUEo2ZEx0dUVKeklKUS96U0RI?=
 =?utf-8?B?TlBYUjFSejhLNGJsVEVTbjR1ODJlSmpYWkVvN0trVTMzTjNjaElJMlBzKytH?=
 =?utf-8?B?emlGb3J0MTZReEluUVg1Z2Nxb3ZLSlB5R3ArRHRsTmZPdDEwYzJBVStuL21o?=
 =?utf-8?B?TU9CZXd5VDZLNStPN3RTckdNVUF0bEJzenlsV0poaWlpTFd2NGpGcEtDRzM2?=
 =?utf-8?B?WHBsTE1FdkJiQ3hTeE1BRGtkeTV3dmZiL0NJWE1LQ2hmQ2tWQmc2Z2FBb2Vr?=
 =?utf-8?B?ZUcvQ3hKdVVVampyNzN4VlV1VWsxVW1rSm5JVlhCcUZMRUhqeUR6T3c3VGds?=
 =?utf-8?B?bEcvZVg3Y1BMZFBkbjcrMFJxdkhIa3N6bkhVMEFWa01LY1JJWXR3SE9PcFM1?=
 =?utf-8?B?OXJMY2pTYlZSMWxjNE05djY5NzNZQm1qZzBVSjlCbkdhd0Z2ekdiQkF6bjlD?=
 =?utf-8?B?czgxcmlvcnZiUkZDdmJxOFg2YkMvZC85d1kzN0M0UzRWRzdBeGp2UWJPOUtX?=
 =?utf-8?B?eHR4dkk3cHo5WFhKT21YWUxtNm9xS3Zreko4V2IwbHFJVGZpR2dkcWdNQmlX?=
 =?utf-8?B?RWV1dktIaHB3dGM5M3RNYVZ6V2VuYmhQaVhMY3c4VkNmQnc1WkE1dmpCblg0?=
 =?utf-8?B?SzhwME9IcG00ejRQcFlkRzJkVGxrU3R5MnZ5WlQ3NStSWG5zRHNQTERhWjcz?=
 =?utf-8?B?TlZpZDNrMWRlR1ZXMzgxTHUxb2JsQWxGMElkYlJpQUkrMUkvYWozeXM5U1ly?=
 =?utf-8?B?Y3BtbDhPLzZiYjVZNTZ4K1hPdTY5azdDTkJGQkcxbE9obUxUUzFSQldaQ2Zq?=
 =?utf-8?B?QWVjSy9tV3dSKzEwa3NMbldjWTQyNSs3VzFBaHMzRlcyUC95RlVkbzdEd1Vv?=
 =?utf-8?B?dUttM1h5a0pHUWJscW9SS3RyZjV6NUFCUjY1VHU5SHhQMzcwY3NWcXhOR1Rh?=
 =?utf-8?B?T1BQcE42dzRZT1ZuazJreXNud3hnK2o4Z08rK2xwbzRJQkVVZTh0MXR0aEtV?=
 =?utf-8?B?MHF0ZW1wREY1eDJLME5rKzlLRGJ6WDlHSEFtVmppUmRyNWZhNEZHRUtyeFFV?=
 =?utf-8?B?WlpmZUJjY0FENVUwcVdmenZKM0dTcFl5YjFmM3Q0d1VlL3dMSUgyUUtVTXhB?=
 =?utf-8?B?YlF6Q2FJT1N0ejV2eWV1S0xkMVM1dzZDUENvL01UU2VGQzk2RjgwQTlnRmNB?=
 =?utf-8?B?Y2JOU3ZBdTdkQzV6QmhNcGZHUlQ3ZTE2YWNMV1BmTXZqd0x2OUtLVU5IbVp2?=
 =?utf-8?B?ZHRWOFAzV1VyZjBvU2tZVDhPUTErYUNtN090Qm9GcU56S25RSXF0SWFWdnZ3?=
 =?utf-8?B?ZFhCNGtSVWV6L3RiejVNbXJBdnFaNG16TW1STG83Tm5zUEFHZmk0T1I1T0dF?=
 =?utf-8?B?cFk4bmZCS3FBb3lSUVdCaC8xRmpyZ2tHWlc2WGFHTWdkd0s5M0dsMDVrVnkw?=
 =?utf-8?Q?8QsOJneq4GCpY=3D?=
X-Microsoft-Antispam-Message-Info: Y98KELru2MySz+6GBuewKevqtMgBkrsN+E5GLiIcwNET5X+wABhkG7CT2m2DWN1JykuqYsapE/JFEaT4cvLLSVRX3yduDuYjdXZDvxQX9JcEDJVKNTjqw4PDr8k4m5CHqENbBD6+qEMAsx+6mYpnV3pSTfFkwtjxvjo6J6b3263r/lDTQ3zD/2jus7WpDM7R
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:OI+JPvPFfDZBUvJz4xMUnCXgBFe6rYxlFSFsbeDwjuT5wMHiunZyiV7EPYW7N/Tc72TPWGTv/d1q2wFdHYsPAlkutpfkxyT/cAMfNLX3HwaVN6C/eiqIYzln6Hgx3rWJBNoKRQy6uSn3+fUx0jQ28XgEs4qbOGxqci8cduf5Bk3eoS7HgtutliyYRhC5gjMgoMiSUM6WnWhVSDbnYxoNhH1uo0uVsPw+dJn71oXSx7F4yb4uNWamr6ZVYhcMndBL8Anu0PEBfm7hTTtLHvyg+yO0B8zbxIjPPxE3giD9Y0Hwi/i/DAiSHhrhijMz6i8pr41XrIQHQlTMb8peGBZ7q7I0ktw2KYHg+KdlE0pVcXb7zCE9uR/yBvWyk7zRIzzIRW4z0TRhRKqzAkW4fljz0wdwC/pRtEfgY2V9eLq2xpbLxDj0zxB2fVIKyGA02h7GJwgYqP3MB1bqbHJlBNOKRg==;5:pXIywsaeNeWdDd6QSeqgAzNujfHjYIz1uCAMANFKKonRRVGAL/ke3EK6+Qb6dmuC4gDdNqpztTWW2+YH/MgsVg7s0lYuRVftVC67CAackU5dwHW6FULXfV1uIHFFDkIPR53071mUGeMNMyby/w4qMudquryfjWRFPVHAmU4dkIs=;24:sFiJy1UeeJHQhf9WUq/whC+8NcC7HJBZORNBjFwFTX8rvxZSxMuZagRSeW1qFa26JPEG71X2NvejNrJGrtZzyl7NSolckoAvgYLsa500JMI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:Rn3LH+pJRtoVb6oHZpnbsRI4a/gsDs/1EN9+9uy+eWEE+AV23VOT58mR/FQlvm/XVL1mzCKU+dGas3wMwXwik6E7woZICkYKGptRKe1qDf6M32VvWSbSr806f8E8MSe1EyJJV8XgEWIBr+aEFsTx2kHA/t6CYjAkaSvwFSGWxJUb6adOWMtmspVGD7pneZO1MESBFkMWUJ3RfXaiX1uyiChc32t1VNtqP/JgG9v/2Wkl1RE7TaofD4HZlpoUUvEw;20:SKyIiLA4AS1mqymRym2p9dGkYGeU7q1PeL+HEKcMGGvVDvlYhLJSra9W/UnIzApc4nzCvn3PyJlEh1h27tkr/m64qTtpDovC/4fos1zv7WFHk/XxyQICtIerY7uiCiOuwXd3PamCLvSU/L5NuXYMW5vFSDOd4yrOJJ5Ne/Zkgc8=
X-MS-Office365-Filtering-Correlation-Id: e71a2511-6102-45ae-8c53-08d5a53d68c4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 15:02:29.3897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e71a2511-6102-45ae-8c53-08d5a53d68c4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009267479229519?=
X-GMAIL-MSGID: =?utf-8?q?1598096676114697571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18.04.2018 17:32, Tetsuo Handa wrote:
> Kirill Tkhai wrote:
>> On 18.04.2018 17:14, Tetsuo Handa wrote:
>>> Kirill Tkhai wrote:
>>>> The patch introduces shrinker::id number, which is used to enumerate
>>>> memcg-aware shrinkers. The number start from 0, and the code tries
>>>> to maintain it as small as possible.
>>>>
>>>> This will be used as to represent a memcg-aware shrinkers in memcg
>>>> shrinkers map.
>>>
>>> I'm not reading this thread. But is there reason "id" needs to be managed
>>> using smallest numbers? Can't we use address of shrinker object as "id"
>>> (which will be sparse bitmap, and would be managed using linked list for now)?
>>
>> Yes, it's needed to have the smallest numbers, as next patches introduce
>> per-memcg bitmap containing ids of shrinkers.
> 
> If you use sparse bitmap (xbitmap ?), I think you can do it.

There is no implementation in kernel, and search gave me this link:
https://patchwork.kernel.org/patch/10128397/

The problem is that it may allocate memory, and hence to fail.
While adding an element to shrinker lists (and setting a bit
in bitmap) mustn't fail. So, it's not possible to use sparse bitmap.

Kirill
