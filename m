Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDDE274AF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="2p6BPA7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDDE274AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966389AbeF1N61 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:58:27 -0400
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:16372
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966265AbeF1N6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD8g9HLMOSqb9Qp/04DxfCcI7DLVlzYhHabq61jgycA=;
 b=2p6BPA7LFkpnirB/5l0IJdlRbUxzqB3fv6R5VeKW3RvRZO+stVBGvJ9xMiUe7VnnCSLEnJJSkxh9qHwQyuMb7AkBkVswx2KGouRXkFgPP6Mddpl/w6YoOpW0qo7KRM9Eu9lpXbQnEpYnyXlLFHB+mLZmuzRJmVhWmpSeuVnyaTg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 AM6PR04MB4663.eurprd04.prod.outlook.com (2603:10a6:20b:1b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Thu, 28 Jun 2018 13:58:19 +0000
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC] Configure i.MX6 RGMII pad group control registers from
 device tree
To:     Andy Duan <fugang.duan@nxp.com>, "A.s. Dong" <aisheng.dong@nxp.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
References: <f5a01de5-fc81-52c1-c2ea-edb77ecff076@ysoft.com>
 <5ab5c58a-dc44-d1bc-2132-8704d05bf1de@ysoft.com>
 <AM0PR04MB42111E25172F6068F937ECCB804B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM4PR0401MB2260FB90A3B243A60D027F46FF4A0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
