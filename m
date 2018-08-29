Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42FCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869172064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Izfs5e5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869172064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbeH2TwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:52:19 -0400
Received: from mail-eopbgr680045.outbound.protection.outlook.com ([40.107.68.45]:58091
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727484AbeH2TwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9uy/5EFnFlPuhFm08h8Pjjj4o5fMa0yj3PBnuk1XMw=;
 b=Izfs5e5S9TJ+pxAOeIoIyiUyX0DfvVMzrAZYuq8iTkmXX0ZNwc0w6RwYEajyKUjGy3s7LF3rruq/OpqYy5GEnKius+aqQFqOrNNTadEjx+gzB/jhHfiyE68hxcH1oMludfQP6r1pIDxL2Fxn0A7Jn9RsEVtRExPuIiUkSki6R5A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:6f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 15:54:40 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 2/3] x86/mm: add .data..decrypted section to hold
 shared variables
To:     Borislav Petkov <bp@suse.de>
References: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
 <1535494377-25600-3-git-send-email-brijesh.singh@amd.com>
 <20180829135949.GF6337@nazgul.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <9a4c2d09-3074-20dc-8801-81fa082148fa@amd.com>
Date:   Wed, 29 Aug 2018 10:54:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829135949.GF6337@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:805:66::28) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:6f::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 448a4ac2-115a-4661-3436-08d60dc7bbb0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2685;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;3:nq/dXgNCQFG7eeiYa3iHytPPvxh+uSQpqQ4hR3larx0v31D/1cNzCrA9rlJkSLycVp0Epir9e9HJiC+tupF2n3SsSsQyrY4M6fkNB8DsCAzO2AHjIP8qwOPLDIBMOUC+mF5YoInnCrWiqXzbVqiXSCT7ZeuNGxDYvCidNsSrom92Ok1hm7rudGHr1R3fJabyvYKm9qW9bLjyA0mtSgGuvHUlv9He1vXlmodq1x3xOxcE66ftEPL93pB82rqzeuT9;25:DQ36Ff4BmdltqdvzhV5TMFoYSr3drPsLLFchZ8Gn1CzHJLnzpoKPn4nsXhjM2T2IcU8bNiDuyaDTvz8AbbP6xQolFUMo7dklKmNgj93t8yYkdxKDxNsWM/U6su99Kf4FobjO4El+NZiZ7evHTcf+SXs6kCXzR4i8WS7+RG5eJ+CBo8IOQsICxuUytiyJQNd1fK1AOUPrYddAWMlmV1B80Ro6+XvTqPDBue22m5cOLhason79i6i4aPSmsp0ETj0wE4JzNmbk+vhlD4z/65/lqZOGZO6HGrGCeEy/AxwINqkHFJBlpomxJxtA4QC0c+2EpHrAHDkFbQzXcHGbAmn6Yw==;31:FBvYADhN9kJCYaLXr+YfmuQzKwM8+jj3tHPOpZEakpGrKDctHLJzUk77DRh1mWkmCmltoDsROFOWETDXFO+dHDsi0lWjQGE/0Hk3oZqo+vkL0VFTP9pOooj2e5VHdFE0uzCwONDkPgbBFo+Kc95sS1wxp7D96Wh/S59tsNydTRZBMtoUus2BCn6/dgtPoTJhMKvA0FVbM4aeN1LraW85EijHarNJHsxEucC2OoU/hIE=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;20:fR3O0KgPKaNVT/G8LdKYwCihz+9qv3xde7PinI1FC0qRbuTNppHaFqy5MRY2G4WErDEFsYSXT6K1zfELe4ipl6EuAbGPceGWPg6PHbh16vOt+3ibvVKcx/Wc8WiImowg8TAG+JauiHEQlyw+QKxVV/EReCiq0CXgi9hNXAS6jhwVI4Jb/IqYLzJzAbkD/SJQVbqyF73TOvUk9VfdEmQUrXxpxh+P/pC7gw4ukhzXcm2W+qEH0xB1wzX8hpoVVESysS9q6ddlYo4AHeUKlFtgdeLtlyfpK1ggor6hTn4+daPZdU4QmqOgncIAVfHGrQWGr0s20RDvzLLO7Qy3e4JRrhUgOiIzngcxVqk4xKJPvn+Qdf3w9lbMYAV7Q7px6wWqFiSgostWQO888QiT+tR+f2ayA7pphhcePM8QX/BebZor8puAbtkCijR7TOGjB0ovEVviqJR3Q+VOBPqJgcA42udnI7gaesIN0mOLdCboTxaxmf744Fo3tSW16VkqwghO;4:Z5TrdzlPfS0nwBEw7S3V+J5oMU1P1YxZHrWgDsjuPsjKCX4MZoICJhET+TZtn6sxpjNJPtObljT7ADjU1JUOlrjiO8VAcIJ21xf1GOV5lvfGOnlFMo//qAfYq6diJJ2ZIdvO19jBzVmcCievoXsES9yTpmtm3qfb23sNx9ne0+5m3It+hTXRCW7IIUEMOsFEw6/gahagiD+y8f5gUSmZyJFnFF3aM949NIhnCZSym7ubdyRDWnAl9uRFTW+rray5fQfH0LIsVdF9pbmFaHzngA==
X-Microsoft-Antispam-PRVS: <SN6PR12MB2685D0695599760338BD760FE5090@SN6PR12MB2685.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN6PR12MB2685;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2685;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(136003)(346002)(366004)(396003)(39860400002)(189003)(199004)(23676004)(7416002)(58126008)(76176011)(8936002)(2616005)(11346002)(305945005)(476003)(2486003)(386003)(44832011)(956004)(486006)(67846002)(36756003)(446003)(52116002)(52146003)(14444005)(16576012)(7736002)(81166006)(53546011)(65826007)(316002)(6916009)(54906003)(66066001)(6666003)(4326008)(81156014)(47776003)(65806001)(65956001)(31696002)(229853002)(5660300001)(8676002)(86362001)(50466002)(6486002)(25786009)(64126003)(2906002)(105586002)(16526019)(186003)(77096007)(31686004)(53936002)(26005)(478600001)(106356001)(6246003)(97736004)(68736007)(3846002)(230700001)(6116002)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2685;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg1OzIzOldtamp2aEMvbzNrYk1WSDJBaWVBVmQvYW1V?=
 =?utf-8?B?emtKYmhDN3l1TzMwYkMvU1p6dkdYM2RPYXlvTUtsNlRWMW9NTW44NUl4WEM1?=
 =?utf-8?B?T1NhSnk0UHYvN0RoODJLbmtwRHVQQi9BVStwSE5QUDZ1bWhzbWswelpvZ3o2?=
 =?utf-8?B?di9UbkxYcXhuZFdaeUkzUjFweEQzSjVaS21lUmJ1ZXFYY0NDQ0d0alhaYXp4?=
 =?utf-8?B?UHhSVlE3UHA3QVNySFR5cERwTzNqRUtSdDhLTWNCQjgzL3pQeXR0cno1R3Nn?=
 =?utf-8?B?d0NJcmtLL3ZFWDZxSEIyTC9zWHlDU2xmdXJoajBWbmtOdzZFeEVJaHRvTjVs?=
 =?utf-8?B?VitUdklRTXFUQ3gwTzNabFR5eEZhYXd2MUdzMjNIb0NkMU4rNDNZYlF5VXNB?=
 =?utf-8?B?dEs4a2paUldndWFzQ3FUeVRKMzZiMUp1Wkd0QmsrUisxR3FkSncxRjJvRVkx?=
 =?utf-8?B?L3FuMVdoNk5JMy96ZEFFeStmSHZrZXBJRXd6TEdhb0N2RmZ2MlRKeXZ5Y3RF?=
 =?utf-8?B?MzRwd3VCZUVaSnpBd3dUMWEyeWlGYVZTeUVNNmFINTNsaGZmRG5yclFOcTFP?=
 =?utf-8?B?QmZXdUR4bzdzaHlNMEEzdWYwUnRQNURkL3F4Y2FZZ0VVOWRFMGUvOWswZC84?=
 =?utf-8?B?NFEySzRqSFpxZlE2aUkzYTY4V2xXdUIxMStQZGNBSVhNaEt1THUvaDFlS3pW?=
 =?utf-8?B?cjB5bHZNSGdTSElHTk0vT3R5amc1NjUvZFd4M01VNEtFUWVkdDNsWXhGMzds?=
 =?utf-8?B?Z0RXRTc3dXZ2UmNsVGw3Y2NLRFJXMXI4eERuT1hmdHV6NzEwT1IySDduOU1K?=
 =?utf-8?B?YUZpcmdTMlVKdkZvcld6TlZkc1AxTERESDJhM0g0MXAyVUp5aHVjdWtKZ3RI?=
 =?utf-8?B?ZDFPTWFrb1I5Sk01bWVOc3FzKzJBM05ZaEkrSkF1MUhIbGRZUHBHRW9ISzRa?=
 =?utf-8?B?cjI0azVVRyt1MW5vNFdPK2hSQSsvVkhYMnVjc0hkT0swaTZ2aFFRT0htZlk3?=
 =?utf-8?B?MU9NcHFjWWpxeUJnbUl4MzNibWxkNEMzTEdQZzU4S1RPSjZSdjlaNC8va0pp?=
 =?utf-8?B?ZUNxcmtLcEV5cHFSZ0hEd0JsMmRmd3FmT2FGRzZjZXVuVjhhREpkRlpYQTVU?=
 =?utf-8?B?a1FCc2JyQnFaa2sxeWJabmkyOUVMYXJ4elRoZnc3UWtkV3EvenpBYUlocFpi?=
 =?utf-8?B?WWlESDFGVkUrQWVpMHdDeWFRZnZWRVlsSlpzS0l6VXlHdk5ZTlRYNXNSVk9Q?=
 =?utf-8?B?RXpZN2NJa0RueEphekh6TjlBYS9lOXBrdDNFU3RDYUVZcDNWWDdwa0lGNmw5?=
 =?utf-8?B?Q2JTRXBsNUZYeHJwNUkyMTE3c2hHN1NjbkcrTXV4L1RaVlUxdDZOYWVGcE5x?=
 =?utf-8?B?bVJ5ZXhvMGlDa0FLTHJKNjVBY1k5dnE2M1Q3N011c0pqQzFZQnpYOXlKMWNF?=
 =?utf-8?B?ektrc1V0Vm9IL3kzU2dDNWlwN2YxelRURkRjamY4c3UzMEptMjYvN0N0R2Zk?=
 =?utf-8?B?NXZZbGlVcnVyR0QyZkl2MlZuVjc4cTMxbzFxWFdyTTMxL3h0b0pHM0k4blJP?=
 =?utf-8?B?aDFhWnR2aExSWFJ1anVPQjBSdW9Sc3FVbEgycG53V3E1R2RtWW96dkl0Y1ZN?=
 =?utf-8?B?Qk1jbWgxc0xyNDJqalo2eGU0M2dRY0tPMVBrYUplcHk4RWpVTlBtQURWd1Va?=
 =?utf-8?B?TXpjS05yZVl2R2tuY2dub3AxYy9MM2JsU3RTUGhCdmNXV2xWMElxZUxGYndz?=
 =?utf-8?B?UDhhbjk4cWxmZXV1ZUNEeUZpRUc0V2dvYWZlNkRaNzBLbk1acDV5dVlHTDg1?=
 =?utf-8?B?aFBDWXVpbG9hTnBOc1g1NWRnL3FZOGM3MU1nQmVZSG9OMmtRRkYwRGU2cFRC?=
 =?utf-8?B?dmV4ZnVWSnJqSFYzNXNEWXlpYlZtZWlSbHpMQjkycVgrM0VjQlRqbW9uQTN2?=
 =?utf-8?B?b1k4bVZiTnk4WExtWkEyNVFIOHp0TGxNSC8yUkZjNHZFL3RGMHYrczRlTkFr?=
 =?utf-8?B?SGNHcy9nY2N6OHkvU1I4UktyaGNjK0NJajFHS1F1d1FjZnF5Q2MycmpMamdr?=
 =?utf-8?B?TSt2akloSWFCd2RwWStjTWRvUVNSalFEU0VVZ1o1WDV5eFpLSGt6dDF3Z1hi?=
 =?utf-8?B?L1E9PQ==?=
