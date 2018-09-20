Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DE7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0A920877
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="ejsKqJRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0A920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbeITK7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:59:52 -0400
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:35456
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725725AbeITK7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF6ZY4YOBfrOoOUIJ6AV2DASCwZwvD265VUrGLngn0U=;
 b=ejsKqJRlSg8aZNVujCJJegOZt9yM/ypt0WP7tV9O4JpX3YmjFzskVze+MAv2B1n/QBCUltKWmb7LTrPElmyynruVPGw8oxcxj+8SitoltRFEuuXScX1fPHN6N4Xhexw/9+V/0T9BSlURapcal8t+NyNeOqVEpmguXCCclQ1XjqI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.20] (85.223.209.59) by
 VI1PR0302MB3213.eurprd03.prod.outlook.com (2603:10a6:803:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Thu, 20 Sep
 2018 05:18:07 +0000
Subject: Re: [PATCH] ALSA: xen-front: Refine indentations and constify
 snd_pcm_ops
To:     Nick Simonov <nicksimonovv@gmail.com>
Cc:     tiwai@suse.com, xen-devel@lists.xenproject.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20180919214710.GA6907@nick>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <33d4fea3-70ff-e488-cd10-3abeb274fe3b@epam.com>
Date:   Thu, 20 Sep 2018 08:18:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919214710.GA6907@nick>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.59]
X-ClientProxiedBy: LO2P265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::13) To VI1PR0302MB3213.eurprd03.prod.outlook.com
 (2603:10a6:803:18::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf689dde-2e64-4833-0a69-08d61eb87394
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3213;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;3:7BS1Dj8DSSDJEwg3MKJaV4Rd+6u19OQz0QKj25hEDycVC0cX+S1slJ0LPM0w3DQlc820eCx5vQyf/zT57u4QHCtlpBJVhWtOGAqMmthiUBPLPYYBjsH3Hw2+p28bLWwQyTR8TR3qREH+hFdzTE3VYkTNElKLo5Li1m2gL6eO022WS9BQVwH2k1Rbgmc12axKQ3RT+oxvVLoV7P7Vl+62dTRpZxknTHvPMUZtEgMJjfxEgtcFWhnv6SlmeHYbkNH/;25:25I7skodpzUJaSDYRGskOguDuLXaaM5cdOnNaOOXYmksZb92TMBjGvR5UsXb5xA4BVAD2qcF4rtrf2i1EFTyzIYpZDYd1+5h7GmqVN/lA0weB9qj1VxZXf11ejS0tu9eHa31U/nfqlP8KQ5ipHDvRb4D7RYcxZgWZRe40zgpG7SACs2mMJ5Ux5WLazJCqxB0vSDuCBA4elgWl5ERSZ61+aIU5ZKt3NkkvZgNNGZSk4TNDhdL0qZ5VlNvQRZmmpm6bz082w07GNGaYyF9aYp1t1wPYQGPTR/CHja/Ou8DD24qkQ1CIR7GA989EAgEeeVsfTwcL9+fLuSGSwB+Rkv66Q==;31:fpwMDGkeQ4Sf/74dTnl+BqPsA7oSX/BVzbVXF4neyd384SBFKkK9pbRMLNrMJKo2krvuM+WimD2g2YzYBXgoWEk+4ZDYHfVKjzvjWCieDn+eXvUsJI6/z+/IeXzyLaGU+aKpdsQ2d0Sv61wIXwUnVVgM1YV0OJnWvfgH+O/+lPK6rTrCT4PtaLWUav6f3S0fCZrMRL7XwLJCcE0O3P426DxxhRI009tiT3Zf2xBAm+4=
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3213:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;20:fKmYnRBmWWjBQzJdFTljBuZUk3jo+gAgRSlgm7wW+x2tEDefNXF8OyW+xK1jsTIPV/TiU2NnaRo68SEuSpNY1P0EbCAGYKpd/uUSQt1DPVdjXU1lUmZ+RsWtce/PQRaVk/w7hfwRoGFY6tsSUFuUXYE7TOVbAj+s6bxyyBLczOK3eZ2TdoK5zsUDSD92FcQbMcqqUCHX8lL6RKHuu9lE6RZqEmSDhCABqagQU/aQUb1ZdqdNvBPshRQudpw2bL2ascE2ufen1fzy/SsQ7MNE8Hv4Kp0WrDkvmVc329mD8sI7GZbiMjF/Ovk9f0PWM3mHBxgsxgk0vC74AkEjkLw1dJ2wZ/HRHgEDv2eFVmsxDG1Qw5yPErf7JgQDkJXV5uq2tTTA67o2ZuCHIFXHuZFor4pwWpX7on2h2rcwwMaj8I4usZ5wBGc6xunENvqFveqaGWGyw+YjzZyBclx33Al3523EBKVohoDk0gbdSJz1BO/eG/x50voSMS2xNHGK/E+a;4:ooTPT2cPGD8Wd6PtZ7zkf1w1MupfTaQrr102QTAE/p2WprTQ5fxMSgHmrkpBY90TQU8L/6H7Ejhfhw5U88AMfztUNOonDAjoJUTUt867wSDg4YvxoP0WIrCMt2DHpo3yZ0QfEXOWy/r7YeGVcDiIbQ38aJbUW8kM/7urvVSD0Wj5V01DRCBy5lC4FmAaEXPegJWoJWDB85V7j+IiDDlmnKcU9rSxpzbW6gYVg7L+hrr69OS5CARbLKuZQmlFtUWGiKxhUDD7hdRQizA30cqBHCRh/r5S4gWYbLR5fTUPMe7LmHn82O7bqudzodnShoRkB1Oj16fDTviI9+VYo42fs21dMU1qFvmddXfZAS+MtxE=
X-Microsoft-Antispam-PRVS: <VI1PR0302MB3213B0E137BF97C5749F2A46E7130@VI1PR0302MB3213.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:VI1PR0302MB3213;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3213;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(39860400002)(376002)(396003)(346002)(366004)(189003)(199004)(67846002)(31686004)(97736004)(386003)(50466002)(476003)(2616005)(11346002)(486006)(5660300001)(956004)(446003)(53546011)(16526019)(305945005)(186003)(65806001)(81156014)(8936002)(65826007)(66066001)(58126008)(478600001)(14444005)(77096007)(229853002)(2906002)(65956001)(8676002)(26005)(316002)(47776003)(52116002)(68736007)(4326008)(6916009)(345774005)(1411001)(86362001)(7736002)(80792005)(105586002)(6486002)(230700001)(36756003)(53936002)(81166006)(31696002)(72206003)(16576012)(25786009)(3846002)(6246003)(64126003)(23676004)(6116002)(6666003)(52146003)(39060400002)(106356001)(2486003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3213;H:[10.17.182.20];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDJNQjMyMTM7MjM6L0Zva0YzSU1vWGxtQmNMWU8xeGxzck5l?=
 =?utf-8?B?QXlsck1vYUdBMFZxZS9BT2lzRXhRVmhyLzZHbVdua2U4MHFWY21iUHNQeFc3?=
 =?utf-8?B?REh0TWU3TmZkaUlORWJWaitZbVA1clRiTHYvTnNtUm9xQWl0dDlJbTd5NUhx?=
 =?utf-8?B?TGxHZGhCVnpyZWlKMFJyNTBCWnJkamVicWNvUTBGemQwc0lDRGpBeklqV01R?=
 =?utf-8?B?Nktna1NCcmM5TWNWaG1BSmpoV085RnNldVM4UHlkL2x2RHRMUDBINWwzQzM5?=
 =?utf-8?B?emp4WUxzUG1reFhKem8wZ01GK1p3TENIUVloL2R0bXRnV2g2Rkd4OEZRZmtB?=
 =?utf-8?B?NnpyNjJaVW9FZ2tiaklxRzhJalU1VDlIa3NkWUdKaXI3UmVtRkRydDR2a2lx?=
 =?utf-8?B?TlliL2hiZEI3WVd1bWRobDBVVnhKUzNXUUlCQkZTNVU0UGkzeDdWM0NHREp0?=
 =?utf-8?B?OWR6ZFBwSUd1Z1J5bi9CVm5wZWtnTkI2cnUxVnVEaXlhcVp4VmVkaCtPanVP?=
 =?utf-8?B?aGJRM2lQdWFyVjNwenlYRXd4anhUSnV0elNwTloyNGRhcGdtS2ZtYXpSYkll?=
 =?utf-8?B?d29WN1N3elF6SXhvdFJFdHpuU0ZMMHhPRkVnb1ZTOWhSdThsSjhvcXVPTDJx?=
 =?utf-8?B?UE9NZkgxZWxaU2lzbHIvV0tLdzMzVVdRbmR1NXJlODBLVXYrL1EyVVZtZ1Bn?=
 =?utf-8?B?QUx2akN1SmZqY2IyOGg4Q3dTZDBSdGh0by9LWS9vcGFHRDBwVSszVUJjV1RE?=
 =?utf-8?B?ZTBPOXJGeVhWV3RyWHNXY0pJL0FqTWl4VXF4ZU83a2MvZlNjUHVtNjFEL1Fo?=
 =?utf-8?B?azYreitxU3dXMDNCaS9XSDdNMGQwVUl1TERFanZMUnRuNTZZQml5c0hubXcz?=
 =?utf-8?B?Sjc2aDdjYVozdUc5cHVLTkxhMGx6Q3VWeGRRVDM3dU1XZWQ2L29Vb2Y4MlJj?=
 =?utf-8?B?S3Q5SjRiRERwcG5FbEI4Q3YyWVMzZzFkdERuU1BMUkM5QXVUQkdNeis0SUNH?=
 =?utf-8?B?dVRIZjJmWGtvUXJwVFk4d0QvbDhOdE1lWDNFaUtkbnQzcDdIM05ZMTFBT0hX?=
 =?utf-8?B?ZTRsZFhwVHdGTzlsWXI3U1B4N0ZtVUJURXVDM3NvTlpiUUI2dG5rZVR5MTZO?=
 =?utf-8?B?MEl1TEdnZG9zSU5sS2YrL1FHalNCMjNrU0hHbnpCYkV2YkJreEEyL1Q1RlIv?=
 =?utf-8?B?N3lxVU53blBncWpuR3dOZ0NjN2tVV0lscWNuYldGeEc5UFZVVS9hcXhqN0lP?=
 =?utf-8?B?WVBSUkl1UGdDRSsyUFlGa3FMVGtxek9RM1VZZlhqVkJkTVgzdjZpbnNhOExH?=
 =?utf-8?B?Ykh3NWU4ZURzWVp0OUsxR0JMYXpLM0lJNnVsNXk2QzdRN1RDazlqcHlTSE9m?=
 =?utf-8?B?ZkxEd0cyRWlBVDlObXJyVXRXcHlwQjZrT1JQU0FEYk1kSEFxY0UxY0RFM0J3?=
 =?utf-8?B?cElLS1pDTDdodEpGdmhQSmtnbzJmQlhhWWtKcC9YNEtlL0VRUGhvN2NJM1NH?=
 =?utf-8?B?T0ZtdTlKVnBIbDRrMDNiUWN1TUg2Q3B2b051clF6S2hpN2hrNERWOWJKcWJs?=
 =?utf-8?B?SzFxMzBuV210cXJTNllMdVNOaHFVRXNFV1dpTHB2YlRhb3VUMytwTGRhWjZS?=
 =?utf-8?B?S1lDdlQwZWEzd1V1SEVVdENSNkUrckE4WWE4WUdyUWIyQTlTNlEvNVVUVTc3?=
 =?utf-8?B?cWVYc3BIZUJWUVJxeVNoVDRadUR3OUVEdk4vaDZEaHdqZU8ySmNBSFZtTm5p?=
 =?utf-8?B?SmpianNZQnhZaisxZkh2dms4OVE2akgvc3hoZXVWN2ViSWU5SUs2alZ1bkNX?=
 =?utf-8?B?VXZXZHJZOXlGOGJQN2FUellZM05NWXpmRG9IekNNTjJ4b0JZWFJmd3JvSlZK?=
 =?utf-8?B?N3Q4WFN1ZjVISE9RWkZ2am41S1JTMXJ2RndNN1RsNlc5L1JPbHVmekVVWWdM?=
 =?utf-8?B?Zkg5SUY3cy8zeWFGNkVnZVNWZVdHRDcvRktMV2VZUzluYUgyc29iY3hjL1JQ?=
 =?utf-8?B?czA3WWwzQ3A3ZDcxVFJjUkt4M0RxalZacGs1Tm91SUhXTnVuc1JrOWNYSVlq?=
 =?utf-8?B?bXJsenM0K2ZaVCtsQUZEUkNSeVN5ZEE5dFVtVUJGaTV1VlM5NWJiejBrU1dn?=
 =?utf-8?B?NmtsQT09?=
X-Microsoft-Antispam-Message-Info: GmGfUm45aiMDxQfT5wMLmbOJyQX55WQyPLa0ZMt5v3yARVonskGFp5SueL6ENGt45BVXK3pJ6qRQtzbuvAlNLF0/rQyff6l2ylyb+9flXmEDnJo7mMOKT+AticHrpbx1pP04ZgQGcI4rkjExeKo/xSTQiCY2oe5yFO4goBzL+KuMbjyAmQtMQdYXlUxlA8+UZL9Vzh/RCwpSfimPH5BeCDCPyh27ckXGXOrwggaBa8z9mBaX5+sa5PwHkZaypNDeFUsg24I0juhbM0CDYDkF68Wy7W4jr2RRPsAystiatNjrERgTIUwCEYXdIx/ZgC5cI4GDFEUuwZGlAlPoU5ZCtoUCZyDL63EG1ikqgwDRPR8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;6:EblJlVGCBsSMAffHln/OFumZ2EWPVunnfiKj37rwiTaaMZ/wynevoIAfQ5MWv0MUoeOfQVCjHkfDJ/5DclU0HyPc9D6ko/VIslOb868huGILWYvFQgW1ELfKVmk7MqRYRRmlXCthKIra365D5Y+rWmrlb1r7IPoxaYCQmkQvnamEZbg+eJmCRdBCUoPfVgfw+LgIklPITuhcjVwnmqeHkpzuTNguZWNhSGFhKgYnHApIFekKR+WlDeCVss1m2UtBKUAGVidXihjBQr2ITs71NQRfI5QjwVLf4NXqRRDQdmV+oB4pcPESXX9BGJBN5KwYWnqmbay9fer0QpNQ6nC3U7+S05DyWzZLBi6I5yu9dvCJTXwoBdaJynJj6yz0YsIttAEbLkeT88u02sfeHoFXo4aSxg3+kMC9K5igpMcYQvLUXKcY0iVT06Fl1HPEfRdi0sqEoM69D7rukYDvfDyjng==;5:8mDCO8NGeGxV7SMcGTg0+XEE0x63l40ZBMRNuYGVQzjpit3rVDN/LQF1QpmbdKsPOgVyfN6omBBWjSBo+XK6DnJsqqgCUaMSaOwVePN9baxWpXI4oZVqgiQ91qyDdCy60CDcv7CH2jU+GebFQmDTxER0cxmYKPAyuxly2ZbH23g=;7:pDrLlhEzMAKZVjhzPiZ+gyu2oRbtWRYs6+WbFeQyIuFY9p7W8vN/aNKjIdeTewGiSpscLXH2qw9igvxR5eM+wVK85DFWRf2m1uLzC5pnF/E/a3KZe52yB5QoOarT1g7XatE94buhM5Ox6Mlj1eQW3rMl9NI3rfI49ak+E2uAFlVJGDHhWosLmr80p/shznrmyUNkkegy1J3CdN+yUT1HVg+qgZAxtk1g/ZCLUo4yfSglVBaRgcEMmvSLrqmZRikK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 05:18:07.4456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf689dde-2e64-4833-0a69-08d61eb87394
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 12:47 AM, Nick Simonov wrote:
> snd_pcm_ops are not supposed to change. So mark the
> non-const structs as const. Also, refine indentation
> to ncrease readability.
>
> Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
> ---
>   sound/xen/xen_snd_front_alsa.c | 46 +++++++++++++++++++++---------------------
>   1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
> index 129180e..2cbd967 100644
> --- a/sound/xen/xen_snd_front_alsa.c
> +++ b/sound/xen/xen_snd_front_alsa.c
> @@ -637,31 +637,31 @@ static int alsa_pb_fill_silence(struct snd_pcm_substream *substream,
>    * to know when the buffer can be transferred to the backend.
>    */
>   
> -static struct snd_pcm_ops snd_drv_alsa_playback_ops = {
> -	.open = alsa_open,
> -	.close = alsa_close,
> -	.ioctl = snd_pcm_lib_ioctl,
> -	.hw_params = alsa_hw_params,
> -	.hw_free = alsa_hw_free,
> -	.prepare = alsa_prepare,
> -	.trigger = alsa_trigger,
> -	.pointer = alsa_pointer,
> -	.copy_user = alsa_pb_copy_user,
> -	.copy_kernel = alsa_pb_copy_kernel,
> -	.fill_silence = alsa_pb_fill_silence,
> +static const struct snd_pcm_ops snd_drv_alsa_playback_ops = {
> +	.open		= alsa_open,
> +	.close		= alsa_close,
> +	.ioctl		= snd_pcm_lib_ioctl,
> +	.hw_params	= alsa_hw_params,
> +	.hw_free	= alsa_hw_free,
> +	.prepare	= alsa_prepare,
> +	.trigger	= alsa_trigger,
> +	.pointer	= alsa_pointer,
> +	.copy_user	= alsa_pb_copy_user,
> +	.copy_kernel	= alsa_pb_copy_kernel,
> +	.fill_silence	= alsa_pb_fill_silence,
>   };
>   
> -static struct snd_pcm_ops snd_drv_alsa_capture_ops = {
> -	.open = alsa_open,
> -	.close = alsa_close,
> -	.ioctl = snd_pcm_lib_ioctl,
> -	.hw_params = alsa_hw_params,
> -	.hw_free = alsa_hw_free,
> -	.prepare = alsa_prepare,
> -	.trigger = alsa_trigger,
> -	.pointer = alsa_pointer,
> -	.copy_user = alsa_cap_copy_user,
> -	.copy_kernel = alsa_cap_copy_kernel,
> +static const struct snd_pcm_ops snd_drv_alsa_capture_ops = {
> +	.open		= alsa_open,
> +	.close		= alsa_close,
> +	.ioctl		= snd_pcm_lib_ioctl,
> +	.hw_params	= alsa_hw_params,
> +	.hw_free	= alsa_hw_free,
> +	.prepare	= alsa_prepare,
> +	.trigger	= alsa_trigger,
> +	.pointer	= alsa_pointer,
> +	.copy_user	= alsa_cap_copy_user,
> +	.copy_kernel	= alsa_cap_copy_kernel,
>   };
>   
>   static int new_pcm_instance(struct xen_snd_front_card_info *card_info,
Thank you for the patch,
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