Message-ID: <1f80b97c-a0ca-8fea-4454-b7bf78dffae9@ysoft.com>
Date:   Thu, 28 Jun 2018 15:58:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <AM4PR0401MB2260FB90A3B243A60D027F46FF4A0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM6PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::38) To AM6PR04MB4663.eurprd04.prod.outlook.com
 (2603:10a6:20b:1b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b82ed75-8a52-4ee3-333a-08d5dcff3486
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4663;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4663;3:Jfj6OXlca+ZkzQtefs5B7IhaNxwd34wbSLkpxRdffvB89deWpQYmfb/39klZsrvpJnCLxKKvbibmp1uQGl28Loix5clmJpUeEx1hjA0HiMtsw1WgjItvM7fh93TaWnnyex0LTbcCH8CtHTdSuzslkNFcmCgeCOgJsBnz8iRBYR1EJjezldi9WbpKmYTW6oXLJnDQw0IF284a+4lF4ir2yA7bTSeO/yDHmU73gFrjR6F62h9ym4raAA61GzzYZvh3;25:mWv0q5yFfI8vMK5Z/VHr+qtYF3x9Yv1ZLCWmHtiY05knFSio3mQgOP9r3R/K43Bwf4JaljvrTDAgDlYSossqJsAHKSWSq4b3sm5mNdaesVkt8lt6+RdGar5E08hvGrdDdj86GtxfANofQV/jIi9NHqQE3fQafLrQh4cEggzM205E7+Uq74feen8nCG+Mlv6FRVnnt/281P+a23eIN3bfz3t43laVMnScfL4+VhIyJhhSOk8TZlx0mP7t4H2yKOip9txUs5D3V8NgX7VFJIvO4lh5WFwvE9jI/hUCnaMulqxcvsh8gV6PMD05korX7itkvS5SEmThePawQJ+BfcT/bA==;31:KUVSBQdmkMYHn/hARGnwsAeeCp8oLIOa276iBp7GN5mHWytuKMEJ/p4jMjq1Mm7e2pDBfhv8YHk7FEUJTCCkgln/TO6lCUIuw1f2Hxvkv3Hojwuk8meR/x5bE1tngBYEe4BgspJ0orJcB9SlsSlE2tIeW3BrvdjF2vjM/+F0m53YaLwv5/zqRNfLNY/vdMUE6FX4aL6h5M1IygbWXFl/wjDU1ugJMBX6F8bAh9CP7tc=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4663:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4663;20:mE6En21gfi6MH9ghj55xq+SfthgB7tnoLpNxztdq5DgeU6z+wwNt7IqyPjHBctrU7GyaEJ2s2D5Y6tgwWPLlMgJSNQk+69Pl8ivucjGfxDZLmh7xXJKWa8wkqWmXMeAoRJx203lPk3cBlpKJ24EwJ7NVizA9uO9Ww4Dspgw/U6XjXwIaZHM5jv3BIp4E2qjA0TGK6LfwYgVr4/zSzvUwmsDC1Cg4vK9gPm8soHxGTwELWb4ffGp2OXY5kxxPxgeT;4:PXmde/MFLPf1GQ8CpfxGlYUYOof7Gqt49e9IDBlBrvzn0BTsKMLRTKOFEvtWmUA2S7o0RVThBdLPxD52JPVaElIyOG4e754sD4gTzoanwbRzNDwXKf+vF64jDe8vSfzy0Ukuw8+NkOo93wG54HzKKvrIgMhirggF/j49nh3macaKn/DomOn1lzHpbFVe3mX16WrMIowelHJZFCxX2vZ5R9CWKEZplgGGgmejxu7K5RDsEOY8D3WPPmImEf6jeaftKoqp+Zm+QgphWX8KZMxRew==
X-Microsoft-Antispam-PRVS: <AM6PR04MB46635656CFAA3738AC452FC99E4F0@AM6PR04MB4663.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4663;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4663;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(97736004)(50466002)(16576012)(36756003)(4326008)(575784001)(8936002)(58126008)(86362001)(81166006)(110136005)(93886005)(316002)(305945005)(64126003)(81156014)(8676002)(3846002)(561944003)(229853002)(6116002)(25786009)(54906003)(7736002)(67846002)(52146003)(2486003)(52116002)(26005)(7416002)(76176011)(956004)(2906002)(23676004)(77096007)(476003)(186003)(16526019)(53936002)(31686004)(11346002)(6486002)(65806001)(39060400002)(2616005)(5660300001)(65826007)(446003)(53546011)(2870700001)(478600001)(72206003)(14444005)(31696002)(386003)(85182001)(105586002)(47776003)(486006)(68736007)(66066001)(106356001)(65956001)(6246003)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4663;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NjYzOzIzOlMxeGh0ZHZNMk1WVFF0WjdRNGJ5L0UrVmxl?=
 =?utf-8?B?bU5WcmlCM0RPOStyN3F6Z3hmWW5VTkk1TkQxNjllSEkweXhVVDkrcjY3Znd0?=
 =?utf-8?B?d3I1ZUprTFd5c2pOcncrWmFHNUVETTVSaksxUEROQ1VzbE9wcVYrOVZkNHRK?=
 =?utf-8?B?cjdyY0I2OElDVTkxNVhBSExoTmNQWWp1eFMycnF4Z1BXZStIaGJHcTdFTCtp?=
 =?utf-8?B?SysxWk5MSHRQY3l1SEk3WHdOZFdkeXRxNGNTZXZESENnbHJnZTB3NitJSlAw?=
 =?utf-8?B?djRTVk5WTkJnM2lOUm8xZzdBSTFISzQ3ci9LU205UXArcGcvRk1lMkxNQXhi?=
 =?utf-8?B?V1NFUmxyTjN1LzliZU5kM05tM0lqS3ZHZEdnTkR1Y0p5ZC9kS2Z3OEFMeUN4?=
 =?utf-8?B?cVRsaHlYblhPMWxZTUF1TFRhWlVwMHBKeW5ReGp0Qlc2cmxSM1QwNTE0MWVS?=
 =?utf-8?B?VHM1N2xLNlV1U0N6NUlLTFVTRVhyZGU3dm52Zmp1OWwvMUxMV3pabWUwam1x?=
 =?utf-8?B?dWJTRWd1cy9aUnlvRWpRVFBobjZYUUxpa2NXODlLalJmRmNBZiszcHhralB5?=
 =?utf-8?B?OFBmWUc4L2xCNVRyTTlVWFhnd0FFK2UyTUhrOWg2M1h4Kyt3b3pEaFFqOWw2?=
 =?utf-8?B?UWJrbDhITlQyVTYzM0s2NnhrRlNiS3dBUWIwNUl1a3Q1V1VKYUpHL21wbTc4?=
 =?utf-8?B?YzFmanBXNmMwZWpXN2cybXRsemNwN01YbnRKMS9sbjIvNzJLVGF0eTJCcWY3?=
 =?utf-8?B?TktRY203QlpKVVllb3YrQlJ3azFRNFFDcEYrVzhpaHpHYjZITmNhN2RqTGlQ?=
 =?utf-8?B?aDJtellCSFNFVEdXYllxeTBYVEltSTl2T1Q3SC9FaTg0TFJMMldGdVprdkJS?=
 =?utf-8?B?cHFmdzhWTjNTLzd2WkxUbFk3QTJKVWJNL294Ly8zdkVqZFJDNHZMZU9TUTls?=
 =?utf-8?B?b3lKcnAwUlFLTy9Lc2RlU2loV1VwK1plK0paMlYxSE0yT1BtWkx5Q25xczVG?=
 =?utf-8?B?Ymh1MUp1VU1ibVJBSkVzcXl6ZXdBci96ajJuNEdpVFVxd0VTMWJRaFQ2QUZq?=
 =?utf-8?B?ZGtPUjhkNlJUUlBEMEVBSE9YKzRsdmp4cUJMWnhvcEJCVGNWSHhkcW9rc0lR?=
 =?utf-8?B?T29ub1hqWERHZXVTeUZ6U0NuN21xQTE5Q2FyU0s1Z1FJMHg4S0VWNEpkZnk2?=
 =?utf-8?B?c0tCTVRVZVhQL2kzV3ZyaXJGbXZUN1k1c0ZtVGZma21ESitlc20xL01tMHBw?=
 =?utf-8?B?VjROYlpYSXIwQXVYbUxFaDIrU1cyb3JpVmFTS3dGOTI1b1ltUEUreVNtWWpw?=
 =?utf-8?B?eHdLemV4aUcxcVdJOEd5K0RMSEZPdGY0Ymp6SlBTM0ljMWs0enErbldDQXJl?=
 =?utf-8?B?ZjNoT003TndyUXdrRUV6OVBidU5ybUZOSzladkpJbUM4STQ0dVBndGZIVlBq?=
 =?utf-8?B?bXR3bTV5MTQ1VWdleXpmdS9TNC96NjZXQlYrN3BKSHYyMndkcENJMDRUUnl4?=
 =?utf-8?B?cXR0dkE4c0Nta1ZyOE90eFIzbDJBanZnWE1BeW1GeHFmaGQyYjJWSGpHK1Vh?=
 =?utf-8?B?UUZpaEtFVjUrb2ZRRUpLYlluZ2ZaOEdsQXpLaW0wQzlEWDYza2pDYlJWN0NK?=
 =?utf-8?B?ZHNsMXExSUNQSnBObnlPWXZuREwwdW5tMFRRWEsvZzNsYTh4YnJTT1kwb2Mz?=
 =?utf-8?B?eFFuL2hoc0xVSkg1NVdlaGk0ZlY4VDk4RGdCUzNHTW9NeTdudjgvZUFrWEVn?=
 =?utf-8?B?bmxKZmZSdCs4Vk96TEJBa2p6dSs1NHE4enlTTDlKTVdibVQvb2xXVnZlS0hr?=
 =?utf-8?B?eGxmVXE0OFVEMmNOMnZhZHNYNGdrL25Da3lMdmVTYy9XUy9yd0RHN21neG5Q?=
 =?utf-8?B?SUhVYlFEUEo2MUxuSzk4eWxsekswY1FkMEpObXRmb214TFZrbEZsZ3pXZDY2?=
 =?utf-8?B?REsxRlN3S25TcXZ5K05aUkY0L3RLM2JXZjBJZzRkMGVTRytzUHRWbHNDYWRa?=
 =?utf-8?B?UHZIdkRYRmZ4a1d3YU45bUNncGlvVSt0aHZVa2o3dDRSUUk3eDQ1b2dyaDdZ?=
 =?utf-8?B?aFhRSFRNdWRaeEh0VURqNnZaOGRNUGVJM2VpSlB2dFNGQU1xZE5BKzlyVElh?=
 =?utf-8?B?aStibllSMlRnTTZZY0tuNHhpYzFkQTZYdWQ0Z1I3RGN5ZUVZWFh1NVVaVEpl?=
 =?utf-8?Q?15GVXf0iK7nR4MZcUTGVgXrdHGcPvGhMMWMrj6ZLL8=3D?=
X-Microsoft-Antispam-Message-Info: SKMKaoYL0x1fY6HTxNfmAd4JlVBSQU5+XcsUeSOinbGo3wypfIfCADBMXcUFc0qhuJ77pGi+OFrwGb3SexF53HAdaYeY9s6uD02UkK38cVhgXZj5oM+QCYZf+6Himkut5BPJ1aDGU7CbQ+Tp23h2Y1HiMZ6rjengfyNXCv16/IVAvSYrSG5xRXFsUTtXNc27S3Nt/r61f2VVwKYtSRnLs4z+3lYiOT98ihw0iX0vEFU9qK5LoommrtDju9pWkqVnyjKMSz6vrciUBRiHVBLWUWiM/xqSnubQY6MgQqhRR7y/PT3bSgfwz4badMM73b/QnSWb/mm8X55zd5aAUGhvX+yuNa9V6XMkjR0pUghXPsg=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4663;6:E0uIlytuRa1ITAYbYzT6xKKzpJsSOdbloVJxbhsj+HVtylM34/SEvKIK2dWB8cEOWOA91N5qwxzXi8n4O51ecSxGLHLnHO9JxtCbiBiqPOncLQgUZDjICy5GxtMrF/TuXHPCOCnIzip5NIv13xFZY0qGADu+VYugxBtG+89BsjONJBOxbvZJ7vi2MgsCk0a0DgR4Rs+FWGWQ4B8Y2HyBDhlkVtF3JOqGLnlnCDaR7VAvlExBMkXmquguLyGpRErON0yLFyVXM9x36C7gjbOIt4VbSlEnYIxmHAI2ECyskq+cS4wyj90wC/g1Dwm+IMkiSbdUAMAtlwhbExpaKYJpXiInYbtljkP0Dtg9WifRprAfd8OalJAlF4faoK+jEvw6UuG+dSPgpqYsSk/z69pVsNwCyoubtiAhPuqHVBzu/LfgZ1io5n8HBRfF0HRVBO7lFrKvEvdYHYCj7v3F9BQOmQ==;5:VrL7+x4IPy2AXmYXv/XsnqSpJp8WjEiUXVagcQkdNastVeLwo6tq6OrC8WTIYscFH42aKUuI0Sg2Q92nNazMO080pCDyxT/pIiRXF2UYmN1fRuZmrTo4A0Hk6th1zoed83dfTeqZpqFcnQN0A+07SOxUyi2kpkR1YVg2MIDOeAE=;24:Uab8FlBp8gYVW9sMgyupyxr+O1O7nG8STVBQbTVWKnarpNx0ihUsjw/mUFYp340q6thiX/mUvjKHpnq3VkOr8f/fHA+oyqu7CElYeBjdHCQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4663;7:m8Ud25+tWtKza/uXP56VTbBZdWw2Y7DJrBxjIp/6bM/kJNgAEaq6o8UkCi4nuGHuKxBsZcjB1vT5VaFHQ+gT/rBpScr4M7Xf8oISgGeCLGLpjN4w3eATm6I5sbSK1oQkxo8AqxsvV5kujgBQGAmsgOOMBH73CuUc9SMa5ai5MaCgnQ6ICrNR1K+Az15DE79GkYxNfCyC2VILqlYv5woexEmfKvkSwQ8FGFk8W8pwKlimlBdF+mN7qw3RUNuji5Y0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 13:58:19.3570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b82ed75-8a52-4ee3-333a-08d5dcff3486
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4663
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.6.2018 04:50, Andy Duan wrote:
>>> On 11.6.2018 14:36, Michal Vokáč wrote:
>>>> Ahoj,
>>>>
>>>> To configure individual pad's characteristics on i.MX6 SoC a
>>>> fsl,pins = <PIN_FUNC_ID CONFIG> property can be used. Is there any
>>>> convenient way to configure the pad group control registers?
>>>>
>>>> The issue is that some bits (DDR_SEL and ODT) in the individual
>>>> RGMII pad control registers are read-only. To tweak those parameters
>>>> (signal voltage and termination resistors) one need to write to the
>>>> pad group control registers for the whole RGMII pad group. Namely
>>>> IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE_RGMII and
>>>> IOMUXC_SW_PAD_CTL_GRP_RGMII_TERM. The group registers in general
>>>> are not accessible from the list in arch/arm/boot/dts/imx6dl-pinfunc.h.
>>>>
>>>> I could not find any other way to change the group registers than
>>>> hacking-in some lines into the imx6q_init_machine(void) function in
>>>> arch/arm/mach-imx/mach-imx6q.c source. As I work towards upstreaming
>>>> my board this should be done from my device tree or solved in some
>>>> universal way.
>>>>
>>>> Any hints will be much appreciated.
>>>> Michal
>>>
>>> I figured out this is more "pinctrl-imx.c" than "device-tree" related
>>> so I am kindly adding maintainers of that file in hope somebody will
>>> shed some light to it.
>>>
>>> I am diving deeper into the code and it seems there really is no
>>> generic option to set the i.MX6 pad group control registers from device
>>> tree. Or am I looking at the problem from a wrong angle?
>>
>> Yes, there's a few special pad group ctrl registers (e.g. DRAM and RGMII
>> for mx6q) which are not added In the pinctrl driver support.

