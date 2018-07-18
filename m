Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F42ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCA52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="E6d3YVVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCA52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbeGRNjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:39:01 -0400
Received: from mail-ve1eur01on0080.outbound.protection.outlook.com ([104.47.1.80]:38816
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726901AbeGRNjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Daqn12E8Zmhq6ys3IA1dU7x2h1Mtk8wDUe8Hqjf8BPg=;
 b=E6d3YVVdQ7GW26xKWsY+nl8wuzcT0KANgmkJJ9Ck7XiGylMhW/xZPDlhKY22LF7Ded/XABONFWk4nGxSN25JxNOohKGPo2rc36O6amdrBWlcDsPj3NPDkcjXLoLZv+ewEuWlN8t5FWeMRSFTF3E13Ytayy3UY9CYzKJhxiaP2r0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 VI1PR04MB4672.eurprd04.prod.outlook.com (2603:10a6:803:71::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Wed, 18 Jul 2018 13:01:05 +0000
Subject: Re: [RFC] Configure i.MX6 RGMII pad group control registers from
 device tree
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
To:     Andy Duan <fugang.duan@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
References: <f5a01de5-fc81-52c1-c2ea-edb77ecff076@ysoft.com>
 <5ab5c58a-dc44-d1bc-2132-8704d05bf1de@ysoft.com>
 <AM0PR04MB42111E25172F6068F937ECCB804B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM4PR0401MB2260FB90A3B243A60D027F46FF4A0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
 <1f80b97c-a0ca-8fea-4454-b7bf78dffae9@ysoft.com>
Message-ID: <e91b9d5c-b08c-3927-0f70-b6db9bada5ab@ysoft.com>
Date:   Wed, 18 Jul 2018 15:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1f80b97c-a0ca-8fea-4454-b7bf78dffae9@ysoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1PR04CA0087.eurprd04.prod.outlook.com
 (2603:10a6:803:64::22) To VI1PR04MB4672.eurprd04.prod.outlook.com
 (2603:10a6:803:71::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b14aac9-1dfc-4c78-a45a-08d5ecae85a6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4672;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4672;3:jhQMfQxVplqEDlFgNp1F4cf+hZvoSRwzxUDU2XsL/KlSY8BlqNmduRTR+lWSuYKPZ1LpxWoacks+iIM7MdcIghKP9QWxVtTbfBn9VttkG99VawE8LAizDsLSJySxPBM6oUVYngCguzGfWGL0vN0BT8+H0sIV6kz2muOsrSFdWA/XBeAkEQjiPM8Hi1Wa1ozzLgrQLnCdjW6WOXbtM6r+OUSlzYJBk2JiyVNrqbEcdi1aQk+YfUaikvCDTDf+bNV2;25:yAvUjQuVQnFxcZOvbIv7ZikLA0FH2LMK0IC+yTNik807dHb8oLuTiTWcYghLoOdsn9rMpJgxaODu8rC0fixUZ0c8XsdUWn9S4L43Ls/vJfIWclXhJ78ZacQqh56Y2+Gq469LM5nlHJZa9/q0UQQzFXphjNCfykRjOZdUAdlrmYDDgEQqXMIYImTtbfybbxu461BFBX2ND7X6/n9ZYKvrX+9U28OvYm7VxKZhi4Z2xqXoDYctWwF4fN+5dglfzjIvnaiS5JVnCFbrCRfHhja2S0XIIxW972d3OC10OI7ZVYTMww5iyZ1weV6e0fyXLe98P35mBoQq5bsDHH6iaWx0Pw==;31:qBy6K9CDHKlEsQF7+2VdGm+Lel3UypBWsWio8ut/P/1cjcby6GLedXhtSZ7TfPG26VGtUiyUkbxC+i/2kJ0MEKiiOcUMFk2s6MW3rMKWDV0KmQ9h12lKvwB5C0OpCKzBH2uszzoeNNHEbi0RusLVn8XfYjL0D3Lg9ALQiKBfYq3BfchfMr583DTaFkxTc99Nzqz1QY4+hM6+MNhfuah9o9uT0uDvNEajKoORuxnnTyo=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4672:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4672;20:lM5jWXP45FQ45C1YN3+uDohqbdqGJN/AKauvSvcobZ4K2tTGBFSAjiEZempifuBFsU2IJV7wg6m0kAkYLq2rgXadZCQzm4374Ik+hTm1D3b9s0jY7gwAaXk4PLXfeBlwM8EJ2MdlCOpmSz7YHU20u4uJmnjLpDZB6akVPo1Lzz6wyp6xtFMMoi13AUOXJxZiyJMWHKAw5az7hma2ahEZU/QpYmqkhJar67fvF6kuTzJ8SKYUr7Hy7oVa8znzlZ3A;4:8Iuk+vSuLCR0A9HxT4buYzlqDEVRRHTY+u4fXsRTIhM4swZZ+4rioxAkE6aTkjShCITHNiZdCJk60x475BELdc/7IIpXwOM0/nojLVBYmHeb+AchXUMEmk2BECzv+nn93wO4GkyKpSCevuiRRqkps/kULO8dPH/1SxNlTXctvzHW/stPypDgUBm8Ho35LtDJ28+Vp/Z39lCWBDhFef2YrJQvNTZLQhjyWbayBwxcGOcbMPh7Fa6OrbJzDLAPkW+B6ecGubQ77Q4nma3MSyi/Sex450cre7Nec7aSOLdWq8IM2enkdAKMIuOD27gQEbzu
X-Microsoft-Antispam-PRVS: <VI1PR04MB4672214D90335E4F5BE07FFE9E530@VI1PR04MB4672.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4672;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4672;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(39840400004)(136003)(346002)(396003)(189003)(199004)(54906003)(86362001)(561944003)(65956001)(106356001)(50466002)(36756003)(85182001)(5660300001)(316002)(31696002)(6486002)(97736004)(575784001)(72206003)(68736007)(105586002)(966005)(64126003)(16576012)(229853002)(66066001)(6116002)(478600001)(110136005)(3846002)(58126008)(23676004)(6306002)(65806001)(47776003)(81166006)(2906002)(2870700001)(6666003)(52146003)(76176011)(956004)(2486003)(14444005)(67846002)(26005)(77096007)(486006)(53546011)(386003)(52116002)(2616005)(476003)(11346002)(186003)(65826007)(31686004)(39060400002)(7416002)(81156014)(8676002)(6246003)(16526019)(7736002)(53936002)(305945005)(8936002)(25786009)(93886005)(446003)(4326008)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4672;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0NjcyOzIzOm5QeHpVTUFFL1hPWDErdFVPZDRJWFI2WThM?=
 =?utf-8?B?cGZIcndYV1NtV1UzcUg0Rk1DZnhzNG1ndWdkU2M1MWZFS1Vpa3ZDcGpSTUtp?=
 =?utf-8?B?bmlNK2dpb0ZXSzFGT2RZdEVoKzVVTnpRcW5hU2ZvYWVQbElFZlkzdDdYOUh1?=
 =?utf-8?B?UnVjalJqQzdoODVMU2ZWamZ0WmY4S2ZoWGRydjAxejBDM0FYdjVqNTVta05M?=
 =?utf-8?B?RFVKQUMrSW1HVWRXakR5d3ZGajF1ZW9yS3REUkRBazRTajZ4c1lDTUlBMmpC?=
 =?utf-8?B?dWF5LzBMaFAzcGNEdzlBazRhUDdBZVIxTUJGZUVoYzFxeFBuZGVMQzJPcXlB?=
 =?utf-8?B?dC9wZ0dGV2pJQjhWTVVxUnhBV1RPSHBObGJ6NDV3NkRjbVNLaVFGcjBqR2hK?=
 =?utf-8?B?Wi80T1NpNEVpK2xlc1hqeHRPdktTdjUxQU01LzRtWFZ1TitrL0tiUVlCaU5U?=
 =?utf-8?B?bHNGeldaeHZ3bGljQVYvcnJDZVR6ampWcDZ0M1VaUTB6aXRlaC9MOGROd0xz?=
 =?utf-8?B?SzVFMXM2WTlqSzdVR0cwSGJwcjdrdkxNYTZIY1BldVRwbDRxN204clhJR0dk?=
 =?utf-8?B?YTBvN0lEMW5VNGRYUDRtS0h2WGJGMjBYMEJ5QnljSTF3aUVlTGV6aHJwbC9w?=
 =?utf-8?B?N3BDWlRORjArOEsxeWgxR3BUMGJJbnFOS2dhUDA2WTdScllKbSs5RjNzQTBE?=
 =?utf-8?B?VkxtZlFPQk1qZ1pOMGdKSmlHMmR4VUNHWVNWQ0FEai9hU1ZnYTVKaGNkNjF0?=
 =?utf-8?B?TTNFOXFrcHl4a0lPa1FqVWoyL3ViZXpJK1lSUmc4VzB4Q2JoSUtoaWNkMlV3?=
 =?utf-8?B?ZmdqQ0ZpOFRoT3N6dXJJNkNwOVZGNisxcmdzTEJCRTZVV0s2aXBzZDRRalJU?=
 =?utf-8?B?cVZPSWpNcXlRUzRIaDJiMHJiNnZsYitGUXd0NVRQSGF6S1MwTlNqY043QlQr?=
 =?utf-8?B?TGp0cldQWk1xMFBqMWg0c0VnbzBPVlNGQnFaSkNCN0dRRzF0cVk1dHZXL3gr?=
 =?utf-8?B?U2pCemNNWTVwc1g1QmVNc1JOL3hzcVhYbHNpVnhvUHRrUzJnYmNnY3JkMUpX?=
 =?utf-8?B?Z21qQzR1TDcwMEVsWi81S1lJRzM5QjhOdkZaalViS3hJR3JmeldaREl4eWg1?=
 =?utf-8?B?a1A1czZMNkIxZit3dzZDZ2dLcmJqUWJNd0VmcUVFaFRFVUpMZmZtK2tSWklj?=
 =?utf-8?B?L0Y0WTJNVitPYWRxdWNuZVMzQU8xY0h3czZtdHRac2RZaWpuNXRGWnlhcW12?=
 =?utf-8?B?clB2Z2djVGlkalZCZXRidmZvN043WGdlQ1dYZDJDbDNhVStLeG9hdCtmUW1F?=
 =?utf-8?B?WEU3TjZxOFl3YnM1N05TT1krb1dXbXNoMW1YK0J5blR1SE1oRUdRRmlmNHhH?=
 =?utf-8?B?UjE4dHd3WEJOU1hSa1U2Vk4wYU10Z29tR2dXQXVJMXhEZU4rZ09aUldqWlZz?=
 =?utf-8?B?ck1WKzdkZHR1TWVIZDFROWV1dkNndEd2VDNlaU9neWRrc0cxWUxSdm5hYjcr?=
 =?utf-8?B?QVhHTUNHSXJGZVg2am80bzU5MVBlN2ZhYXFHZkg0RUdoM1gya2hINW8zOTVh?=
 =?utf-8?B?bTdHaFpkdWVQbXBOMjE2eUVmVkRwYytrMkU0RUZNZUhVWW0wM0w4M240bVJD?=
 =?utf-8?B?M3FKL0R1SHZKdjhTay9nK0xhVHhlZEd2WWlMSUJRM2tqOVNzU2dWUzJWZS9J?=
 =?utf-8?B?eHhUekhBVlh6cU93alVsYUQzZ1c5RzdnMWNHNVE0WldvRXpNTmR3U05FMlk4?=
 =?utf-8?B?dFVFbm1jbEx6aWpDTmpWNEl5Nk11MGJkL0NNRkkvZjY2R3R0TW1ITyt3S2hV?=
 =?utf-8?B?TzN1b2RLV3R5UUtQbFJ2WFVidnpqVDNybng0ZkllaGFCREl3b09sNVFMOHg0?=
 =?utf-8?B?SHh1elVnWnNyUFRsZ2hHNUlzTmpmUGdpWUZ0UE5zcWxHam9QTGVhWkRsNG85?=
 =?utf-8?B?UkNidnpBTUgxQVFKZjMrL3d4bTNuTkUrMzkyWEVjZVhvWkFjQnA3cWgxTy9C?=
 =?utf-8?B?NFNFUmlhNUpWZGsrQlE2SHpmZzBpQUt4aGVNRStYdElBSXBTUEovanhOcVh2?=
 =?utf-8?B?dmc2T0xHOGtwVWdPVUtZZmpCWm10aTVnNlhNUm1ITFM5S2YvenBUak91amdm?=
 =?utf-8?B?cEpMQjB1cDFxMkZzR25UeUdtUWMwa2xjTEJEOUNsRFR4N2NZOUkvNmRWK3g4?=
 =?utf-8?B?ZEpSZ1hkUFlNWjBBSFFKZU0xeGpEUDRkajdtVDdabUlIcGhDdG50WVJmYWRG?=
 =?utf-8?B?aHptbS9YMnM0VXBYVXR4d09TeFQzVDBnem1lL3ZMcDdZVEd2UWt2dz09?=
X-Microsoft-Antispam-Message-Info: hCCe/BDDRYmeNMN8q8a+pWf9m3VcTthBgsd8T0EUnCNXXAG+L982UtRoVCiR76ZOM8Xnyo5qn321lqA7Q9Wgy23I3XuwDOqKT8YJkC3Ltj385/URGlzg4+MKQdMYGRGuxOEZNIn5ijujz/IdKRY8rufcYKlIBGJRDvEloNHK4FkRzAH8MRcce598oEzPIj2LZ5jfPhop9tiPZgpPrvJVWJ7neDx9ySTlw9zQZnuLXZQuMpgGDAXALNxaffspk38mWsiCsohBCyIjYlsbH2on2lFRnwL1TUkbt+R6GG89Kj7OsMs+c8gHbqlfSl44x55ctVdKVd2gDXyuKeSlkiQkZse/DnNHPgTPLwTmur22bAg=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4672;6:VyiOeyFR55STHgqQ3/E9wTd25AdsoRKsmGWP8ebg9DnjOIn/ZiSqjLz6EC17/M4HDtoae1YccfE3ZnDJERJqSKSZYMVs97Tm2ns9CBeHR76QXjRD1XdM1oQo4fROzD1MMoLaldsGf1EAiE0daJuUgrfMLLJOjCHdOfrKhjaAsLv2MvGBpjQdZOizz+ctl1HQfEd6tv5Mjk1GEl7m3fSpurh1gQMx0JfEx79HMc7l3M9YtUhW/1P+62FclAWJSfjEv9txvbwx2GPu/CAgEA+I0LQgq2V6XYPL/x9Lh5NY3QCm3yLU1+3WXfcy+aIjr+0gMU7XckPcolkEeVNnx6nP8+BJBjiwd/mPnDGvndcuM5izC62ZcwGI1EIth8cSrBfJHyy3Dd30oCzr75RhBBu9T30LtLLihu51H0ttwvzSRlhdNpd5u6KKrG+umb36vob/clRacHgynnrMdi9TDtnjxg==;5:ByA9iZurdaNvc7IwiW5eId5X5lxp2+0/h7SjRf8eXhE4IVwVv3AwZcR/aWmnA3u5rWMpi110wB/IIU3CgDFbI6wrBgDUqhGKKkTcgGBJCmGrTssB1XKgUKufjSDnzjt2pTXgmzIpnrRz/gOrxTXPPjHptpg/VCIWkAD84lUqdWs=;24:UiKhtDGhSkbhlrVCm965EFR1XMy8bALdNu+1Tb9bNMRpmQxy03KT+GA8YuKr/u30cEJxy12A1GQkyLEtQHbHDwxBLWDdT6aLHQOVfy1RKMA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4672;7:Ckjr1JozXY06uOhDnMEkiw5okeisY1c2yrrSaDVF5uh1DhD7jYw1qiyJYXOG0GKp2uPdEL3EMZe7yZr32/dls5ratJL/aHlcMWW4M/blgF4uAw2rlz1iGstD0TCj0bwfaU6ah5rknmDH/htxLzZt74b1kvQCKEKauwbBqmYbBii9HmcR86UO3eRlDhet8IxX0AgqIc62MO3CQ7qpXuvE2V4KedmHs7f4907PDzjQEhkKtYPdBQ2T/2Nr7ledMfgD
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:01:05.0579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b14aac9-1dfc-4c78-a45a-08d5ecae85a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.6.2018 15:58, Michal Vokáč wrote:
> On 25.6.2018 04:50, Andy Duan wrote:
>>>> On 11.6.2018 14:36, Michal Vokáč wrote:
>>>>> Ahoj,
>>>>>
>>>>> To configure individual pad's characteristics on i.MX6 SoC a
>>>>> fsl,pins = <PIN_FUNC_ID CONFIG> property can be used. Is there any
>>>>> convenient way to configure the pad group control registers?
>>>>>
>>>>> The issue is that some bits (DDR_SEL and ODT) in the individual
>>>>> RGMII pad control registers are read-only. To tweak those parameters
>>>>> (signal voltage and termination resistors) one need to write to the
>>>>> pad group control registers for the whole RGMII pad group. Namely
>>>>> IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE_RGMII and
>>>>> IOMUXC_SW_PAD_CTL_GRP_RGMII_TERM. The group registers in general
>>>>> are not accessible from the list in arch/arm/boot/dts/imx6dl-pinfunc.h.
>>>>>
>>>>> I could not find any other way to change the group registers than
>>>>> hacking-in some lines into the imx6q_init_machine(void) function in
>>>>> arch/arm/mach-imx/mach-imx6q.c source. As I work towards upstreaming
>>>>> my board this should be done from my device tree or solved in some
>>>>> universal way.
>>>>>
>>>>> Any hints will be much appreciated.
>>>>> Michal
>>>>
>>>> I figured out this is more "pinctrl-imx.c" than "device-tree" related
>>>> so I am kindly adding maintainers of that file in hope somebody will
>>>> shed some light to it.
>>>>
>>>> I am diving deeper into the code and it seems there really is no
>>>> generic option to set the i.MX6 pad group control registers from device
>>>> tree. Or am I looking at the problem from a wrong angle?
>>>
>>> Yes, there's a few special pad group ctrl registers (e.g. DRAM and RGMII
>>> for mx6q) which are not added In the pinctrl driver support.
> 
> Hi Andy and Dong! Thank you very much for your comments.
> 
> I still have quite limited knowledge about the pinctrl driver and related
> things but AFAIK it is not like that few pad group ctrl registers are not
> supported. I do not see any support for group control registers at all.
> And not only for the imx6q but for all the SoC variants and other SoCs as
> well. Am I right?
> 
>>>> How should we deal with boards that need to configure some pad
>>>> characteristics available only through the pad group control registers?
>>>
>>> Andy,
>>> How do we handle it internally?
>> No, we don't handle the pin.
>> I remembered IC owner said It seems only RGMII 2.5v need to handle the pin.
> 
> That is our case. I need to use 2.5V signaling at the RGMII for
> the connected QCA8334 switch. And also to set the terminators accordingly.
> 
>>> There're probably two ways to do it:
>>> 1) handle it in fec driver by parsing a specific property
>>> 2) Add a new pad group into pinctrl driver support e.g.
>>> MX6Q_PAD_CTL_GRP_RGMII_TERM
>>> MX6Q_PAD_CTL_GRP_DDR_TYPE_RGMII
>>>
>>> I may prefer to 2).
> 
> No.1 is similar to what I am doing now. I have a DT node with custom
> compatible string and a reg property. Then I look for that compatible from
> imx6q_enet_init() using syscon_regmap_lookup_by_compatible("fsl,imx6-rgmii-ddrtype-gpr");
> I do not see a chance that something like this could be accepted upstream.
> 
> No.2 is much more complex. IMHO it is not about adding support for a new
> pad group. It is about adding support for pad group control registers from
> scratch.
> 
> I do not mind working on a proper solution. Though as I mentioned I am
> still not very experienced in kernel internals/APIs so I will appreciate
> some guidance along the way. It should not be as complex as
> handling pin muxing and all the related things though.
> 
> What I see as a potential problem is conflict of the usage of the "pin group"
> term. Now "pin group" is used in pinctrl core and refers to a DT node.
> That node associates any pins that are needed for a given functionality.
> Those pins can actually be wired to totally different IP blocks of the SoC.
> 
> Whereas the pad group control register typically associates and controls
> pins that are common to one IP block.
> 
> So the question is how complex such implementation should be?
> How should the binding look like?
> What is the proper place to parse the DT and write the registers?
> What SoCs should be supported?
> 
> Se bellow my very preliminary proposal how this may look like.
> It is meant more like a background for further discussion.
> I am really not sure if this should be strictly solved at the imx-pinctrl
> level or if this overlaps into the pinctrl core.
> 
> Thanks a lot for any additional comments,
> Michal
>

