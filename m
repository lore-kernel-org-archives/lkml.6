Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE25ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD89C2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SlroTxOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD89C2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbeGQO6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:58:02 -0400
Received: from mail-eopbgr730063.outbound.protection.outlook.com ([40.107.73.63]:13066
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731679AbeGQO6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ6S7cFrn98IHTyGODMxvBYc7hqtvhgex2PjWftjm4I=;
 b=SlroTxOIkM4ZZtL8wCP0Gj+qPFMU2kbtDmdT/DOdK+AfLjUG5NphaHROoe8nVzi5B9uNOxTNwUSLQRNKZno/J4hZMJXccwynZjip2Z72Do+IZqp7BhPSXHw1GQQ7fgB90Thaps6LWAjIK1hllnTKDemezO7Agg7xWGEw1pl2Sn4=
Received: from BL0PR02CA0108.namprd02.prod.outlook.com (2603:10b6:208:51::49)
 by BY2PR02MB1623.namprd02.prod.outlook.com (2a01:111:e400:5267::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Tue, 17 Jul
 2018 14:25:02 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BL0PR02CA0108.outlook.office365.com
 (2603:10b6:208:51::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.21 via Frontend
 Transport; Tue, 17 Jul 2018 14:25:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 14:25:00 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ffQuS-0007wx-6C; Tue, 17 Jul 2018 07:25:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ffQuN-0007fg-2y; Tue, 17 Jul 2018 07:24:55 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6HEOr4J019616;
        Tue, 17 Jul 2018 07:24:53 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ffQuL-0007f5-0f; Tue, 17 Jul 2018 07:24:53 -0700
Subject: Re: [PATCH v3 0/6] arm: dts: zynq: improvements and cleanup
To:     Luis Araneda <luaraneda@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180712041024.20583-1-luaraneda@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <c4ad9790-c7f6-03e1-84e6-e08782cf332b@xilinx.com>
Date:   Tue, 17 Jul 2018 16:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180712041024.20583-1-luaraneda@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(65826007)(76176011)(478600001)(31686004)(5660300001)(63266004)(6246003)(53546011)(106466001)(2486003)(23676004)(36756003)(47776003)(65956001)(65806001)(230700001)(4326008)(39060400002)(50466002)(356003)(81166006)(36386004)(8936002)(81156014)(316002)(336012)(64126003)(31696002)(305945005)(486006)(426003)(11346002)(106002)(9786002)(126002)(2616005)(44832011)(8676002)(54906003)(110136005)(476003)(229853002)(446003)(58126008)(2906002)(77096007)(186003)(26005)(14444005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1623;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT029;1:wcgNH/ajc6uClNffrjgtBiLlg89FyP7LNt1DCCHUD86Nho3yEMZL4cSADoVtL/oG1LHCMsFMJSPQlJ28lOSAbjWZiUBSs4kC8ovSu8MkhSnNtpnVS66rhLhBE42+yWB3
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a98ab434-2f15-45b0-422c-08d5ebf114a7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR02MB1623;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1623;3:zKOzTESrXPJqYlB+SiSoPcY8g3dfLcgJFJM3tFsiCS8LU/7cbms06YIpD7O81lxA5VX2EMilzJzD5+Kk8E/nM/AofpWu2eiBMsBUTCAxV1pC96e6B2RhSMYk9nfY3csqjs5Tq7+A/QURB4U2K2nFul0lE1AzZyiL+TPHP91f6kKsxMSYfgYMCbthBcOTzLrOkITcM394aHcZr5fY/klYj8YmkWgA6GLjboiKl8OdTryTzv3hpWX2V41YC6w9LunYCI008phpZmkxzV8McdC+WjRQuxDfSe9dC14lg/rrA8TaICe+aQtoe/xZBH7xhSdrHsJii9165qCJaqbAIjNdppyonTQxm1SmDmbhUjTbHWA=;25:Gin6bnhENTeQ5CEQ1QrjvNwsF4lQLTzyqPC7LmxFWERVrGiKNffDU0bgVlRTTkRumjVKUny7i48YD8V2l3bdJ7eS9LnZ/msuOjQps1vBXVu7goaT2bi3WHUcAjpFUwMjY9JdOSH3xfkVp8/KpFXFululzzMPN6mrkttFIRgvO8nSROa2G/9e3SS8V2X/wM5bMHltnehZabkbmkEWXB5IE8c44oZQji+vdCDBahFen6TggaVdO72O6sIcDtG1V4AxwRjCLDzzxnyX7FVREgYTnz3hnaxxbmCjakzHzQBFB0lhaJAjqeHNf1N+Qlzevx/T66pu+++T/p7v4BPCkle2vQ==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1623:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1623;31:CDI/yazih7diZMAHk1P6u997DImH8bbFT7a1Ts+24pewuMB/E8082iTHJOq3iDjLaPRTY+w8zYydpgI89WTug8n7x+fYd3oErg11SmvbTmOKSQlaPIMa/WgiYdutOpoI6HWb09jnocx2W96WqmXC4m4/3+AKKhCcLoXwUDMwsQDNpkijmxNeXymyFJbRYUrMY6RLgf/Vrwfy+Q7AU6dD0Brdckz2YlUtrXjcFal6yYQ=;20:5K1EosYm521UbdfgXspGXb1imW+aJKXDOLP2pKVGjTz7qZsmbgQtaleKW4SMaSUm+NmH0dxXvokNoCrsn084Z93egMalO3QJyIdkV2OpjtzP6vrBuQ142AnDALN3nQzF+4VWo8eQHFmsuFQtXxwc/Pw/h9lrWpiR1k8MAhtoXSfc8R9TFu2YPbM6/wR06HI8fZUhdo96g9Wk4eWoAHz8ewEFpOOWfPkSZsDjS2j8MWCDHD/HZkDJWmqzPapgwGvU+hGjZjYBuCOPHIOWgHBc+AGQrkALHb51b3q2e3UZNfs9zlGPyBDpbL1lNbO2GbZQbaJMlwIAsH4ORDnXeiAuowvCxTueBeRDJgT4PdAYCBCielAH7B/YpaPgcuMaoeDuna6X6nNR3jQHJEVJOBb5JKKpbE4ZwiuHmnsIyyDjPVXWfx4EIKpR4TwalD7STQx41hqbR5eZM277W3eI8IHbBV/ulmgKCiFgV5/Ei8UufVh11BulJbiJjhsVFAyVEYVm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB1623852DEAEE714A4D4D64E3C65C0@BY2PR02MB1623.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB1623;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1623;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1623;4:4pvg1ORKVovazpzin/gZN7MCqwYuZuqrfZkQGI/Db3MyfecSLhYnc9M6Wt0Go0fnsx1Ouwd9ntMevA2LSBwe/VXQznL6dY9CxP3CYQys0DzItelpsLNZDfo9QsaEcu9llSZStuP4U+PxtisDQNjkCqhAOuYHdyopg6469UCDhpntwbUPGP3NbARCMhfPVdywOFIDSIWkiDPvLEZjdmO0VYDbcu52PlxlleklHlqq0ZBQpGH5KtFupFssdU/oN1GHfJRcbqXB2kE7e1vdBM2NsQ==
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyTUIxNjIzOzIzOkZsclZKY244VmF1c0hDdGR4bDVKempMWmNX?=
 =?utf-8?B?c2p3ZDJGOC9uU1ByQTZiZTNYRlRTaTZVbGlrcS8yK2U5Qll0K2JqYmN0V0pV?=
 =?utf-8?B?OWVDTFNuaStLRU5zcmMvMFZuaFEwdi8vTWhFZ0p0MXFHMytGVnpKaWIrWkIy?=
 =?utf-8?B?MGU0WFo4WG1VMHJqaWEyc3dqZjUvWmJ1UXZIN29qZ1cwNFBxZmgwaGVqOVpF?=
 =?utf-8?B?MlViVjVKK292bUYzaEx5NFIvTCttdVhlZHNlMHhkQXVLcm9kQkNBbEdkMFVu?=
 =?utf-8?B?WTd3R0I4TVVNWDNGMmZlRlhFd2RRUWVZYlNLR0RTNE83SWNSYTFmRmxOM05X?=
 =?utf-8?B?ZUl1THMrRm9CT2xKd09MN1FIR1M5UXFlMTZJNU9BNm9yQ0FIVXdid1ZJdmFn?=
 =?utf-8?B?UDlBcDFmYTd5SEI0R1hUM05icGFQVTlDU08rNXl3MmRJS3VVRHpXVGM3NVlE?=
 =?utf-8?B?aDM5N1VSVUxIdU1HNE9GVk15clRIZ3BzeCt2ZWN3UEVld09tUlhJNnZjYzQy?=
 =?utf-8?B?cm9ieU9WWFBVbGRPL3JnWklpc2IreFJaMXo3R29NM294c0dJV3hhQkFuU2ZF?=
 =?utf-8?B?M0pVMXhtdjE4bm5Ha2hHS2dORnN6eUo1UFBtdE84TWxXMkdjd2NENStsUE5S?=
 =?utf-8?B?VnZTVXlWK0g5WWFOYUc3TFdzYnhCSlRpUXNOeW8xUE5uRTBwZzVzdVVjYW0y?=
 =?utf-8?B?eUNkQ2NDTWFoS2U0M0lnV2dGZmE0end1MHJxQytWYkFiS05zakZzVnYzV2to?=
 =?utf-8?B?TVg3RVlhc2hzemdQU3dpU0xUalFWb0w5WnVvTjcwWjlWQ0tFL29tMkN1SEFY?=
 =?utf-8?B?QWhuL0FyWHNoMGhPQzZadXo5c3RNZWtHUTZOL0lBell3bThpSk5qZW1UOVR5?=
 =?utf-8?B?QUt0a1lnNm43eDVlNjl0cEZXU3UvQi81TVAyRThrODA0OEhnUHUvQVNlam9v?=
 =?utf-8?B?SGdnbGZQNG9HMEdWejFOdnVTZmd2VGdFc0ZwejdaRUNzMGYvb2tJY2xpNGtO?=
 =?utf-8?B?SVRabTIrOFc5Zi9zODNjTm9XNHdvV3lXc2JZTXJoalRWemJsRlZtODRpUnI2?=
 =?utf-8?B?UW9VWHk3UzNtMTZQMjhWTTVuN1hFVHhNV0s4RTc2NUlZNWxoTi9xdlpBSWxv?=
 =?utf-8?B?ZldlSStmVnJockUyVjlkc3k5S09GTjRISWZzZFNUVU83ci91M3lZNjJNb2k2?=
 =?utf-8?B?T1lrKzMvdmJxYmN3Y2szODhvOEU3UDdLbzlPS0FCTngwWlU4YUphTXdWalBP?=
 =?utf-8?B?L1ZJd2F6Tyt1Q0VkYXBDN0xPakFJNVVoM25jaVp5VWh2bEpzNU0zenJ2K1kx?=
 =?utf-8?B?VGtMOTJ4WnhUZnZXaXdGUlFUR3dScWg1TUNObEI2OXVtajhDYTAxYTRNT1JW?=
 =?utf-8?B?Y3cyOGpSSkJVWnZUT1p0cDY0V3B4WHJKTFFIY3ExczFMLy9pUEJReG1XZnhG?=
 =?utf-8?B?UHE4U1pFaERlcHVMUUQ4MGRCVGhoZ2FUdWNEb0lXWXQ0VnljU1Y5SFRndUtQ?=
 =?utf-8?B?eVIrQmNpMmtjRHVjM2FnTTlVOFRBalR3ZEE0QnQydkpsR1pGclRJeFphaVpR?=
 =?utf-8?B?YjBFc2JRU05tbWdyRmR6ZG8xNy9WWUpKVm1FVGhXR2p0R1laUWI4NE5OMzJx?=
 =?utf-8?B?ZVdLYlBESFJPb2JGN2p3WlhsZEJGNHcyQmx0UkRxSzZOd1JQOXJ1dWRLUlZQ?=
 =?utf-8?B?UHdoT3B0THhMeHhVZkNtbU9aNU5XUGpQSU1SL2xDbitOQ1VWSUFVMGt2V0JH?=
 =?utf-8?Q?20fpAyLrKaQoi5Of/DjSqUxvb1DKbGJw0Q0NQ=3D?=
X-Microsoft-Antispam-Message-Info: jfLVLPyWMtodYV3ojor7eQgd0FdeKvhPONzVVJxnDsiir4wmIljLUH95BruTXVpkj7w/MEBWdSn0hUdZJdjmU7V6kDZfu3WH4EwHpvFKUD2y75l7GHaDbAtigACSwiX8fHb8wkC4qPPkxpobbkTXmNRBUfBUfqxXaq8eRGUD+pQh8RWL7Wd7jCjUUmqMQQfo1Fke6UBRSnzNOZdB87ZYbKMx1NzmxJVhjcySK98ghdi6Z4Uu+/HtND0aFHFjOTGiQyhkocXXUMd9f5oJCAakSmb3yNAGPqzil/fnTxiu3iozYcrSP8q86JpUuX1MhgoCY6VWWGPu8D+m0vQwO1z+Dv5IdK7cBWAXt25OeObUKog=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1623;6:dg8u2HtdJFFLm5lN11KqQHPqRVT+UauiwFAWBjODqcsJQYAk0W7wnaad/P0KztpfE6ku4nkWyhpbFB3wl83Xs5URR7W+lNc7V15xMUVroK7QKHCLG9QeR7/8/A7a0GJhJ7OOr5cYV91AnNwrdycAfUd6OIxvpp5LP7qA4TvNVa71+swKbJJdFWIxulGcMlDWtW3FSoPFEkJKs4NLu7WMve9dQkK8D/xONXKf/91q16ORhMGo0EJ8ti7JxOFFNRx83h048uIfno+QeqXE6pMKtzIquRdx7OKgT8HsNAtpvwaqHGbxER1nO9njtyqe+wfKQwHLFq836yhiXuvsWg9/qzVpCdBM+hdn9DQ5RHSclncjRqj/X341pzo5j1SN6gtLqO47kHVCYCK1BP1Kxpg5uneewdkpt3gVHHAupbLpLd6i04nmGB3k68UBThOnwsBNgLVrff5Y82Hlams2kKe1jA==;5:rVB9zAqQqwXL0JS1dZDLu8NT/Kbr1XJWtiL0oMcQtpDxUn+vlLjGX9GCoFkp1++k5y9BvggGd8A7bNR1zQoxDrCCfkgIsEyS8tfp3gqShZfdnbyN+UbcsTgx8uJeHVjbBFC3FolXNX0aS7AnIz041p9PDAso8xcmlCUpkhBk0FI=;24:lsk6Fbn+i06VEcuS7H4LPIhCk7MBL7WZejJF6xN6PM/ue8DRDcp8SOwPzHTtt5QThhdH2iKjGPwalAd8qAd9fmiMkcdD0RzrwUeSRdZPNj8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1623;7:w+8QAtvPT9piEQvUyBPxO79EswslBlzo58QdF2spNWz0fm8iGD69Xu19GsbivMKGJoS/XqJUrcEBIng7LWMtJrTEyF/HaITYhm2vNwZI2A+tTlkV55pQj7LGrkVnEU9r4F/3WxHf8QHeFyfeZ++1Y9x1u/QuMU6OBRSO9oegApGlbE5z6+7GJi/c8dou+umw0b0Rpj6uVbHx6l1rp3abTUjb6qy9djs+ncchF946M6ikZxIGlaH3+JPOpV1Ks+vw
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 14:25:00.6444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a98ab434-2f15-45b0-422c-08d5ebf114a7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.7.2018 06:10, Luis Araneda wrote:
> This series attempts to standardize device naming and improve
> its information for better identification
> 
> The values of the "compatible" and "model" device-tree properties
> are corrected for some devices, adding complementary information
> when necessary
> 
> Changes since v2:
> - Split dt-bindings patch (too many changes)
> - Apply dts patches first (reorder)
> 
> Changes since v1 (RFC):
> - Add values to compatible property instead of replacing them
> - Don't remove "internal" word from Xilinx boards on dt-bindings
> - Migrate content of adapteva dt-binding file into Xilinx's
> - Sort additional compatible strings alphabetically
>   by manufacturer
> - Dropped patch that renamed the zedboard development board
>   (no apparent benefit)
> - Dropped the patch that removed the "zynq" value from the
>   compatible strings (breaks the ABI)
> 
> Luis Araneda (6):
>   arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed
>     boards
>   arm: dts: zynq: correct and improve the model property of dt files
>   dt-bindings: xilinx: zynq: Improve boards description
>   dt-bindings: xilinx: zynq: Sort entries alphabetically
>   dt-bindings: Move Paralella board to Xilinx
>   dt-bindings: xilinx: zynq: Add missing boards
> 
>  .../devicetree/bindings/arm/adapteva.txt      |  7 -----
>  .../devicetree/bindings/arm/xilinx.txt        | 30 +++++++++++++++----
>  arch/arm/boot/dts/zynq-cc108.dts              |  2 +-
>  arch/arm/boot/dts/zynq-microzed.dts           |  4 +--
>  arch/arm/boot/dts/zynq-parallella.dts         |  2 +-
>  arch/arm/boot/dts/zynq-zc702.dts              |  2 +-
>  arch/arm/boot/dts/zynq-zc706.dts              |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm010.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm011.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm012.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm013.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zed.dts                |  4 +--
>  arch/arm/boot/dts/zynq-zybo-z7.dts            |  2 +-
>  arch/arm/boot/dts/zynq-zybo.dts               |  2 +-
>  14 files changed, 39 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt
> 

Applied all.

Thanks,
Michal
