Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC76C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C234D20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YqkkE2HM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C234D20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeKITNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:13:09 -0500
Received: from mail-eopbgr820045.outbound.protection.outlook.com ([40.107.82.45]:60353
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727518AbeKITNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv/LIiy9pPbqRp+446h6VdMYTsCrTu2AGtwKJfPmq0Y=;
 b=YqkkE2HMtWvCygwoutASLtakzfMIX6mRQtlHWzS+aJOdUsImJ8Yx28nMASc3E095lIPS+dslnp6yu9aX2KaBg8e1eTAxdiLoGGyvSK927lAdh62ufVk/eKkmsNWnZNdIOJAXTsuHKVHCK/qy5Eqrs/4nT/tSt2RHRHl2gy3wLBU=
Received: from BN6PR02CA0073.namprd02.prod.outlook.com (2603:10b6:405:60::14)
 by SN4PR0201MB3520.namprd02.prod.outlook.com (2603:10b6:803:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.28; Fri, 9 Nov
 2018 09:33:19 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BN6PR02CA0073.outlook.office365.com
 (2603:10b6:405:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.26 via Frontend
 Transport; Fri, 9 Nov 2018 09:33:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.11
 via Frontend Transport; Fri, 9 Nov 2018 09:33:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gL3AD-00047R-NC; Fri, 09 Nov 2018 01:33:17 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gL3A8-0004Me-Jo; Fri, 09 Nov 2018 01:33:12 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gL39y-0004JC-AA; Fri, 09 Nov 2018 01:33:02 -0800
Subject: Re: [PATCH] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
 <20181107085503.GA31517@flashbox>
 <9d52cd84-440f-9a40-d0ec-1397abb24c98@xilinx.com>
 <CAKwvOdmkC1LqMokhQUebpEZRoWWWwtQnbm8xGwiwdBy9UOMT5Q@mail.gmail.com>
 <af717713-9e51-139d-1206-1682b83ae434@xilinx.com>
 <20181108150116.GA2830@flashbox>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <40a17c3e-6c81-6f59-cff6-003a91e10b29@xilinx.com>
Date:   Fri, 9 Nov 2018 10:33:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108150116.GA2830@flashbox>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(438002)(189003)(199004)(65826007)(5660300001)(26005)(2906002)(9786002)(14444005)(186003)(8936002)(478600001)(77096007)(31696002)(81166006)(305945005)(2486003)(50466002)(81156014)(76176011)(356004)(64126003)(8676002)(23676004)(53546011)(36756003)(54906003)(446003)(110136005)(63266004)(47776003)(316002)(31686004)(6246003)(44832011)(58126008)(106002)(486006)(36386004)(2616005)(39060400002)(106466001)(336012)(11346002)(229853002)(4326008)(126002)(93886005)(426003)(476003)(65806001)(65956001)(230700001)(107986001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3520;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT038;1:q3jdykGvItyhDzakFbgD9DpN9MJwN0a5KA7LA4hDckfJ+qCZp7Ab3fJ6wtyiEhNHzHrSV0b4OvpV/I5lUGyx9+uZwdYyHzb2QWFSzgE/Zfwo6fMZDJC6vdQxQf007MAJ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87f8a603-ddb1-465e-f6da-08d6462661f6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;3:4/u/DOIgeN/ksZu2yNdjrUtnuBaYGggfKSyzREHOZDUaoj4rJrlBkzeu6fuwg9GnPT81AARNUuvSX+FAYd+26PyzKUzvP899hkXW+R8yzGZO0h9uRRiGorDN311n7t7p/7gg39FPwZLiAQWrM5xm4U5LRvbhX7s8nSjHhXc8GIu4UP4pS1EO7IX5QHI9m4u4frJodJ8YNMqDegDz1j28gS/xZdIheyiXUtGU7IIJ5nZE6LX6ZwdL8P9y1dGcKQ9NTAzMLqKz2R6KZ8VFocH8O+42f2rHX4UDfvweZs+X5sjmuxqwqza0dbt9C3UyZAA1GPR6zIKDz4Fm4vEJsBhjKZUzgxjt1E/q9EcQooBZ1Ug=;25:JAJn14ct71psY7vAqYJK0eqzmLnLymRR5qIm8nmzsaOmGN6xUO4//zeyKybm6IOSvlUjjyMXZOTb/mFuokczSuCvmFu3tzp8B8IbO/n+pATB8muptFOXzP7scrP1Pgw3hhK/m2VWKvAex3GQ4pFgcnEs99XGstBuzIu+aDiBE/RVYkvLqqEpDjIGO6/tQU71zV6G0qApocb1QeW+hJqW/4FR9HKc/kq+JZmLZKqNS+O7jQw5dsmdrlUXNB12slz2J7Zie1L3NCL//QAjqvbuMsuQJjGxf/Nv31Q1Ev0/OEqst6uNPj9ExpYcAwmX1xyKUcpARVHPj6t0c/TPSJWpZA==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3520:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;31:4VxAEudnNMiBKrvUlyjOrYLCGAerpRcFRNCNu0xdqLGjMLN6nh/UyoIOpYzMdXS90KrfNjC0V9xDZNR7NOOes0XMdho9CEcWBtW7TZyFfOHjebPtnew/4EgFTakyFIVOYi5sVCmDHedb8zC3X8GiRD0WrRMVbLra8GZG0CXQwKvi9xDD3dWI6UE7e1V4gLfOczeijAabTsRxaUJTmdjfNVYWMp29F7NVkWc490VZ8No=;20:VwX1IRkivQdqK7Ntc/PrH5u6Wom1OQTpCrmTe+AEolyf5xjsdesnEuPJFwDVMZhs8Hmq/awBACbWqdkCCFho9EDoMBMIGs190CVweUGb2mrnKuxsSvML/4Yc9hWsOabVEnx/1bVpM1Ts6S5rB+omdEa5OZP4w16UX9qBXtb5x/ORYAJoujjFL6M06ykErfFuA1PIToVH9RhfE4jL/TlYB9ht1UM7Tn+8J0AvqpWhixowNmBvVK80Vb3qm/wPaTHzTkVOKuI+uOPTM02mmzeNpwZqMFWhI1YwCYQuyO/Abiqs9SJbz2gBLnI0XiVXKeqeoXjwQKMX6iAtSQbtdFjiCb4coS5YnUZAv82tYfYe5EAFYRpuoMCHWFWErXP2ExwG+Nk3z7UrvFSkLV0evVuD6oZJen3Y7ULyHEXa55opYJAEZfhb+6BbVmliTV+jr2aZDuxsafQHQSn7Ha90hAOjQ+MG5/9S934RsJQctvQAfXUWrPhAZeEXkMoy2r8AOJ9v
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35201E83337B282875767365C6C60@SN4PR0201MB3520.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231382)(944501410)(52105095)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3520;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;4:BEUDqVntj+wtk52YEP5ZbYFnAa+onLaH/tNC1GXJjK1tbCISh3IrIQrWEyjFMZ6RZZR8xW5DJhY6X+9KKeF5yyOFItrQc/VZXsDBJVVuGbRUhT68x+LOy1pbqalPrkrdmwvAhRJUkj80eTknYX3nBx6ZyWLP6yTUqIWjWoSbMVnqb69H3lBfDBgHVE410w0VDFJmGOz8m6h+wp1d9ZCuhVv0rovCmGWaLf14oDC6oNyaQQrmbwVNX107msbajlYkrg+HlWy/iAVVmuNpuXjmRuiKxv2weUK8cYy4YuX3lw7hZgxxtkoYC0fs4WtptQdO7Jqy8e0qYKwrCMtkkE51ZKWAPoxEdhuw49VHk/tuIRo=
X-Forefront-PRVS: 08512C5403
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjRQUjAyMDFNQjM1MjA7MjM6NmJuU1dTbFo5NDZNZ3I2YW9NVWQwclFr?=
 =?utf-8?B?N2ZWZlhhMU5YRWF3bGxRYkdIaFhueXJlVWlDbGpEb0UvMklUTDhGVXI4ZUJF?=
 =?utf-8?B?cTRGMTQwUks2Q3BnRVdYRHQ0TkVqS01NWjVEQkNGKzFwWXJGb0t1QWFQdWNE?=
 =?utf-8?B?cDI2b3FnWDZqNUVpUlZWRHVOVWJRdnBjelI3MDhxNmtTSlpCanRvOTRTWWNk?=
 =?utf-8?B?aXI1K0N3K25DemFPS0lVSWQ3SzBBL1c4dm9HWnNjaWJWeWRUK29URjJnejFq?=
 =?utf-8?B?a3FWSVh4VmU2Qk1wMFk0YjhUeDUybm5iQ21JR0RNYWVBTWJjekhadFhKemJC?=
 =?utf-8?B?Y3dvaHZWaGhUZDJJZHlxampHbk9mZE9DbkV2Q01Vd1RSUldIbzJoYng1RWI5?=
 =?utf-8?B?azZmc1hXR2czb0ozbDY4Z05aS2R4WWdUVE1GUTBpcllFelVvbjVnTHl3c2Z1?=
 =?utf-8?B?WkgvOWVUSXVCSnZXWU43ZHJoTUJaK0dZL0VPQm90U2xlR0dKeEpaYjRwbytM?=
 =?utf-8?B?SHVxK3Z5amd6ZmNVNDV0U21nZHJkN3RYNWNIQVdqdU9rYmd4b3V6dTdBQW9v?=
 =?utf-8?B?aUJzYW5uTzdwZ1NsTkUvVDkzSE4yc1FJdTltdWxXWW1FdGFlMGVJN3VsdDFL?=
 =?utf-8?B?NndiSzRZNTNERThvaXJGL3YrWnlwYWdkWUFyUEFmSUtwRUpnZlNOQUdPUk93?=
 =?utf-8?B?OHB1WDBjZE9PckVCOVZBbWwxVU14T3hvTDlLWU5NUTlXNjYxU1pRbWxBamMx?=
 =?utf-8?B?V3BuS0xxRm1aRGRoMDIyYkR4aTVNUUpVMEp4RWNhOHhNbnhNZjBtZXBjdGtL?=
 =?utf-8?B?SzBGdXczU3B2RlVuR0tKeEVBRi9GTGcvV2VQOHVUbjZjSTFBQnVnbnczU0lh?=
 =?utf-8?B?L1BOUUhPaVQxcEtoMEgzL0t0aG9FemRzdm1pTVQxMkR0b2hEWm1ILzhvbmJR?=
 =?utf-8?B?R0VDVzRrZ0UxVndBNVlEcGR2bkNQRmpOejdSSURqeDRVNkN4cWVYWFJDVXRO?=
 =?utf-8?B?VitJdlI0NUlCbVBGMFVzM2NxSUZKbEpvcXVyQzVlT3pBV1JHZVFaOXhwZzht?=
 =?utf-8?B?TDBrTnFFMWRWa2NVNkVSVUE5ZjF3UTA0dU83YUE3bytVSkwrRlVMSi9EbDB5?=
 =?utf-8?B?Z2NtL2wzYWZKUGhDejRHMVFmLzgrNFN1M0NFdnhTRnYzZ2lUR1lQblVQK0lB?=
 =?utf-8?B?RUdmVHNNNmE1MUJWUXp2NE1tazFOY2QySDc5MFM3TTNXNGtRaHRwWDlQZlJj?=
 =?utf-8?B?VXlRdm9GdWVaNnZKWFRFOEJnMlBZOHB1bjFBVmpDL2EyMW1kMisvNnYwWVBZ?=
 =?utf-8?B?VnhHZEdIcTJ0UzZQdGdSaE5Wc0hsN3FwblFTYlNnQkUzMnlyZWN4WW9EYlJa?=
 =?utf-8?B?bHp2MmZMUTRxN0ZRRFVNSjJXSm1rVnlFSDZaTXN1bjV5NnB4T3ZleWFuWkdF?=
 =?utf-8?B?aFN3cHhSY2l6anVlWlgzejNFQnk1V2ZWQWJKSFYwWUptVGNaS3Fxc3I1UU5L?=
 =?utf-8?B?dTRtSFVnUnZMWWdpbSs2c292elRtZmhkMFptVzI2OFFpdGsxYldBdEhTSnpo?=
 =?utf-8?B?T1o0SXh6cC9KT3h6aXR1MmxaWFNrNjJLK2pvajBGeGk5VjRTeVVad1U0b3Ez?=
 =?utf-8?B?S2ZyTzc0MjRUVzhSMjUrcFVxOStGaGlxSW0wNjFIME0xTTVIV3FRcjcwV0pI?=
 =?utf-8?B?bHdjaklpRDByTk80cTl5MDJ0d0tnbTExdkhZTzg5VCtCeGRBNDJ3ZFo4TzBl?=
 =?utf-8?B?bDVZcU1OWXEvbXRWM0tEeURTdG9MbWRGQldCd2NsY29JdlNvR25BMmY2Njky?=
 =?utf-8?Q?2jsMCh4Vd4P4p+C?=
X-Microsoft-Antispam-Message-Info: Bmg2Bhr3fB/RpjkdlvMSD4tfnZKauVRHpEvtoTxoPu741EEEI2Plmloryet2XsJdlA6LtZ//W1XuO/nTd7vuOLRFm8NLDTDW+du3ETiFWK0tJFpXYwc2F7UCP/e7KZYDq3ulKiNmMQgdFMJ0nFBW1ZaH3gRHrkV1rkm0WwYzpVMuonQ/3feHC4NuLYR2pSeR+OhnYb1DtX2Bwb0T8C/7E184KvrkSNcSIC4hP0nDP+nTxJjfAHF7YFqR9LgDGDpa1qvynI+du8iGa1anqR7O0/dsT/liKI/SpCoywqB2yGcUUspoxKFEUN6GnfpZpN2/HC87snE2OWBk/zMp5SR3WepKBurhrcng19ckaqcpSS4=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;6:UxcMHKq/VDWJBiWj7PLoVyYtAD1+Hgsh6Xa5g6Suzt3fJO1g/gjzpkDVjdJY2LJ2ESPztAsValPzLY/o64Te1qdI6LSdqLjpgH8znh1Ept00J46HbVT/clPgdhj9aM3zbJepBjAkDH8QSC6Hacw6PS81UqwvB3ISr8ldp6viAVMhza3qMwEFURHYUXqJZPv/2HJLBi2QLyk6clwt/4WNoYMo/RsqgbaqAXv3b7vVPpzq3hkehYU4mmhsynVZOKgJGEfsfdNJvF0Ow0Maptf+2NexnslFAEcAst/ZWUUQfmy1lbo/YwUCI2m0NYglK0bXIWWjMN2HH/BW6L0D6cFThN55H5rhM2MDMptZ/fAwvBpJZtkbaa4xd/L8Dai83QRLHTUvN5gelcGxDshlZ9TL3D1mz24mmFDHYxdV9FzFbdEZeQ3CqsWOXNtKKw1+Xd0KjY78UylRqiSXvXMLlG+rtg==;5:QHDsIaFuftxhW3YlotS82mAi/D/AKN8Q7yFAL0Jly5EFqYvEYKsSfMiPSJSJWCqTSOtHEuBSogYKlxEPw3F7Wxe2dKhbZ/4ijimVJDxunI9Q8QpPeGBNLCJxk7bQ/k0/js4/bBzbSPwleS4vH2vQNyV8We72Jp6YfVZxpbdsgvc=;7:sGhD1nwh9mOBwL36Q0hJt8W8VAkpBLA0YDFYr/hFMLcVy3ouVCo3ZJvNB87KjIzAi36dUmHGhMIcGPCs3AS6KyxUYE4UrglG8n6+Lr+M6DC4+MGG4s7bCQ8JU3givo391HJG3kb/kEUiaVGFYQEJSA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2018 09:33:18.1249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f8a603-ddb1-465e-f6da-08d6462661f6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 11. 18 16:01, Nathan Chancellor wrote:
> On Thu, Nov 08, 2018 at 07:45:42AM +0100, Michal Simek wrote:
>> On 07. 11. 18 18:48, Nick Desaulniers wrote:
>>> On Wed, Nov 7, 2018 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>>>
>>>> On 07. 11. 18 9:55, Nathan Chancellor wrote:
>>>>> On Wed, Nov 07, 2018 at 09:46:12AM +0100, Michal Simek wrote:
>>>>>> On 01. 11. 18 1:57, Nathan Chancellor wrote:
>>>>>>> Clang warns when one enumerated type is implicitly converted to another:
>>>>>>>
>>>>>>> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
>>>>>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
>>>>>>> type 'enum pin_config_param' [-Wenum-conversion]
>>>>>>>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
>>>>>>>         ~               ^~~~~~~~~~~~~~~~~~~~~
>>>>>>> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
>>>>>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
>>>>>>> type 'enum pin_config_param' [-Wenum-conversion]
>>>>>>>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
>>>>>>>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
>>>>>>> macro 'PCONFDUMP'
>>>>>>>         .param = a, .display = b, .format = c, .has_arg = d     \
>>>>>>>                  ^
>>>>>>> 2 warnings generated.
>>>>>>
>>>>>> This is interesting. I have never tried to use llvm for building the
>>>>>> kernel. Do you have any description how this can be done?
>>>>>>
>>>>>
>>>>> Depending on what version of Clang you have access to, it is usually just as
>>>>> simple as running 'make ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi-'.
>>>>>
>>>>> Clang 7.0+ is recommended but 6.0 might work too.
>>>>
>>>> TBH I would expect to download container and run this there to make sure
>>>> that I don't break anything else.
>>>
>>> This is the first request we've had for a container in order to test a
>>> patch.  If it comes up again from other folks, I think it makes sense
>>> to create one.  Until then, its nice to have.  It's definitely
>>> overkill for this patch.
>>
>> I have played with it to see that error and here are some steps I did.
>>
>> docker run --name test-clang -it --rm debian:latest bash
>> apt-get update
>> apt-get install gcc-arm-linux-gnueabi gcc-aarch64-linux-gnu clang git bc
>> build-essential bison flex make llvm vim libssl-dev sparse
>>
>> git clone
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git --depth 1
>> cd linux
>>
>> export ARCH=arm64
>> export CROSS_COMPILE=aarch64-linux-gnu-
>>
>> make defconfig
> 
> This should also have 'CC=clang' because compiler detection happens in
> Kconfig now so compiler flags get properly set. Other than that, looks
> good and I was able to build pinctrl-zynq.o without any issues with
> those commands.

For arm32 I am still getting compilation issue (arm64 is fine)
Below are my steps and version I use. Do you know what could be the
problem?

Thanks,
Michal

root@1e15921e6d15:~/linux# arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (Debian 6.3.0-18) 6.3.0 20170516
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

root@1e15921e6d15:~/linux# clang --version
clang version 3.8.1-24 (tags/RELEASE_381/final)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin


export ARCH=arm
export CROSS_COMPILE=arm-linux-gnuaebi-
make CC=clang defconfig
make CC=clang drivers/pinctrl/pinctrl-zynq.o

and I get
clang: error: unsupported argument '-W' to option 'Wa,'
scripts/Makefile.build:305: recipe for target 'scripts/mod/empty.o' failed
make[2]: *** [scripts/mod/empty.o] Error 1
scripts/Makefile.build:546: recipe for target 'scripts/mod' failed