Ping. Any feedback would be very much welcomed!
Michal
  
> diff --git a/arch/arm/boot/dts/imx6dl-pinfunc.h b/arch/arm/boot/dts/imx6dl-pinfunc.h
> index 37e430a..eeac9e3 100644
> --- a/arch/arm/boot/dts/imx6dl-pinfunc.h
> +++ b/arch/arm/boot/dts/imx6dl-pinfunc.h
> @@ -1089,4 +1089,24 @@
>   #define MX6QDL_PAD_SD4_DAT7__UART2_RX_DATA          0x35c 0x744 0x904 0x2 0x7
>   #define MX6QDL_PAD_SD4_DAT7__GPIO2_IO15             0x35c 0x744 0x000 0x5 0x0
> 
> +/* Pad group control registers */
> +#define MX6QDL_PAD_CTL_GRP_B7DS           0x748
> +#define MX6QDL_PAD_CTL_GRP_ADDDS          0x74c
> +#define MX6QDL_PAD_CTL_GRP_DDRMODE_CTL    0x750
> +#define MX6QDL_PAD_CTL_GRP_DDRPKE         0x754
> +#define MX6QDL_PAD_CTL_GRP_DDRPK          0x758
> +#define MX6QDL_PAD_CTL_GRP_DDRHYS         0x75c
> +#define MX6QDL_PAD_CTL_GRP_DDRMODE        0x760
> +#define MX6QDL_PAD_CTL_GRP_B0DS           0x764
> +#define MX6QDL_PAD_CTL_GRP_DDR_TYPE_RGMII 0x768
> +#define MX6QDL_PAD_CTL_GRP_CTLDS          0x76c
> +#define MX6QDL_PAD_CTL_GRP_B1DS           0x770
> +#define MX6QDL_PAD_CTL_GRP_DDR_TYPE       0x774
> +#define MX6QDL_PAD_CTL_GRP_B2DS           0x778
> +#define MX6QDL_PAD_CTL_GRP_B3DS           0x77c
> +#define MX6QDL_PAD_CTL_GRP_B4DS           0x780
> +#define MX6QDL_PAD_CTL_GRP_B5DS           0x784
> +#define MX6QDL_PAD_CTL_GRP_RGMII_TERM     0x788
> +#define MX6QDL_PAD_CTL_GRP_B6DS           0x78c
> +
>   #endif /* __DTS_IMX6DL_PINFUNC_H */
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 15744ad..3e9d1ba 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -467,6 +467,11 @@
>                   MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL    0x1b030
>                   MX6QDL_PAD_GPIO_16__ENET_REF_CLK    0x4001b0a8
>               >;
> +
> +            fsl,pin-groups = <
> +                MX6QDL_PAD_CTL_GRP_RGMII_TERM           0xC0000
> +                MX6QDL_PAD_CTL_GRP_DDR_TYPE_RGMII       0x100
> +            >;
>           };
> 
>           pinctrl_gpio_keys: gpio_keysgrp {
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 1c6bb15..3c42917 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -235,6 +235,8 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
>           }
>       }
> 
> +    /* TODO write the pad group control registers here? */
> +
>       return 0;
>   }
> 
> @@ -421,6 +423,7 @@ static const struct pinconf_ops imx_pinconf_ops = {
>    *     <mux_conf_reg input_reg mux_mode input_val>
>    */
>   #define FSL_PIN_SIZE 24
> +#define FSL_PIN_GRP_SIZE 8
>   #define FSL_PIN_SHARE_SIZE 20
> 
>   static int imx_pinctrl_parse_groups(struct device_node *np,
> @@ -430,6 +433,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
>   {
>       const struct imx_pinctrl_soc_info *info = ipctl->info;
>       int size, pin_size;
> +    int pin_grp_size = FSL_PIN_GRP_SIZE;
>       const __be32 *list;
>       int i;
>       u32 config;
> @@ -531,6 +539,22 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
>                   pin->mux_mode, pin->config);
>       }
> 
> +    /* parse the pad control group register configuration */
> +    list = of_get_property(np, "fsl,pin-groups", &size);
> +
> +    /* this binding is optional so stop here if it is not used */
> +    if (!list)
> +        goto out;
> +
> +    /* we do not check return since it's safe node passed down */
> +    if (!size || size % pin_grp_size) {
> +        dev_err(ipctl->dev, "Invalid fsl,pin-groups property in node %pOF\n", np);
> +        return -EINVAL;
> +    }
> +
> +    /* TODO Parse the pad group register IDs and its configuration values */
> +
> +out:
>       return 0;
>   }
> -- 
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

