Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbeEOOhX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:37:23 -0400
Received: from mx143.netapp.com ([216.240.21.24]:55175 "EHLO mx143.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752173AbeEOOhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:37:21 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="259088199"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Peter Zijlstra <peterz@infradead.org>, Boaz Harrosh <boazh@netapp.com>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514144901.0fe99d240ff8a53047dd512e@linux-foundation.org>
 <20180515004406.GB5168@bombadil.infradead.org>
 <cff721c3-65e8-c1e8-9f6d-c37ce6e56416@netapp.com>
 <20180515141721.GF12217@hirez.programming.kicks-ass.net>
CC: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
From: Boaz Harrosh <boazh@netapp.com>
Message-ID: <99bd469f-5cec-c537-ba3e-738956070a8f@netapp.com>
Date: Tue, 15 May 2018 17:36:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515141721.GF12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM5PR06CA0021.eurprd06.prod.outlook.com
 (2603:10a6:206:2::34) To BN6PR06MB3076.namprd06.prod.outlook.com
 (2603:10b6:405:3f::34)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:BN6PR06MB3076;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3076;3:kY3GOGIWO9j2i92QjbpReUDAgrY/kdqeSxjeBPCPAelA2Q+UGLpD597heopuA1Ky/6llsxHPyDyTkg9+G6hVBjEdjFLe7pZGfjjXNUHZV/HOpi8L2zRrMfUK2iovbZYjvD/9/JeSGfCOWjd4PG22Y/C/EMWctXxeyCV8+rUWMa8HJiuCEhtlcPKudHUSq5FCAmOZxE+C+YesC/QV+Rel0Qqr4+c7NGaiu1OfkHAi74zuAI6iuX8+7poPw2tph9vU;25:N/rGUVMRLPliHTsvrjlES+TGsNvIqWiebNnufvcFioNRtGTXjlnIuXrBrubz1G8wA2bet61X0sCve4YF+AhkTGtAX0rEoNL4NpD1DqMKPAqn98iY47mBCCPmbgpjwzTurU/eifLm0/hUB9cNGtLRHYF3V1bKtKg9nui7gC8r00sZFA+KmZwCB7qkSQZ1tZFLiN/As+yYas/t/bjM8vtvRMjYpmFXu0l+edIFCLd+2ua6GN1FWjApfoyWXywjx5gH6a2v2ElTBxOw+re1arsLocthyCgZspsDiEuybZd9A0Zo8TqKBInVqZ3QVhVEGsvbZM55CD2piONHEMj7XvaCPQ==;31:dgS8U8nnFNREL+4qbw4TWPvmp2LTDF2CfFiNZT5NF4W2dYsJ/VoQigcC6VkyfMaPW75PPnJMlCoRB24KXvJmPUpin+1NZIJAJGvqlOJiMbG2pEpHNKVcakrdRpQ0lXLI6MihLL/HzMp6b/Y199Tssezx/st7uAwT9+n0Sjr1wDyyYXsQBVQGesvYXymNCWSTxjtBUZ4pecmlZ4JqrzSznhh0i4mvThsF8ybKYmQslXQ=
X-MS-TrafficTypeDiagnostic: BN6PR06MB3076:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3076;20:GJNCU4rx4vLYoBykbN9HlnmO+d6RPggMITpRxBobveUv6VeW107NI0iZ6n9iCOP4XZfk/xo0C5nV6G3rsBYLtwltkExzoX+xPon5d2U7aMlc1nbaj+o6GsVCLslJAHmezgHCiXvKgzgEmT/hncBz8TOsYdrEHMl5GPB+abg+Sw02YqzIbK1JJ6KHGmBR4s8x+zUIMYdOkKZlhAY/Vx2XaR18M/1BKmuQGo5nx3+GRjgkLxWTdMDf5XvufcTb/Acl/BA1sdp1It0S4hEOQac0YfSCobChMq/yF/mu4qRBzvf83PE45sXkBlYLl2Q5RyNwS5xG81sftalhP+aLLUlkoeDWB22zupyq3h6Zzm+pjnlGc7XWsBUOWBE2cRjyDRENi4C9G2cijs+Htqb7p7ifYx/UD04njb+wzR9iAMMX6MvoAPqQ4RPrbs0RXPucFF/lBzMbvoJU09b/QQWF5OcRivokPc0NkJCvcKz+H5tufG8PGxjJ0cs6C3y1jKDZQPfC;4:YwYc8lITlj5IYTXil4dSyixj+qmFNvo9W/4OXXfAecBJl3CDVnAuHQDRHAru07yYbosF3VyPn/R3DP6VEfDnvo8oTaWC8le/KQJcQS14RNrx12L0jn9+PKFDvInLha1D9kk0h53y/KIyGWBGcNB11JTvEQIVnSI6uShbC63p3PVbxmGCyIxC6V6Nloh17PXdkP8TW5yWUqbjAKYXXv7Pq8EP4WX8XExBe7Hz4QKMlzR0JZDSqqr/mIl9bbsTax8oUKwdbsVuRn2q87CQXoAwRw==
X-Microsoft-Antispam-PRVS: <BN6PR06MB3076CD46738A40A8D7EF50ECEE930@BN6PR06MB3076.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR06MB3076;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3076;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(346002)(376002)(39860400002)(39380400002)(199004)(189003)(50466002)(316002)(72206003)(386003)(53546011)(478600001)(54906003)(97736004)(2486003)(52146003)(23676004)(110136005)(52116002)(31686004)(76176011)(16576012)(8666007)(77096007)(58126008)(6116002)(3846002)(25786009)(47776003)(93886005)(65956001)(65806001)(26005)(66066001)(107886003)(6246003)(4326008)(53936002)(956004)(476003)(2616005)(11346002)(446003)(486006)(305945005)(7736002)(64126003)(6486002)(2906002)(81166006)(81156014)(230700001)(16526019)(7416002)(36756003)(8676002)(105586002)(31696002)(8936002)(5660300001)(6666003)(106356001)(68736007)(65826007)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3076;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA2TUIzMDc2OzIzOk9XSmNSZWFSZGl6V0VTUEluNTlNZ0ZJaHNN?=
 =?utf-8?B?L1l0UjVlRkJ0UHJ3OU9ZVUQwejI3RnZKWnNNT00zRG8zRHhCRHd0U281VHJR?=
 =?utf-8?B?Y0dwU2d3K1BrZXE2SGVUK2tSWmpIWm1Za3ArenJFODVOMkgwdmZwSURJYm5p?=
 =?utf-8?B?TW1oRklsaUJETVdZemdrT3BkbUhWOHlyVmUrZjFmRnNZTklQT2VGZWVqeWJm?=
 =?utf-8?B?MmNyOGJnYTNFbWczSXFNSXlNWHpPSmFCRitnUFRLeUE3Q01ubFIrSCsrc0ly?=
 =?utf-8?B?eDVrbDI5ZktUbFpYS1dXa2h3aHpOYmtsYWQ5R0VzYklRNC8wWVhwa3JyT0Va?=
 =?utf-8?B?aWhlK091dUg4ZEFSTUcwZitDemF3L0FYVHpOUjRWOUJFNkVoQ0pTSmhqclI1?=
 =?utf-8?B?bmplUlJTTXhZT0t4dktMY3AzRExFanRRSHpyMjhiY1J1T3JsZkR2OEVtSStC?=
 =?utf-8?B?cWVFdkR5ZVNHekk0REY1RHAxeGpaRVFMUDlGYXhSV05TWmpzNVV6TUc1T2tl?=
 =?utf-8?B?UGlqQ0JBanZDL0VkRDlBN2ZJZ0VaSkdaUk82eVdiNG1qRWNpZmVXVmJWSmpN?=
 =?utf-8?B?YTA1Y0oweXN6Uk9uS3VsMlVDUnZhZ0JrWi9TTlFRMXE4dk9TcXdYamF0T20r?=
 =?utf-8?B?UUdNQWxKbVRZMUx0UkNxckhmZ3VqRzMwWlI1bnZSenlhbkdldnRoNUtDL0Vj?=
 =?utf-8?B?aGZLaWswVGtSejZ2WFBzbExydDdVTmw5bHp3K0dMeFAyZVVPV3dxVUV1K0lx?=
 =?utf-8?B?azJoWWFIdDY1OFRxeUpRREkxTUVsMVdRVVA1TVVhSUZmN3VpSndrM3h6MXdQ?=
 =?utf-8?B?L0dQK3FQeEVYWGYzUXJZSmYwRklscndNZmY2aGxXU2VQODhiWldheFhTNlZH?=
 =?utf-8?B?SkVuQ0pER1lmeTgvcThNNWN4cVZTUnEvVjN2dG5RN1NiVXlqb0VPRGhsb3FC?=
 =?utf-8?B?TDc2WU9zQWhXS3B2RTBDK0FGQWlNdXlHS0xDRzVESzArdHlhZ3NsdXhZSEox?=
 =?utf-8?B?Qnk2WFl3MzdscmcybmVmUjRoby9QN3g3Vkg4QjFhUzFXTXY5TEY5OURjRWx3?=
 =?utf-8?B?VEtmNVFlc3l3eGtnbnY3K2FqeFh0YnA0eHZCbm84K0l3eEZKNGsvOE5pait0?=
 =?utf-8?B?OExFQkl3amk1b3NQMFdYVXJ5OFE5YjVXbS9mSUtRZE1QZjFHbXQyUlhKNzRF?=
 =?utf-8?B?ZHF1SHJSNUpGV3ByenNnajEzbnUvdXJoNnZYTkJsdkFYdFJaZzAxaWRBa2pS?=
 =?utf-8?B?c210OFNmYmVHTzdMaXJrUTdmTHdmQzVrSEtVd3VMQStQRm8vS1ZGM1RHNTZ6?=
 =?utf-8?B?WWN6YmE5QmZrMkJrWThIV3R0Q3l0SVpWelZ1bzk0dk5ROXJVOVdxbXRIaVVJ?=
 =?utf-8?B?SzdJY2JvZ00rbWoxMEZoZmVjWWNjeTVaM0YvdHFXak41bUFkclM1dHNmdXBr?=
 =?utf-8?B?MXVpeDRRWE5rOGRsWlkwWmo2U3BidUxrUHVRRkRXazI0d0pGRmFuY0RSRkRF?=
 =?utf-8?B?T3l1VEJZWVNsZTVNc0d2dmd2ZHFNR3VGSjl2SFVmU1RmdzQreFFCZVcrN0hO?=
 =?utf-8?B?OTJSd2lqNmpBSHNhenczM2p0ZGtXSEdLNVNMTDhjN05nT2RkY2xWNCt3RHNa?=
 =?utf-8?B?d0dCT0FUNnl4SWlVZUZMRVZ4QWxiRmZzWjd5TTJvZHM1OTFkbXdGdndiencx?=
 =?utf-8?B?M1BsNkhMRjJGdEdGYjhxMkI5c0ZVU29OSXVrZFFNaWlWaE9icmZPM1JHRDlq?=
 =?utf-8?B?c0FQL0NGa09nNElhU3VGMWpFb1BjUWFoQ3M5UVRhUW5nWCtDK1JaMWs0ckZj?=
 =?utf-8?B?WXVlbjRPcWcrbXZjYnlSTnhZcE5vUG9FRldhamJ3MnAvRWdpSG5lck9GL0tx?=
 =?utf-8?B?eEFJSTNoR2d5TFBJVmljOUY3ZGtIZE9vQzlJWVA0TS9NTVBBbzhJR0psMUxt?=
 =?utf-8?B?SE9iRnhKd1I5blRJTHdoK2QybmlvbnJnNTlsd2M0TnpSTVk1MVhONzNyQ3JU?=
 =?utf-8?B?WFZYL2NaeTZtakpWQXVGNjBLSzNiMXgydXJUeDZSYlA1S2NiM2NuVHFFZWdt?=
 =?utf-8?Q?fjZU=3D?=
X-Microsoft-Antispam-Message-Info: 90OGM1WMCjn4WM0PXvqjFmg+ECya3hLxDKwNF2VVCM02ml/fVplyPTeWzsfkDaCbMuqtqn4W4acY72d9xIkxOd97pWrMulGAwtZKNKlBvMOntM0VPjv0u+VNQrrQUe8N6DUZbg/7cVHsxLm5wDiM/azwyCn4cAfjcg5ttzGH5TgHxZHDpJLsc0hv1f0SWgtv
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3076;6:1vbIrg+3qulp5Rx8cKC/tAFMdEW7EfULeAj55sa1wFmZxY1mVH6g4zsYra4pYHLZ5aKLa30PXUVNlo2J6Y51FFd+eLbqWMreU6PkDFwDkXhQ46YGFXOtTc/uwAfBL4yDCNIC8Q4bniODCKw/lfShAbUN18KKNDbB8M+8Npd+i/qU9BuJrcFfrAlE4mAKdIA5dgdLuLh4S1d/UD+502/NcoIYoO4Jwv6T7uvR+ZqJc3Wpz+wPuBki3/yyOAheiNR/hvGwaFOVtpUNbw0bBCu3i6U8Zi04s0y4gkEkMRLZD2be8ydef1JP0fyraB2RZRspVO4JUtFgUNPSJYFpwU76by2GE9Tfe1CNiO49Y9epSu3Q7GO0c073Ca05w5TmMUxWkVrqdQzoQ4WtLu/JMWRgvx+YUxzrx88+4FLa3RFxZPhjiBR+qzWtIbMwjZZB7qUuDMjkedQiUHceuoMeIOkzHg==;5:s85SNoOBpXyKIMs448wOjs1aRl360kx4h/qDuNAablAQMsJXOTzEhZfO1Q0XliNqvkXRh/m28YrbypifjiXvmv5DmvD6ylZRlMhB3vM+AH7byEmxGMs+wk9XAZjj/5rnJEPtQSnxvOX9Z1FMLRCTRd+qLAqXYxydQh0fp1UDe/M=;24:Q3y5oFMBBj6/DvPkD1HmMMt3s9zYXt58WJZeBdV/pXb9Bl10DS2F9VMOJcitH7qjFsK5sZmFgGrecPpzrW73VHLkmvCaPMIjprG/PYId3jc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3076;7:hafDSLnNYq3EjKLEV/NSTKjYN1pOBfkAlYXneJZh51Or8/NvjNcon2FMi35FCzjD6pGNSoxVsHk5F4MoPcWgcoDIyulSjg0hlc2ws2v4qygtp1mVa9eRHkcrBkIk2QHbJ2iu4+bIi7jxeXCnhnQXO5/c143xopas/RcQMsxiWgIGswfDV0VLz53jtEYM7GrSqqAmWiFvJSGOqj6ewU2jek4L08Aajk9WM4bY1lDKQ6oROB95vL9mHZaLYlQ3SGv0
X-MS-Office365-Filtering-Correlation-Id: 7e6788a2-d726-4d23-ed27-08d5ba715131
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 14:36:56.2371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6788a2-d726-4d23-ed27-08d5ba715131
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3076
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/18 17:17, Peter Zijlstra wrote:
<>
>>
>> So I would love some mm guy to explain where are those bits collected?
> 
> Depends on the architecture, some architectures only ever set bits,
> some, like x86, clear bits again. You want to look at switch_mm().
> 
> Basically x86 clears the bit again when we switch away from the mm and
> have/will invalidate TLBs for it in doing so.
> 

Ha, OK I am starting to get a picture.

>> Which brings me to another question. How can I find from
>> within a thread Say at the file_operations->mmap() call that the thread
>> is indeed core-pinned. What mm_cpumask should I inspect?
> 
> is_percpu_thread().

Right thank you a lot Peter. this helps.

Boaz
> .
> 
