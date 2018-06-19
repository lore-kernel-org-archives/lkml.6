Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA732C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E652075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xSQQNyXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E652075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030595AbeFSUqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:46:52 -0400
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:20544
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030424AbeFSUqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGK5ZEr8H/QqwA/W5u0hlZHWuQqxR5nrGAG3UAsxt/g=;
 b=xSQQNyXLDUBONHBLpSuU8+ysmceg4EMdEYWIg48Hw2kIs2cY6II4iY4CdMkNY8zSG3N+d0EYqN5EW1ItgBg6/sVKDLZOK8wto7jN94cEa1l2MDG8obx8Q6hWapiO/Pr7FDlI3k85CDRm0CPMzYyBA16vcV+td3Zz6FTwyeAxFg0=
Received: from [10.236.136.62] (165.204.77.1) by
 BL0PR12MB2452.namprd12.prod.outlook.com (2603:10b6:207:4e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Tue, 19 Jun 2018 20:46:44 +0000
Cc:     brijesh.singh@amd.com,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, felix@feldspaten.org
Subject: Re: [PATCH] Use 'imply' with SEV Kconfig CRYPTO dependencies
To:     Borislav Petkov <bp@suse.de>
References: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com>
 <20180523144621.GB25143@pd.tnic>
 <CAFLxGvyxHU_Xahwdf=0TYx8Nems78TLioLZGGLTkxNGCgxT4Dg@mail.gmail.com>
 <4f565a11-9e99-b861-06d2-b42922e44c7a@amd.com>
 <20180619094658.GB31750@zn.tnic>
 <3953c12f-c2fe-5d1d-bee2-ac9a230300b8@amd.com>
 <20180619194350.GG31750@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <15f10b01-e32f-5fc1-a2e6-3c6ab1461b30@amd.com>
Date:   Tue, 19 Jun 2018 15:46:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619194350.GG31750@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:805:3e::37) To BL0PR12MB2452.namprd12.prod.outlook.com
 (2603:10b6:207:4e::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 768e8c4b-6d63-41c3-8f61-08d5d625c552
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2452;3:7pfsgpRL7ZU60TQNZpoT/RImpZZX1zPwAIvHqW5Sq+goVAqbLKmL3bnnUXNin+/AbfmLdzOeRNNaFOTobujOAjtipZyDdeiPFZDYcGTeNAw7sFpLtUSTe4GaOkSxfyQfeCxHxIGiPGKVA932ipZa/dyhsZ8i3TUq12TZAvSwE6afpJWNJmqDbWReoD/jAoKlQRwBuiCgDtA6yoPxTvM4g3xna/5HGi8jqkUdFvMUyTH+rgsR18IihfWcVExQPWuB;25:SaXxtNFrS0VISOha+KHF6nEroV9gNHJVqpNHnIVMcPg9Fjm65hNX7KvKjoSg3vjRKU4eV5wZrVCI9vUkgNUzxyUVYQWlcuuVAjqcik6XASA26ApCPf3rjumie+rTgPuGyd0VbMjO04ynfFHv7qpcv5MOo6MQAMHxac+FtFT2efs/9o3M9B3LpxPvAX6PcmP+5itTGJN0aBkJhJvhKcsEhQUJPKZfIFzHzmb+tXWRg/jRoFm4whETr3xhVasuUsoee2v7DkzGsUAI/MdveYOKUy43LeTmYErVn62o2atZUaSppmaF655EkGn7CVyBqJQ+vJT9aducfk8x3GL0sBTQyA==;31:mGdygx9dzU4wSOWSI7DDUfcON9L/gS6YLn0cEuXECWqWBhhxP4ClTqfWpMJsCh8BRPiZkdweGf69QkM4G8/0MCbDrI45aXrrzgSku+NHS0uVKJYyruNa++7ggzNtU1GUUEBj/P6jo6U/HygXRV67/6H0Ifaz1xEdA0ys74NDHX/p50vvTD1L5DEc38dA5YheqnSXBYSea6sKJCJ3Gpb9kfWeUJgGk2818AN3lMnq120=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2452;20:vSSGCSLNqsRTREGGzP+dWHGFgU8KSzvINqDtacAJIZAplxzLk0ek9S/MYyPFb3tdZzTyKMJXBrsZ/cjqbxHibAR5iQdbu7FTLYIAxkPAgWwmfVIxQQI/bZ7kG4HuHkC+yGT3vuBr/ENDlkwlNjMssXutSWypPFtYBLzBXTEOA1BB3kLL/sEyB/3TJpNzWAujgXsP6dZ7MtWBlIMAOkbBSxWG4EEXWAwmeVRi9DRqMAeuTr6lY5qZc88GxuW7YreES4OSEeJvxcHoksn2lVgGbAGrg/dJHf3XG6tWxAyul33nBkhHUo2WJE0JPm240TfSAFbEIsNoJz037yUNu2IxJANM7GV6/fvrCoaOHCWTnpukCNfwuqBtG/NHRtWXxwuApnzKeh9D7SwYM5HDii80EZUHFFJjpY0wvArnYoZPZdm73YEeUTJC/aTqNR/kOooSMQj7m8rTzDZIXQxjZBccFw217xDo2FVNNGtz3MYKSh8LAj8+qMfW9p34qnLRRbkL;4:G72t2SB7iRsNAOIACh5ajE9Y/SH2sKI0xNHvy9zT0171ZoaA0TSXnxDvasQoKYuHuBgYCpIAg3CUn/ipIFmCwNj9wGRSKx/HbsSpcpTen7DxM1X2ulcMUAxSjbajZXJ3LLKi4l8vnIiURkiB72vHtEKon55OGt7J5TKRVJhrzwhczB2gQXj4bbcs9waAsVNl4JvHG0LMf23NKDfAsKM1/sD7iLvgnVOc2fpC+QEndVymMrjcD3ZNW+kOT0IBOcaKgNP60K3NyCWwMCLN9DFK0w==
X-Microsoft-Antispam-PRVS: <BL0PR12MB2452F247BC2511766F5DA611E5700@BL0PR12MB2452.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR12MB2452;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2452;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(97736004)(478600001)(7416002)(50466002)(53936002)(39060400002)(6246003)(25786009)(93886005)(4326008)(67846002)(58126008)(54906003)(31686004)(16576012)(316002)(3846002)(76176011)(2906002)(36756003)(105586002)(106356001)(8676002)(956004)(44832011)(5660300001)(229853002)(8936002)(68736007)(81166006)(81156014)(305945005)(53546011)(47776003)(65956001)(66066001)(65806001)(2486003)(386003)(7736002)(65826007)(52146003)(52116002)(476003)(23676004)(11346002)(6486002)(26005)(31696002)(6666003)(230700001)(86362001)(77096007)(16526019)(446003)(6116002)(186003)(6916009)(2616005)(486006)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2452;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjEyTUIyNDUyOzIzOmltei9LVnFpV0VHSWgvL2VJcE8xRFBUcC81?=
 =?utf-8?B?RGlxdmxMMm1qY3RJeExZWGdSVXYvcnVDemZsVmVrR0ZLYUF5L1NESlE1UC9w?=
 =?utf-8?B?VERHQUxDenZPaDRyQVdJKzRwU3kzajd0L0VPY1owdUNVeFBMbkRiajJ0MTQ1?=
 =?utf-8?B?b3RPTlR6TlFQNi9mK3NmUzlBTmFPYngvaXVuaHZTZW53SzRIM0tiT1k5VEFB?=
 =?utf-8?B?V2xuRnd0THZUTGhDMXEyZGdIYVVKb0JzYkYxVXRyZlpiQXNIbVIzSk4wa2pk?=
 =?utf-8?B?WlFTeDZ2V0dsb1ovc01ieEVneUdHVHVCK1FROHh4RVMraC9ucGhnMmpubFZU?=
 =?utf-8?B?U0VRS1p2Slc4WlpkTUZZK2Q1VzJyTzNPTUlIVTRLcWlEaFQrelZjMjRGb0dG?=
 =?utf-8?B?MG9DR1pvb2JSWEEzNWdSeWFFOStYVVRKLzZ6a1RKVk1vWWxEUXdBcElJc0hJ?=
 =?utf-8?B?MWdiTlNsN1R6OTNXbDQwU0pISk1BakhoaENiZ3dVMUt4MkRjTFh5SkZ4cHJC?=
 =?utf-8?B?d3RCUlVaSHVuRXNpZjhMWnlERTVyY05wM2RWa1Fpb1ljU3B6SXdpMm85OGQv?=
 =?utf-8?B?b291UU8yOEVuZFdRRW1keTE1SVhFeFh0bXFiK29ESHBZUjNBb09ZbkF0eWNW?=
 =?utf-8?B?ZmlxLy9iSzd5c0RoK0dSZEhsbWlLblNBa2JBWU5CTkRMbi9LbHR1RkNtSSs2?=
 =?utf-8?B?YUZSSU9iUFgrWEdQUkswQU9NcXlGaDJDT3Flb0R4TVh5Z0REeGwwOUt5L0JS?=
 =?utf-8?B?MTl4dTFSOHBpdkVRMm41UHJDOXBqSjVzSzFCcDM0eGt5NFRIRVRrK3l4c0xn?=
 =?utf-8?B?TTN1M3pZZUs0REdnYWVSRmZ5eHVrUWZFWFd2a1loTjlwdHJoc29lVm41WVp2?=
 =?utf-8?B?TEtrUVdpVTdWZDNaakRKWGJzbUREZzRtaVBiQnhsTWVuNU9CMW01N0UxbmhC?=
 =?utf-8?B?S0d5b3d1V0JnV3poZExlVXp3N0RvUEc3WERlSkRqcEwwcm53QTUzRlJnRFIx?=
 =?utf-8?B?OXE2NkVlOGtZbkJ6VHZNblM0MWs3Zk1BTEd2aUxXNWR0RTVvTEp5bjI4Qk8v?=
 =?utf-8?B?NWFtTWZabEVzaHk5amZhRzBSOGZnUWgyVDU2QkdoL01keUwyQVdHTWxHR3Ns?=
 =?utf-8?B?dmI4MFkrc1VZQ1NNdytoWmIwZmN2cGdDK2NJd0wycUpPbjV1Q1A0cnF1NmYz?=
 =?utf-8?B?d0F1clpzN29heTc1S1ZjSTMvTzZSNzBtY0NxNVFvY1ZZQUEwMHU0aTY0Zk90?=
 =?utf-8?B?V2ZFM2dUbnFlVjl3ZTRKUGlYL0VFZGRMSS9LYVR0R0FwbldSeEpabHlJVkxD?=
 =?utf-8?B?RU43QmxOOHJ6SnZzbnk1RDdDdlE1UFdiR1BmcVZDWVVnY1hLZVZGVmtpcnJ3?=
 =?utf-8?B?cWVGWWQvem5BVkg4ejZ5WEJsS0trQ0h6L2huVHRIZzU4QWJscFpWOEpqTWQ1?=
 =?utf-8?B?aUdhQXFqcGFqTFNaNWw3M1F5a0dFVTUwMGZuR1NpdWhoSUJUY2g2MERJQWFk?=
 =?utf-8?B?cGU0UU1iL0pJRG1kVlBZK1hWakNtd3pmd3dkR1FGQUNib3JmUmt3RUl4QnRo?=
 =?utf-8?B?ekljL05IWUpIOEdSM3dyU2kvWXZRNk1ySEtzZFJuTTRQUGJkcmIyOG5FME1Y?=
 =?utf-8?B?STBkWWQzaUQ4Vi9sajQrZXY3SlpZbmFOYWxodUNRY0ZISjdKT0puR0l5aGJj?=
 =?utf-8?B?ZkVBMnIwV2RrQVRtaWtoZEUrZnZaQkRRNURHVkY0NTY5TkwxL0s3emJHTmRP?=
 =?utf-8?B?YnQrSHhxb3plbVUzdlk2WFh1TnpDQStsK3M0Z0tHNEZkWXZ4bGo4c3c0bmlE?=
 =?utf-8?B?SlNhNHFYQVNiV1FnS1FibXNJK3J3cXpRN3VwcDdtbTZUZWwvV1R0b3cyUVpL?=
 =?utf-8?B?Z0ppNENpeGVzRm5kZlcvd3VkNkZYZHhUZHRZbHJza2UvbWpaWGxiMEJFZ3N0?=
 =?utf-8?B?UEl2bjFJcTNuTHRJcUxMbXNQSDdiMDd5SDFwVG1DNVN0L0kyTXlaVnNBRmhN?=
 =?utf-8?B?V1V5SE1ITVR1d05CaG1palhLNktFRld0SGw1Y1hSV3NTYWNScFAyazd3bXRs?=
 =?utf-8?B?bFZJam4ycWgyd2d3ZEhZVXZQYjgveS80MjVNS0FuNlVXL0pwL0hkUS9Pd3p0?=
 =?utf-8?B?ZEE9PQ==?=
X-Microsoft-Antispam-Message-Info: 8tLiNdFDhWkQXe12VLJEs/xzXCX1n7XD0jYgUAfoO7ici/JR73kG5WrjKAH9jEotxdx5izl0dNGr13PawkdWEDcMYCFSdCgzWhR5v1UFZVFDKW33ur0P8IMBHsBj73OHiuYz6sbzMkublzKZcKMRg12ZmHA0/kLSWVQobYdtS5mcb4C43ZDvNAKuazz7jJ3SfhBlTlVTJG5nvc52KvphxXj3thnhG1Vf405DRjAXMhDfNphkJRfYnt2GnodOm8SCsl4Y6EXW263uaUqUELjJtv7Vhru7RFKyaaSl0dzqSsVTptYl3uzxk293Ap7aOjKC
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2452;6:iYZSXqPOrf7lGhpZamgXT3Y3GqVzG1ZG55BUoZadqITUBNGBWccNruQ/xEzzDb1Kf8kfO/hBuvMcPL/RJNz/qy/S8Gq9yt3XUCRCcOvblqlpmKMeGum6SA+VUJNCf7JnP/YIN2MWbZJneWCXaZuXIoQt+StLd35jWqOSC4xNVWrtNNYmxUThAydrvxQ+fVqTMWYj+IVQAo3cTMb2MBE7mYgUOfNTc7bxyqy5EQ4SE9voSIWQ0kRPjLx2xRVDZmCDyNh3MrBC0c+TgljDDuiNcCRcDHrlNUgobKDES+kitx00cL0VBc0iqiLxFkaiyKSyHYe0P7ZbH007GdfJdp0gsdnPYF3t0XlwQNnRW3FWeFjx8W5xsmJWvy70Sc1Pj2QFtlTUcRXtdwa0XCfGIAdcZ+H3ByyD2DpHowjwVIzCAFyB1qFq04+/FZbdqPn0SOR23S1wTtKfFSZxg3DH0JgobQ==;5:iNxgzpEcsgKWDBytdWWJ/rZTCG7xDI6o7TjKcWK5GhMyZCAVQpgSPOF+h1WZ9b5eYD4F5kgrU8mGqiKjP3CwAZlsNDG8E3zETUX9qdSXS6TqCe4P1FTrwDjCm1/R4rHB4qZmoAMWDDCqc7m5d0OZFiC4uQKcuncqaIjt79zw8qU=;24:sDWhe/aYCD/V4Fu9/VH0wDWMoK9uHuK9ZfsJYEhjclEOA9aCh7hNVsFgY1SOeNf6ngOaUTYR9S4mog+4W0BazD8A3jqiutszSkO32rek2OM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2452;7:CDmomOElLd0y0hfDSSc80Fa7iMpEPgPWz/g/RuOpHXsbU0Pn/3ukj2kPh9MjjqPOqXzRhWhVBpsivuxijZAXCKzM+bffEo2hJVLgpxXxhx6haemW1wkTd7W0RJKXjc63DD53G/ax7b12n7/vruEsJixstZKWFKRAHWi5Xy1qEZE63j9wOQzzaSG79jcFVgYKQsZxY9uX+7j/f8tf75mceohzFTp1mtP7Yk+mvwj2D00MD79DSf5yvb1blKMsShAa;20:oGPq7AgfgOBYE6x53CKu/hg/Y2BJx4pamS5odKRE/IWpLJKebin7pHkfmunQlzRIqwr44QUNnKZPLsH9Bg/Pm7A7IEkQfYeQqdtMCFM1l64Z9mP2lOMpJ0iWdRZwbSRsjaTAUEazzw+8GeVqjjxTKyfe/gS77m0Spj9XoDqiHX0PBeq8JJZ1qjy2G9gN0TtyQk/JSAfEoXxrFuzFFC+L6EsO+7QTEW7DTFZghcQnUrjCjw0Sy08s/gv+I3DUtp26
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 20:46:44.5182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 768e8c4b-6d63-41c3-8f61-08d5d625c552
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/19/2018 02:43 PM, Borislav Petkov wrote:
> On Tue, Jun 19, 2018 at 02:22:53PM -0500, Brijesh Singh wrote:
>> It would be nice to have a single depends. But the main issue is, PSP
>> support is provided through the ccp driver (aka CRYPTO_DEV_CCP_DD).
> 
> And this sentence states also your dependency:
> 
> KVM_AMD_SEV <- PSP driver <- CCP driver
> 
> but what you do is jump over one layer
> 
> KVM_AMD_SEV <- PSP driver
> KVM_AMD_SEV <- CCP driver
> PSP driver <- CCP driver
> 
> Do you see the difference and how the former is much easier to express
> as a dependency vs the latter? And thus a lot more robust when it comes to
> random configs.
> 


In case if it was not clear, we don't have a standalone PSP driver.
The PSP support is provided by the CCP driver. If you look at config
changes I proposed then it says if PSP is available then we can support
SEV. But since PSP support is provided by the CCP driver hence we
need to have module dependency with CCP. So, we are using your former 
expression in the dependency but have to extend it a bit more.


>> Hence KVM_AMD_SEV need to have some level of dependency with ccp
>> driver. This is to ensure that the ccp was 'y' when kvm-amd=y for SEV
>> to work.
> 
> If that is so, then your dependencies are wrong. KVM doesn't care about
> CCP driver - it only cares about the PSP driver which gives the SEV API
> it can call. That's it. If you have to make it depend on CCP, then the
> design of what depends on what is wrong.
> 


We had discussion about this during our patch review process but lets
revisit again. CCP driver manages CCP and PSP devices. Ideally the
driver should have been called SP driver but ccp name existed well
before we added high level SP interface. IIRC, during SP patch review it
was recommended not to rename the driver from ccp->sp because it may
break folks who are already using with ccp name.

Here is how the config looks:

                   +------ CRYPTO_DEV_SP_PSP
                   |
CRYPTO_DEV_CCP_DD *
  (ccp.ko)         |                            +-- ccpv3
                   +------ CRYPTO_DEV_SP_CCP  --|
                                                +-- ccpv5
                                                ....




>> I am sorry but I am not able to follow you on how creating a separate CRYPTO
>> .config item will solve this problem. Creating a separate config will be
>> useful if we are okay with calling 'select' from kvm (i.e if kvm-amd is 'y'
>> then all the symbols from crypto will be 'y').
> 
> This is just an example of what you could do.
> 
>> I looked at other drivers where they have similar situation and it seems
>> like solution is same as what I have used above.
> 
> Copying how the others do it is just not good enough - especially since
> people can create broken configs currently.
> 
