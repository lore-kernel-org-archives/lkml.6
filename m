Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4004C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718EB2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xsofpJyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718EB2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeHaMSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:18:43 -0400
Received: from mail-bl2nam02on0061.outbound.protection.outlook.com ([104.47.38.61]:36808
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727334AbeHaMSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h1I8Z9fYarAOtquD+86cCLkf/NR2yLkAWv5Or0PrW8=;
 b=xsofpJypJ4ZxWga3ISQEMMXjTVzeWXAHMN8bR6/YXIIWfuQxz9eKwc48jSBBfjS1IcasoQ60fdsBswH26FnYWtfKKZnqUu4sFqlB/N5fyWnQyOGlM7laZjnNqf0BUISrg8BW69628QKzyrOFcVGazbdj8wTa9aHLuE3UV17n0v4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 BN6PR12MB1715.namprd12.prod.outlook.com (2603:10b6:404:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Fri, 31 Aug
 2018 08:08:23 +0000
Subject: Re: [PATCH v5 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-7-logang@deltatee.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <98bff500-4e4c-3a34-6762-16ef4b076d90@amd.com>
Date:   Fri, 31 Aug 2018 10:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR06CA0149.eurprd06.prod.outlook.com
 (2603:10a6:7:16::36) To BN6PR12MB1715.namprd12.prod.outlook.com
 (2603:10b6:404:106::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f938881-4e85-4d73-3a3a-08d60f18f041
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1715;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;3:ciXzFbF6IP7dZB3E8mFJ+BwmkGDRyT7xOPZJqSKHwAaxcvnDnn6IhcrnqNEEU7nCXXIYY9KhxLCDPyWRc3pHI9JsnX+Ch1MPPTg18PTPsLWUnzR8QEwwT5ibNdNPDewkH39DJ2AX5FfUBCViuBmjGJ+dp4XSor2BDOKfgRPXFMgvUef2aUqmuHPySAMGR/bPJivlfwYzM+ajGuhusCNyo5Qt+iXXyqVjHgsoNoYm60IGCoY18nj2skq3caDtE4W1;25:xtuclXkiuryQEZQexwOv9gd1Esu+yScnCYHwjmkhG3Z1RPjtlILcN/X9sbsZWddmMsZyYpu1kDOeqbdC4OGqolTOhXX3lPBQ52H563Fet9YHaUOvL2aFtYpLbdrbJkGyO+Edvt4mTxoVXcmznaBxcAKv/4eFEzurGdSByJ9IKgcAICd4AMasOAdMQGl50sBTlpzPkoZAKPNqrQoMvr8d/ry4o8gaqjdN1VuyQo1fLvjDY2mFT2Ls1xhNwe1L6EH7DgGFKS7np2FpeGWMnSN2PStBda138oAwmX5Od3B6dy6DD2jHhj47faO260W5VgzSTpE+KhB3Bj+g07koMyaufg==;31:+VMG9fpm02bt4h/ososcUp0c2D8tsWedbOD9F9CUcJ7A5HhnO2CNkiREYqvxPzuV6e6rVMB47wzGD84TuMaUDgS2O9G17u/rKSXn2W9xE7Hsnmy6lsIMSyixMvyigq1U2Qbpiey8/iZjm/VecKMHEtU0qfxhak+2AgRW3AwJ0leFOktEOqHXb/20nHZZqTEE03rQ//FhVfVPbnKjUp9Vhho2wzO83V+MHECIQ5P6MBg=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1715:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;20:OhsSfK2MEPedyCVxT4mIULFWchXCeA0GoPEwOh9QaCgJR7wkeBP36NmOKcvL9FDsrTC0iFRT0m0iXlori4SXmtPa5J+LJXnMcEgRXU47r8prKhZHbdWtYLIY/UMdM67Bt3hA9roG6sSe3D91I2+aXMZc7PWJtsbQBVJMiOd8C6M6zLlczK9U3lCY36l6Fx53zCkEv7gqQlKa1z8mN6n4oLZpu7efmITMBDSeFqjhmn24Yo9UHyeF3PhFq3j1xpfReVz3B27UL3LPTqHYRQ3A0atX+DwxkRUEu+0zND85D4mctFtbSZK4XZ+LrBD/lpc72J2D4O2PjGdjfgcMZmvDbBn/OMYHMpdjFzHaq1rEamsycvm3KSrxF/Q0OCLv3LV0hx735ab8elhNdLOpZGaRL7AHVp9RFl0SHpxbvK5NlwLyjbijwTc8EMN2cwXEv9FQunxRP1ZivgwupZT7u7VBF91xoGibiI4tRBQpo8BS6mVFsufROjPPa7KqKFc/7Yq0;4:Mja8lFhv8CLCWNlKl0MnvFF5sZF4nYtAOISFRTvasoxHV9wWr6YN5wcW0T/SB3sfsFcm2oDsbP7jnTZ/mZwu0REqeb3z17bgY6Mcs+PHUjukR34nFFjzLMXPg8xd/QJSgnIvMWlohoPhdlFFwugxwFv/ghS+OA2IApIhGLrswXzIYJZYAjEB6spREzEB2+Iuvq6TTVcDanWh/nCMoNamRrdwh6kJ33uuaxFcWpNCK/QD1bLVLOmLixYPo3xMZseUiBMaEfmE42PLJHq958DktQ==
X-Microsoft-Antispam-PRVS: <BN6PR12MB17156EE23E4303F3A62FCBD2830F0@BN6PR12MB1715.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BN6PR12MB1715;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1715;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(6666003)(50466002)(386003)(65826007)(53936002)(5660300001)(106356001)(67846002)(52396003)(76176011)(52146003)(52116002)(2486003)(23676004)(64126003)(54906003)(316002)(81166006)(58126008)(31686004)(105586002)(186003)(16526019)(6486002)(6116002)(1706002)(230700001)(46003)(229853002)(8936002)(97736004)(68736007)(7736002)(305945005)(36756003)(86362001)(486006)(4326008)(2906002)(25786009)(6246003)(65956001)(65806001)(476003)(31696002)(47776003)(72206003)(446003)(478600001)(2616005)(11346002)(81156014)(7416002)(8676002)(551934003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1715;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE1OzIzOkFkazRIM0hFUWJLVjJuLzZGWkY5Tkxhaks3?=
 =?utf-8?B?KzNuRWJXTm9kTGR3aG9FQThGVlVQRzF3OGZ0b0hMak43SVFGZVo3NkxXQlBp?=
 =?utf-8?B?MGloK3Bld3BPbmNZSlpxOVFaUEFrNmV3THgyN0x0Z1NoRmFlQ0tYYXgzdWg1?=
 =?utf-8?B?YWFtY05qVmhqUEs2cEdPcjV1NTFSTktMSlR0SXNtZ3N0MFhQY04rU1VaZUdl?=
 =?utf-8?B?NUI2MUhBTXBRZjcvMzZrdUxnS3VnT3lDQXJJNWkydmRXS0R5VUpkUTVaQlN1?=
 =?utf-8?B?ZWdUTlJvMkc1S2pySnVtUEgwTEw1RTBieEkwRnp1cTBIdDBYUFh0L1U1bVVU?=
 =?utf-8?B?Ylp0WTRZSGZSVnpJWEZ0eU4rQ1Y4bGdnS0hFYmJqcjNya3V4c0pseFllTDRG?=
 =?utf-8?B?cVJvTFd6TUdGT3BmS09UcDcyZkVVWDdnczR4VXZYK0JqWGZlMjlyTURpd0FJ?=
 =?utf-8?B?bW5kelZSbDBxenZoc3ZuSTVaemIrZ0lmOVRrckkzZmFLUkZJK1pUOEpFcmRy?=
 =?utf-8?B?NVkzalRyL3NDOWJya2VzSjIzSUd1UkI2dXhKYm1xSjRQdHpMYm0xY0hOcCth?=
 =?utf-8?B?UkREdUZIZWR0VDBKcmk0U2tveEh1Y2RxNjVHYnVPeGZYQVJrQXloWHRDQ05z?=
 =?utf-8?B?a0xKcW9ZeVB3Y2ZJQmN5Z0MrSHozZ3RDaHpudU55ZDAyZW8rNTZGVCtjeEox?=
 =?utf-8?B?ODBkTVFMNGVWSGRBbHhOTFZWSmpyL1g3ZGZWZlhuUHpvVFUwSnJPL05JY3lO?=
 =?utf-8?B?S2tDd3B1bHVWcThNRUY2RnYzaGdLTUFacExuSTVLOWlxM1VaMEZ3eFdlcEp6?=
 =?utf-8?B?TjhsZ1NiRnJKdHR4dWgzbXNWTzhpdUZ2S1k1RG1lL0VNcDFqYTdveVlHSUpQ?=
 =?utf-8?B?OEN3MFNac2hMa1VFaVlTY0tpanVuQ2JvdEVvN3Q4dDBnR2NMWlJyenIxYzVL?=
 =?utf-8?B?ZU1rKzQvWGVDdGwzRTltT3plR1luNDMreWxPZFN3NzI4TXRFK2lCOWRRejdZ?=
 =?utf-8?B?VFptbllMTzNDQzF4NVZpTUdORk9PM2VncnBFNW5KRWdETVE3RnF5aXNIT0xV?=
 =?utf-8?B?ektROXlHcSszdFJtZHBTYjV1TzhxVjIvU21YbjVsd2h3eGxib1FsNDlOT2Fh?=
 =?utf-8?B?ZWZNUWs5TUtuUHpqN3B1TnpqUWh1c1RJT291M2ZoWForR05DL3k5cFhGTEFm?=
 =?utf-8?B?Z0lpdDhDSUJMM3Vzd1g1b3FRcTU0OUplblFPZStQVzdwa2Y4S0FIZFI1UXZD?=
 =?utf-8?B?Q0RyZHZGWVIvanJ0Z29YUjltMmkwOHRZVkhlRnFRUjNEM1hjb25JVFk5Tkhh?=
 =?utf-8?B?b0t0alB5RUpMSWF0UkZ6QnVMZm1qVHdnY25YR1dKc1lkWmF2RFh0Zk9FNW5v?=
 =?utf-8?B?dDJncEY5RmdLbU9UQi9iOGNhSENPTXdFNlNjbHo1em9nUlZJOW9KN1UvTnFI?=
 =?utf-8?B?anFHQVpDeDRySDlQd094WkxwQnR1b0NFVVR2Q2U0MmRjTzB6Ukt4UjdlRDJ5?=
 =?utf-8?B?Umt6OHlsclZsd2NUb3hESnV4OXNZZVRxbDdCMEZBR0NTSWtwTmZDVFFvbnhM?=
 =?utf-8?B?TCtJU1hHdmZmSE9sMXMxYVJGbW1GSm5BYk16SnhyWExmZmNkNFp5Lzd5Nkpk?=
 =?utf-8?B?RmtGMStidHByU28xQWpEbjBIVzdVL1V4Mjk0K2gyL0diYmpQYkNmYm9YazhM?=
 =?utf-8?B?bGdvVStQZDc4L0ZtamNBM2hjM0tYNWxjb0NrN0hjL0l5ZktyZUlqNnlIVk5n?=
 =?utf-8?B?WnMzaXZBL1I2QnpPdE9CU0Q3OURiL05TemEzMllHaXpuMEkzTEF5THk3eTJQ?=
 =?utf-8?B?MUNKajZnZWVhRXdvK0Rvc1BHZVZXOXdoZDVmWVZ1VEZsYUp4czFySThwbmIy?=
 =?utf-8?Q?HmKj+PKHRmQ/pVzHpCmguizSNMAqQP4t?=
X-Microsoft-Antispam-Message-Info: vR7EryrCUNEqspmi3gwgrILdwFEP7FQTXtcdRSi8mJ2Ks3NUGv5X3lsTaFlA97pAycZYtMVRNDngop1ZvTAfpGGfZKXYIX2xjkt9issFBzslBRXGb7awrufB6NP3zWk9N/c1HpNm/Ri0n49FaISLtEVPVW4lUeVq5ZkOfUPRUzmEgQcyX4I7G5bhpPJC9K1IdnQhTGbJTftQmhFiaBNvAJAo0LgkypdaC0S4ifGJc64BCIeGcC+BF+V5OZOyl23aKf5r4kAI/UaGDroZQgQyDGu1F3T0YdVf6ZKkObyGgIIf3jyj99ZnMzDmJm2eIG7QRDEkpCtQ+GOCLS/dGeqTQz+cvYfVY5EvhaeGE9qP9Bo=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;6:T1gBwAyp0xuAchZut70gzBgoP+Dm9IvXgfYkbzBGRLtJUM7dluPYRbZA2Hk8PvfIhbE9BjCQuTZRbdCaN+Lcqiy/OtglHrQIwpRaBpN1zXSqsCug2ahKO8JOWTFdu13FK5EkzpP3oY5xqw0xTbEPDFpiz46sTE8g0D+XQXA2prBtNxO5ejhapNdZFAL2Ntn6V2LSBoSjiYsU4DPk/GmzZXc53tazHT9Fm/MCfqazPV+52DaNnABLY4FNZuGablndjnterRRU8uiWAcnC7McCg2AMNaZo5U89ql8jetj99rTgm5ip03rai8AVpzqNh/FtKSMoHx9DI6E74uDivvueVCLQKNpDwchW+I6+Unm1A/MLXY06BWwJKUnfSNRNdE8YaX9WNIb1BS9va2AbEQ8tKLebElw8drEckTVi0Z5w6Vi3dir02eHXjMNNN6u8fPWeAmelYgGbquojvBoB7V+61g==;5:cUxxVbdbPgLLpFnFtXJ/3qMM2mY61L7yhBMsXhB7lPXeItJgzvcniqjuguVTgkFjb/6MtzRsWIRZKgXu5NaeKR8FFZP31dVQ2fTj2SmyppFtZKxNxB0AezspHwxKFY9n/9mRYcm+2O6WQPMOPG/ctdBap3eWAFphTTgA0aUUoCU=;7:Ceoi0d5mXftJ56HjAVnHHB4OFjlFEZgsTah+tjGRE8ta2L7swn6/dao7FLvpTod2KzDYM0yhEpYRBNikpbEAbCAaCqDkka4UF7/PuQyd5DE9+eIDKUoI4xwyZYlkkVcAxAmym9ZkYt/PbW+Uy8VSzUkyPZhcPSPDepG+03VIfchtM5b1fo2j+t7sTz0CpmjkiJ/fkbDXjkVrAa6q6H07oeZ0RcbUv17BTXUnvQBugYrLSd8HxE0RFCTA2MlF1jcR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;20:KEsdM9PJK+3RkHpm89XMdvENkwtUJ1gGKOpWghlY2UGrpEVuEsPyOh4IheJh9LU08HfWA7sTaFRl7TY9O1BsIDig0A36RalKFTWHPhCkimFxCr1IMuIJxX47KyKGM0MyRnjrKGKmwfzX3ysSSQGenRzN/oOB8oHHkT99HkSTL7QFZyZohnvSlsVDPUvu9BFxEzLmr9aDflXIaqXNpIqKH8oYtsVX8af4p+t4pXE3T97CHFeRyOL6O/t5I2Ly5IS0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 08:08:23.8758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f938881-4e85-4d73-3a3a-08d60f18f041
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.08.2018 um 20:53 schrieb Logan Gunthorpe:
> [SNIP]
> +============================
> +PCI Peer-to-Peer DMA Support
> +============================
> +
> +The PCI bus has pretty decent support for performing DMA transfers
> +between two devices on the bus. This type of transaction is henceforth
> +called Peer-to-Peer (or P2P). However, there are a number of issues that
> +make P2P transactions tricky to do in a perfectly safe way.
> +
> +One of the biggest issues is that PCI doesn't require forwarding
> +transactions between hierarchy domains, and in PCIe, each Root Port
> +defines a separate hierarchy domain. To make things worse, there is no
> +simple way to determine if a given Root Complex supports this or not.
> +(See PCIe r4.0, sec 1.3.1). Therefore, as of this writing, the kernel
> +only supports doing P2P when the endpoints involved are all behind the
> +same PCI bridge, as such devices are all in the same PCI hierarchy
> +domain, and the spec guarantees that all transacations within the
> +hierarchy will be routable, but it does not require routing
> +between hierarchies.

Can we add a kernel command line switch and a whitelist to enable P2P 
between separate hierarchies?

At least all newer AMD chipsets supports this and I'm pretty sure that 
Intel has a list with PCI-IDs of the root hubs for this as well.

Regards,
Christian.