X-Microsoft-Antispam-Message-Info: 9mx3HPugWriCVovAs+86gPuGnAyyR2Hn+xw6WRMwYgb9UTrnkJRLTOJztOsB+lFcsFhZoS1izGA3AaZLUkkF4IlUfOcQ//fGxHq5Cw+I9kc43Wmw922ixwRWJ4UqXoZgoZJ5cj71743l1x8kboYBQQUgfNYl37jnLZOYdVnAMoaok/48kJkMvMo3vNM7x55x7YY8AbQRuYDgBuBzSoXgZS6SKNjH3EMWKtG2GEL1F2jzWphlzQ+atWWGvTKkFUeHio25Q26atNBiCgX3RlP/0wTHulIZF/wJVsbDV4hs910+2AKwVmVy3b7hUOo3hNfbb4zzmfJyZy+m1+Qly1GUq0OpPxcEeDaixZFjoVhMf4U=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;6:tNC1v8lVcX83YREScW4OENBlFfdOKZaf2xDpXz4uAdhvI9sjimM4+evP60eVqHZmzHo3emeypRvnqrHExvzUqeGneJFchPgjc7Wlo7+CATWQX80V6B/yeWXvrFmvLwk4w2c3VhxOgSduikT9MiGjopmIO3U2zATDw/+6Nt0yNRbGZ5ghbakBmcLLMybCl77+nUNki+OMiUTndqNQy/4R/zD72Z8HarLdvv9iyEm7SFbbSUl9P4681O5c0ZHvbVkxnja9NI7hwJPBW5BmYGvQl0cTO8L8h9DZ3f1tQ3uziP9Ijg9u543d7vINnmTGh23+0fxiRQMS002ALJCl9DbKnkg9mmm567l1JEixSVMf8dGkYT8z9Wpoz6RMSyn+u96IKFM8JV390buJyAy//9eysOcZjz/I8gTGwQxi2pBWXhun2QCF3y7Nu/fy30wNyhQbTSI54WpJSzg2Q++thiwgng==;5:ruBLI6fPco0wT2rsv1jlXWkysSQekakENjFEa5JHmNWLbqesep6GdQuAm798t1PgjzF+rO4+JyK0JsGWZ7kdJqCVOTIcwrZxt2QCvSNZ0A6e1ixh/YVj3Ds1nuistCipu9+f1PXzlo1CC55Bv6ZqLhZcy9D5UxuNEBN7Ir4cEKA=;7:REFQor96nrWvDufRwcaV61TPmM5cIpsqgPErnz+aRvaYIli8pApCRBk71WLHc1mgZvp2cd87qfAAHzYTFtIh+jfUkdtjxojuvSYZpYCy8D5vY4ImVm20IZbjzzSKt/KnRBHQ85ZND28qa4aUSyq8+hFfBGPB+v/1wbYtCLmF9IFNrmyirFpfH6GuTCyzb2Vt0RhHLWY+Wr9d3aLA4FPpU9oVqN+6hq0WP80WGko3LTgMxTJ3/DkgXeob77rMNY9y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;20:iKk1MkGJjVufX0Il+vpElslcKgH/QNZjaoh3+mevY6mgaqczJRejbVkYz35FAkngZo+/NXSZz4A371L0eu7tduCEVVJrzkLprS/Iliz6usnUrJVozDAKwPZCH7WIEQnHK2sJSgubtctkeNEdp4rU6bz2gqE56wKsMNkgpua3shChQ9nBFm0pZH+EQfyAjpTV9NNy9sCR89PCTh++FFyjtq9N9VHE820mb4jflgmAr9fC9z01NWDvO5Jk4ruXy0e4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 15:54:40.3323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 448a4ac2-115a-4661-3436-08d60dc7bbb0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 08/29/2018 08:59 AM, Borislav Petkov wrote:

...

> 
>>   static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
>> @@ -235,6 +235,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
>>   	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
>>   }
>>   
>> +static void __init sme_map_range_encrypted_wp(struct sme_populate_pgd_data *ppd)
>> +{
>> +	__sme_map_range(ppd, PMD_FLAGS_ENC_WP, PTE_FLAGS_ENC_WP);
>> +}
>> +
>>   static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
>>   {
>>   	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
> 
> These changes with the _WP flags and helper addition belong in a pre-patch.
> 


Please note that the _WP flags and helper functions are used by this
patch only. Introducing a helper in a separate patch will cause a build
warning. I am leaning to keep the helper in this patch but if you think
it should be done in separate patch then let me know.


-Brijesh
