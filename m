Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E2EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5CE20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5ctaDvml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5CE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbeGaPoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:44:16 -0400
Received: from mail-eopbgr730069.outbound.protection.outlook.com ([40.107.73.69]:41951
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728035AbeGaPoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUd+RXTdS3YPV0pwrCQZT3ANc6Q74Nj30YPr6LKR1DM=;
 b=5ctaDvmlrhCe1zDVpfHRHltTaBmHKrWf9Yq8ypNu0UIBxgWyWlna9vGcRbYIiT1RdOrfmkcU6+1IYWZ0ZbzKpDpW91LtLtGkbpeGXxfo4+sjIpwpxZ14VfhUadW2e5P85cpaKeXWBSnK9whKPzAXbiM2bZ+gF0Che84ZFoVzSk4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [172.29.160.53] (165.204.55.250) by
 SN1PR12MB0192.namprd12.prod.outlook.com (2a01:111:e400:5144::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Tue, 31 Jul
 2018 14:03:37 +0000
Subject: Re: [PATCH] drm/amd/display: add missing void parameter to
 dc_create_transfer_func
To:     Colin King <colin.king@canonical.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180731104254.14683-1-colin.king@canonical.com>
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
Message-ID: <39ae8791-f3fb-ecc8-7409-3bb6b134e4a4@amd.com>
Date:   Tue, 31 Jul 2018 10:03:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731104254.14683-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YQBPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::38) To SN1PR12MB0192.namprd12.prod.outlook.com
 (2a01:111:e400:5144::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b4ac27-63e4-48c2-dbcc-08d5f6ee69e2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0192;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;3:TQmAaTs4TEYuTwwrsOfbLfCV6gmyDsS8wclIuxta+yJetofZmry39zFEgQHGPgj5aAl+mCWdLAd8/TI9Gx+19acfs0TlijhRr5+wa4qc+uH/Pzm6NfO+WCp7vphp04RsEkIjlqCIZwEOv2RuhwCjzSw0onsGF9AFQa/xfxIlJAMIJ3Mli67Wf8gtVEIuSbHodkFkkpzC5OGNC/shwpaEt8InVbxhrxD67c+MAqBWgAWBzelAddjCZnHdk5o+CHGn;25:I68LixQvJM4JBm+3mlLAzQ6y+0AyTddDrPIPkXiFfu4soGQvt3c/TwsXWEQHw6TgYsVitkCt4b/uljNtr4zJyPHKnvov+P1JQzh79UamAd5eV8OBmpBKQQY0BUWLjsZOYnggSMBTQxUu6+tkjlOJUInC8/uFXNuAJDrghHofcvNK2LYmBd5FVDpXoPnwsqSnOYmauCVTOnu48f8yTzfpA5unjpR/iAuK3dCO30qqMwHY2+SbfN8sWo/W2va5LE6dKPvr4JSljfQTzsdmneh6Pan4T1+u4nr90n5cDpMo27DWP+7pWC/36o9365nTyrJ9B3zn5KXbNmHXOrzlwra39Q==;31:LCoNcxslIpgWahCOQzIS5bnpDhK5tN9fdE1kV8XhJzF6/CYm7jWgC1EDBjtK34LbKvGSjpwBqt390JV3jnuMJ6ApijjDKJxkjBxizgWx3UOBWrFCF91RTA8Lh3WQmYh/+a07nKkz3UDygXCDMcaKtIfP6hZuzsrK8fnRHYBv3xY7W2+zf+I9Xylti6lKAv2xWVx0FvmwsBrBLCxe25kI6mCwO1W6XmW1zgfkMOplyQ0=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0192:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;20:kPapdZpOeAg2FUanHq5nJShOaiiRwjJGxIkCqvvK51UYa9RnXzfAaw1yJynP9hjJHDAqOKAoNXK9EbeyV1SgJ/p8jP4Ol8O2m1JhSVR9Qx4tp9iZ096zPA51gUlJmnzeOniEX7GOfcY01RxnfZ/b+FilAoRpP0Yf932KTkgNFq/H6uzIe6alcDsGEfER0GCod77gfUDFT2YeLtpySHaW6wBkXqFLQ864TU68YtmSvZIj5N7EEQH4PkIKjpjoW0zr4tk53m0cWo43UKMl2u1NZ6SsVgMfgTOdIFXvrzCYND9Y3WiSIRLp17xxNqwwM08p3G3et8lZvpeoRWJqveYHrNjsIxRNOz/hbOIpc9heB/4Vfkpox9FnQAECQIH07QXfzEjWbD1OEjXGY0wG51iq9Qd9MSD4EjTuCT2EfIRDlnStBTxOWkw6JUB4K6I7fQVA4Au3GiYlwsLvWO1fDvkg/Dv+rDvh+r/mnG7etgfYMbC9b9+536BFtEv8kRek5s8O;4:zraNpeEfzn2p7kINjiLlsptGIf4T0/2Rm//x2hzfgDek/av2AwrLHcLykKYfMHbgAPEq3nZuoQMAijabXy39PR1HVV1VHzGLohvtxx/bhD/3GlKA8laLtkigTsfM4IG2/kJ+7F9TzjP07PuvXwq9rhCLRLp7GUViI+9tTjxHeEbZQfGFEKojaXXhBoeE35EHZmaxXK3dLv/qATzlbhAfd31tuNexr8uTFJ1SmIevrsl+ks+8cXEe2iAAE12W0wBpkk1hdxPAn68sziX9/qkgfR2wUDBrYU2iU+2dWZrS7f/J7LbJ1hOP2AhBJfL2YNimuPq9ISqcuv7T6zk0cj9WeA==
X-Microsoft-Antispam-PRVS: <SN1PR12MB0192D2540C3F3ABA386756358C2E0@SN1PR12MB0192.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0192;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0192;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6049001)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(230700001)(14444005)(68736007)(2906002)(66066001)(8936002)(65826007)(47776003)(64126003)(65956001)(65806001)(6116002)(25786009)(105586002)(3846002)(106356001)(7736002)(31686004)(229853002)(305945005)(6666003)(6486002)(31696002)(86362001)(486006)(23676004)(2486003)(52146003)(16576012)(58126008)(2616005)(956004)(11346002)(476003)(446003)(52116002)(478600001)(53936002)(97736004)(72206003)(36756003)(110136005)(44832011)(6246003)(5660300001)(81156014)(8676002)(81166006)(4326008)(16526019)(50466002)(316002)(186003)(77096007)(26005)(386003)(53546011)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0192;H:[172.29.160.53];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTkyOzIzOnppcFVoWUtCY3o0REEweUxlUGE1L3FsVGwv?=
 =?utf-8?B?T2x1Z1BBYUk0d1ZFNnV5VzVXb200UFArRjhnR3REcEtwMXJ4eEk4aGxDK3BP?=
 =?utf-8?B?VEljUFp0REZ6TC81bDd5VnU4WENhTm9KbUNvdXkwQS8yNVg3Wk5Ic3FwSHc5?=
 =?utf-8?B?cDYraStXTnRQakF2aUcvdzVvUkxpdTJRdTJDdWJUU1RER3p2TklHUTdQS0Jp?=
 =?utf-8?B?Vm5acVMwUGp6UC9nRE1wVTRiRGJXNWc1SndUSS9SNDA1VmxNSkJQMjhueURQ?=
 =?utf-8?B?MG5NTDdEckxta3o4Ym9lVU1XNHo2NTBQL3BnQkl3NkVKWW9vWklOU3lmZStC?=
 =?utf-8?B?Z3dIM3kwNHF0Nm5qV1VwWnNFcVFWQ1JFbG1hQjFnMFd6THJiYVZ4eXB5ZzdX?=
 =?utf-8?B?dU5qb0xMb2czdHhpNlJoTHZXdTFhYmRTd2V0NXBYSlRvUkRSS3VxMDAyOFBx?=
 =?utf-8?B?REhTV0k2bjEweGJLZmNaRzdoZ0xrbVAwVlZ6SkVPYmNUYnd5TUtydnBaNFVw?=
 =?utf-8?B?RGVWV3NybVhJVVRNdVRld0Rqcmt4d3RmQUYwRXdXeXVyRVBJOTFIMjd5U1Qx?=
 =?utf-8?B?dHpCdkcrUERQWFJub0JYa1lwbmZvU3ZWYlUzbTZ2NWc0VVVUMnhEbGZxTFky?=
 =?utf-8?B?N2h4dVVpZGd3NFNPVWg3ZFprR3pGbjNWaWtQUW5FeWVZUmIyY1o0RDJCYjlh?=
 =?utf-8?B?em56bEl3Z0ZNRW9NRjhOV0pXVVQzRVk2U1kyeGFsU2lEWUVCT2VWNHVLS0Iz?=
 =?utf-8?B?VTBZd0hTdzE3QjkzNkQ3bWFjRnZTT0R2LzlHUmFXTE5ZODR0b3dDU1VPRXlM?=
 =?utf-8?B?L0RVbWVGbHhYUTZiaSsrUW80QVg2Qklxc2hBUXpobTR1a2JDM1JxZ0dTaFQr?=
 =?utf-8?B?eU8ycmJyV1l4eXdPY3FMTHhuMkhwTkFqVEpuWFdjMzJkSFA5TEg4d2NwK3Zu?=
 =?utf-8?B?NVE3UWFKV1BlZVF1SGl5VS9FcmwvMDAwUldtVEtmbHpweE9yaHlQRERjVHc0?=
 =?utf-8?B?blJvdG4zNzNTOUxtWmFFV0NPc0VYOGU5QXA2ZkdhR29sZVJTNlh4cWUrQXFY?=
 =?utf-8?B?OCt6Wkp3c3UxRDFhblJvR1hQanpKclIrNDIzZlorUVJOYll1VDVWaGJOS1RQ?=
 =?utf-8?B?cytSczlGenQxeTB1RHo0aExadUNIclhUaS9yTkVISHorRXl0bUZ4WlFKQXhr?=
 =?utf-8?B?MkcvOGxJVDFUOUdCdU5MbnovcnBGSEFrTVJ0TCtTYk9nblpLOVlta0RNK1Nv?=
 =?utf-8?B?SnhxamFPaWEzZVphc2hPOVI3cXVxUFRZUDNqR004YmN6bjMvV3lMQzhWYnRP?=
 =?utf-8?B?U05KMTd0eTFBUnYyTXV6dVFzdXZTY05jdGlOS0d4Y0VLZXJuZEM4NHA1VzFa?=
 =?utf-8?B?Y0Jhd3hPR0E0WHVScUpRWVBVZnVJUTRqY2RUUTdERityTUdudkZQZVdkZlpO?=
 =?utf-8?B?UitMaXIxRjlvZlA5WlpCclB6ZjlXUDJwSHRaVGJQUHZsc1VZQk90dWhVWW82?=
 =?utf-8?B?QXdXcGVwa0ZRODdEeXFHa2NWdnVyZUpiaG1PbEt1NkpudmtmcFBZTGpjRFU0?=
 =?utf-8?B?Tm5Sc3F5Y3Z0SjVZWFNndmR1WnAyK0JCVHA1U2lTTUV4OHhTM2s4U1N3d0Y3?=
 =?utf-8?B?V2Z2UVhQalBlcG5qSzNLZ1A1RkVSakVsUTBIRTV3U1BCRzRjSkdjVjRvSUtj?=
 =?utf-8?B?TzRMTDhENjRkZ2tJbEtVM2ZTeTdLSkVXSlVuRC8rWmJHNG9Pd0FOY0cycm9I?=
 =?utf-8?B?cXJwNTcvWk1hWk9nZ3dEb1EvWjJxSEo0eWkzVzljUE40Q2Q0ZEVEbGZoTm8w?=
 =?utf-8?B?MkFKVnFGbDY1SEx1TmorMC82cFBreC90SzAxQU1sc0ZmRForL0lKVU1YVDVv?=
 =?utf-8?B?SU9rTXNWbnpXQWZzV01FMk51cjhrRVNDeW9BUTFGbHdRa1pTeEVzdm9GSmRV?=
 =?utf-8?B?bUtPK1A4UUhmMkxkd0plNDA0VC9hV1JmYlFwbnQwNkZhUnR2ZDQrR1VTeFNH?=
 =?utf-8?B?VkgzYy9zNC9JOHBUZXRhYmtzT2Q3dy9ycUQyOTRxK3lxVmxaN3habkFjVDdo?=
 =?utf-8?B?R213bnhKMWJVeEtUaVJzS2pQTjBBZEM4Y0pwNjNtR2RoTUxOcDdJcGZvR28w?=
 =?utf-8?Q?uXLALbSadokc17N+NgFeF4U=3D?=
X-Microsoft-Antispam-Message-Info: gQ4BHMET/OXoehHoXcbOdKaQfZBrDuG3OtHYLb+POE4CoN+2m9GbDBRVhUuv1lOImBg9FauhOyi6wp6ZeFOnxXDmbTzudynztxU7s9JqKBUKiPuEmWn83zULR50vQbjSlnRCH40CQ0fVeRCcmvoApZc0oZ3NXdnAjcQcW4dvglKtT2RYafWlrFZWhGhau60mIWbQ5TpSZ3TnLY7rzHSXXax6B83pBDI1u4NVRXbqlG5wl2waEZgpH6vSGCwEMK4WmwM15dXNcn6R+kasgc1B9klKLztPPtokcOqEXceRJJDflPqeqfrs3M+M253LGRLXJDQh+AgpuzUXdyGRFRYmhEokVBQsKt8PgOQDylzRoic=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;6:H+3+diiUiPCLiaDKzUKiWy69bk22KsOK6/003WpwAegxe3CNQGXxFHfRnYnX2zmxnMj8n7z+nfUA3rOxopSixGR0bFWtxARRZWIHBdSPsSoL+PXmnkezljm5+GW+LA/SX+Z0OmwwOvZHuKQCDEvu8iJFLdGTv8R8Mwcneafish+0L5/XyS3pIxA7U5xo3JMP3WM4XkXnJiK1nXp+qG5S2fcYFExU6Ocx5M8VteFDR+94fO0cFfxQbFd5K8mxR2MjE3Pn0/cw/NEU1RV1ZEXoA1uUDNF2szkqQ8FqvFuS1rlq+bQk5N+GysWpI7CbyLpoUgbfT3ziGoiTvnvN2NimVZZe4QsNTK7P6Y39sr1FYdPUlsAwElV08hPkq4D4LX1fbh6Sajk2FiVwrcjYmGX5foxT9/ItSQrdqYMZT71/cKqDLZhXU+tk1eKH5FHOqe0GbeGdghERUXfAzRgbQFKX+A==;5:q2hdTtFRKhQXk0yFjxEv98ZxA/E+TNOLn+AWhHrasAZ/n4L9GIA3Uon7AhiW/cYzvfjJpeK7+52Ekf/4OuaGKzUQMQPUlHbZPIuxwesX6d681lenlymUyt7jfq/xcv/oaqZPjT6Wxxp/sQLcdm7WWzVi1lJW0oQvQ0IJpxRyoZw=;7:G8BistMOQtsheIqsQZM65mIEXW6Ow8sZ/Raryw9fiEIQU2pjVJMi/cuoMk4bK64G/IMphJ6zjjZaO1HORMWUF3bxz34HxRLoa8VBNdC3vG6Luv67tvFk3FW8wArPHlldU2N1Ay7gJPSWCE6FnWXo6W+9QyA7Gw7HNLutzaUFqEsai4Tw3RfdsNg6xos5zMT2+a7hjb6eVvqKdT7KiFq+bzHFseMoqAevuHiZ55nqkWuVjSvWgxmdtUkL66OC5P23
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;20:/9JT+nlj8osEW825qioX+AQErXuCURmKz77pvTYh39bW7oXST+XvlCSH37YoXacLCyc4FCKl+vE69iLyM3Cd2Bf4bGw3Q6iv4dQhtXg5UJA3tgUGUiWBCGCBmym5by0s3LoG0yTFs2ls+wir12h9zewAxhCCk9SSdSzR9ZVfg7/6XQgFxKMrMQMXcCpYt+/oFWL4RXymU6NvgyZquKmBuQEZMV/eaDxLgf2TROGhTMxXWzUSJ8J4m+ifmGUpWt61
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 14:03:37.1999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b4ac27-63e4-48c2-dbcc-08d5f6ee69e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 06:42 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Add a missing void parameter to function dc_create_transfer_func, fixes
> sparse warning:
> 
> warning: non-ANSI function declaration of function 'dc_create_transfer_func'
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> index 815dfb50089b..8fb3aefd195c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -192,7 +192,7 @@ void dc_transfer_func_release(struct dc_transfer_func *tf)
>  	kref_put(&tf->refcount, dc_transfer_func_free);
>  }
>  
> -struct dc_transfer_func *dc_create_transfer_func()
> +struct dc_transfer_func *dc_create_transfer_func(void)
>  {
>  	struct dc_transfer_func *tf = kvzalloc(sizeof(*tf), GFP_KERNEL);
>  
> 
