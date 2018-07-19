Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85C7C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F8B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bg0Kyh/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F8B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeGSJE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:04:29 -0400
Received: from mail-sn1nam01on0069.outbound.protection.outlook.com ([104.47.32.69]:49632
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730382AbeGSJE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M/VjCo5k2g9mUJtgGxDa9rZMiODW2g1qvM1ZFP/AqQ=;
 b=bg0Kyh/46C3ow3aYbC8WPr3aU7oUX0GwsAaZTSbZrzFLIqxhM/WAe1ToAFVH7JqN7USulRwFcG0BjGLmsfSKUrNZUqQbFGqGF1ymdler3njfapN0YkkkO/Qgbv0H+IcILBgZPI7IbbAz0DekTSjA5Fsi9Hcz136mYLgt3LmzLiY=
Received: from BY2PR02CA0006.namprd02.prod.outlook.com
 (2a01:111:e400:5261::16) by SN1PR0201MB1917.namprd02.prod.outlook.com
 (2a01:111:e400:5223::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 08:22:24 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BY2PR02CA0006.outlook.office365.com
 (2a01:111:e400:5261::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 08:22:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Thu, 19 Jul 2018 08:22:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fg4Cc-00072d-Tl; Thu, 19 Jul 2018 01:22:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fg4CX-0007DK-RF; Thu, 19 Jul 2018 01:22:17 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6J8MAtw008158;
        Thu, 19 Jul 2018 01:22:11 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fg4CQ-0007BO-Ms; Thu, 19 Jul 2018 01:22:10 -0700
Subject: Re: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name to
 'iio_xadc_channels'
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Manish Narani <manish.narani@xilinx.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        Joe Perches <joe@perches.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
 <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <7c4ee0db-ac33-b093-4dbb-1742fb029012@xilinx.com>
Date:   Thu, 19 Jul 2018 10:22:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(186003)(26005)(63266004)(31686004)(77096007)(106466001)(230700001)(53546011)(50466002)(478600001)(36756003)(14444005)(36386004)(47776003)(65956001)(58126008)(336012)(106002)(65806001)(316002)(6246003)(426003)(110136005)(2616005)(2201001)(4326008)(486006)(126002)(476003)(81166006)(81156014)(31696002)(11346002)(446003)(54906003)(8676002)(2486003)(64126003)(23676004)(8936002)(6666003)(5660300001)(9786002)(2906002)(305945005)(65826007)(229853002)(356003)(76176011)(44832011)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1917;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT034;1:9Pxogo2rDCAHzisVmt+ptN3T1Kdxo4mWBVpgAE6/HDqdhbK3vBoizLuM15jaPjs9o8hsEy2V8NnFgdaDpaZd/sBkI0eu1XRJXJVuWA5NEhx0bo/Khvi9cNCO8AkPF/30
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d0b0f79-b0fd-4efb-c3dc-08d5ed50c12c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR0201MB1917;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1917;3:o2B6HG06pWq5Ranh6k4Y5Nrx7cOnu79MRFUos86cJnv8yTiN4RKRJwtI1y8i7+A0W5EHEifRhwBjhXl2wbtetnhmOMDx4jF+BEtsSLJNB7Waxksx0Sgy07/6E6mKXPcVHni5M0ne25PX8PPwuT9w2ehCJlaEgIxPXWKD1x7ZZvce34T26ngDXDo9B8jWGEfiTrLbd02KSeyX5L3XkAdvu/q57PWd8Cz41yvVpP6vxZLdFL5Zf+Y3kNxwJfqKx7q+2XvDDB6jgGBfnuq/UXMLitgCMhjFocfEkqJWl5neLtboqo2E/FWnd1J4c6iDGWN8YUpBLsvWkp0o8cQneGiOggj3TWZpL3qObNhiCajfcSA=;25:VtbDd3sUXCrK8x94lkJ0eZ7MrmeUDDwUI2UAYy3j9B2fRuwthybcsbczY+uRCii1ZsEfsDeUn4z0DNmU3NRU8Wg+ghatXYJSgmjf6QmudiTT2/ICfiAP9QMBDZjWqs8iYnjLllA06GQbhh2JtcF9iCUJZ+rGYiKP0VTmUTsE5Cd4xnI9svtUyVlLiKJLGopOXVIAYMIYHl0JzBcGGm6KTk12Vkc5wyoYrCpBmCqMQem8c7gljQhK2In1Ua3SgWDfxphsOIwC8UADIVfkmBDAwQuofuBVU6vrTgdHRfS6D3668jbmush8gL2c/GT0b1kfmOAaM7N9zg6L5nm/XMsUrQ==
X-MS-TrafficTypeDiagnostic: SN1PR0201MB1917:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1917;31:IoQP45bkhdGiqUqJdJWoMXm/bBXyr5Fp5/2cNwhzC1pCpxuH6+AeWZX7sQaPIMB3wHwZU86U85dbJMXNYutapDW7ZI5IeHdKiuoj0A8134Xm14PaIJ1KNvydyl99auk5EyNgBPgaZFqNMJfQkyeTTGTWRZPB3gEsnEWSqYK9fLbtnr0oqNFEhykljIye4Se1wEV70CaO53PIfNMbTRgWsOQ/3Hxw5Pnn35r6RcVHs8M=;20:z4tsBTdc6Bn4TgOnmfZFYtBVK/pEzzz3K+1GX3OW5Hw4tt3M4u3N22mlv8gjdPir1D4GBk7YmQzYbCCqXaN6XfweWxESps2BgFeR3yOfbcShaGoAlJBWI1u5hXiMiZt7E1K/gvO5zkgpyTkxszu0SxpYpyyc1F4IhTM1BY0hd3ua6EgwNHnvcA5sxrqndt7+eA7HnRn2Tnvdw90PNtEXP3J35Z4BOiD8lNYhFrmFpSKrRxy68z6ZYNGj3VCvY8/RXE9e5DXJxYP0QB57PysOB4kFFDYmpHHdreGsu0ypePQ8feW6Q7Wl8qbP3xpU2Eg2vHF3J3k85UlxjG3yKIDfiL2FouB45AldR6kMy7Vzxc0zLnoaYyG+p8zzahT1A/pl3zi9J+sElyebgy3E2e3yNv5FUJfm2DjBBW7pnk3i++pT21ixerTalkTPLpt2k0E3ICCVvg1d0ynKCMt2C7sKJntGm8/ciN61Dzlc946mm4nFYpSHQ4lPTNCs++Ow7I4z
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR0201MB1917490644F1C936F1931169C6520@SN1PR0201MB1917.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR0201MB1917;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1917;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1917;4:PWMq0YiBZ65WQ2N7g1tk9oN5HZ431I86CC1/UC0Kx6HI2K3G1Howw1v1lfhXtzF0avCDuVjHXr3E9Cpmv74uvM0Ejj2PhwMarwQIaCz2etihVSm1fnlzYqTgMoeTrY6G3MPztRDf4G6fBqsvy25olWhDEX+6pTZamSxVg0N7gj8UuRSibS3mglVUq0YvKg9xkON0YbPwxEFlwJolN0D5GWb18Vchh5Bm6n5/OtPALCFTDuDwcKTXSGT0ZE0xD1HxUCHqxLvezFymY3cxTGn0HA==
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjAyMDFNQjE5MTc7MjM6dEdYNEkxazdBdmJRWFJEaVl4anBCSDU4?=
 =?utf-8?B?Q2NXVVU3aHFuRzkxcit6WmRDUGJUS2V4cVV3eHA3eXVQc1o0TUtCbWx0WkhB?=
 =?utf-8?B?OTRleVJYd0p0WTVEbFJTdkdVMy9XWWk0S1hhYUlyRnY2SjQxSWM4ZzdmeElI?=
 =?utf-8?B?SmhUaTBicnFQOWd1UTBZaUNEOWs4S0lFWVFBdlJmdWMrd1FxdUovUjZwUkts?=
 =?utf-8?B?cW5NaGs0dU0rQTJPTGw3ZkU1WmphU0RCc0N4Z016WTM4YlJWaDZoUEJFY2ZE?=
 =?utf-8?B?V21ISC96bE00V3BLLzQxNmFHRkpwVHNyeEk1VWl6YkxSbkk4Y2pGNmx5QTFq?=
 =?utf-8?B?V1pJWlVEbWU0QlFHYlhJcW1ENzFiaUNSbFQzclhmRkxtM2pkU2ZZWi9YN29F?=
 =?utf-8?B?TDNObnFRZjljS20yTC9JK3U4TWFJd21ONWQ1TW1OMjlRKzU2ditBWTJxQTZo?=
 =?utf-8?B?bGNVVFNrMmhlYUpVQzNZSWRPcHVlSkQ2NnVYNWQwTVI4WVJ2ay9oRnZ3cGJL?=
 =?utf-8?B?cTBsL09mQlIwN3p2TldNVXNST2hlS1Q5amR6SWErbVNnSFpIQm83aEdoL2xH?=
 =?utf-8?B?QVNBY1JQbjEzajRCRkpkRmptb1hkYy9WV1g4ekZ3NTRLcExUUjQ2ZnBJL056?=
 =?utf-8?B?NW5FYUNGS3lmclVlMVNNaTI2c01DZHhQbW1aWkxJVkp1YVhueHZIVzJ6c0Rm?=
 =?utf-8?B?cnQ0Ujd0MEZlUkc4dDA5NnpaQUZJeHRoc0g2TWJSSXFBd09LQ2RzQ1ZXRUlz?=
 =?utf-8?B?ZXpVdlY3L0Vqa3Byd2hjVFp6ZE9HRWtzZlh6eExERW00em1xbGxPS21zcVlk?=
 =?utf-8?B?VVpuRXkrZi84UzYvK2w1SnRVM2kzcEhRaVVtR0pTMENjOXZiOWNkVDhPT2oy?=
 =?utf-8?B?aFc2YjRXUnVWZmtieFdKcGszQjBwRG9iS0RQVzJqKzdvZTN0QXVNOWQ5WE45?=
 =?utf-8?B?R0pxQzI2WXNoRkxuZzBlM0pQVXNTQmRLNWxpVnM0dnV4Qk9mTUV6bnN6T2Zj?=
 =?utf-8?B?bGJmd1FrV2dQQy9CRyt5Q08xODFjOUluRFV3WHRhTFMvNXJiOEs0cjYrcXc2?=
 =?utf-8?B?Z1hYOVF3Ui9VanRrUXBlM2g1ME5RcDNNaVF4SC9ZdEdzS2VIY0prZ0dkdWhw?=
 =?utf-8?B?L1hMVTRRV2YrdmxTSXovUVFNRTRiZ0c5RUE5S2o0ZGpHYng0U01ybG55bUhV?=
 =?utf-8?B?TUlFNU03c1ZJcHB3S1VuUmNzVHZZb3hyems0eTNQMENXQ3pUMmV3SnlaclNQ?=
 =?utf-8?B?ekJwQjNwUXgrSzQ3YzNZazJTaHhKK0xjMVo4WmpwcDk2VVpKWDF6b3VSL3dw?=
 =?utf-8?B?M2xWYXpBNVBLdVVYNE1hK29ZVGdMalpSanZxekIzMk80Q0szOWlUWkZuMVFk?=
 =?utf-8?B?aXc1dWhXN2U5U2VoMzlPcTFvbS9mWTJHMEtjKzFGMTdYaU9zTTkxdU1kTjlN?=
 =?utf-8?B?K0VvbHBzRXRhZTN1UVNCSC9VUlpGM0hVbHRFaWtXa083OXJ0RnhRdlBaR3p5?=
 =?utf-8?B?aHdMVEZDZ3NUdVFhK05wUDVLTVFsdU9ZMVgxMXJVTVkrZ3M2cjk0WklkOVd1?=
 =?utf-8?B?aDl1R3lDRmI0ZGROVUtiWklHeEwrVkZrVitmYUVod0hIUUdHNXpLNSsybTRV?=
 =?utf-8?B?bzEwTU5BQTdrWE1IZmxCbjNBazVMdm5XSmFRVUxYaWJBV3NEd0lhdHZFbjR5?=
 =?utf-8?B?dU8rWjFHWUEweHVNOUt3UjQxZEZmbHZwYmFUSHNIc3VHSXRudHFXRDQxeVF0?=
 =?utf-8?B?YmtYemJJQnRDSUxCenZ2N1N5S1FiTGU4VjF4YStuQ0dmaThELzkwUG40V09E?=
 =?utf-8?Q?3yoQzTbr0Z//0yL?=
X-Microsoft-Antispam-Message-Info: PIvY8jMp57WV/3KHThG9elzhtO6S5ZO9EaGR3mi9JjkoAvIoBzHt3u8xPhU7oOl+ALC6XDonCnMEff5V8cOm4AN/S5WksLnoVFeEAuVNnOq2SN8r3+uETnL++5dSeCak9rsrIBmwp83AM6omt1vAKeVT7Dhm+tz8/WVmieoVtBg+vaS6XgaV6izlmU9ZB3Bh455G5G0rzeefchIWV9Ib/lACBiMNlo5CLw2+LmZXozbQILebyQANy2on0kxDqRP6/MUHbJhBQWHneIkU89pmFAeDzINHX1iUhsxnLZQaFn0J/BLuJVOvlAZ64eti21yZNd28IbopOahETUExP/aYLk9651FEQu+P5qcRAsV5yAw=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1917;6:VrmW9/HJ/qtIsTFoAPTa9Hy6GFViCW8jfncMhYhw4YwVVnxCy0pCp5L8MCJ0xA2rpJv2xsuubc54kLHh0Zn1/4z3+rwS9N+WZe2BbAj8Rn9vfm5ZPNhXc0J1MOtNfNE312FEE82Eis1W/CsX2dB9fYnsugNcuwvQeW7CCpZrwEQmoddEJBHv+trHwFNfMcWlTDc3N3X/isB4tDYt/liqUSNiTypjXsbYc1OhBmDYaMkXOk7iQXcINARruv8zUf2qtovaBYEplGTcvm9hwVmtXG7o8Zrd1rZ0CIjywNjTLC5MXSN79QBX3hmUjAuoKVTnJ0ocVAmA1qPoPOp9rFXKTNvWiYqH1rDWUxKUwNBe0WuYLtW+AFk+t5CyBNF8m3/XSboGRuUEsI60ieSt4EcjsNbh6W57IUqV0vz/nrewelohK4xFPQH8CmJ/bDLVeukWQ978iQDt3HnsVop61++cIQ==;5:2Q1vLzJonOAAER3+Q+zM+cjwZwFIDML865x9ieu4TgYqtc9+z8pF7OQ52Z7WvWVnBVfI0xcJMk+S2EESCgYIN2cA6dc9/vDQUEOZohw6kweUm8xdKW0bJFsIgdplzie44UwE3NibCsZcreKVFSmiUjOUessVFDkqv1z1kH/iWGQ=;7:CQ8925KphrAxQBEXoomhXNAtwsGfdDrZV9M8twlhOWKYjOM4anZSTkLF7aImku7rTsKj9ZzeszRGLOJpjq/0sGFDNcXQLW4/i268Z0zwqC7Lv8IxZbc8OdPiA/ttiudrXl0MErDZ2MzxbBmMRomutzQ1GLKbf9l944tG1vsFi7ylCj6/qMEDMI0CdaxFExpLHijgOr5MbScYWo6wvrJy2UvovZoq88OOKEvaW0heOR815Ba+Vr+BbdhNpG77nBs/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 08:22:23.3614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0b0f79-b0fd-4efb-c3dc-08d5ed50c12c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1917
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.7.2018 13:18, Lars-Peter Clausen wrote:
> On 07/18/2018 01:12 PM, Manish Narani wrote:
>> This patch fix the following checkpatch warning in xadc driver.
>> - Reusing the krealloc arg is almost always a bug.
>>
>> Renamed the 'channels' variable as 'iio_xadc_channels' to fix the above
>> warning.
>>
> 
> This is a bug in checkpatch and should be fixed in checkpatch. The code is
> not actually re-using the parameter. channels and xadc_channels are
> independent variables, just checkpatch somehow does not realize this.

I think it should be fine to have this patch in tree. Change in commit
message to reflect this should be enough. But that's just view.

Thanks,
Michal
