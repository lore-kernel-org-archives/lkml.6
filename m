Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeC1IsK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:48:10 -0400
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:21217
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752447AbeC1IsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:48:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Wed, 28 Mar 2018 01:47:58 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: David Miller <davem@davemloft.net>
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dnelson@redhat.com, Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH 0/7] net: thunderx: implement DMAC filtering support
Message-ID: <20180328084758.GA12236@localhost.localdomain>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180327.132822.403377635482599502.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180327.132822.403377635482599502.davem@davemloft.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CY4PR19CA0032.namprd19.prod.outlook.com
 (2603:10b6:903:103::18) To BN6PR07MB2993.namprd07.prod.outlook.com
 (2603:10b6:404:a7::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6e248a6-effd-445a-926a-08d594889dcc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2993;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;3:In6uNhH8FcNf9chIeVJJcVKDisKpypo00bAfbvIaYizTYVaxgBmdiHV8J4BLp8uih+SbIeIfbBZoG77X56M8Ynkw+dI9uH21ffzUlwsIbRET+VmfcxMx8Qufjn1Pqh8wUGTSlE0iWI2vRSS0RoknbJxtQ4fDraTVHTwo4Yh2zPLnMTxnC8bknLJY/brzhpcAsINOkUKUM+oRpF78wZ3ESUfW/0/3z8uZZGTna+zL1U5uyQIIKuN2icoyY15WDCOQ;25:EFYTxeCqrNIEcYDNHiRzFev+5nd12j1Hdbjyr/wbNZy91WX6QVXuXQPmgSiop3vtfl2nmulQlaZfbkrIyfTgT5o4EPd2nGyu1eF9U++KRE2JpKNe9YGYTNV52LuEistmK1GowV/4YUriOzBIM6J/845ClsenKVFN15OYZc5yNpMRtpz8Pe5W98Rge/yUFLLfkZ57at/bNTdr3MnkBtEhlfda3Ywy/21g0Jc3dojP+CVnhuWzl8KK0zf6rAIJdcaVSC9dni7bfGfcU9cCVWIK+rp/wC4sITYD1ee8is1GnYXRYlfT7OLaDMTO8fQP9M4K5JT7jh9krZCsFa1ykGdiNQ==;31:G6fkDpTIy6z9fVH4P5Q2GVfqoP8x0UGm4PTpngrO981OJZ6tV+3RdXJTrcat/JGpJwaMy5km8V+E3xAQWHakXCrrmU/KqapAaMUsKGjJheQiJEle64/k7otbWlChnn61UpNWT8ePloIzbUQBeetgBblaieu6l8yOno/O6J+x9rcdpE3pCT4ZzBuan1b2+5nBNKgcwdOnzmI6/kjI4eUGdBdoXQpexaMWqplanOMvE5U=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2993:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;20:TKt2U4NPeFyP+kVWFzW2pG6883R99ysgyP3tHBeyJ8wQZwsQ6HxI0ipu85IK2TUFR4kT2NCCazXe8svulNme7txTgbTu52SGpXwXNwS0cQANwMXfcRREbo60qm/dekhHLdYyxiR+yutnJmVnWW1Ae3CwAgeSBr6ky5AC6zFu7dpTyFg1QyAm4GN/ySkITmOPAfOirytcvRI1lqWwSqGYTWPeEhf70s8Tgi65wlxPVuTa1MH7Wyq83h/+E1Kyjl3yXSgdPT3NP/4UkmdCx9nfHL6BHxa8bDkV3n0tj4xBfnczj5+pm8uCU/a2jtNSQzKpnxUs9aIcfk2ed4+GFffDNTwJ2H9FdekglNZYinYf5iNkYlPwDDfgMiRs4L5nP8UDkM9n9sh6+V8qNGNrnc1KWLh5S+ikLFJc3Q50edY1h3k9kaP6+4vXQykfdRk9F5GRz86PM9B07LO4tbsdap1itfzGtnOScRXRGpLt2FktFiTZONk4/0nXd0MUgBgmTqUFb5hOYTWMqn0P4B4mVXlcq2rFwEeOjks3rAzu50TDZjSFjGC+V8cK9Jj+9viORZOkoMXTIO89almi+7XFxgzT3fLW9OytmCrUVGyezyogqew=;4:Z7qBOo+0zwt7yO6kSG5f8LYRN7es6F6bxWMO1sEfAnz+ne/qskhtx8Ff6wno6mjzAmw1owYckIwb+7ioltM7N0r3NnaRXfCKOPJUvjqUfW//WACNV0ecPUvx+yguNza7kQn7LFKzNPL96O5oPzJ4IIFydV8g3IFyzqAsGGTAm0XOdamP12uD9Bw8PSUkhZgdZ2h4uMaAE5DHkRAp5O66KYqP3M2gzyt1UP8sprBldKmuzuxtlPTHCXBbt/Dg7yHvUWYYKZ0IV9Dzg786lWPGYg==
X-Microsoft-Antispam-PRVS: <BN6PR07MB299360AC7D36CC641D774DB68AA30@BN6PR07MB2993.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR07MB2993;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2993;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(6246003)(107886003)(5660300001)(26005)(52116002)(186003)(16526019)(106356001)(39060400002)(305945005)(7736002)(72206003)(76176011)(105586002)(7696005)(8676002)(97736004)(478600001)(11346002)(81166006)(446003)(81156014)(486005)(25786009)(476003)(486005)(956004)(8936002)(4326008)(50466002)(386003)(6506007)(68736007)(33656002)(6916009)(42882007)(58126008)(316002)(33896004)(59450400001)(3846002)(2906002)(6116002)(61506002)(9686003)(229853002)(47776003)(2870700001)(66066001)(1076002)(55016002)(2486003)(6666003)(52146003)(23676004)(53936002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2993;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIyOTkzOzIzOkpzWGRRWHJiRE15bmxPdURJV2lFdmFjOGJv?=
 =?utf-8?B?RzIxOG9vdTQ2SWxTT04wZU84Q21ScmNqMlNLWnFvSG5Sb2pPdU9wTENTNS85?=
 =?utf-8?B?ckF2UXQycW96SklDdDU4VkpTQ3JsZ0Izc25CMG85djk2UE5ydFZVVGllOGY0?=
 =?utf-8?B?THNyOTBZRGdDK3dCdlhtOGJoVVdqcUVwbHI4YVczcE90TDhlRmM4aTZXNTk5?=
 =?utf-8?B?RnBETWExd2swQ3puRWlTaTVyU21FTDlIaTJCejE4dE96QXR5czdRV1lqUHo0?=
 =?utf-8?B?VU9PcUd5aklIbUpraXR2QkJiWE5UeGZ3ZC9wSkVrNTR0Ylc1TnEyUW5lSWhH?=
 =?utf-8?B?cHNzSDR6cnBHU1FNTzBVT2ROMFdxeitjQjE1ZERFV2lRWWxmdE5rSHRSanNr?=
 =?utf-8?B?RTFBS2ZOT3c3bU81eG9LclZnVWJoRVdaNWNReXlQVFFYYzVNdllyUU5jUlpn?=
 =?utf-8?B?eVoyd1lKRmozUG1OL1ZiWE01TWxUTmdrdkRvdERoMmwrNk9PTTJTODRZb05F?=
 =?utf-8?B?VktDaVBPU0NNOUJEMnBibmQ5aEN4RmU3MlJ2UkdodkZtNUsrbmFRMjJtaVhE?=
 =?utf-8?B?WEVNL2hieTRhU082bEdnSmhQenRRZVlpZy9HbmgyMWtmN2lScnBpMW5JRXAz?=
 =?utf-8?B?WFo1c3N3cHNSR21Fb2FHOUR2WVNZbTFKblA5Zi9HKzlVc3B6WUhSem5SY3RP?=
 =?utf-8?B?QkIwU2JaUDN6WkdzYnZZUm0vbC9SdTRsLy9ab0k4Vm96bzgyQmdVODVCR1RG?=
 =?utf-8?B?YXFqalV4RytxcUhrZUkwSXA0b3pSek5ORmxHMXphR3JiZTlrR0lmbDZTcU5J?=
 =?utf-8?B?TEl0OSswZENmTU1SZUlQTWtzazFmSDR1a2s1UWpNTjhRQ1J1Y1NpNTlmU251?=
 =?utf-8?B?djNaZVlnVlBlYmJRVVhxb1U2cnlCTGM0N2lUaFRHdWlFQytmcDBnL2V0KzZ0?=
 =?utf-8?B?SkozRlptNzAvS2hTNkw4TXF1bDMzNjBWeDBTNXRIUUVrbDVxWDJXTzhBQ2Nr?=
 =?utf-8?B?Tk5SRU5zdVZJU2dDQ3BRQkRGcnJRcVc1dnB1VWVwSGp0eTVkQnJUR3diaFdK?=
 =?utf-8?B?cXhzMkVZb29EazNkalZobDFaQ01vbzdVcnE1MjJOUzZXWnpmSE85K05VVzNw?=
 =?utf-8?B?U2MwZ3l5OWkrRHllcEZlWnJJQnkyL3hkRlFhc3hzMGhZdjVLQzNSeWF2U1RL?=
 =?utf-8?B?eVBIZjVEc2trY2pwd0ZrcUE3RE1zU1hjVDIzMFJXNzFhYS9BYy9FSkdzTGsw?=
 =?utf-8?B?bHMrT1F5WWlJR0xJN1RqUUpFYldQaE1kMVBCVVF2UEwrVzdvVlExakdlcEs2?=
 =?utf-8?B?R1Y0ZEFUR042QS9vTkgyaEZmV29HbFZudmc5ZE03anYrTkN2aXRSbmpiRTU5?=
 =?utf-8?B?RG4rTnBwcU5FcXkyRVpLTkppMW5PMExSQ3N2QlVsRW9qWEFRWWdvN01VZ1Jv?=
 =?utf-8?B?aHhQQ2c5WUlUdWxpY09KdWJwSnNMeFZHcFJrLzROOVFjZU1oQks0Z1oxMTZi?=
 =?utf-8?B?N0plYU42WWFtNzZoMjZaN1FwUEd0YVYrN293QkExRHM5dk83U3ZnZ1FSR2ZS?=
 =?utf-8?B?Z0JsN0x3RlZ0azBndWJYVXJLZk5kWTJKUzFCZUpIZDlIZzc1ZUdubXBFMk9H?=
 =?utf-8?B?dVBLYlRtaU5hNEhQL1VpN3V6bW42MThEc01oT1FJMUNUV0YrRU9WdXp0M0Zz?=
 =?utf-8?B?c1BUZHVrQ1NxbFhNY0NXSVFpcnlFTEQzWGxzZmpSNkVuRFJKeWc0YTA0Z1FX?=
 =?utf-8?B?enE5K2NEUGxqc09wanEvQlA3S2xpWVZONzdnM3FiZllBMFNUWS8zR0paT1Ex?=
 =?utf-8?B?YStTdDVCS001ZkVQUjFRYU5kWHUrS2tQd0xrMVVaelpMRlZoZ0ZSTE4zeW02?=
 =?utf-8?B?ZjZOT3pBSzV4ZXdKMFZZellaTkExMkp3U25vSzllaW9OZEYvOUpJNnlRbTFl?=
 =?utf-8?B?UlVBR251YTJJck9JVytyL01MTGkwMnJDTE1QditkUC9WY2wvMkl1Uk5jb2hM?=
 =?utf-8?Q?MPlkVn?=
X-Microsoft-Antispam-Message-Info: LkdjOlz0eJ+3ovX4pgoxJAx5wr/JUQzYxiOhi8XZawZ2xA75zxzoHdOnNLc/fMRO3nSaSLcSS0HoRwdape0DXOZMJeO+WliuGJj+dELDhVoi3EaOLlxeihqVLHGXWabOhff76oLBmTS8OkP5e28KWjz5S1DnvwH3njuqB6NdojcrlixsRxMOaGAYdr5BL9Gg
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;6:zkDpy/BK3emkz2emYQY+bFZpDmClBL8cJ1BPU1b41IcU4Qni2bN1rTDOlSEkTBOemBMNL+WM7lFH5fp941oz2CCazwtuQ3X1+KiQCPUV8VjhkWZz/Aei/+ENkU5B5Xqj42O1RZ5sVP6yf7E6ddKLIYokMcwwiOd8/RPGxv/zLMaI2BStl5iUxgtOiN82eQCzE5kmOOiYJAj8z7hSZ/A8xX506bLtnsoY0fhldf73+ytJNfrpLj2MTQU7wgUTj57QBbvuN5z5eiiEZ/4c9HYJEjiw/p1I4Zprgce/FnU3LkNyP0j6BEZ7V6XXy8VkTQnvEM36Isb57JjQGWrGz4qynL6KdvZhkt713Zj2LyKOP3lKdU+MAYaH5S760hQV970W2LdLUx4ld6kcbH3mYKUnEvE2vxmdlwXTVCwqzIFnSFl3AnlKl1EzkEK7gexBy8UYyPbsieziF08JluVeqLUZDQ==;5:Xbo69hNa9IlYonLmbI+qxPTdBi5kl6fwQlc4dmvNyHDkpQytfZSTnnS44eP8ULFjbpiHBrdzK39pcvhKEvufNz2rahmcaigYOCi7Bzvo3fTLPfxkpbLXZ+XrWlwMsIn3pRXCLfxf6+rI5n5Ic5eDlCiXIZ8eYsybbcOhNtYrCjs=;24:FazSfNDNANIeNiiUa/zL2i18pZ811G7ZGddN8eLW3SR3WMa4II+HXZKVJsNt3Strfovw8jlBpqIF/Rsg/dmkGhiQw2RzCokDJXrx1JvadwI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;7:O41NBsiOPTD09xbbePoq36xIegpmFZR8m7/7INnsLEMJJu7ISNqqAUOSSnUxX0bea5xwhqk8lutOsbrS7IwS4v6ghs9SOeVsSSadVK8kbny36u0/MDB8CXPwbVkcwDK4a49jrDeYJ+2zqYrDaQ/EdFUHnmVbDo/3+ZGLTGe44tf98dt6OlMwfU9UF5dBfuM+YVPZaKagzn2xtd5a1zN4dybE2zlhiZPS0DDsNnX4gHnU1TM2jCJmGHjw6smgj0kb
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 08:48:01.7728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e248a6-effd-445a-926a-08d594889dcc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2993
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for feedback.

On Tue, Mar 27, 2018 at 01:28:22PM -0400, David Miller wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> Date: Tue, 27 Mar 2018 08:07:29 -0700
> 
> > From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> > 
> > By default CN88XX BGX accepts all incoming multicast and broadcast
> > packets and filtering is disabled. The nic driver doesn't provide
> > an ability to change such behaviour.
> > 
> > This series is to implement DMAC filtering management for CN88XX
> > nic driver allowing user to enable/disable filtering and configure
> > specific MAC addresses to filter traffic.
> 
> This doesn't even compile:
> 
> drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function ‘bgx_lmac_save_filter’:
> drivers/net/ethernet/cavium/thunder/thunder_bgx.c:286:3: warning: ‘return’ with no value, in function returning non-void [-Wreturn-type]
>    return;
>    ^~~~~~
> drivers/net/ethernet/cavium/thunder/thunder_bgx.c:281:12: note: declared here
>  static int bgx_lmac_save_filter(struct lmac *lmac, u64 dmac, u8 vf_id)
>             ^~~~~~~~~~~~~~~~~~~~
> In file included from drivers/net/ethernet/cavium/thunder/nic.h:15:0,
>                  from drivers/net/ethernet/cavium/thunder/thunder_bgx.c:21:
> drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function ‘bgx_set_dmac_cam_filter_mac’:
> drivers/net/ethernet/cavium/thunder/thunder_bgx.h:61:38: warning: left shift count >= width of type [-Wshift-count-overflow]
>  #define  RX_DMACX_CAM_LMACID(x)   (x << 49)
>                                       ^
> drivers/net/ethernet/cavium/thunder/thunder_bgx.c:324:8: note: in expansion of macro ‘RX_DMACX_CAM_LMACID’
>   cfg = RX_DMACX_CAM_LMACID(lmacid & LMAC_ID_MASK) |
>         ^~~~~~~~~~~~~~~~~~~

Will update and repost series as v2.
Do you have any other comments ?

WBR,
Vadim
