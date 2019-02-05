Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E45DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7792080A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h6m7MNhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfBEK3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:29:21 -0500
Received: from mail-eopbgr810040.outbound.protection.outlook.com ([40.107.81.40]:21341
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfBEK3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JWcPavPLkR6e1DQuHHjMNQEOK20WHca7ZOx1VXMtJQ=;
 b=h6m7MNhWLLzvmO9ZH7nTD1Mzz2jYXofosurSZqnyBBTKAA9PLGLSetGjaJtRJRSM7rqgMLChfcZ37IM2XsteF+qweQptRH7r5LchUzKQZhvaB0ZpRAH9w5AomgdCTPlbGQuaaORzDW7MO1CYS5Fe4cDIIX+xN1MgPUJgsMCBDdg=
Received: from MWHPR02CA0047.namprd02.prod.outlook.com (2603:10b6:301:60::36)
 by SN1PR02MB2159.namprd02.prod.outlook.com (2a01:111:e400:7a48::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17; Tue, 5 Feb
 2019 10:29:17 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR02CA0047.outlook.office365.com
 (2603:10b6:301:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.20 via Frontend
 Transport; Tue, 5 Feb 2019 10:29:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 5 Feb 2019 10:29:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54230 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gqxyd-0006DV-OU; Tue, 05 Feb 2019 02:29:15 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gqxyY-0007bI-K9; Tue, 05 Feb 2019 02:29:10 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x15AT5Vx014437;
        Tue, 5 Feb 2019 02:29:05 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gqxyT-0007Ye-7Q; Tue, 05 Feb 2019 02:29:05 -0800
Subject: Re: [PATCH v2 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <jollys@xilinx.com>,
        <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190204070951.6933-1-nava.manne@xilinx.com>
 <20190204070951.6933-2-nava.manne@xilinx.com>
 <d949520b-452f-9e66-42ae-263959a8c549@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f317c341-9706-3a24-6faf-711f2627bcce@xilinx.com>
Date:   Tue, 5 Feb 2019 11:29:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d949520b-452f-9e66-42ae-263959a8c549@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(199004)(189003)(63266004)(31686004)(65826007)(31696002)(2201001)(4744005)(106466001)(476003)(6666004)(336012)(126002)(305945005)(478600001)(6246003)(446003)(11346002)(486006)(426003)(2906002)(58126008)(81156014)(316002)(110136005)(186003)(65956001)(65806001)(64126003)(26005)(47776003)(81166006)(106002)(2616005)(356004)(36386004)(44832011)(8676002)(77096007)(8936002)(230700001)(50466002)(23676004)(229853002)(76176011)(9786002)(36756003)(2486003)(107986001)(921003)(2101003)(1121003)(83996005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB2159;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT058;1:fJztKt0Yim+lKRVKiJPne2A5/bgSJ/hkiGxVgWGqD71H7+p5KQ1gZCsG7s8/yJsrzQO7JY+vfeyxykDVSy/uK2LHzQ+eht+eYIde8U7Gj2dStCCeTkuK5mi+JJoc4Qo0SWy8WEHerFhflhY2x2axVw==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94075539-4b65-42be-f641-08d68b54c7c5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN1PR02MB2159;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2159;3:j58w+VOkOWVjhqtZYwRvUyikHKFz6WWVaAQpSMr7HLydvyrgj7Iu6UNJ7uve90WX3chA5y64aLoyufJyKuJL+614BijlDAdyy2YTJZImgq5eOQXSpWcVLuQwjfb4FKzR4veSiKTN/k8tgThiA7pCXJqMOPYO+EWubaFj4zhNI8VJJe8moutJroHlJNEmIQZcDVy8Eofd0tUCSv2yPumE7HCKnTEe287gTXpQDqbXXkMp13v9Szr/taI/ubm8gRf3oj3kUY/bh2/ByH1MLSyYpLR8yh+w9xFfpPyL+4WA8iveBy4DXbVdU7hy5FH/yjvwBCxPpFKATb4h/6JsYpPw4Y4N4AxCtkj57NObw4fIiJ1thaRJT+fWwoJVaZTaF2NP;25:qHZrQ9RXVtEj/t4vllgW5ON7C9l63fDjvQOMnesmjkZfjVueLFbOaFpd51sbYcVAHFJbVZFSymGCOnTTc+p5CeuB7H1uuMq8N2v9XqtK/CZr/R0dTOs+O3twu0lA5CqLsgE1wdN8b9RLu2Agp48WF3h6JHeYmtmmsqAnvsN87fXBCVs7oXUnLn6pANN0ILQ+pa/uhVmzvmeoh1LjLM6UjxwlJ/S5br3omOtKr4GRCznT3HLuS2bu7cqLeXDpGn2kYfgH9xsXMbwQsPpFxqNIpDHnizEs1W6WC+m5lvTk5aTgvyZZEUfQUdbxyIMOlcdV8Y2NlCDi/+XPyF0HCABKUA==
X-MS-TrafficTypeDiagnostic: SN1PR02MB2159:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2159;31:spbOSIuiY8j7u7yswwmkHkMBXde9VYa9c+cx/eq820bLpbYtVwZpR3Hl9l6YEiff/9RdFwIAEQdU04krzBfC0tLPC1jAxr3jVTvX8mMQnrmtmld9J/fEw+T9fHRvXMTZyAyBQTYDU4lDVL8DzsNotY/pV+mSatyBRu0CtQTabtJx4NRYVmIFl0EDQIVG/G4Gl2RwP85H9jx09zlaJV1FAmCVq86b1iGPkQGjZdlmT8k=;20:d9xoI4o7zrdS8b+AmUdgCB8AmG61ZO+c4f4zC8XBE3QKtYw5SI1YmUyWio6Iq9z2+aKoEqirhzwNX0QWC/FFoXd46uCvyc6scJ3HKgNyrlF34bM1PvHdDhPaAe0f23IU5wD9bT00eqrdPdElXQFOOAHTYEf+8OfdDaxS4sXXdLvDCl/wbDw3JALmpZwJem6r85XaDAeZ0RU/vf9kcmhUMSgxUmiCzwRi+KYcO6faA5QSEYh7DYfWrYxTZO6CeNQMy4NBqN2xXOIPJInOm8hXMBmA6HI13QkbfKmj6a0YMH/u2IUBg86H1XVV62jx8zTEJQrNsRwg+u62tpANWi9Y+uKOqrNactegv0Pxj1wzZQWCG77BhOIjPaeivvAI8JVRKLCchg9fWpzZBAgCBS9S41fk1ouHOwIC3xOpbFtorqmjtPE/SpJG4vcW8Fcr/wBfqjiThXVQqFEwc3SZR6q49lTZLvNLsCwx/PY4oUAGwJqpw+olsWUQIKhu74nl52Cu
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB2159C5AFF5A84D09EDD68762C66E0@SN1PR02MB2159.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2159;4:6cYG5zkh4aXrZbnEUC6cbCu2MsayrCrNt/bsWxLxlyWnsxqAZKHNTuV+BhMcSglFMwMuxNYXOAeGTfGwe8mk3FNldd5s4uBQIUEz4vtWD/oHL5jukGzWKNlpUatwJFAjVARnBAidydrhp5pN2SFgTvGNluXSuCN16enWSNN4O1YnB1jnCB1yFkslYnK06NBoNtdDPZWceUqCe/gYh98vkOBF1Ni4LW/Xa+71QUQSveQyWc8J2oazoTzKCrzaGhovAUczh7J3dINvQ3FtYO70md307N7dGeZuNSVMqsJibko=
X-Forefront-PRVS: 0939529DE2
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjAyTUIyMTU5OzIzOkhkZUl6VDVkOXQ5NDFVekpTUzBiYmlrTDNT?=
 =?utf-8?B?ZkJCR1ZTMXdLQjN1aG9NSjJsSkJJY2NUb2dYQ3J3WDFGVXRiOFc3NmtORHFO?=
 =?utf-8?B?RDl1eFNHT25GQU1qNkJ2NzBsWlNFWUpLOU55VXl2UVFiQmxiQjEwTEtJVXIr?=
 =?utf-8?B?ZlZHUHZXeHZxQkFlTkJRWGFXVVVWQUtCcWpHcmVWenB6UmNUdENrdG9aV0hv?=
 =?utf-8?B?Q0ZlbVZHck1iZXZrRjhLbG1neVdyQkRkZng1OUJKeUZVNS8rSXk4RzZjc2s4?=
 =?utf-8?B?bHdWa3hXbkhLc1NZMk9PRFVPaUl1NDc0UnFpTEJ6cE9NNTZTNXpGZHEzR3lD?=
 =?utf-8?B?QjB2aVRndlJ4c285K0k4THVPclliVEpuMWF4MndrSDc5bncxK0p2c1pmMllu?=
 =?utf-8?B?SnFNZk0xeDlsa3lJeFl5Mmc3VVZSSlh3KzlGa2txQ0F6aWJUeElZWVkwbXls?=
 =?utf-8?B?SS92amJTa1Z5ZUxCVk1QTjVNcE4yUWsxcHcrbTBSdmJyQ1A2UHFtbndWUXIv?=
 =?utf-8?B?YXVLTmIzMzhFS1VORWYrcC9CcHdXNVNLOUgrYnh2OU5yaDJTVTMrVEpDOFow?=
 =?utf-8?B?MFcxZG9xU1Z4TWdmQlEvRDdkY2NHQVBBbDFoM0ErUldSZTVLaldxRC9MOTQr?=
 =?utf-8?B?SHdDQSs3b0gzeUVhYXlZbWtHN1NTKzBEUkUxaHlOaG9ZOFVhdGVyYlpYeStu?=
 =?utf-8?B?bDk2LzRzQUVCUmZXY2hjRlVzVUdKYjFIb2JKL0t5R21lc1NLQjFUVU00SnN0?=
 =?utf-8?B?bkpMTjErVVQ4N3d0bHQ0WSsrLzBCS2gwVkJZWExuYXdWdmNJTytSUlgzbUI4?=
 =?utf-8?B?c2NYem5UelN3T1BzWmRZby9CUndXbDY4MndQSkVremIrL0FNbG82TEdJS2Nh?=
 =?utf-8?B?eVY3TlhESWNERU5iSmtTaUZPM3UyRjBCOXgxMGtHTFhEd0pYOVBUQVpNSktV?=
 =?utf-8?B?N05TQ1I5anJtWkNXK3ZTYUU5SmxDSGplMWJvSG9aRmVVZnNQMy9xa3hJTUFE?=
 =?utf-8?B?ZVVQeEw2NDJuTS9PUDdJWlB6WjBVWms2a1FGM2RZVU9oMjJvRk5ONUlBak8w?=
 =?utf-8?B?eWgzMVZVdHgxTnlIU2o3ajhCby9EejltRXE0K0ltUmxua2ozWTNYQ2ZFK2VN?=
 =?utf-8?B?dDNtYkpxb1h5Yjdtc2o1MnoyOThCbktLL25xc0F4Mll4NzkwNWRaRDhVTnBH?=
 =?utf-8?B?czhmWXp6Umc0VXFaR2pDSDFXejNuQ1d0TU4wWHZXYW1Nak80TzQxLzZFL2tF?=
 =?utf-8?B?QXRWblZjNzkwSlo1M3Y2U0ZvVUZoWi9RQnllVlgxMTVHRlp2THVoUFQyTVBD?=
 =?utf-8?B?TU9vckpYRG5vTHFEQTRJWkhQdTViMWxNelNxWnlXOGJhbGtwZmxRRTE2NHBC?=
 =?utf-8?B?T0hPTHl4T2o0cGp3NUJZaEwwNkpyd1RZamh3R3RST2F6R1lNK2dHTFB2ZFlZ?=
 =?utf-8?B?RWp2U3lnOGl1VHVKaXlBTXRnN0ZrS2JwR0N6aDY0Qnc0UGV6TXk5OGpkbHhh?=
 =?utf-8?B?MDFaVHJEL1BFMzJnWm1QdWJRWHVRaWUwVmQyNTJYc2pjRDZwM0pxSFhIWHBo?=
 =?utf-8?B?aVBJZVhCZXZnMjQ4VlhySXpiQjgvdXBWMjVlOGJVdExSZVlLclkwejNtSUJr?=
 =?utf-8?B?R1VlS2lUR3NrY3ZUdEJUWC9CNExIaEZodHJZQTA0dll5WFpCemM3SEQzSHdl?=
 =?utf-8?B?d1gwT2YvUTRLTHNRY1k4cjlRL1FoREVSQU5peW9VbmdMdzREUFd3NUI2V1Bn?=
 =?utf-8?Q?/DBTNpEaKOAnwAmKfCz9+TWrBWoimrFm+g67U=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: rMjVea+JuOeeEDIwrHeQ69/DQQPEpE2+K1Mg4kZCgB5ByqEth7Pc3J0J0rULnnrHhvbhYBhG5RqqMZuOE+TnYZh5g3xbuDWRO5eHpuJt/WrcIJ6ui/v8pJc8q0QCuG0IUnx9ZUw7EAYcAU6m1HRMqTGe0ENbFe+VBxN1NLp74wiX81MpdaYjKg3bEKH0SwGr6XqJW5pmrxqsbdxz3FHxnXij7UUNhcIK30zzU6zlHlEv6j/ph+uzmMhdU0oXvEfbh8zpiw+MHGYCj2va8qNRVIBUWN0YR1ctRntiINhgvH3loEwhSvf/ClR+nF2nI5jB4910B8V9mSJm5lzadHpQUH55lT7nhmV7fFb+BSC7ppkLfJ109kNtUcMKqUlBYnU3wK5f5DUHf2oEvPPH5MXkfoRQJO8bDrIA2Aq6WPpzs1E=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2159;6:8VbJCglVtGjZZKiL1rfiiGwjIeheNg74V7ROEpcFyEI0gduvsAuu9V0tsTUA+oo4si+EUvWPlFsVzt+OeQFJu8Ezv1oL3jTv1rQjkzcKE8diWZ70JIdhP6yk5GhulyoG4n/yCrZ/THfT/akmy7a66NrQt+dcSmF5Db57AkvuUMNNjmekuN+CvDbzWH18xnDb9wCMjDONJRMrBypRWrkBDLs7TlQcO3Q9WaqgxZbYXnElhZRCYMMLz5F4+wkX1WUGMGeGb05Hx2v8s8ttPpfKafZqEaeVrH13MA67S+iXXH1TWKNtGnCcT8ifJ5lJbsGrceK8TAu0GRPIbPVEZXktfTdKClkG5mWX8kSdGpHorgt5kpyCQi/dIyRD6JPAEuy7A3HGQjcqGywDeafX6uFDvXrWKZSEF3uCvMh0n0oJ4QROB1uFhSYXs5vZJlx61es/ty3r7B0hz91uNTSzxY6Y/Q==;5:LXoEyFYGxS+OaVnvoPRFunmIZgz0VzNPcy3j8CJg83BTgUMAyjGEHh6wVvNqARojLMh4zvMIeo/SK/WibCUBsHscYLrY1F2AOgz+bnF5J6mRiEVE1G7T78O5D8cEc2AdFU+q6TTyThrAqXYxUaFQxFHog1pqvFnjh1/gnZqbfZYPwsGESab8o5SOgPVv4yJ/ddU1mFOOcdAt0CXv7Ldnrw==;7:H7RcA+3WYkjy2InmcIZvwVsQDXXcSXmI2KMk0gT5uIRWwt6e3a6yuSpGWJuNola3nyrWQ+hzw1LOWSyBBqeFOsmwoRDJX/Y03VSJS2RYJNjp0r8bLgLkQsiQYliWe+xBmOZppPFe36omlC4WZ2wa+Q==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2019 10:29:16.2915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94075539-4b65-42be-f641-08d68b54c7c5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB2159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03. 02. 19 9:50, Srinivas Kandagatla wrote:
> Hi Kishore,
> 
> I need ack for this patch from Michal Simek to take this via nvmem tree.

not sure if my reaction went through. Just for a record. There is high
chance that there is collision in firmware interface. It means if you
can ack/review that patches then I would take them via arm-soc trees.

Thanks,
Michal
