Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6762CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B180822405
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hCvC2da9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B180822405
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeHJQoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:44:12 -0400
Received: from mail-dm3nam03on0064.outbound.protection.outlook.com ([104.47.41.64]:19904
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727270AbeHJQoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bn+OG0C2+aUV4KUMt5kHZ+MaCHGWUWDkIeyao4JRYA0=;
 b=hCvC2da9eWYmicesLSk/FJdYHkL1Qn0FuRcfL3BkBUsgnZob+DxanLpbbMzkeLmmQdOC1RUJs2t5jurEEfC6VMRGm3v4tFU+2G8EjAomqJFkuV3NI8M5x1obvgcLUFyUrx8ILdNL1Bfnfhaub13uXO/nUjSTVP7htoFKiSYsgKA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.64.67] (165.204.78.1) by
 SN1PR12MB0174.namprd12.prod.outlook.com (2a01:111:e400:5144::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.19; Fri, 10 Aug
 2018 14:12:06 +0000
Subject: Re: disabling psp in bios causes errors in dmesg
To:     Thomas Backlund <tmb@mageia.org>, linux-crypto@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gary.hook@amd.com, Brijesh Singh <brijesh.singh@amd.com>
References: <3be85fc6-6323-b368-747f-b7650b3898b4@mageia.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <1e514ed4-a2e1-32ec-4ec8-64134b2fdb9e@amd.com>
Date:   Fri, 10 Aug 2018 09:11:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3be85fc6-6323-b368-747f-b7650b3898b4@mageia.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:404:b9::18) To SN1PR12MB0174.namprd12.prod.outlook.com
 (2a01:111:e400:5144::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b74c9a39-cadc-4ff3-238e-08d5fecb4156
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0174;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0174;3:kDYs8VCH+N5lEgi9zoz2ONKvEMKsB5O/YVU8qnPIy9Kae7oOc18jEkZ2oY4nJAsX24c82HnMjsMz8jUkM7R/5EmIJ09f73uRsPxre8Xr3tpvpUjXbhkO15JaOje5CkmqsGmcQYoRtm2MmRIZwaddWEFwBX+vl7Spx2YFDyJ1zeTPsLnTjdXUioq1Fv/1LeOfA0c+Y8i5ckZmp6LWaq5/ZuyZ+BATpRXEKtIOMk8OtJ6EOYqKVks7wW7EhF6fbkl5;25:Vqs0pLBkVXyOmdzFcKgcv5m1OYhD14YMKYYHqruHZC4DHl9UrZ5dj8Bv2jdGE5XJa3NL2NRpnc0LG4IP/rZcpEHHv20oswBhuFZrw1IczjnlOR4Rf3n64ne9R3q5OM9aQZ6PRYu7F0MIXWoc15cxnCbFKbJEtslPUBBjAwN7crYitQXfnecwriV/j38l4CyPkroaTWDI2vlf/vxO6IGsnC2w0N8oBLsLcYkl6XrCwf2brB/WAIo2jobfmB+OJvrHR4cvBoxo930k8cVaKQa0odV9CbfDN5NJEkDzoXQF2JfeTJs+myRTAMwJcz1Rq3zEuICvhBu4gWqP7y2lJ9VsJA==;31:vX3D7uzJ3DUpwVjfwd5kKaex61NhrznwFODtamg9rct/Sle2GCcju3elX3IIigRLcTkemI0fL3Eop+1JF4H9hvYZujVxufxXL4yYHL6OAfzWTeKhoU3nX5dAPOZJbk0pRLSqW8EOw4GNo1JqaAOO8IISAco0RSnnMmkfZKvquRNSpI1pu7Ua9BvPz6ZpW+gYwrm1LNa/i22WgnvYLDK4WBd0OyFrXM+EQtsu5KE1vaA=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0174:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0174;20:U8wwPQ2x7AK5e6cYsqpGzo6UXo1f1zx/Pls8/jM4Tjm+Iw+heOYGGZ5GoBWKEyPY50VnluusxtQSPleGNF8eWMf/ztim25LXCklhB3sIT28xT3v9/FL9lqE/JAf0yvOZnFGAW4GUQdIgNkng3u4JLb1XNjPVZE+qUeWhlYaFx95hOBBJ4wBDwVgACJzL04BRflKVYAWj9z0doYMb7NysNLQrFM2Etz5DRIW6wIWwjt3GIf2/uKOkJ2EmpthGl475Xo1QzKdTZfBl/5SQGlr2W3Xoy7XXLR+MLwhRFoY9l3PrMHTdczduDS1m0RYcfcd1vdzyxSaloh6iXXnK17hHHktjirkiV7UwKOgfq2vQA7sXpakIMRTQrXd8hgHVvtUhFF3E6PGCUwG5GDrhP29tOcEqIoBKHS5n3dptdweiBqbESTtiQC1wk15E9ZBW9LOPeHlNzP1OSgxblw+9eKteEjfhPjQI+ff7GmLgNAFHJ7HfW6ketRxCb6vUOw86jg1I;4:DQYJoGLYkJCDgu/v5mXF1yYNnsKE+xopfSMVAmB2eWK9bP31CnaSnFTdMCT3Diba5QK0h4VVWhTCXgpvgu15eQ+lq5jLlWJXHr3Ga6NkVbvrLQvhkU0Jg5L616jIcbL3ays4C/o1VMdN298i25S2pOn+WwLjvOmgdyEeC+LDC1o5HEx84q6aZ9vNSRFuXeQjPEqwvmKSMKM98MKuADgQTSet9LbaJkBgv9oR1iQ+05Y6opHOihAWkrjhuB52AZvu1qMFa2rA0CSS5MV1lYTRAw==
X-Microsoft-Antispam-PRVS: <SN1PR12MB01743C731BF356D212952E19EC240@SN1PR12MB0174.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0174;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0174;
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(189003)(81156014)(2870700001)(52116002)(26005)(3846002)(8676002)(4326008)(77096007)(5660300001)(11346002)(446003)(2906002)(956004)(3260700006)(25786009)(36756003)(2616005)(65826007)(105586002)(6116002)(106356001)(58126008)(16576012)(6246003)(31686004)(316002)(486006)(16526019)(476003)(54906003)(76176011)(97736004)(8936002)(47776003)(68736007)(65806001)(65956001)(66066001)(72206003)(53936002)(50466002)(14444005)(478600001)(23746002)(81166006)(64126003)(53546011)(7736002)(86362001)(31696002)(386003)(305945005)(229853002)(6666003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0174;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR12MB0174;23:FNBeSCPW/wgxZiVHXrX5p6UfKtAw56+Wu6CGF?=
 =?Windows-1252?Q?K7cMfTd/ubL+x/HYu2lLvpx0qJc7JO5HWS/d7HzBQvPcsU6Y1T9wJvws?=
 =?Windows-1252?Q?b40WSmDZ/G4dhunt0YbMF64spR8rSpHTkuvXK4bI8FGQ+3lDQPWQN7ZW?=
 =?Windows-1252?Q?39NjTG0cGiBy4duya3b1pU8kJiAzXVeGOwIjcgNK2qxno+4Gw4kM0QHh?=
 =?Windows-1252?Q?f2OcVm8XQjMe9L/Frnl0AtPtdks3Xa2sg0LNHZ4d3snZKM1gBF5duOo0?=
 =?Windows-1252?Q?abTKwvsIvi6FEURXScri2DruevQI0jE7fe+BnmLKEuV0yj6OPfASCH7F?=
 =?Windows-1252?Q?1k1pN9YZbIJJheY411Su38xv2IgZzDF7yOazTGo7ys3UkjPj24I2aVYb?=
 =?Windows-1252?Q?J2yCUfde5V9z7Avq9BZe706XEcVpRer9wa0brG5IEbFFT9gVeDajXQYI?=
 =?Windows-1252?Q?3UvsGDBQzd48gxI95ptlkGoRYy4OHFaP6kQD3Gt4zm6bJvVFxdbACqEa?=
 =?Windows-1252?Q?wzsG3u08kB6A07ldZVzfUk7C1rqmxTDpgZrX71z88o22ICvH/FCpXBKS?=
 =?Windows-1252?Q?QreI3cD3pKisLNaT5o9Wh1U9DsFaXRaorgGYz2rJ0+wGCFk8XPRHQtJQ?=
 =?Windows-1252?Q?Ojq2bz8Tywq+vbYxx7vlGLtJHNthJzOLqMf+L68WsIn2v/itj4uQqpK4?=
 =?Windows-1252?Q?rfgrVMuKR2ZV3AW7JxYqJD3tixG9EU0K5rLjR5vbvLmOpJpYU1EKjyNi?=
 =?Windows-1252?Q?LcJdoLJsMy+GfCjJaAnchCUVDv+9f5Esxh7D/3vkPhawAIkk7H2bCgIB?=
 =?Windows-1252?Q?IuydrR9vF92gOBbYNZtbf6EqhP9jPL/5vSM94c4rUBrOLkqXFCqqwum+?=
 =?Windows-1252?Q?ISWXJ8qWHfIK4UElKuKRQYJy3J3owUyGZtIH3sIAYkRLgU5KuAeqnEoj?=
 =?Windows-1252?Q?faGJVKKQcD8D/FetQI6AWjKt9jkISO7sdtPmOEjBOg7rrkzA92RXbQFA?=
 =?Windows-1252?Q?dH/MsGMFK1lrfAZIJZECE0c/INGNltIisDJvvKuHTdEezfaWiuXrEFdG?=
 =?Windows-1252?Q?CuhDKyGLlSDgrRKrDBrs9L3GVvO0OvOxTEjmO1NN7Hnpk+R7+tWkMJmi?=
 =?Windows-1252?Q?yoXUZoevjWdgR/+s9We/Ncj609Nc419maD2orQKQ0SBPHIdG5P319TE0?=
 =?Windows-1252?Q?qpS+LtrqsYv+9nhvowP2NArWtydF6kEkQ2fe42uJS6dHsEdynuMuIAFu?=
 =?Windows-1252?Q?n1FRXRPwJ/51VWF69Qq9WcHrqUiY2c73Qh8xK84U2DBI5II56fOkO7wH?=
 =?Windows-1252?Q?qHPEbTcBGIoNbP7bk33WmcNPBTtX86S5J4xTmUsmWSA0HAb97JjEXjuD?=
 =?Windows-1252?Q?DuPHrgcfDsl7rAtLnAh7IUZJ+cb7JbWSH0VieMrDOQlt+aQ8lyO92Dcz?=
 =?Windows-1252?Q?mYVlW8GCQu3H/D99kGcQmC2agOrde77yMYH13t63PnZZKXw9eSCL7YmU?=
 =?Windows-1252?Q?mkqaAkgfYwoeEgSF/+HpCXiL6k4gMjCg4BSfYE/5OvY8kOGLA=3D=3D?=
X-Microsoft-Antispam-Message-Info: pFSH9AC+GYBWrRv6hriPiXXXR1hQhvNjAKELHPpCvvl1oIuI6B6bdC9aeKv/g3+JhEtzYRdES9J4x/oNu84sPyUCdgZOxNAsxQs3nb9Z79GHlwsW7+DV0d5N5fm/SdpQ/bOYtgK4d0rbLkWupWV9eP3QqQZtRzilITeoanmB2IG7AXUi2CzNVIHiMeLFL8OAuBOYgc5pJTFHWKaI0ft1KSE5BSjArhGTGC3Aok+8sq2ydtkygpji2Tlv4WktdTcuOdmDq7olpD4W5ORLzMJsnUpacuzPXQXW3PmCE/BnxR7RctGaPMR4ywQo4SI+aB9ZezL+dTfbWrIFWU6de1xF82E48Sz/UQ/q1ukSkNXmjDo=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0174;6:9Zqm14UB2RqEfJHcm7GW1iNWMlWWhpT9Sb8BVB7l8E7xi1F5oQXTukNuHWR1vPpjxjpgevmif63AOMSjnnu/qbjVcgp7mNEymOR2foYkWs4F2C1O0dAkGJ1t9z4K8gNwj2i9YPWt6JOKoycl/pg4712GYb1GthqdKP6pou6zqaq4EK1uun+yjhUh3BnL8k87yim5xqlwlLxPUchy8kne1cZYIDcSP5j9By9Ab6Pz5bcLFkneVyJalH7ZzoXI+s7UkG7mT694RQn98kA8kKbL6KwcwgpvuCKkH09n0q3/SFuSqgOHNUCT9jr3eWC7fxNBjIw6+PXASOeijrHcRBx6WIL5dxt0NdBVCs9fXyk+xElsD8qpW/2p+3/xSprfx9pbmV1K38b5a1CrrohYOGxmYHA5EFO24Jy214peBsYRX3dqh+gThhyLM4FhkFI6QtSMI2KvOP0jRT6HS+l6SMdI1g==;5:yh4BMwYmOib+Aw/ZqgzegedyLO3mFzgSHHcjOaxgsTRz6fTERjUra/zD8DZscOEJaCapyKq75A/PG+0UM6VQnDtYAyae05S8+YGImsFcXIcdXoIbs9A4W4pPy4L8CQoeh1SpPcXRcdSSeqdh/vZfv4UxrLpYEfqATHGC+/Hvy8s=;7:KiGHQFKT3WYprh1Apgaus5pnj7UHcJe+aVyc6KyjhqeVgaNcSGIqTyG5vtY2sX3AfIEQwY7oMPZ0fi7PVaF1Lm9CX61nmXV5eMXnw3zu3+jRfvTcmhenlgNi6a+RgNu8uA2NGR9L8WtjLbrXTmZDdXpauQUoifZgdn2ekGioeZXj4JYQ3k/hzz1AVo7Km/kjKcXA9Ta8MRmJKIVK8ExOyvKKBWSRY45IkLN2vxzHw5G+tFrgWZ5u17kjVYTyZxEu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0174;20:15vaTlO4Ox1P0WuAgpLezY8WnfdyrCDP7Uu4+8domdachiUcgSHbdqAMCq2VfqeheA38wgn7cAbiTY/K6QNV1c0Gfb0RljFxR68k94HMWmVBzG9oqZyV+LoQe7pOukRjNudH+m5ki3sokmPVG+BdTUp3dYxSunHg7EE1ol7wa7XlqFj7Awghdt6q465iLh5itNECovkkmZf7q2t1HbxzrO1ZUXy14K7U17j0utZiqQCeIYCxOrKeqI2Jw8K68yWn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 14:12:06.5579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b74c9a39-cadc-4ff3-238e-08d5fecb4156
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/2018 2:03 AM, Thomas Backlund wrote:
> Hi,
> 
> this is tested on kernel 4.17.14
> 
> hw:
> 
> MSI X399 GAMING PRO CARBON AC (MS-7B09) bios 1.A0
> 
> AMD Ryzen Threadripper 1950X
> 
> 
> Disabling psp in bios gets this in the logs:

Hmm, I'm not familiar with that BIOS option so I'm not exactly sure what
it is doing under the covers.  Having said that, it would seem that a
register read is indicating that SEV is supported when it is not on this
platform.  Maybe the register read is returning all 1s, (i.e. 0xffffffff).

You can work around this by blacklisting the ccp driver module for now.
In the mean time, we'll try to understand what is occurring here and
provide a fix if we can.

Thanks,
Tom

> 
> 
> [  246.748978] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> [  246.748978] systemd-udevd   D    0   724    716 0x80000124
> [  246.748980] Call Trace:
> [  246.748986]  ? __schedule+0x234/0x840
> [  246.748988]  schedule+0x28/0x80
> [  246.748993]  __sev_do_cmd_locked+0x1f0/0x270 [ccp]
> [  246.748996]  ? wait_woken+0x80/0x80
> [  246.748997]  ? 0xffffffffc0683000
> [  246.749001]  __sev_platform_init_locked+0x2f/0x80 [ccp]
> [  246.749001]  ? mutex_lock+0xe/0x30
> [  246.749004]  sev_platform_init+0x1d/0x30 [ccp]
> [  246.749007]  psp_pci_init+0x40/0xe0 [ccp]
> [  246.749008]  ? 0xffffffffc0683000
> [  246.749011]  sp_mod_init+0x16/0x1000 [ccp]
> [  246.749012]  do_one_initcall+0x46/0x1c3
> [  246.749014]  ? _cond_resched+0x15/0x30
> [  246.749017]  ? kmem_cache_alloc_trace+0x3a/0x170
> [  246.749019]  do_init_module+0x5a/0x210
> [  246.749020]  load_module+0x215b/0x2530
> [  246.749021]  ? kmem_cache_alloc_node_trace+0x45/0x190
> [  246.749024]  ? vmap_page_range_noflush+0x24d/0x320
> [  246.749026]  ? __do_sys_init_module+0x136/0x180
> [  246.749026]  ? _cond_resched+0x15/0x30
> [  246.749027]  __do_sys_init_module+0x136/0x180
> [  246.749029]  do_syscall_64+0x55/0x100
> [  246.749031]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  246.749032] RIP: 0033:0x7ffb1a09018a
> [  246.749033] RSP: 002b:00007ffe196680c8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000af
> [  246.749034] RAX: ffffffffffffffda RBX: 00005562bb20d080 RCX:
> 00007ffb1a09018a
> [  246.749034] RDX: 00007ffb1994e6f8 RSI: 0000000000029e50 RDI:
> 00005562bba5e710
> [  246.749035] RBP: 00007ffb1994e6f8 R08: 0000000000000004 R09:
> 0000000000000000
> [  246.749035] R10: 0000000000000005 R11: 0000000000000246 R12:
> 00005562bba5e710
> [  246.749036] R13: 0000000000020000 R14: 00005562bb1fde70 R15:
> 00005562bb20d080
> 
> 
> Should it not detect that its disabled and bail out ?
> 
> -- 
> 
> Thomas
> 
> 
