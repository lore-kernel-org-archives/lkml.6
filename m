Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4502083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bBwmh63U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4502083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeJBVjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:39:17 -0400
Received: from mail-eopbgr710083.outbound.protection.outlook.com ([40.107.71.83]:37408
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbeJBVjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOyOy255Z1RylO0ojpUoqZVookHUIj3nBHyaXKkYg38=;
 b=bBwmh63Ujo0BNUqm7fxoJR1uu9qpgUFRPKYrHUB8emkd3fnp31GrpLWOos+BPz5421fZt3wu4xan88Xp+/3kdKI8OacVYwLWfoYd0YYI30GoBLBgLVFvVbrI1ApdqpneDFbdNvGM/3UwUJcber7jNomFiXjXfFgR5II1IrCzDeQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [172.29.160.53] (165.204.55.250) by
 SN1PR12MB0192.namprd12.prod.outlook.com (2a01:111:e400:5144::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Tue, 2 Oct
 2018 14:55:24 +0000
Subject: Re: [PATCH v2] drm/amd/display: Use proper enums in
 process_channel_reply
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20180921215505.14634-1-natechancellor@gmail.com>
 <20180927180632.11520-1-natechancellor@gmail.com>
 <20180927180816.GA12545@flashbox>
 <CAKwvOdk1AM9K=GQtFb2dWOor8Py5O-t7Q6g-rYbygJtF_DpjbA@mail.gmail.com>
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
Message-ID: <1188b75c-9e4f-1c0b-f014-cfd958640caf@amd.com>
Date:   Tue, 2 Oct 2018 10:55:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdk1AM9K=GQtFb2dWOor8Py5O-t7Q6g-rYbygJtF_DpjbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YQXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::28) To SN1PR12MB0192.namprd12.prod.outlook.com
 (2a01:111:e400:5144::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd27c11-ee55-43e7-0bc0-08d6287715c4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0192;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;3:EhIJQBPbX5YEVNrm8MRy5Zl0imeqle9hfCDkwjJbnZ6kYe4j4l4yAg1XT6a2bzt/rVD0pllQ41l637C98RCnGgnTsisxjw82fP0BDaTeaARy41Sxb0RSwwqcp9dmqYoESZ//+1lbZAG8c0FHkiqLT0Q+vctdUvhHtsid+6l95P3t7a8WE9RKMVxq0qL7eQWa5FBE1jna8bncjdbvB3jyrXGGawL9GlBnn5/3LbSobgJLiaMCEDSNoHrZ6Lxv4IsS;25:c+nGJ8dSHCu9Gr9y6X21ni5JVLfBgrvpyOe5dZrixKa6Kh4Q/zApP+3/oO1ivrg3QvapbzIvl3eVTLVYhKQ8LOj7dFPNrapCAAFtvP3ujJvXZJ2fzJpj7D1nY/nzB9MdB4zRZl3nmmCgkaEPDLLpuJGhyunktWyQq5AdXq3FvaokH57EXU/EMfHr77wNZXGMSh139UZ6gsTESqW7B5LaGblXfWmBsGanPy23DRcIyT5TWewImE4czGreSElRPv8djN4AuTI5G08F60rtN9xmCjKMIEVh3mh8TEkIBvsz3HEDi9QudJgJNK335iLSEa2VFhQm+6jibozHHhhukNdf8Q==;31:Lq71ST/VuejzJqo9gJGL5RBuSc/WyKvqWzQIdC5UjFPV8dqWHOoX7IlZKuI14g9rQVN1w4Ms8JXw8gV2fN4ksxGexN2iFSo/BNsb0ckVArJh+hxqEFUkMiVEv4zkmpwht8a3O+ZNyIBco5Ubrh0TBFq759XwQM5A1MW5i8FVRRZp8yMeerJut4AXUGUgVpfqJSDHGfrQVJ3kSTTy5+VH1beR5FHM2j57ArEmKA2l5k8=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0192:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;20:WNfJejLWXPKjFZ9AvZKDYsdA8sjAghXnVfdpY6XCKhumrW4bJp1GG408lsGyiAiEsYjt3gCC9QHx8AxzWKgBupQ6GXXIrri6DybBbMoC1IWUr3rBpe22LQ96q95rUH2pWmQFgCxrx5TOsIOX0W1FR1/I9iKBoqiTKSTUmEt2o8Z4CtgrrSuPVm7XYQqF/19A6oPPnjFjTcNq9095Qc+tPV/hs6lfOXXhNHPyYxeCQpCu68bs3oM3qg77q/I9KPhtUPPeAGQEtqtRSdv3VOschoBihNVi+cqVv4ihNuAVLu/e7sesQcNtZSzQOumMT0RWMu7QrLHn/8TWu3MpsCqXtvkvB0flzrdRGnGbODzW/B3sRm7Z5uAtGeQ8nFlLgl0rRx8UF8F/DcYEJLho9IMHAEF4RCG22b2NHXpI0ieKTWHku1XCfG4591bAHvJcx2pH1T/Gk7V734Zq4rJ7FmqG9qX22iPGYEjw9vH7lB4x+b2oYhHvNiTFzo0z6zj5Ar+b;4:2Ifksmzy1aRDLDenJMyCkR8mMCNEUSlXvmhGOOoRFHzFkMGqwfqRlX+AstTBbPYsgFKag/NMaEv18LPDkCf2c//7UFyqfEDyZkyVe9CFV7BCkxLlv9S/WfxyffXDw1n7GqM3JQt3M0AJagLlf04Dh+fCsXLGjT1cWEyeMAne1xJLtj5Fqa1ev+V+Otm1fjbuuR/Se+CBLv4cqO7/E80DaMRTGGjnnMc95s0A3FzNDTCSX7eyeMDM5oC5rk/TO7ywHyFa1IS4xbO2GTUVaImnXdDxbSUH/cnkdHiTqV/vguxuuWvevLqfzBzLfVJfN1Zdwf9bnoxmA/vnt2P330ZWy7iDAuAOuxUd/kvKfExiXbuHT1W296BtWvGTybYuR8ooBvPvlRAvHNtn1xbZiYJAJKUBc3M0gg+7uTCG0me/VUY=
X-Microsoft-Antispam-PRVS: <SN1PR12MB01923CD4CE452103778E64358CE80@SN1PR12MB0192.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:SN1PR12MB0192;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0192;
X-Forefront-PRVS: 0813C68E65
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(39860400002)(376002)(136003)(366004)(51914003)(189003)(199004)(478600001)(97736004)(16576012)(31696002)(110136005)(446003)(386003)(39060400002)(316002)(68736007)(7736002)(31686004)(575784001)(86362001)(77096007)(26005)(551934003)(81166006)(6116002)(53936002)(58126008)(76176011)(16526019)(186003)(3846002)(93886005)(229853002)(14444005)(81156014)(52146003)(65806001)(5660300001)(65956001)(47776003)(8676002)(64126003)(53546011)(106356001)(2906002)(230700001)(52116002)(105586002)(66066001)(65826007)(4326008)(8936002)(11346002)(6246003)(305945005)(25786009)(486006)(956004)(476003)(72206003)(6666003)(2616005)(36756003)(23676004)(44832011)(50466002)(2486003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0192;H:[172.29.160.53];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTkyOzIzOjc3L2tNM1lLR09veDlEeWJtcHpvMWxudERY?=
 =?utf-8?B?QmRqeng0cXp1WHBkUnFMbzdQYVpSS1NOaWlLNDJUVjVBVEpCNDE2WURaNVEv?=
 =?utf-8?B?aWRJTnZ0WmtSMFF6TW0xYnZIaVBUSlVEdFE2MDZnUHRCODZkc3JUcithYm03?=
 =?utf-8?B?T0tjR3J2ZkhzVEpCMllXblN6dkE0TDM3NS9VTVZkYmxwOGM4VmZueldndzd2?=
 =?utf-8?B?NDJaUFBSQWVwUEZDUGV0TWw3TlhNT0hWbGdvdGZxVEh0ZnNQQ2hRNkJnVUVH?=
 =?utf-8?B?dmVGdWVaY1ZRcFd3RUtLb3NLd25pT0FPR0FTSVFHV0hGZWRIajJaVUpkNGRx?=
 =?utf-8?B?dlkvWElHcnJsMFVqZlQ3a29DYUUzNGF5MVJucWgyN09VbGFUcU5TeUJIQUZO?=
 =?utf-8?B?blhtM0x0b2xTS3NNMFNYSHRxa25ESUxGR1ovdzk3T2VZeThUdDlteHdtdGtB?=
 =?utf-8?B?aDVNUm4rRm5EcVBXYWtObVhwRmNmaE1wNjhxdW1LS01nUnRiSElNd0piYjc0?=
 =?utf-8?B?elNTMkNacmh3cm51dkRySHBqM2lxT0c1bFdXajczWFNVRUx6U1JvQVpaaFdD?=
 =?utf-8?B?U3ZJUmFFYzdISGhCMGdpazd0UWR1cloweEFBUlZxVUYrZ1c2cFFCSnpyT0Rw?=
 =?utf-8?B?d1dmR3dHOWlleWREcXd2N2tXblFVbzh5Q2tuMHlCZ3QwQnJ2TEdIQU9sY2xn?=
 =?utf-8?B?dkJ1ZnhBd0dpR1B0Z2tUc1lGaVFMSldCUnVFVkVoSWZYTjAySFFKSHJCWnhi?=
 =?utf-8?B?dm9ud0RHN3RPSVd6Ri9ta2JteU5MenVMVzNwT2VEZ0EzbDN2TVJCdVpFbWpQ?=
 =?utf-8?B?Q1k3SW5KcUcyakVDN2loRW51Tk1GK0d3VTJ5UmNXcllBaUFXQW1YdGVDQnZn?=
 =?utf-8?B?OFNXY2NzMVVhV01idjVhSkpVNi9La1E3N2dCL1UzVVVtcHZGRjFMdUtVdmtw?=
 =?utf-8?B?NUt0QXM1MXpEemxXTStDWTJwQmlPM3EwbzFObkdCZ1RNN09OSTVyRG84cWY2?=
 =?utf-8?B?Ykg5aUJkbGVLbW16bUpST3d5eVJhbnFtMnZTdzA1VzFtaEZZaWZWVmVYYkdL?=
 =?utf-8?B?cTBSaUJjRDUwcGUwVGN2cG5mVFB2MExiSk1NVkdiRFBtSFlsTElWZmJSdmIz?=
 =?utf-8?B?UVE2bUU1RzU5WFpZWVZEMVBVQmhRRzEzQzFvYzlydHRaalQrWDdTazRPMWdt?=
 =?utf-8?B?MDFtYmNNV1IxdVhIQ0hQUGpyVmc0ZjVXQTA3c292ZkZKR213bEVVVVNGZlN3?=
 =?utf-8?B?WmdKNUdjYVZCU3p3RHlEQmdXbThFbjdxWis5eW5JM2c1dUUwUGVaVXFZdEdY?=
 =?utf-8?B?QXN2cXFHU2VRR2ZleE54WFc0S1k1MHVzZ3kwdjZ5RjhzbGlPQ0lWQkJ6dWho?=
 =?utf-8?B?ZlNsdGF2V0ZXVjgxc24vN3QzNkpNUlpZdFJ2dHFwSU5XMEQ3c1B1eml2RUYx?=
 =?utf-8?B?MUl5alY5QWVjazRDblhJVVg2UEVuNXZNN0VjV3lRbnk5d0cvSmpiclNQOUp1?=
 =?utf-8?B?VDRTRFdkS2JQZlBmSUVlNStOd1drU0hYY0VKdDJWckxIWm8rMVZMNWk3eTF5?=
 =?utf-8?B?anJpbUpYQW5oL3VjWEs1S1cyQ0tTMjEvQnZmdDJqUEkrSmJPOGozQ0l2V2lz?=
 =?utf-8?B?WFFGRmRHbmlLOG44aGdkUGVsbXRaZW10Vy8vanlMejREK1NyMG1yTTFvNHlu?=
 =?utf-8?B?WWhXeDVZODk3aE9KTGRDWU5vUytpTHZFVmV3Qlk5TDVlcUw5OTdaZ2NlZzlW?=
 =?utf-8?B?NTZLZmViZmNSMU5ZMzJnQ09pK0poZm0zUGhzdTc3K0JSV1NwaklOY3crNUx5?=
 =?utf-8?B?REJod3Uyd294bW9QeDV2R1Q3NTRMcTVuQW1vL0F3SkM4bmE0RVFuemx1a2E2?=
 =?utf-8?B?U1VKTTErNTczYjN1VG1ONXc5UU9LL3BMTHIvQVF3d3dRbHcvelZ5cTY0UG1r?=
 =?utf-8?B?ZE9IajZvb29oTS9KSi9lTUR2Qm9idEhsK014aGxoaUFKTGNPK0ExU3lsSWF0?=
 =?utf-8?B?YWZiek5DWnBjd1NMamk2U3pVSG1Za3kwQWlrSlpWUDI4TWwyZGhQZ1o3aUo0?=
 =?utf-8?B?RFhNdDhmaXd4T2pGMEY3QnUwK2lseEpGTU40TUUyejcrR1hFV1NKcm0wOXB4?=
 =?utf-8?Q?Q6Xr9I16+1ttH/SwUS/YOf28BTTLIwHCCHkyrcLKH7Uf?=
X-Microsoft-Antispam-Message-Info: pytWNfaec3p8ni9/GoCfZz40DMjTWyOVAHemGlIY0oW6z6c3v3Tu+vp0B8NFJVlzMDTSCs3iODUW5hGfvFv+42OP58XUGoQ2F53gcILiZ3TNO1QU0IoQ4l4u29V9l1g6qC/rYsewR1x7kBlDP5McT6wwwq709pnE0HJg1xD/GY8XYpL8laqWJOt0o7cXtacC5bSer07OMPnqRWn/32lHulpRwyw3S0BCMZBDt+OPcrhj4DBfhSr0fGjaX3r2Q8lRHA/rKM915hKK8HciEezDlUP+6bEjvaYe9vLKTad5nOwChXFwFNouQ31zBRSCUM5Zuj1FJHeRDNf2hbIQJX8j7EwQ0vM7Q3fLNoN0GYZClHI=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;6:0+9dkoMvxVfzw1h5JIc9CwFSO4XpioBrca1xluWWThF+Y1OUbiFSbtDYmPgsbYquINrye4r7ynXOOnFEZqwLc9Yy21ifRPqe8znzUoFAehpYLKzYjIRUX9Ai8wr+/jdgw9rrUXv0iKLRMrhKTrKsUZBtvb/g07vqC+WgXniRCGwHkUCr9q85Fu2vcnnHcYu9CA8pg6Oe1ViY3xlZ7VwbEoGucsQ+0EdBqOMSm3kjJAK08HdyE0kTn5SrF6OS+CRKMPI0kVErHC8TEA6O6upJIUtQJBTZ8Thm91ha7+17CEjNzf+25Y3mDoLk2JfjpShapFhl40C0AA5SpsVshH2Sbm9zq4kVrzE78dn4ANzHDz0ICdOWAIJSVYF4ys2BGDoHEWLlRFjmKcrCqAGHYtYxeIwGHbsWgIWEnAOGJRTihzykR0GbjkBBmuraNcPmtN0DoxjmQIck0aRB74zlVGwbnQ==;5:JAulTMXr7j1L4B/uFAqo5LQrQgcC+lerpjkiGhiaI/ZtP1W+JQjUGwV5Obl67bn0i61lq94di6C45YH0SlSDhT/HZSDEEixM+8jidpslmiS5bZ6u5IeqGCvxQff4sehkSpF1ZbzgNT6fPyeXTvVOJJxanq+hmbtlv1CHtoZA9FM=;7:WHZZgwWlJ/U5OecSfc7wDL/mgxLdpD8A+TmGEWDneCX+hrvH1mejeeXIXzzTww15qn2F8aNP+G6Za2GXWsWooXWr3TtP3OKQovZ5yNQtKg1TV0cB5B+5FROfqfoG32u+4Zaz6y6Bsc2TnZevWIz/bJMH5PMr+BxtoKBzmJZDdjqzdgTLS16vSf1izaWHJTWPf3165Y4YalmsUbfifpEvDZLTn6Gzb8dg9bwIj4kzp+5ypVoGSZ9RFoImSijg/mHV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0192;20:he5Ru1r5y0wWIK6xYdk0fm/MX/wHjycon859UTbGuwiCcowrytYM76U8IiGT1+HiqX7EvyEnDOURPmHM9z1O46jKEYVK+b1mfvJj2fUpqvhhcOk97eXYnppVgGEDVhielPx7uJbdSFa4yiQ5DvNyDUn439AJuV/0sp4PTCTD4If+EqTzueYSVWmttHwcSASROoAqSvok2KZocULSkG1Jp6mMIusFsozmkhqMKluZRPJ1gvA1geHDACxjg5JzR+1a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2018 14:55:24.0354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd27c11-ee55-43e7-0bc0-08d6287715c4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-27 02:11 PM, Nick Desaulniers wrote:
> On Thu, Sep 27, 2018 at 11:08 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
>>
>> On Thu, Sep 27, 2018 at 11:06:33AM -0700, Nathan Chancellor wrote:
>>> Clang warns when one enumerated type is implicitly converted to another.
>>>
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:315:19: warning:
>>> implicit conversion from enumeration type 'enum
>>> aux_channel_operation_result' to different enumeration type 'enum
>>> aux_transaction_reply' [-Wenum-conversion]
>>>                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
>>>                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce110.c:349:19:
>>> warning: implicit conversion from enumeration type 'enum
>>> aux_channel_operation_result' to different enumeration type 'enum
>>> aux_transaction_reply' [-Wenum-conversion]
>>>                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
>>>                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> The current enum is incorrect, it should be from aux_transaction_reply,
>>> so use AUX_TRANSACTION_REPLY_HPD_DISCON.
>>>
>>> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
>>> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
>>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Pulling it in through amd-staging-drm-next.

> 
>>> ---
>>>
>>> v1 -> v2:
>>>
>>> * Rather than change status to an integer, use the proper enumerated
>>>   type from aux_transaction reply as suggested by Nick and confirmed
>>>   by Henry.
>>
>> Sigh Harry, sorry...
> 

No worries. You're not the first to get that wrong. :)

Harry

> Thanks for the patch, Nathan.  Don't worry about sending a v3 over
> this; its below the commit line so this detail wont get committed.
> 
>>
>>>
>>>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c                    | 2 +-
>>>  .../gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c    | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>> index 3f5b2e6f7553..aaeb7faac0c4 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>> @@ -312,7 +312,7 @@ static void process_channel_reply(
>>>
>>>       /* in case HPD is LOW, exit AUX transaction */
>>>       if ((sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK)) {
>>> -             reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
>>> +             reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
>>>               return;
>>>       }
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
>>> index 8eee8ace1259..59c3ed43d609 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
>>> @@ -346,7 +346,7 @@ static void process_channel_reply(
>>>
>>>       /* in case HPD is LOW, exit AUX transaction */
>>>       if ((sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK)) {
>>> -             reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
>>> +             reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
>>>               return;
>>>       }
>>>
>>> --
>>> 2.19.0
>>>
> 
> 
> 
