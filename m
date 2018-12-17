Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC78C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ACB20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BrDo8Flz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbeLQPdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:33:03 -0500
Received: from mail-eopbgr790079.outbound.protection.outlook.com ([40.107.79.79]:45792
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733263AbeLQPdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nocNVWEJOhleL2sZQLQ7zDxu8FdjYewGNri7iLxfk9I=;
 b=BrDo8FlzlkYcHYPDUOX/PQo3ttDmgBqFoQjHHPG9a4xXZhRyJtlggWVzVYxALDrwoDfguYj1lMYt9VUKjhDlxVvPUHWyMj3oOgAU9iTPstx1LcTK+es+OS11N9SIUy4avD3/DlnXgmNO9GmA4/tyLKrgOyfevRo9u1mHHoPNqhU=
Received: from MWHPR02CA0009.namprd02.prod.outlook.com (2603:10b6:300:4b::19)
 by CY4PR0201MB3505.namprd02.prod.outlook.com (2603:10b6:910:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.19; Mon, 17 Dec
 2018 15:30:07 +0000
Received: from CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by MWHPR02CA0009.outlook.office365.com
 (2603:10b6:300:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1425.19 via Frontend
 Transport; Mon, 17 Dec 2018 15:30:07 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT034.mail.protection.outlook.com (10.152.75.190) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Mon, 17 Dec 2018 15:30:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gYuqM-0007bf-J4; Mon, 17 Dec 2018 07:30:06 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gYuqH-0002pM-7j; Mon, 17 Dec 2018 07:30:01 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBHFTxxw001956;
        Mon, 17 Dec 2018 07:29:59 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gYuqF-0002mR-1d; Mon, 17 Dec 2018 07:29:59 -0800
Subject: Re: [PATCH] serial: uartps: Add the device_init_wakeup
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <ec9fdbdf1c444dc60edfc75a31583630e76a9b72.1544016009.git.michal.simek@xilinx.com>
 <20181217151520.GA12453@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <333f4be8-a4ae-4276-e2ac-725d1ae4c9b0@xilinx.com>
Date:   Mon, 17 Dec 2018 16:29:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217151520.GA12453@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(199004)(189003)(54534003)(65806001)(44832011)(8676002)(81156014)(8936002)(81166006)(106466001)(2906002)(476003)(2486003)(36386004)(6346003)(336012)(76176011)(26005)(9786002)(77096007)(486006)(426003)(446003)(186003)(126002)(23676004)(11346002)(64126003)(2616005)(65826007)(478600001)(316002)(58126008)(6666004)(4326008)(110136005)(356004)(106002)(230700001)(54906003)(229853002)(14444005)(31686004)(50466002)(6246003)(305945005)(5660300001)(31696002)(65956001)(63266004)(47776003)(36756003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3505;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT034;1:U/MX7RbqPwkATDAbICcfV0pgzUE4gLwdHWM2A685cROCutm2DulTuFcpoCN5x5ju61TYjX5370PLhn08GByPOb7UnQexauPILbuFSq18QYXhtP8uwvzcdzNCSvElSyPG
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cc72cab-bf27-49c4-1b1b-08d664348651
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR0201MB3505;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3505;3:1JKuaIGMc2dpOQE3s3IuCp8cSlB3VOPaxK4D6HXkqlnsToqbRDM4TLzTc/lPuYZDqk9NPPYi0PgJAeLNVO6HsbnpjWiSp7hqKCdUMg7uytMx2ISvG9HvDgsYzY6KqRWHH+7lN0oUqE/85uWTnoHv+vGudC7RpxbsLtaDmNIbSfumYfnI5JczbcZcGoNobhJbpebDMXVYXJdtVqMKNQ+0Lefk1Z62nRwBGw/5/GQXeZl90FsoNiZlW+HgWy7if4r2cM7rxrkVbwpPQJ+FgTtb5D7f3x6M59KdSnRNMKx/oEzjptPBlXY4kXwk/hg53krTmA3ABUX7I52hlp2xmBLURagsZVk74tcJZL+zq/zDPko=;25:Nl1z4WoYpCwYAII0SHuzjnt5DsFGhdVYaVJLmiryXs95/qMdp4g2RjZL9vy6Wz+AHR2U72Xg4oPAYysV0WHQH5AXxq3XQVwTS1Vx1jNF7RwQgqkUhVZ5kjvW5hXgaaIqCP+gxgJgmtRiuM5KnEk1cbStXCsju3GhSTIgBxzG1lH7ZfN9CZXxoIEE9jREL8oPTAVeXIUoyTcLXPK2585q+CE5EL1xfff6OIumm8gHZV+kAawqY3ONk8Fd3RNeRG/NG2dymjPk37KndnU8vT1G+oJjubNY1PG0XGm9omtDbou0P5zx0o8Rne0m0m7bZ7z48j5u2Qowh7gnJbMxtrRAqg==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3505:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3505;31:x4oOWMqsz8WjST9p28r0k5Qy0O8IHfAm2HM/CHMdhRrK95rxt+ok3uv6gMyTsLAypzpR6RlZ2ajIziPW1ZQIsaSwl9KfYZoJ2fzJhTLOk6AKb8BT5MhttKI4ficgVQdjrMAQv4gueJFLo6cBITKOtNkMSemy4t0qN4K1Oy7npG9Gul/tiPrY1tPGt6HzVPya/ANjDggSwm6sdpLAq20A5bGrrfwQab3oAwYtUwhBjdU=;20:oW/HCA9vDyoUHYEIWHqr+FQVBw2YZgIrtyuPLd0iTgUn+8OY1mlF5/bIGxHUWo5zdzCI0t+yExkZMzTM06hUbjn0kRahBEwou+5TtqOzK+MhV2ZBo70tSudGAtcOz+C/sPW3WTPiNmwKpUrIBvQ/s4cic++71lSKQebjIJuooI3w6u+R64wqDvtQ6yMQEnxGNEh3RIPBzSGKbNvDGueI5hS8DlK5tlTyeQn/G5d/iMQglwijukgcHlR8BrHFsaTTwXX5k5zHWbpkulq+ojBZH3bGCOi2vvWlleftvO/llbyeaNG/X8tB6fxCPSE6octedRmV0BvYwD+K4jhbTl+CoRe9IDSbq1bsC073PJX2BUScjNAvlRy/jaQ+f+rLw+Uc4eTsgy85tEoo+XIrkBUopDYF3izwGcrI7bfOLQjUiuuh3wuvkQjaqpC2bPuW166VvcHAMGme2Z86cRFgXu8YU+TrY6jdKuzGZSqb/2piih6nyVV8ax0YIAKOtcgGoYE8
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3505536CF39E2F138AC62ACBC6BC0@CY4PR0201MB3505.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93004095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR0201MB3505;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3505;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3505;4:OHJ2eKrF3CEu2rc+ydNV8jCArAuXwjsyEdAqjSqbd58gxiR6SS/Zo5HqBTlX0KO/mselvK8IGIq7oK8meYCRY95k4GySTu/Tbw+GrX9Tb8VZ/l+/BlkUIix7MtiDlEQTYT2SL0Jml1fjdC3jWQD+hDahOVOVSAwNlWxyIkTQAGIUZWhF7RDjvMKbedNt+E5EySsNJHmnbSgtol29CvlFSdiW86t4V7FplEIuaEZDbaND219Tbpqcraa8ZrLbPQX4nnoYexLE9BU5mcWLaso8/A==
X-Forefront-PRVS: 08897B549D
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyMDFNQjM1MDU7MjM6MmNNem9GS3h6dlFyRlEyYmw1VXorVjFF?=
 =?utf-8?B?ME5VYm4rVklwVDRUN3BpOWpLc3lLa0pwdEVha0t3dVNxbnJxa1hXMU1wRjlC?=
 =?utf-8?B?N1ZEK3h0WTZHditjZGN3MGdjR09sUGlmMGRiRlRiZFU4MjhKZEkwR0pBcDhC?=
 =?utf-8?B?ZmUrR1NXalZhak5xcHFla3J5VFc2a1Zxa1Y5bElkdXBkaU5WMWo3ODV4eFlZ?=
 =?utf-8?B?aC9oemErekRWbXh0ejdLRERJWU1kSnhCWFBNdW5TZlRFem9KeWZ3SmM4UWtC?=
 =?utf-8?B?NlhRdHdSOUZNN0ZOWjNxaWNXTDMxbHJOTVBNNkRLQ3dCS1VSNVBjN0RwSG9m?=
 =?utf-8?B?UDhlOEliOG5KZE50MXREb2hMWllyMlRBWE5ETG9JOW9aUm82WHF1a1ZjSU53?=
 =?utf-8?B?ZEJaUVg0UktVNUY1bzUxYTB5eW5BYWsrZU44RjZ6b0FEK0tyUWplSllDb2xT?=
 =?utf-8?B?eStuVlRjcklNQ0x2UTJVdWo3aU1EODI5cTBHK0NlcWphQWs4bGxzdjhWLzRw?=
 =?utf-8?B?ck5PWTZzZE1YVEU0UlNpa1dub2lPck5tYlV3Q2FST2F4N1psd2xXdnZhK2dz?=
 =?utf-8?B?YktYQWZmeVdqRSt0Q0kwQlNjTEFicVlnQnF5QkVTQlA5blFYUDZaWnUxYzZE?=
 =?utf-8?B?aGc3bVlLQ2V2RGJCK2dLbFVPVGVPWkN6V3NnMTRURWhwd2I1Q1lVVkNJSWhv?=
 =?utf-8?B?ck8zNCttSXpkQkwrM2NZY1dteHJIV052ZStyMlFTQkQ1UTMrWWZIY3NwUDNv?=
 =?utf-8?B?Wm8wdlZyM2V3ZjNJNFRBbzZieCtMUXBwdk9EVmc0eGt5K3lZZFBmdWN0dE1W?=
 =?utf-8?B?L1BPMFp0L0RPKy9zcGJGT1IxY0VkUjY5eFZodmVMUHRLemY4R0ZnVmpiRzdi?=
 =?utf-8?B?dlRnaDBIMzE3NnhnYTRoZDA2cFp1aDVtSzE5SVM1MytXR0pRdkhJWnhkU2hl?=
 =?utf-8?B?Y1gyb1hlMjFrNXBQWVdaSERoQnBqSFpBbUFIeTdFQ2FpN1RZdXlnN3Jxd3d4?=
 =?utf-8?B?RGJwdVhWSS9sREZoQTR1Nzk5WnQ0anZDNHNvRHNhV3l6VHNOM2NNYzY2WmxJ?=
 =?utf-8?B?TWNMQXp1YUVYWWJRdUZSb1FiRnMrWFVJdGVqWmpXUVE0ZElpajNJT25haC9G?=
 =?utf-8?B?Mng4NzgzaUw3MzB5OUNCRTZrU3M4Y0xUdk1CTEF3NWVuN09oY1J0dkI4R2VY?=
 =?utf-8?B?cGdRcDAyckwwNGNiMDlYOVhoc3FIRlpmWXE4U3RITEFJR3NUNzFSQWhHSGhC?=
 =?utf-8?B?eFM5NzJXNWlTUWR6bnBNU29WMGZVT2o2bzhNQUxmaW1MT2wwTUd1TFh2SjNG?=
 =?utf-8?B?SFIvKzU1czI3NE44U0hsN0hXd1loZUtWNFNVRW9Mbkw4Mm1SNVVaN2c1NXJW?=
 =?utf-8?B?dngyZlVsM3lBL3BiaFViYzJ0SjVMakoxZlpOT091WEJSb09rYlYwQmNLL2Vw?=
 =?utf-8?B?a1gyM0RreW00cTMyVEtaempSaklGNWFVZnU1b0I1VjdhWTh5eHc1SmdIWFRp?=
 =?utf-8?B?QUFHR25Eb1RXdVF1UVlYUnpWK1VpcnRzWDNGR1htSVlBZUxDeE1xV3F0Nllo?=
 =?utf-8?B?YVFjT0N1ejBpMGUwekZJNWVnMksvcGtJd2NxV29ZZVpaYlJ5TmhRUFpSYmd0?=
 =?utf-8?B?Q2R6bWpNWXh0SENTdVNKL1dVamFDK3lFLy9Td1lYNGhKbmQvMHFxK0l0bWcv?=
 =?utf-8?B?WlR4VlhkY01kRkVHTk0xMWVDSlVTdEg0cTFvUGZ1bkk1bXI5WTJ0MHhiWXpD?=
 =?utf-8?B?RGRQTll0bGVCaXVqOGJ2d213PT0=?=
X-Microsoft-Antispam-Message-Info: 1VHDDoTLf46xihHDZi05vxQQmB6a/GXdrdJDsDrVstyTLbzDJ/TD8xXNJ0yKMar9/iVcy4UlzzOMc3+2SUq1iq83HX+MGGRHLQRcAdD5GDm3rdKWK0siK7txjEhN5358/8oSGl9NoeERlUWgB4ixdgdHOtk6rTeUV/SFruyjLGRBo205IuufJ8rP/Y6cS5pDBiZadGDlYAv07TbOdrvlOD5MiroGTYKoVt6F3g0CqSZEwUav2qz/FnQ1mxF4LYg4h+O1x+3lLHbcDJ8PNvg1ToBCj1Z3i8b3jtL8DUqXSiiEcGck6w0XpzKDMiXbnifg
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3505;6:xyH1w5ZjBadzKcey4A0jD9a0fVaDVHZ5OBLn+3fZI53QIKR+DbPfj9Hm1IkcD8mJSK3wFv5UyVC3sKhqSEPs/Gp01EL4MUCzU3R1J1WfaqMDNUL7kdbhunPzyFgoqHX9+s/cvzLEUiXoVLF6f/+wH9CGFnRsi3Z7g0KUTABt4UArX+vnFcn23kF8swRrwZ02pgSCVFLxlxv6Loc2w+Lx7jg+FG09IexJUNVRCqrYzLR8GTh34UbA71BsSm9fbe3rSwJd8i+NuxI2Va7HkeUJk0dQSGdAA//4ksYObUUSZkrgufaT6D8cZKzyhFa/x5L02OW55hYR1PrKvpx61/ygWm/2F4LmENgnXvfsl4U25zA9BmfMMC7+31AYxy4AOxcZgNnRZsIpx/ZukmGN1o2/+0sWuM3eF8m4Un7hyn8NMMx9C1yMEAmvrd0n9vajr+yN74+DRqpSSVqpMBAwRPE1XA==;5:FOk9D1qK81GJZRJfRjvnSzxc6O61Ff+K51fJXWPsu8S0xDtt1Z9AUpojBolV3oZetsvCNG/dMKDA/uvrLXt2foh0vqyOFBQhhHYPj9hG56JAgmMGCFj/EkZW19ZQEqpM41OiVLv+9ozRWwAgRY9vjr7xt8jN0DrG6EyHijX6/h0=;7:fH0loGhJLgNgyx7wCXvpLwrNPNkMHkl524ZxaMO7w7bcNTdNevXN0+DA7adU9WoqWEawOFZhjWIn/EZu6R3MRCZ+QAr1xPKNtXw3C48LnXj2atRC9G7aYM9jz0uuPXLJ8zfwV7DcOuIwb3fRR9an6w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2018 15:30:06.9980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc72cab-bf27-49c4-1b1b-08d664348651
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 12. 18 16:15, Greg Kroah-Hartman wrote:
> On Wed, Dec 05, 2018 at 02:20:11PM +0100, Michal Simek wrote:
>> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>
>> Initialise the device wakeup.
> 
> Why?  This says what happened, which you can see from the patch itself,
> but it does not say why this is needed at all.

We will fix this.

> 
> Also, you sent 4 patches, without any numbering, so I have no idea what
> order to apply them in.
>
> Please fix the changelog entries up and send this as a patch series so
> that I can correctly apply them.

They are all independent that's why I have sent them separately as
single patches.

Thanks,
Michal



