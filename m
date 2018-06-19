Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA036C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE3C20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rrIHRHH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE3C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030413AbeFSTXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:23:03 -0400
Received: from mail-bl2nam02on0062.outbound.protection.outlook.com ([104.47.38.62]:36800
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966263AbeFSTXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkDP48xIY7JkwspRjcYGfsD3HLmkKtHVJGjqmbtURUk=;
 b=rrIHRHH2Aj6992DAFXweoskQCe45oRtMJKCYV9d5XHkEFiX5OPWIsp2GFDI1yLv0DZXkiT8MHxqHXp8P9OKUzFe6JzltjCqpcOQnDiS4Q6hCkFEOutFY59OzDdEx5YF5Bs87KJ0DC32+A0kY2GukLQAUVMGu8cIEoKP7DFGCuF8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 DM5PR12MB2456.namprd12.prod.outlook.com (2603:10b6:4:b4::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Tue, 19 Jun 2018 19:22:57 +0000
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
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <3953c12f-c2fe-5d1d-bee2-ac9a230300b8@amd.com>
Date:   Tue, 19 Jun 2018 14:22:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619094658.GB31750@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:805:a2::34) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b04427c0-186f-4915-9845-08d5d61a10f8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2456;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2456;3:BfGytDiuSAz18tOX6bYa/FWJS6yZc/IBfqDeM24X3ZIABQeQ0//ObZz/2tns9U+284eEy6eOAHtg/DqYvNo+F70W/RmsY3Mg1tcJAspqFCf9LqAIi1/EYvpM2XK4ECm/4SOyT+kVyUONpuuKwOx90HtlQdwezJfRg7X5qjEtg7/QItuOOZzsvFSC/nXdboice/yswElRSYAHZ55HnwuW8RdftfuBbE/GZ8OR8sZ6v4+h3d2bVb4WMn/2Iwci+4Tj;25:tXlV5l5BzL8ra9YsMpZTop0VlHllVXP8C0iGKCpN1vNhn3SCGJYUeWWyvFhJyTse0iqpIPzxgTeqy3na4r3AmoRRQEgTE2c43HQE/LXdxQlAerpAwy1KXHBRwv6rHP3UuiDj3+QRe4Jho9lspMdIgc7H5NYIuSfG39clOfN8iuBiv8PqKcyZGugK6gA8zDsDOSmz98pJoEtBWj17yOihD/KKaAn5KYcY+KvfiwOne1bT9ZHAGSa5PTFsO7vlrP0G/pcQFafLJi3fOJ6S8WqefMRQILdxJmqMf9FoqSfQv4nuzeFPMRfoFrCZiOMztb42rgaTPiwfDWJJWcb292GG6w==;31:Oy7fx4vtjgjy7tUJwCFPPNocrdxI7LhNo/p4QVdL9TJIgt/qbF45S1RHW5uF2Ai39QDTlt+pqGvNgKH06j+7EUw94QVVswDdmBKRKGThE//zeM0gyv6KFHUbu6HMlstLnxzSoY+7nJgDqTPVgW8KFJa68Nzx0f2/Btd4WRCmKy+oJg0KZZLYn5KL4vsCUNsmsqgK3i9e4wHkkj2BYiwoe7HwdHS+lEdMLdnXKEz19IU=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2456:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2456;20:x07vDUHCfKjFLmWIyhGhtI1s9XsUFq+Eqsshx29+oELVtxL4Xhxw2yIxhT+Wqr+E80vJY3V3A0Wbq6Dj2ocdxMyYnAHrHLHV0NqAbJD7joKAi2WbHiOAiHklnQQsro32Wu8nBmVTxcA/gS0JTYCiQqHz2+u4SQoiZtpKIrEUDFZLP4O9eOeMzg5vk6WnZgQButf8+JF4bNgBUts3DU2snaj2ouVqUaeUXHS/yffgcVtLr6vp4NbeJ0QD0tVO5xX1HK+QmHBZE1HQ616tEzZpX0+Q+AzBkh3B2Iwb9aYIbwa1FPFFgI2V5ORaKdFnDV2lrhoAXqPzDYq4mi+giZL/D7SJWsGpPEL4E9IpB95YSySvGS2fgVk/FkXJBmJn1sFul8ZOUl+ad5BMt4x1Zqe2/vhkruD6q3DNDF9qZKpIDu9MpR/uY2kW33MSA6F0nDvpqkuNLcBIrNABL3baZLskr8dIQHjzYJshK9fWp9/x17pR7E+shr1Hgk5WZlpFihNf;4:Ijhcvc/XDCioasmXOBN1320jLuBZ9MGH9JPoh+aKneIyz8w0T1y980wwntekIuDyH4Qhp6kIdSmipjnUKd2+s9FAJ+QLxQV0Ft20XaalSY3sMG/8CkhiMrj6cN1xLze59TYjnH6mAm3Lxi7CHiYA0t+V+Q2/qNs3zbQkTvkxuKtLLtUAuxSyE8Xe1tRbhpvFB/yy546XHlCp4Zca3Awe6FJHI4FUn1YSOL0G258bmdHi2ItRC8Sk3cHfS0+719Mhj4FDt8WfSWngsWg2zfBRUQ==
X-Microsoft-Antispam-PRVS: <DM5PR12MB2456687FDE040F072071792AE5700@DM5PR12MB2456.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB2456;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2456;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(97736004)(39060400002)(6116002)(3846002)(86362001)(53936002)(8676002)(386003)(53546011)(81166006)(77096007)(26005)(8936002)(478600001)(81156014)(186003)(4326008)(105586002)(305945005)(16526019)(31696002)(6246003)(106356001)(2906002)(54906003)(16576012)(67846002)(7736002)(229853002)(65806001)(6486002)(316002)(58126008)(2616005)(50466002)(11346002)(23676004)(31686004)(476003)(47776003)(66066001)(64126003)(65956001)(5660300001)(446003)(486006)(76176011)(36756003)(44832011)(6666003)(2486003)(52116002)(52146003)(6916009)(956004)(7416002)(25786009)(2870700001)(68736007)(65826007)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2456;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIyNDU2OzIzOlk4ZFYxd1pEOVFqWlQzclVFQUlGTmJoWkJM?=
 =?utf-8?B?ak1XWVNVQ3I3RHNwV0ZicU53TmpCM3o4Z2NkVGhEeEgxWmlQdXgyTmw1TGcv?=
 =?utf-8?B?b2RrU3JzZEN6YmJDcEhXc29xTnpmeGozT0tHakNrZHE2SnE4Ly93dWVkNnVY?=
 =?utf-8?B?K1VueEE5T3ZsRElsZlUvSE5WNXVLV0l3SE82eXB6czgxbkJRbnh4M3dSY1hm?=
 =?utf-8?B?Ti9BbGtGMktmL1RaOXlkbFdLNFBqb1AxcGgvdS85VUxVQzVReXhOTzJWYWhz?=
 =?utf-8?B?QlR4T3hnb1prRjFuQUxqUVFoTTZDUjJCeHdjdUk0endBYkMzNVd6K2E5MFpY?=
 =?utf-8?B?cjZaNnVNaFl0akNvVFhKNnBYSFhEc01nTW5PR0FFcEJMYzNBZGJPNVQ1OHhX?=
 =?utf-8?B?RW9jMEpWY2lkY2ZWWVFoYzRWak5GL1dDWnQ5ZmNQQ01HVmIxTm1vbnNBeUJX?=
 =?utf-8?B?ZlZ5b3ZsOWpNYnJPMDZhdGNvdkJ6Qmx2VGRzL3orMUZPejVPeVFzUG1ZWkpS?=
 =?utf-8?B?RHZFYzY3YWdwNkgvU3FVeGpKUWRTL1JIMGZtYVR3RHdNMGppR2gvMFB3UTRY?=
 =?utf-8?B?YTFuZWJWb3BVTmR1Y3Bzc2U0dzduRlluN0lhbEVNSGJuVnZlVytWQjdneTkz?=
 =?utf-8?B?Y2pKMXYvb3ZNSHk2a2JxdEJLS1ZVaDEzY0Rkd1BWc2lVTi9BeVZwRDFzNTB0?=
 =?utf-8?B?dU40bkFRV1FyYjhqdVAvMFVobnZ0OU01cFBlZjNEQk1XRGpWOHBmdDBFdVRm?=
 =?utf-8?B?NVNFV0luWjh4WG55QTFkMkRzNG9mTGFqWDkrZHBPcGRWNGRjWmtZVUdoeDVa?=
 =?utf-8?B?d1U0V2xyTlcwMFNqcjlqbTFld3ZDdGRLSG9qSFdPcnh6NHFUcXJhUW9XTGQw?=
 =?utf-8?B?aEliY3YyS1FUYjEyME5CZ1pnTmtGc1RSYVY0Z0VDSm1KdE82R3hnMnZKRFZp?=
 =?utf-8?B?ZUZ0Y2FTYkNDYlFaTWFmTHJJdzNhWjZ3WUd3cFJyMTRDWFlBVDdidnNobFhz?=
 =?utf-8?B?czlHdU9EQmk3ME5PbzNpcVhSUUVsWXlLQXhnVFoyb2ErdXVxRXZwRUdkSUJz?=
 =?utf-8?B?MlZlVTRJcGQrUU9mTmIwVDk4TTVOQUNESmh0MXkzblhjNjY3QWZjTG5WNHV6?=
 =?utf-8?B?VENqcTYrcjdsa3pVU1RPVHF0K1pPMEp3YmlaU3dRYW0rTi9QbUhLZFR6MGNH?=
 =?utf-8?B?V0o2bGpSL2dyK0UrQlJoNnF5SDJyZXR3M2RxMG9WVzBXTWU2a3J3dHp6dXdL?=
 =?utf-8?B?dTlHZjN2eFRBbW9qNHFKckxBSVpGOTNwcDI5emFKUUVBTGJCbUl3UE5BaWwz?=
 =?utf-8?B?ZWpYeStKR0lRSkhhR2puVW1haVFkbGRIeWxKNkZ2V3Fmc3RSd0UwNTJtcm9L?=
 =?utf-8?B?UU1FUksySXVreHE0SDdPNUpldURqRmh1cHhQdHVQZVU1MlFEWmZ1azdxV1VM?=
 =?utf-8?B?QXUzaUhCV0ptL2k5aW9vaHp4ekhxK1J3VElqbHRrbzR3d2d2bXkrWDRDQWQw?=
 =?utf-8?B?QlcvSDJFTkIzMEFCVVJHZnNCYnRsUy82a2JoZHladUJJWVFFQ2FlaEM4VHZs?=
 =?utf-8?B?Q2dUb0tHMlNTRGpGTTU0QTRIRnd6Z1lJVWRFL0tQcS9TVUMrclFBVkJIVWZS?=
 =?utf-8?B?bTdQVEp2WjFGa3pUS3VIbUxiT0QwRCttdXZLUW15aThsL3U4RS82d2N6TjVl?=
 =?utf-8?B?VForUnZPVnk2R1laZGlEZWhXelNOZ3JiKzl2clllUVIra1VQeFloQXNEdFFW?=
 =?utf-8?B?cTgxS0xiSHVod1BoUllPNFE4ZHpibURYK2FyMWJvd1IzdjVtWHJEMThJM0kx?=
 =?utf-8?B?MVMwZUV4QVY2ZW9nNm44dTRGQjl3dnVwUFJVSDZycUdrNnFmbGhyVVJLcnhm?=
 =?utf-8?B?dWgrTDByeS9VMWNsSWpFaTBiQlFvVHFhczhIU21FaituekxQSG54SmFNeVpD?=
 =?utf-8?B?ellxbXFRZWR3eFQ5Yjk0ZjlybWd2RGsyQVdDY3NBNjJzTFp3Vm5TTklIZ2Ni?=
 =?utf-8?B?dFNEZURuczh2MXVDeGRvckswdjI2eFlQdlBvN0F5REFQYUZNVWllbURNVFZv?=
 =?utf-8?B?cVhBZStEY2FYRHZqcEZ2K291bHdaUDgyblFSTklZM0tQSWpCNVAweloxVkVz?=
 =?utf-8?B?MVE9PQ==?=
X-Microsoft-Antispam-Message-Info: dDu0cDaAuuaRSoJex89lmRoWV4Mqq2agpQ/kniI0MuHviLkj9cTuhRFGeW/KqeMr9wWrILU20ly1xzkJmoDtPJTZosDi+BIvncet9XXFTboLftX7w/6otka0qWDd4MgQegc10mxzy2FrPF2HjpOx2vyO5/K3sPOdWwnRpmpZYr2TD/UMUJd7EmZDt1cpeZIRsQ57CXkRKi8EBls3pajCulB0QtvoVgZmEA+BCn/CGAmhSwQX7OPCEvTXAsOxRK6DPK5bKiS4OUX86oprD197sdRAS2LYlkE3mf9HD/1ZEf6utLhRyrOC1Y1Oc6HM0J/Z
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2456;6:tUI0wrXV3eOaAp0SKUk9HaguDnZFgFAoE6GuTBW67mH9qzz8OwLqX5TmWX3NTcwSq2wCO2Mzsnufg/bWaUfcofIUtWXDaIuc6wolw/04axUE2ekAATYj/ciOpiiSWVkPOPvOOiVSdw5+BtT+U9Wv7DFZSOT8oAO0NARJ0KDkFXFBou8ggAXQqX9e3euIZY8iLkLDne8a2bb0ZHu04B5k4mucWYK1LPFaUzGDL+bCon0MHpYRdAi6tXWLFgcYzL3bc0FZeAVy9pB62OcYCwl0e7Ymtn9Wklpk/VOECXHK0zEwIxVwiHdCoLgPHDfmNP59c69vDMbxFyY+Q6M538qQMwQBdnPz8pahn82eEzSzu1cDnpUFl6OMAPPpN9BnSElgnRYKk06ki4I51hs0eAyR8AFquSb1dB6RNwf1VDWkjTEZKnflNM6qZ14QrODnx1RuXttZEriobHVfRcM6Q4JLBw==;5:HbT4bQOh419OE+eoaRc8BrzX0RtwrsNPSsrc/rcBJRfC4GhsD5pmEVv3l3fAOhnwSUWlSp4n3hI358E7mb9Jk8W2Egp58nB37Apyrjti8Y48gxPcuP5+gTjdPJnwB0vX0OBnqozjGCGB02Z02RwFLvGmdSsi5AxiAW/4C256crQ=;24:o5LNH5OUEWHWKK3yLrAh8ezqo3oNz6NRWqYmnp9RUOVYfdt3IEednXmDQBTKITEXIk96Q87Eaxi4HvhBry48TZufw4C/JCxE2OKPXq4CDr0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2456;7:/+1l28dnb8m4rcoX5QULy228DPkCFTcjCGjFXSEs6wVmVdHr/JT3Fzd4OwdaRezpz+wBcp4S/9NeQiq2mFZhNzKKzlq/qCwwYTa8QrJLqdeRrKsO4uaj8XsehFqgegmF6HS3PqluyE+li6wQSa3JUUP370TKYV+9mSYFkhNlHtv9f4sUjb0j3NuzzRzY02K+h8+7g2q0vKSj9cpjamMYdFT5JpENkxvqo8Mno+G1yoDL2fqolalikWgTZeRiFquL;20:RU9uQGnG6cZfTNAgajfFEnpjMvgF7twngyL/eGaZmpSAGZFbtOjBBuyz/mWCrWetzgzvDyolnY4k+fm4FZ9Q1Gty2LXBN5nszYUzUfsWEPvCEWYcVsllB2b0m2d4dTXS9WwiXWm3BOeoQbzSVPhLOCfyAhs8kQ7x2QsL7bhr9NDpdvEyrvsujJBKcdNBSE6+QBrP51UfwFzeP144kbC+AXGm94uPjvpiCsgKjRr28ZAwzgQTVtXsf5ct0CAjs+51
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 19:22:57.2755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04427c0-186f-4915-9845-08d5d61a10f8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 06/19/2018 04:46 AM, Borislav Petkov wrote:
> On Thu, Jun 14, 2018 at 07:08:26AM -0500, Brijesh Singh wrote:
>> I think depends should look like this:
>>
>> config KVM_AMD_SEV
>>      def_bool y
>>      bool "AMD Secure Encrypted Virtualization (SEV) support"
>>      depends KVM_AMD && X86_64
>>      depends CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
> 
> CRYPTO_DEV_CCP_DD - this still doesn't belong here. KVM_AMD_SEV doesn't
> care about what kind of functionality the PSP needs to function and
> select it - it should only depend on a single symbol.
> 


It would be nice to have a single depends. But the main issue is, PSP 
support is provided through the ccp driver (aka CRYPTO_DEV_CCP_DD). 
Hence KVM_AMD_SEV need to have some level of dependency with ccp driver. 
This is to ensure that the ccp was 'y' when kvm-amd=y for SEV to work.


> Now, you can add a separate CRYPTO .config item which collects all
> required functionality for SEV guests and have KVM_AMD_SEV depend
> on that. Or a similar solution. But not have KVM_AMD_SEV poke into
> CRYPTO...PSP dependencies because it doesn't need to know about it.
> 


I am sorry but I am not able to follow you on how creating a separate 
CRYPTO .config item will solve this problem. Creating a separate config 
will be useful if we are okay with calling 'select' from kvm (i.e if 
kvm-amd is 'y' then all the symbols from crypto will be 'y').

I looked at other drivers where they have similar situation and it seems 
like solution is same as what I have used above.


-Brijesh
