Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5687AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1BA26C2A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rZsr93uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1BA26C2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966006AbeFZOYD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:24:03 -0400
Received: from mail-by2nam01on0089.outbound.protection.outlook.com ([104.47.34.89]:32000
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965993AbeFZOX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0EbmP4VgPa2r0aKEa1R21Un8Cof5OMzr5IfuzcqfgE=;
 b=rZsr93uhdNv1tCbYywoEykOu9Gvx32k+Ec0WKmLLlnfREPkxIWF5pwIoP00KEP4gGJaIgDdaRc5AoPbcwus2D5cQxCicQ9CurXuqbf0W+JShbBHj1/zvlPzWAtq2HIQigcKsUK6zv0qU8IiWzj0MEchxo/WCoKuJdtwqHHEfrc4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [172.29.157.77] (165.204.55.250) by
 SN1PR12MB0190.namprd12.prod.outlook.com (2a01:111:e400:5144::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.24; Tue, 26 Jun
 2018 14:23:56 +0000
Subject: Re: [PATCH] drm/amd/display: don't initialize result
To:     Stefan Agner <stefan@agner.ch>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180617085343.10760-1-stefan@agner.ch>
From:   Harry Wentland <harry.wentland@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=harry.wentland@amd.com; prefer-encrypt=mutual; keydata=
 xsBNBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAHNJ0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPsLAdwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2zsBNBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAHCwF8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <341abd6c-0ace-11fd-733d-d7d4eb4c71c2@amd.com>
Date:   Tue, 26 Jun 2018 10:23:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617085343.10760-1-stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::22) To SN1PR12MB0190.namprd12.prod.outlook.com
 (2a01:111:e400:5144::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb684929-a1e6-46e4-549c-08d5db707449
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0190;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;3:CEXZAXKhIFhp0wrM2hR8gQcOK5A4/aNcgUkDLWg/ib/+8K93V+Nq23z0C1FhqdsCeOo0QQmhcRBjKpdLesmtDwhqZE+zbOY9RkR5LLW9ESDgI3fFYDFKOu2WBS2w0xcHhE+1bI+djKj1m4k5SbV8VQ702qZD/PJ+sVED2wpKh3sQg4kKDFfrjNxlHySiBUL+BocRYRZBA8XKmnuA2DtE/wQX9oU5qL1ooH6GKSMca2GnB8ACTMouefRXrFu8fZx5;25:F3Q2uWq42pQZ28s0Tj1GCGg+R/5o3CyG1yP39uqaqu2ZbmQnIyPa9nvx0VJvz3jGs3PjzeLZ3s3fceU3aBD0r8p3XGKy4IuuF+9nnFnahT0y/pUH4SA6ugdE2qu6AiJ9nuxKjd8YE0hnH+ACCyOwhgF3nt1Tex+u82F+a0ZVB7QE5smAVd7FhDzTdbr9NkZ6kdCppHgPT8a/2/pauDP5k6yZj1VUCMj8OjVC0A8688i6XN3VbtXB7+dTrL8Q1mxOTRFocY58hlSryQ3qE7QgBnxXLM5tHH4FTukALX3qDi9lYgY207bsa2kBN+AFw+2ja8DI5FHAj1fwYXR2Q+LpbQ==;31:7W68Fs1kRJjtm06sGQnDnYe4X/kJodmZnj09DPSGDQxEoaBrczrhz3RUJQmF0pNdWNelcytEBC1dHFUawExpDqla+7FILaVYyOoge/9Qv09xhDDG84kQZJBRCy84hClTVZwclZL0KucDC9Nahu8ezTi/5ftxzZNsJoy6mwnXVWJRsOUVo6uojecu6E+0iXdpejoHHwxJ4dOe9sgppRs/Pm0oRiYCFgePxG9ScmhCqMk=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0190:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;20:FF2qBvniss2u1uwXzHlDPa3Kmd54oSdCBkGk9+rYHiXO3tprncTbPkcTwh13hn80N1Vqtt/NTwV1J1qI7HTIehJ/ayhopJAzGxfUCKHDFPlp//rzbxbL6XoQ1QjI45/YORLlu8kxRRRak5w+PQyQk3g2Fw6GsM17Wf/Xmc4fy1ZYVqqrQtVqvaoUu5D/ybFaQ6peQGC40CEqM3YbSrTzQz8oD0u3QFWMI48lkKiyJqu7eCOKQoJ8RKAZdrX2PNEIRfPq7M8ytmhT8QeHKIFJ88FFX8/9DGADUB2BrGivqX8RPw/XA6yeNFcSUfagjlc7MQ7/jOpD8P0gGQhTsIQV6x4c39AoehTSWJzcptPAEp3uNBxckbKwRoSZkrAMhHFbwG4/tcFvldvrcObeGbt/PGIKPnuhf3+CV0ZWDiZooy7bCZDpQP4Sf9iyX4HuWkLQyOmjML0Ai0YdpbsRpVaQ7zNHRh4FNlEcwJSx6ra2zKBgA5dk6zLSdZ/0i/2VV4Id;4:2j6jyiv9k5dQs1YXuWKRV7/3cKIAZQvzUmPYXKyCGGAaQFH+rJ0as2h+wou1rPX7lWJ80Wo1zMEHfmhAFlUDeiApEDM2lDo9nuqRzB7OR42AuX8Zh1INnNoX5QVcbr1PoVnD4muLJB7CNcB6XaujO6srlDIGwyUkpegB4fxSnitkSaysqXZelYNocH/WbHkQae9rweXrLFaprFCzq5F03Y++cp/FhlFVIM+yPbwgHthB749qA381vGmAHMiM2Zx254STg0epqlwFVgSjepTgj5IrEKRN7bpvDtnmRmnuaXAxjmqpKaBMNEOHJA6vh9V1
X-Microsoft-Antispam-PRVS: <SN1PR12MB019090A63C7B7A643EFDAA358C490@SN1PR12MB0190.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0190;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0190;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(52314003)(51914003)(77096007)(2486003)(76176011)(52146003)(8936002)(16526019)(53546011)(305945005)(50466002)(386003)(2906002)(53936002)(52116002)(316002)(64126003)(54906003)(65826007)(44832011)(8676002)(2616005)(476003)(23676004)(81156014)(5660300001)(486006)(16576012)(26005)(58126008)(11346002)(110136005)(81166006)(446003)(956004)(7736002)(3846002)(230700001)(6116002)(47776003)(65956001)(36756003)(65806001)(31696002)(66066001)(25786009)(229853002)(31686004)(6486002)(6666003)(6246003)(6636002)(105586002)(72206003)(4326008)(68736007)(106356001)(97736004)(86362001)(478600001)(14444005)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0190;H:[172.29.157.77];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTkwOzIzOmYxUWR2T2pIM0kycFJMUFRoaVF6TDFXc2Rs?=
 =?utf-8?B?cFdEbVhkd2RBbTJYMnZUL0FlenlTWlNLdE9GczRwbml2VkhUdmRmalNjaFR4?=
 =?utf-8?B?WS8zaVRTREFmQzQxNTNjL25yK0FKaWFJalp1U3JIWU5SOXB0bUVJK2ltUDNm?=
 =?utf-8?B?TE9mQ2JqQnpYUU5OV0N3TDJpbU1IMVRRODdqdld0c0I3bUJpTStzV0ZaZnlw?=
 =?utf-8?B?RDVYYzQwTEl3OE93bVlmcG43U3ZRN3d4Tm5zV2RBZWs3bGpGbjEzSkZvVldU?=
 =?utf-8?B?dm0yV2NaK0J5TlM3S2RFZlhPd3kyVlZxU2hRMjVKTlRNdmtLci91bXZhQmpC?=
 =?utf-8?B?aGlpdzRyMVZyT3RkNUUzNlpGcnpsc3Y0VHVHYW55NSt2Zm5Cb3ZVaXJCM2JQ?=
 =?utf-8?B?TmVodUFEMmZzSGJUZUNaYkw2RHR2OXp6NGJ6c3RQYWN3QUxjWkhyYW1sNkI2?=
 =?utf-8?B?VTczVXpqQW9TdGE2eFFVL1pxNkpqZERUY3FDSlY2REtJTlBLK0g2R3F2S2Vv?=
 =?utf-8?B?djlGdkd5QTFyUTQ0a0JtWVU5ZGNnUlh2UCthc1JDT1VMQmhyeGJEVEd6SEw5?=
 =?utf-8?B?RnhwOGtLWWVla0JRU1Q5a3lPSVZyc3ZhL2E0Tno2eW9wTWNpUFE5MmpwOVN3?=
 =?utf-8?B?ZFBEMmVkODhzRStzd2J5aklWa1d1YmRReXJHZys0ZjBLNDErSGF3TTBxRTl1?=
 =?utf-8?B?U3BHMU56RU1xSWx6VDJZeTdrQjlpR25OOGkvbnAwY1ZwTndTR3BvZFhMWUNK?=
 =?utf-8?B?NVowVENNeXE0aVB5ZzM4dktwSDBNc3hyY1k1c3VGT05wMmtSaGRmTkVFcjhP?=
 =?utf-8?B?dkI5OUEyckgxVnIwSU9XWWpuVkp0eC8ybFRNMDVrdDIxY2h3RXRvQTJpWTB2?=
 =?utf-8?B?eUJYUGM0QlV5bHVVSk05ZkJRcnBNc0NhbUh1QXBpZnRrUlNkZlYweFFQRU9P?=
 =?utf-8?B?TWpQZDJZMXZXQmI3YU96aGpuSDNDUHZCOHNkLzNiSkpMbWY1ZHBSZzkyM053?=
 =?utf-8?B?b3g1V3BmQ0haR2xORFdvRHhVYnM0c0k1bHQ0ZVhFWjJ1dnN0azNEenozRXRo?=
 =?utf-8?B?VHBxbndpRW5WNzJkNm8zdEN6ZU5ub2hwVFd6KzFCc2NQYmFWZkpyZEt4Q1ZK?=
 =?utf-8?B?b1I1Tkl3dVYyYmpTMDNEUittOEttZGNWU1JRaHhBalh6QkhucHcrU3BCTWts?=
 =?utf-8?B?YVVRR01XWmo4U2FZeTI0WVlON3FzQ3k2YjVkYk5sdFkvQXMzZWR1M3I1bzdP?=
 =?utf-8?B?N1V5V05KMGtzVkIycG14SnJxTVlZSHJjSTFkQVhmckR2R1JZUGNWa3VUSi9o?=
 =?utf-8?B?WDJRN2tQMFRXK0c3UTdNT0pWYWFza2pWYkIzVVBESk1NVUdXVFFYL0NudGtu?=
 =?utf-8?B?aGh4TXFDTXN1S2RWbjB4a09jaTkwaW1xNWI2RW1HS3NYMzBYSHl0MDdha0w0?=
 =?utf-8?B?QU54NnA1VHh5VlMwbC83QWhDeVNUdDdzb3pSSjdLa25XdktDQ1VhSjVlR2Ns?=
 =?utf-8?B?anRNdXpvQUZPb0hQK1oxMTNHaVJZem1mTzl3ZlJlVkt3MUZqeUU1SmhqWVJv?=
 =?utf-8?B?TU4zM3VQWUlXUERjNkQvZ2kzUFlmM0VkZGdFV3FKS3VYN3BhcnFWRC9PMmk3?=
 =?utf-8?B?cjl6U2hvdEV3MTBKYlBUZmx5TGc3OTlQQWNFcmFQTGFKOFdxWHFWakxCVjEw?=
 =?utf-8?B?UTBaLy9sQ3FLUjF4OTEzM0FMVVFrRWRYL0syTThzVlJSTjVGR1hYY3AyNjRS?=
 =?utf-8?B?bXErWjMyUDdkUmhSU1FMdHJrS0Q4M01pYm9SdXNnTXB4S3JBTWJQMkczc1Vt?=
 =?utf-8?B?ekY5YmgvUkpOMG5PWUx5eUp4OWRLdzU5ZzcxRjZwS0JHMnF6TFBrOXA5ajRV?=
 =?utf-8?B?c3ZOZ0dHSlNmaFJhWmpSWnFRdDBEUmFmeWhjYXFQZFh0UzlvL3BEcWVYenRl?=
 =?utf-8?B?THN5TUhOYWhSTTU2Sis5NVk2UzdTOFdsb3UzTmUvV3hEaWpGZjJmS0NkQkZZ?=
 =?utf-8?B?aDhETkphZW9EWFFFbzVycHdMa1I5eWVWOTRMNXFGY2JFbk5iOFk0bjdJZm5P?=
 =?utf-8?B?dG5HSnRTVnZTM2JxeTkrNmg4SlkwWk1uZHdiYjVlaHprbFNYRzVPNGxTVU5K?=
 =?utf-8?B?T3c9PQ==?=
X-Microsoft-Antispam-Message-Info: fjlf7Lc3tydbNC9aD8taa3d2TQhXRqOQexC2QbzEjeA2/Ew5g0TM/cxeqB1pFMmiRl6jeVtA8Xr5+RlOlBsDf2lmTE89VnPn+rPj7/vsfRs3MvmKuCuYJ/L6VFmXt1R17XvV5SkH3vqG8TNoUmMfrik56WEqJnyhucvpErm/fiNWpYKQ+o4PlSCCwii/gpM5+SI/ZkjZhCJbAdQkbNsLzqJcY6rIuFmqjHT6IQYFrqXHU3yPUnplTogK3ZI1CYEPbVvwJKI3RwrHjuOax6DcTmCo8Vrm9e8hknPyvx0KxsNFRdVfLkzPl66H1GoL0Hxrqo6Tf/YPm64oUu0wM6TFJeQYLwGMimnG3NWdkVWw3BQ=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;6:0Qbdi27YCK6HCsuVtomDEfyPtCI+9MDzEWKnbCSKosC3/XSN4x04EwfIgV6Ztg1vBmi5k//UBaOZId4H3IhuV3NEehJpqZpHbDYsmEDhQsDX3ZjYQd5kN0ZpilAAUFrHDMm10GeJnpmIx+/BlECJ9vlic1qaGWJ6BipMih2wnC3+h4I/ijbSN2CfhsJT8GDjWglpYwlbOhG8L/ZL5bZ29Dys/BNdkoP5GRC/BdQb5+7rz8gPq3euYA1UM9FrDfKCQqhwjU8xRIE2vN7XNWGMSuHTxz2Zi8Yj+qjt/03FuCV84smyHT4yU9HwRguOTbb481f/xWdtxnrSPr8ognSkEMY86c8X0zzQsFWAfUyTyA9DLk3Z7uFPchK2lUMvMC16cNNr8zgYmXLA7nkVEUgdoJ3V1WLBCC8KV8TtafqIkA+OuNZ8IzwzG2HlukaA4E4ldvz/T2O9t6NLwi4LJoWbKA==;5:wv2OBSJVW/dX7GJ+7PGiPT0Ou40SZaCQQVgKhUTP/IoS9U9THx6ggmcp3pU4rHrhqD1DHSATIy9balLvEv47+kolPWE5vCINU94hvbJTmTSwUJvdkz9J4STZhXtI81+nnWf0Z6xcQZZbZgQJPHx0H96/RcKuJYAm0Bgco1fGTrI=;24:JtWfOcquAnmeunv6lgrcpp0/CXfqt51vzj6rLs+48Oy284hCN/dOhn7QqVffFug1KhbFzciqIvbyt31WProhB+xmlXWGotz+6zrwAfk0haE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;7:PPs0iB4yRnAyw34ropCR9WL1MP+wQzn5FrqObDauqLUWMfTszu/9jdivazYwlAVuLq8cNd9IwuHWkB8crNycFj54Jo2vCG2yBvC2QLXkKnKaS9xk8ZPDP5KBtjGgbfeQ6LSxf8lfr21jD5mIr1XPCgqQfEjWJMpf26RK967tyum3JIqvDg+zqWVSO4ThwxQXQFMu3VAdyRf7rKDK1bQbv09eWYe1wp+YHmz4GVh5KaKOJcUV/mRlRelrTdyzH0nI;20:eC85wa90wW9B9OgMphu+yLICa03zNkBIvA9bCILjEGd7hbGH5e1EgTvL9VSRX8JqqPPFYK2CIU+VV1eWm7A8spM7CopOliGCkRihAxEoHsKkqi8Bve45QJqRAmti6X+AnAe9fugON77LAz+/VPBNvRzHQX5boQ0ApD3tyDeSV4gjkjjlNpGyqdH/55rM10aM2J1+ODHmpmQVJ3pvf8KW8eZGh3zi/0+RYjCTf0q2FH0MGnVYhIZTY0yxRmoNn3UT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 14:23:56.7348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb684929-a1e6-46e4-549c-08d5db707449
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-17 04:53 AM, Stefan Agner wrote:
> The wrong enum type is used to initialize the result, leading to a
> warning when using clang:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1998:26: warning:
>       implicit conversion from enumeration type 'enum ddc_result' to different
>       enumeration type 'enum dc_status' [-Wenum-conversion]
>         enum dc_status result = DDC_RESULT_UNKNOWN;
>                        ~~~~~~   ^~~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
> Initialization of result is unnecessary anyway, just drop the
> initialization.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks for the patch.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Ill merge this today.

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 7857cb42b3e6..1dbfbfc0fd45 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -1995,7 +1995,7 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
>  {
>  	union hpd_irq_data hpd_irq_dpcd_data = {{{{0}}}};
>  	union device_service_irq device_service_clear = { { 0 } };
> -	enum dc_status result = DDC_RESULT_UNKNOWN;
> +	enum dc_status result;
>  	bool status = false;
>  	/* For use cases related to down stream connection status change,
>  	 * PSR and device auto test, refer to function handle_sst_hpd_irq
> 
