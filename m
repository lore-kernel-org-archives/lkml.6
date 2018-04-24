Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933499AbeDXOWI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:22:08 -0400
Received: from mail-bn3nam01on0069.outbound.protection.outlook.com ([104.47.33.69]:61639
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933417AbeDXOWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:22:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH] drm/admgpu: fix mode_valid's return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@amd.com>,
        Dave Airlie <airlied@redhat.com>, Samuel Li <Samuel.Li@amd.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Keith Packard <keithp@keithp.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, Monk Liu <Monk.Liu@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Rosin <peda@axentia.se>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, Shirish S <shirish.s@amd.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20180424131438.1751-1-luc.vanoostenryck@gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
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
Message-ID: <2c8949f5-0721-0a87-bfda-c483ebda9856@amd.com>
Date: Tue, 24 Apr 2018 10:21:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424131438.1751-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To DM2PR12MB0188.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0188;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0188;3:bLGJ/PWbBEM2xQTqwKlNFscAeC3BIvgj/jWMoUzeauULMDuSB5xOqXC8gmda/krzwSsumuyPpNXfHSTqMZzOHp6VWwx/249U4e5H7CIAUcjvMFKfwodOR1WW9M6v9rO9ypJguWm87JsofjQKhx5j+OIpRBeVSSyCbIQLqozumHWHMHPGlasDFBXepw8MkNIwF50FYX1/2H3sgTbjEMSw0p7q2J3VZimX9zl1I5upC+Jy272xDxIi7M0l94BYCR2C;25:N96MoxQCyWZT8+hYFjPv0mlv5X5pEkYCAOO6QEocRT6rk6pf+Z8eu2Lfig09hXuXfOrfhdCXPfX+UnfNbI08ihEK5xMoXCmWJq3GT+WdkMUFqms6h/tBaYTZvTD/ICceITfVNdMPE6rbSCf8K9GJzTuJWFNn89yehlUKpCCxxMTSz6B9/u6o+/jYNDiHnj0k1Rs5B/Pw5xVwK7sNi21ZO4b3uV9uXUD6i8UMqHWU4gAoQI26NdYRM3+LdEkJgthnAaX0upSvFKuSzfst20LjuybYRpg6O8BhrsyLdFyq6P7AoTdt4yzlGxs6o5bCFNoe5E/U1V1PYqTNcubfa/ZbLw==;31:U7R+SOsQQg017E4Ryo5EDdahL0txVD9hKGeXfo+xm4JQY4hWo6+7Pz30nbSD1wMMAcb9d4qntR2pV+yfyjXwwl6EZN1Xftmpo6nGBLOGrVUODZN73bctEHKSV/FbDEsInq1CLZO1Y53QBft+buZFhuQCs6ViJMtd6KoWWluUI+Re9tEinw2DQFTe2gjdRRkHdOHzi8lK+/lt0TsvpLKwqi4Dd+tbpepUDxXWeEVPfXI=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0188:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0188;20:uwkZ7Rf/FlWuYaGhW3udovhD3WqkNeLyYRrqdniUmV4IZ1uLOiNPuhV8jcp1S5lFKqTBOkCRv6Kb6QqQ4Vn3GEDV/ScaiS006GClaTDSGu7L12QpQGgb5MRZS55HmTeQV4vKKsTuBUCKSrhhtmXXCpdFwNMRqeJAjTipKGcJMx+0YPMdYuLdko8rI4RCT7CU6R8xG1rB60vyNcJBJ4cxT4IPdr9qSdt6BQm1jeDVo14EqwvkaDVJ/k5EoioFdhpW4CsZSnhNemyReDZgbk0dtJLaPJO+SIhC57AHiGFCKjIb+PkVJGwVWZjyP8+C7vyjRItk6NBWVptzaQKn+FAWWRhZ39QpB8Nmgiv2xWHK9pwrIVTvhdTfhlIZyV/cGa/OQPTYnkB/c9PVyw3kVLbnIUlMRRajZFsLXhMSHiKqlHqPvS7mev2TxizGC1wAAxWjpr9/Y/6/lgwuRDg6/20gAicBHYx2D3Q68ZUD1Ncr/gLZ9PXFpPVoQR5kqYdt6aHV;4:UKY0aII4JyV4eyAwQD05ZZuR8TP5XcJyhu5u6YCJMWcwqX202KxhU5V7JD7eP7zF6DdEkH2HC+NKAlGPXPaGw5S6mgZc4WQphDyS8SlTlHgn9pgN2u+IOlUApBkCg+tFK19KLVIndTTAG4Pz1xRMs6kWfZR9VTFofRbF1Aub1mRNfNMPTxesbA3DResWL0TGVN8pOWKAH3iBfZemXfIWM7A0B7wS1utBHHxW/dXLkQwNfXUq3diEzoRW6jyzGLg4PQG3Q0ps3rStI6UoglPKQjg+ohLvyNs32TDUfDmewaHuTVilnk7EBgY75UhUjBe+09SuBjLMZZbbhB1+lr3lSg==
X-Microsoft-Antispam-PRVS: <DM2PR12MB0188B940A42EC4D3D48131378C880@DM2PR12MB0188.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM2PR12MB0188;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0188;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(346002)(396003)(39380400002)(376002)(377424004)(189003)(199004)(68736007)(575784001)(6666003)(65956001)(53936002)(956004)(6246003)(59450400001)(54906003)(106356001)(2906002)(11346002)(47776003)(53546011)(4326008)(6486002)(446003)(77096007)(16526019)(2616005)(486006)(186003)(39060400002)(36756003)(23676004)(52116002)(7736002)(386003)(31696002)(97736004)(8676002)(65826007)(26005)(478600001)(5660300001)(7416002)(316002)(81166006)(476003)(44832011)(8936002)(25786009)(72206003)(2486003)(76176011)(31686004)(58126008)(86362001)(16576012)(52146003)(3846002)(66066001)(229853002)(65806001)(50466002)(81156014)(230700001)(305945005)(6116002)(64126003)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0188;H:[172.29.157.77];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTg4OzIzOm9PRFVJZG5ETFloaTRJOG1sOTJvTWNrUVFq?=
 =?utf-8?B?cFI4S2Eya1AxeHV0TmZxM0xmVVR2anVKSGZaeVE2Zm9UU00zZzU5Z2JjanJT?=
 =?utf-8?B?aFpzS0U0STJtVTdJd0hBdWlrQjJRcTdnODU2TTlzbnFzbExwTjhYc2p2dlFr?=
 =?utf-8?B?ci9wZ1dqbHB2NjI5WVJ0YXFZY3NiMEVpQkR0YjlSU0ZTUnpicC9NV3JrcWtK?=
 =?utf-8?B?Z25OZEt5eUI2SzF1enNxU0xUM3RwQmZ4QWMzWHNaOGpRSFp4ZjRwTXNhWEIw?=
 =?utf-8?B?RHZqUkMxaHZNRnNTMXF3Z1BiL0JHOFU5eC9qclRmRDVQaUFsaXd1aUFFU2RT?=
 =?utf-8?B?Qms5UXQ4b3RxekpJMHhmQWxmTVRSc0ZvSXVnd0QxZlRsUzlIRUZINFo3RlVv?=
 =?utf-8?B?aFA1b1VPOWJSK3hLWklxNzhSNjlLZ1RGWnljWkF5UFYwUVhkZk5aZVZLb3JI?=
 =?utf-8?B?bjgyQnRJOVh5ZjJ3OTNnU3ZJSkFVSUlIdGRDOVhONW94SnNkRW1EcHpkSUV3?=
 =?utf-8?B?R2d1MWlRTzArVFd1NExSaS8ralRuUCtQTmpjZ0dnV3YxLzRXR3F5NWpsSWxx?=
 =?utf-8?B?MTFEdm13RXRTdDloa0UrRU9WRGI3S0hlYVg0QzF0RVR0WnJ3a0U1QnJFQk9X?=
 =?utf-8?B?QnNDVkdnQy9pQ3IyMDFwa2JuU0I4dy9ObWlBNEErUG00VzFESml3ZGNUMWJO?=
 =?utf-8?B?SnNRdnl5UXg3SFNFWHVjUWJIMGNnNzB6SnlKRmVyb1dhemNRM211eCtqemxL?=
 =?utf-8?B?TWdHOENVc1BYRFZaenZKRkRuNnBGQkdXcWhMZGdsSlpaMHNmd09RK3dmZHF5?=
 =?utf-8?B?cnc0K2ROV2JCd1lZRXUvYjVZQ2lnWU5FdTk0MW5hdHBYZFVxNHlNc0ZTS2pP?=
 =?utf-8?B?WUlaRWtTQ0VOQmxQYVhCS0Q1a2VrMWNoeU40a2pSY29UYkNoQTVPNUhUZ09B?=
 =?utf-8?B?amU3Zjl6UjRDV3Y1c0dXN0FOOW9qZHBOcnNqTER4WFE5dnd5dDZPbER1Ym9W?=
 =?utf-8?B?QUxFZFUvYkNsdklYc1g1VjNrbnlwMTNMV0cyQ1k3UG9EZVlPV0ZXUXVrYmRa?=
 =?utf-8?B?cTViV21hSVdybDllOFVFSkhvcnBsWW1CcEJRR0JnWDV2REFXWHlIMzByVDAr?=
 =?utf-8?B?RFlVd1VGWUpmQkl2aEVMU0ZkbXdFdDBxakwzV3IxcHNUM0JsalpQaTc1ZzNk?=
 =?utf-8?B?Y3IvanE0WExGZllVSG9UVDJUU2YrMkxPSG55TTZ3TVJuSjNlS2N0T0NvUk1N?=
 =?utf-8?B?TUphYXRpNjVzd0NFYUF3UytLeDkwaGV6M3lPNEpoRFU0MG1UdTBGclpZVHhH?=
 =?utf-8?B?N3lWQ3BNZFRBcFhxMWtkSDBsQnd6S2REMFFtb3U5WndCa0dsRElBb0MxdDVT?=
 =?utf-8?B?MStwNFlZRnhVWnBlQlRQellFN1BoUnZNNHpZQnBkMTJKQ0NFeXVKTWFiVThp?=
 =?utf-8?B?VVdoQjFiN3N0UDF1S1R4U0ZtYlNxUGlwYmVCd3VmNFRaZUNCaGQvRDQ1clQr?=
 =?utf-8?B?QW1VSDIvUHZQWTRCVXZvSHh6bDJQazdSanhFMkt6YWpQaDUrVG5wRk1xWmZI?=
 =?utf-8?B?WERxN0kzSjNIYlJtNk9UdXZWSVhyK3BkNmpGUmprMWEyb1NnTWt5b1lBZFBp?=
 =?utf-8?B?WjlneWdvWkhFN2RrQnFVTVFMSGVmSWMwY2FSTkJ6M1IzalZBSkkyVTlRR1NI?=
 =?utf-8?B?MjFsZFljbGZwUzlNUEh4M3RMa3Y2c3NYdkg5TFdRemJyRWNrVjVmbzdSZldy?=
 =?utf-8?B?aWRvM1dBM292WmZodUpqVGFLalNGUVMyTHJKd3J4cVowdUo2WnljMU1Zc0pW?=
 =?utf-8?B?MEdiZFF3ZW9TeHdYWnRGcUM5NnZWWnppRlBXaHRuL1h1SE5QVEt6NDJmcW9B?=
 =?utf-8?B?ejUrbEZ1dWtPcHlRMUczR2Q2NG13VCtXNmNLWnVtdDF0cWhqVkJkUHgwbHhE?=
 =?utf-8?B?ZmVBcFVQWXplaFZPSDZxa3dHTUZQM1BmblQ2U0MxNGZzY0dlUUdRYTJXcVA1?=
 =?utf-8?B?TVB0SUQvVEdORlF5eDJuWmM1ejJNclVwOW9ML3hNd0JPSEpoNVlmdENjQVdE?=
 =?utf-8?B?MElEbWxJditJT3BsWGZueXo2Q2svSUxVZWRlbThSRm1PcTZmcjdHOWVId3l5?=
 =?utf-8?Q?MwHoWEGPgFPFaatY+P9CTiI=3D?=
