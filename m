Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD372C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865962083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="t2pU8/wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfBEM1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:27:31 -0500
Received: from mail-eopbgr780078.outbound.protection.outlook.com ([40.107.78.78]:52256
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbfBEM1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXz8XlpJtoavWGoZoo/4r4gaiKfWaRCUZJi7DmvBYGc=;
 b=t2pU8/wdCqdRyeiYArlkePSczV9Cfir5DScpm3RPp0oY6id+N2WFftTfR30GGBCjuI+D6lrhiP3U3UKRpyl9QUSaWisGg9u/9rPjOZPqJgicH3GT4xfEquY3L8p2Lbe5IMW3nem7ALPsU/txr2DBEKX2nURsSk24ItJ18gbAmOQ=
Received: from MWHPR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:301:73::33) by CY4PR02MB2647.namprd02.prod.outlook.com
 (2603:10b6:903:72::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.22; Tue, 5 Feb
 2019 12:27:26 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR0201CA0056.outlook.office365.com
 (2603:10b6:301:73::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Tue, 5 Feb 2019 12:27:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 5 Feb 2019 12:27:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gqzoz-0002Al-A1; Tue, 05 Feb 2019 04:27:25 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gqzou-0004CL-5s; Tue, 05 Feb 2019 04:27:20 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x15CRBJ4019611;
        Tue, 5 Feb 2019 04:27:11 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gqzok-0004BK-Q8; Tue, 05 Feb 2019 04:27:11 -0800
Subject: Re: [PATCH v3 0/3] Add nvmem driver support for ZynqMP
To:     Nava kishore Manne <nava.manne@xilinx.com>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
References: <20190206110721.27765-1-nava.manne@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a6c443e3-a9ba-ffa3-5f0f-69db6884646d@xilinx.com>
Date:   Tue, 5 Feb 2019 13:27:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206110721.27765-1-nava.manne@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(2980300002)(199004)(189003)(65826007)(305945005)(336012)(966005)(6246003)(478600001)(23676004)(36386004)(50466002)(8676002)(2486003)(356004)(9786002)(2906002)(8936002)(76176011)(106002)(106466001)(6666004)(81166006)(81156014)(63266004)(2201001)(31686004)(26005)(229853002)(110136005)(36756003)(230700001)(58126008)(486006)(65956001)(186003)(77096007)(31696002)(4744005)(64126003)(65806001)(47776003)(426003)(11346002)(446003)(316002)(44832011)(2616005)(476003)(126002)(6306002)(921003)(107986001)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2647;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT012;1:7JGoH2RoFhNj/ha6a2vcoh/z+j1ZUC/c12q47t50bu8PeYFoqMP7uWhkx28ibLz6JmFSSfwCP/95/d3SrC8OXta3kMNozeDHXgpEl0TPmc7caGuh9NKuzB97oRwFKjku9knELWvea6ZAvQmaKhABaXdnVDentc0/y/9/WoRmgio=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cb8d7bf-2bbc-4a60-7180-08d68b65497a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:CY4PR02MB2647;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2647;3:/60lp1J9j+upuzeEG7K0eU8pyfqPueCV/Vb9H/MgDWEfgemDJxiYL51ln2dAPCdom6ZYyHZiSFn4ko6y6mzFasMvyRfPSffTuRkBxrNzKDIh/j/dweu/cxDY6uax4J/y0EZHHS0t6GT2WR8zYuQ5Q7dTqu6uMA35qXpz45vBzH60lq/gQhsIKRWvaPuBos5WO6nskEBgMUl2EG75fuIjbzUPkjwJtImolDhe5FR9ycKqkX3yrb2I/2iddVcMUKem3A4rEtZMPJc9Xb9AgyMUlv0OU7QN1Iil915ZiHf5lfzn/o04kLqeeQvOsdbuP+3LdQVJyWkinf41ZTMP952Weomlg0LQ9OyRCkVapqlPADz3EsRnfu3Opkuhr0dyH/Qi;25:h0mgJbrM1NMC8jpyjBtaXKYXyl8oVrUzQtMcq0A/SmOE/BbFDlReolYPJZR2Xu04Gvq++546bGY10zPOBLybe/D48pAxLJzTp+AYBstQv7ohhR1kO8gZYQYzqJ5UPp1TvSDSewTfwXBPpFuh/BOlKKhvvrjKK8CP2oYlgXCoDEXcGlcV3LA5eHNO0mRP4wT/jQNuj+L2SkMwUlpmWSW1WTFyQ2WOGGPUxW+vdu3NJ3tfrFG8hYPPMtAgFi0Sfaeztmp6kOlhIgBjWwNRiCzHJE5Nzx8FPItJlUbGIPohp6RYEssb7DN6ERKJMP0CeGibQwaFDf/71Z3kOzbOTqos/A==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2647:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2647;31:v4x4YX6Fxa2Y9Y0zWLC1zg8LLhI1M5qIMCC12TKOhPVPBYRFs91GwslNSaOPXLhxaL7SWTBStn4392y2i9qdPN73UNr2E0tPOte5KZDCrlGqVdw4t2iTwHHYZVI+XsBFVQumLoGQdf/TGjT/UPlKVsf69TZl7Z/hlw1ItAzoMKbZGuJhQCdr87SCcu0lCYNNkIz8ebbDyab3+BlaNfdw9qunLW6FaUw0+0za9thi5Uo=;20:ZMfwoVHr970mL+YlZcmI0gs58V2JMDXUJyve6K0Duv64bO9fn3C/RuixM0WsyypzK9ac+9VUBXnq9zNG3Q0POHxMe9B8K5MSzHqZByrnUKmLkrXoSm6DXPZEW9ziQnDfMaagPUco41jpyB1SOn7lo8t7WiwJZiewBtde9Lomrsn3GPtwqTyceCXhm6+bLAPRu5b7N9Q1YmgL66eSDdMnMVmxMnZfXlPntnVEyemEmUgTqHX6H/PTEp67FWr7+zPzmcb33Ym3S9sadOlLtO8eV32tNZ8acbCqCGFJqDCAefgwebzJXeMmNj6v/ShWSQ4d3zwMtNW4ZozDnLntAVLRBIueIa8IUNFwVVia5ZDYam9cjbLECB2yvTn8J3iI9M85rOzcQ2MssZtGHokY79ZzcIQVpAHfGHMntOrfGN0xPQo9978JxTaSWNVbvSyzMrY+VqqL/G7DAiYBmNnqgAQh1sTqUb9xnoR60VCHCRcsVcAsPLelL3X/aI9mMgiVu08l
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB2647F635C30E7796673081AFC66E0@CY4PR02MB2647.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2647;4:gopEVTVs+7KD/MMhO6Q8LieSWCspkNLuFTeED3EJGweEqWqMwONM984yr4VIohuyDOL5MI+Tkj0tGMlt4Y+oUkatKzuBI/LWjQW9Zf20S5sp+au9urGV9MnL65cgqsH985H/dWRo+gXT6OitHG7gHb4vH+Kmfu0rUumQXGbWuRM5LGyPjGn3YH4ZxGajK+i5ou9kVMRrH7Ro9vITAZO3YHVPS48AwA1/VBeKlcVwR4rzvYBXkeWbVVIKtPchEbEWn6Q3dUbBAvL+NSqZomF0v/oFjDETURQo+Q0mQujvTactfu3HQuPsQuWmyPeVYjXq
X-Forefront-PRVS: 0939529DE2
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyTUIyNjQ3OzIzOkRzSUgwQjZkaEVTMHBhZ0p2Mk9Fa2xRdm5B?=
 =?utf-8?B?czJCUXEyM0ozcG5mdGtiMnk0MlhaQ0k5Q1pOWHc2L3FWTG5ZRGpObFVhRkt3?=
 =?utf-8?B?NjhBRUVacU01cU1SQ1lpMHYwSEhQWENtMkI5TXFWQWd0Qm5kZm16eDhWS01u?=
 =?utf-8?B?SGtDeVZEdDRZSURlZjdKcDJNTlFPdUlkTE5LWGRSRUJ6alB6cGI4dzNBUjJa?=
 =?utf-8?B?dXZsK0pVSXNYWlpyaElUZVh0ZEJIRW5Bc1JjOTdnay9VaW16RG1MeHV0Z0Uy?=
 =?utf-8?B?MTRhOXVHNFBIdUdTSCt0TTBVb2t6blREZ0ZLckc3aDZCR0owRFdXNUVzazZQ?=
 =?utf-8?B?Z0lOTS9KckRLRUpUaW1yYjQyZkNDZ0wxaW42VFlsWjluUzd6eDFVOVljK3Y2?=
 =?utf-8?B?UHBQNlBvNVc1R0VyNnZOYWdOVDBEckVtaHRuWm56SGYyR2RYOUtMZE95VVVs?=
 =?utf-8?B?bkNGWDFkS2VPMXh6T29FdGhjK2lOMTlTZnUzd25OdW1udUpIcDZSeWd5VDY5?=
 =?utf-8?B?WTEvLy85enBOcDRLNkVjTXJ0TUZFdmRsTVZlZjdXZUp6Y3prZWMrMnpiUzdW?=
 =?utf-8?B?NWhBdVkxZ216WHV1ek1qRjBrMUl4V2hYUE1yTHI1WnpRMnBsK1oyRjhId3ZI?=
 =?utf-8?B?eFFCS3NweUxrOWZjdTExYzljd3craFNCd1p0WTdGc01EUHovRDM0MFVBZFZz?=
 =?utf-8?B?Y2h2ZFQ3S3ZPckljSkM2alErbi9sbGlVUWVJcVk5VHZDUldsWW5tQVdsTUNv?=
 =?utf-8?B?RmlzRnh1cG51dmpBTVVrMVlGNE43UWpPYlNJVXpxUWViVVRTbE9mTjU0KzNR?=
 =?utf-8?B?WC8xdEtXNDNObm9PRjFlY0QybVdpT2VDVDl2ZmNERkJQaG11MjNUcnhoMkdm?=
 =?utf-8?B?dGU5OGhZcmNDam15MmM1K3F1OGI2aE16clRUaDN4OU51aEJ5ZC9yV3kzYkE3?=
 =?utf-8?B?aTdpdGZxVG9LbEozVVUrNjJtZnBOTHhDdDF4VE1SSHNKQUJVZkVNQ3IrcTV1?=
 =?utf-8?B?SGFDUHRDYWs3ejVlSHRkdlNSZnVaRGdteWFoOEVweVJHcmUveHo1N25hWTZE?=
 =?utf-8?B?THQrU0FmdzNZYWtzcVJLVnA0UTBzU0JWZkFpSHhJSTUwb3RmK0ZGbEhUV0Rq?=
 =?utf-8?B?VUdrWHNBSHJ2TmRNMmpWcVNCL2EwQjRpaHNWaFZpQ1N3RjB6cDRrcDJXZktv?=
 =?utf-8?B?K1g5SGx2N3krTHFGbEJSeFlHcko5Rnk2RTF3aTE0L2p4enpKOWJvNTBwZ1BL?=
 =?utf-8?B?ek9wd2ZQeHpYUVl6OWlWVGN5Q01BVFV2ZmtVaHppanJoMm5HNnFsS3N4VTM0?=
 =?utf-8?B?NU1zQ2pYMkxSQ1RKMUFzVjM0eldmQWt2cUxGWnNLdEZDTTA0Rk91cVFtbUhM?=
 =?utf-8?B?eXR4eWFoM3QyaVhsNzVuZEdFdllFMmVCcHVmRnVYYnZnNzM3em9xSldGb1d1?=
 =?utf-8?B?U2gxc2gyVzJmWHJ4VjNkeGozRlVCd1ppeTJXSDZ5S2UrRmlWMEhpM21MK0lP?=
 =?utf-8?B?QVh3Y3hpNHNvenFzUlhqdGtKY0kycHpVOUo5cXZIeHRtbWQwZDA5SlFySDRU?=
 =?utf-8?B?aXhJV2lzNUZyR3JpZ1RiN0U1dlI3ZllhWVJSMTY3cnBFZWlxYnNPV0Y3aUVE?=
 =?utf-8?B?RzdyRVBleUhHZkNGTkIrZEVFdGFaK3hMdWdBd1NLRmNpWDUrRm11YytaLzVC?=
 =?utf-8?B?bGxRaEU3UitmZ1JUcE93d3dIWll4dU5PdVFlS0NMMnV3R1hCelQyVVlYZGox?=
 =?utf-8?Q?tECZhjMLC6WxfFTwyaBoDwioz6IKcw3mbc9mg=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kDM0Rz1oMrsdKeDJqU+0Q+PXwXJxgtsLfXfovlt1zvOHopexmyVJXdZf0F4ehTgpc4Wm4CE4kxWBjKvU2E6QrmLOsOld4SnLYYawW+7q3GquVsAQfxcoJBA96JCOMAPevyt1X6NkXE0qukW+PNSt9GBML0B9iumByAvOnkr38PbyARlzVUY5JmYhsXhwm6QYce/FbAmqQngrh+6+zfhekIIEYqW5zucb99QXAAMfDIoCo4YhU4I7icji7Kt2E6spXVBeA1cBgKiMMWGc9Ijxr7ZL4o49aEPNOU5bBuk3z/0TyT5j5eRbaZS6vvHlXl16M/ipU7+QmlFQlRlkWhgQT7vj5Y7bhEAJzxISgZQd4Z3g+xVgtMbNswFXQCzjH8HB84v5MuRJNO4SPWJWXkfhf9rQrLw7fqPOiSi4u3gmsjY=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2647;6:gCDjf8USzP8NRlVzT/GIogwDNJ54WU+BHZW/alz/D659EPkuWf3qIYfiYwrhx6fLxSwKb/fJagiA3somlUTLof27yaqyr0qLmBlj2NOn6hPgrlk9ZZwlCyI4TUHLf8M4sDw8JCV5HLFBuNBcCDstWN83W1NQOPYhSLwj0HRGIC/pJZ14ks3LWMVXfVcmKl76TOQp3rpqEiChapdYLM4Y5u9nm5xCPidWnN9j6dY6swuGCMmkKKKRaEDA0oVQG1Bdm1UAzNPqLZzYbLKM6kJiUzINuWDoeADf+FyHnFlpjmKUdL4pWmBV9mSF7D5wWFU6j5akSrxnKlKU+KMtvlWUM9eLx0m+gLI4fQQuAbHNkCZteJGGy1MLzmMLlSWbWIofBDMHw7wKVd7jRBu8H9A3SXiUItHVmrQDW6eis/0G6bmMowRIiY4TQSH5q+qX8+QWd74vi8rZ7XrpCiLw+uJGWA==;5:pPxPxt3xss/5Bw2awJhF4NEQlR2lFUT7fAYVwND1n7nWhqhBPUlX5O5qbOwo458eaTqK+cNqZncKFJm8rwwn5MBmdWvt8GsHbwZUyZ5AUPy3dJTkNbWRGsh0L2BihTvHvmxVVKhlKFdHnnPe2Uw1tlf3vkwe5GmLYNbsZdXN3+XWZnx6e+Pb6y6q59dsyIgdMpELPDjZiFT4rfJrrUzZIA==;7:do2gSTHUPlCc8nehrVSOxsU+McTw0J49/VMJMOiTzB2TnKmJlXC47N2l6m2IXF1eZrQ8318mO0s/CJZNdVqlb5VQLFeS1lN6appqT8Yf40weGTOLDwuVvCkhEnpUeYuBf1XuPr2+ozo0QEXy/e47uw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2019 12:27:25.8491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb8d7bf-2bbc-4a60-7180-08d68b65497a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 02. 19 12:07, Nava kishore Manne wrote:
> Nava kishore Manne (3):
>   firmware: xilinx: Add zynqmp_pm_get_chipid() API
>   dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
>   nvmem: zynqmp: Added zynqmp nvmem firmware driver
> 
>  .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 47 ++++++++++
>  drivers/firmware/xilinx/zynqmp.c              | 24 ++++++
>  drivers/nvmem/Kconfig                         | 10 +++
>  drivers/nvmem/Makefile                        |  2 +
>  drivers/nvmem/zynqmp_nvmem.c                  | 86 +++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h          |  2 +
>  6 files changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
>  create mode 100644 drivers/nvmem/zynqmp_nvmem.c
> 

Applied all with one small change in 1/3 by using number 24 instead of
22 to be aligned with firmware.

Patches are available here.
https://github.com/Xilinx/linux-xlnx/tree/zynqmp/soc

Thanks,
Michal
