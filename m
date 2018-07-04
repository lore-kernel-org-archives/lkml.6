Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D7CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81B1242AE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JxrfHTkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81B1242AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeGDRxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:53:45 -0400
Received: from mail-by2nam01on0051.outbound.protection.outlook.com ([104.47.34.51]:14516
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752218AbeGDRxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAbw+mrBeer9CXmskNk5TecRoWykZ0kAG8hgIzSYuDo=;
 b=JxrfHTkfExSO7vMKx2FUdSQBr4ebBkC31gs6cNKevVARFqPbAD3yeoEn7M4cqyNNN9WRcy8XpD7VE0+Gq89l+PWgcrZ6qQ40VsoxKJGvyzvCDL5geLX6KzS+dV7bIbjtc5ja+VAA4GZXvC8vWPZN3GczyoeGfCkYAJu1p8AeUbQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [172.29.157.77] (165.204.55.250) by
 CY1PR12MB0183.namprd12.prod.outlook.com (2a01:111:e400:50f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.21; Wed, 4 Jul
 2018 17:53:39 +0000
Subject: Re: [PATCH] drm/amd/display: Use 2-factor allocator calls
To:     Kees Cook <keescook@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Vitaly Prosyak <vitaly.prosyak@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180704172730.GA33562@beast>
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
Message-ID: <fdbc41fb-2aba-626d-da69-b03ecca40d4e@amd.com>
Date:   Wed, 4 Jul 2018 13:53:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704172730.GA33562@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::42) To CY1PR12MB0183.namprd12.prod.outlook.com
 (2a01:111:e400:50f8::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87c5f6bf-a018-4f50-4f3e-08d5e1d713e2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0183;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0183;3:w85w4uuwMWW2qf5uUuap0aucF1A8v+VVb81XltUQEsqJdxv6Z0OKShNYK+35ZnjhysPD3FhdtWxhdtlKguyjGYq+XEk2VbJywfC+pA+cycez9+VRDx3+qofb9yy80Ur037L/sRupOpuweAsOB6bAo1MsL6EuCwA1SujSQZRTQoBynp+b7JiFtzH0wzZPRCp4fbTme9X1YHo022UKzHPzjGQm538pfaxMBb547gHAitun8sTecT2sptJ5ViJrgpFE;25:JcMGT2tmlYoEMXH03myqB7OMEjggf04EkWD4kVsOnuJKdzbO1u+QzguRKDwLw4Y9SdWAZ4m+/cOcdhS19MGFcUpwTVQ50GtMTLOTtC2iTz+dHIiPUo0DY5xmBkRxK1GGiav/ASZcnWeqR6sNa1VGv3iUKwmshoyB4/OT1Temvx9DywSi/HXunKMxeiKMbI3h6gCDxQoZURaw7lMZp9oLDV4dLmgCd9yYWNFcNM2/5uJE6MyEcg2oV65N6nf8W83c03esED+5teKn6WTrOIZNd8xlFXH6XFp3gQNguQGSK5liAYfjoO1qYIA+twF4jAXz3jGbxBLHspznwljnBgnkag==;31:hI6yULgNOA0NIv1GwUexK4r3nXf/9fDJGBOBKcwelXdz4C9XzgNjJJqpJrIn8gSDN2AEvVaSEZKxXMOIWTsX5mgCiHUg0qFi2XFWaCGcUET8C7amIScP0hXYUNviULFpEfHhJ1fsg/fQdr90G2sPOMmkujBd0FRwVJRAzJriQEWq9ujRDe2g+wQMx7c3PlqJoJpdmvxz10saKoAFnNuShVwdiLQhiH9NUcH6BDU/P4k=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0183:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0183;20:JrC8z4Jg9A0vZaPpeHHYBXqrT1Dz0ePKOTKFsMEbsNM27kiHtWI2+10soze0llma6gGMSDofOn/p+Tq3Dzxr9dN3rshJVGWdjB4yPteignjs9ovMXrUxLqXoqrVqB84n0hk+lWbaF2vvCXBg8BfCC3jPTMflrvVZPTh3MevALVTmvYoXfiU04bVHntaeDg3Ry0oBsHxSLa3AnOU/tUmTSobNPjP5KytKQGmHVcC/4VzTrhzgDZ5RueFJ228nA6TJuP8MWpQrMH1768X47Mh4LjZkkg2HVgswCbMZ7CYI84E2J/PXWBvlIOJpXT3S1W6PTGcT5xvGmuzowTkFlgbtFkQGOhli5cP6JVB+Vnu7MJYCwoaWDX11aF7Veofu5kJYZ6Ih2GqfShL6UA3pPVUNHw3MTFlgzPRjYF+b9doO1a0StSgkWi9/OcJWALd3fcWwunCb/h8SF6vXUo8M6pusqmY5H27M44bn37TYXdoHiDWEUH6BnHDZV0xqCkTeo5Jw;4:LmVxgwjUo6PTikv77pzClccAq4LG0ilsL5DObzZChbjEFk1yrf+YLkFFSe2Xudgtm8tng6FCtyc4ULZt1ystZd4P7BBeZ4sOSOEOB5AhERm5DUklezybMOmYKG6Xxbbn5o/jgkQkAmwt8HCBkX7t69OaUZVT7UkMAxAvOX9GH/YDxt/+Q7vJc7VjY9siDPam1PWkxkibAL5orBs6BKh9sGE/BnsKsHwQboVqrjK0LFVJIuftu1OMz+EX7Rz2I11rEcHs+4wt8o9rpp7K9ohMmRqgY4DwuoI0iWBT4kABJ+AZ6CAJHlMZT9up0LwfSUXj
X-Microsoft-Antispam-PRVS: <CY1PR12MB01835B1103DFD85D9A7AD9188C410@CY1PR12MB0183.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR12MB0183;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0183;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(16526019)(81166006)(58126008)(97736004)(81156014)(25786009)(316002)(386003)(26005)(229853002)(110136005)(77096007)(186003)(64126003)(230700001)(65826007)(53546011)(16576012)(4326008)(8936002)(106356001)(54906003)(53936002)(6636002)(6666003)(36756003)(72206003)(8676002)(6246003)(65956001)(44832011)(31686004)(52146003)(68736007)(2486003)(7736002)(47776003)(6116002)(478600001)(76176011)(105586002)(65806001)(50466002)(23676004)(3846002)(446003)(11346002)(2906002)(486006)(6486002)(31696002)(956004)(305945005)(86362001)(66066001)(476003)(52116002)(2616005)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0183;H:[172.29.157.77];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTgzOzIzOnB5VGZiYlIvL1daNm04eENGbVZXYnJQNklL?=
 =?utf-8?B?NkZmUHBMZXJId2UwTENIWHF3eWJhcUltRktXS0NqSzBuVHVlZkFkUVJ4anRJ?=
 =?utf-8?B?dWE2TllVdks3V3kycGF6eHZIbTErcCtTZkV4VmdKOVoyYWkzNGpRM2pUTFpt?=
 =?utf-8?B?aHlDZUFocWE1ZnlySjlWckx0TUN3NFpGalJrMDRPajR6SG5qMXBRY3lUWTlS?=
 =?utf-8?B?U0d3ZVRGYjZCd3NUaTQwYTdsb3c2TURqaDg2UUdwM214NEgzeTZ3d1dIVWdR?=
 =?utf-8?B?NGgweVhJMGRuRUFXRmpabkZsTkJMRisyNUtLYVRFOXBwSzdrMUwzMGdZUmNL?=
 =?utf-8?B?dGJSZzFFK2xHSFBIeGRndWxyZjh4OTlnLzhTQklPYkVDT2tmVVF1clYzRXpq?=
 =?utf-8?B?U1VpMkI2eWNvRzdwRUJscVByUU0xaUVmc2RrTVJKa09uMytsazJadkhJUmdq?=
 =?utf-8?B?T2F3bUhqeVZLMVBjSlRFR2QxbWRubFU5ZG5kSkZpUWFabHRTM1Nob2dXYUVl?=
 =?utf-8?B?L0pSS2x6WThxOG9GYlJNZ292TXlNSFRRdVgwRXVkMmZXcnVYL1BaMTBvYkRH?=
 =?utf-8?B?SmV3emhwZ1hmemtOTExkMkpOaUQxRFExT0w2RTE4Z2NaWnhEc0JhNlJtdW9v?=
 =?utf-8?B?dVdiSWJHekVQRlExUDFpUEl3VmlVVFA0cWFkNW1acTI3TVg4anBlN2d6cmZa?=
 =?utf-8?B?SS9HWjA4aTlVd3ozcnRkRTNsRzR3eHFCYXkvOHBOU3ZzcHNYbjZVc1hJRWxB?=
 =?utf-8?B?YUZzOTBNNTVnNGtRMkc5QjlNZUV3TlBMRHJLZTZkVi9EN0tUdVFnTWtDajFs?=
 =?utf-8?B?bmNFMkV1bEY1SkNBWXk4VDdoYmlDQjJIamt3dVZ4b3NxaUgwZG5yN1d3ai9Q?=
 =?utf-8?B?T1lPMW1RQmFmeDFOV0Z1VFNWd2J5TUc2Tlc4R0NOdnBiandTdGhKVXErY0ZD?=
 =?utf-8?B?V3pqMzQrL0xzRDZ5QU1TdjFScmMvWG4vZStybk1rSXZGcHhMOEo4aFVyU0RW?=
 =?utf-8?B?bVFHN1o2UENUMHFCR3hNZlNrT3NkYVY0OHc0bVkxVXF6Vjk0cWtpLzEzOS9O?=
 =?utf-8?B?NzRSSm5jYVczZ25aT3E3RHVZVkdLV3ZoOURrRDVPazJ6eHRmNDQvc3dwUFk2?=
 =?utf-8?B?WVMrSXJjcCsyZXdyVUU4YmxjTk9PNzJ4NXhpNGpzVlVXYkRac3BxczVuQTNL?=
 =?utf-8?B?RmlsL3dnK091QStFQTlvekh6dnk2ZHIvRTFUQys2SzBnald5WTJSK1JsODIv?=
 =?utf-8?B?eEo2T1krYzdtUDVTUDdlZG9YZmNWR3MxWEVwbnJSclRTc3ROMFpTK2ZldVM1?=
 =?utf-8?B?VGo2dXZDVkwzaWRCang4RGRWMHhBTU9USUVCdi9DZk5heVBxcTRhcmJsZmdX?=
 =?utf-8?B?OWoxdUU3N2VlcWt0MXFxWVpTNy9CQzVVKzJSNGZzQ050UDRvYzF1Q1d0akNI?=
 =?utf-8?B?RjJNc1N0eHBHelR0c2wzWXBsNUVITVRVZHhSVUs0cUl6Z3VmMUVTdmMxdkJE?=
 =?utf-8?B?aHkvRXFLTGpmcWhrMnI1V1MrVGIwakxWNklaNDZwOG11c3U3SHRFS1ptUEdo?=
 =?utf-8?B?emlydEFXVHpQdTVNa0c1NHExbDlCd2RVa3Uva1ZwVmFNMW9KUTFRejR1WElt?=
 =?utf-8?B?K1M0MzJsWCtuaVR2aEhEZTNTSytUaGUxTytJM3E0YWpFcnZUbFJZT1BrRWpF?=
 =?utf-8?B?dDl0TXZ4anpETmhwT0ZKTzdraWd2enY4enRNUEhmNzBUMjVLN2xpaFlkZUJu?=
 =?utf-8?B?ZHYvZ1U3aXAxMWtpNFR4WEpTUTZUMmduc1ByZkkxb2lyRTR1Njg3Y1FZK3pB?=
 =?utf-8?B?cmRDdzR1UEtMQllsbEphNmc5VWhqTWlHMXVweldrenQ3czkwK3lwbEY2bW1m?=
 =?utf-8?B?TzBFTkk2MGc0ZithMGx1d1FNQ25Bdk1qRkxENDNqc0cxMHZ4MXpuZ3dIdGVa?=
 =?utf-8?B?SGx4MUROcHVybkNtZ3kvMC9MVURWK2JNSVFyODVQdG00WjA3c0NwL3FXYW45?=
 =?utf-8?B?ZkZUMVZjMjgvUnp0RjI5MlhPS21lSDIxdExqdz09?=
X-Microsoft-Antispam-Message-Info: X6zgxa4rqVT27r93WamjCtgcFeYf5v8iy778LFui1kZGOPASHa1UlvOxq/YJ0+4cRVFWaMHDHP94553YCoXVPyHFl/RmSFfoUxxVCS0t42JGEjybDafUcxeHFeZIWTRoNafzWcp7c7i72+/KhX2pY0v94UElt+Ncr1wCe9oNYO06mlnPc7PwZDakxOguMweXLFi0EmMOnlsC9MLFOlx5X1cRueJ1PgNWj9X+9//KWUigpvxy6Q7WAyOt2hTjYRaopixubfXP0tRUdSw1JcA2xH9OINpNgpBCK0DFAUDqGp+KY7Hu8DziRsSITdUa7nolxs0mo2l0uIDtGNHjwf32riE+KBsLhZD/yFFQyIaarVQ=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0183;6:bmclskL16e9cRt9YeRA628DoAIZtR0D+1SABVBm5mkyzXztcyTXM9LG1hTLqzaIqHQAdcIWuJreYX+No+optjvTpPynUuUfONB4EjCU1V3lKV7s1iUIQOlsId9lCclBwwGq0UobJh1mNuQEbRPJBgD4sRDSfEAWxogm51/mCoW8Rg0BZ0nPnvOxyAFW16ejMAgYZQKLe45G2LkNshREMUfvZO+5wbFl24qQ5kdXJ8VVQIPrSgZ6Fa/Mj87m/QM/DYbexmnxUQdWepZG0fBy0FPXikrpp3YOrolryx+dcVFeqOjWJchbtzJb6ZcwmtzxV6YINQ3eKWgyNwJnJgrWgIgpH8/cpO9uqv54QksFksGV3e026tlpwn9Kk2c7KNhBOOD5wl3n6xr05T/O6TJX3a5uinB0eIqfzz7t8Ytk5z83CBNssYxJissJpfuteRKGGE09CWbcmX/QBLi55HBOXdw==;5:/QUhke2KrJHIj8EGU7N9/wTa74legLLAsIu1r8oFutfFLeEEekft8w13BrOmYEj/uRIU345oL0P9aGAfHZFCJdO0B5laylOFKy84n9TFMVxQ1XGW6Aa//uFNt22+IhGM+bWRMbrMBK+lRsqVdhhSOFvFejJMfhPqfx30QpNWsZ0=;24:cNUDJ7GImlxa4V2K/K8cpEEsOfN5NQoDrLoqJwAbO56UWqwFbDSmLkZd3GKe/B0Meh/aISBoEGVyoduUpLNXB0j9ecawHCNcUg2V3fxC33E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0183;7:lozec1LpBCcSzjEmCA6yvEAq8wxeJcKBxuwcpGJt3GH7rPeAOZ4r926/O6OSMGG2KcEhm1csLobD+rtPQSekAMkxA7X0oqKroyaNj5PguzqYmHr7HEuPT+rvnjhXwervhH0WCCAsXYYNbAlcsakb5uF4eeMGWK+gxY4NjutB5vewL3LzVuPTcZ41qg9KL/G+7Y1uz/gHkjbG/Zs74RXylgruD+REIfu30qo3U/paGLfbht78WbXg5d8laaV8yLC1;20:7Cax/PT7PgYMyhNXQbRGElU7+vH0oZosZkEI1sWvxg8VlhzW5wVDZNLand2m9jG4y05uAU6UFNyMd1HO1HtZl4qkXWg4HQMkAD2Vp5z+V1OJwEUDMKuqlgQJWJFgBmi1esyJ41bJUmNfaxUT11XxaY1GTAx4iLpLV4MVkxC3tk9NN5p3E3rkzkLg/q06WG2/LypjgMVE0SDrKJgDGZTN92bnV+OYmbIJSO8ddcVU02tq1+vgeplAJVKAm26Sne4F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 17:53:39.9360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c5f6bf-a018-4f50-4f3e-08d5e1d713e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-04 01:27 PM, Kees Cook wrote:
> As already done treewide, switch from open-coded multiplication to
> 2-factor allocation helper.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> index 98edaefa2b47..ee69c949bfbf 100644
> --- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> +++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> @@ -1723,8 +1723,8 @@ bool  mod_color_calculate_curve(enum dc_transfer_func_predefined trans,
>  		kvfree(rgb_regamma);
>  	} else if (trans == TRANSFER_FUNCTION_HLG ||
>  		trans == TRANSFER_FUNCTION_HLG12) {
> -		rgb_regamma = kvzalloc(sizeof(*rgb_regamma) *
> -				       (MAX_HW_POINTS + _EXTRA_POINTS),
> +		rgb_regamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
> +				       sizeof(*rgb_regamma),
>  				       GFP_KERNEL);
>  		if (!rgb_regamma)
>  			goto rgb_regamma_alloc_fail;
> @@ -1802,8 +1802,8 @@ bool  mod_color_calculate_degamma_curve(enum dc_transfer_func_predefined trans,
>  		kvfree(rgb_degamma);
>  	} else if (trans == TRANSFER_FUNCTION_HLG ||
>  		trans == TRANSFER_FUNCTION_HLG12) {
> -		rgb_degamma = kvzalloc(sizeof(*rgb_degamma) *
> -				       (MAX_HW_POINTS + _EXTRA_POINTS),
> +		rgb_degamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
> +				       sizeof(*rgb_degamma),
>  				       GFP_KERNEL);
>  		if (!rgb_degamma)
>  			goto rgb_degamma_alloc_fail;
> 
