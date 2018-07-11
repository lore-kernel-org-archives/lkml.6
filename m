Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F50EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0446A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r90D4Bg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0446A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbeGKM0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:26:08 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:49408
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733144AbeGKM0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tipoHmYMll4rsGebyAlnGAzrdnjkdX02yhdqXmGLkfI=;
 b=r90D4Bg5J+l191XfSCrG6Hz0C/ihEXb/FwEL5kwtKKnlmQiYEo2LjfZnI9m/JAFXXSTEU+1G5sqvJzBeIpehE5Qo3+vzImFgreDMIaQL15Gfa4K2c3j2W3eBuTJGYicBa2mD4Aq1Uc7S4MvEO5Qn1AYZvWx4XWRVJxA2nb6OfNY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from fsr-ub1664-115 (95.76.156.53) by
 DB7PR04MB4300.eurprd04.prod.outlook.com (2603:10a6:5:28::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 11 Jul 2018 12:21:58 +0000
Message-ID: <1cc67fd7d1214f93f7ace6f0c2a46303f79a828e.camel@nxp.com>
Subject: Re: [PATCH v3 1/2] soc: imx: gpc: Disable 6sl display power gating
 for ERR006287
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Date:   Wed, 11 Jul 2018 15:21:55 +0300
In-Reply-To: <1531311392.3163.47.camel@pengutronix.de>
References: <cover.1531310547.git.leonard.crestez@nxp.com>
         <d694bc32feb1c9638485700ba53cd6e51bea495c.1531310547.git.leonard.crestez@nxp.com>
         <1531311392.3163.47.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR02CA0035.eurprd02.prod.outlook.com
 (2603:10a6:6:15::48) To DB7PR04MB4300.eurprd04.prod.outlook.com
 (2603:10a6:5:28::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68ee09ce-4d8b-4a21-0b1a-08d5e728e664
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4300;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4300;3:doW3e34gktkHhvRDaYEoxXi2Z+gbpvBI0ujyGVGCtUzlseIgW9nHhjUXDozEN23+kLpZH47FaD5FpYpJ9SKB3fF+QbSZ7W9n/5uH8Rzj8NZlLcmXrQZfHwGDVjLc21Mo1xTN74UEKiu6SYmblSnUCTQOvp8Zq6plGeKfXUBUQ3CZryL0BEqYbC5K4/XM61uzrK8XjBItvHliJp4WeJ1/yxAjdR1ONOaKotULxjgcoOOwVH8UWx7+T/h8MiLaBoOq;25:GNh0V9KT3UJKsZM51tu0dI5Sq32MZRLqiWmyKGpyJ1kz1I/5TZZ3+4LVKTv5PdpVv1QKcObgt0OxXtbDnYAbZ1d5/eSlIrrHjNs0kxPOD7mdfJ8K8nU33RBhGvU1r/fk8NaZPzU5/RhUH3EzEh3aKUzDb5E3QEQOWG2hC7o/LjT+mbBxocjpNGJ/ioAWHPM8fNqvlwTEKPcUv5IeVypjzpTz5CIlWt07e5HM0Uo0yiLTB60u1+JOqKgQrd/4V86rIr6gNaIHG3f2e7fdnM41Bf9rXD3ofL0VvUOWkynfq6KLEmXLTnZ+0jM63cEQVAWdpxzWvSugrK4M0OX7SOpY4g==;31:3KT/mX6KGxtEeG5q6w11/1tUwNvjd1J6tK3huc9WBQOzY83ml0JiSUNDec5z9PspU+VJ41auwYeDfyHXivQBfoZTnDAcUXt1QCQ76qI4EfpYgd3ZLziWb5K1RnXD9593NvCGJQ2ajGeEWENEs7dqgiuC8jLoNjW+Wx8jKSCL+8zh8EAIEklbXQnXxu93C9mXDXfq8zuYPIblFfHKumyuQTvtsuJ6i3n0vlGtZ58OM/A=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4300:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4300;20:y+sJ2GBmvEPbqzbIQKAKgmJPuRQAqjkuyEJTZJcwITJd29teGPuSONKkfUdi27CUa5j66MO8Q/qdwz999BaH161frQKOOovnQluSZRqg3IgQTx6nVGEgfEYDY1UtZeQFqGxdw7XxRCml7mFmmK8J8FU5Xj867ZiNG+TPW5AMrMMvMxQrBPhUcA0w/9PHdk2z3RCLC0p0glZa6lpG4H82XNYcBump3TEiwDRQz9/SdI/714nqniLVKfqPFyAHOB4P/govpzM3hKlbxx6WCp1BVVJOnAxiRzFmokAeZhd73LSaJekenOdbvAiFVZh/URRnONI+LXz94cB6rocEFqTM8fX/zHWDxHJv53rMC9VV/GyiIvMm0iyIafQU3qok8NzmSI5U87Bf3sP3RcsaY+L9f2w8BEwkiVWVbBUC9ZTaA2r5dse8GVloxKS258WDm5/Hr3kpLnOMNq0dABXilvzaZPXpHc4vGMZQDdXUptYRyYNDl+YTrUhZyTiUFBu8Or/p;4:fX7Tsi0oKlLeJUDYHMo5s6m0pxHX7Hkyxhq18Bo6dh4V7hqYE47sFOhx+ZjWJUiemGRfpii6ZwlB+x9UvepZCmNcn+WYkk+N+59q+r//BDctG4QcHMkYyEZvr7tvFXgtw8SSQKOUVnwJypYxbFZneo1ho1jIoE2acpI2TnpsgnuUXIs+Wz6xwwA17nrJ9R5J8qun+4wvoOEr8cWp7xrRdvzjBb/pI21uVakWzb2c90MAaOtzfTTuc9WHO0QvzZ2P7N1N6Xb9mjqAAElyGJecLgMgi43uxyz0Fsgj9ZrYZJxcjr+K+zru75aM5YTlNYUW
X-Microsoft-Antispam-PRVS: <DB7PR04MB4300F48E61835A024E86988CEE5A0@DB7PR04MB4300.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4300;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4300;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(50226002)(106356001)(105586002)(230700001)(26005)(186003)(16526019)(5660300001)(68736007)(14444005)(8936002)(50466002)(316002)(86362001)(478600001)(2616005)(956004)(476003)(118296001)(11346002)(110136005)(6246003)(7736002)(6666003)(97736004)(486006)(446003)(2906002)(53936002)(6486002)(44832011)(66066001)(229853002)(76176011)(8676002)(81166006)(386003)(23676004)(52116002)(6496006)(36756003)(5820100001)(81156014)(305945005)(25786009)(6116002)(3846002)(47776003)(4326008)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4300;H:fsr-ub1664-115;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI0MzAwOzIzOk9JZEI2eGN2REswYklheE1seHE3RCtOSmRJ?=
 =?utf-8?B?Z1E2a21NL1g4Q2M5bzdmdW5zU2lINGgrNDU2K3FiM1Z0K1U1dG0rMW91dSt2?=
 =?utf-8?B?NVlPZ25QdlpoZlRmQXdGVU9WM0ExMXl2WWZZOWJ1N3U3QnVBOHh4OXlEUVBE?=
 =?utf-8?B?djJTSHR3cyt4SUVENUtpTkJ2Qm15VW5wMld4eFNkVEUzcy8zZ1pCVTczL1pj?=
 =?utf-8?B?KzgzZFgwMmJFaEt3UzhlWmI5SjB1TEtEd0x1dTN1VzZKRFdlQWpSOCtvNkFS?=
 =?utf-8?B?MmgrV2ErVWUrQWtQMnNxOVEwQ3Vjdm9HSVZnTmNMZFNHZFVGa0xSbmUvaldw?=
 =?utf-8?B?TWQvR0tKNzJVdExreXBqK1VtVTJ6bUNpK2JtUDNtMzF2Q3VjNGdGZ0tDMm5a?=
 =?utf-8?B?L0lMRktOMGZlWm1NZTVlNzB1UHhGTkpPOVZ4R3BGblRZOTB0ZW5id3BpVm9G?=
 =?utf-8?B?L3JSanFlZTQ2RDIveG9KcTJBOUk2RnhVdWlqaDA4NStpYlAxVXNPS0NpcTFq?=
 =?utf-8?B?UEZudWFYb2RrRWliSStQYnI4NVJ0RExSalE4cTFGV0UwRkFncHNlMkliNzBY?=
 =?utf-8?B?RE4zUGhqWGpIdWtLMUlTTDNEZGpUUVdYdFZsckorTDU1OFROaWMxaVUrR09o?=
 =?utf-8?B?U0pNT21ZamYvRTRocTgvaW5qLzNWdW1oV25uaGo5TUhaUnZLbTdzK1hJa0tz?=
 =?utf-8?B?WVIyNEtmSGZNdTQ2Vk5LWHlVYVAyWE9aN1lGdHNMTkIvLzZIdGk2a3pFYjNI?=
 =?utf-8?B?aWgrUml4aXA2cUJtTkRqaWpBbFUwNElQd2dSalpNb0RLcjhpcHQ1WTJkT01Z?=
 =?utf-8?B?cjNxenVzVlJnL0x6L2wyYmJQcFB4NC83YmhHTTJHZHZaSVhrL0E1UHM1ZEtG?=
 =?utf-8?B?b2d1NHdPY3NDS1YzODA4UHJ6cmQ5ZkdEekdrR2FGOEMzazhIaGNyY2I0T1RK?=
 =?utf-8?B?aG81QmowWG53b3d2U1o1UlBMdGZJdWkwZjdZTFpvVHRJZU9vU3QyRTFmbG9V?=
 =?utf-8?B?TXoyWXg4V25ReDJrbHo3eTYxSHEvNGgrYVlsNk43RUNmUE84dmcxdEVBU3Vr?=
 =?utf-8?B?S0JGL0xWNXB1QytNL2l1UzFtZUsxQlN4V0JGdHorbkJsTVNFYndKTnpZS0Np?=
 =?utf-8?B?Q0hXL0ZLUzdreGM4YmdZcEJlKzZTQWRqS0tsa1dHRWtTd095NFhmdzBYYVZT?=
 =?utf-8?B?cnhFQVZDR3VVZ1kzTFovU1lwWTc0ZmJVY1NXbW9CWll5Y01RSWY4dklodUcy?=
 =?utf-8?B?Z2tVbGcycVd6eXNDZmd6OWlFaEN1TmNxOEQwMzJwYkY0S0NHTnVzQWMyRTRq?=
 =?utf-8?B?T2oxREVyTEozL0tYODNCVmNvRStpUzJuOC9sMFlldTdoRlZXTVBjUFk5SVFM?=
 =?utf-8?B?eE9HV0QxUm1pMk83ZENPUzhZd0pFSmFKSnJRNHRmL0p2VDBZQ25KNWhtM05H?=
 =?utf-8?B?a0ZBdXFUajNUcTRGRnRncnhCaDNObXR6c3JHaGdiNWN5N2xENzVRWnR0TXhS?=
 =?utf-8?B?V2hTeUFISDA4Y3QvZ1FGSzZXU0lIcE9IcFdPbVZVa000akQzVXFXOFRTZ2pR?=
 =?utf-8?B?Wkovazg0dVNEMjV0OVBRM2VrVWZuNHE1ZFRGK1dVLzFtUE0rRXJ1Yjc3Rld0?=
 =?utf-8?B?bXZycHVSYTdUU2pzc05IS2hJZzA5ZXNDME9iaW1YMHFnQU5KbUNOcjBVVit0?=
 =?utf-8?B?ZkluM2o3NFdWNEY3cTFkNFRrNmZTdm9jdlI3UUxLV1pIR0VlNzhvNkE1cnRp?=
 =?utf-8?B?T0JiZDdRdzJTa3FCRjF1UT09?=
X-Microsoft-Antispam-Message-Info: m3yiYHaS++L4QAfYfyqwT37X+U5j0wN6JnsQgriy/Z8dSnv3ln3yC3ANYdVQO9c831Cj2sRQG/VeUageEdOMlKqiqfHDU5F+fXY60QbOc+xeC9SXj1F4jQ7R5hBceN2HI8edG51vOArMZOOqCIsA0fkdAy2e6/IdlsqOOUvn364ifNsaxIKUZugdie2VICp7LV2+JAZdnyg0yQl94xy6aAzpsGdDdNdNPQn6kjpi4Gw2NqYujIfw3kW83ONnU+2eQXxGAyPwSfkQnHDQRuR7ORY33h5LUbMl3a2LNE6Nz+6eAenooars1WJOA4n2SaQwhwX3/FSo5yOuCZithKEHR8sUVkJroUR8qyrOmt9PSVE=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4300;6:YznAJzLKq2TxyWJj/3y14i8591uqwoExZk2nd5y2ga7uqvUpD4Lhxju0X+HbATz7/OoeCfdC4OoV1zu7ellajlKfsMpKz2gdioCTmD3h/8yS6YEUwedxeMygf44/qwvt3Exrks8sbm/K9TOSwDJ78VfBFUJ9P+fxK4Jf7s18so+Ee8X4sRTwQBUNTqgPbc+ujT+A0amvGRXxteVlMeIdf7szcM92qT4C+lv0b8IkGhVgiNlNROLT6hWrcyb2C2xUc5i193SpdSc2Ncn1v0UBQ9/5I8wsyeVuAPSkrn/lwiSBl5U9elNGoVhxw2WeFgWF1OgBIM7/LYjbvYZzDbXbmhk2mvKYNlhJRQn+0R2AOCiwyKnkNpWObvcTzXZwhw7sq2oFLNaI+3OmelKGD2w+1htYVZAulIk+v7DyfjKu6VwnmULcRI0KqeLQ83g6njnjTFX2sEuofksar9F2lI9M2A==;5:R5xViiOGnSPVHnBg2Jb3hqEwVjs7LOxyCKzQV50KkEQE0qPEVCmZPdp5j9fZAiuF/DzOQxkz9Mgs0YG4vyqUw/CEqlv6KnVkBrQvetyMfnC1hTqfc4mzXy+txI+PP0a21ARLt1Y4OxiUVBYI707nDxWbqpgaA7Hxr3CaPCrPdTE=;24:tbpxtqNxuCZTSC/bQctPkxt0p183OWFgZMZs6VozOtFNHH49qIK0bu1zJsoUcy2hEwrAgSnONOPsl71nLWxQPTqJXqlJsDi+zjg8fatG6ik=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4300;7:cQh8b7PU2WzwUiTV0qVzmBpLuor9OieStqBRcbbwFXUApgyhd4Z7V+3KCMefTBGY7GU/lrQi4fsumckHZMmZoEVyayG2GHjvLdeV79juXJ+Z+dMxCkJ8xQqdcOYx8eNn0UibNEFjbQ5xLFzhWrkigvEM41ZrD43OnTGiuwXrPXKBashVjdYVymv6N66Zape1DDlAtj0k0kev67MXSxuv8xm3nikmnh0USjgT90AoWDhyNFFlA9H8DebDwUEGNaan
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 12:21:58.6032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ee09ce-4d8b-4a21-0b1a-08d5e728e664
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4300
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 14:16 +0200, Lucas Stach wrote:
> Am Mittwoch, den 11.07.2018, 15:11 +0300 schrieb Leonard Crestez:
> > Handle this in the safest possible way by keeping the DISP domain
> > always-on.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Can you send a follow on patch to switch the i.MX6QP errata workaround
> to use GENPD_FLAG_ALWAYS_ON and remove the -EBUSY stuff in the power
> down path?

Sure.

I was thinking of converting it to a new GENPD_FLAG which allows
power_off in suspend (as suggested by Ulf) but switching to
GENPD_FLAG_ALWAYS_ON in order to simplify the code could be done first.

The -EBUSY stuff is not very harmful.

--
Regards,
Leonard
