Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeDFIN4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 04:13:56 -0400
Received: from mail-ve1eur01on0085.outbound.protection.outlook.com ([104.47.1.85]:13024
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751418AbeDFINw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 04:13:52 -0400
Subject: Re: regression, imx6 and sgtl5000 sound problems
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, Xiubo.Lee@gmail.com
References: <f9a166cb-9584-5553-bb72-35b22a0652d7@nextfour.com>
 <20180406072317.GA10500@Asurada>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <cb688eae-0438-3c6f-47cc-86b2a1f88de0@nextfour.com>
Date: Fri, 6 Apr 2018 11:13:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406072317.GA10500@Asurada>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: HE1PR0402CA0035.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::24) To AM4PR07MB3330.eurprd07.prod.outlook.com
 (2603:10a6:205:a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 071b6a5f-efd0-47df-595e-08d59b96541a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR07MB3330;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3330;3:09jeU0FX95Z5eXAHNXUl5Lko9E5FXWVced+tSKFfDL4hrwDz2KnuGc7DJDz4v/S376ZJvCTBR3nsRpWPC2gDcJ7cl82nz3Jvl1oHj0+4DMKhwbnK+9fFpzDUkLoATOTQTbLehy/EKyTVxvrmwoIm81d2yWgBsNTxgsV1Sbs5XkBTF/xeXptBwymbIa5QrdXZfv51Xg6qz0whacPzPcNvW5ghJSSQHsQSnYhy2HjUjpe4sryTiCgeNwhwqBTsiVFu;25:a/pHLezUqUcdvQXrZaQUIoUMn6DiW2f9e7LruDOP/4bB5AyX9ilOGjo+rGyQB3LG5nSR1JVaDn1MvsvVItz4WoIAOtZwJsqwMa7Wr3hWony66/uingQSMtZaub7lvmFX2iBGUlM1LEKSMbl91SozFqO0qNbSgDLMOEMkC/QxCAU0+9YPQZPoydUgn+TTMyOgfGpP9d/dk6Ge+4RD9Gc3y0OQeWYqdvagOJLFlc8zz8m3RinzJgP9jQxTTPZ/FodNBfDl1JVey4+Phg8IFWrl5nRBqsds7/VH4tJtacexVl2coL1Hm1wFYAHDSEe/oOBCddSjjCOcSfZMWSSNhGQIHw==;31:sfHKV0tPbMur064tr5KsDpIe/CqCTvMuUZ5rFxip9NLzxoFpZgvZHisVrsJcSkNwAq+3LS2/3omvGiv8Gnsy7naOO+JYrdoLN9AXGskibYyUevl8pA/+Omu546CufMgqpI+F5iJd7ybN1UVtEBWLRg39J+iqv1OvJjfJYeV+f9iGtGYyvRzrE6y8UUjoi8fk16Ciak1Aja6BUqC+oEeS8mMn/xGGhgDDTX7xzl2NSys=
X-MS-TrafficTypeDiagnostic: AM4PR07MB3330:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com;
X-Microsoft-Antispam-PRVS: <AM4PR07MB3330B5DF3B2AABC9EFD7FF6083BA0@AM4PR07MB3330.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123560045)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:AM4PR07MB3330;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB3330;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3330;4:7rD4e5ZVj/jlA/d48w4zoKcwDwYo9dsVZ5QYaj1M6XsdzJhv2rqp9FUkOXLYEHEpcvsXe8MJDOZ19ApsVeI01X9MupjN2mNjbK9CQA6bte4Q9ZP4YvUH0l03KP5cBxbLOofIzFxcmKbN/Q6A8REDQzatu+zrfSGaUghnAe5MOrdk2LlKe5of8ix7D8a2RnamHisxHCQFsw+N+5kptoo0RgQNxM3r0YIKxkrP9SR8Yw9Z28I9aY2igdg09b6ot3ok4b7YtQq5+WuOaGBkfrBWJA==
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39830400003)(346002)(396003)(366004)(376002)(39380400002)(199004)(189003)(50466002)(7736002)(25786009)(478600001)(186003)(31696002)(16526019)(6916009)(77096007)(6486002)(97736004)(105586002)(1411001)(64126003)(106356001)(229853002)(6246003)(486006)(68736007)(26005)(8936002)(53936002)(31686004)(2870700001)(39060400002)(86362001)(52146003)(2486003)(47776003)(66066001)(8656006)(11346002)(956004)(65826007)(81166006)(76176011)(53546011)(36756003)(8676002)(65956001)(81156014)(4326008)(16576012)(386003)(54906003)(3846002)(23676004)(65806001)(52116002)(305945005)(446003)(316002)(476003)(5660300001)(6116002)(2616005)(2906002)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR07MB3330;H:[10.10.10.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA3TUIzMzMwOzIzOm1ndzNqWWx4MEFSQmpyVThEbk1XQlBULzc5?=
 =?utf-8?B?d01kRWdON21YVVpLQTFxeU9wWmFXeXFRM1p1RHhYWmd6STNUSkZaR29OMUdQ?=
 =?utf-8?B?MDJpM0hLY0I0TldyREdUbDBVVXBCOTNjQjJSTmsyajVBYWx1bkp5bUdkWUVz?=
 =?utf-8?B?OHdiK0Y4RGV6YUJNV1lzUW53b0QwOUZ0cG9hZERDcmdJQ3QzYjh2UTdCUUJ3?=
 =?utf-8?B?RjljaE1rcGJBSVM4RzRyQkxURFBmNEZKTWRtZ1lPNUp1NitYNURCT2U1Y3Y2?=
 =?utf-8?B?TlVFZ2luWTdEL0sycHRCSzZObkVwM0FQVGl6MlJoMXNkclVKOE1zNDhLQ0l3?=
 =?utf-8?B?MEVXWG1YUFJUWCtJRzhOT3duQ0JqK0NXeGwzVE1LRzlWQkNiNlZzZm5ETTlP?=
 =?utf-8?B?NWF2bWp4ZnJsWFNzcmZDRGZoWE95Y1RVZVkrUzlFblJGWGhzWjVMZDllcVBJ?=
 =?utf-8?B?b3htY2tFRGxzdm1jQWNtdTdYeHE2NjRCS3FxK3Z5RGJ1MWFzYmU0TCtZL0ND?=
 =?utf-8?B?TDVKejVvRGNITEdjQzBDYk1qRUpYNEpyV0d5cS9pT2krN2FwMzFIdUExOFB6?=
 =?utf-8?B?MWJqUXZMVXMyMVcreWJOdUovWGEyMGdUU1VnZnhhcVRzalhld3U2WVBFMjJ5?=
 =?utf-8?B?cjhJb0dWRmNWSTRwOEVwS2xXVFNudEl4aW81SFIvM25sUlNYelZJbjZsWm5C?=
 =?utf-8?B?Q3RmUnFUbXJ3MUpNc0RGd1pXZE9DOExYQk5aQThwa2pvUnZRZTNIQjAraHNl?=
 =?utf-8?B?VGQ1U1FCN0lsVjBMTFZtc0NpRU5MOWRwdW5SbG5tMS81bDhHVUF1VkQ2NVhO?=
 =?utf-8?B?NFVOcmRTWTExbDd1TW1VWXh3blFnNVgxQlVNVGdxVzJPQm03bVhDMjYxeHFk?=
 =?utf-8?B?dGhaTnV4bG9Qb1ZocllxaVRJVTh0cXpraWZiekh1cVVycTJRdzJPeWE4K08w?=
 =?utf-8?B?Nnp0YmZjaGRWWDh1SG5BSUwyRnVSelFlWXl3NFpkSHc2clRXK2VzMWo5VmRh?=
 =?utf-8?B?RDBWRE1KbERaSjd3TlMzRzdNL1NXeDU4YW1lYjlxSG9MS3RYQXgrVEdZbFlj?=
 =?utf-8?B?blhRYVMrdVNRY1F1bHFiTW1aSG10czVaQWJjU2dGeWwwQnhlN2VhR1dQQ3V0?=
 =?utf-8?B?SU92NXV3ajRvc2pEUTVMaDdTbWlzTWIyMTU3NjBUcGNXSXRyclRzUkxBRnlH?=
 =?utf-8?B?c2JjRTNDL01kYlFoR3BKZEs5WGIwUFJYalZPMVZkTmh1U2wyeWt4YU0vQVFU?=
 =?utf-8?B?eE8zUjZiVUZwa2dNK053VTZRVjJzZGxQQ3ZGZXJKUlZ3Smx3alBpRDhmU0ph?=
 =?utf-8?B?M0svdXcrS25aL0ExejRMRUk2VWhPZVRnVGRRNFI1ek5xMCtqKy9UWWNvN1oy?=
 =?utf-8?B?YVlnSVZRbjZVNzlVVmZCUCtrNXFrczU0S0dWQVdJNGlOUmh4ZU1xb0swWmVI?=
 =?utf-8?B?MUpHVkR5amdjMWxrUXZCR0N2RlkyNFBYZld1V1k5MEJXc1kwWFNQZnJWSDlR?=
 =?utf-8?B?RVhjUHVpUVA5ai9pbFNFVFBlL1lzM0ExV3paOEtMZnd2NWxTbVF6VUVxK0N5?=
 =?utf-8?B?OGZnS01NS3l1RHpEWVp4TnpLeWFMUTJZTkhiY1o2cHVLQ1VQZStrMWoyNjg3?=
 =?utf-8?B?REkvVEdwcjVhaThZQ0taQnB3QVdKSnRya3ZGWDRmanFyTnZqdlVFUFRpbHRZ?=
 =?utf-8?B?RkU2NEFBRjJPVmhyK21lK3ZVZ28xOElaK1IvYjVMczc2UTBpRlZQZ01vMmxq?=
 =?utf-8?B?dEI0T3dYOU5xWVdMalZmSE90OUVxejl0YUppaHFaRHVJT1lEUjN6QVlaWGJQ?=
 =?utf-8?B?VHJsNkVXcTZJUmNqTFVuM1NyVGdud2lxZ2ZrZ09tZ2hzMytnWk14cGhLN2dC?=
 =?utf-8?B?NmlLdGpMUFl0bmNob1BLcGx3TGdqazc5NWx4L1o1REZnZHdTM0hoTW1mYzBw?=
 =?utf-8?B?OWptVkc0MXlaeVNydGhHZ2RrT25nZy80S1o1bVV0WkZrdFRNNERyamQ4Qmcx?=
 =?utf-8?B?V29OcTRqR3gwMm9JUmtJWk9ZWWgzbXhBUU1SUT09?=
X-Microsoft-Antispam-Message-Info: jQy/KYtq4r2DMLQrZG9iVytH+MG6IhQ/ocRyl338o1KE+HySPhhKJr7k2M8O/qth7MNU2JnZJs1xvYd+MYR7521FgrbJvfJJbnjZrnRJZn/9Ycqy7Tk+fJdnZgftA7PD64hz+N0rQfs1tr6ALhLVFtQGxGn5RVsH+AE9t/b25lO9Sc72ShdRMa8h5GqYncAV
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3330;6:UogF0yBxCP8YQLIqDLFd2jJVN2s/+u8alj+P3mQvec874/O9vfzlFjWgp5QSNCjoFNbCc5JWYH7HT/aLWv32fB0C8Gd09HCeCfyOmHPkHg7D3hwszoX114zZbP7K1pQr1ny7B2faa+3EHVaz84Kb6pZ7kSy7POHUseBTqO1TifC8ZorxsM7sF/KWiLGFWqPFYDO1qB5QxU79n3B9VOYcspjtITLe3ZpHcKKzDF0ukBFRuAH+q8rT1sUyINAyXhuEHvngjEAA8ic+pnfNxA+njFbfIyBrTyAYJmtk3KZUFLBhN16tiieJL1yJJY2ih3g/LFcjL9C6hqQqlEeYUDpwe8i4XO+gNr5z11WgdKGOucesmmNxyQCvP54fUyVuaeJty++FFAfRsf6ivsmH4rcuHpQwyx3rpRvDLbazHYKmD7fR3KXMin9i6sKw0iqVCYK3s+KkQCkg5nMae05GD4s4JA==;5:IfaL+miJAmP0bAZXduSB59lhKmk6zq3KWf0NSPNEi0JjtG31e43PiyHgB2rsG4KdgQYHFPr2bm1zWiBUfrEeJmBtuKZQY2RP2fH8s+YnXY8yo43uB3eIy7/tuxuJdslfaBjo1u+NKGSmRYU0lI8vaj/5Y//Mm8b5uuqiRNpwINA=;24:FfC6b3BtwbC9DO21uXcl6y4L4qK0VBgnMV69ZhzR7epatVROYA5B3pYqulUqQneBK6HfYb7cCbuxouuegEVqQzWO6FeqhFh7RbsniXkoWDc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3330;7:qOsfswhx2N5OQLWlwUX9lI2CCjbDHMsfeN/NFsO43ogInUq8HS5SsEPoxbk62afrEu4g5YIjANdiLlh6MVt8ZBP5yl5ka6g5XxHZKGqaebKZbJSUe+D5Q2rYdpSIov6diJP2V/h9p0Ol6pem5MTU4TV79LbilO/hEN87x2sIGY+6V0EH4lb15YzeRJT4Nn/sgDAsdS3dj2IiCmJ+MJm9kOrfS0Y1yDhsTDqHZTLk0sMfeBVfw6l+2gZ2Vtofdvbd
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 08:13:49.8183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 071b6a5f-efd0-47df-595e-08d59b96541a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3330
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2018 10:23 AM, Nicolin Chen wrote:
> On Fri, Apr 06, 2018 at 07:46:37AM +0300, Mika Penttilä wrote:
>>
>> With recent merge to pre 4.17-rc, audio stopped workin (or it's hearable but way too slow).
>> imx6q + sgtl5000 codec.
> 
> Could you please be more specific at your test cases?
> 
> Which board? Whose is the DAI master? Which sample rate?
> 
>> Maybe some of the soc/fsl changes is causing this.
> 
> There are quite a few clean-up patches of SSI driver being merged.
> Would you please try to revert/bisect the changes of fsl_ssi driver
> so as to figure out which one breaks your test cases?
> 
> If there is a regression because of one of the changes, I will need
> to fix it.
> 
> Thanks
> Nicolin
> 

Hi,

We have a custom board (very near to Karo tx evkit). The test is simply aplay file.wav, at least sample rate 48kHz tested
and not working. Nothing special there hw wise.

I try to bisect it and report back to you.

--Mika