Hi Andy and Dong! Thank you very much for your comments.

I still have quite limited knowledge about the pinctrl driver and related
things but AFAIK it is not like that few pad group ctrl registers are not
supported. I do not see any support for group control registers at all.
And not only for the imx6q but for all the SoC variants and other SoCs as
well. Am I right?

>>> How should we deal with boards that need to configure some pad
>>> characteristics available only through the pad group control registers?
>>
>> Andy,
>> How do we handle it internally?
> No, we don't handle the pin.
> I remembered IC owner said It seems only RGMII 2.5v need to handle the pin.

That is our case. I need to use 2.5V signaling at the RGMII for
the connected QCA8334 switch. And also to set the terminators accordingly.

>> There're probably two ways to do it:
>> 1) handle it in fec driver by parsing a specific property
>> 2) Add a new pad group into pinctrl driver support e.g.
>> MX6Q_PAD_CTL_GRP_RGMII_TERM
>> MX6Q_PAD_CTL_GRP_DDR_TYPE_RGMII
>>
>> I may prefer to 2).

No.1 is similar to what I am doing now. I have a DT node with custom
compatible string and a reg property. Then I look for that compatible from
imx6q_enet_init() using syscon_regmap_lookup_by_compatible("fsl,imx6-rgmii-ddrtype-gpr");
I do not see a chance that something like this could be accepted upstream.

