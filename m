Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35263C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9DB21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kj+DGfzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9DB21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJIUdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:33:50 -0400
Received: from mail-sn1nam02on0088.outbound.protection.outlook.com ([104.47.36.88]:5120
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbeJIUdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Mt2Sq7NlvMeQivsWUzeUG4nAV0fo3Vts1vvXYQrHTQ=;
 b=kj+DGfzkX9maIcbCbSFooqL9zkbEMU7qIhQ10c82tbkbMvEN6Ru5favbSwMwAaVLl4sFed3/Z0RpbUsGDl9o7TVJbl/QYQs9Mh64O48tUo5YumVsWab3rHHrA4pmp941I1ps+mcjr92PsGUt5VCkvQzp67Kgwx+B6lZ6hmf+0xM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [172.29.160.53] (165.204.55.250) by
 BY2PR12MB0180.namprd12.prod.outlook.com (2a01:111:e400:585c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Tue, 9 Oct
 2018 13:16:47 +0000
Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
 smu7/8
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Zhu, Rex" <Rex.Zhu@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113125.488862921@linuxfoundation.org>
 <BN6PR12MB18092FFEF5BB3861912C8535F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20181008144917.GE32006@sasha-vm>
 <BN6PR12MB1809FA86B039B8EAE460BB49F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
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
Message-ID: <86281b7c-8940-5d1b-e164-187087519dc8@amd.com>
Date:   Tue, 9 Oct 2018 09:16:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BN6PR12MB1809FA86B039B8EAE460BB49F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YQBPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::22) To BY2PR12MB0180.namprd12.prod.outlook.com
 (2a01:111:e400:585c::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8e1860a-274d-49f8-c043-08d62de97820
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0180;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0180;3:Z/qZ4W8uadAQvkcqwuPE/X+j18buUskH1sA8QxBckEyw5nuNoVFEKNDhp9CU3YYmGDLj0qF87jDpMRogzzmwNfaG0J1XF8GA2/s6aHSYHyz9YNhfvhWV3sgw3Qw5wRMqMH12XDBG8z1Xo9K7MOQ1zIDcmu3yrwP1jnYVAZ+3nA98VNnyc3eZeK4v75Y2Ej15ElI+b85Ga7f0sh7UbEO+g4GicB6d/cSRECr0Z+qA63ymM8RVGysDWb2dNWNsrgyz;25:8R89Jn9/2P76vTHs1emc1Yd6HAz3bEO/J6U39i1raf3CMUEF8vSB2jE9vupwP1JjZWbUkD+VlzIyky1PAYMzVJxMbPuEwCl4rabjDvDJoKdz+jd6f738KwBPZtVwJSC31Zl37e/4XL8hF1O7xS0feAcRMcm7D0vx8ihkqa2NmFSC8KM6HYOS2uN56cKfrR2a7ny2V2V9SIRLnhRh/qM9fFmYCnR5g2racyvgvtKJFFvXcflFdXOtRrSu4xDLucgsAaO19VJfoMCdZEXhPMJYIHB7BhB66LVj5NoB9sH66H2oRmMvCxHT6hH2cL8gIxjCnrQo3nZJebo+iTLAEKMmVA==;31:lwwgXwZ32ts2NGCqN4KMdQpzeVG0tcqdijQxbAlM8VFy6Bby46urYV9o/Og+T3JO180pK72IVj6jMkNpUJ4wnZA3miv/+nermX9kbbtbhRZpVk5Hitx6d2pUxTBzX38Mw+H70iqHrg/redteI0NcDCaXY9U9jQFUHEt5BrGpMNYTbTMtfhKSAgZ7A0IH6TKdB0pJ6/iGpEAMi6vw60coI95wzD6R290MJwkg9pzgEP4=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0180:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0180;20:kzZZXqwyufQdheDi+g5JH6H1Wba0qIZyk1LXRXL5kPiy8CeRZbtT9/ENo98V7gn8OU1zut/JGY6wfQ31IQ8Wy7qrHLnuX7EA5D1dHKG/RCkC6kl8ziviKdqzgTAzIW19wrfn3cWHQ0YASi4P3OsjZ1W6pO9bzn84FbdN076XM+1RK61fFcL1sZYfb6wHsfGNWMwpbPEYzI9PVMqYgT3BgajHTrKHAOccLyt7gNBCCo+43IiVY+ZC9TFPqMKJQ7ihEMPvQkbm6NGZPnJ1sBD2IL5PYVRxPHBT4AfvShD0etAUcTWGoq1WQypM5eARaBHQhth9YkHKBd+MXhqk1QSRIddWaf1z9GwAoinkxirDmcPpPYnUWMb4BmLFV+zsYhBjcMGt3nSNoNAfpim2E4uQ+rKr7bwwkqpLRlEyhiEFK0TPvW/c0bOd0O8h87zTFQ978axCo11h0AbjXMpFQZ2e6R1JM2+ROogZ/t3Nc6SK8k5kxkl7VilGuATZ90djQWCJ;4:EXda5CPQNLIkQOOcUjFoudfgVkimAxxWnVqJEoaLyNYq04ZGFgLVU/YEJfE5xOOPhwJ0gZmbkgtkzUjfaL4DvGksRt/Co5t9UZamscvZ9fQzZe4pWM3jIRI3QeyLmBC4gtAiCGb2w/MuNqPI4zJIH5LWduRFDQu4mDW/BpCswTA6E8bt2Pe5e+Ei3rL1mRI4xV4yqaGFY96rN6Ge4U4gendLHyA3xEfDFRhS97bGGftgDki3zqy7GcvtFTjyFrdKJpqm+CxGJJARN6eB76LabwXCLkdTgPFs3D6IZvc+tGThom5roBN/o2z7q9WvpvZX9VMCJQNBgabdjRbnLLz7OQ4wu6L4NLkLc3V/npQ9vVrrGC9KMC76T+aWYCR9wcB8IN1dOiRF2linjsskxIAx4OfsSPbPVrP0HpKB7zuHglY=
X-Microsoft-Antispam-PRVS: <BY2PR12MB0180756816F5B260000ACA758CE70@BY2PR12MB0180.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(9452136761055)(28532068793085)(89211679590171);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:BY2PR12MB0180;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0180;
X-Forefront-PRVS: 08200063E9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(136003)(396003)(39860400002)(346002)(376002)(13464003)(199004)(189003)(23676004)(486006)(7736002)(305945005)(2906002)(58126008)(36756003)(110136005)(50466002)(956004)(2616005)(476003)(31686004)(97736004)(2870700001)(64126003)(44832011)(53546011)(386003)(25786009)(345774005)(93886005)(16576012)(19627235002)(316002)(4326008)(53936002)(6306002)(106356001)(6246003)(65826007)(45080400002)(5660300001)(478600001)(966005)(72206003)(6666003)(81156014)(81166006)(8936002)(8676002)(65956001)(65806001)(66066001)(76176011)(54906003)(68736007)(77096007)(47776003)(52116002)(2486003)(26005)(11346002)(105586002)(86362001)(6486002)(31696002)(186003)(229853002)(446003)(16526019)(6116002)(3846002)(52146003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0180;H:[172.29.160.53];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwMTgwOzIzOnVONXc1UzZrRlpmejJlcStScndGT1grRjQ5?=
 =?utf-8?B?bHdZN28xcUtCcnFVbDJZNWhmS1ZybFRnUEFzQWt2Z1RPSVNGY0Z0WUE3ZDJk?=
 =?utf-8?B?QUVpQUw3dUVCelRyUlFKa2l0L2hRVTBxY2RyaWF4UGNWMHY0VzgvOWl3Vzdk?=
 =?utf-8?B?enBhRVBtTlFKekNFMHNKM0dCZ0o4Y1UwczFqRGFHdTRCOXRQajArWk5naFlM?=
 =?utf-8?B?R084dXdHdFk1YklOL0oySDl2cWJlMVB2aXpsN2lyR2YxT0lnMlN3L1p5bE1R?=
 =?utf-8?B?bVFiNk5Jd29WMC84MVV3eTcwK2tLdUtObVFzQXBENXdEcWxIWm5qYW5jU1U2?=
 =?utf-8?B?emlSc1E4cmdaR2JtNjVVQzBxbFlxWmprUUNHazN6dTNueUxKWWJ2MEY0a1Vm?=
 =?utf-8?B?alp3TmFRRjZmR3oweFZYWVBYeUZ3VGNNaDE0bXZiY3lPYWN3QlNETE53cmxH?=
 =?utf-8?B?dnREcnJyR1hqQi9yaXBHMndIU1R2MkJiNStKV0xZcm5nbTBGbGVXTHA2TU1G?=
 =?utf-8?B?WVdubzlGaTRoMjc2WDdBaHdFTVdSelhhYUEzZ0YwSmtCUUJPSzRnUnVJS2Js?=
 =?utf-8?B?TFVlU0YwckZybm1KdDRVNEt4TURMYkpLd216bmR2TDAyWUJudW9mcUQzcVZw?=
 =?utf-8?B?eEFOdUwrcGlzOHRIVU5oT05kK3ZGWis4bjM1WkoxRnZTMFpoYlR1cmdxVGRk?=
 =?utf-8?B?WGNrQXB3cDFuUUtuRXpuY3hGL1J4VlVVNi81V1FoME5Ra0FqZ3M3bi9MeEU5?=
 =?utf-8?B?UDBYa1BRMlU3MVI2alkyR2tCK1FCZk1PMTNNWEExb25UN2hsLzc5a1BMNUhy?=
 =?utf-8?B?V3dORzFOdzV1c1V1Qk9ubmRsQWRnQ01zT29ITzVRK0ROWUg2TGxmOGJYR2kx?=
 =?utf-8?B?NWl2ZlExbWZ0Z2puMGhtWituZjRWMERMdzdSSjRBRzVTS2w2Q0h0ZHFyUDd0?=
 =?utf-8?B?OUtGc3pLUldFQ0xKTHpweUJVWXY3RWJ3R00wUXVGQ2RwY0JlSWo2NjFGc2Mx?=
 =?utf-8?B?QXBMdlZBUWlzS25uSW1TK09kbnNOR1dpb0JqV0NnRHZ3b21CVWNUcVI0V0Rj?=
 =?utf-8?B?Rkx3bjh5dCtldUsrczkyN1NsbUJ3Lyt1YURCQU03eVh4SDB5STgwVFpoMEcx?=
 =?utf-8?B?ZWFZZ3JTWGpkcmx4VWtLSjkyV2JuRG1xMEFXdlpaMzhrc3o5ZzA5MEhlTGEz?=
 =?utf-8?B?dFQwZ2psaHNlTVpCVVc2d1d6clRGcTNZZFl6NDE3ZjNUYUdCejFXUnIvWjFo?=
 =?utf-8?B?YmpGaGVTQzRNWFdHVFJUTGRYK1h1c2d4cWxRWUhnUHN5T2NTOGJQcVllcER6?=
 =?utf-8?B?RHJjN1pGdlpsYlpuUTBIbGh5Sk1GbndRL2dUcmQvYnJaelNmcGZOL3VFQjA1?=
 =?utf-8?B?UWJZSkhkRzZ5bmZTeWNWa2hPOUY2akZXZGdOTU5FcUZnZ094WkZtTG5zR3F5?=
 =?utf-8?B?eDJMdkJrRXZ2RFNwZ3VUNmFxNklUZFRVbmdnNE1FcUJucFRBUGhLeGxZaVhE?=
 =?utf-8?B?TUtJNXlZcDZQZ3BBMk5QQ0QvKzBmS0NxaVVhQWxUM1I1ZGxpWUVlZ3kxVFZP?=
 =?utf-8?B?K3J4ZmhmalVQQ2ZrWEJzQy9GTk9pdEwvcCtqOUR6ZEQvQTl0MlVhanhnMlZp?=
 =?utf-8?B?ZnFLY0xoblpCTmViMkx4ai9ZTFpQenJxRisrcGtVMWxtZkNNYnh3YnpHcXBN?=
 =?utf-8?B?azVBOEllUUlPU0V3YWdDMDZzcVplZWpTd0M5RWdXSFNZTWV5b0dpTEI5TVNi?=
 =?utf-8?B?TXpzd2hxUTlwSFdxbHluQndDRDBlSGdOeHkvWmE1RVZDL25UM1F3ZjE1MWJW?=
 =?utf-8?B?UzJka0ZEUEV0ZXU0czBpaHZzZ3dGNmlyZTRhV2dEQm5kVDE0ZGpmMW5aRXVZ?=
 =?utf-8?B?bmRxSjRNZzkvVGdRL09vT3p4Z042MVk5K0lrb3I5ZkZTNCtZWEJmMGRSako1?=
 =?utf-8?B?d00wV0IrQ3pUTmd2c0NXS0NjbGVxcFlmR25FSks1WlA2Vno3Q2ZBa2xjdmpz?=
 =?utf-8?B?UmJQWmtZRW9kejZxSlBOdU9GbVRSQXY4ME02MndCYzQwVFVmYTBMNE5EN2VW?=
 =?utf-8?B?TzVyVHlsNGZ1SWpVeTAyeGU3ekRaNWpUNzJaWUJzSFZOQ01qNUhNK3U0RTBu?=
 =?utf-8?B?VnZXVXZIeXNUZSsxVi9VQzJqUVBYRnlLUndCWEM3VGtaeHg1N1R0eTZCYnNt?=
 =?utf-8?Q?0LJJQB4OZk6BRB373WOZVSdhfOIhLNW6GFF8fWQeBw=3D?=
X-Microsoft-Antispam-Message-Info: tz94VKosqUGhl2ELkC5xtG4umtr7UgtFcnMijs2NFPW98wtiQ5fVBn5jIvuB9gEQQGhHdctBzQRkoevsANe6mpRCOgl859V2vQMU6RSnvW8QJmbJ06H9vk5Mdo7VOFtQOCqW+wOM2myiwAEmh4Bz+hxXjytMp2zgjsk0bHo2zkBElg0DxGnI5vPckL00cjrKWMOK90PluDKWnc6MJhyjZkmtYSNrAnEr2p77dG5sd4Tb4g2GWrsiaVLE07Ksx6Y/lMKL69Jsn+ytYVhN/w+qi5sd1HDcF4UzRX7CvLUCO6O8ZjAcPPnl7h3qDRpOm1+1dn3E1fd1Enlh/GL7E4FYlrGkMbNLEQG3FQArhk+XRho=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0180;6:uBp6MWh0GTZLB2FhbkPygzJ0mEjdlnIesyupEs9Tn3DdqpyrY4ADCO4PBoSyCcJayp8V0dJplJwyfYKzrx64R6+qCSWjS/TgtLCbGKhXd7T8XTxh73SP1U0lmW9A9g6/dFNl7Md6uxEEb59Ymm8qQAxiv2vcBX4vy00vZUcftyJRilY2wEXvM8cj4de5GdcZGHIi7wvwJ4U5Czu+cyoXKT3S44PP8s6IqxYBpSjClqFFYyGNzu/x5FkDsmWB6g0gE4VLoAAty2WFaRmppJaAS2AGarKz0USj+UQwyJ0aTsjGBout+SaNF3A5OulkhiQag6GtxIRSnYa1hBzRGGqkUCb4XHN3m/hlDFSil3jdSi7rXNGXGoZXodJP1ginQ2puyFwtj6/kWEPonLEJHrLqS3ZokSVH6bgYetMBe3asgBG75+39YZEAf/VzG2W86cUoonS+gN6Noy1+qfVK+5LGOQ==;5:s7TQRQ5cuApFQ4KTPZvKJPJVPyc3D0hpNAhDUnnGv9OZc/iEMuVWKR/GbYTdqllyX5+tFoxAaN8M0vUiON1N8R4sirnNH3A65VZ42VSOBj8XEkKjlNyejN9gUbFbKmY4BP+IOWFnZxUCt3Yi9Jcwga39P3UOtVu9GvJ4KLuQLQw=;7:ix5jXEpemQ1MLR8SdACV7I25tKeR5+UpnUDEl55zV4lDykriv0x3khTKweyYClN/iCMkXGdwozEy2shUXuNq2xB/kGoBqjUxYmpyTU51zCX924KNQR+gFqH6b9G15nqyWbjc8gqwLKD+r7GStyFxdNQwRYC614m4bjNmYkioNtGMYZYsMOOmoYOIk9weVh1Y9pBSlFn5XU5OXwDiWTNaomehNnrR/XuxpHne5CMxqzJvUYANhOzxP+QYMt498WHw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0180;20:sXLAPqQ90xc9Y2i9ebM8jX4ev/vXoHoB2q4unKLsdfgxJj/A3V45lbHRpkTPBxeDHZ5H1hJmDeEXJ82SginkJF0O8wsC39Fxt0Qa2VIPxsM9ML5pRdn5v09lDQ1q5cgOhvoI7gAUYcvJzFsyjCF/OmVVXdm5pqNZI19GeW+R883BUVkORds40/PMw5JNXV+9IqPzlrD70X4jlUKfjFOcnEUOjeT/PgByI5vjMwD8ki8WYxmNfakIdK+c+iH0bisd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2018 13:16:47.6171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e1860a-274d-49f8-c043-08d62de97820
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-08 12:17 PM, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: Sasha Levin <sashal@kernel.org>
>> Sent: Monday, October 8, 2018 10:49 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
>> kernel@vger.kernel.org; stable@vger.kernel.org; Wentland, Harry
>> <Harry.Wentland@amd.com>; Zhu, Rex <Rex.Zhu@amd.com>; Sasha Levin
>> <alexander.levin@microsoft.com>
>> Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC
>> for smu7/8
>>
>> On Mon, Oct 08, 2018 at 02:33:56PM +0000, Deucher, Alexander wrote:
>>>> -----Original Message-----
>>>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Sent: Monday, September 24, 2018 7:53 AM
>>>> To: linux-kernel@vger.kernel.org
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
>>>> stable@vger.kernel.org; Wentland, Harry <Harry.Wentland@amd.com>;
>>>> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Rex
>>>> <Rex.Zhu@amd.com>; Sasha Levin <alexander.levin@microsoft.com>
>>>> Subject: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC
>>>> for
>>>> smu7/8
>>>>
>>>> 4.18-stable review patch.  If anyone has any objections, please let me
>> know.
>>>>
>>>
>>> This regresses power usage on 4.18.  Please revert.
>>> https://bugzilla.kernel.org/show_bug.cgi?id=201275
>>
>> Hi Alex,
>>
>> Thank you for the report.
>>
>> I'm working on improving this process, I'd be very grateful if you could
>> answer a few questions about this:
>>
>> 1. Is the same breakage seen upstream? (if so, it should be reverted there as
>> well and we can grab the revert into -stable).
> 
> No regression in 4.19 or -next.
> 
>> 2. Does the issue reported by this patch ("pipes seem to hang with a 4k DP
>> and 1080p HDMI display") exist in the 4.18 stable tree?
> 
> I don't think so, but I'm not 100% sure.  Harry, Rex do you know if this is a general issue or was it just fall out from the changes to the interface?
> 

It was intended to deal with fallout to smu7/8 caused by the change to move the kHz-to-10kHz-conversion from display to powerplay. I believe that conversion initially overlooked these blocks. Rex, please correct me if I'm wrong. You probably know more about this than I do.

So yes, I agree, it was never intended to be used without the change to drop the *10 in display code, which was done with this change:

commit 23ec3d1479fd79658cd52c47618d8ddd2f32550b
Author: Rex Zhu <Rex.Zhu@amd.com>
Date:   Mon Jun 18 18:15:15 2018 +0800

    drm/amd/pp: Convert clock unit to KHz as defined
    
    Convert clock unit 10KHz to KHz as the data sturct defined.
    e.g.
    struct pp_clock_with_latency {
            uint32_t clocks_in_khz;
            uint32_t latency_in_us;
    };
    Meanwhile revert the same conversion in display side.
    
    Acked-by: Alex Deucher <alexander.deucher@amd.com>
    Acked-by: Harry Wentland <harry.wentland@amd.com>
    Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I don't see this change in the 4.18.y stable tree. I probably should've caught that with the initial 4.18-stable review patch.

Harry

>> 3. If not, could you briefly explain why?
> 
> We refactored the interface between the power and display components and this patch fixed up some of that fallout due to the differences in units used in each component.
> 
>>
>>
>> The algorithm I use was very confident about this patch being stable material,
>> and when I looked at it back then (and again now) I was very confident of the
>> same. If I can understand where I was wrong I could improve my process.
> 
> There are some other dependent patches required that were not flagged in the patch itself.  IIRC, they were a bit big for stable.
> 
> Alex
> 
