Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DC1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5C621535
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hw1tLpZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5C621535
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbeIUFmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:42:42 -0400
Received: from mail-cys01nam02on0063.outbound.protection.outlook.com ([104.47.37.63]:40886
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbeIUFmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvvOiOxdtumBJf7G8THnb1nrA4gaSpF4cxfpl0FPPso=;
 b=hw1tLpZ1AYCBy0MGfrKUwwef4PH4x55rHAQxOWAyTYr0Ahmd4tzo/WtgLOAHqmmUdFTsNhiuS3htS014hlvLig+FP7nfvbi6wvdSIlDqTC/lhtvo9SPCzQVbioG1X4nTalJgTek0tM2yZtS0V1OH2U8KzYB2CWMtwnCB2V1Cd7k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [10.224.54.236] (165.204.55.251) by
 SN1PR12MB0192.namprd12.prod.outlook.com (2a01:111:e400:5144::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Thu, 20 Sep
 2018 23:56:29 +0000
Subject: Re: [PATCH v2 1/6] drm/dp_mst: Introduce
 drm_dp_mst_connector_atomic_check()
To:     Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Sean Paul <sean@poorly.run>
References: <20180919230913.16894-1-lyude@redhat.com>
 <20180919230913.16894-2-lyude@redhat.com>
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
Message-ID: <ae042c49-1c0c-ae58-d1ae-5664b790e631@amd.com>
Date:   Thu, 20 Sep 2018 19:56:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919230913.16894-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::41) To SN1PR12MB0192.namprd12.prod.outlook.com
 (2a01:111:e400:5144::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02fe28cc-2c89-4702-342a-08d61f54afbf
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0192;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;3:kznWSHk1hA06Zq0NWNwRMftQlow/Qzqh3pRJk6LcqlPVZz4ICMKY/CO/bWSa4cGMnsqJ5Ez25g/dWSmfoqA7Y/y29z5UMZjRXNVK7eW7rzTkKCteU+fMycqc78PZoehgEyNyC+V0aqBZA53zue4HWQvwrDOb7A2CWcLB9nL1N9NrWeF+Cb5fX+pKR4/6zuG8/SljVH7fTqiHRQOIn4WTI/pHkRFaBz4U/HGfoVVrBbUmimkNgpJav+i4yqDtfMFo;25:a0n3RYr8Nothd0lN8ilb0ahq03OwS+97EhiCHYKsVSFIAYfupl9PHfNl2+IW+9xTWhHP4kxt7GQyYjDV3TsVNpcq1PUvZEqD1ZdIzGPdPL01kIlAKBuyTSIPzJdt7iVhl5PJS6Rcv2lROq/7+mmPV3lYzCGNqfkFxQXm6B3Sa1xg4N8QWWUyxR+Y65r2nU3Mt2s67oOA8JAWB5BJiuYIKZI+g+PkxUagv7QodGEo8Z1IpqXe/ShZIKtVbPOp3agEvvfBw04inYhVHIvCmIhlNckhhtPWYHe/dE0AW2yM7aQVmKQbGotEYXYBHGi/ZGQYoM1L9bIlTNa7FZcOTSoyRw==;31:kzpmYGE4ZK+Qo3r6H629pWrpeJ6t16TubsNL+EtktzRKCM8gvxgd4yenLldnPY0D0fCfMC8As0Q3SbcU1jFnKMbNrJP/G4g5cHzDgCXum7/lW+T7Y02M4GHFECXDJykcCc0hPRtPEmdR6ocnJUYiR5blaZvI8eBXbOjFXH2zIsx8Nwf3yyTLC2RsDMQfk7OXYd6RcSic74cMjv6yapvAS8fq3B/FB8w52EJ1btY16dY=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0192:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;20:Q9XPfyJsArfb+DJFKd7fuIxI3S9zmqe4GPiR74kkT7Q7sRRjur4DaI53BEaU9+2ks4EW/Bv/9VLoCie2sRLhqT3+qDbE/+56Ok1NCMADTknG/Gdn40i7imKtS0H+LG5AEvIwAtkyy3A5gpIayg3acx6/3pJGLyGdDfjtQXpj02bdJiTNIH6hCSt4XG4DRsH7L1IdGTGw5RS1dG2TPVX9m7Cn7wfOR3G1AAyL24ve30vJo3GY0iHKFRfaq1sgdTHZZHgUn7WNcFLta6H2DFeHctiS5lZtkhaYdFufqEqKJODcTtm3YVpEzfG5J+EN/VqONcox2R85lxNtGAjyRMnrvky9tVWiHfo7mJ7+kFSROdLHOvoS1gKh+uWPGzqpNP3fEsHqhEzMeufincm0vg11DTRoR9UwaX/u6Q5UPXjvhkKwdiyh/jOJxrSQMrXJH/fTqKpuXyuq73wfHx11sHfGMcVNbBX0s/vk5Bo+HRWyaZTPXsSrSQ4cl3WH97XQ/DgW;4:LoT4aeJuXajJWj1kPs2QomkoLe/NQIopElfzDClAhsyJDiPORAdXKZ9TdKAwE0mJy6EQQw+sYciDN751enddSBk42nA4NmNu4wtxt2IOkTsi1ofY5qfE9OhiVnZZlzyECgNFX32nYZa8o3rT9PItcWf1wPlW2yTxzS+hYxU5vALHkC45leebH8meyCb2SVt+tDPSL2cgLaPbKPz8dADy5aaxfip21kRLegagNfNXUS+JTURjLKQLnJsjv7Vo3BuGdJqRcwklH61eTMLNqsfwa2aYl9iDECsNA2V8HYz8ZBbBQ/PI5gEwLY9Tk06OjnRiJk5fmxccsXgFYudTF3cYEA==
X-Microsoft-Antispam-PRVS: <SN1PR12MB01920B1315D612B5E0A1C7A98C130@SN1PR12MB0192.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:SN1PR12MB0192;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0192;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(2616005)(53546011)(7416002)(81166006)(386003)(81156014)(76176011)(7736002)(316002)(31696002)(106356001)(105586002)(31686004)(6246003)(305945005)(4326008)(25786009)(446003)(16526019)(26005)(3846002)(77096007)(186003)(14444005)(8676002)(11346002)(486006)(64126003)(52146003)(8936002)(65826007)(6666003)(5660300001)(86362001)(2486003)(23676004)(52116002)(956004)(230700001)(44832011)(229853002)(478600001)(72206003)(54906003)(97736004)(6486002)(68736007)(53936002)(16576012)(50466002)(476003)(58126008)(6116002)(2906002)(36756003)(66066001)(65956001)(47776003)(65806001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0192;H:[10.224.54.236];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTkyOzIzOkIvSHIxZWRUYlg4c2RGcEpmTncrbEpta1o1?=
 =?utf-8?B?d2t0WGcwOE5SeEFEYWFtdWtuSWZMYlN5cVAxZDFFUlN3L2VCbVBKT3V3RzQw?=
 =?utf-8?B?WXBEODNkWi9QVmM1TGFValNCd3FlejZxUFpRSmhaSWJ4UnFMZ2FxQU1qMjdz?=
 =?utf-8?B?dnVzZnJlaUtTVzA4NE9DUVdVTmhiTGRBdGVtdVc2QjNCeE5hR0VSRXV0cnpm?=
 =?utf-8?B?VzloSzJabGFsSUdxN21pb3kyRi9zNU43UzEwYTRUS2NhTGV3RTlta1M0ajRF?=
 =?utf-8?B?QUpycFVGSXY4K01pQlVXWWVFOExNbmxLbnQvZDF4aGVWN2Z2NFFvV2FtVkdN?=
 =?utf-8?B?akd1WXpCc1pxMWZud3NmYkxYZnZyMDdkK0Ywa2NqWGtRMXE0djY4bmZxUmc3?=
 =?utf-8?B?ZGttZTRZeVBKWEt2V0ZROFRndlNyaDgxdmMyOTVCbTZaTUxKYzJ0SzZyU2pq?=
 =?utf-8?B?ZDJXaHlYb29FeGJvcElsSnVSRmI1TjIzclVBYllyUlQ3cW5FeWpSVmtUZms2?=
 =?utf-8?B?Z1hSYldlQ1VrRmVOWFVjZExmcXdUV25zMHV3QWhmMmVOMWRTYkJSYjRBemNv?=
 =?utf-8?B?anlnUDE2c3Fvd3c1a1VmR2FqOGZyUWRVL2JJOW4vM3lTK212UVdmU0N5UWhQ?=
 =?utf-8?B?MjhOTkJ3VzA2bnNLeTF3WWowcmgzRDRlNzVNYXp1anZKMk1vMUI0UTdia1NO?=
 =?utf-8?B?aDNGK1llc0FJeElYb1FRdDBaZExqMjNtd1R5ZEx2VmlTcHZlTU4xTkVEQ2hl?=
 =?utf-8?B?ZkFaY0Z1MzhSVGRuS1VGRHdEL0VhTjRTN244c1NjemZweXNXL3N5aWpKVUZz?=
 =?utf-8?B?bFptVDlCMXova2dIOS85enJ6bE9YNHZCeHdQVUoyeVpQYzBnNGhlU2MvQUQ2?=
 =?utf-8?B?Q0NEWDFybGVCTkRWTTZGMTIwemlCK054WUppYVl3UGw5NFY2RkpNU2xpTEhl?=
 =?utf-8?B?S2gvUkJmWjErVWNiWUFpVkt4SmZEVnl5dmRSZ0drS1oxbFVvYzcrbElJek9I?=
 =?utf-8?B?R2JydEhYZU1QWEtrVTFFa3k2M24xYWxrNzNOOC9adWJ4MjNiYXMrRTAvZzhH?=
 =?utf-8?B?K1lGVHQvY2VLQk95TXJaRXc2WGl2MXdETWl5eGo5VnlMcERUUHAwK1dTcUJ0?=
 =?utf-8?B?UEgyRUpQQzNUTnBmZDNDVFg1WWd4anJYSmMvRGZ0c1FRelh6U2hxejNKbzVO?=
 =?utf-8?B?YzZGNkREQithNEtCRU43cmZrSGJTVmxGdmg0ak8vRGFXQU9JZzduYis0TG04?=
 =?utf-8?B?UmFEVGd4dk0vNlJ3K1NiV1MrTWdrZnlwNlk2UjF1aTFnZUlraW1wWFJKelVa?=
 =?utf-8?B?cnZNcmZudjFyYllkZmlkRzBoeU9SRDBBY1c2S3pJRXUyR3QwNVd1OVppNVhw?=
 =?utf-8?B?cVBwa3BPOXlTRlBqdnhNaWxQb0tId0Nqd0tVdGZyNU1leEJwOGRlUUpMb2pL?=
 =?utf-8?B?b0sxazBFbkluRDAxM0l2a2pvMUloZjdobzZWRlpNUVdxaW9OL2FucDVxMk1G?=
 =?utf-8?B?czBVdGxmaExsR2dXNHJ2QWQ5RnZWMng3aklVa1ljWEZneG9BWjdvVjN0Ti9u?=
 =?utf-8?B?bHA4ekp6TXovbnpjTTlIbXhWZ0JOQXdLWHhYd2svNTVjNnBKRExkbEtheHYy?=
 =?utf-8?B?bTMrdG91RHpsTGFEQzY0YkZlRDdyUkdjcy9xaDZ5UXNMTDUza1cydTVZU3pq?=
 =?utf-8?B?TlhwSWhQcnpzMFpOb1QwSVpQM2lNRmhWRFlYN1luOXRnZ0hMMU5YSTRGUnZu?=
 =?utf-8?B?RmNNd3NQdFJjRENLTytCOEpHd0oxRFBPV0daOG9VSUFZdVdqa1owN0Zwd1R0?=
 =?utf-8?B?Umg0MGNWUGdXSWp2VFFRbVRkZ2hicmxqV1c4b0hkUnFGRE01MzlBMTYrdm5o?=
 =?utf-8?B?aERWTFB6SzlzUUVONjFlWHlZT3JMUVFtTUJqRG9CYStsRWxyTE1NcXRoSWxT?=
 =?utf-8?B?d2RuMUcvQXE2RlVpZ29PdVA0MmVaNG5ac0g3ZlF1R3VUc0NxS3VTSW9XMnIx?=
 =?utf-8?B?Z0VUK3llNGFDT1AzcHNDTDhvY3VjTDhzS2VkZz09?=
X-Microsoft-Antispam-Message-Info: zTG0svrj29o0v+7T5uj+okUBIflUP6ofMRaZVVETfphqujW5SCE4K58Y4JgYRJBd7JpfrDpESQtN0C+8SLWAk0XPEhCmlBhKV4UueqhI3E73W+rHEv8kkBTh5ZoLTKJRUi3+oIvqxpMHZwkAm2fog5u/wwEztiHAWesA+Glp0gv/UyUgORk2hlA+0uXAKmvtsOtVtw8WjjjBTsOTP8PPeytWKNdSDMb5ni+7v+0a5sqvOyhgavGuLB6zldqlGcUFNM90rfAwxU7ysEePgANBOgDuzpPz4Qwz1HkKNwerkW2gJSTOYpS4NSS+B9+hWf7dGt/oyHP/NtTD3VqFLmIkjv6dx9EtUa014CpZTp9za5o=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;6:rzOmSkpE5vrvUTwC/Vxy9oztgNDZL9O8perjm41WnAwD+YcwR2GbkYlS19hRoksXtGzrfoOh+HJlJUunCSbtCisPor2vobuDjdXrMhwMiDpXZrV7+1AySGcQdI6Q7OauQmGC7i8gDhDOabNlKVVoSaQ2D6Pgj7+9FQT2O4X52w1rMgPmxCmNfQBsNU4igRRbT7h505euZV5qBYCyJekyiuvnV95F+Rnft/6sozLPF+RqzFje4uhwDjeqzPbwFVo5dnl5xHdxJ/ibVwvOazYxItImiFEVUqxMHEezR4kBtwlZbcYvgHJBi/foZLGLt3TLBAhy9/8Hzq747H13WJ7lfpsGbrxRN/dVv8SzzLK3fjiVGPMns2ybJCZICxCL3HiUY13Yl/jVzCyVBXKvxyrcoOIAHVLUd7ogu1f1+8AuseJPQc9zwG6Od38Wx7xizqpo8YgTWfDao/1b/G8pJSt5WA==;5:a9VUiqSkTGlw4Ccy8O+bl9pgWK5p/icayabGdgK/Wfgv8M3xDq8UnkLrKF2BnoUs8n/XRH/YiWJdei0Fl1eeVL9KVn8cXCU39mmMyjX0XHZNF7fGwETLYtpH+dqZRpIFL2ySVLgUxEm7Q0CBk92Uv0uI4nmJgcRCaBwJgkh0w1c=;7:lXyh8EyhZ+JdawMhfN5B8qOx9oCJXqChw5t4fBaQY+56qtH4k95vDMghRYzYboLMazwWcYqydf+L8+o7Mnv4sEE5aphORglCbxyxfn/ptdCZvJfCCJ9/yPjYCDULp9kUvx7tHuVlQvxJqmmZY/TcQJZpwsuciIbcWti3JibwVwYz3pjE3X4QxJxVo5lOiZup3/xI7F+00JEQdhzKr52nvQMyEB4LEVaciZraBems41RNelg87OJTxRsDCTn2bytm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;20:BtqMt+Gz/PIlVIBbUkwAqeVfjvOIb0C26nwhKNk/RYcQzjlHDk+DahOjRawhOmpuDoSUlsY3k//a6I0qaYRcdbHKlMfrYkMh1Agyv39YpGOygXh2itvZ8LyUYSWs5W/fS8Z7yXDiQ9Au+rUYx4uea2mxB2OuzBWPUjQJOr1M4MWOpaMLxmOOD8X3Ujg9Y+xMS4mDGMG2AvH00uYQMJQYzQF9vyGopJbU72Afu4GSy876Ok/4LasTqj4ik3Rhnxt9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 23:56:29.1542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fe28cc-2c89-4702-342a-08d61f54afbf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-19 07:08 PM, Lyude Paul wrote:
> Currently the way that we prevent userspace from performing new modesets
> on MST connectors that have just been destroyed is rather broken.
> There's nothing in the actual DRM DP MST topology helpers that checks
> whether or not a connector still exists, instead each DRM driver does
> this on it's own, usually by returning NULL from the best_encoder
> callback which in turn, causes the atomic commit to fail.
> 
> However, this is wrong in a rather subtle way. If ->best_encoder()
> returns NULL, this makes ALL modesets involving the connector fail. This
> includes modesets from userspace that would shut off the CRTCs being
> used by the connector. Since this results in blocking any changes to a
> connector's DPMS prop, it has the sideaffect of preventing legacy
> modesetting users from ever disabling a CRTC that was previously enabled
> for use in an MST topology. An example of this, where X tries to
> change the DPMS property of an MST connector that was just detached from
> the system:
> 
> [ 2908.320131] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:82:DP-6]
> [ 2908.320148] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:82:DP-6] status updated from connected to disconnected
> [ 2908.320166] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:82:DP-6] disconnected
> [ 2908.320193] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 111 (1)
> [ 2908.320230] [drm:drm_sysfs_hotplug_event [drm]] generating hotplug event
> ...
> [ 2908.638539] [drm:drm_ioctl [drm]] pid=12928, dev=0xe201, auth=1, DRM_IOCTL_MODE_SETPROPERTY
> [ 2908.638546] [drm:drm_atomic_state_init [drm]] Allocated atomic state 000000007155ba49
> [ 2908.638553] [drm:drm_mode_object_get [drm]] OBJ ID: 114 (1)
> [ 2908.638560] [drm:drm_mode_object_get [drm]] OBJ ID: 108 (1)
> [ 2908.638568] [drm:drm_atomic_get_crtc_state [drm]] Added [CRTC:41:head-0] 0000000097a6396e state to 000000007155ba49
> [ 2908.638575] [drm:drm_atomic_add_affected_connectors [drm]] Adding all current connectors for [CRTC:41:head-0] to 000000007155ba49
> [ 2908.638582] [drm:drm_mode_object_get [drm]] OBJ ID: 82 (3)
> [ 2908.638589] [drm:drm_mode_object_get [drm]] OBJ ID: 82 (4)
> [ 2908.638596] [drm:drm_atomic_get_connector_state [drm]] Added [CONNECTOR:82:DP-6] 0000000087427144 state to 000000007155ba49
> [ 2908.638603] [drm:drm_atomic_check_only [drm]] checking 000000007155ba49
> [ 2908.638609] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] [CRTC:41:head-0] active changed
> [ 2908.638613] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] Updating routing for [CONNECTOR:82:DP-6]
> [ 2908.638616] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] No suitable encoder found for [CONNECTOR:82:DP-6]
> [ 2908.638623] [drm:drm_atomic_check_only [drm]] atomic driver check for 000000007155ba49 failed: -22
> [ 2908.638630] [drm:drm_atomic_state_default_clear [drm]] Clearing atomic state 000000007155ba49
> [ 2908.638637] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 82 (4)
> [ 2908.638643] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 82 (3)
> [ 2908.638650] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 114 (2)
> [ 2908.638656] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 108 (2)
> [ 2908.638663] [drm:__drm_atomic_state_free [drm]] Freeing atomic state 000000007155ba49
> [ 2908.638669] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 82 (2)
> [ 2908.638676] [drm:drm_ioctl [drm]] pid=12928, ret = -22
> 
> While this doesn't usually result in any errors that would be obvious to
> the user, it does result in us leaving display resources on. This in
> turn leads to unwanted sideaffects like inactive GPUs being left on
> (usually from the resulting leaked runtime PM ref).
> 
> So, provide an easier way of doing this that doesn't require breaking
> ->best_encoder(): add a common drm_dp_mst_connector_atomic_check()
> function that DRM drivers can call in order to have CRTC enabling
> commits fail automatically if the MST port driving the connector no
> longer exists. We'll also be able to expand upon this later as well once
> we add MST fallback retraining support.
> 
> Changes since v1:
> - Use list_for_each_entry_safe in drm_dp_mst_connector_still_exists() -
>   Julia Lawall
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Cc: stable@vger.kernel.org

