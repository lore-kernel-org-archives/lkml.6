Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D9C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5311B20824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FBYcyBCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5311B20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbeJYREA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:04:00 -0400
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:62144
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726696AbeJYRD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 13:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMhJyY/UgLIsJwoNwTp/XYMgrJ7VpYu6gxy8wwpb6fs=;
 b=FBYcyBCu7/PYk0Bu+neAiBLea1v0TNCZz+ZSrNVoF7Dvua0I1EcBp8LFmg9rsakc53Ly5+NRWGMops3pNsbGsdtvJBg+SAGj5DRFTWUaNia/WA3HNuDiUFd8D1ZtH1IyOb/uTmqD6NNmNc0orYuwP94h5eUeepVRMio5i6Wd7/k=
Received: from DM3PR12CA0090.namprd12.prod.outlook.com (2603:10b6:0:57::34) by
 DM3PR12MB0746.namprd12.prod.outlook.com (2a01:111:e400:5984::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19; Thu, 25 Oct
 2018 08:31:57 +0000
Received: from DM3NAM03FT044.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::208) by DM3PR12CA0090.outlook.office365.com
 (2603:10b6:0:57::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.19 via Frontend
 Transport; Thu, 25 Oct 2018 08:31:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; 01.org; dkim=none (message not signed)
 header.d=none;01.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 DM3NAM03FT044.mail.protection.outlook.com (10.152.82.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1273.13 via Frontend Transport; Thu, 25 Oct 2018 08:31:57 +0000
Received: from [10.237.74.158] (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.389.1; Thu, 25 Oct
 2018 03:31:55 -0500
Subject: Re: [PATCH] drm: fix call_kern.cocci warnings (fwd)
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Julia Lawall <julia.lawall@lip6.fr>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <alpine.DEB.2.21.1810241955110.3776@hadrien>
 <BY1PR12MB05028BA16A21896179679800B4F70@BY1PR12MB0502.namprd12.prod.outlook.com>
 <823eb7cc-ba7e-b816-1821-c73dfd4c70bf@googlemail.com>
 <8c956766-57ba-c6f7-405c-04a41ae926be@linux.intel.com>
 <1b153270-c73f-ea6f-6573-b742b81d6c42@amd.com>
From:   zhoucm1 <zhoucm1@amd.com>
Message-ID: <2538e7eb-d71d-2c19-a1eb-57701dee03ef@amd.com>
Date:   Thu, 25 Oct 2018 16:31:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1b153270-c73f-ea6f-6573-b742b81d6c42@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(2980300002)(428003)(189003)(199004)(11346002)(26005)(2906002)(31686004)(64126003)(336012)(186003)(104016004)(14444005)(305945005)(77096007)(7736002)(97736004)(16526019)(72206003)(76176011)(2486003)(65806001)(47776003)(8936002)(5660300001)(65956001)(478600001)(229853002)(23676004)(6246003)(356004)(110136005)(65826007)(8676002)(105586002)(54906003)(16576012)(68736007)(93886005)(81166006)(81156014)(6116002)(316002)(3846002)(106466001)(6666004)(50466002)(58126008)(31696002)(446003)(53936002)(426003)(2870700001)(66574009)(4326008)(36756003)(67846002)(86152003)(126002)(486006)(2616005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0746;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT044;1:e9ef643BtJhzN0cYg0UNqV5tvYlRcpazuM+wBdTpk4RJEr/pSOOYxXhDOZdtmwyVJj59gfKaNJRKgMLBtcx8KNCnyup1pOPkmVi8AIAMsbBVyozYjyVQSsDfm3uZ0lX5
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 172f8bd3-84c6-452f-cbfc-08d63a5453cf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM3PR12MB0746;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0746;3:7/JYofgow/wA86KT+MDGlGF3ZvqTG4g7ybJ+lKuSk+u+UEzJKkdRWh/NOObMANaeuUFWIyJnnUwXWr/8t6zwTkDHlOJv44tAGQFQtKqi4hy6W8DCWEnBKD4A6YIWlyZx1q/QULHXUgmq2Ka+My5Hpaebdatm8GN/r9u3VVAG09twdyfT1V9DV9x6RAgICiLMuj3FJTJDYjZwk1M5D05ZscK+rKcHq9dr69rlSaHHdGYug9pwxHfooaLRMGtbv/n4rSo/uTckK4NsDnTqevHE2uY2wQ3hbDgOlnk1dxnmO1XQ4KC4PRDDYXI6r8UYIgIUWq3e56u9YPVWw1a1VKleN1O+QzlpKk2IbMrKiHusxGg=;25:X30ZF0XwOieVxrlVQz4l2EJTyWLKN+pzUAvxw9JSXMI2QheU/fOe6d9QHIVB0GisdM0DxsU8u567r9LtXeKf/1apANSjAkWW8MIPYEcOTkIhBeYJ9iQOyQFTySv23QhsNozMqOEt5XpXGmB/9IvrXvwEgsP4VNy9ML4nWJwyb+smfAn3nayTMvC82/78y844cvYXFEbKudbrlt3fIVebZLDcBph60sFlImxVtdd8HEcHhdZ15HWHLUg2VcZUtl0YnRXVFJXTSRCP206iAdJfvQnhLSEt4tEIXeDz5sxUpIeQpEWxO9nQxyvZuG6rJA0UTiLRDQNmV7ag/XPMi7aHMSfdSJRUgQzqebRkQ7SLv4Y=
X-MS-TrafficTypeDiagnostic: DM3PR12MB0746:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0746;31:tiohR1Fl9XscL1Ha/+ebz2N/L/uSx3uDyRgO+axcNH6OlEXIe5KI2M/JUXJe+fM2TyUasE8ZI0J03bHuKxicwbxlhj9gfGcGe/GisqGN9/la2Lneu5uTe68LLVgER9YnKX10VunFPy/Dt7pTDEuPdDoqLUIrHxy/W9hMR2LBGDtbULNbHPNrl+jKZjDtCOpt05Q74v828Ff3k+IlSd8aZiYc85Vy0FkjzJJvS8yL7Ew=;20:5Blfy+07ueadmUCcO6GSWfuNAhlITQfK61+mipXO6CpTY6EokrFxns3aCwoR0WjitLbDwx1qxT60CahCj1R1w2VQj5/L0w+ntVsIY3ign7nAREIF3j1mS64e9WqwRnmkyAFomW9nviiIQrjAbcoqrQrWQ5Sm3sf47MX+dGPCmGNzL25K5B8qaC+NXsSCg65fy1SdqE6H7Yyt79Y+SmcU8+jDjy7MAwo5Nx0gTyAKiyNClUmQKJWSELd8iKIKHzs0MHEKHWoXefuackwZm1Jn83N1+qM9oK2HMTn0YxQPrvH3Dxs9yM1s8P/0vg493NHhtr3t0sOibSS9r8TNAkTRybiNmi2qF1MCxGNGB5NuIDI5V/cMJkMGgJi7XIepKxiMsIt+PLagBv1NVEtqnEAtJ1GPjPbCdXXoaisHfkqfVJxuzhOSPqpfeiol9KT2IjYQ22cS+Cxv1HHhaNjhHB0xd5ppDAHrZmeoR882TbCg5BYdnl8DCHQPGY0IKcAIc7BG
X-Microsoft-Antispam-PRVS: <DM3PR12MB074677FEB8696BFBC503C5CFB4F70@DM3PR12MB0746.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM3PR12MB0746;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0746;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0746;4:OoEERuFyRupj/QmL+OJ/aISI44AttZSToVnOwJXoZS80qV+oLiGnb3x35CTkrxgqbm3YDd1rypJp+HvNPa4Vv4uagPRp2Ob09wzIQxVVTbsDZ4Ju7XIwZJlQKPiYO6DXjk61DVKq9r33qjabwTs8u/VuM8Xx1XVxkSZi6GtRdi/VzEBuIuq5d8MrAlkG2mKmZKiNejZ7F7KWxc45GR3MJY14bTf+eAKIv1rv3JxEeMlmLSF+lKyXN4YOTkUrE9+KDc57kAAiaO0rWbhYiXJU5uKDxlz5Avr57XCzEiZ0jl6CZTJjKW9Jpk7y+HocLxbD
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTNQUjEyTUIwNzQ2OzIzOndZQVJZQVNxelp5cDhvekY4RVBURUorSlND?=
 =?utf-8?B?OXY1d0s5aHJCNjh0U2szMUN6R1VKMm9zVHF6c3pwMU9ucHpzKzd4MHkzeDJV?=
 =?utf-8?B?Z3RuMEhYWlRJNWRyT0lKa1lsMUdudXRmd3BJM1lDbDdFS2szV2lSYzdUY2Jz?=
 =?utf-8?B?ZWt2ZGZwRU5WOG5UZXEycjdmaXl0VVNpb3BrM1Zibmp4ZGtJeEtLTmhmV09z?=
 =?utf-8?B?OFppNnlNYThpU3dIeHlETnJVM05wV0xwTEFtT1dTTFFqZFVjQVRjeDdhV2x3?=
 =?utf-8?B?ZXJvUThHVTlVcWswTWtHVmh1eGtzL1NBMnU5cGZla1J1Y2I3UG9nVm5pNW15?=
 =?utf-8?B?UVpnWDRGZGlTb0Q5RGVCSXJ2YjArVjlheCtJSjRBR3c1ejl3eWZjL1RSTUFP?=
 =?utf-8?B?ZnA4SXZLTHcwajhmTVJ6SGdJUVRLeGJ1R2dia1dtV0pYNS9OVzYyU2EwOHRC?=
 =?utf-8?B?SEtmcG8wU241Y2JoYUhaWE9ydnRHLzMvbjMxT2xqdHlWNVcySmsvRThEeS92?=
 =?utf-8?B?dFlVLzZ5NHF0L2d1aE8xYkpGamhKaUJBaGIxNHFzWmoxUHN1bkZlcXEzU0pB?=
 =?utf-8?B?dGdxUDIydk13RU1NeUI4TFlxYkF4MHJReXgvU2xtSHlHY2RrMW5USDBqei9v?=
 =?utf-8?B?ZUJCU1R1S1RxaHJsQXF4dnVTOGlOVnQ4bTVJdU1aTk0zcG9zSkxPSmE5Zjc5?=
 =?utf-8?B?MmJqUE5TUmQ1Z09CZHd5cFd3TkFDcTlIekhJYlNiL24ydkdmM0dMT0VoWVBE?=
 =?utf-8?B?cTIwMVljd0V1ZmlHTXZLTnFGRCtyOUZFdnUvTlIwWkNSMktYTkVVYnhITzAz?=
 =?utf-8?B?SllHZHNXNElJMlVrcVNhNy94M0RIdlRtTUorbEI2SHZmeEd1dmpSbVZIYVVk?=
 =?utf-8?B?Q2tZeDB2MXhvZDZNWHMvZEorR0Y0cStRTk4zMFdKMmo3Ly9UUXJ3TWczRWEv?=
 =?utf-8?B?VGFDeUoxcVRsam9odmxweVRNVU5KcU50UmNwOUFhVFZqK2dGZllLTmZscU5h?=
 =?utf-8?B?TmJMYWErT1EzWWgzNGI0cnZtREZobHNxZ21YRDg3NldoMVIxcFViQmk2Q1lV?=
 =?utf-8?B?Q1VmYWRjRFNWVDlJd3dCWGdkamhDNHdEbkNwMlNvZ0k2dmxrTUtoTTNGVnlz?=
 =?utf-8?B?QjlYbGNPMk5GemgwdlNxdy93c1VTbFFpMCt1ZWFZZHNna1djUU5WSU9DSUdE?=
 =?utf-8?B?Unc4NGFmWmI0cVdwWURFaERpSHo0VlkwUjhvcWIzaXpDdVlyOW9VT2ZJdUlK?=
 =?utf-8?B?ZUdWOWkraE4wOStVaUZuZ0svYTFtQ0ZCUEp0SmFHKzM5WDBmcTUyQ2tlc3dZ?=
 =?utf-8?B?NmNXUVJXbzhRY0JDWlRLMlNMbGtXNXNraXFOZGlEWkwraW9FU3M1dzFvYzgz?=
 =?utf-8?B?WCtOVkxOVzF4Y28zdmdLeFdIVWtDeDhHMkxML001STlQS2U2WndoMUVoMHZq?=
 =?utf-8?B?K2JydGdtemVGY0E5V2RIZ0I0NGE5Smpzd0FNTEUzNDNxMmR2bjkrazRpclg0?=
 =?utf-8?B?ZWh6eUQ5SnFkY0p1WHZCZDc2TktvUWNNODFJN2NONFJGOU01ZzVmSGxJTVVI?=
 =?utf-8?B?NGZEQ295TkJaMEZuNmEzUjFxN3JPa3c1c0VyWG9JK3ZmOFlkR2Q4UzQ5Ym14?=
 =?utf-8?B?elRRUzVNZ0dRcVVtdjBQbDM0SHluUjVqVkMwd3p4TEVHcUxBa3ltYmQvQU5V?=
 =?utf-8?B?S0l6OVlwcHN2M05ueHVmMnRqalJNMzBOYXJiV2NmNzNIVm9CaEJ6akdTWGMr?=
 =?utf-8?B?ZndTak5pcXNOdGRicmNwV2c1RUNJQUlHWStERXJNcGVYWGhWTHI1d2Y5cU16?=
 =?utf-8?B?Q3lmQllaVmxsMHpmalpnNWd4U0kxOHJGMFZTZkhuYyt5bXlKTkprY0lubnRS?=
 =?utf-8?B?amdxZUNtRStrZURxTTVZVnV4Mk9DajMrRlpMZ2QzOU9pRms2Z21aY2FKN3NT?=
 =?utf-8?B?czM5a1V5clozdkpUeEczQjMxbnNPcGNDc1NPT1FhOHJXMHd4RjVpWUdYNGlk?=
 =?utf-8?Q?69TnKw?=
X-Microsoft-Antispam-Message-Info: qrf1chBPnv+1m8ctMLXEdxhTN1puC/493RWSJXJGTcpclRaVQQefLmpd4TBz1gD5oO8A3TDG8Muw5FqXMn6kOJEX94eVCKPU76YRwNqfrKU4T5MkX9wQD1e3Jp+f8XVjJsOaQztxiWhApLLBskF+7HcD+bztXyphIaLpwz0cK0NUmDOYUga/PaGW6kfZBqe3qYdy7s+MM2+yi9f4mntZumg53mpDp2cSdk5G6sqRLbNutkpqWrQYw6+CXiaQN68eKkVkXCrrfEXBRcRC/6Dk+kiI0Wzq8Sk0dgqxDlXIS7TTtx/2Yv3qLmalhs/pqyMgDytpCPn6crMh4c6lwbRd5DRAOWz00iXK/E1zCg78RQM=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0746;6:FQ3AWLWJ50w9s+ZNZZMStMxcnrIjqycX1xQsj+xeoPYbyfgQyqo5XE0b3hH8bwZ5kAztVz92iwQypiNGXgX3WYlt5gv5+Z4gvKoX8DSkfIvWFJjoPt9EocsOmWQ0a72VderdXBAu+ZnKQA6MaG9Zk+30IfLWbqt8Lp78JF8zJrOKlpWZ+ZMYVRYBcaQLBYaDcWCZgHjl5QzMUy9bO19cAsrknhSp2WLyof7vuprw1H3QUXwhNLUaajimPwqvv+RX3MTDE3kO5agqYy7n5Nl1VDHBE144gsFupjVB8UbWnteG21UT+5XAZoigOG4JEvLNOKmuwU+uLZGMrIHsuz3+jBiMwXIJyv3lN5SoK67fqGYUQBzYhq9RH22u+bVoBh/M1pm7UVJz9NqaEl0rGq4Uzxg4R6izdTueltPyAnaDW8HwTKO34jlntPr+a7e/TP5Peui09RReqLjcmzKtdjtP4g==;5:EoDMYFwFk4AdUIxfRe0oHOUr80WWFYx6VAA0ExfrFHym095aVjwPT/zI9abTfz/MtXtRt7XWfOBVzkWrt4mWQKikFNNvn37GADgbfVU04onNHevw8WRy7ZNR05sjl6Fti5NYXxSr4Lz8wSyWu2WSkC286LLyRCQpB6iRFo7UuHA=;7:km+Qaf6BVpBkhyRHr4ytZUu1Fstsqrsaw8hmL5Jk7yR9FA0gvpdspYNZcdvwZvZfhWgtUjhjtO3emqn0nADHXk2DOa93hG595oEzk5EainkjHLcHYHkKuOy4vzqVGSohIsfX1YlrL/QaYaLMg/JAyg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0746;20:Ov6DW+g1OQoFREG/CQA8pYWtVx1/zSa/hNJeYl3eQoiSxvDS8VKjkCGjRXP0e6we1x5a+mkqKGqvMbGgEZKF5a8ZMPMbbV/ZVNCpe52vmbd0B3n9YbxEpsKEE9SzElJkp60xtB5acUE4+CHrM77uJOIY86xewBj5qdFpTwySRNwanJo4XViuZYdWOoJKH5Ib0g54HuFbr0uQDCfTkOlDhrTLIeAZVsXG3rnYT/vfh4zTyTkTUkp7q6pt5NQqzvZf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 08:31:57.1513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 172f8bd3-84c6-452f-cbfc-08d63a5453cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0746
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

will send a fix soon.


Thanks,

David


On 2018年10月25日 15:57, Koenig, Christian wrote:
> Am 25.10.18 um 09:51 schrieb Maarten Lankhorst:
>> Op 25-10-18 om 08:53 schreef Christian König:
>>> Am 25.10.18 um 03:28 schrieb Zhou, David(ChunMing):
>>>> Reviewed-by: Chunming Zhou <david1.zhou@amd.com>
>>> NAK, GFP_ATOMIC should be avoided.
>>>
>>> The correct solution is to move the allocation out of the spinlock or drop the lock and reacquire.
>> Yeah +1. Especially in a case like this where it's obvious to prevent. :)
> Another possibility would to not allocate the dummy fence at all.
>
> E.g. we just need a global instance of that which is always signaled and
> has a reference count of +1.
>
> Christian.

