Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920B8C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3948F21A28
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gX7RL9h0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3948F21A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeHHSnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:43:39 -0400
Received: from mail-eopbgr00121.outbound.protection.outlook.com ([40.107.0.121]:2337
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727472AbeHHSnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CY5a5U7/uA9fosft7SwxuuCsXIG8Tj5i6t70DU2rzk=;
 b=gX7RL9h0Hz7mp/uqWjBTfsslzKypphEOinH1Ht1RppIKQ6XElo6AOK9u2bFNPXxevjFNuOfP/dIHWQQ76hrLxAKE1g9ppWn2av8/coNn2+hBxBwDWwLTMcOfrjTZeftkG90FaIl4gjcjGFxzSZCdpkPurroalhyA5RNHj4fix9A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2023.eurprd08.prod.outlook.com (2603:10a6:4:76::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 16:23:04 +0000
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com,
        paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
 <20180808072040.GC27972@dhcp22.suse.cz>
 <d17e65bb-c114-55de-fb4e-e2f538779b92@virtuozzo.com>
 <20180808161330.GA22863@localhost>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f32ab99a-de28-b140-a7d0-027073055728@virtuozzo.com>
Date:   Wed, 8 Aug 2018 19:23:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808161330.GA22863@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6PR07CA0011.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::21) To DB6PR0801MB2023.eurprd08.prod.outlook.com
 (2603:10a6:4:76::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e0ab688-63df-4bbb-882b-08d5fd4b397d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2023;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;3:zPGEq3rz1a9087RYlcH88HFfq4d3gH7CC1a3I/z/53jxqCCbwZkbexziHPEcCiCEFjfzmNG4WAO3mAB1RxW/O0ofLieCGJ3Me6pNcwnD0OF+IFRCOaHTlcexz2fQpjhH1UlkjH+WkhKo0c+9WqwUejyOpgpSSUmTOPIa3lgDhsdRHCrgkorBEPVCPjiBUUOmYK2cWR8z/YrNBQ2kuC2LOJ6/DndHuw+W9E3GwmLlWVAwrWdzjwXmXEE/L5EMPLTu;25:wNJe7pE8BucDgwrOZZqWxth0ZKRZnc+dJ3JJcWE4IvyzdZNLZkkXBK60BUBvpFQGM7Z7h7KgkzlW2Ptw1Lrw7Cxe64fbApc67YOmBrrMRuMkurYnXSB4e3JOMLUSY7r5DFM4C6NMJZ3AyVKzLt3/O1ptpUpx2pthcWJfnDPrcbChBY9KHI7vWiK/pkJeiTszj0PPYJKqyy3GarzXCKsyuYyvY6fbvB2MjSG6uMO+wP62bkr+SdpmUltARiUjgJDM5624uJri32nX3WzwTz9AYpyaUElkaIVBV66e0LW4/MonJI7l6ZvaYcPZzaYJdGJmgvCfVJ+MHxcFuvxRNU918Q==;31:wOGZoyA0Eonj9W/F4urXB995kknvaVzEMlxWJCEg1nu7PsSFgYZIn35xtpQYV3Nq9jCtCT1Xt4uKjTMCcSpViLh0ttZ2THnTflUsJwNg5q3n1gSdZd/uUtZKouzoSzYYopsRBuJqaMe2jopugAGLhb7+QjVZZv27EBqj4iJTZhKmLAqMMBJzalDJ4Cx6TaNs0fSYUgr6Z5jXd+piFcJmoFiCVgjEsIlZpJiC+Im2mBE=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2023:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;20:vjMbQDxlLONIjrIxv6QMt/SHD8qybT5i3jnTMWmTYLYijgGvunMZd/lnHGj94SGDHgAioexNY340abknIVPf1qglTAuWhK7V4YAWprqJAfytlKQVtWbszD3KqHnM3bV9yAZ8TIvTFq8rx0gQBmoGy3eEc/lmR/8xqDc5cztoQYhR6NG7ePx0xVBPl0XGgZk9SamUuiOU2iW+QwNm4b0/L42v0X8sX0QGPnRjpDQSRUUoc/h1NWMPTubSwZ98nieE6lCau/igPn4sytEVECbLI/RrCXYBBQtl3picjcDGQjR7PHB8pbjZqxuJQn72w0Pfjj4cT4UUKOoqZPCZz8AZStQ/uxkbF/5YHPaEeePAeQDPO3ny6aCbsvMXjjo2MutVDtXRsudCgit5yYuXVSiertyTljeOZ18yYPPsPUkZzBQOqf1wsO3a65am7I8YKllZytgC0DuNuXd2g2mSKckqPFvKY8P91LTjgnNMuNNQmubVCP9HvT0oinVurf8+X4kF;4:Yd+IYCGbEmucq2IscDPxFWsD+Kr85VmTATPms6CkqAEN1ZqPUpPHf08N56g/GKgF1ZEsCoNDJPZJTa+J3dZhyyt0Op4rFsCXSXyOD+wfJHxuT48gU3bhKtGRf7NiFqfNajjj69kvxTXZ8C5CrWitee9GXpDKxkg36RHfGZEEbwFBgLU65LrJo+FPknQWNssiQ/vYWuMRsaiGQmQNMk3PB8F4WQms/lLFHkMEn3vHOIrDtel9QArt+Io7CGAvSPgL4YfkHUst4EVgKB5fGhsclw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2023DFD76C09E6128E747CFDCD260@DB6PR0801MB2023.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2023;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2023;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(366004)(376002)(346002)(396003)(136003)(39850400004)(199004)(189003)(478600001)(81156014)(81166006)(6246003)(39060400002)(316002)(58126008)(47776003)(16576012)(64126003)(25786009)(66066001)(68736007)(65956001)(4326008)(97736004)(14444005)(486006)(65806001)(86362001)(446003)(36756003)(11346002)(53936002)(31696002)(956004)(50466002)(476003)(2616005)(93886005)(217873002)(52116002)(76176011)(386003)(229853002)(53546011)(5660300001)(3846002)(186003)(16526019)(305945005)(6486002)(77096007)(26005)(7736002)(8676002)(2906002)(23676004)(2486003)(52146003)(106356001)(105586002)(6666003)(6916009)(6116002)(230700001)(65826007)(7406005)(7416002)(8936002)(31686004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2023;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjM7MjM6cVFRZGZpbG1vTlhFbXNmSW4ydnBrYXlv?=
 =?utf-8?B?S0FGaUlhckVsak5XdHFKSjVCWUdQSng1RFFXZDJTQ1F3Z0dNSW1lNDRTdTMz?=
 =?utf-8?B?OU9ROElLTWMwaDRhUHNQa1FQWFBzaVNtMGNTeEMrakNWSkxRajEvcTJwejh0?=
 =?utf-8?B?V3dCRVdHMWRuc0VUSzQvU1BFdHhKL3hSV0hWWkFTLzdSY3dicW4wTFZhSzk2?=
 =?utf-8?B?QlNITWd6QzN0NnRwZ21qemxTOGtPOWRkQ284Q0trUkMxRVJLY3Eyb0lJMTVG?=
 =?utf-8?B?YlNyVG5NY1o4SGZpNHhmUzEzQVA3UkZ5WFIzRFJtSGRtRDRIamk1UTlkVkpV?=
 =?utf-8?B?cHJXdGdHcjh5NzJkQUJZdCtabW9XQkxXOHNRNnNYSUpzUDVmWnRSZ0dpM2NC?=
 =?utf-8?B?UHlRSUJDcnpwaGxkNlIzNmJ4ZDUwR3RYa3RuV3l2eUtDcXJNa1ZuZTc2NS81?=
 =?utf-8?B?NGZndG1TUE8rK2Y4ako3a0gyRC8rNE5jdjZWbERMUVJQYXcxVW5iV2ZBbS9k?=
 =?utf-8?B?bTdxOWRPWjREVmhOaVFtWWlqd2RVRXhqMzQ2Rm81dHdQQXZ2OU81N2ErM0xp?=
 =?utf-8?B?MkI3OGJZMU9RTEgySnRuM2lmdDB0NFVhTVdLcEhaQ0VUeGJYR1JjcEFDOGF1?=
 =?utf-8?B?V2xyY0hMUFJtTnRvckRxUzNybkpDdFkreVV1anBZdHJZSyt0S0NzQ29ZQXRl?=
 =?utf-8?B?cXlJSmZLelBESzEwajNnbFZVcTdrU0ZpYVFZa09TSEFOL0xrYkc5NGtBWmJa?=
 =?utf-8?B?c1Fhb2g3dWlIdlhDMjJBSFltNVRSbjBsd3luWW9kajdMTmJkR2VNRG5KRHQ3?=
 =?utf-8?B?TXVnRlNETUdrZDdoUmdnQ1IvTUx4RWNKc25hMDhXdDhWLy9rcDA4MGxrSVM3?=
 =?utf-8?B?ODg2U3p5ZkVPYzBYdjYxd3kzTTNwdHlGTmt6RzlPNTZjdytBeUJiM3lnTmdm?=
 =?utf-8?B?SXpiOGZDUDRhbFFwYjlOL0dMNjJqa2dKbVZiQW5ZaEhlRndreVlZTldBSlJ4?=
 =?utf-8?B?cjZPdHMzaDcvRWFOclAyb0xPaEVOcVdYWTBsSEp2MFFLUjJ3NkxiYk8yd09K?=
 =?utf-8?B?dUc4ek5la1NyUUhEUlJLZkdlRy9sbXdubTJ3R3VwQ0VnVzhtcElQNVR3ZTNu?=
 =?utf-8?B?VWIybDVTODZDQzc1cEYrOXFLUFZOVjFiRmF2NG5KVUZDM29xOVFhU0o0QVpY?=
 =?utf-8?B?bHczOG9HbGJxQnpVNUNsVzY2K0ZmdWF3eFQ5OFRYMkFvVGlXcW1ManJHVmhS?=
 =?utf-8?B?R095dVIycUdyYjM4QVVNZUY3RGhEQnRCaDA2aTVob013ZS9PazR2QnJTWWlr?=
 =?utf-8?B?bFpDRGMyMFdQZXZjZDhEQWRWbVB0RzFzMEswUFg2WFU5OWZOT3kveTRBOWJh?=
 =?utf-8?B?TXE1ZVZmaW5NVmtkaUtlcS9XdlFxdGhJUXFPRU5taldKVGltQUtMYmFFWWxR?=
 =?utf-8?B?ZTliMk9hWTkzNHc3UHJ1SEVrOVRyMzJLSzVCSS9zcWVlekIrVzkxZFJpek1V?=
 =?utf-8?B?TGlROW5NQUM4Z0ZyM0h2Z2kzdkU3cVlYenptSGIxTHNIRDVyd2E0U09pNWJa?=
 =?utf-8?B?RlFBUWZwd0JVYnh5d0kwRWhGanc1S05Ka1NzelVwNVA4aGQ1V3huNUdVOW1Y?=
 =?utf-8?B?SlgyQXNsdzhmalc2bHpoSzJENmN1Z1BSMVI1TlhIcEc5cG5QY1h5OXA1eVJy?=
 =?utf-8?B?am9jWHZuTk90VUg1djdLblRSVmR3QmhHTHVNY1k2bTY0RTdNTW03N2hlTnM3?=
 =?utf-8?B?OFZJUmVrWjZON01nOVpPT3Z4bzFBczZQOUppd3VRTEFQNDRxS0NyeWZWZ0dU?=
 =?utf-8?B?YUlVaHRMeENlb3BxalNCN3JIQ1VsTkNvc2xXMVhyemF6a1pvMmhERitFeXhP?=
 =?utf-8?B?NzNjZEZrNjhJckJMWFR0V3JtcGs5YmtJZHFFekxUM2VOY0sxNVRkRnh3NzN5?=
 =?utf-8?B?WjNIZ0s1WjlZSElCSUhuNEtrVHoycTZyS3R4cGJSR0xFZDlyYXg5UVJlRVRh?=
 =?utf-8?B?WCtSQ09jZVV6U0lCRnprZE9QVUpkOHRBMUJLRktPWENhc0tvdGkyMVhaM0ZW?=
 =?utf-8?B?cDJ0RTRwSW82Nnc3L2VVenIwMCsxRHM1K2FsNkhwQTRzMWdmVEZXV25Obzlp?=
 =?utf-8?B?MWYwbHRNems1Qk1raERSTHNiZzU2c3BHUzl3ODhPb1UvYTJxZVY5TjlJb3dk?=
 =?utf-8?B?eG9COUQxdnQ1WHpKNGVuYlVvUm4yZWc9PQ==?=
X-Microsoft-Antispam-Message-Info: xV2i7QBTOTPHrNKLagcuOR4QdivS+CPGZ0gwY/Cgn02A9icXuMVFKhj8SUrBtGDXLY3AYQeh8LNtqAse6PPXIE+MAVVU4yv8uXjkP37PGlswMKODccBaR60yYJovZP30aHaycZXKRabBxev7pfM/2RRkZHpsBuJ1p1d0dViQXGxIv6ZDK7XfvjgNy72mqzO8R54UFHuAvsg670TpYE8N9esyBa81WwHUz8CpTCyk+sq/mxp0WKlucjE9d1vNefjiuG8kP1bTwrn1b/Evo1viWzco45M4buocdd9z9M4vGb/TAHVZPM4rVcY/jxDR4FdVpsJqbdDUaWJFxiVFs3ApDIXKeGJyt6UAjcAmjo26nLA=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;6:6C7jj/II/LWN5A4qckjui2AZKTVNng0MxtMXBI+oeqz5GXeGzHE8joA/zpc+fx8QS4aYOsA3GLS5/zObWx/FpVv8JztzVQ7g62gPHmKHbHVaKxrNq/ukJxnycJ/7f5afSCgmRbAiaXQ4Rci3tXddyxpOE0uT6aHXrDl6u/Cxvw9C5AtZe83GVA7cZv+ixebo3/q8THlGMv/6ZrkCYSCg66VzjJaN1b28DUqv/wnYnWH7IlSRX9J2uDON1kPWKdoq0irOo01DalMK8avFf/AR0KP2y34oASKnteV/LD+lMTLiG6FmA1YqT1eFzsLm/bg50Ch6cAZ42ljy2fULBVJG6DdZp3pAfVsQV3VpS1MfDRGQzK316QFaLyYH3XRu66/aAWkrH+8UIDt28b2gZG72eOseUoTOsIfBlDEdo6YBgMB1wXbwUMHYiBJ8aiKOPx8xbcMf7Nzf3zfYlKwmk5WDcA==;5:zS/XqMJ1rL5Bkg5VKOe0cl1BlufiJEpHXmcQ8pE5/ohwkXFAryMnqDFNSYKAjFFiXocgBoAi0ueU3R5USPxdftiKlkjBPvCXS1aouYihfnE2Zrswm+HT8cuqWSyaBS+ByhdQD1yC2NLZn/Zeg1xQq6TYmDhdnMFHOhs8PA/gKG4=;7:CCDavWOOhjj2SJNUMhOKgTBqDsIrPLf1285qSOSOGMCBk0rZIfq1wMcSj4uErSczCfplpzBDU8e4lgxklK6gBYG4nO+teAXWvEBssX5obugsuXuX9rqfH/wNE8qaBD6ci+RsBonLZm3F6P5nzNQ3ED6avx7NYqiS+ctoapLtqRuF5z2w0yKItP1XyLy0Oq6oWflpuw+2S4fVqK1n6u1j+qOQGRGl9UPSjM+HenPE2qKTK80TL8N4/uWwNkg/U6xj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;20:GiE64j+FCzFYGJ31HriSGs/CSSQ/HgrYwH2io2f5UZcuE1ozDD2ySjOr/FwWKNbKs3rhXJZRSjCuTOBCVEt39ZVCF+FdAFkUcdfImawdRXo0Yr8EW+R0tMvU8WDLPRi6rzGmEAF8Kd73jZJRnqbhv/GFJ0Wf8TJIv/E9xixNQzw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 16:23:04.6674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0ab688-63df-4bbb-882b-08d5fd4b397d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.2018 19:13, Josh Triplett wrote:
> On Wed, Aug 08, 2018 at 01:17:44PM +0300, Kirill Tkhai wrote:
>> On 08.08.2018 10:20, Michal Hocko wrote:
>>> On Tue 07-08-18 18:37:36, Kirill Tkhai wrote:
>>>> This patch kills all CONFIG_SRCU defines and
>>>> the code under !CONFIG_SRCU.
>>>
>>> The last time somebody tried to do this there was a pushback due to
>>> kernel tinyfication. So this should really give some numbers about the
>>> code size increase. Also why can't we make this depend on MMU. Is
>>> anybody else than the reclaim asking for unconditional SRCU usage?
>>
>> I don't know one. The size numbers (sparc64) are:
>>
>> $ size image.srcu.disabled 
>>    text	   data	    bss	    dec	    hex	filename
>> 5117546	8030506	1968104	15116156	 e6a77c	image.srcu.disabled
>> $ size image.srcu.enabled
>>    text	   data	    bss	    dec	    hex	filename
>> 5126175	8064346	1968104	15158625	 e74d61	image.srcu.enabled
>> The difference is: 15158625-15116156 = 42469 ~41Kb
> 
> 41k is a *substantial* size increase. However, can you compare
> tinyconfig with and without this patch? That may have a smaller change.

$ size image.srcu.disabled
   text	   data	    bss	    dec	    hex	filename
1105900	 195456	  63232	1364588	 14d26c	image.srcu.disabled

$ size image.srcu.enabled
   text	   data	    bss	    dec	    hex	filename
1106960	 195528	  63232	1365720	 14d6d8	image.srcu.enabled

1365720-1364588 = 1132 ~ 1Kb
