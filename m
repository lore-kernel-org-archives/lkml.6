Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383B520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="Kr+QhZvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383B520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936928AbeFRKRq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:17:46 -0400
Received: from mail-he1eur01on0073.outbound.protection.outlook.com ([104.47.0.73]:17984
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933984AbeFRKRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FzVGBwF/EfUgv9BIn5d9Dd8c0O0rdQkHnZq6MymAbc=;
 b=Kr+QhZvn8R+bYUs6EfrqR2OX8SmfSZ9zVmAc/PBa8+6cvv415bdMHQOGt5ws7dlwqrMLTrdxNF7g1QeulVNdOv7My657lu/igIvzKLBxz/LPCQCDRubW7fOhfa0q4B+SeASnis9GOoklVbc2YlO1zLJ1ZoB8KFzxlwWcvpU4RdM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 VI1PR0302MB3214.eurprd03.prod.outlook.com (2603:10a6:803:18::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 10:17:37 +0000
Subject: Re: [Xen-devel] [PATCH v2] drm/xen-front: fix pointer casts
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        boris.ostrovsky@oracle.com, David Airlie <airlied@linux.ie>
References: <20180523113630.29811-1-andr2000@gmail.com>
 <b516542b-a0f5-cbce-d351-25b88a7f3288@suse.com>
 <a8cff47d-a990-924a-0a63-b6f3aea3279b@gmail.com>
 <ad523698-9c33-3fe1-9eeb-165cc775a936@arm.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <4a66887e-744d-d14f-85e0-e3cdb78934bf@epam.com>
Date:   Mon, 18 Jun 2018 13:17:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ad523698-9c33-3fe1-9eeb-165cc775a936@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM0PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::19) To VI1PR0302MB3214.eurprd03.prod.outlook.com
 (2603:10a6:803:18::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a04c83a-a435-4444-8f05-08d5d504b816
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3214;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3214;3:HEU28KIC+UW3KmSCqGOEgxu3E0cZSYC/1wdkUy2GCariTE/Yn/iZMdHb3TJZscSbJJtYENc8GF2Xb4DHpL3ToKVFDXaSyOraCgSqsMsv1fkWi4ljzAQI1RT3EOppcw4y86acGBohL1O9U+erAi+4ByRmexSTfGN6Gic4EOZLu3HRaX1Q0seS4BoRNzZBz7sGSRFphX+GSzTkSM+iyrn9hWVgH/lS3Ll7Zk2S2TqYpEn3bXVxLViJAsaEznvFhC6S;25:mDLDBd9QgZuAXOpuNNr6IYX5PfUTv6hk2MvipZRc3UY7dzX3usPbvWF2Cw66HJagnEYYSe2a8Fii5vniTmqH9I6mdi2qcER1cBS3AVlI2dapChx1YPPEoW6IavV7nwXe4hFYaEBuhYCK7KBHNTLjFKCfYZH5fw/7eCgrzD+e7ca6AiW52oTV8hfiHiJ89thEHzlfB7EPLD7ux+sf06IelTJYpKsNjEx8wzdYFz978uf2Un8L8lK9coOYLWKoM1S/A1M65HI4V7NPBF941N9Yak/P+0220zyIoe4eAlNAukqP7K4d7XsiN7IlCsxN3D+rn39fkzhY/afotZCwMbS8SA==;31:pcgi14UH4wv73P0ZNVlsYG1+aZCawCgD7sGtD5sTmGeXimrhJfl2HYlX2x8lYyLLMYrWqLBV539k7Zb2dGex8JYppmy6r+sQBltsL8QJrmrH6fd0ZDU+eqpTRBdGOxYqK4/+iq3YLq3gVSwQw7RiYBWtzmQdvq44EiJ5YQvxurO1dHPsamDewD8jIEH8EEbXA/lbaR0OkKShjnTDTJMKAJVYtfu8ugdJBtudvtGH/sE=
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3214:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3214;20:f859ue8YM779ppq/smqQyh648xXUq/g5ks04nh9PS80JSTsJZ46bm3xgFG/16NwlN3u4QacvXvI50QXptDM74Sa4cTvZ8IcTQIOipWdBJwP3RbiroRZ9uEJVDuFo5JdujWnynvtvYmX13yqUemGZIr9hBLwqg1JckiA8cz9BsKvdHbgj/Ub8K3MxPcDvK4vnU+wv5T8r5DC1HGQmqAo4bhKXuYtz4npIRx9c8GvA3kiERpfTdz8TwdSD3hGwv5wfHLLdC9w7HJ7RMOs5BbsTVBP241zpowC1jiDRpdwo9N8jbkXaFg5NfWXA5XoN5mPmvpz4h7/Ce9aeWhFAYtMztZuIyl4pYHbsTRcdlLzegAtlw6V6mc/NYARiwZCv9O4gR0/fNQmXw1OD3K6fPSnedJcSGmRU8WMs3jOCb/PXyABYZR4vFp/CYPVsmjC/mwArqGJJeQ0TGhUeZcwVNLakp3qKUFOQjXXJ+VIBr3jt3dA8KWW4G4FoQ3+4p8N3vV0Y;4:7wgU81OJ79ZADq72FtqS993zV6wZ2RNY4gu4Bg3/ygcvdB0hCqf781doCArfF7tZh01ltFXf540wgVv7uk2TiJqGzwPpjzsGxW4Ue+980QJ2oykerNhERDlzV6lfdV76xhPNOEa2j5DnWDu0QLZcWZTvAj/fWvITjKdHjzTHgrtX2p7qz9m/r5r4gdEIRp4310teSBmZhMo+iVIBigyYuvy59EclB5As41PNQmxuvnC9D6jcrdstpRcwoQV9+Nnd/ij5wZ6yoqfQG3/jHkq/trWLqZXlG8tye+umCwUtLc+ztX9tapTfGXPsFt22ETEx
X-Microsoft-Antispam-PRVS: <VI1PR0302MB3214B33CC1528F8CA66753FEE7710@VI1PR0302MB3214.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0302MB3214;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3214;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(396003)(39380400002)(39860400002)(376002)(199004)(189003)(47776003)(4326008)(7416002)(11346002)(66066001)(68736007)(86362001)(25786009)(106356001)(58126008)(16576012)(93886005)(53936002)(50466002)(31696002)(6246003)(39060400002)(67846002)(6666003)(64126003)(31686004)(476003)(65956001)(2616005)(65806001)(6916009)(478600001)(72206003)(446003)(486006)(54906003)(5660300001)(105586002)(956004)(65826007)(6486002)(53546011)(2906002)(230700001)(386003)(55236004)(8936002)(8676002)(97736004)(6116002)(81166006)(81156014)(26005)(77096007)(305945005)(76176011)(3846002)(7736002)(229853002)(23676004)(52146003)(52116002)(36756003)(80792005)(16526019)(186003)(316002)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3214;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDJNQjMyMTQ7MjM6VFlVTmxTd1V2V2ZyUmNLN0d4SEs5dGxI?=
 =?utf-8?B?eVRoMWhvQys4T2JESGZVRHJvUG1KL0hQWmtmU1VmbmdmVit3VWZIMWxNbVkz?=
 =?utf-8?B?N3g1RjFUQVBjNFVEeiswOEJFeGo0UUpBOW5QKytwS093RUlrV0lBVk1yUDcw?=
 =?utf-8?B?NGkyaHJDaWFaWCt2RGlVdkZORitSdVVrdW1kYStZcTMzN0tiOXBqNUtUV1VD?=
 =?utf-8?B?azU1VFFKZjhGUmR4elI0ck0vNDAyMzAxTnRFRTFoNXA3SU5wc3dYMit3WEJS?=
 =?utf-8?B?N2hlNTFBK3Frcm0vS0EyZDI1ZUs2STMzME9VS1E3dForbm5aYlcyK2g0WDlG?=
 =?utf-8?B?OFVlMGMzSW51dGNjSWJaUE5nWVkzVlJGNSt1di9sMEZtd1NtayswajVjdnFE?=
 =?utf-8?B?OHJkdURTMWxSS09LMHlvd1ZCRXhURExuK2VOd2VOejJPYVhBVGZFdWFDM1VC?=
 =?utf-8?B?ZVowY0dWUGpjWkNNNWpTS1RrbmMvL0FHaVRRdEFTUWRVemt5RUE3NWJkVGs3?=
 =?utf-8?B?T1hUWGJGb1VGOWJSczlYMTVvUUNWY1c5eFJIZEdPMGVpOW1yMG5Qek1tNWI5?=
 =?utf-8?B?di82aTB2OXlpWmFHTytxVHN1U1JMbS9HUjJNUEg3THhibzRFYXN4K0UwK2Yw?=
 =?utf-8?B?VHdqWFp0UXlub2tKa2sxT3dIZkpYS2dsMTJkbkxYaEtrZ1ZhRzRxWU1tdVVa?=
 =?utf-8?B?ak96WERBSFVHbWpnNmRuZVJpVHV1STdoQ3NYdEI0QjJqRDM3cW1kRGljbGwx?=
 =?utf-8?B?UmNKVGowdnZhOEUwTjRnNjQvVUY5L1pXTGlUSmRibjcwS3hyRXJic3VlbCt4?=
 =?utf-8?B?MWlLeDgzc3JTaWtlNTM5RHRLTXJPYlp0MmN4LzJxZ3N1Z0pRdTVkTVJVM3BO?=
 =?utf-8?B?QTRhaDV6V09UYlNabys5U1VyYXRzeC9rdW8vb2k2T3pLYXZOTm9HbUF2M0Qx?=
 =?utf-8?B?elZHT1VsZ0V1Z04vejRmWVJQVEFTZ05KYzd1ZTJUdFhjVE90TFdmbjd5Y1VT?=
 =?utf-8?B?WkxFL0JYc3JKZi91Q0Z1MlVNcGx6WmRoZFIyRWdjYmFra1NRWFpwb0N4bE8v?=
 =?utf-8?B?Nlk1UEtydHpyTjU3MngwemVSaUxKT01Dc3d6YXBRam5YRnpaTm1SUW5GYTY2?=
 =?utf-8?B?SWNmS1NkV3p5TGpESUZuZkdiRnBzdFo3Q1Zjek5YWmY4MzM0K0R0T1pkQUZ1?=
 =?utf-8?B?ekFoYVU4Q0xCMzRWeTBSejhHYy95UmtXUXJuVERJTlhBTjdacThKT1NGNVZi?=
 =?utf-8?B?ZDhLZStQelRTNGNrNjRTZUc2WWJJKzZqWTBMZjFUYitpcE56TUs3UTg5aG80?=
 =?utf-8?B?QmRnb2wrYnY0Q2Z6a05YdktpU1lzUENFamFOVnJ0MzRSTjl3dkliREZtb3Br?=
 =?utf-8?B?bDRVVE9jVUlBMWRWdlczdlY4clJaOWdjUVFOYW1yUmFKcEYxWnBMdjgxRERm?=
 =?utf-8?B?MWxrVUZleGphZG52V0xIeGt5UFYvSFJTRzZ3TTJSZXdGamFHd0lLSk5RanJr?=
 =?utf-8?B?eDh5b1pSbW9FbFlLOFRBdnJSeFl3eVpyc2RQZm9HUnRpaHUwZFBCYzZHMDd0?=
 =?utf-8?B?UEMyNEZjZ2NEZnhuRlZ6a3VGVWt0YjZkdUtjcDN5dTBaZmhCdFV4WXZjQitk?=
 =?utf-8?B?TzZBMUtxMmtVVHVKU2crRlNrTldjUC91bGd5RE1hcXBUd2ZtelJHM3Jnd1Mz?=
 =?utf-8?B?VTIzUUd6V1dOSk5DVmIyV00xay9rUTFSdncya1QyVzcwTDFUcm16VDNOSGZR?=
 =?utf-8?B?RzNYd0NnRE1UTGZpYm56V3F2WjVaNFVPZGgvQ1Y0VFlzY1BDNVdVRFBNQlVs?=
 =?utf-8?B?TTBadXpDQzdUangrdTBSYUdnNXNtQk13Rjd6YWlHcmJ6bWxmcktOeU4vVEZ1?=
 =?utf-8?B?RUxmNkFIOEc0NVJQSGNKSy9yTkdySTJaWnhQazlmeEYrbFgwSDNZQ2JoclNa?=
 =?utf-8?B?RGh1UFBNakk2WStTWG9mS2h5Uk1oL3ZHZmlTbFZoUEVVdUFiQ2tWQ2czTk5n?=
 =?utf-8?B?WWxoTzc4bFgyMG5IcHUxVFJrN3ZPR1MwUFo4NFlPMDlNSmUzd0d6SGdUREVj?=
 =?utf-8?B?TDlDbDMyUExWZ2sxYlNYSm5jL1lpbytpcjN3WWcyQWhiSE5jTURaSnZUWFY5?=
 =?utf-8?Q?9VpjGZEhot87+6W4gvxdnDeF0rPBbdLIpIpSpw7aexe/2Y?=
X-Microsoft-Antispam-Message-Info: dZCy8GQS8sRfGR9ncR0aW2uCO1jexfHVMM8Q3h06n9cNgSlm+3BDLUKpXQwmZaGXsMC2j0kkFxRp/7jlbriZVRVhUG8ankS6UaYhX+nxsssk3OQlXZ+J3XuXAwy15vOKG89ptP23Lzddnv36y/N7Z9fT1uzS5UrNnaNp2GwNXMxxsf4PGlElOCHcozd7Bioi
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3214;6:9/mblHp9RREZ3BD1Igm4i/FzhgekrItU3/pO9SXURj2lbFOWDHxAYNzeNe6UVGtd8JH9kpJpNLx7drGAl22OthYM2fhYz0w/KKJzUBvi12Ua6/Wz9/bXK/ELY+MBddZlHz+qjIHgkTjeIuQ6GvKD7e0mSLh9Biic2N/erFBKMgpJf42PjI4abaLBhVVdMyGOm/mMdqbpW/vKG9NzAzAD6GLSsRrW4j/BpfRvnkAVi1uZo/5v/tBxZPExO0QfeK7qazv3FW/sy+C+wuP67Zpe0t8BAaJ235aZddDwJ7nqV3cGEjCXZwctz+hJY3IDfByOfQONLJ6niST9tegWsalyLFIWPziiDbHs3T7o4HaVznvrupl9MxyIfXtv3/6xPfw7en5EblbQJ8E5mO5AQqbT0k7fo7YoFMf4f+MA+vSGsX4HxDoEeldrdLZ0Vp7B81ylUBqyuQXNIoJ3czx0plXbig==;5:dA9erptdecNRC2GVkF2VM3KBrkOtCLB80dIhdp81Rf3qn9pL6zLVW1le1jLJ/KfYnA1MRPlmOprphr0BHzef5u4JDCAZUF8LIbz8fLmbuUYSuYl4cSQXI6bZO1bZjAlzYUPvs2Z8embhQhCqXAzdEsWNXRi8K6lAFI4VoH0gDCs=;24:HIQrZnPZiDtKr5Gb6I/IiSqUcZHSbkrhudwjwsPXZgSSm8m/ha9Z9DkzDIFAIBjkZMgFvrOKZ2gaO3e59/rSVuAdB4SiRIZW8TniPqJaRxo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3214;7:IkAGU+9BeQwo0pefbzP9gZ5kHerUcZsx1aHZSO4G79uxz9qb+HPS1+K8js1VRzTmkdErDwZXREII/pxmFQ6KK3V+rDMU3tV8fwd9niGCUG58ivxEk7kepco/nw4XUyY9oRuS9mtlOHn9UnapiZc3QAUQfUqLZcfJ9QOhjyTh1VzaWYvNz2SwXbthy87b+rit0SYUt2M4nR9isba3L+BILDS/H88BgMqc/Pcj8fm/ZhsivU5PbM0gTCYnd75TV9G/
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 10:17:37.3504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a04c83a-a435-4444-8f05-08d5d504b816
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 01:06 PM, Andre Przywara wrote:
> Hi,
>
> On 25/05/18 06:32, Oleksandr Andrushchenko wrote:
>> On 05/23/2018 02:46 PM, Juergen Gross wrote:
>>> On 23/05/18 13:36, Oleksandr Andrushchenko wrote:
>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>
>>>> Building for a 32-bit target results in warnings from casting
>>>> between a 32-bit pointer and a 64-bit integer. Fix the warnings
>>>> by casting those pointers to uintptr_t first.
>>>>
>>>> Signed-off-by: Oleksandr Andrushchenko
>>>> <oleksandr_andrushchenko@epam.com>
>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>> Thank you, applied to drm-misc-next
> Is this the right branch? Shouldn't this go to drm-misc-fixes instead,
> so it reaches the tree before the 4.18 release?
> Just stumbled over the issue when compiling 4.18-rc1 for arm32, so it
> definitely needs fixing in this cycle.
Maarten, can this be done please?
> Cheers,
> Andre.
Thank you,
Oleksandr