No.2 is much more complex. IMHO it is not about adding support for a new
pad group. It is about adding support for pad group control registers from
scratch.

I do not mind working on a proper solution. Though as I mentioned I am
still not very experienced in kernel internals/APIs so I will appreciate
some guidance along the way. It should not be as complex as
handling pin muxing and all the related things though.

What I see as a potential problem is conflict of the usage of the "pin group"
term. Now "pin group" is used in pinctrl core and refers to a DT node.
That node associates any pins that are needed for a given functionality.
Those pins can actually be wired to totally different IP blocks of the SoC.

Whereas the pad group control register typically associates and controls
pins that are common to one IP block.

So the question is how complex such implementation should be?
How should the binding look like?
What is the proper place to parse the DT and write the registers?
What SoCs should be supported?

Se bellow my very preliminary proposal how this may look like.
It is meant more like a background for further discussion.
I am really not sure if this should be strictly solved at the imx-pinctrl
level or if this overlaps into the pinctrl core.

Thanks a lot for any additional comments,
Michal

diff --git a/arch/arm/boot/dts/imx6dl-pinfunc.h b/arch/arm/boot/dts/imx6dl-pinfunc.h
index 37e430a..eeac9e3 100644
--- a/arch/arm/boot/dts/imx6dl-pinfunc.h
+++ b/arch/arm/boot/dts/imx6dl-pinfunc.h
@@ -1089,4 +1089,24 @@
  #define MX6QDL_PAD_SD4_DAT7__UART2_RX_DATA          0x35c 0x744 0x904 0x2 0x7
  #define MX6QDL_PAD_SD4_DAT7__GPIO2_IO15             0x35c 0x744 0x000 0x5 0x0
  
