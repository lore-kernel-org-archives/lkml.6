Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D25C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989012156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tfGyWZtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989012156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeI0NUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:20:20 -0400
Received: from mail-by2nam03on0071.outbound.protection.outlook.com ([104.47.42.71]:37664
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbeI0NUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8ky2ctowEoFW2M99N8Q8d5Uxb/2lGU5NBYaWoKDses=;
 b=tfGyWZtdfQHlPrbTmAY3XFP9JJov7AOQK/uyyGJACValxfGC/Ni7/Y36/L9Lt/S6NLf9/rWR5vDOT9BT3SAt85uJ7Dypz5X2agU/1T9GizLMBAUtE14YktNolP2sUqWdpeBD2qSqpwxrPxn3UhOCgFtIb68R3sNe9UMWat7n7AU=
Received: from MWHPR0201CA0101.namprd02.prod.outlook.com
 (2603:10b6:301:75::42) by BL0PR02MB4754.namprd02.prod.outlook.com
 (2603:10b6:208:5d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Thu, 27 Sep
 2018 06:53:03 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MWHPR0201CA0101.outlook.office365.com
 (2603:10b6:301:75::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Thu, 27 Sep 2018 06:53:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Thu, 27 Sep 2018 06:53:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:39500 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g5QAX-0005gR-Pa; Wed, 26 Sep 2018 23:53:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g5QAS-0000VU-Li; Wed, 26 Sep 2018 23:52:56 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g5QAN-0000V6-SK; Wed, 26 Sep 2018 23:52:52 -0700
Subject: Re: [PATCH] of: base: Fix english spelling in
 of_alias_get_alias_list()
To:     Randy Dunlap <rdunlap@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <gregkh@linuxfoundation.org>, <geert@linux-m68k.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <b64be28f7705a91fcb84b9c59ca830e057c71d96.1537959997.git.michal.simek@xilinx.com>
 <dfd94b86-0a71-a2c4-449d-7f06ff3ae30e@infradead.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5d8b8daa-3953-a22d-3cab-5bd1764e4602@xilinx.com>
Date:   Thu, 27 Sep 2018 08:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dfd94b86-0a71-a2c4-449d-7f06ff3ae30e@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(438002)(189003)(199004)(34290500001)(336012)(11346002)(26005)(77096007)(446003)(53546011)(2906002)(2616005)(486006)(476003)(126002)(44832011)(65806001)(36756003)(47776003)(65956001)(356003)(186003)(31686004)(426003)(31696002)(2201001)(36386004)(106466001)(63266004)(4326008)(9786002)(316002)(230700001)(5660300001)(6246003)(54906003)(39060400002)(110136005)(8936002)(58126008)(8676002)(81166006)(81156014)(106002)(2486003)(65826007)(23676004)(6666003)(229853002)(50466002)(76176011)(64126003)(305945005)(478600001)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4754;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT011;1:FLfSh1oJfORSKpr+FcbXs2sWl7K1EK7bbAYYSKdv0jeVMF5/mfvxZ2TVmVYKnPAGsAuzACmS3d0ygL40XCHGPa9bs8vkccccOzNHS1EdJTLUoUsC5MC81txHqBge3I3/
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 598a6d0e-bc4e-4344-63dd-08d62445dead
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4754;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;3:VsydG67T9KfjjCKsKJjqKX6RenXq6O2MHX8k7KEJH1fULKWsdgCT/NYXcYJCi3OtT8+4IDAlFtDiK0YPq271gUQXx1QM3/QFGdb8HDA07ndhIKpetv6ELK0WN15Q6wSHDxXG41cjsGgD9tTcWbU6LsiGarj0M2BL1GQEzGxfwun7JQWq03yHui51xyetQlr7grEoIT4ugQzMugwFttR/pdeZt3FJCA4AiEvM+t9U6eo4X7dSQ8LiHc/GK0rnbycf/rw8Cnq0+P+OPpaJTDnpLN8+RbvFl1ffJGYBfdMdfuLsRygIIkjvLIA2kXf2Aa/XjK6SjBHVJ17D9/8lQ2aZM0lxzX/OuwYYDirS3l47lIg=;25:IxxN/YbA6XJT+ktHVA5+FgvfE8AxQEUEbm3wmL5c3mAwX+dB0vyJXedjgjYG0SDFol+tEuKCDIHgdK53hnGOhbxZetiYLZTTL9tF1YSWvasnVVl2mmWAU6t0tIJrM+dEMAUN+qpsSouXSnu6rUTKhucGOwvuL377zBEp28oXKUw1iVcQywBo09YPc3tqvWm4s3a9ZLi3OTdtBEvLcqy7qwG8xJIDzwQ4juRD/iPWzVx7sug2+2ZJsiMyqfqUR8tlxxgtJpEQ7OYMT9v0yD0xMNZ5Cbu5ErtL8ZsLasdlfb0rCbso4C5aYq0me5DgHLtRLiu4TZSzibK+0OvUxYdqhA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4754:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;31:D/qJ6wDGVRuAlEum/Vrluy5UsAkrdSDldTsoaD3HEr+3MwF8Qbv+un/mc0QZV5AipghW7swRwCB1GdpN/sBb58esSs5rXpTFFQFrjKorS+dRtEZB9dWLJX8qNYcJSsyYDJ7fzSdLnooi+3DYrKkzR26tfmLjuSsDdciiDOuKqq9SyM9XC4J/e73fiBLtOMXhDvlc2pEtsJukcSzzyDb0i2jmWP9fk5VrF5haEUT6868=;20:NOt3lQnQ2+NxCcllBqBTsEm2JRUNM0jbTVCA+h1RxHAP3cTtfcaWIiyyEYcHQEPYqbsceGy9Fb9AmZJ4x3VOeKWZ+I0aat+d1euw8GYx9Q7uZH6mv/JrhSDGrv2fQDZReTCJyTZsEQUHxdoULHUoy6jX9xtizpP1vRt53yg3Z1vXoXm9XhQW6oivh7DORjlNuXJTJu7LZ17MLCwfKg5PPoTERsoX9Pgmd2abiMmChHXuax2nVq1W1VEoQYJFz8GfNLLjjL2IfbFlhFGegsH8Ob3vWOcOqkj/uwucX3m+16NdAkDlZmp5n6v/gzt82Rsgw/GUKz3q4gnEV+YCPB1CwwJ155Z+oYSRrbul5+CX7koiGltPjCkgmvyMVbghY92xBSbdFf6kcm2rCMrvRLOfqytX8Sh0IszyEFhK0dv2HWcQ2Hw0+XRMcQvFzcAeuo1f3V0BqnWgr+TprZHg2X6Op5tMah/zpsnUoSodAw7JmTqj5TIs3umvE89KSZEzdqQ0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB47542CCE94A38BC88DB2B1B2C6140@BL0PR02MB4754.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:BL0PR02MB4754;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4754;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;4:RU8cG5h++hJAfnjobYEmszEqX6xCnSLhn7zCqq304G17XSxK22jmosmFnZaxr0YpKaTtfRvVO9KVVj+SAfl1dhyu1UlBBD9SKTu1q2ztuxW/WCGFm9nMGj5catbVPuFTopOx9edLysiYvVZI1TjLjSBhOABWsN8nfPncKFM1ear/ofEWYU+IDlihCu/1ROfMh4yFAKwj9ZWgORQX1i0KVs2/IkzkOP9vxhYfAM1p8hdo9Z98/FPGreB9lEjfxA8XWQOpoP1xcNpGHbvtdYb3RqRD66cqSrEAekdMzg4FrvgDso8E0FFZbTUhfUMHZfcu
X-Forefront-PRVS: 0808323E97
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0NzU0OzIzOjdJeEloN0RLTFBpbU8xS0pjSVJWMXNEZjhT?=
 =?utf-8?B?R3kxZ09jMkk1Y1hVcVVmbWpZSU9lRUxPQUxiUUwrOTJhQUc1YkloUTJwMVlt?=
 =?utf-8?B?K0xMeTNiTUNWNUx1MEw0dit3aE41ZnZqRkpaRFVWTVJ1Y3QrNURGOVVUZTJX?=
 =?utf-8?B?S20wTU1nejlDQUx3cnpKVjlCNGU4RjA5ZlVaUENLL2x6MzBMWVZ5K0JIY3F4?=
 =?utf-8?B?d3I0akd1QXpjdHhCYXJZYTlaNG5aVDdIOE1WY0YzVWdNVUxQL0dNTjFsaWUr?=
 =?utf-8?B?aDRpU3doQURwbGhvZHhScjVmdWEyTWRQSEFDdjcwR0hDQS9aQVBLR0hWUmc5?=
 =?utf-8?B?UzhkMFo0VWNyZStSOUZsNkhNdld0eFZ2Sy84dHZ4Uy9SR1FpSXRVOFp3Z3hx?=
 =?utf-8?B?d01mcytLbXN6UllkdC9ZZURkZ0U0SGd6Mjd0cXR6SnJzdkszQUNkcjlRSWNr?=
 =?utf-8?B?NEp0djl0bTltRHllVkRialBVNFB2WUNpM2dsYUZudDNMNFQ2VDdUTGQzS29T?=
 =?utf-8?B?akl0U1JJYnYyWEx0bUpvcDV3YWQ5c1Nodlprck44SHIzRm9pbzdUUDY4eHlv?=
 =?utf-8?B?ZFpnZkRuOUM4Y2hoU3RTT1kxOE93V0xneEUwaTY5d3MvRDY4WXBTc0VIODFF?=
 =?utf-8?B?YXdiK1Q4QnRnZzlKOWJVQ3BOYzJiL3lyVm1QM3ZrYzN5V2Y2VjFWWWh1NDA5?=
 =?utf-8?B?QUNoTkY1U3BiVWtOcklWSHVaNHR3TXFwcE5La2w5RHpsRFYxeVRic052RUs0?=
 =?utf-8?B?K24xRW9uU0h1YkJEVW5BM3BHdFZqME9tcFhndVJiSmsrTjVtempmZTlMSld2?=
 =?utf-8?B?eDV3NDFtZDZUNzJoajlUUklERkIyMFF6dUVaQ201aHNzWXNEWUI0eHVtYXlu?=
 =?utf-8?B?ZmpMVmJwbTlFOVgramZETVMzeVpxUnVpWmRvaXhYamVKQzB2d3kxbzcvNWZo?=
 =?utf-8?B?OTRyUmVlaG9Ha2ZIUS9PN1VTTHVtTnpzNFZjb25FaUt5UzAxSEcwZXdDVUFY?=
 =?utf-8?B?ajFlT1BvOWRBb2tERldnTWhnT2QzZmxjWllNR3hiSFV4b25zSWxxZGN1NU9L?=
 =?utf-8?B?SEtXR2tIMVV2bkRDbVdiME43aGkxcVc3cy9oNnN3NWZCVlp2RitEbC9LcXFu?=
 =?utf-8?B?eFU0TXZPb1RZZ3cwREdoelRiUURtL2xhTVVDbkxzaUJOTlM5RnRFeXpoekFT?=
 =?utf-8?B?eWoxTERhbWw4RzlNMWszN1dVajdEY0RvQUVxQU1zSGk5aVRucHJCU2RjdW9H?=
 =?utf-8?B?OFdsMlZxY3ltMlhmMWZmOHhVZ0t6T0VOYllzcHdCUG5JNTBTaHhKbkgrOTli?=
 =?utf-8?B?L1pCaWI1eUtha01ZUDB5cEgxNldadElkTXNMTXQ4TEdMcGdwSE5xTEFjTjFk?=
 =?utf-8?B?MnRmRlhTVTJIeS9xY0NXcnYyRGhEUTI3dllEbUVyc1E3STU1d1ZPemdOTHpJ?=
 =?utf-8?B?SVhsKy9FdXNQT3hoeWhKY3MvNFlGVlM5cE1oSE5LaHp3akJlWTVZZzdqNGpY?=
 =?utf-8?B?N1JPdm5YUFp3eW5BQXlpNk9MUUNYQ1FwK3JOdkdYazZESVk4UWcyYjRLVlJW?=
 =?utf-8?B?a2E0Q1M5eUNSbkhCamNlS0FwUjlkQzBYWHFnZkg0bHVUUUxrN0t0MkdENmJD?=
 =?utf-8?B?VjFSeGxuQjhaN2xuRlA4UjZ5eW5iYktZN2JxZ0NMRFN4VnMzSmFsMzBWUXNk?=
 =?utf-8?B?WjhNNW16MnhsczZZenV3OE95NkUwcXRPWkZzSkw5SHR3N2crY2dSS2VZTkRR?=
 =?utf-8?B?TWJuY1pSeEZVM0xpdVU1eVAwMTBtUUdBWTBYTXZZY2hldmtNbEovV3hZZUo2?=
 =?utf-8?B?aXZ4RzBwaEo1elRzYzFBNXNVVDl3Wk5wZ1VNYUozRExFek5IVXBXRFBtZGdp?=
 =?utf-8?Q?Yf6c5gQeKM+Incrav2kyyvDma0NdGTju?=
X-Microsoft-Antispam-Message-Info: n9Jguf03J3m7XDr+0x/Givk6fd/fEX9+VUOtFsGGvfcPx81g+jc8SlYPjah6JqXAAmscVhpBYhkSfj6eQIFtYMwQFYiEIqfNARfzMkRI6Vepu0vNOMATuG4Kk3PLQqCgu6T5tDek6eKkCvMuHmwHEJKKFqZcwxHHclcIjnR0kq1uNL47voZRGSo3yOmpvPUbuD/tTcyvWwMzQ0ZBsDHcNE2YxuLCiJDC7vj0hUUA3WG45nP1bdSIkAiuD787veZuJM3Y6LgiRsTWqThtw0rsavNxrbkZRmYPjcWlqd9haAb073+YaH1ssqYV8uR4w7Rpd1YEesLsq/AGPsvsAAeV5HgnB7sqXON4k5NQXoC5/+U=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;6:uy1CJCX7oZEvTRlT8wOa3VzgRM49A+UItGO5uYJLQQEahx3l1VXoc0Xnz0pzLO4F/X1tmZC2nWM5WJGd3GHzrex9EwW2jmssIj60uspFJuTGPCMOCAOuaDvH62sd8pxmOTPdHiH+G+aS94/ONylfnHiV1gNMWmXo5rndLMMriMRxf92uBRu92GMx3KnUiwLIjk7/YW5D1t0aHyBAA0dKeEx2Uab6Uv0Sp8oFC1cjPZ26TTNMVIYjkSMDRWkJySSxIjbM26LoFUUXEMlHbgM+SkzkfEOYRNYW5HvFpqs8lpWjZBG/OkzPLNEbxWAmFKoACREXrcfiH82I3mxM2txmT4qDqcwBQWHTrhGX0QSAQLBEetLmx3ESzIZ2RcWxvBksxJvM6n7kVI7j3gbjB0XTdIqQNDMG6mTTaREVLeHwBEfvWg5HUeAhyE1bMEeHB6d+vN1OEvNFW8m/WdP4o2BtyQ==;5:NUpS8wcsTeRp0PLlqjdper7QDedDsH2BiqU6bb2ii6w6MLTA2E2+OL4IFgFzyWo1zYApwUOLXn5Ta0EnDd7a2s0XoKbQO7iGwtqmInv7f3CyXVsV265vzpVrAfPrY1wn9EyiESKqPS+h7eMUxb3hIOY1v7YDO9X2MKeDMu94S8A=;7:qwTJZzRAv+X+ScAQMxochUsPZOUj9BoOUpZcsyG/iq0sTB6OzIA64hfra5q8SHMjgyFJ32ZdE93ThpM8jgXubqlqgKzFTki9D68O2JRspiNp0c8r1rAjE5C6KKjuiwTNDtjKk37dDIJqcLQ8v2I7BmUobJ8a8FyuFheSqO6PqFf7+0FNt1iOEUb0zsqiNOx3vfUmrVgJcqhO1sFcJwpibySxnkdBmN28+xgGx5vPyoeiYVFByUaFSpOH4jG2tlSm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 06:53:02.1908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 598a6d0e-bc4e-4344-63dd-08d62445dead
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.9.2018 17:34, Randy Dunlap wrote:
> On 9/26/18 4:06 AM, Michal Simek wrote:
>> Fix english spelling in of_alias_get_alias_list().
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Greg: Please apply it on the top of tty-next because patch is going via
>> your tree.
> 
> Maybe a few more fixes first...
> 
>> ---
>>  drivers/of/base.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 33011b88ed3f..ffcbb2963ba2 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -1948,7 +1948,7 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>>   * @matches:	Array of OF device match structures to search in
>>   * @stem:	Alias stem of the given device_node
>>   * @bitmap:	Bitmap field pointer
>> - * @nbits:	Maximum number of alias ID which can be recorded it bitmap
>> + * @nbits:	Maximum number of alias IDs which can be recorded it bitmap
> 
> s/it/in/
> 
>>   *
>>   * The function travels the lookup table to record alias ids for the given
>>   * device match structures and alias stem.
>> @@ -1971,7 +1971,7 @@ int of_alias_get_alias_list(const struct of_device_id *matches,
>>  			 __func__, app->stem, app->id);
>>  
>>  		if (strcmp(app->stem, stem) != 0) {
>> -			pr_debug("%s: stem comparison doesn't passed %s\n",
>> +			pr_debug("%s: stem comparison didn't pass %s\n",
>>  				 __func__, app->stem);
>>  			continue;
>>  		}
>> @@ -1986,7 +1986,7 @@ int of_alias_get_alias_list(const struct of_device_id *matches,
>>  			pr_debug("%s: Allocated ID %d\n", __func__, app->id);
>>  			set_bit(app->id, bitmap);
>>  		}
>> -		/* Alias exist but it not compatible with matches */
>> +		/* Alias exists but it not compatible with matches */
> 
> s/it/is/
> 
>>  	}
>>  	mutex_unlock(&of_mutex);
>>  
>>
> 
> thanks,

I will include these fixes to v2 and will wait for Geert in connection
to discussion we had in origin thread.

Thanks,
Michal


