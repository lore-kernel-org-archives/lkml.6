Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5DCC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14B726FC3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ETnSbFLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14B726FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933662AbeF1Gje (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:39:34 -0400
Received: from mail-eopbgr680060.outbound.protection.outlook.com ([40.107.68.60]:55029
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933153AbeF1Gj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDZrW93AraiLXFH6wv9g5FsDnOjcqYEll192IfP4Xi4=;
 b=ETnSbFLq9SUlz20hUuENcc6oDNaCxA0wDm/KM19lPz3FgcWWCT+3n18V2BhQSCkejRjKkBr0L3E/SDCIIHUCvPnnLpTrjKJ3D7BPOe0qYJHcQmq99ZTfsQ7nivt+3rPVXT4Bvf7DWaJRamMzY9cv6u2U74jZqoOoETye8XArQRU=
Received: from BYAPR02CA0068.namprd02.prod.outlook.com (2603:10b6:a03:54::45)
 by DM5PR02MB2650.namprd02.prod.outlook.com (2603:10b6:3:41::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Thu, 28 Jun
 2018 06:39:23 +0000
Received: from BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BYAPR02CA0068.outlook.office365.com
 (2603:10b6:a03:54::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.884.21 via Frontend
 Transport; Thu, 28 Jun 2018 06:39:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT010.mail.protection.outlook.com (10.152.77.53) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 06:39:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45922 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYQaQ-00040k-1h; Wed, 27 Jun 2018 23:39:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYQaK-0003Mj-Ul; Wed, 27 Jun 2018 23:39:16 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S6dC99024900;
        Wed, 27 Jun 2018 23:39:12 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fYQaF-0003IS-SK; Wed, 27 Jun 2018 23:39:12 -0700
Subject: Re: [RFC PATCH 3/5] arm: dts: zynq: correct and improve the model
 property of dt files
To:     Luis Araneda <luaraneda@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-4-luaraneda@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <05232c62-0b3f-d2b1-3e28-98f0154942ef@xilinx.com>
Date:   Thu, 28 Jun 2018 08:39:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628054205.17737-4-luaraneda@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39850400004)(396003)(136003)(2980300002)(438002)(199004)(189003)(64126003)(316002)(575784001)(2906002)(31696002)(106002)(36386004)(36756003)(6246003)(58126008)(110136005)(54906003)(486006)(39060400002)(2616005)(44832011)(126002)(8936002)(9786002)(81166006)(11346002)(476003)(230700001)(186003)(106466001)(65956001)(76176011)(336012)(6666003)(26005)(2486003)(65806001)(5660300001)(229853002)(426003)(31686004)(77096007)(8676002)(63266004)(446003)(47776003)(81156014)(305945005)(478600001)(50466002)(53546011)(4326008)(23676004)(356003)(65826007)(107986001)(5001870100001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2650;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT010;1:lu+X8PC+Bf2VlnTgMkdwCy7mKIVlZEYOKrfnZShBWo+Q1f+xPNwM7KqNERheiAZxIrh8gGKuUQDim5LTUJhag7YGJb3znowkmC/ys5VQd/0uf7jQABDRfN6CbbqWNNQM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db44e541-461a-4fe0-17fe-08d5dcc1e278
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR02MB2650;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2650;3:garEmrCs6hxbv/bTA7GJP+imEMVzNhB/Vy3ICICVyuuVpr0wKROHYoRLrLX3JvWsBXODCLWh4/LVStddTPpkWYdoy+mm/yOa9eX+vCQf3azfkd8Dn7WqhUwnHKPFTZk27CPQyCNvipBnq8EOKnxkWwMijsIXdjTozr3tW/wqgHj70HZPmtzn05t346LcGQeWkJO0fTlKbeaTCU9WboUe1KwNx3QYXVdTdrivPRpwLvcwW8c1tYcMj3ir+7IQVuxdRxlheAKnU5PeEdK/o4S7BFKvu4Y37FEW+FAcC6lVQMinvMXHNM4ZXyChN7xTY20Bd04i8MBZEk7C/zHGdlsXFXtCOi27K+Fd3kVMtJaij+w=;25:H9k+Tb2Lc21jWU9LAiXtEKSx6D5z573faqVeaH/51SY4LowhGkEOfXaym8y/3i8foLeEp76erWGBq/jbALXKspOCBwZXFyTNN9JgCR8qrmrnrvoegYnU2qD/hUE3BtR34nf5GyzaZPSof9X9cj5mDAci4vy1XAmf/40WHDXhpg+A3TDs8aXKdYNGhukB+GypNrOUWBCYNhNZV9zuHviaBs3lk54XQ1m48fWxQK7I/l3XjH79SjPQ8GuLSJnAmo4TGhE1xzdWh6MGHFHCxnXVAjcIDzNh78+z/zFk1jugqBvBT95M9ETA8XRqMsUQ+z3cw9DL3T2mVTztIYafGsXovQ==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2650:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2650;31:y9otLq1vMeBRxcMaqGjWwwlUkQoSQxKUMlOaXIgksAZfB9AdNjwZElVRqnGxGkzYg3j72yU85BIwiwYBAqhXGEY23N3gdETGBFdkXFOjBvo708dKti1mlZ8G+/tTNhQunQCPFAq4oslDW/a4AH76BK5dw26Pnr1sXEGCNQqf0mPsx4vKQ4Lv7oQhblhFbLYDEYpEesjmbs3SyM7Fl+YYBlcxyV3y4jfx1oVqv9ydmr8=;20:hdFqkJ8uJZcFFH51RIjA7eJL0TMymJ1MlenjT200n+0alsxM+D4NiPI1yht6yab8BTt6C/vVRGMQ5V9wvY4uQdpCJQ616G06gsPWD28XLKthn0GGXReErHbxuedyGcm/dHITRk26revCjD20AVYyeIr/65kkmemVSqgMm+CG5D53/QzkYWNpW0oSTYTSS6kSVfxq/vbwHhQdMh0XUM41k/DH2fC/3cT0KhepoH8rPtkG2vY49LdO8STVmTiT25OgyMIYrNFBhLfDqpu1nSP/xSoCMcCnxeVe11Z++Mk+cW1gmOTup5H50oqj3V4WgIr8T5kP6oBv5ht9p7hvkWDOLugERlZFcDsmCNm732PgWVI4v01Ntbk/QIdjwaTbQwz7+8EEx8yGpJwaTRyx/sViOS00lLduOs1Ox+cs5VR3y2uLFPzTf+3SPkcTPb+EqT4ilwaqWkh4oyppUf9YdxxsBC3a48qBb4uoVsA5QHqqk9PJZgNJt81+r7vLTbIzgKDL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB26500AA21D3EE327EDBF5736C64F0@DM5PR02MB2650.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR02MB2650;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2650;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2650;4:lMu/ACn00m9LvP++3Cdm5B1fzxyiZ/4ZA1ybE7FQdyj/tepqSUqGSAJwT54nXVj8a0X2qBkRyQstboACho95I2+V0CthOMLDh04dFcfYnBDLQWXrUyLOevmhw0QERdg+vO7Tjp0qoUokUiDZqVMviSBz7vGdCE4Bl7FWsm+IK5SahM/OZR7kiUnFv8GLEivexMH+3uZC12m51iTn3q1kTnnkkJPGw/Gh3r1gXIWgpOymM+z0lHWW9TZL81paQH5OXyt4PuWLIxJUXXeev12uKffwPXVMkojt9pj11Ed428yKCWBruiG9KfRSBveCpCRHBy/FIPj6kbSyHzF3NHjerQ==
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAyTUIyNjUwOzIzOnJ6cEY3V2pzalM0VW1hRWR1ZCtvYVhNU0gx?=
 =?utf-8?B?SDdURmFsU0FLUEZ3aTdITVpUNzVhRXVpbHZ2STQrS200bURSb2FmRlhMU2lx?=
 =?utf-8?B?bjhJRXNIVWJyVlNPUlJtVS9RUGRhT24xcm41a0FMcmFzRTV1ZHN3OEFaVzla?=
 =?utf-8?B?K0ZnK3dXeG5JOWFuTUU2N1k5NFpxUk9SdnJwa01NZXNZTkdJeGkrczYzaHQy?=
 =?utf-8?B?N0tYRHpONTd6dDFGbDhtWVZ0WFg0TENtL2Uyc1YzSWcvb1VtbHE3MDhoVWZJ?=
 =?utf-8?B?TFFVY3FZOGlLZ2lMODlobzF4VjNuc0dyM1NXYjFRY0E2aS9uQnM5U3lleGF0?=
 =?utf-8?B?UEFwRXVxSzZIdVpCdjM0M1NZT01JWk9rK2REcGdiQVl6eEhVaUNpblN2VFRy?=
 =?utf-8?B?dlVtOEZQUkJZMGZvOHBuNy9OS3NvSHBXaG1pL3h3b2E4QTh1ay9GZ1pNdDlr?=
 =?utf-8?B?Nk80MHR2R1NZd1dFOWZjOCtaL2dIU0FkcHB4UEE5RzYvR2hOMzV5dHI4dVl0?=
 =?utf-8?B?Q3I0S3NIRUpMNmVpOW5DZE5DSnpFTW91aFdvZkNQWUFmK3JKT0FHWUprM1NB?=
 =?utf-8?B?STBLL2d2TlpPMGJCb0kwZW5rRHRESFhzeTArMnJSTC9oK1ZyZ1o5bFhpL0py?=
 =?utf-8?B?L3p3WUx5Nm91ZW14YnR4VnFJNCtaZlV5Z0dNZXgyTkIwWGE3VG1VMG5wd1hw?=
 =?utf-8?B?ZVRnZnhkL2orMk1hSGx1UE9PQW16NFQyc1IyWERrZWtROVYvczcxcHZuVHo1?=
 =?utf-8?B?ZGRyRzJkN01nZm1GLzkyQVF5c0cwaDYyY1FzeWZ4TWwvSjJXOHkzdVVEcVhs?=
 =?utf-8?B?cGw1dXBBN1RaZ2hWVzVvNVBzcGhPWFpIeG5hSUVYbmZ5RDJYVkhXOGUxNVVN?=
 =?utf-8?B?NXRlWi9NSXpUd2RhMmNqYlowZUgzNHovd1JEYUJIWFJOdkNSblZqZjJ6SUV3?=
 =?utf-8?B?aGwxYUZ6eTZyNWRwVlVBeU5ITEEyRlk5cVN5RmVuL1VEaHVGQjNMdllFWXVT?=
 =?utf-8?B?dmJ5a0Z5UkhYVmRwRUprNzFWcjBjZUVvdXBiZktzbzIrbVJkM2M2VW9jeUcw?=
 =?utf-8?B?YjFkVG41eWZtWi9IWXFPZ200cDVySVJ6SHcvbEU1RFpUQnVRYWJJeDlwd3Iw?=
 =?utf-8?B?UC8zSHg3SWNEaHFaSW1vdWpYQW1mcGMvRENHekkxaGIzMjFYcW5aZm9taElQ?=
 =?utf-8?B?REx0NDNqWGtDR2FEbWZ6SXJ3d3BRWlJOSEhXWUpCMUQyQ1ZpRVYwOW8zdm9o?=
 =?utf-8?B?UmZKWlFQMVpwN1IrV3Z4SW1adzQxS3Y1Uzc5YjhxeTh3YWEwcVJJTFllS1dn?=
 =?utf-8?B?SmhMSnNOYm42R2MzRFRXY3dVNC9oTGkzbHNpdjNneHVCdnNmTW1ZdXI0NTQ5?=
 =?utf-8?B?ODNDNTlPRHlweFI3MHdTUkhHU2RzQ0dZK3FKU1pJei9uMk1UTElpMEgzYXN6?=
 =?utf-8?B?MnhjbkpsNTRIK3FXYmRNWGpjTDZEd3Fhek9GaXQwUFZjWmFnZHdvYUVkdFcz?=
 =?utf-8?B?a2dPMXdRN2tDWGRJcXMxK1B6RmNBWlJKTGNtMEgxRlVHUHpOYUlOYXp5cmFH?=
 =?utf-8?B?bW4yL0RlWXRHNEhXZjNJQjZ4bnc4aUsxcUVreklGNXVWRTBidjNRYXVKbzRu?=
 =?utf-8?B?UG05SXdFb0ZKa3pTS1dRRWg3VElLTTZ6My9NZ21BbnFoeE8rOGVVSEZ4R3Uw?=
 =?utf-8?B?UHVpNGg2dFRMSG1qTUlzWDI0a0tXb3R2UVdPcmpHTGZYWVdDSFBhTzkxSGxw?=
 =?utf-8?B?MDdwaDRKT3kraVhuZGc1ZWh4RW9Damozdm40WWdDTTIrUkx4ZDRBZEg1NmUy?=
 =?utf-8?B?S0Z3R0Fsd2h3b0pTT3B1SHpWUjlaYURJT0JpYXVvZzhycWRzbG80RVZvVFNu?=
 =?utf-8?Q?2zMFfmhCf1A=3D?=
X-Microsoft-Antispam-Message-Info: fbmBvfpn2fUURBE23Zl5yhJhb3FS8rXF96PgB8Eq5WM+bxbxcmslm5moyJcD/d6PZajqHt0pMQjIkI1zOMcZL23SodPl1sa2CmAnykdNyR+OfVwPlTUtoTN6TMudIZ5HpTOVzgiRn+2Bz6y/fwUNYjCPt86cL0bCcgSBWYaxtYtnHunDEYXfREpZVwJHWKqXUwTbsml6g0RCtKSmWEFBbsCVv3wAQffb0P7ASEBMN/AYAEYu7XIg7G0HBckcVfeW3K+ea1/H/yy03PMjB2iwIVNMmEpAZ65dVCoHs+qesY2qMAQreCeJQH9Dh3DpcQ0kgNCx6RcsIzjMeoV8vRZT54FCJoKx0ZFzbnRBYb18SFg=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2650;6:dkbUmEDXp77hv+jnm1OIeYiMXUlbI/lzXTr1zsjgV+QRElzPy0epzfQy28rrBL5uYyhMom4Mv12WmpGEXBuqmR7P2kszYUIY5istPHEWEapdB3B2YNPxkAWuDG1gkrrycuC1m4dC8OlDUY8UDnud6RujVMHMoBR9IcL+azsz/CFT6sYmctW6SUgKpwc9kiRYNZpXVjgZwoQhiQ4fn45SFoiK4jEQudkeDJfJhuupezwhrr6pqvuMKk1fqVoPRsg1ks+n68IjsAzVY60f6HycDHniH+JkyBSUzpBa9lVPXjWa0dfU9klfmsPKi9RIFrLBUikUE+LU2p35tLEtw9Pk1lgToOKi9MIjEwWdm9O6giFQgxcHxp8/rMXDM8ZAbBnB/UP4jUsdCB7mzy9MA/sdK+cmgUQGYJjeqQPjX2vcrK4cUcet4MVudNEX33VSYFiRfea82hLTxw+osZ2MkExjUg==;5:MhhfyGgDNIujM/L2hh1OkmcjT3WqfxrBVRK8FS49afihUgfch3IgXYN0+aqsGIrRujKkdbGSedSLYrxEwZVB58CqhJa0nMGVTzQaTSgqpWGsVYOHVciSSJjktcBvtspgBeKrjTUsVZq2dGA3ZpvYV2fmwNW3En2UOO2Y335Lfmc=;24:GkuEPzYrU8KlE00CLOQ8Qhk8xBeG+k2gH3ZH2kxHaiSYih/rEgtic3BqAGn/lLBPIXvcYYBLU0uEpQuTBqebcVuxZnf75WNua0y6e6k/V80=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2650;7:0F1wB9JUEOc9zNWuhWEgfyGd8b+f/qH8e+tyN3htN4fPZpPAz7Nru3N2XRMOGz+g8SHpsCksSzlSQ9oIdzj+upL3AZd0sFncvu1w8J0hypHgXB85LznTf0T5kGBGb8RoI6RQKHSYSliqKYCJzYDH7iKdx9gKG/UH7mwlGGpZF7qdQm1/Fevha1WFPL/38AFKmaKqLRQuqnwf4FjI1kRnBfw+DsBMNUiF+nz4XH3r0P+vZC5VwBbA9Do/zQELC3/r
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 06:39:22.6457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db44e541-461a-4fe0-17fe-08d5dcc1e278
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2650
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.6.2018 07:42, Luis Araneda wrote:
> Replace the current value of the model property by a more accurate
> description of each board (which includes the manufacturer), as some
> of the boards had the same value ("Xilinx Zynq")
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  arch/arm/boot/dts/zynq-cc108.dts       | 2 +-
>  arch/arm/boot/dts/zynq-microzed.dts    | 2 +-
>  arch/arm/boot/dts/zynq-parallella.dts  | 2 +-
>  arch/arm/boot/dts/zynq-zc702.dts       | 2 +-
>  arch/arm/boot/dts/zynq-zc706.dts       | 2 +-
>  arch/arm/boot/dts/zynq-zc770-xm010.dts | 2 +-
>  arch/arm/boot/dts/zynq-zc770-xm011.dts | 2 +-
>  arch/arm/boot/dts/zynq-zc770-xm012.dts | 2 +-
>  arch/arm/boot/dts/zynq-zc770-xm013.dts | 2 +-
>  arch/arm/boot/dts/zynq-zed.dts         | 2 +-
>  arch/arm/boot/dts/zynq-zybo-z7.dts     | 2 +-
>  arch/arm/boot/dts/zynq-zybo.dts        | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-cc108.dts b/arch/arm/boot/dts/zynq-cc108.dts
> index 1a0f631c1..8b9ab9bba 100644
> --- a/arch/arm/boot/dts/zynq-cc108.dts
> +++ b/arch/arm/boot/dts/zynq-cc108.dts
> @@ -12,8 +12,8 @@
>  /include/ "zynq-7000.dtsi"
>  
>  / {
> +	model = "Xilinx CC108 board";
>  	compatible = "xlnx,zynq-cc108", "xlnx,zynq-7000";
> -	model = "Xilinx Zynq";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
> index e40f40a7f..3cc957428 100644
> --- a/arch/arm/boot/dts/zynq-microzed.dts
> +++ b/arch/arm/boot/dts/zynq-microzed.dts
> @@ -7,7 +7,7 @@
>  /include/ "zynq-7000.dtsi"
>  
>  / {
> -	model = "Zynq MicroZED Development Board";
> +	model = "Avnet MicroZed board";
>  	compatible = "avnet,zynq-microzed", "xlnx,zynq-7000";
>  
>  	aliases {
> diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
> index c05f4b67d..54592aeb9 100644
> --- a/arch/arm/boot/dts/zynq-parallella.dts
> +++ b/arch/arm/boot/dts/zynq-parallella.dts
> @@ -12,7 +12,7 @@
>  /include/ "zynq-7000.dtsi"
>  
>  / {
> -	model = "Adapteva Parallella Board";
> +	model = "Adapteva Parallella board";
>  	compatible = "adapteva,parallella", "xlnx,zynq-7000";
>  
>  	aliases {
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index f2330b0cb..3f84b94db 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -7,7 +7,7 @@
>  #include "zynq-7000.dtsi"
>  
>  / {
> -	model = "Zynq ZC702 Development Board";
> +	model = "Xilinx ZC702 board";
>  	compatible = "xlnx,zynq-zc702", "xlnx,zynq-7000";
>  
>  	aliases {
> diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
> index 3ad1260ff..a15908cac 100644
> --- a/arch/arm/boot/dts/zynq-zc706.dts
> +++ b/arch/arm/boot/dts/zynq-zc706.dts
> @@ -7,7 +7,7 @@
>  #include "zynq-7000.dtsi"
>  
>  / {
> -	model = "Zynq ZC706 Development Board";
> +	model = "Xilinx ZC706 board";
>  	compatible = "xlnx,zynq-zc706", "xlnx,zynq-7000";
>  
>  	aliases {
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm010.dts b/arch/arm/boot/dts/zynq-zc770-xm010.dts
> index 6884f1ad6..0e1bfdd34 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm010.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm010.dts
> @@ -8,8 +8,8 @@
>  #include "zynq-7000.dtsi"
>  
>  / {
> +	model = "Xilinx ZC770 XM010 board";
>  	compatible = "xlnx,zynq-zc770-xm010", "xlnx,zynq-7000";
> -	model = "Xilinx Zynq";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm011.dts b/arch/arm/boot/dts/zynq-zc770-xm011.dts
> index b78883cee..b7f65862c 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm011.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm011.dts
> @@ -8,8 +8,8 @@
>  #include "zynq-7000.dtsi"
>  
>  / {
> +	model = "Xilinx ZC770 XM011 board";
>  	compatible = "xlnx,zynq-zc770-xm011", "xlnx,zynq-7000";
> -	model = "Xilinx Zynq";
>  
>  	aliases {
>  		i2c0 = &i2c1;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm012.dts b/arch/arm/boot/dts/zynq-zc770-xm012.dts
> index c3169d636..d2359b789 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm012.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm012.dts
> @@ -8,8 +8,8 @@
>  #include "zynq-7000.dtsi"
>  
>  / {
> +	model = "Xilinx ZC770 XM012 board";
>  	compatible = "xlnx,zynq-zc770-xm012", "xlnx,zynq-7000";
> -	model = "Xilinx Zynq";
>  
>  	aliases {
>  		i2c0 = &i2c0;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts/zynq-zc770-xm013.dts
> index 8bb66859d..651913f1a 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm013.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm013.dts
> @@ -8,8 +8,8 @@
>  #include "zynq-7000.dtsi"
>  
>  / {
> +	model = "Xilinx ZC770 XM013 board";
>  	compatible = "xlnx,zynq-zc770-xm013", "xlnx,zynq-7000";
> -	model = "Xilinx Zynq";
>  
>  	aliases {
>  		ethernet0 = &gem1;
> diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
> index 98381cc85..bf3e26dbf 100644
> --- a/arch/arm/boot/dts/zynq-zed.dts
> +++ b/arch/arm/boot/dts/zynq-zed.dts
> @@ -7,7 +7,7 @@
>  #include "zynq-7000.dtsi"
>  
>  / {
> -	model = "Zynq Zed Development Board";
> +	model = "Avnet ZedBoard board";
>  	compatible = "avnet,zynq-zed", "xlnx,zynq-7000";
>  
>  	aliases {
> diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
> index 1e713dc98..be40be9b7 100644
> --- a/arch/arm/boot/dts/zynq-zybo-z7.dts
> +++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
> @@ -3,7 +3,7 @@
>  #include "zynq-7000.dtsi"
>  
>  / {
> -	model = "Zynq ZYBO Z7 Development Board";
> +	model = "Digilent Zybo Z7 board";
>  	compatible = "digilent,zynq-zybo-z7", "xlnx,zynq-7000";
>  
>  	aliases {
> diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
> index a6c00e7fa..0439e9f1e 100644
> --- a/arch/arm/boot/dts/zynq-zybo.dts
> +++ b/arch/arm/boot/dts/zynq-zybo.dts
> @@ -7,7 +7,7 @@
>  #include "zynq-7000.dtsi"
>  
>  / {
> -	model = "Zynq ZYBO Development Board";
> +	model = "Digilent Zybo board";
>  	compatible = "digilent,zynq-zybo", "xlnx,zynq-7000";
>  
>  	aliases {
> 

Not a problem with this patch.

M