+/* Pad group control registers */
+#define MX6QDL_PAD_CTL_GRP_B7DS           0x748
+#define MX6QDL_PAD_CTL_GRP_ADDDS          0x74c
+#define MX6QDL_PAD_CTL_GRP_DDRMODE_CTL    0x750
+#define MX6QDL_PAD_CTL_GRP_DDRPKE         0x754
+#define MX6QDL_PAD_CTL_GRP_DDRPK          0x758
+#define MX6QDL_PAD_CTL_GRP_DDRHYS         0x75c
+#define MX6QDL_PAD_CTL_GRP_DDRMODE        0x760
+#define MX6QDL_PAD_CTL_GRP_B0DS           0x764
+#define MX6QDL_PAD_CTL_GRP_DDR_TYPE_RGMII 0x768
+#define MX6QDL_PAD_CTL_GRP_CTLDS          0x76c
+#define MX6QDL_PAD_CTL_GRP_B1DS           0x770
+#define MX6QDL_PAD_CTL_GRP_DDR_TYPE       0x774
+#define MX6QDL_PAD_CTL_GRP_B2DS           0x778
+#define MX6QDL_PAD_CTL_GRP_B3DS           0x77c
+#define MX6QDL_PAD_CTL_GRP_B4DS           0x780
+#define MX6QDL_PAD_CTL_GRP_B5DS           0x784
+#define MX6QDL_PAD_CTL_GRP_RGMII_TERM     0x788
+#define MX6QDL_PAD_CTL_GRP_B6DS           0x78c
+
  #endif /* __DTS_IMX6DL_PINFUNC_H */
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 15744ad..3e9d1ba 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -467,6 +467,11 @@
  				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
  				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
  			>;
