Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD4DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2356C23F3E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="a5KMNFAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2356C23F3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932272AbeF2ENo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 00:13:44 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:47168
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752226AbeF2ENl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 00:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EARjHnn42uOQ76SnwLEY7WEiTTFKEYh5id6GZgXIGk=;
 b=a5KMNFAs4wCfyvSBLsOvt+niUCfr5zf+zfNMfXHp/kUtEKJVbFCbCSh1X/tzLD7PbZdgG+sLC6CVn2HYpdyjbn8eEzNilZLgtD5eHkW9TEmRz3UapGzunMO9VwljzP2wduBVh3IAZSNuaxk3RhUIKMAHruYcVqwDqdfdKP62oIU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.114.68] (91.133.71.105) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.21; Fri, 29 Jun
 2018 04:13:36 +0000
Date:   Fri, 29 Jun 2018 06:13:31 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/6] Add Actions Semi S900 I2C support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
CC:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
From:   Peter Rosin <peda@axentia.se>
Message-ID: <76F2EEF1-A266-4E05-8C72-74492928A531@axentia.se>
X-Originating-IP: [91.133.71.105]
X-ClientProxiedBy: DB6PR07CA0014.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::24) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00f4c2b5-f71c-482b-4497-08d5dd76b026
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:9MD8TGKwa62+oYbR8815NIb/xTh7xSU8iBVL3c+7APJ+/9If0VSS5jtIM7EnofBFqw1I/T8W6pgCU9IcFuxGnQyEdtd5hlOtnyT2t6Xwia3uHGwOQ8i+NHZ1qUMb8vbnkYXlF0D3H3BFw97Gxr8IsbmeOZbNHjgcuWDQAipPg5pnD3F2GQdHKeeRLXRVTa1KT1xwi/hHhsRMwaynYcujca9KmEzo7zj7RI/ZE8tu4YO5piJfG5Lt3io+4kmRuz/g;25:8DiasJmqIdmYetMrB04nyUYnTtnQ+LfZM7EBScYwhqmkil9rNr/m6w0P7QLMXuW7z3jpaxsM183++WmWvJbbYCy7lPVlNUdX7K8I8pYqAQ3R8Nws7SwfiFId2yYfU1izZ/IwOSpTpbC8kUIa3qBE1oKYQ/PqYVfcW2QD/pRISfJhjKu6/IURM7VOkgUCP4Z20nUwap3L1gqJ1sHRWLbgorNUOLamnkDATsC7YOnfPvcq2A/YXyMa+tVT9KzSvTTLEYJc3J2Bz3gcNkTK08mqvrtxwqex9v3C9jV81HxbNEUkMmU7smenGD1vqOwyFsMJYfMIxAaYuMihFmHladv9FA==;31:OzqepxQshn3vX/GgmRhvjtRDZFKakn7zgZZybfi/RaJDF1kmkrUKlFjbS1gNofNgo/pmZ3B0fTneIUzGMjoXEU7ZD3pDBjqpFfSeL7GYk7Ig5BWiDcpNMmZ1z9M2QeMdwrwhqmLuVByPA560fp7bRI6npftF4VLzUbilZuokwxAY5Ei9K5kaxX0C2Ub5HkXApgGGUa7xUVzrGO/wP4Frahir2Y55MS4QCvQxaE+oULc=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24494E91D3235F9C9F2718E3BC4E0@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:Virg0dw+ZmvQkjX2r2oVv25C3r2W0Pbx6e5eW4Eurj7Y1CIBM85W8Os65PZsATalIuAZ62teCTmCRiZ0znvOtbc4mD4cnl9jSHoHHBKncLZB0mA2x2OJsSEsu+rxFv9uTyJcbq29iIwFE/HRO+shHDyVkj/zV3LmVIOIkSrZLQIFu71bjB7gUWPbXC6sqB8yDMqiHo10M2ZMYLy8pMMiq2pom/5F88Zjv7EStO9uRD5ugdCut3akKmhLXeisiXK9+Lp9qP1b5PBkiJI0tQbjCA==
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(136003)(376002)(39830400003)(396003)(346002)(366004)(189003)(199004)(82746002)(16526019)(74482002)(186003)(229853002)(486006)(4326008)(386003)(26005)(33656002)(66066001)(77096007)(11346002)(47776003)(68736007)(52146003)(6246003)(52116002)(6486002)(446003)(2486003)(8746002)(23676004)(39060400002)(2616005)(53936002)(476003)(956004)(76176011)(7736002)(50466002)(81156014)(58126008)(97736004)(36756003)(5660300001)(6666003)(7416002)(25786009)(16576012)(117156002)(2906002)(105586002)(316002)(86362001)(83716003)(106356001)(305945005)(81166006)(8936002)(8676002)(6116002)(3846002)(478600001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:[192.168.114.68];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NDk7MjM6aUdCWHUvQXFpcGducHhQaytiWURXeFdN?=
 =?utf-8?B?bGlBU1FyV2V0U1NBWmphd0U2amVaN2l1WGQ1eUNRenJGWkpuSURUS2o3ckRG?=
 =?utf-8?B?TlVLSC9Ka003VzFvaVFCSGE2V0hoZStzTXRyNjhYK0gva0ZISkUvcmdKYW9x?=
 =?utf-8?B?djhMY3lQS05icnRnQ2Q5cFZTUUt5V1BaUmhpZFVoSFI3czU2clNzTkkxUjFQ?=
 =?utf-8?B?dE5tQVk3cHlJbkIxT2FjbW4vSGxEQlF0b3NJQmxVS21hWTExZkg4ZGdtSWNn?=
 =?utf-8?B?N1dsSGhHKzZoblhvSnMxRVhSb3QxeGJHd3ErTCtDTEJtdmpFaG5IdVNKUEM2?=
 =?utf-8?B?Tjd2N01sSUNzOFU3aHE1Qks1SjBWd2ZBSkFobFkxNkJXc3Q4dUhsbUVMRkw5?=
 =?utf-8?B?aHR4MzNKcGhwYi9NWkFnRmFERFhkV2g4N0dmTDVrbUVNSUtRU2NrSDR0dE5T?=
 =?utf-8?B?eVdyUXg4NTRTem1HdkpDSkFvQ2dLMU16VHdHenZPdytFNVRBdFplWUFZaE9P?=
 =?utf-8?B?ZnBmU3lWT0VSSUFhdjBWam9SREorZE9RTmh0eXpkR2lLcEVJb0laVmJvQ0tl?=
 =?utf-8?B?b2dsWCtONEF6TTY3UVFrWTZNS01yOThGdWFzKzFHRzgvOUpJQmJ6dm1uUzFL?=
 =?utf-8?B?cDRlaWpQR2tQaHkxYTQ2dFdoRFN3QkxtYVVkVE5IeExlMnhaeEdyMnVYV3Zh?=
 =?utf-8?B?MVk5UEcyWHhtNGtndmV0UFJ1bk5VZC9UTzJkei9hUzhQMjEwYnM0bnJVeEVB?=
 =?utf-8?B?WElEQWZaWkZ6Q1ZJR3VUNGMwRHQzeXJyT0FMeWVvaVZ6bGNzRFFrdG1Hek9Z?=
 =?utf-8?B?ODA1ejZXSW1lT3pzSzVlMTBTZlJsZTZJQWtnVnZtWEt5Ti82MDgyZTM2aGdN?=
 =?utf-8?B?NmhEVlZUR1I2eExuZzBsbXhZK1VKQXRWQThUaDJVWXBwQ29HNld4SXZmczdY?=
 =?utf-8?B?MHdJdUN0ek1wc3VObVdZL1FGdmpzeHBnN1h0RDVpMkZkWER6RDhPeGdmN3NO?=
 =?utf-8?B?M3YrS0Qxc2dIQmYxZnlhSng1blhFWkRLWlkremZ5REQwTjliZklQVDNpQVc3?=
 =?utf-8?B?UHE2NUVvaXRhWnpsZlhlTFlweXdGZW91cUM4ZXZyekRpS2xJU01DQys2ZHJV?=
 =?utf-8?B?QmxnUWZhNGo4VTg3ZTU4eXJsaWZDYzFJVEJlNk1NTm5ZZHVERzVxWmJMWk1S?=
 =?utf-8?B?S0tIS3VIaW1wQURRakVPVzNBZUx3czk4TUU3c1FEU0hnakdFLzJTVDRtSmw2?=
 =?utf-8?B?SGpRYUphL3NITE9EcjNsYUtGd3BiSGRjK2piTGNjbnRKb1Y2c0plNEVUakZs?=
 =?utf-8?B?Z21GWHptTEwyRWhPU1FCQWgxank1enh2VHJ0SWdwSzZJNGYyQVRGQVVsY3FG?=
 =?utf-8?B?TkJNb1FZUGNocFJ3dUdOVEhmdmdwOUFXS04zVmNiT3MxNW5UNjNIbFh2TVdE?=
 =?utf-8?B?cVN5UmdaMk5zLzdQNGhMM3lrMmo5dkY2clYwaVZjRkFIYk5CdlplSm01ZVFM?=
 =?utf-8?B?cXhYdHdBbkFHejZSeGd4QzU2SW01WVU5QU1aSWRIbEMxRVhnNG5pVGQ4elN4?=
 =?utf-8?B?elgwSkwxMTNSR1FQMHlYaWhaWmw0N3YvSmJ2NmxFMU56c1AxYWllZHhGUlhj?=
 =?utf-8?B?MHZSL2t1Sy90NUF6dTZhc2lnOVF4L2JsS0dsVThaRHBLMnhuam5MaVV4Um9E?=
 =?utf-8?B?eE43d2RTSGlJTHdBMVBjM1F1cTJSQktnL05qNjRiN1FORjd2NFRkR203bXdu?=
 =?utf-8?B?YktOdmFaUXZiSnpoSXpuN1h0cldMeTRxL3d3L1Q1Q2xwTWlCdjRiMWdBTEJt?=
 =?utf-8?B?OVVDdndDTW1yMHZPU2VhdXk2NWNLMGVZZlNQZ2tVc3RTUDJTUXZHdGJnVUd6?=
 =?utf-8?B?SjFURnRGZXc5OHF6K3oreTlWaWVoNjI0M0pMNHZEMmhpc1dRcDVKcnlROG1D?=
 =?utf-8?B?Q2puZkw5emtwWHpPL3lrZ2V0SXFSend5bFh6UWlKRFBnbzhtNXpiOGptZGR5?=
 =?utf-8?B?cE51UWpxRVQvTEJRZm1PKzJ0SXlaNHpoUnc3L3lCS1ZKblJDdUNqQ1BnaXNt?=
 =?utf-8?Q?8YWV8Y=3D?=
X-Microsoft-Antispam-Message-Info: 2bZoH21VVVMPCNOoQG/BJ7IMweSrDBx071We+aNJOWMK9NFuMsukcOmUsC7IBOaoN/xO9c3+G0+iThiLJS6JFYzgUVLHhM4LK2BJimF2jLWWOHzqHq3Q1me4wQwK3s+4vU/nXMjnRBdN/Mc9W/+IIeWZfcH1FvvJRSWsFsgZUr9FuJjpSzR0HVjvtvvkhFQ1nyZX2OyyyxqBGXCvg5fnCk9XfaAgNMD7h3qoDF4gNZ1hOS8RishMuNKFjwoVDNH/kc5TO//dzJKLrSZmx5jSWvS41ppFd951ayrorhUGoSSePEnlV3Fzl6GdqFM5TWDHa6TM/rIes0kqTM5X8zvGAdtYo8kxOuPNT/uKYYLVgTM=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:z0e1g4RWMk/Tsdx+Pg1PB2hYROXoSnIKNjPLNF4M543thCXEOMIwgvzyQOfsfkb87J1Ybnvd9eOv4+DaXiuFr+Aywpws4QrcFCDgq4+124fqTrCohdA8dz6e7WKFhTjc9N2nZGwx3akVhKHINAakPa2YA1S4nST39JfJx7Q9mC8e0eMAr6tg0uMq9aqddKM9V3krE5fmes5SGvTyrE4aLd7im4FxFfnBvSU+ULfdv1jtu+BGBpUtmAxJKm4fLblTsgxzSMncAE1QE3YX5GFFEn/YThnpmeZrGWsldaxetD3WRt3RMlZBI1E1l4vpy+/4DI4s7j+dM6+rRWz5JWDNkgZmvQtVNTZjdeYwH2Eb4xKt99BK1fTR++rzGUz2WPw98xs92hhX1vScoUgR+Qm4HV9G9SALDpqtUwD1eoDAWtlSPtVn0i/XSqhqvMwawT8QJ6xixz3oa0vW/BAI0P6+ng==;5:YCpnym5PCIkeY251V76l0mmKz+++p/p1+MLXyLt8IlvcFEiDQAdJoElQFWnGvkgz41UXO9Yk7o/14fPz7xLs9tG0S6uxsZ9DPH8KCS/JfHwiFAAXqUjGtxgluuxQoClaA5ZvWC5O46fZSMw/HwTdFJ4FMAFurmsJiyBdxpL39jI=;24:qqHH4wKXYYt+9dUwTVGIoUNgmbWzOVdj1F2J6dcjSMcgXgANTEeWaAf6ZF2NfPsQf7hOW0Y1Fu3Qq0ZvmcUs2iHF0RaHfAYK1k7vZkM/Wxo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;7:+yFNUIDU01ITqnUZQ3zrFtIKCnf79LqdnS7xS+SgT3u1BMs+eVpEyD9PTDGPFInomOSkyWXCqHOlydGPlGqa5DPzF/ZzvEl30iUt/GT2T/cwyISznVUv/bqV0ksaz92JYN9vUD67Nml0DfN2qapCiK92orzivL0W+M6U/+ZBPpVSxjfI+LJ87lCzAeIpZII5i8GoiwuZ1iRskq28ZPTWgQHP0PCjERytOclmkhWrt8GnYRqrHGsuBmJMOy7IRW3m
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 04:13:36.9676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f4c2b5-f71c-482b-4497-08d5dd76b026
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 28, 2018 8:10:36 PM GMT+02:00, Manivannan Sadhasivam <manivannan=2E=
sadhasivam@linaro=2Eorg> wrote:
>This patchset adds I2C controller support for Actions Semi S900 SoC=2E
>This driver has been structured in a way such that there will be only
>one controller driver for the whole OWL family series (S500, S700 and
>S900 SoCs)=2E
>
>There are 6 I2C controllers with separate memory mapped register space=2E
>The I2C controller can handle atmost two messages concatenated by a
>repeated start via its internal address feature=2E Hence the driver
>uses this feature for messages of length greater than 1=2E In those
>cases,
>the first message of the combined message should be a `write` with
>maximum
>message length 6 and the second message's maximum length should be 240
>bytes=2E
>
>As far as the bus speed is concerned, this driver only supports
>Standard (100KHz) and High speed (400KHz) for now=2E
>
>The pinctrl definitions are only available for I2C0, I2C1 and I2C2=2E
>With the mux option available only for I2C0=2E
>
>For Bubblegum-96 board utilizing the S900 SoC, only I2C1 and I2C2 which
>are exposed on the Low speed expansion connector are enabled=2E
>
>Thanks,
>Mani
>
>Changes in v2:
>
>As per Andy's review:
>* Modified infinite loops to fixed number of retries
>* Used i2c_8bit_addr_from_msg for constructing the slave address
>* Removed unnecessary parenthesis around defines
>* Modified certain dev_warn to dev_dbg
>* Modified the error handling to more generic pattern
>
>* Fixed the return value in owl_i2c_master_xfer
>* Added MAINTAINERS patch for I2C driver and its binding
>
>Manivannan Sadhasivam (6):
>  dt-bindings: i2c: Add binding for Actions Semi OWL I2C controller
>  arm64: dts: actions: Add Actions Semi S900 I2C controller nodes
>  arm64: dts: actions: Add pinctrl definition for S900 I2C controller
>  arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
>  i2c: Add Actions Semi OWL family S900 I2C driver
>  MAINTAINERS: Add entry for Actions Semi OWL I2C driver
>
> =2E=2E=2E/devicetree/bindings/i2c/i2c-owl=2Etxt       |  27 +
> MAINTAINERS                                   |   2 +
> =2E=2E=2E/dts/actions/s900-bubblegum-96-pins=2Edtsi   |  29 ++
> =2E=2E=2E/boot/dts/actions/s900-bubblegum-96=2Edts    |  11 +
> arch/arm64/boot/dts/actions/s900=2Edtsi         |  60 +++
> drivers/i2c/busses/Kconfig                    |   7 +
> drivers/i2c/busses/Makefile                   |   1 +
> drivers/i2c/busses/i2c-owl=2Ec                  | 471 ++++++++++++++++++
> 8 files changed, 608 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl=2Etxt
>create mode 100644
>arch/arm64/boot/dts/actions/s900-bubblegum-96-pins=2Edtsi
> create mode 100644 drivers/i2c/busses/i2c-owl=2Ec

Hi!

I don't know for sure, but over here the arch/arm64/boot/dts/actions folde=
r has no pinctrl nodes at all (v4=2E18-rc2)=2E So, what is this series base=
d on? The reason I started looking was that patch 2 *appears* to depend on =
patch 3, and I just wanted to double check that=2E=2E=2E

Cheers,
Peter
