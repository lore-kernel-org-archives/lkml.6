Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C283FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D882084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0jva5AmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D882084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbeGSLQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:16:41 -0400
Received: from mail-eopbgr730052.outbound.protection.outlook.com ([40.107.73.52]:17248
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727032AbeGSLQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOJRBl22ZPACBDo3gznQfoQ9uqi1BNE10UA4nWJVKb4=;
 b=0jva5AmM9c80YygkB9nR5aEiNNG9cWsuGIgaNNd2hazLrdQc/ohB9mTaXG/eIi3MgJ4a0elcwJzTgYnZiWuxlewHeIY981/Y9uhpieFcwkIToG5i+7zfNz/I2iCHytxqD8vTFO/QlYtEKVt/852eh+7PPg+wU/8/N/6aDo6MLno=
Received: from MWHPR0201CA0087.namprd02.prod.outlook.com
 (2603:10b6:301:75::28) by SN1PR02MB1631.namprd02.prod.outlook.com
 (2a01:111:e400:519f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 19 Jul
 2018 10:33:47 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by MWHPR0201CA0087.outlook.office365.com
 (2603:10b6:301:75::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 10:33:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Thu, 19 Jul 2018 10:33:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fg6Fl-0007ko-9g; Thu, 19 Jul 2018 03:33:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fg6Fg-0004bj-6V; Thu, 19 Jul 2018 03:33:40 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6JAXZmE021648;
        Thu, 19 Jul 2018 03:33:35 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fg6Fa-0004Zy-Sl; Thu, 19 Jul 2018 03:33:35 -0700
Subject: Re: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river for
 ZynqMP core
To:     Jolly Shah <jolly.shah@xilinx.com>, <ard.biesheuvel@linaro.org>,
        <mingo@kernel.org>, <gregkh@linuxfoundation.org>,
        <matt@codeblueprint.co.uk>, <sudeep.holla@arm.com>,
        <hkallweit1@gmail.com>, <keescook@chromium.org>,
        <dmitry.torokhov@gmail.com>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2c3aad45-37ce-2446-4b90-bddb477286ed@xilinx.com>
Date:   Thu, 19 Jul 2018 12:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(36756003)(2486003)(316002)(64126003)(36386004)(53546011)(81156014)(2201001)(50466002)(81166006)(9786002)(8676002)(6246003)(8936002)(58126008)(26005)(356003)(76176011)(7416002)(31696002)(54906003)(305945005)(110136005)(23676004)(6666003)(65956001)(476003)(6306002)(39060400002)(186003)(77096007)(65826007)(446003)(229853002)(106002)(63266004)(65806001)(44832011)(11346002)(478600001)(5660300001)(47776003)(106466001)(486006)(426003)(107886003)(336012)(2906002)(4326008)(966005)(126002)(31686004)(2616005)(230700001)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1631;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT032;1:wv1Mkun3ZrqLH9wuUWn9WhepTMOAeZ+iQYlOQ6yED2UajiR4SEKu4YFjDQ+MniZfjesWYyghct+ZvgdC0xJajZgbo+jjMp/izlKxhCbiA/SJMB/fC0yIuPf5wsIrvFe7
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64900ca3-0bd9-4a90-5e5a-08d5ed631b8c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR02MB1631;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1631;3:PqT5OCZco6dhfcpDauiGG7mOSLuWmakfPr64YX2vKt4oStJYeOhLtU8Mag2rde5HEwvoEAWiWvP0OCeH1pq7P3aX7E6ib+zDFvl5khgpCnC9efeVAAxc9OrjcurEk4YvCqScJdB2QeRe4e1J84kMzYuTJ9/TWVNLtbkoBGoKs1W+Jf9tlEfHg7DnRkeByvzOue2K//31xFpm+eKczzM+r6nwU5lzTbKZTFZ07Nn9ecyUlHeoo1GS8Y9oOAK8WvP49w2YMiT17ARR0F8Uy4qYdAryVwat2U2jirYkEbfHW9iupBcYDTvDtUsCIn+KxZAJxsh8RUlEmhy6NFug9P2IOCvoryypmLmkwk7v2viNtq4=;25:nwm/5L532ec0fcduNa0vtAvp8kFN2Vek41eJ7hZB4+0QJNUj6BmRsyIyq1Dyr+RxV9drv6GOb2PgYO90CGC0w0/PFFNUxTds7J80CQZOzRok2JMcYvZwnd0GPkQV1WVDnAK70PItYUkApsQqqHJz8xlLxDfDHGw32opBfwUq/7n6g9yFGbWBAge1iILZVlK8dJzDOyGcb+qS/AnStJmUEF/qBLm9x+JyDdND22/NkNnS0SVnoqHptNg2LoYjSRvGZ7V03VQ7HraGyar8BsZU+eq1XyU/Ig5iOrJJ8sTlxFO5QJgyqDuRCj8LEUZIlUlqWXT9R0AZ3WABGlR8jkj2xFBlpZNtoYqwUDycCh5wRcM=
X-MS-TrafficTypeDiagnostic: SN1PR02MB1631:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1631;31:pxghDFHlMuMINAwlmtnw0EnVBKfA//s/x7gv6m7hrT7civGavlOCaz6P+A7MFlqbqcpB56kqeCCYwTDc68K4GIMXcLoWv3v1ddHl0PW8Ag6BFl8DWQ3FxRRom/KN8NpnGdQUZKbtngNNZdio7xwyqNVMLnbaGhRr5iS5yjT8cfEi/d75CNB2IunBinyFedfeuD3qhAhQk6/T2dNwOGt0sDVIZIQqMBN0+BsnMZkULgY=;20:kDaYsogIuCxssP0kTE9L4zixuyUxQTuQ6cdR5t0yFVREO2Vq4PFyHMB5mG3YkbMSq2HFi1sxKFa22ZxuebBPifZTaEtCxtGOpZEDJ0Vlb0rZjFJWukGL8mvGZkw02nOMJTQsTw95jM+tfv6hn2+10i4Wlijs3i4ehPz244y+F6cilL/GYJYpaM7ih05gyr/7ugv4bBkNh8sWAdjYIRZksgj2dLfpAPNytWmhoySTMLJPd+teDvl9+Yw+xVFgo3z/GmM1pSsTkCgtRdT9L/cj7Nywx+VcDlmm4LJTbsTj6DFhMGfnThRWU/RIHaDO4jsoNk2tN2yknK4CAh6OFTtAtJjX7RCMVIATT064hr/urN2l18gttL3gr0X3+ik8BTtliC7HyxKwxVDiaNEcoZu5hw0JIkX0WDbNsK4pMzl98EtCJ65t1Ds5U/zT1dlTqGPYl5yb9Qz3VyR2b8ODAdEHqYUGls/jKks1SDhSp8DRn7Qlq/+SYt3E+RwvehxXS0Kb
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB1631583B09FFEF3C529DA95BC6520@SN1PR02MB1631.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB1631;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1631;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1631;4:dr7UDn2q+1WAUeWkrhViYrs3q8XVdjQWuXzOwirxr6Abgxi7j5rLX1L1sQpLNmxFNBY2R/qZ+woMdoqLoU5DmYfCf4O3YOOnzLcAbJbwdwEYVh0IVQOkMu9nb340IO1ZPJvEJ9doXHwfecpTNs9hZLZvhcYV6d9cATrO44jtW02H6TwBsMWMx8Lh+c0MeQPAX8qApy213EzgxTV24/w0F3dFtUo1Qc124/lGC8zvGK6oqA5Ut3foIbOec4WezAy7DMxvdIyXezjCuZ8/j+WKz9Ozj38+1uU8lqJkCfkbx3sEEYFflU66kICF6qPaT6bt
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjAyTUIxNjMxOzIzOjhoUHJMZzNIWENJMWFueUM2WGlvQ0NsRVh3?=
 =?utf-8?B?Y0wyMTZUSnZiT0IrRGF2cHVGZ0svVkVxZzJHTWVxL0FTekNUTDVnQ2RXdUlU?=
 =?utf-8?B?M05QdWZsVUVVUGxUbVE2ZlRmNnIwSGxzcjF6VUVpaFJqZFEva1pydmJNbUtT?=
 =?utf-8?B?RmwzY1pEMVpESUVsZkJQRXdBMTFaUDVPTSt6ZklMUkJjbld0ZlJ2RDRFRE9N?=
 =?utf-8?B?aEplMmRNU0tFY2ppaThwUkRIK0VNN1dodjJDTHowMmxEMURQdjZITVNHbHV2?=
 =?utf-8?B?N21QVkZuWU5zQjl4Zk4wbjI4cGk1RHpLcXJEblVLTno5U0dLYUFMcFRPd1lM?=
 =?utf-8?B?SVFkUHdrNGRUenBYbk9NK3ljV3lOamVkNHl0b1V4aks1citIQ0RLSmFGeGE1?=
 =?utf-8?B?UnRMMlJ3VE1rMW9POGFKTTZOQnVlZDJyUlhPTnRsbW1ScDVxODZhamlpdzRM?=
 =?utf-8?B?K01pQlV1bUFxdVhScHFCYVZJcUhnMzUzQVJZYXdWMjhMVHRvNDU4ejlKTGND?=
 =?utf-8?B?V3dMZzRCcVhiM0UvYlpsTnhQejB4RzdVZ1dRcldaR2ZtQ21laU5ndVVzbHEv?=
 =?utf-8?B?bzl2blAzUmQzVUhkYXBsd0J4ak8zYk1wSmdnaGgzT29NSDVHNm5DWklhdlpa?=
 =?utf-8?B?OHlHTFZiMWpzVk1XRjFyQVNZMjI4V2VKRlNoQWpHUC9PVTR1ai92bzgrWmJW?=
 =?utf-8?B?T1RQY3RpdnJKK3ZXR2ZEcXkzWUlSTHZWM0JkRWx1Q3MxVEFIUGdzU3hDa0dt?=
 =?utf-8?B?MEdjTGJTMERGRy81ZFFEQXlpMEpDTDdHUldYMUN6bDZmUnd0UFlXNWFvbkJH?=
 =?utf-8?B?d3FKYm1oWHpZWHE5RGNEeTdUdTJqRGIxSDZvd1I0WEV3Tk52L3VXeVFLcTlj?=
 =?utf-8?B?dUtocWo3aSswblpvODJMcVhIbGF5cW9DQktoNEFZQVYxVUZmNk9nV1hOdGlx?=
 =?utf-8?B?VUJLSzByaC9PYWNMeTdESzlyekJJQTJ5K1JPY1A3UnZCbWQyZTgvdVFSd0xy?=
 =?utf-8?B?Rkc5THl1WW9ZRWdXQnRadTVpa3o5UkpNVjA0NHMxZStFNGt3d2oyQTBuTUhH?=
 =?utf-8?B?TkNpdUs3OTJRVGJ0Q3NaRlAwWlJiNkJ5bms5Z05xV1pxQlorMDBlRUZHZHZG?=
 =?utf-8?B?b0RkZXZyVjRzajdUVHNvdTk1ZkNYdVRUMUlLSUNwNkFBVWpsZldGQmhJZGgv?=
 =?utf-8?B?UzNUN1QwNU5ESXp4c1R2T2gzY2wxTEpTdW9XaU1UM3dMNC80ajBPZ05QQk1i?=
 =?utf-8?B?OXJSM2twL25FQmdjSE5TMnl6amJ4TmYrRzBBLzJvM0hTOEhJTTVsNHZJb3V1?=
 =?utf-8?B?RjZOTjJNNmpzbTNqY0Jxd0xjenhrSHdGNTNZcm85NHh3Q01NN3ZoWjdFQ1p6?=
 =?utf-8?B?R2lGSG1XM05DZTlUYWkwQTBlVnpYY3BxQkNaQmZWLzAzWHVWWnIzeXhBZWJI?=
 =?utf-8?B?R0FxbzZOVStKc0N3NEJCR1VXd1kxaU81cGc2Mkh5eWRvdVRRc1ZGZTJlelZu?=
 =?utf-8?B?SUlCZ25aWVBLRU5GdlB2eG4rSFpweHhnWGpwcjJIQmY5dGk4djFQQkgvZkRH?=
 =?utf-8?B?UGFuRDVlWUQwaUpxdWQyVlhHSDRoSXBvcVRzZUtOMytjN2x3TEd1S0ZaRFpK?=
 =?utf-8?B?OWpBdXA4eGNoZlFZbnc2clluZm9JT1ZMckN5dUloelVVd0tjQWlyWkdtYUJh?=
 =?utf-8?B?K2xIV2tjMG5ZQXcyTmlWSHZhTHNxVWpVNzQzSjN1bmttSGg0cUxXTWhrQTUw?=
 =?utf-8?B?UmhIYmJjUk9UbG9pdEVBRGdybjBpK0NvdU9URm9NZzlNV3hrZHhNL3F1Nmsx?=
 =?utf-8?B?TVJhVk5RWDVBWGM1SVFDQXQ2VDgrclhGeUlqTTN0SW9LNkR2MUlwRnRZRmxZ?=
 =?utf-8?B?ajBRTXpWYTdSN1pmNnlRUG9iRXNXNzFneGs5SFVLQWh5eVNORjdjaE1EeEJy?=
 =?utf-8?Q?Oi0ac3uFZtEUcvB0Z7zyicPt1UtWB8=3D?=
X-Microsoft-Antispam-Message-Info: dqLqJTddDc6CDh9ZCRlAllYy+rjD0Q7rHhj/C86H9Nl4SaaKP92W36DmOtBgCcLuImLU1nbW/TmCRuJnuHEOdn9CTzx+2MIMgNXONw/Ri07/0IjxPONWCh2hUvoVcdTakErc2u2xLbNLnHDEvXVIOSwsiEUGvPTC1kQxaA0oNW1ln7xoSkC+FB+3mxvHcugIux6hrA8luiNzy6blNAfgJdnsqP15gZIegyzFE/On9g20cFLajcTipL6V4Hhzf3hcYR9meBQZ93zg4gL1qP9THnDEc2Zyscf/lOhA59luvuEFK4wBiPzQKi0z2seEWsKt9CnM9eCoSHM2FifLnTmilUOOCs3NXO7/6BRhshiKBew=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1631;6:jCoVgCK9WWT22gIU0Ut9cmBfaB45T0tbsjPFH07udLE79BYnv2yfXql1DsT+JFClSNkY2d+d3Y6Eug8hrkkofmVHlr0N2AfDOPl3z00RK5XQPcCJqJvf8/gYVXbe0KK+l4mJvMEmTVM5wTjSz+BKLFvVhxSTCfbk2dCHWxmFQzUCQuRtnukhl2ZQa2LMcqYVAiCL8Ynx/GFezRNO1TsLhvWhBYbowCoMFbdeBFWfzKgEPa5haozus2K0Fnk224IP5aDGPe6g2ARvlNwteUl9GGN9OvN50E9urU6ESCAWBTEArQUpVyfxoOZDAKUiBQJxItxzMRGt5XyWQzN9ZsaQWhv2IsGD4V4jbOwxtPiY07fr+StUZHmgNKUuuwN0uQExErEEkts5trHLwm4zHKJDO9x+bw7WB1GmuHrNN/CF3XcZiyqa+LTUVUgz+JMkM11nkbW4ogoQJg4BlESEz1yqng==;5:GC58ZuQ6cv+vFgh8wGMxK7SbwIQFFslt2qya7D8eM2Nj/XDjK9BGFBYF0SDETga/IFJ+/XhkayBQeHkaVWYRzuYtTBWdOqO2/QmHzlBrluDKJZ9TwUVTd5Q/hOXg74BFQhJp1XnZlEvfoif7KdV2IQOhyu7zPVYx+YNAnho83kU=;24:EB4kfrFumW6dGY4bjgvsalUA7Zpy+/jnF+d/051R9Y+PV2WuSSaeEc2NmwHQb2cppvW9SjxCq8rnP4QOgw6OUqWC8evpnsBPgrKKbbciRng=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1631;7:TZ/O33uhenWBuafSONpphEzpHqeiDjt/RsrTO8u/kSJD9dSszUVHfwP6ji+AchUUBOGK9cYKD1BDum8OVvsuuKS3wcv++WVmUQnn2WGkS4Eqqv1Ka8QIte0YnkunYHPqEENs6EGPAy+71GHuIKj9f8EWKHY4bhw0nI5z4NWtcAjidPUZVokm6gHGH8x0lHQPOk4+kg7bfc/3jfxFSkdINsyxWmJ384QoVEaY4eT5oDEZ1cMOi4FyEouKlfPLriyr
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:33:46.0022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64900ca3-0bd9-4a90-5e5a-08d5ed631b8c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.7.2018 21:58, Jolly Shah wrote:
> This patchset is adding communication layer with firmware and clock driver who uses 
> those APIs to communicate with PMU.
> Firmware driver provides an interface to firmware APIs.Interface APIs can be used by any driver to communicate to
> PMUFW(Platform Management Unit). All requests go through ATF.
> This patchset adds CCF compliant clock driver for ZynqMP.Clock driver queries supported clock information from 
> firmware and regiters pll and output clocks with CCF.
> v10:
>  - Incorporated code review comments from v9 patch series. Discussed below:
> 	https://patchwork.kernel.org/patch/10478575/
> 	https://patchwork.kernel.org/patch/10478457/
> 	https://patchwork.kernel.org/patch/10478461/
> 	https://patchwork.kernel.org/patch/10478463/
> 	
> v9:
>  - Fixed minor typo comments
> 
> v8:
>  - Corrected typo in clk Kconfig
>  
> v7:
>  - Removed xilinx specific clock debugfs API support
>  - Added reviewed-by tags for FW and clock bindings
>  - Updated clock node name to clock-controller
> 
> v6:
>  - Broke patch series to have base FW driver and Clock driver user
>  - Incorporated code review comments from last FW and Clock driver patch series. Discussed below:
> 	https://patchwork.kernel.org/patch/10230759/
> 	https://patchwork.kernel.org/patch/10250047/
> 
> v5:
>  - Added ATF version check support
>  - Updated some functions to be static 
>  - Minor function name corrections
> 
> v4:
>  - Changed clock setrate/getrate API prototype to support 64 bit rate
>  - Defined macros for get_node_status return values
>  - Moved DT node as a child of firmware
>  - Changed debugfs APIs to return data to debugfs buffer instead of dumping to kernel log
>  - Minor changes to incorporate other review comments from v3 patch series
> 
> v3:
>  - added some fixes to firmware-ggs.c
>  - updated pinmux get/set function argument names to specify function id instead of node id
>  - added new pinctrl query macros
>  - incorporated review comments from v2 patch series
> 
> v2:
>  - change SPDX-License-Identifier license text style
>  - split patch into multiple patches
>  - Updated copyrights
>  - Added ABI documentation
>  - incorporated logical review comments from previuos patch. Discussed below:
> 	https://patchwork.kernel.org/patch/10150665/
> 	
> Jolly Shah (1):
>   drivers: clk: Add ZynqMP clock driver
> 
> Rajan Vaja (9):
>   dt-bindings: firmware: Add bindings for ZynqMP firmware
>   firmware: xilinx: Add Zynqmp firmware driver
>   firmware: xilinx: Add zynqmp IOCTL API for device control
>   firmware: xilinx: Add query data API
>   firmware: xilinx: Add clock APIs
>   firmware: xilinx: Add debugfs interface
>   firmware: xilinx: Add debugfs for IOCTL API
>   firmware: xilinx: Add debugfs for query data API
>   dt-bindings: clock: Add bindings for ZynqMP clock driver
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  82 +++
>  arch/arm64/Kconfig.platforms                       |   1 +
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/zynqmp/Kconfig                         |  10 +
>  drivers/clk/zynqmp/Makefile                        |   4 +
>  drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
>  drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
>  drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
>  drivers/clk/zynqmp/clkc.c                          | 719 +++++++++++++++++++++
>  drivers/clk/zynqmp/divider.c                       | 217 +++++++
>  drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
>  drivers/firmware/Kconfig                           |   1 +
>  drivers/firmware/Makefile                          |   1 +
>  drivers/firmware/xilinx/Kconfig                    |  23 +
>  drivers/firmware/xilinx/Makefile                   |   5 +
>  drivers/firmware/xilinx/zynqmp-debug.c             | 249 +++++++
>  drivers/firmware/xilinx/zynqmp-debug.h             |  22 +
>  drivers/firmware/xilinx/zynqmp.c                   | 562 ++++++++++++++++
>  include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
>  include/linux/firmware/xlnx-zynqmp.h               | 116 ++++
>  21 files changed, 2818 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
>  create mode 100644 drivers/clk/zynqmp/Kconfig
>  create mode 100644 drivers/clk/zynqmp/Makefile
>  create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
>  create mode 100644 drivers/clk/zynqmp/clkc.c
>  create mode 100644 drivers/clk/zynqmp/divider.c
>  create mode 100644 drivers/clk/zynqmp/pll.c
>  create mode 100644 drivers/firmware/xilinx/Kconfig
>  create mode 100644 drivers/firmware/xilinx/Makefile
>  create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
>  create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
>  create mode 100644 drivers/firmware/xilinx/zynqmp.c
>  create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
>  create mode 100644 include/linux/firmware/xlnx-zynqmp.h
> 

It looks pretty calm over the last several series that's why when I get
an answer from Stephen or Mike I will take this series via my tree and
arm-soc tree.

I have applied 01-08 here
 https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc

Thanks,
Michal