Whoops, missed the v2 earlier. It's still
Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 76 +++++++++++++++++++++++++++
>  include/drm/drm_dp_mst_helper.h       |  3 ++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 7780567aa669..58b9554711c7 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3129,6 +3129,82 @@ static const struct drm_private_state_funcs mst_state_funcs = {
>  	.atomic_destroy_state = drm_dp_mst_destroy_state,
>  };
>  
> +static bool
> +drm_dp_mst_connector_still_exists(struct drm_connector *connector,
> +				  struct drm_dp_mst_topology_mgr *mgr,
> +				  struct drm_dp_mst_branch *mstb)
> +{
> +	struct drm_dp_mst_port *port, *tmp;
> +	bool exists = false;
> +
> +	mstb = drm_dp_get_validated_mstb_ref(mgr, mstb);
> +	if (!mstb)
> +		return false;
> +
> +	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
> +		port = drm_dp_get_validated_port_ref(mgr, port);
> +		if (!port)
> +			continue;
> +
> +		exists = (port->connector == connector ||
> +			  (port->mstb &&
> +			   drm_dp_mst_connector_still_exists(connector, mgr,
> +							     port->mstb)));
> +
> +		drm_dp_put_port(port);
> +		if (exists)
> +			break;
> +	}
> +
> +	drm_dp_put_mst_branch_device(mstb);
> +	return exists;
> +}
> +
> +/**
> + * drm_dp_mst_connector_atomic_check - Helper for validating a new atomic
> + *                                     state on an MST connector
> + * @connector: drm connector
> + * @connector_state: the new atomic state of @connector
> + * @mgr: the MST topology mgr for @connector
> + *
> + * This function performs various atomic checks that apply to all drivers
> + * using the DRM DP MST helpers. This should be called by all drivers at the
> + * start of the atomic_check function for their MST connectors.
> + *
> + * Return 0 for success, or negative error code on failure.
> + */
> +int
> +drm_dp_mst_connector_atomic_check(struct drm_connector *connector,
> +				  struct drm_connector_state *connector_state,
> +				  struct drm_dp_mst_topology_mgr *mgr)
> +{
> +	struct drm_atomic_state *state = connector_state->state;
> +	struct drm_crtc *crtc = connector_state->crtc;
> +	struct drm_crtc_state *new_crtc_state;
> +
> +	if (!crtc)
> +		return 0;
> +
> +	new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +	if (!new_crtc_state)
> +		return 0;
> +
> +	if (!drm_atomic_crtc_needs_modeset(new_crtc_state) ||
> +	    !new_crtc_state->active)
> +		return 0;
> +
> +	/* Make sure that the port for this MST connector still exists */
> +	if (!drm_dp_mst_connector_still_exists(connector, mgr,
> +					       mgr->mst_primary)) {
> +		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] has disappeared from the MST topology\n",
> +				 connector->base.id, connector->name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_dp_mst_connector_atomic_check);
> +
>  /**
>   * drm_atomic_get_mst_topology_state: get MST topology state
>   *
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 7f78d26a0766..8e33c2c85d1e 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -625,6 +625,9 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
>  int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
>  struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
>  								    struct drm_dp_mst_topology_mgr *mgr);
> +int drm_dp_mst_connector_atomic_check(struct drm_connector *connector,
> +				      struct drm_connector_state *connector_state,
> +				      struct drm_dp_mst_topology_mgr *mgr);
>  int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
>  				  struct drm_dp_mst_topology_mgr *mgr,
>  				  struct drm_dp_mst_port *port, int pbn);
> 