X-Microsoft-Antispam-Message-Info: UhsEHR2FE5g+Bd3EiX3GFEtTPh6tlsqrKMF5yUrxag9Gj4SwMB0GouYMBCsPtUfjI5m7JV7KaZEnx6/VhyhcISf5PcbvVZ00vhlIiTbuUSiBfRnLR9LX7ICYTOrrzp8XIfNmDTXG7LTgme3iCWqvnUlhQwkIipIDEBfgWPPVYyACBfN1CGbJtyPIxZgImf34
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0188;6:dAfO/8wyBqoEIXwlTkOZzwUnpV6YNLV5hakbzf7xWM75NXozS+5S7ZOdJ4bW82JbxtQVS17kkgGT98nDqEj8wtpNwMUHOuiwbRLBDaTy3vNviqoi9Vzyqk+zUWKhSq8f2lx3M7n/jiGimDiAmCOkp/7YLy934EthG0daM56L3zrZ36fS5ssgwBq/yHPFFm6xVHYxiYpLefzGO+uEJFwSZ5Zenp0Hdpy6hNrgaq3XCcVKN+8UJuJGQ97eITaCkb94hLtnnFLdtPgZQjzQ6A5gmYtZqnWqccJt6oft7zl67Po2CmRNNfv4P791EH3aTTGcEybJZh8Iwn+YQrDihG7pjaOrMTUHNBndlz8zvOkmnvLlbvqZeVHrH8Pdo6LOHVIVOCaEpBn5Imv7SYe9anCDvjPpONksuPZtSKYjyiwLBYcWc5Z9vI2BxYU4XssHvqtzwXJsazPgamm+vOckq1/wzQ==;5:DAEKAj2WC0vB+IXQsY81G/nswYLZtkYv6bkEmWms7WwgwwCt+I9L4jIExu+5Rxf18HBzzowIoqKqfvC8elojrSuZvkggD7QXoQ9NkRzO2L20fU7cLUcDfQr+Br14KqofmT9jCXHpw3ukAEIng2ddLZ4lT6W7pTIQrbQLYSfQ32s=;24:g3Rms+X+a3G2CmsfF2Jk/5n79CP15FFPcnE1dMppbGPcF2a32BMvEkBfPW9rVp7HPCiQ0jXq7Mskx0busSyNhyAJ3L53+4+wCfanfVXn3/k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0188;7:dhkZlLJD/ihNuy14C4FQleTjAVSbqv3vRrIH532ehgAjHy/5xv6tEvXMy+TZ+YxmBVZKlLu9dLPjrwO7d0n0sXa8Ool4eovw6AlXtf9Tgz1xHT6uy1/QemZFe5oL0E5DOJFst6Xs/PK55OmdlzriNqw0luorvcKQYXPk8QxzygT1KBa2NoDIv/ffWfXC45yrlDXI569i+HCWHIHe8v8eicCU79OFYUO7tcEJ/CVEOrV+9ZXTXXI+CSgKD+akOYDl;20:Ns/9d/cbORKqPah8kuqpulOaAUMEa25Oa5iersODp6hLc5bHxsBExtHW6+vayU+Nq28coHJySP+aejleHsnON/04rkTvlLXI2O1a/mohlVoGZpu0jIzsvPFnOEbPx4SO7Z9JMKVih+JFTCGyoDT15NuSl85J0TyhScxPVGK4yQvzHya0RJjtGZIGs0EHIdETonktJCNAd/8pGrAIw3tRuzkVgnJDVHx8WJmy+k6wZ5/GT5KBXQ5NM+HFCTXx3VJN
X-MS-Office365-Filtering-Correlation-Id: d3a4da68-9103-4bcc-9a8b-08d5a9eebf4c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 14:22:00.6134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a4da68-9103-4bcc-9a8b-08d5a9eebf4c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0188
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-24 09:14 AM, Luc Van Oostenryck wrote:
> The method struct drm_connector_helper_funcs::mode_valid is defined
> as returning an 'enum drm_mode_status' but the driver implementation
> for this method uses an 'int' for it.
> 
> Fix this by using 'enum drm_mode_status' in the driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

