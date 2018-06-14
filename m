Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4C2EFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B5E208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Pgeve/uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B5E208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936010AbeFNMIh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:08:37 -0400
Received: from mail-eopbgr700048.outbound.protection.outlook.com ([40.107.70.48]:58208
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754990AbeFNMIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbGQWiGF70gCJefC4y/tbmlqx+h3kdfo5VUrSm1BXAQ=;
 b=Pgeve/uj5w5UXmZiBea+gMRuWZBmX1Qm6opC/zhBfS/Gj69UnO11tyMzJzLKD7e5/tI7OxDnSgLm/w76Fg609o5nYQMx+R5bZK4UNcq5Pjl0We5USeW1BQr6VPqzmIbWcc8XJC5+yYVOSZkALSAPjxZHMQy+SLAjybx4mIfP4Sk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Thu, 14 Jun 2018 12:08:30 +0000
Cc:     brijesh.singh@amd.com,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, felix@feldspaten.org
Subject: Re: [PATCH] Use 'imply' with SEV Kconfig CRYPTO dependencies
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Borislav Petkov <bp@suse.de>
References: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com>
 <20180523144621.GB25143@pd.tnic>
 <CAFLxGvyxHU_Xahwdf=0TYx8Nems78TLioLZGGLTkxNGCgxT4Dg@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4f565a11-9e99-b861-06d2-b42922e44c7a@amd.com>
Date:   Thu, 14 Jun 2018 07:08:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyxHU_Xahwdf=0TYx8Nems78TLioLZGGLTkxNGCgxT4Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN6PR0102CA0020.prod.exchangelabs.com (2603:10b6:805:1::33)
 To MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a865697f-69e2-4790-4bda-08d5d1ef8be6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2460;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2460;3:FArAL6sj34pS05mAKN3F+PUbtNw/65Qlx8ODZImTc6lXpHqBRFPZRuFvsl9mwwLM/Li8Dsi5ujOag2mt1SJriwC6x0f9mIwLX4qBV9mhGOd/TaVLvx+YPI/kkLbJHG/Y6ClJySSdpKuEor4UC+x1HNvFyJiQGgOxeEj/fnfBfx2UxBgDppExhs3F5ztDtq23w7ZWCFpu9Rpl4ATFtyNKIDhxRFe/IJkWvjQa/hfMNJa6w2alOQrir3ZoIB4hM7bC;25:pdST8beStUMTPmZhtItW+70HAKQvECANiJiOf7/6LBcBfVVvPtZQW5KRhT2D8U4zA72R1QbDAmwjC/o2ndelHI4NWdCAUUXWmbsde4WeCNLDAJf+NjQHnxfAItsxAIh6XJlfdshPnhr2VBKWF3JYKFPzTTXleSAZP2EMkEcDbCTJ370PzeYTqr3dfGx+1Sp1HKGkZDlFXwabZSqFg/c6p8SAjhUUNY8MlFWu4UL67gVlje6RWRsGY85pvjfxTM4lrxxUMKLAxgf9h9el1yMknPmAv42DsSf7po+boCnrPYYg/hZBCCZBgJ1/mVRHxAWW+ziA8bn3GqDcpB/bWGOUfQ==;31:QOD+mpC32soFYggjFGEkIGmYcBvpXxKjGOuUxuNk9E749tD/3UFjunpi2dbCbG7fkR8Ia3M/IqGattIPO4Yqpw/JXD73/GdGtTlNinCPI4GMYNTIvbbeiQpo3c+urYcammgFZryQ3z7xjHkDiNNMR3BxVQbaj60FrY/2KNUHg3P+acyWgKxrZIkPQFZeHFAvTKptTU+fIQJorTzbCPoVZdUr2n8PGvV8meoqs/V5eLo=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2460:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2460;20:3rHuBqcXiHk7osq0GZ+OPCt3Q7JDT089TAAlVklZZHgi7Vb0EDtiFDbwNdD7JqPE1NAtuoriO1dTOdiyl/G4YU00oUTGvIQN+mu1aU88oHwJQVj8R+3vxsJd4YAruVDREIFIG+gAX+wAl3jAiA8Oh3alAqKvykmgHbzT+pN48u7CLYwJRUxfCgXpR2p7a3eeWZCjXtLmRaBPaaQAfFuWBaMZvcdJL8JNm9fHBWqZY+jFUKamiqfLkqls2qGRaAaeF2Hm0uw+ETZBklJJ+qTwXacepmy619gfLKeVt6ZaG0gRaiAgE26+OtzfZ617mr99C3lDbvfKLJPw4ppuXjB+LfhLTR2WIvLsK4xhq0EZwyhVyb/WhEdlkDX6eUCh6/ZaY7iBAMWkAJ4i+wSlCwp4dS7V1KSN2LH9geiljWTGuEGos0v0hQpct4iDjlgwcVnfEXysqwI6RZg0E9OShR3hLAIDyaHfXK3EtE1UqaLpVE4gemlLGUJZmwgcZUhW7HlW;4:qxwq54ULCOStSwJfBo6qq416eW1ZvpQJeVvWBYKczdDQ4J7Iz+SyKvlWG3HUjZR6NjDGI4hDmgliQ62mCgS5FB7xBuAMZXDcHlxw9fuxf3wl9Pv3DM0DBM/yGhqgyqnxy8s+csRG0unxEXpnWy+Krf9kzs+9LDEt1NMBXXIIRGOW9SQKUuGvyg6R/5zZbOTVJqh6kVNrhKTWCRakkcue193NtbfDipdmk5ZsSyAryuE9bMTaXAHhIYCTlxB3Z7UaLhU4nr11K2vy2C/n9xiHak07eWPW8NHDK/zcwHvvKEn5XC4sCUsYVyWAxHpikJugkB8sK5Petd5tXz38Gj9+JA==
X-Microsoft-Antispam-PRVS: <MW2PR12MB246019F81F2845DA0E617EE6E57D0@MW2PR12MB2460.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MW2PR12MB2460;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2460;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(54906003)(68736007)(39060400002)(66066001)(50466002)(8936002)(6246003)(229853002)(2870700001)(2906002)(110136005)(11346002)(2616005)(58126008)(65806001)(316002)(6512007)(5660300001)(16526019)(44832011)(81166006)(7416002)(47776003)(26005)(186003)(446003)(31696002)(86362001)(956004)(65826007)(81156014)(478600001)(3846002)(4326008)(53936002)(8676002)(65956001)(6116002)(64126003)(106356001)(36756003)(6666003)(53546011)(386003)(105586002)(97736004)(25786009)(31686004)(486006)(52146003)(6506007)(6486002)(23676004)(76176011)(59450400001)(2486003)(476003)(52116002)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2460;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNVzJQUjEyTUIyNDYwOzIzOk11a1pFSzllSDhHL1VkUXNwcENtY3B1SzRR?=
 =?utf-8?B?elhQTHlsOHVWSGRhTE1PMUlDRklYelFha0hIVVlaQWtkblBGcFdicGNmQnRl?=
 =?utf-8?B?ZzU0Q2NmSGhZVjhnN0NKYVNqNE95b0M2eE9nVXVXRk8zMFpQOWdqWHd1Mk5E?=
 =?utf-8?B?QTB2eitsVWFLSDVOMXNIVTBIYU15TmVwR3p1emM4L0Nyejg1MzFaQ2NXdi9E?=
 =?utf-8?B?ZVZVL1ZkbDBtamFXaTlacmY0NDZ1R1gyK0NpcHR2ZHk3SjVwY1BOQ1lCb0c3?=
 =?utf-8?B?Z254T3dVSVB1RHphNnJDNkRSMFpUdzZjNWxRbGkwS0wwRFMzU0RIaWgzWHdV?=
 =?utf-8?B?cGlETEhobllxelIxcVpsdjg4Z2lSUWxMd1NVVW9uNVE3MGlUNUpKNmswajZs?=
 =?utf-8?B?WDkva0tMRnlWekl4clZXRk96YkpLZFJGYWJoOFV6RFNqTjhMMmRzc2J4Wk9L?=
 =?utf-8?B?OW1KWDJVL1VSNm9RZGNaajlHS1ozRlZRWXA4OThNbUJiZ1FDck56Z29Qa2ll?=
 =?utf-8?B?a25IbW92Wjg3OEl0cnphYjB6Sk1kaUNaUEFKdVlrYnB3dnZXWWprMVVrRWlV?=
 =?utf-8?B?WUE3eTQ0M0EzWmpEOGlpNGxPOE53c29XbHFaUVdoYkRydmJxcFc2Ykl1M1dR?=
 =?utf-8?B?bjM1TFllSGtrOEN5eG5GcWJqSHJCVXQyVi90NlhXWThBQWhHb3Q3WExHczIv?=
 =?utf-8?B?dVNYOEdPS3Z5WXpnM1dvdDYzSUlRemxXbFRQb2lVZU5xOXcrcHpVMStsSG5D?=
 =?utf-8?B?UG1TcWtsN0I2Nm5qa0gyUWRkQ2RXUlRoRDdXODJNVEJXYVQwVlRGOTI1Z0hP?=
 =?utf-8?B?c1NUQ3NicUROaXNnSFQ2Vm52MXlkOHhSSXV0VklGdWNYRHk0NE9SeGRmRklJ?=
 =?utf-8?B?cU45SzlPYU5wTG9VN3RyT3pyNGxOUUxrMGxRTDg0N29EcGFxeE1lVU1FVHlu?=
 =?utf-8?B?bGpmVnpheGxNSjZMcnJwODZsaUNwMCtvRHJYWlJjSHA3TndDNmZCeHlmL2lz?=
 =?utf-8?B?ZGF3dVZaRDVTaG5VS3FrYmFqS0RSK2tWM29HVHdjRG93NzN1T2RrZC9ZSkdk?=
 =?utf-8?B?RW1maWx4MVdkS3BneUdtK2xyd05aZ1VKeVkxeXdLdXN0TUMvUE4vZ1BFZitK?=
 =?utf-8?B?Um5uMmt0V0JGVGNsUVJrQjRabDI0Wk8zREkzUGk4VTYyVzRSZFMxV0pKYko4?=
 =?utf-8?B?NzN6WVRpWFVoQTdadTFQYVh1WTUvUnVObmVEaFhIZFl3SGJQZUNPalN3OEE5?=
 =?utf-8?B?cnlZck9HQzVjNitIYzcrOWxzeWUrTTllNjljdFRxa2NVMGgxbDVvQnNxNllL?=
 =?utf-8?B?QzA5ak10YXhrdjlIWVJMVVBnZ2Q3RUliSStEc0xVNS9JSjUvdi9YZG95QkZx?=
 =?utf-8?B?a3VRZjltRUQ4VWQzVUo3eHhYWXExejkzSXA1dVJlbW8xbHVLcTBjamVRWUFt?=
 =?utf-8?B?MXR0Yzl2Y3lyVnpJUmlwZVlxY2svcUs2OVpHcElTUzg2ZjhWOGNXQlF3VTFi?=
 =?utf-8?B?R0JITHJvclIrdWdmcGVtK0ZYWmUvRnR2eWFlL3k4Q3NVNTl6RXE5QzBEQXZr?=
 =?utf-8?B?SnQxNDhHQXM0a0hlbGFxNVNzb2QvV21Uc1pOWkRPYVhPYWljM0cwOVRhVUF3?=
 =?utf-8?B?SHpLQjYwMGQxRCtMQnBJU2xzNHE3Tm9HeWIzTStHVzd3eE5iVzl3NE5waU5a?=
 =?utf-8?B?UGd3MTF0aysvdXd1QXRtTGxsMVJoVHBuZThEK2VDU2NZZGVTaDU0M1dqcjI2?=
 =?utf-8?B?SE5lOUtMdFEwclNIL0FOOVJkUzVRYTJ4YUxPcEdJLzVwdFNIZlI0amVmK0p0?=
 =?utf-8?B?OGorNlY5ZXYwaFNxZm1HQU1lbGZlUGdybUgwT1QwV0dCc2h5WWs1cDdFdDFX?=
 =?utf-8?B?Uzcxdk1hd3N6VG1FV1lBTFVEdDdhMUIwdkNxNnZuOXM2NWN6TTZmWUtId01s?=
 =?utf-8?B?anNXK2JqZi83WnRvM0dXUG9hMDViVUliQlhUV2pqaEkvOVJPRUNpbWJ3a1Vn?=
 =?utf-8?B?eVVnL1hUdzNtOXVqVnpYK3ptcmlGbEdtSFVpWDhQUlRvQU1VUGE2elFqNzlx?=
 =?utf-8?Q?ELxs=3D?=
X-Microsoft-Antispam-Message-Info: DN7RHIMfD54mtnxNvioravf5AJ2Wc7rTHmi3+2RhIbSwAHc1pX7dbZOEPdrbYo+XbTFrpYkMRXTp2uqQvEwGHZK5xusTjNCFZeRA3LO/8w7HwJIXUKdxmqFOUH5wfJCQHXhH/zBES9yIzBMTr/SXI30kbRzS72p1/mEkgF5UWO9UCYsn7ngeTgi/1HxOsEL7
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2460;6:RiNUqkPaT5kShLE4ed0uB0bL4kC/eIaO5P6r85dgHBJDXsHX7FQ+tfaPZOFYVjD3wJVIqm//2ifhMfjDeD761Ebu35AM2zbonkUntKTxgCcNA8/SsKcPnDmJR45Gbfho57n9fGeCt1KRh8Lx1/nWlglTmT4n1aPvCw4OyTiM6pI0CD6AZhQE4zibTU68PmnWxG+E8v3ojf1xA1LLmyQ/eIPt9HUrugchnPb9FRJhXcsn4VNLwOpvH24GGAk2I+dVkw5Lmw/Vfy6bdFW2bit9rT7sHuqsTiw95XgRV6uOK4fFJmaZlsU9Cj+la14doXcd74oRsM+1xjTlNyj/imLmOtKlpY0DzQDrGeeZ5/AbF6ycpSuPEV0YB7/QsZ+/ly3O4ohXfR4C2BVGwIM3xWrE2mA+3DEJ5xkX7THv0xCLWP+Lc3PD7YoPqvF/HUS+/8M4BegiH2E5bF/MDFi/qg+crg==;5:nzyJ2hL5iTsLB3dNoA0eAw9VoOW4otQKgQXkf4YL4iLBA87UxRa8FZCVRv+T3mYhxbCgQ2ION7Up3n/RZxrlJKatJK/WVYevarw8viSCESbxBFlRkTuBPgH4GN73rENwI5ur5noCeXq6VsgWJNylqxlLxh+xHXo/f0SCFdaItZw=;24:UqBUTZrERrbOC7MGq66atip3ESlWTbi4NWisf4nI0a+VpgK8MaBDH1BPM9f9c+M5xydw3zJP69zVuFamlAaxkOxrUaEQlnJ0QbzWF+go2mE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2460;7:iZ3BxPwDLKSnQFmIt8T4ew01EM8LI76v3jYvFm2UMnvgYo3XzV3glOBFloWBM7iascR2n3UFXHfk0TvTHhPf+wkOUYqdbFD3/FGuXAEgzqBRhActhkmo0HRMc7gvDKT11pKttkkgi1CZTjyYleR01sJep9lOf8qVPUL4bgY0z6nBlANthzuiUCpXbaOKc08u/2Wg0VYxp1NbRnbGyTlPmt5LQsuQHKKuFr7qEKwz6QZTZuKdeq8CYc8uTOpqdEZX;20:wmGZ2k1H1DckE2JLcENCgXB9O/UYrHP/QD3kU1ElnHYOq9LUGdxvyyV1vMorEyBFpU54jz4mkEdYeYAM8NK1YVoRjTshPNWJhWl3SfJNNIxpyAFcPSZiKod/l3ZE0WHI4qIm6T8Am0rOABUunZYinh+sy7kK7Vz/2h04eZwON4gftLEufrYfOT5lSHUKJiih3Glh5jsZo6G6RgxOn7ZmcBTGDzAAnePEu2y6+SqK9pwMWqIOM4X/yBKHxYSur2ZI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 12:08:30.4348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a865697f-69e2-4790-4bda-08d5d1ef8be6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/18 2:58 AM, Richard Weinberger wrote:
> On Wed, May 23, 2018 at 4:46 PM, Borislav Petkov <bp@suse.de> wrote:
>> + Tom and Brijesh.
>>
>> On Mon, May 21, 2018 at 10:12:53AM -0500, Janakarajan Natarajan wrote:
>>> Use Kconfig imply 'option' when specifying SEV CRYPTO dependencies.
>>>
>>> Example configuration:
>>> .
>>> .
>>> CONFIG_CRYPTO_DEV_CCP=y
>>> CONFIG_CRYPTO_DEV_CCP_DD=m
>>> CONFIG_CRYPTO_DEV_SP_CCP=y
>>> CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
>>> CONFIG_CRYPTO_DEV_SP_PSP=y
>>> .
>>> .
>>> CONFIG_KVM_AMD=y
>>> CONFIG_KVM_AMD_SEV=y
>>> .
>>> .
>>>
>>> When the CRYPTO_DEV_SP_DD is m, KVM_AMD set to y produces compile time
>>> errors.
>>>
>>> Since KVM_AMD_SEV depends on KVM_AMD and CRYPTO_DEV_CCP_DD, the
>>> issue can be prevented by using 'imply' Kconfig option when specifying
>>> the CRYPTO dependencies.
>>>
>>> Fixes: 505c9e94d832 ("KVM: x86: prefer "depends on" to "select" for SEV")
>>>
>>> Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
>>> ---
>>>  arch/x86/kvm/Kconfig | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
>>> index 92fd433..d9b16b7 100644
>>> --- a/arch/x86/kvm/Kconfig
>>> +++ b/arch/x86/kvm/Kconfig
>>> @@ -85,7 +85,9 @@ config KVM_AMD_SEV
>>>       def_bool y
>>>       bool "AMD Secure Encrypted Virtualization (SEV) support"
>>>       depends on KVM_AMD && X86_64
>>> -     depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_SP_PSP
>>> +     imply CRYPTO_DEV_CCP
>>> +     imply CRYPTO_DEV_CCP_DD
>>> +     imply CRYPTO_DEV_SP_PSP
>>>       ---help---
>>>       Provides support for launching Encrypted VMs on AMD processors.
>> Well, this solves the build issue but I just created a config:
>>
>> $ grep -E "(KVM|PSP)" .config | grep -v '#'
>> CONFIG_HAVE_KVM=y
>> CONFIG_HAVE_KVM_IRQCHIP=y
>> CONFIG_HAVE_KVM_IRQFD=y
>> CONFIG_HAVE_KVM_IRQ_ROUTING=y
>> CONFIG_HAVE_KVM_EVENTFD=y
>> CONFIG_KVM_MMIO=y
>> CONFIG_KVM_ASYNC_PF=y
>> CONFIG_HAVE_KVM_MSI=y
>> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
>> CONFIG_KVM_VFIO=y
>> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
>> CONFIG_KVM_COMPAT=y
>> CONFIG_HAVE_KVM_IRQ_BYPASS=y
>> CONFIG_KVM=y
>> CONFIG_KVM_AMD=m
>>
>> which builds but the PSP functionality is not there. And I don't think
>> this is serving the user: she should be able to select what she wants
>> and get the required functionality added and not have build errors with
>> any possible configuration.

Yes, I agree.

>>
>> Now, looking at the security processor Kconfig stuff, it is somewhat
>> confusing but maybe I didn't look at it long enough. A couple of points:
>>
>> config CRYPTO_DEV_CCP_DD
>>         tristate "Secure Processor device driver"
>>
>> If this is going to be the top-level menu item for the SP, call that
>>
>>  CRYPTO_DEV_SP
>>
>> to mean, this is the security processor. CCP_DD is confusing because you
>> have CRYPTO_DEV_SP_CCP which is the crypto coprocessor support.

IIRC, the patch series which added this support started with naming it
to CRYPTO_DEV_SP but somewhere during review process we discussed that
since the module name is ccp.ko hence we kept the config with same name.
We can submit a follow-up patch to correct it to avoid any further
confusion.


>> And "DD" for device driver is a pure tautology - most of the Kconfig
>> items are device drivers :)
>>
>> Then,
>>
>>  config KVM_AMD_SEV
>>         def_bool y
>>         bool "AMD Secure Encrypted Virtualization (SEV) support"
>>         depends on KVM_AMD && X86_64
>>         depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_SP_PSP
>>
>> that last line is pulling the required functionality for SEV but - and
>> I *think* we have talked about this before - having a hierarchical
>> dependency should make this a lot clearer and fix the build issues along
>> the way.

