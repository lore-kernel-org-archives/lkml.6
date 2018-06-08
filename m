Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ICrjGNknGlsDEQAAmS7hNA
	; Fri, 08 Jun 2018 06:53:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3E489607E4; Fri,  8 Jun 2018 06:53:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bkWVD1BH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9EA266074D;
	Fri,  8 Jun 2018 06:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9EA266074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeFHGxK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:53:10 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:49408
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751181AbeFHGxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzi8YXCE7Viu6f54Aar7zdMvWctZ7LXSVyxXbX/vvz0=;
 b=bkWVD1BHQhU+M4A/bg4BZhwWrwHysCrZkdtJKP248MOyMGckRIR+NauCD6EH8bXhqbUZoP3TbNciaSHNZn0bJqOAjo4vg9FMGi56JcUK8CKY8BCYr3VARXlwpBnH7gmzR7JZn0LruHq8K9v9GlBmlU0c6XIUIckSyqCJt/1k8+U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 MWHPR12MB1727.namprd12.prod.outlook.com (2603:10b6:300:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.15; Fri, 8 Jun
 2018 06:53:03 +0000
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: Christoph Hellwig <hch@lst.de>, Gabriel C <nix.or.die@gmail.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Joerg Roedel <jroedel@suse.de>, alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com>
 <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
 <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net>
 <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com>
 <267c42ce-91e2-4843-3815-904ac74b2f44@amd.com>
 <CAEJqkggsjnod79HFvYQHRFEsFaN-bb27P8Xf79_9DmxhLKs_Og@mail.gmail.com>
 <20180608060223.GB24107@lst.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1c8b3938-6656-5d5a-f65d-dfd2e55d989e@amd.com>
Date: Fri, 8 Jun 2018 08:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608060223.GB24107@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::21) To MWHPR12MB1727.namprd12.prod.outlook.com
 (2603:10b6:300:112::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1727;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;3:5a6nhgXWSAZCKFj6UkLCEsXbm6ieKynVG3oijA+kuFst8ZTqqbAaMgFNklwFn3e116Kf7IMsUhWmZjpXmPETSNaxHs5uDPvYmTkayVdTcKX8kbVNMHbkYH3+koDDLFCUss3P1AnztsO+L+lxrArxmm+z/YTSOBswAdkCixMKop9Cy7e8Qbe3BcgvhVoWMWU1h5bdqLhO6aboahrssShLbQS32P6W4Ji+lCJxkxSaoRPEbdFMvn6af1aNDgy6oH0W;25:VENsnFuPI07iPVJs5u1zHFkXs9JwST2T+yphCiOci+BLWOHdzuHQwZuBb+IP6a2LRs/JU74RhCWWW3GOZJUTrMwx5Qsr6rxmTgTgSJT6d+pFInA74lLnQxtZO64blzLs6uvtKFu4lu8jpkrTTb7rpif9IN21NDhfY33mVKrq8x9RxJnWlDFQyI+jbhnZhMvUxZjGDsEBMXAyQw1EuNI17LEd1L+GHlTN/fJ6XgFrSyX2W+Vmobj9DEU8CMZ35SEOCa9ASYoIDeJ27gqRBG+fcSzfZUc3jm8J/m02c7YXSroh7M+yKk580WbHpOQaaSfwLfHzvTGxINIGPNNKv/nLsw==;31:o+Gb9+ok3WxDGvFYteJE/6x1xtrT1+vnKnEMjppgs2YBO3wWiXiX28pTDNbUoSIdkC0MCVQBbez/VujAZGPz1dzgVOcPGovA7oqseFZSMF0xIEb5aMoHXdeXfEkP1dYtOcfG49ltgF3cbMRvALOFU1XsuDnLjxGcG26F0TfoXyG0pVIjf0l2Rxe+rdBtS8fuPmaReps2H+cX+L/YABbmGJEqgc7bK6pwwCcNYaGyv/M=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1727:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;20:juGBxZrrk7n1LzUG2OkP9EQFjZHTNKiGVZg4cgSUHfDSs0S7m4w92PsbDhvNPwP70soxejNip843CmlEcBUC42PKuTNqBkvrXFblZ9GPxDSZx8TFSoIZGlGxqMFMlIs1yduef/L78OsgUxC+QOl80P5DynlreMki/PzpzMHf5QRKWQg1sPw1juyFbNfe7d0ncR81dOSrVRjSyj+aq8R4OxrQFj3BvbO7XslrbaOgHkGVoQnq90Aip9jRH0YZegw5ReF8d38oAkZKPVMLS7fKSYcPcw4CDxnNewVb8e3tmLhE+1CfASkL1SRozo8BR2dYcU/rP9va7AwIZwLc6ydabqzjV6NNhY6tEF/kV6glz1nJMrQ8hjCsCFjaFY+quQFDv8ryubZLdPwOi1SQW8+6wGADksD4/bd3y20ffJquUR1NAJBXaLhrNLH5taRWvEfMVhT3oWQv2xUIr2sAnarsrP9DGEZPove0oAjCB8ZWdjc8MdmjQwCgjFd6NfGKoITr;4:mRf3Hr9Bm7tWlYFVWKwckTC0eMr+6thepIHjy+1YQYy3Hj+S9yWPq9gfy54hFEyejeHDPdl7hr5P/k41K0AbrUzgsV8nKox9Jn6ZwL5S/2bcQ4KrAAxPDKSB/8MzZGpksY8v9zvMm5HEQWS/Unfn26SQYxsUtXJnbTyUKIujCnv8fr3j/ZmuwJL3Fo5haQX3xdXrSa+D7g1Fvcjm2B4RrUas3dbOzpsZ5pszEyFO4zAlPpv7Aw4V2UIUYn1LCHj8TTagHEmccMALogs/fKbhJQ==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1727A838C25D53E81B520067837B0@MWHPR12MB1727.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR12MB1727;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1727;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(46003)(7736002)(53936002)(229853002)(31686004)(486006)(478600001)(36756003)(8676002)(64126003)(476003)(446003)(2616005)(72206003)(186003)(6246003)(81166006)(81156014)(86362001)(16526019)(31696002)(386003)(47776003)(59450400001)(11346002)(68736007)(2486003)(65806001)(6116002)(65956001)(52146003)(54906003)(5660300001)(65826007)(50466002)(8936002)(52396003)(52116002)(23676004)(1706002)(316002)(97736004)(106356001)(4326008)(7416002)(105586002)(305945005)(6486002)(2906002)(58126008)(110136005)(25786009)(76176011)(39060400002)(67846002)(93886005)(230700001)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1727;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI3OzIzOi90cXNxdWIvVTVlSzdtVFQwd3NHSVo1V1pL?=
 =?utf-8?B?WktXQVFIODFqcCthbkxYUE9RNmxjcFBhU1FWS09EWExidUFQVXhVM0J0cFZZ?=
 =?utf-8?B?RnRZN3JpY2xYcGMvUCsyRVJLSG1vNjV1SmxXVmVRRk5lYS96Z2wzU2xzaFNP?=
 =?utf-8?B?TkFESHFWckZvaGxiUnhxbEpYdk04Z3RRK01LTzF1b1lMWFkyYkp1eFFWU0Ix?=
 =?utf-8?B?SzUzbkt0bWZyN3Q1MlIzQ1BKK0h5MThkSkFKWGM5WEV3dlZ1MCttd1l0MDN2?=
 =?utf-8?B?V1loVXdBZkZxbUsxdk9nVjZGaEFHOFV4QkF1RUdsaG9pRGlsa2RFOFpvVWQy?=
 =?utf-8?B?NGpmMEJWYWw2bUFRV25ySFg3SmNyamVRck9pemJUT2FQbnowWkRGODdQQ3Vy?=
 =?utf-8?B?dThDMXJUekU5TlNqVlZxY3I4dng3cnl1ZUdWM2YvaGZHaGpkckNaVGErb2hR?=
 =?utf-8?B?UjVxOENtMzhLczZmb3JWdnVIMVFueSt2YXpzV1NvQUdkZWVQMndvdDhhUW5W?=
 =?utf-8?B?VHU3aHJRRURVSkpUSFVUUGVlRjFKQVl5dUNwUTdRa2tMcmIwYjJIeW9teTRB?=
 =?utf-8?B?SHNGUnJRYzcvUFZxOG1LT0s4RXNYTk1SSVNQUG41ejUrL2p3K2MyemFNVS8x?=
 =?utf-8?B?ZG1Nc3BGUFp6M2NweHF1NDl3K1hKclp0SklCODJ4eXVNVS9Jd2ZyU2tRMmVM?=
 =?utf-8?B?NkVQcVJYK05iWllRelgxdm1zbERaMnJ5WGhIZFBCVVNVaFdRME9tcGlkZDdW?=
 =?utf-8?B?QmRqVHNINTV1QkhERkVkRjg5c3RlQW16d1EzWG0vaFVaOVdXRWxQRTFSS05x?=
 =?utf-8?B?bUF2WVdoOXNXRDhzY0hhWE4xcGdRVWFKUjYwVWJhME1lZ0t4VFpTbnVMMERr?=
 =?utf-8?B?ZkhpcFQvaFFOTkl5dUJYV1ZJNzVmRjlacVNrTWVEb21wdG9uUUZTRDZvOUs4?=
 =?utf-8?B?T1VhVEtPRE1hVlkyeitvTkM1b3A2SWx2NXJMekpadnNOc0dnL0xOSnhHYUlH?=
 =?utf-8?B?RDFLZEJqTjhPZmhwNnl5bHZKSjVsYmp5UFI3TEpCMEUrbTEwOE1EMklxT0VW?=
 =?utf-8?B?cDBtbnNMUFFKakNtMzJVWkdlWk1UTmNYZHVkK0U5dy9Yb2ZCWGFYNEluK01C?=
 =?utf-8?B?NzFTOUM1bmdnSThkRnZ4bHRIRjRNNnpSV21DTlo3TGk2MUxvaE9YbmorMnY1?=
 =?utf-8?B?WVNBTnZFdGJmc0NiVForZi9hUVRJRnlPT2ZJaDFvN0dXZURXYUxjMHhJdllE?=
 =?utf-8?B?YVZDMndrNWRSaTRaQVB5ZnhBeExIL0dFR3VjY1g4WU1rb2Z3SDVWcEphYW5Y?=
 =?utf-8?B?L0FKRmRoVXRUWEhHSHo5dU5QVFJUTUg0Uy95SDJKdm9oQk9EbjlOY2FwbUhv?=
 =?utf-8?B?QVRBeVdGdkkrK3JZOXpqT04xNWNFUDRPWnFZeUtrNnRQVlp6MUxtOHZvQlgv?=
 =?utf-8?B?b0w5clhtYkptQ01GakMyTU5zL3hHOGhPNGpRcTZiWEZwV09uRDBaQy9sbExI?=
 =?utf-8?B?WGpIU292MUVNaXFHVzIxMWZ1MG0zVWZqRWVLd1hDNjIySzUwdlg5VVlqUTJo?=
 =?utf-8?B?MFVEMWRYYlRxRVVlS1ppNFYzc0RZYmY4WGtTclFvYWRTNW16RkpncWZjbUJr?=
 =?utf-8?B?TDlwU0paUjNTd1VrMkh5c3N1dVlFWWlpTC84N2lEbDRIeUtQMS9UcmZKYnFX?=
 =?utf-8?B?M04zaTRZVkZ3b0JhQWZSd1hjQjBGR1RDMHN3R2FOV3JMTDA2K0QyYnlsTjBQ?=
 =?utf-8?B?SW9XVzlobWdXOVRRaW1ZazJwZWhaMGVicnhXc0JwbEpWQ2RCbTVtcnlpOVRv?=
 =?utf-8?B?dGVOOEFScDJrUFlTdXMxUmlXcVc0YU10ekEraFA4bktBQjEvL01YZEJWRFhT?=
 =?utf-8?B?QXlaN2JhaUF0ekVIYUFDTnNiVDNELzFDSW0yKzlDVlVSK2Z0Zjhkb0NTZEtY?=
 =?utf-8?B?WTlvQmVLZ0puWVhPL25YbVcweGFrbzQ0MjkzMWluTnIwcFZMRms3YkkzNkFF?=
 =?utf-8?B?UWJBdEVMQ2I2eDV2SHB3MlJoODVqd1ZFdlJxZz09?=
X-Microsoft-Antispam-Message-Info: FPdi6pNkueJ65uuz0kqC9CF7CHMYFe2ftQvHNXGeHmHLaWRuAYjNado/jmC9eKrwReHq+cT2dU2pvrISrYvcW4AzJtucIyxu/azroxJbxtD4+/7mf25DNc3YGNEp7kBdUsE9t8QZUL6p9bKdX6b6ruHdDd0Rh65tdf1c6Mlrae7abb3kU7Mb4smsK4bDcNRU
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;6:QuU89sHiIuq4E4PgExvIsuh7iPCdCdZiUNeNlPXsTfogChEB7hzYQw0W8MWX2ifqej/MczX61c0Ol5F7B1vYC5nSH9xR/VjKKO0PIJNNWsX88vuJl/miscv7aEXX6+FyPKP8q0T1FNhMwCIp+RDOoh4zmKjEuxHFgpIyLVuXCCd22z/otfJ/WF0aVtTb4ehoS8LQsA4CKgAM6anWnTywKliBJMbqoq6/M3aoARD/6QscqNHtt1BWiT4j8QWqYZd9W5LaDX/HY73CyHJRBUsW0zIYC/IfVfIi8AVSyHVVwwPAuJRCP/yY7uu7Beg544IPD43zxBqwo5rffrDtfwWGpPSE3TZmviNt7/OgnD5vrPrl6VcQLK4aQ+JpgVMRs7BFzM6frOvdu+lXxkCI4RTaKGhrVWZ+7PgS7ag37jD8TP12nC8LXEakqs9N84Dan5xhcWTDPOaEr95tT8EaIX1YUQ==;5:9KBkGC5ndrUTUJPW0nKvmOUsMO4ZpPR3qlfVLbNno2P3h09fX6sBHUHU4eYDTHipP9LKdde1Lb/yQtXIDKiSkGoFZ/3z6lW92E/cs/nIH7IMyNjZUDJEJ54cDs/rD8FrqnBZsx3EoQYMQJosxLTzxe9ZMXHb0cjQh4a0p/eUAaI=;24:f2lgOiyFQBDu0/auTHZho3VhZUIWUkjyb/PxFyz9+d2CRPeS6d9i50bUUymoHKcm28jRuX+fkZXIWFsFSgvtMXHcBOtbhuRp2+eSoftWkOg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;7:wRjrHIebfwztMKdDGUGvQUkm0BbNWibV9l38HFrPgPIPtsiwTKw3XTlwoVlhugK88IgPb0e08Kyjuc2+aVGV1x23Y1cCbyOKqxe0vD1Qphcrl3cxTPcUVNTurtbYR7iwDhcWkszc1lTcwubg7l9R8rYwocEP2nNEGQO6ZNfgmVN/dMTtnd4OxNfE4+wQ6h9bPliNJ2GKnkcq2/x0m/MEfd8IrhEczy6yzsAkr8eH8/GMLPhmeICmtjeh9QqoQ0/j;20:ussynS2VQAIEHoue16zcbYxRg0PKk9sfDZqR4Q4/JTF6vmGglVxlrVvyX1pfpEvsAZt6iTp5f7QAwK+zl2JUgeW2XVfN74ThQIWXmo7PB9ybjScZSnFZhcE6vyBoFScNGiQ/fQjUqUKwuV085icwJkAtgHR8aiwZaGPcUFZTConr52BsqwQM38r/8YwD1dSJPFAuWdLWoW+hVSIvDPn8cx57OBik/JMfJkvRY7C2wByFMAuJOb/jIkDmxojp9DKs
X-MS-Office365-Filtering-Correlation-Id: de9e95b8-45eb-4b21-ac1b-08d5cd0c7d47
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 06:53:03.9370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de9e95b8-45eb-4b21-ac1b-08d5cd0c7d47
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.06.2018 um 08:02 schrieb Christoph Hellwig:
> On Thu, Jun 07, 2018 at 02:32:46PM +0200, Gabriel C wrote:
>> Ok done.. bisect points to:
> What is the failure mode you are seeing?  Can't find anything in the
> mail unfortunately.

As far as I analyzed it we now get an -ENOMEM from dma_alloc_attrs() in 
drivers/gpu/drm/ttm/ttm_page_alloc_dma.c when IOMMU is enabled.

Still need to figure out which parameters we want to use for the 
allocation, but I think it is only 4k or 8k.

Regards,
Christian.