amd-gfx mailing list should be sufficient for changes like these.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c          | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index 96501ff0e..8e66851eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -691,7 +691,7 @@ static int amdgpu_connector_lvds_get_modes(struct drm_connector *connector)
>  	return ret;
>  }
>  
> -static int amdgpu_connector_lvds_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status amdgpu_connector_lvds_mode_valid(struct drm_connector *connector,
>  					     struct drm_display_mode *mode)
>  {
>  	struct drm_encoder *encoder = amdgpu_connector_best_single_encoder(connector);
> @@ -843,7 +843,7 @@ static int amdgpu_connector_vga_get_modes(struct drm_connector *connector)
>  	return ret;
>  }
>  
> -static int amdgpu_connector_vga_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status amdgpu_connector_vga_mode_valid(struct drm_connector *connector,
>  					    struct drm_display_mode *mode)
>  {
>  	struct drm_device *dev = connector->dev;
> @@ -1172,7 +1172,7 @@ static void amdgpu_connector_dvi_force(struct drm_connector *connector)
>  		amdgpu_connector->use_digital = true;
>  }
>  
> -static int amdgpu_connector_dvi_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct drm_connector *connector,
>  					    struct drm_display_mode *mode)
>  {
>  	struct drm_device *dev = connector->dev;
> @@ -1448,7 +1448,7 @@ amdgpu_connector_dp_detect(struct drm_connector *connector, bool force)
>  	return ret;
>  }
>  
> -static int amdgpu_connector_dp_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status amdgpu_connector_dp_mode_valid(struct drm_connector *connector,
>  					   struct drm_display_mode *mode)
>  {
>  	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> index b51f05dc9..476c9b987 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -329,7 +329,7 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
>  	return 0;
>  }
>  
> -static int dce_virtual_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status dce_virtual_mode_valid(struct drm_connector *connector,
>  				  struct drm_display_mode *mode)
>  {
>  	return MODE_OK;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4e2f379ce..d7e52c4f6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2855,7 +2855,7 @@ static void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
>  	create_eml_sink(aconnector);
>  }
>  
> -int amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
> +enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
>  				   struct drm_display_mode *mode)
>  {
>  	int result = MODE_ERROR;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index b68400c11..cb7e20cb3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -246,7 +246,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>  				     struct dc_link *link,
>  				     int link_index);
>  
> -int amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
> +enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
>  				   struct drm_display_mode *mode);
>  
>  void dm_restore_drm_connector_state(struct drm_device *dev,
> 
