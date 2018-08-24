Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A07C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB412151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ehUMsAmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB412151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeHXWXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:23:11 -0400
Received: from mail-eopbgr710075.outbound.protection.outlook.com ([40.107.71.75]:58880
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbeHXWXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RuC1alN/+UUMwjKUmaZ6JEHSCQeELQygiLuNrSgfmU=;
 b=ehUMsAmMgT6ozpFvKvvSHClqjg7baV4Qt/VgJ8HR9ADHLkXAftWuoMg7lF25fO9bSUkF6ldjTv2JIeXXSkOJ0IxkQKi1f1fuwUkn0UdcvoNnFio6125X1HoWyrFqPnxVh6FL24rd4vt28Om3H1Rs6ajkkSXleMyuiB6dyw69mqs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.24; Fri, 24 Aug 2018 18:47:14 +0000
Cc:     brijesh.singh@amd.com, Borislav Petkov <bp@suse.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: SEV guest regression in 4.18
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20ad6cd5-394c-d3ae-d99c-b656d7ef8293@amd.com>
 <20180821083911.GF24940@nazgul.tnic>
 <3d46f44c-dd78-8fa9-02ac-8206676ffde9@amd.com>
 <20180821151938.GA31212@nazgul.tnic>
 <92e2b80c-0dcc-94be-8d3a-5e11e5cf2370@amd.com>
 <20180822081417.GB4069@nazgul.tnic> <20180822150033.GA14200@linux.intel.com>
 <4d6ee892-a34f-28b3-18b7-1c663eb281c6@amd.com>
 <9635ebf0-7c99-6edf-1240-8dec28036a70@redhat.com>
 <20180823152907.GA1488@linux.intel.com>
 <60acb594-abe3-912f-9702-2f34961e575d@redhat.com>
 <c565ae1c-c2f0-8a43-b1f5-404c2efe7c56@amd.com>
 <25d2cf1f-11ee-ecba-73a9-15a9553a3d96@redhat.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <47b8f9dc-fb55-f14d-cb88-343810ad5763@amd.com>
Date:   Fri, 24 Aug 2018 13:47:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <25d2cf1f-11ee-ecba-73a9-15a9553a3d96@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:805:a2::19) To SN6PR12MB2688.namprd12.prod.outlook.com
 (2603:10b6:805:6f::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 181081f0-7381-4951-8dac-08d609f202fd
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2688;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;3:fGs9U1aYTHAR80eq/iKIqB0Wpyr3eVDoBZOjA/Jg2hlIMEtotUOUQjYPuZmfggmwUuTIU7wwihPSX8tZn8JKVY+vlQ4dRp6WUlXU9V7jAwrhVeeFe5rM/8GB5ug+0zuHzSWRVfGX0WRzAugImwV54kudeGxlgchTvwBbqVirGFpSGuJOmcoAVEu2KTcBmsf1ynAOomGV57dzsBCjUxG6rrRyKeBTo+MjXc9ct7t4uNHXM2OHkLWT9n+/25EtvJRC;25:XHaZ9k+FuBCBLbNB3FVfnDXMcL15rmMbB/l8TCLuZ8+Gp2swBX1gzc43AYK7aUog+J26gwWZcEiB6/8LOh2exuK/EwLH62CT2RGjN+b5qszmtfZgmZdFdtAzwYpwFWthAPzmi1vYYN4hHTZyQDTV2c5CnHcYHXK3C+Hh4P7BuLlv1hXQ6Ew14ShSV3IqaWjFRRnML1rhfVcCAXNpAQJ9GsYNbZ/AuCAA84R5MccOjW2336SolTY3rGdWH/1a0JE6lwyeCzD3hjLQkYXyYzGsCWmIvzOgyt/YRJ65wROox+567XTqGTZrE98wz/Sw54TyxTv7EN7kPphKHh6Jhoo8ng==;31:ceIMBURT+tsbZN8SUQokh7BkJphj2ow5mBs7LystskCDuJrVUpyYLIPSqoFI96Q6UxILYiSQ2qSz2MZlTqWEoJLIv2sS1pMzuCBSQ4WrvMI78lnQ/Hv6Ngy+vwGAR/T4r9KgR2aeQ+EzwnAXURanq+ldrjimnKEtij4WlEZLo/YrkBXomyCbW/BAO4txZgMNhkm2ok9pysLf0L5f7bLwQbb3tW5l1l8R1qxUCBVO3nM=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:JkDXPyfZwRtYBiy3vnCy30hAfEFfYRhqI+NE42gonOzee46/OrS1zuKBnH63nLm4FLzo/GhUuWo06xCYrJ9E08GBAY418ZoNDm75PyQyzGCqm8G7ae7x8nNoqSVFA005YciecTpPKlcjvhHaYyvvt5jl8fd1elb7cFM9pdtqGxma+5McdZSOG8L1FfrEMJpZ3ixqozBu+VNcll8E+3clPsfeGvu+/iqYAZ+qTAAqSwPL12hWotJFCi23xYyn453nnGa8pmlxlLRFBDOS7FnquOcM2qpup17cRLRgyIy0s+6P9WkCysjnCjxC0EBxi93gQEFVoCIIBKFA15/ZU/8UpOZ/fJ08HDbZTxnqoM5drSMsrYZninlK9qwBR8nota8Kxk09ex/PDViTJkf66A3CzfGB7bmtGYsxyEbmARgerYvbsiBaOMFhkUNsLVuXj4A2/N1joOtru+D/IeYQCarTU6/y73J5oQDaP4isogwPVlS/s6IOIudy5wMidjb9FSkS;4:T2bH/d+DNRjmKn3N8z8A39fMzOT/pA2aAF1rtczKTt5hb7a77kUbRh/2VgC4c14BePniwvQ6KK0m2GHlR2dgrHJ3Xz3YM/n8Ed7bVxxjKTFM5AHapgTZh0I4pTSgPBq5Oa/vei2X4AIDAA5kvmVuP09jK77eBii7ZhDded7ocnzV6yC8Qp9n6olXyV47YPtQwG+UdEJDVCGcJiqBc+OSRM9WKpYmQh7ucxTfnGrNxngqUzhUlpZe/dkgOGgxFZ/f1xRuF4VvWROfhokgvBxBhg==
X-Microsoft-Antispam-PRVS: <SN6PR12MB26887590D5B354DCD2B05302E5360@SN6PR12MB2688.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:SN6PR12MB2688;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2688;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(39860400002)(376002)(366004)(136003)(189003)(199004)(53546011)(77096007)(26005)(16526019)(186003)(67846002)(2486003)(97736004)(76176011)(446003)(6666003)(11346002)(956004)(2616005)(476003)(52146003)(52116002)(23676004)(486006)(229853002)(81156014)(14444005)(81166006)(478600001)(6486002)(53936002)(8676002)(44832011)(50466002)(305945005)(31686004)(106356001)(68736007)(8936002)(2906002)(7736002)(64126003)(6246003)(2870700001)(36756003)(3846002)(316002)(58126008)(386003)(6116002)(16576012)(54906003)(110136005)(86362001)(65826007)(65956001)(66066001)(93886005)(5660300001)(47776003)(65806001)(25786009)(31696002)(4326008)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg4OzIzOm1TeGVGN01USDhFUEdoS3dxUWQwakFxNnM1?=
 =?utf-8?B?UGgwK2wrVmhVV01CcGJDb2lORDNHNmlVcklQeU9xNXlTWC8yOUhXTm1oUisx?=
 =?utf-8?B?eWd1d0tnSFIzdUw1Skxxby9SZzhReFVNNEU4OGREOFZmLzFKQyttQ2pjKzlU?=
 =?utf-8?B?WnBUcDZaRzJVMXZRMXNDTU0wNHZLQ1ZIYVgzcXpWaGVoNm4yVG1lNlJTYUVE?=
 =?utf-8?B?YjNyUzl2SEthckdINS95ajFZVWF3SCtDMm4wT2FKaGFtUmVPempUSmI3S2NF?=
 =?utf-8?B?VzQ5NHdwQnRPd0xVVFppTWhZV3lMSkZUaVdUdnBaaGlqb3RESGJrd0MyOGc0?=
 =?utf-8?B?N3phamp5QXI4QkkwUmJ6U0VWMG14T3ppc0xMWjd1YTdwU2JLYXZEL2puVU5Q?=
 =?utf-8?B?UlhBUllhTWFSaUFpb2RlU0lWSmlzVlc4Q0RoeFJzNU5BcjV4L3ZTN3VOdU1s?=
 =?utf-8?B?U3Q5Tk0xM3NyeFcwTVZNbEdVd2ZYak9CUTdBV3RReFpsa1M2NlBZb0NsK0s4?=
 =?utf-8?B?WDF4b2N5QVdJbG85b2d0TWpCekxnV3p3YTJhR1dUeUlBeWFqRzRVczIzMEhK?=
 =?utf-8?B?WnZFV2hFYW1JRDFYeVoyaEhWdFA3eGE2dURIVHdSeE1FdGxLME5SWVFOSGU4?=
 =?utf-8?B?dHdMUlZSYlZoTnRoN2ZrbVYxb1c5ckR2djk2UDFrM1dmTHdRWHhUVzAyYnF6?=
 =?utf-8?B?L05Sd0Q4WVpRK3NBS0ZUK1l2bDg2bHR1bXdoSllnUEpXeXhFUkZ0dkQ3SjFS?=
 =?utf-8?B?TGprVUo1dGs0OXNScFhqQWcxU3R3VEdhSTZHVFA3My92dGdGQmVueVhEcVlL?=
 =?utf-8?B?VG41aldDRGxrQ2RGc1pPaVVQVHk0SjZnWWNNNnp0bDg0WnVVMGtNcGtBdzRk?=
 =?utf-8?B?UW1DRkE3SnphK0FvL2ZwaDg4SEIzdVhFMmFuTDZNTlNqQ25GVGlUZmFnU0xG?=
 =?utf-8?B?NmFvRTYzdXhuRnZZUXZOMTlBTE5xYzdCNklRZ2grd0NkcmsxMEFzSzc5cjYw?=
 =?utf-8?B?MHJXUklFSUkvQ05RQ2hMSHdlZlhxajlMQU1YSzRLenJ6aXRSQzdadDlvcWZE?=
 =?utf-8?B?NzZhOC9JOEpmeGlLV3drVmE1cnlWa1hNQXRoVFk3RzJmMFhHQVp3UVphS1Nt?=
 =?utf-8?B?Z2JNL1MxMEVYMHZFMHZTMSs0RzZxcUl1S3hQMGF1TnBIZ3JVdll2a1kweXJL?=
 =?utf-8?B?TjcwVjM0dndCNGJpUVNrMVF5UW8zZHBFTERBZUdYZ29EdnhqRTJFQlNCdGtZ?=
 =?utf-8?B?WHMxejJJQ2t5eXEzK29PUExaS2R3eTZPNnUxM3BUZFN2TW9kUmpPTVBiUC9X?=
 =?utf-8?B?RUJ5K3paYWE0YlFJWGMzVSt3c3hFa1E3TDFYZUlleGxyVU1XOTNkVGdIOG9v?=
 =?utf-8?B?by9CS3JRSzdlQ0lmemtEUkhjb1NreDJ1aE1leWVmeTNKam1CZ01LVm5kRFdO?=
 =?utf-8?B?M2V0SUFQeTJBVERGbHFqWHNwV1l6VFpXWFdRN1NpZkhDQ3ppLytHM3ZpQ0V6?=
 =?utf-8?B?NzB3NE9sbEtuOHd6cTYwc3JDaEhUZFdPUFBrMmpEcWhKcTZvcnFsZFJ0OHg0?=
 =?utf-8?B?WjJJbXlQU21LMlBkeUZNTWFYM3VwcXkySW8zbGQwaHcraFdUZ1RSMXBpamsy?=
 =?utf-8?B?L2FIeElnQVZOOThGTEtpMVF0VnY2YjF0RUc3aHNEK3lRT0ZiOWZSclB3cW55?=
 =?utf-8?B?QWhXd0dtTFJHK1VpTWNQRlgxSVVpQUVHMk5vZFNIcnZwSGxqWW4va3ZNNWFI?=
 =?utf-8?B?U0k1MW4zZ3l2U1VOODVCRkR2VE1OVjBrWmE3cUM3UVZ0b3hGK0dDa0FWdG0v?=
 =?utf-8?B?aFpaZ0VQNHRVN28xTE9SL2ttcStLTmtkbDd3MkRwcWVFbnA5SmpKT0ZyWmJ4?=
 =?utf-8?B?OFpiMXZvN21BYXNMSmJUOTBiaVF1L2NPV3p2MmlsL05vL0RJQWhBbWVCYlFW?=
 =?utf-8?B?cXhRL1FibmhpUlJ4UjV2RWVuYVVnREdESTBNQnJCRkxWUHlPK01OZmRmY0tk?=
 =?utf-8?B?MzJnVWhLcnRhWmpkVWl4dk1XdmRLaE9oTzdBRS81Q1Exb1c5OTdLTDMwbGVv?=
 =?utf-8?Q?RO/s=3D?=
X-Microsoft-Antispam-Message-Info: jGEhhR/AReCC8A8b4pAPEOP5SB2nifAgM6CcLXHvfh1Eg7tDYzspNN82dCyXyIUJltjdlqsJepNOKZRMU1QE4k7+uZ91q2jd1mqX7OF2UTmO4tEhY1WyPX8mtgduRQZD0HXvALoWG/6XEtwYx1gACAX/WS9iQf+yjlsyG4k3iQc4l8FXOO8Ih84Vd24WdvT4mjpy0DNb4mzWFuALSrm8KmZlrWAv028RXDaGZJWYE8AEEBZ21Y7edJKsvkpyOghRReBExjM5Whnm6hdrpnqzCET/Z+ZMvEoYpcyoYX6vwhqglzhL5eEhwyWzR0yHVr425H8ZPZbUM9yamhBgnU33AABJEMvgFPN/TsltBOddOpY=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;6:45uwZVnuahhXoGvu6z6URhDgwigeJoi/fENUP4lmrFoQFBNtBlFccPGFLYoEVobfGwX0y9ParIc8e9ujetnlr3adCap2FRjBjuI9eRKrU/yB8DcMFXMq6XDySvGRDgIGpz4DVDU/TYUkt9NVP64pYLuUXx7Lfti8t4F5HKuS2IBLIVNkkLvhABZqC8xblMF2x/2+DkhsqzGD8gwYnZw750Tex56/eokLLkfdSZZXBUOKbDICgK+nRZYR84YvD9Y0ZGw/tzC8fztUqwfAPck3HfK6VeUazhfvQ9T74iEGm63DuGQOvHA4h/b9N8zARJHn0QoRO/+QojDwMq5l16EpKCBiH/0beZntkv5uHHOozCo7iA6hh9ngIRjNZPpDM61YZ0TYx/7Ip0PXulz/lzxeRjU9NiltKJGQqOxad9VsS1qXw/Z4dNBU6nUuRVrhaY8qaxysFRae576j4E9NBZ4DVQ==;5:qWHj8nqtIDz08hEkOBpmYe4acSrH6sRWwNeOQmoUaNmvgqPzwVpLIqHq5wwQYqFLMZi2Ou+DhlcBBZAugONiwu+tvZWqNivhof9rJWnA5zZLuNtOEXSIIZwmWodWA2WIqB/6hWR6W9t9OLvc6SiAJFu/+Mh6VJj71Dxo8W3l1/Q=;7:howMozcvdabytNijAPdiFsbP2we/030DKKv39iRSe2lvilFHcYkWxxjnM/X3p/r3dSaUv9l91THFGmvtHXKCWdH2Xw7QMtTZ2pPpZ0uY2BfWhYKY4gvuv1FVSV4uDGBqhfvGZSryRD4hnMQT/eK7z6sC4ocKMgR8Y/FUkWvfammhQWQ1GBOqaTB6++KzlDUhKhSRCV4H6w4sznm3affdYMpsHgb7syAMxOo6iShokqSrTYrEMGkJnNpR5jsBJS0L
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:+SR/uDUMfdVlEMZ+Yu88o/OJ54XEsnquMLMhqgTYCu8WtWJ9fpVJ4tO7NiSNxaWkYlwVNCVPbHwm9r8k9T9mGc8QBj9YvdAwJCwZi3SY64QXMP6zj68RduTj9bYTTjycyX+IhmgFfq3MyMr5CK/KiULeRwJwIGrxj1H3mEH1+F3MVEVo5K9CO5AxNW5dkWXZehO0QJrC73QwE0xtlDe3sMrAmeO16kwF4HdTDK1g68e6bFkNhzp4sPijgkYvq/iq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 18:47:14.9815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 181081f0-7381-4951-8dac-08d609f202fd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/24/2018 10:50 AM, Paolo Bonzini wrote:
> On 24/08/2018 17:41, Brijesh Singh wrote:
>>>>
>>>> Wouldn't that result in exposing/leaking whatever code/data happened
>>>> to reside on the same 2M page (or corrupting it if the entire page
>>>> isn't decrypted)?  Or are you suggesting that we'd also leave the
>>>> encrypted mapping intact?
>>>
>>> Yes, exactly the latter, because...
>>
>>
>> Hardware does not enforce coherency between the encrypted and
>> unencrypted mapping for the same physical page. So, creating a
>> two mapping of same physical address will lead a possible data
>> corruption.
>>
>> Note, SME creates two mapping of the same physical address to perform
>> in-place encryption of kernel and initrd images; this is a special case
>> and APM documents steps on how to do this.
> 
> Ah, so that's what I was thinking about.  But a single cache line would
> never be used both encrypted and unencrypted, would it?
> 

No.

If we create two mapping of same physical address and ensure that
accesses are cache line aligned and size then I think we will safe from
cache point of view.

I have not tried early remap from kvmclock_init() yet and not sure if it
will work so early. The downside of this approach is, we will put
too many constraints on caller; it will need to ensure that variables
are cache line aligned and sized, never accessed with C=1, and must
create a new mapping before accessing it.


I am more inclined towards creating a new section with PMD aligned and
sized. This section will contains the decrypted data. In early
boot code we will update the mapping with C=0. If caller wants to create
a shared variable then it can do so with:

static int foo __decrypted;

I will submit patch fir review.

thanks