+
+			fsl,pin-groups = <
+				MX6QDL_PAD_CTL_GRP_RGMII_TERM           0xC0000
+				MX6QDL_PAD_CTL_GRP_DDR_TYPE_RGMII       0x100
+			>;
  		};
  
  		pinctrl_gpio_keys: gpio_keysgrp {
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 1c6bb15..3c42917 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -235,6 +235,8 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
  		}
  	}
  
+	/* TODO write the pad group control registers here? */
+
  	return 0;
  }
  
@@ -421,6 +423,7 @@ static const struct pinconf_ops imx_pinconf_ops = {
   *     <mux_conf_reg input_reg mux_mode input_val>
   */
  #define FSL_PIN_SIZE 24
+#define FSL_PIN_GRP_SIZE 8
  #define FSL_PIN_SHARE_SIZE 20
  
  static int imx_pinctrl_parse_groups(struct device_node *np,
@@ -430,6 +433,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
  {
  	const struct imx_pinctrl_soc_info *info = ipctl->info;
  	int size, pin_size;
+	int pin_grp_size = FSL_PIN_GRP_SIZE;
  	const __be32 *list;
  	int i;
  	u32 config;
@@ -531,6 +539,22 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
  				pin->mux_mode, pin->config);
  	}
  
+	/* parse the pad control group register configuration */
+	list = of_get_property(np, "fsl,pin-groups", &size);
+
+	/* this binding is optional so stop here if it is not used */
+	if (!list)
+		goto out;
+
+	/* we do not check return since it's safe node passed down */
+	if (!size || size % pin_grp_size) {
+		dev_err(ipctl->dev, "Invalid fsl,pin-groups property in node %pOF\n", np);
+		return -EINVAL;
+	}
+
+	/* TODO Parse the pad group register IDs and its configuration values */
+
+out:
  	return 0;
  }
--
  
