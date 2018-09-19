Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C49FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BE820880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="mgM8fPfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BE820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeISMdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:33:51 -0400
Received: from mail-eopbgr730068.outbound.protection.outlook.com ([40.107.73.68]:51360
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726972AbeISMdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhA1Ac4bPVHYNfwk1yI+eeaRwJIF4ULQZANDQYvkxjY=;
 b=mgM8fPfgQ+hQSief8moJEySekoonYOAVToA8DyR3zfJQiBTZwhBYMjx3hslo8H//NHNLerQZhlQ691H1vuepE3fpGw6+IOnYS51D8MEcW3c67R740qMbZULZzB/a6GceqUQlB3NYoOO1DXIBjeiokMvZ7HBYdx/P9EsBG4z9SGg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
Received: from rric.localdomain (77.180.38.12) by
 CO2PR0701MB0999.namprd07.prod.outlook.com (2a01:111:e400:1435::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Wed, 19 Sep
 2018 06:57:15 +0000
Date:   Wed, 19 Sep 2018 08:57:02 +0200
From:   Robert Richter <robert.richter@cavium.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mian Yousaf Kaukab <ykaukab@suse.de>, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cwu@amperecomputing.com
Subject: Re: [PATCH RESEND 3/6] arm64: add sysfs vulnerability show for
 spectre v1
Message-ID: <20180919065701.GK3795@rric.localdomain>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-4-ykaukab@suse.de>
 <20180917172206.GA3795@rric.localdomain>
 <20180918083805.GB14404@arm.com>
 <20180918095226.GJ3795@rric.localdomain>
 <20180918171550.GN16498@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918171550.GN16498@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [77.180.38.12]
X-ClientProxiedBy: LO2P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::26) To CO2PR0701MB0999.namprd07.prod.outlook.com
 (2a01:111:e400:1435::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e662930a-f172-42bc-654a-08d61dfd22c3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0701MB0999;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB0999;3:scnZRlmrWwmaWQZ7rNx8ypMKLpeuyC95jvMUKPB6DBsKsUk/EUGOXZZhVHQ/U8MBmzgri9LQ8HkIKR9MIkGFPi6B4R1rY/bUzAp8xKOdLMHtqZTqlbNjdM/mHsDs40+Wemr3kFYf+1AsiasDzTHWMO8u4G6Qn19+G5neB7RGRDGbJKgD2fn315j1u8cCtSid+9srjuy77nm2oqHDxgINrm4TuQox55dOMR3Jb+1t+AIVz/y7UfB7QwOPHc+zOtwK;25:RkSxcPJgHRHtzA9pwteX6D6HvNnQGM7LHmGSKEG9PGlaqLz7QYyV2598ao5+iWG4MO92HpL9A6ATFz8Yb87nEXdhy4tKY9nxFKV5nsq7pHnswlju7lEjFyu/WOOUAyjWz2Ig5tj/Kw37JINH2WxYZCEd1eL1Zjb/NWR786lQ9sgKOPxKuvtFZK7ICUZfnzePYt5ivmuSkjSruL87NXGJt9iq3P5RnRpxPIN8fAYZDvVhmAO/v+aaE6TsqIJGd1vIwUi6w+8cFiGj0CtJ6c3DHviUTZJzwrAYuPL35K+sMbpN/4F6+6NxWeMgvceRk+l2drMAMATMEUXrceH2+OjQ8g==;31:RAmogHrb46XMc5Fq2fqnMNptWOuIgELFzVL+Fu6OFT1Nh79kK83xJkp12cohTdW1NOY809TjUql++OOKEObJRZGvDReUxxSowbkaEvrD9GRxcT0zu2qp6cDms4fBeHYcyloyjApfVS6QbjuAAlxe7WbletLlLHl5C1JUmeYCi41QxrGwJA9AatG9d4mG8r/Y+7fdAN2zs1Nhixn+aUkt4TLwTkyuwttF0QVHMMozAOg=
X-MS-TrafficTypeDiagnostic: CO2PR0701MB0999:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB0999;20:H2/9Kgn8NZkgBPRQBT+8qp6S8HIHaQJb+zJbuI53XCgrDYqZRiwDThW8mW4z7BtXg1mgNfAPr4QYzflCvDgU7FkFJ3UXNuGrUeRKLSouzr7YJCm9XbcfCEa4iIesfvkezN066wpD3WRjTHH614sddlQSDCa6AWKIVOTFRtUrBvZGadIhYaFyiqwQGSfZUo+mnuEraQr06PMIcq+rrG5p3u0qNZ6Ps7xPrCEqUSlzN9NB7ZtUP4q5n8gPtqN4QMu9HlQjM56mcm/J3UkK9VHjear7PAwiDMjNqg11Lfdxov0ATpOXWweqkSIboIyPrrbg33x8Ndjcd4WikxsXveN8oWXjYjJCF+1FwRyo2dQ34X9ccpesfk3eWsXCaH2EPm+1EJQo9ptsOUqhyzSwvJxMaiAJJdyOZI3WVAGAm0IQaVjKySE+mGJUtySUup2Hkb4tqSDnGAMf6FxCV/3eglgy14dWCG5q4Hsc2DizWOnD7sZozLjgVxGKUBn5tZrYhOu9;4:sgNkJk2pr0lJC0+BQXlvSbUx6W0vNtWzaD/HMWzjvGFqQpesHJCxp17lELr1kM7WVyKgksoxe3Qd0yNayEvBx2ZpFfhDpn0FSpj+KtCteJedIEHpm3mIzaMBiHpTEkccBCSbT74FKk5I6uGItGQ0VgHiCUw8/q5Yam6/EOX+FgIWfKYnwqOTKzUJYPwZhI0MimQ04xOxvRsXaEIS+JjjlDADyXpoIzM5I3pj6mYOcuevbi1Yxv6WhL9dlrxRwymMJkDsMlzN400tS/eo6ipw9x2RCASgAI9jgtc5V8cD/yoyK95uJkftcjnhlZjqMH1l
X-Microsoft-Antispam-PRVS: <CO2PR0701MB09996761E2388AEC326CAC14F11C0@CO2PR0701MB0999.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:CO2PR0701MB0999;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0701MB0999;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(57704003)(76176011)(6246003)(956004)(33656002)(217873002)(2906002)(81166006)(16586007)(26005)(97736004)(81156014)(58126008)(486006)(316002)(8936002)(186003)(16526019)(25786009)(476003)(4326008)(47776003)(478600001)(86362001)(446003)(3846002)(23726003)(68736007)(72206003)(1076002)(53936002)(386003)(6506007)(229853002)(93886005)(6666003)(6916009)(105586002)(106356001)(55016002)(44832011)(66066001)(6116002)(7696005)(52116002)(7736002)(33896004)(11346002)(50466002)(9686003)(5660300001)(305945005)(8676002)(53546011)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR0701MB0999;H:rric.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0701MB0999;23:SRhMD2wBA2xWM+PqfFP8T9T7O4QixZ0mTRZ113d?=
 =?us-ascii?Q?HuaxWPvwlr6QKReh3byy9H1e1ykN3muUPbyms3yrY+OhUzFKSuAQrg/VwDaP?=
 =?us-ascii?Q?nLPthprv4a+/otOCM2kn12wfH08U7fmFMAwF0OCOVMasQRN5MhqBQxJK8LZx?=
 =?us-ascii?Q?yzOnj9cx+X9BuQPragMipt2u81a564heJhcuq1Fg9obG17/8r9rIoPPQDAhB?=
 =?us-ascii?Q?AplYsk9NQ3hUwIPcuPok4ZPc+dTd/SJCMT4+DremcNlJEfQouyHmW1PmINxT?=
 =?us-ascii?Q?sch8yvcQX2UTdumCnuWVVdbQmtOtQF2duom4GcAnJk7oj/23F0lmNrRaatTB?=
 =?us-ascii?Q?LwzO06uGsIFp6AIPLWDMKRieFC3VFjLgPUF+WeUm/Cf+dV0dFzk2OlJ2ivt0?=
 =?us-ascii?Q?St2LnbXyccbNnYZ6pBfCE3p4LmVolM7I4O3nmS0Rd4bKEcOerAehzsAsV6/y?=
 =?us-ascii?Q?70dJrvKRQvevuynS64lqxmjq7hovCL1vU4g3ehEgRawsjAl5qWOTbK/QwDyj?=
 =?us-ascii?Q?tlcbQH+czEvlaXdoTWo4yPsvDZnPIcEssZTlQ/v4xTDjRqpw/9ZtBsocwJ9u?=
 =?us-ascii?Q?F/TskN52eSHx78+1kVgz2jcCfz/UcZe5EDO4/1yRxfe7gMsp8iZ+L+j+F1uG?=
 =?us-ascii?Q?YKCzc5o34Lqz3i908nV5XCMM8wainLQFLb5MHvrw/0G5ds81Wo/P7PwPYoa6?=
 =?us-ascii?Q?6RbALSP9BpQ3UQSAIP/IcAPF6FurG6rtiXFDQkQwyBJF21un1erJn3PyJAqv?=
 =?us-ascii?Q?xHbnL6+VP2jejZVY2bJq/G8C+3jQm0CFDX6V/UcWw4nHxKmzpSjQ3xlqdeQ+?=
 =?us-ascii?Q?aoGTCuio41NkF211WLw7oGxpmptmUFu98+9fv1YXndP4Rb/2IwW8GNM0oFsW?=
 =?us-ascii?Q?x4B4vVvvmD8WnaEwiUULggcROHFUuuINb0Mi9k6hTOStEwN4t7fAyUrOo+xl?=
 =?us-ascii?Q?KF8YCCV5MM78Y37Rrm3adXgXVrJpYNHVhApL2JFwPRXDy0+WUJS9fTVR2cUY?=
 =?us-ascii?Q?P3LzWf34FbKEMFc4BLCbt7ZLnjwhdYP9+UiTdqE6YZpShSdeiAlD48IyuJRE?=
 =?us-ascii?Q?jbDOcgFWo70cjYIe11aN/2/go4KXhKK62MY9oabj/Ut8yGKTyS9xln6kuYpf?=
 =?us-ascii?Q?ecONH7tobT/lA3eT3VDDNTAsCvaH7R7StfdgN224hPAPNEFtgNcVizCyDl59?=
 =?us-ascii?Q?8oQblrG4F3teXVWn+ScWGKEn8MhRV8yLD06FzVawJtKojB29D7T4F1QgzXAo?=
 =?us-ascii?Q?hOslt5+81JSjuwVnRc+GrNnwemx6l3FPngE1eQZKxOchdCcs2naCqUFl1CGH?=
 =?us-ascii?Q?8oUnodDpUu8EXZTuC5M7SNPGfYp+EujDY2jZ6pLKF55dNsDqX0h6VYkk25Vo?=
 =?us-ascii?Q?OB6ylqmOy+B2vc9Aoz15qa0F6t4E=3D?=
X-Microsoft-Antispam-Message-Info: K5cazk/r44EapeeUyyG4kleaXvpbDtBPDzzgQ2kV2mg6cDA0AzDDri0jLZ/yoSiiR4FZrXmLRFvDeMsdum8uC0woTgJWN9Akm0mMoazJa9MWI7V2NUwbXpidGLlTpJ9cukdEY1zm9MbtNgTHe+AOagFzkYpLyTEbVTk3GPYBSI2m7c94eAlKM8WJ0NahlKpQGFiLWziGFysAYIg74Dhlk6bPWfbVSDjHzXK/2Obj1Stpwu9SWReZzyAktTQ7zFPL5RZSSpef3Z6Ap5en1T58Ez+BTKAXqstY+gEVFcmer48DnVXZSWZLWdj1C2MMgZNjmUU7WdY3emVDzDbzt9wbjNSYNVZMxTs0gorQMm/ARQI=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB0999;6:6UNTySrWZThx13wBMqITcAFTFRGKI4rNGOY/2MwKc1pfkc26keCdV0VtmAd94rlBwzjLIocr09/2RAgGxSrxYgh97MSpkV+EaXlxx6hxvu2OxLeG/IYQ4DQ5VQq9cHq7iMwOLtbrGeff2vnVAPofY9rQ+UrSWJhglQqFMunH6PJExT2uFSWCvi35sdes66vViIW+gfD98hzOHN2x0qnRIbO8fvImTqAhbi4Ldy/4+TxylTxyEWu/iM2ObH7IO++X9Gc/y3LmTR4ptrO11fVxWl0tRNoUZipEF8+OyRsA7WER/2leS4p+du+r1nDFAiR/UNoR/TTTdce2OtxHHIAafg2kj3dBXiFaQwMTnh2YOPJwi26zd+GDnKdeeI9YoSyay5f8nTqXeyT4axL1HaD4UR+MPhGxmJ+fpD8MI+qnvY5GwsVaX5OQ3fnl0d+6l/eSWiAyBQua+bM2rzp67SwS3A==;5:EbamVQY9LqgHtTicCrKlB0VcErWb2SpeNaLbYTlT/2WsWOK9AjqHOd6u8ZodBAwxQheWidfwRgsm5b8H2pJK/yCaZP8/Zq/XjrX8tXDvBgNvwyQDpZqJCNdEBE5y5xx/R6dSbJvzf+n7uJ1k/u0QQE0ZB7N1bjyrW+wYf/WT7jk=;7:p+jw09dbr8CLSNnRYVyqEvijOFb8H3qQsAVSJZhBcoMOLZdxeGuMNdJ1fNsoFi7sk/YaG3sMGN4hxJqPRHz8e8vmW6RxH0TOPSdQTJO8blRPy7QA9a6WhFoCPqvBSzk9/L5AJJ62WIkKg6xGGNHXYnDy0Ll0VhD8qBT8/p5DNOe9vpz9km+rMeqBPIMSOxiu4a1Xh2UvuouGRwN9pLDtpu+m0BmPgQ+bFVP93mh+GXuB5Q2T3+DUapUpnsK5K6UF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 06:57:15.2164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e662930a-f172-42bc-654a-08d61dfd22c3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0701MB0999
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.18 18:15:51, Will Deacon wrote:
> On Tue, Sep 18, 2018 at 11:52:27AM +0200, Robert Richter wrote:
> > On 18.09.18 09:38:05, Will Deacon wrote:
> > > On Mon, Sep 17, 2018 at 07:22:07PM +0200, Robert Richter wrote:
> > > > On 27.08.18 16:33:07, Mian Yousaf Kaukab wrote:
> > > > > Hard-coded since patches are merged and there are no configuration
> > > > > options.
> > > >
> > > > Could you add a list of upstream patches to the description that are
> > > > required to solve this? This would be a strict definition for the
> > > > mitigation being enabled and makes it easier to check if backports are
> > > > affected or not. A build-time check would be ideal (e.g. checking for
> > > > certain macros).
> > >
> > > Hmm, I don't grok what you're proposing here. Why do we need a build-time
> > > check (and to check what?)
> >
> > My concern is, that for kernel backports (esp. distro kernels) there
> > could be various interpretations of what "Mitigation: __user pointer
> > sanitization" means. So a list of upstream patches that need to be
> > backported in addition to this patch as a requirement would be good to
> > agree on. That should be documented in the patch description.
> >
> > If these mitigations are available in a kernel backport, that could be
> > even checked at build time. E.g. we could have a sanity check if the
> > macro array_index_nospec() is defined. But such a check does not
> > replace a code review of a kernel backport.
> >
> > I hope that makes sense?
> 
> Ok, I see what you mean now, thanks. However, it doesn't sound much
> different than backporting a patch with dependencies, so I'd rather
> avoid adding additional code to treat this case specially.

A pointer to the patches would be helpful as the dependencies are not
obvious. This is different to just backport a complete series of
patches.

-Robert
