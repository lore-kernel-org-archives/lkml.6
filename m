Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD443C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853DF21890
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G7mLAnQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853DF21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeHQRAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:00:36 -0400
Received: from mail-bl2nam02on0054.outbound.protection.outlook.com ([104.47.38.54]:22800
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbeHQRAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Duw/6/Diixmi8dZWbtuK1Q8AO7We07B6qnSl9iN0S0=;
 b=G7mLAnQMrrIKerxFWelywbPpF7/g5+hE1OncJ1bE7iR3rFIi+StI4ggbZRviBe7FLVdUq7+d2Ml2fULeTeYWlGJe3ppfNqgIgJbHODYvJw3x1lEzGrzymPH+cTKoT7+Z5xrmPGTsRYQP2Fdc2gXU2Ro1K7JIc2z5ETqARDXGpSQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
Received: from [192.168.1.2] (165.204.55.250) by
 SN1PR12MB0606.namprd12.prod.outlook.com (2a01:111:e400:c429::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.19; Fri, 17 Aug
 2018 13:57:01 +0000
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu/display: Replace
 CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86"
To:     christian.koenig@amd.com, alexander.deucher@amd.com, arnd@arndb.de,
        michel.daenzer@amd.com
Cc:     airlied@linux.ie, Jordan.Lazare@amd.com, harry.wentland@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com>
 <8d7c294c-6585-01f1-cd78-5c30cd30142d@gmail.com>
From:   Leo Li <sunpeng.li@amd.com>
Message-ID: <773509cb-9760-325c-42ee-abe76684ea32@amd.com>
Date:   Fri, 17 Aug 2018 09:56:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8d7c294c-6585-01f1-cd78-5c30cd30142d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::26) To SN1PR12MB0606.namprd12.prod.outlook.com
 (2a01:111:e400:c429::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a214fc70-da01-42d9-4610-08d604494ef2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0606;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0606;3:XlJV644RUk8+Nz7fWtD2Gaf5y9fUWalt4ht8yb4NmPj/sLfwfA2AkTnZVLzyEfv2Vn1xksEVTl9THtbeIAI7afqqZzIGGhV4Y1t0iX9LVj/dUDvDjhxusqdwL9vG4jeh/mLVuGUXQrHRgizPGJbisKi9exWlCCUQGilUG7ZvhKoD9fuvMgfPdqoIaZ/HIhWVQ5sIyGNSmD93qjU3Fs7ExkFMW+DTJwKXjBwPGK7NOO5gcJD9i4ciUSltt106rJjT;25:NWM8Gx0dmjfxzZMG4O76Aj8ty7IOrJlRdrerVT+EOdOPT+ATf8sVw9Y03TVXa38Pz1Z7YcH7DJF9IH/WtQ+3VkHiaWdD+LOcPKoUi3sCp12sRyQCMFcYD8554DgXm/WYp9vnf2UsrKifbRr0SnSpiw79eTKp8DnyheD1/A+z2jmScJ0sn/rzZqcgHp+Ln9FDlUsjLir8neS1MiwZ8lcQiM1t4xmCo01Ve79UPxZW2FdYb0PB3plWdr05mfSvpT/TkfJNhY6SjUeNvUV7WrXiN3K9vA5VT3kFOX5zoSMjx5WwqvKuU1686l4+jOlr8+AYXwJDS2dYUcdwr+gED7aI3g==;31:YjlwGjuzzhMbWwqGiotIPtVttj/MCMYLpjmtNT/O5wW0K7IC/3gc+3sYD8cY6btWpVjLKp3WX4tSBo+VQ0Wh+uSm97wyCR9CuT1Lc095lxLY3iURSoW9PbdjhnfY46eRpfAwKvn/mvFjVXhfsRhIFsab2THvLbd7HR+uvcGvkB1151XTW9DFBu7Qf6FssxwI90m2DapPaAJFNVuZO6AZrMBFRGoDzSbG+8o5rRmU9RI=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0606:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0606;20:YsuMTwbLYouqSGDJB/Kc6UPSDjoTPzYCzviNvRBxu8+QHEYKYI0g5yB65fyyUyRHmCvc6OifR9fsIRzYxwoSF80OVzlLGwB2J9Ath/16a2URqLOVbJjRmOH00Hqmlyv0s5rkw8wtRkyotZD/ezwJONffZjL6zB4251wGIb3YAXMCi+M9gZhMYJoyUMb0PSe1gJETveJZGTo2Tb6lQU9djnfd9T9rsNOF4SjXYrBJvz9x9MNnqaYfL5K4blg+wefbZyt1uZ3AIj0wuBOmGrvjnwh3AZWqclAzsjDJk8KRq9uXIvKDlip3w1ch8v79rU+DsjEiZA9lWfN1Q0xhsLElOfafKANcdRDrfhXf+1s9sHTxRD1LjteWR3mRL/G/hXDyNXSRviq+WZKqQBAc9stz8eP4iSMzD+VUrEn3soilHdxgB55eJ8nl8GwBsUmXdwnG+mIjCNMbt2TPIGaw0XsKRuCjy/aVpUvIdq2UGoAOnG+KxUYR0lUpAJKmBehOxD4K;4:9naRAeZMQZSPJ4ERykZb6O7wijqJXqn3kFadiE+8Ec7sE5UkAmAqrC9jL9I8w/LMxyO0/02+XJ7InfzCvkktAKmi4VRHC/9wvD1H0mr+cLz7lIP4U3JTVs49PMTokN18KMUFSX17ASZhW+NGWRg2eVx2NZt56gjqvlH2oFAYJA8Wq508EZMZvJkAQUhCfT+xlvk6XpxLFsUnedzk0b36DHSf0QDMyt2PxFRkZahXp3q0P3+wdvu+2lhypkLaICjMU96Ol46njcYqhLeXjf4yEIdjJq0iyOjicNWh/ex90D6h/NzXvvqe3p1W+b84Vmf9Abk2+/3KEGXsPvXuDf9aowJ4StaxVmCSVUA+vB1bcDOejfwEIbsuyb3xKWlxnGFs
X-Microsoft-Antispam-PRVS: <SN1PR12MB0606FCE82CA4E266E2485B6B823D0@SN1PR12MB0606.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(788757137089)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:SN1PR12MB0606;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0606;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(97736004)(386003)(53546011)(16526019)(956004)(11346002)(476003)(486006)(2616005)(26005)(186003)(446003)(65826007)(6666003)(64126003)(5660300001)(77096007)(105586002)(6116002)(3846002)(6636002)(31696002)(68736007)(86362001)(31686004)(106356001)(8936002)(67846002)(2870700001)(65806001)(4326008)(6246003)(47776003)(966005)(25786009)(117156002)(316002)(16576012)(2906002)(15760500003)(229853002)(52116002)(23676004)(2486003)(72206003)(52146003)(58126008)(6486002)(7736002)(76176011)(8676002)(36756003)(6306002)(81166006)(305945005)(81156014)(50466002)(53936002)(66066001)(478600001)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0606;H:[192.168.1.2];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNjA2OzIzOjc3TEVhdFJISVhMUXcyTGpZUWdpOFBJMnZ6?=
 =?utf-8?B?RUg5ZVRqT0pqcG9mQVpuOGYxT1RaQUlUd3V5dDduZGxBWmtzbFVvUHBtakMy?=
 =?utf-8?B?YXhDUFR0eE5peHpWZHdMZXQyOHRLQlhYd1RJUDZNcVh4QWZpUEJrc3hVaUtn?=
 =?utf-8?B?UWlYT3Y1ZVYvMUx5V1lHZnVpT3cxdm9jQTBXQlA3MlFMUjhCazN6NmJQTGh5?=
 =?utf-8?B?bm1GRFVBR1p2UVJJNmQxK1JNb0hMc3RZODgrQkZKRk42UUtLVHZFUkZJekV0?=
 =?utf-8?B?M2ZoUUVsSmN1MTRXSVJVVkFodFVXTzNFYUNQZW1NQTNURXI4NCtoTmQxcnhs?=
 =?utf-8?B?YmROTGFxSmZ5d0Q1dVYrMzk5NzBjclR6NktBM2c5VnBxQ0F1Z2t6R3VyMlhs?=
 =?utf-8?B?Ync0WnNXdkJCdmVEM0JCODZlK2w3TG5EK2tKaGhhME9PTUtmRHorMnhMdjB6?=
 =?utf-8?B?UHdvV2pQOWRmY1dMOEJMMlduNWNWTFNQSE1icFBPL08yTGZGM3lRNUhmdUtw?=
 =?utf-8?B?SWNqRDl3WFdmNVJ6VWpITFB6T1lrODREQ3Rmb3czZzBFVWhKcmZ5U2hzMitv?=
 =?utf-8?B?aHNIaDhWSFprSEhYOUFCUGZVSVE4cnE4NVRDcGVyaU9pZUd0VlZnNnZIUjJa?=
 =?utf-8?B?em9WMXB6NHRMZU9DNzdyVzFJWDFGbXFSSHc1VjRieGx6eUNYaGxFSURCaFEx?=
 =?utf-8?B?bXgrUFgxOGhSWnZmRWc4ZFBDT1dmV2RzanRkcHUzQ1p2bXg5UUNzOWYzcjBZ?=
 =?utf-8?B?YSs1WVZ0Unp6NVI1NEdZc3R0SXNUdjVDMUxKUGs0b3NQQ1pTUkNEWXZnVXVP?=
 =?utf-8?B?VHYzZ1BCOCtyTUFRRmswSWt6UzRYK3ptQ3VvR2F0OVowdklwSHYzemV3Wmph?=
 =?utf-8?B?NWJQZFVGRVc5OU1GYWlSMEdoTmJUTE1LbU1JMGxINUMwMHRldDdoQ3UxUU5U?=
 =?utf-8?B?cksyYXFneDMvUFdFMDlyUzIzUWhFR2tvUjllbWJBSlFvZDA3eDA0SFRieHNG?=
 =?utf-8?B?VE52T2REcFVyTHNNQzVqMVZ1aVozWkhyanU1anNZVGNCeENyVExFbGpHb2pW?=
 =?utf-8?B?VlllMzB0aEx6aENnUms5RU9DNm1qc0dmMXJPZVNvYkdsSlNNMDRrdjJnY1hW?=
 =?utf-8?B?NXhRSm53dmVWTzNSMWYyVDVlL0N0SUV0QTluQmZaU0JPUzJyQ3c5c2txS21w?=
 =?utf-8?B?aWEycnB5Z2RRaVd1V1RBRit2TEtjUkJyaXFRQ1Z3UDViTktFRlBCNkxpZk5P?=
 =?utf-8?B?eTdDOUpabFR6Visrak9tbktCY29FdUVXOTIxTU5MZmZkU2hjZFdaTlIxV1JQ?=
 =?utf-8?B?Y1hrZXZPeE5rUklHZkZlWjlpMXYrTFlsOGFUUVpUaVp3dHo2c1NkbXNnVFFy?=
 =?utf-8?B?dWdwcWRyYUZ3QzM4amNTbDcvMFF3YUJIWENHM29HUmIvUWNQemFCQlV0cmdE?=
 =?utf-8?B?WEMvdS9TU2lNaXlmb3hEeU8zVHFiNnVpM0kvTDNrOThWVzNWeDdwRWNPWThU?=
 =?utf-8?B?ZnhHMVIrTjdjMVhWSEtHTEphV2szNTZyd2huOVNDWXdhSWdHMTRyK1FXZnJB?=
 =?utf-8?B?dzRpWllQSGVGaUdXOEFhbHRMOUpMcW1YOHlOWjFMbDJuSmRWbWZPTGVsaW1Z?=
 =?utf-8?B?NXUwUnNaV2hzVVlWMHlrVXRrS3R4VDV0S0xYM0V4UkZsSnVwNmxNTjgrb1RY?=
 =?utf-8?B?WXRIUjBjM1FvNHZielNqbkRuWUM4SytRVEVBdkpEczNHaW9XMW9mTE8wNFVl?=
 =?utf-8?B?NkhwVWs2d3o0WGowYmpwZzA0V3ZqUDNQS1RFSG5aSHhmeUpzSmJCSDZvL1dx?=
 =?utf-8?B?VVJXWEJqOWNnNTVpTnRORmNHM1ZRNlJUeW91WWVoTWpwQUFSVkxxRTBzNGU2?=
 =?utf-8?B?K3FBa3RRV3M2TUIzdWltcmNDT05hUDJTTnlYcWdLVUpCZWNQV04wMVZLQ1JR?=
 =?utf-8?B?d1hoZFBySzE4aEh1a1VUT1JxRTk5MmhUdUJINEpYSE0wMWgwa3dpVFhRZXlE?=
 =?utf-8?B?Y3BrRjIycDhWdVlQeGNLV0YxWmY2VkoxbldjTUdLTFZmKzY0SDdRYWVvMk1w?=
 =?utf-8?Q?3MaQf1lM/K2dMVq9nPFs/HGDs?=
X-Microsoft-Antispam-Message-Info: YIvLJl/v7eIC17VWC/LPwRy2obTi9SuQr2lctvxakJgyAaUcElP9xjW+z79cZQ1XCkJVgbOxowPeSNXkFbGREydNBaXEb3CH9V+U0M0eyUSp1tGmZ2gfnnlk7am/mSedpLUluKgQEIx0rVJWhGqxLQ1gR/tkdz9MMNBa9hf7RyUi5MDSmSjpcUMoXnEMWbh3S1fg7xT/1oU/V4+lP0bJwuhC5znWT7LU2KaOkRppicBLRlz6CUZUcgo288YdmVfmCY1rAMC00trb2Kx4iJr6Sa2F1TzG7QyqZP8U3zJbadiATvyhHSReBZeE8/LDoQoStDuZQMtehebrbDEntTvChWPVoc4a1fj6mxp+4EqHUw0=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0606;6:4U5qBx35GvwBnVgBvFktee8RzLxcv8iAkdAhkBHdz7ctfeGwbeNK1oIxPkUzqwqXccXgO+svcjJZx45RyfmgvLSVty5Gw5PR55Foj1xNerKo9LEydMQNDZMx/P0PyJeYFgs5PYry/JZy/TuK8pFktyL9liSB2TL1QIs+FV3tAwvduJ0fT4ExGoSy+ynKswJGOFeuuw52mFGQ4/4eKdEvnd5DsAZ+VR2PbQAcaR1Oni1EgH4f6ioF6w7bAwYZ8OUp65m5sqhiG3HPV3mNDVGCRq+5LmPpZm8Ost/W1dt+4daMfYZk8zPM6Dh9GsqYC4Tn5aZkqZNNwxlA0usTpsGiBFrcqBGnq2qELGxnbbg8YU31Q5keX45LJTnHAwjVW0IeWYf4wcd94gja7oCwTqKgSSlU0K/yboqiGDyP400Qg7kg9XZG9Zt6wZphc340iFD9yKrODPDdAgJadlwNuFL4Mg==;5:UZyuAeDfBMayx5Z2xg9WWIBmcJ0pBCKiCa+QDiVkspKt9wCm5VdDAspt1Lxm6F7Rl9Ve1FyG+gyG2CMwZ3QlE4eHaqWRlxYj8FrNu2tgMrLUU0obUJ1I0W68jXKXe0ncGmpUZ092xBjmHn3cE3PW3al66QcncuMfy1XwV3DPcgQ=;7:m0doEbPf4xS38AJ22K+QyN4q3CJGHH1Yngt61ksSCwz/Svmz2enWtOSrdaGsaN0zWBLSZjcORFEZVIW25QEvVVIaIvM20QHkNEscbp8Wis70Icvw0fBb5ilk6eSlQlkEEt/t/i6dKKNFHVkgf8pd8nDnSpWkPwPcLMRbJHMYpXKsbFxEsibqBw40NS9rI4Qeb0SatkFFHKkIL9ts8fcHG61aaJgXMU9OxIbL/cNFX2drgkGtMBiow73od4j/4OcM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0606;20:g+CinBTRldDg3lkWu/yNR5W12jJkPFjjTi1+gO4rZ7Ctt2X4AucBFt4r62e6ICugeLmZMdZssSihCRKbm0Tn260MWF6L3D4d7lRAxGaVx8bNkH4TOfyaanFG2NR3UbybmCqXTRhwFvqhbN+mbhHnA6zO847SLzw3ntOvgLQk7ltJZmFQx8252bgYRw/2AUNwhCicsxJM1wZPbR6Taauz1Lqazq8TqgCeJ78GROelxRvXwT+q023nRTlmgeG2iVhc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 13:57:01.7034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a214fc70-da01-42d9-4610-08d604494ef2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-08-17 03:16 AM, Christian König wrote:
> Am 16.08.2018 um 21:44 schrieb sunpeng.li@amd.com:
>> [SNIP]
>> +config DRM_AMD_DC_DCN1_0
>> +    bool "DCN 1.0 Raven family"
>> +    depends on DRM_AMD_DC && X86
>> +    default y
>> +    help
>> +      Choose this option if you want to have
>> +      RV family for display engine
>> +
> 
> Probably better to follow Michel's suggestion and not make that an use 
> configurable option.
> 
> Instead just select it based on the dependencies.

The 2nd patch should have taken care of that :)
Leo

> 
> Christian.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