The first set of SEV patches accepted in upstream was using select
instead of depends on. I used select mainly to ensure that all the
drivers needed to run SEV is either builtin or module.  A follow up
patch was submitted by Paolo to use 'depends on' so that we don't create
a circular dependency - I agree with that patch.

>> Because, IMHO, KVM_AMD_SEV should depend only on CRYPTO_DEV_SP_PSP -
>> i.e., the PSP device because SEV needs the PSP, right?

I think depends should look like this:

config KVM_AMD_SEV
    def_bool y
    bool "AMD Secure Encrypted Virtualization (SEV) support"
    depends KVM_AMD && X86_64
    depends CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)


Like you said,  the KVM_AMD_SEV should depends only on
"CRYPTO_DEV_SP_PSP".  But when SEV support is enabled in KVM, we need a
CCP driver at the runtime, hence we should ensure that if user selects
KVM_AMD=y then CCP driver is also builtin otherwise she will not get SEV
feature.


>> Now, the PSP device *itself* should depend on whatever it needs to
>> function properly, CRYPTO_DEV_CCP_DD I guess.
>>
>> But SEV should not depend on CRYPTO_DEV_CCP - which is the top-level
>> Kconfig item - that should be expressed implicitly through the
>> dependency chain where PSP ends up depending on it.
>>
>> So that you have one-hop deps:
>>
>> KVM_SEV -> PSP -> CCP -> ...
>>
>> IOW, a config item, say PSP - if enabled - should make sure it
>> selects/depends on everything it needs to function. The upper level
>> item KVM_SEV - which selects/depends on that config item shouldn't
>> be responsible for making sure the correct items for PSP's proper
>> functioning are enabled - that's PSP's item's job.
>>
>> Makes sense?
>>
>> Maybe I'm missing something but applying this simple logic would prevent
>> such Kconfig build issues and make the whole dependency chain almost
>> trivial.
>>
>> Thx.
> *kind ping*

Thanks for ping, sorry I was meaning to reply to this it but somehow got
dropped. Can you please try above recommendation and see if its builds
and runs?


> Felix just reported me that build failure too.
>

