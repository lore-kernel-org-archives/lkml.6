Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D70C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691672064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="EGAwqNN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691672064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeH3CPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:15:40 -0400
Received: from mail-eopbgr710137.outbound.protection.outlook.com ([40.107.71.137]:21161
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727104AbeH3CPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dJYgnieZdW0AXrkfhdMZcVE8lPHSUu5FrrvUbZ2UY0=;
 b=EGAwqNN73N7+wSyqZ2I1vVIbaJhhaS0UgUWwhyS+SNkqW9nzOg1IJqFqtD7UdbjojU9wG53lsHYkFWDzg8BHzMSmKFN/G9zI0GRzIDa5QeShFtfCr+fE+RAxI+Luo4v9fysGUQBSYLF2XjIL+ltzbHcBWU+oPfW7QFBVmBKpEwQ=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Wed, 29 Aug 2018 22:16:01 +0000
Date:   Wed, 29 Aug 2018 15:15:58 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: BCM47XX: Enable USB power on Netgear WNDR3400v3
Message-ID: <20180829221558.bwaamm35cvgtfea5@pburton-laptop>
References: <20180819192023.18463-1-tuomas.tynkkynen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180819192023.18463-1-tuomas.tynkkynen@iki.fi>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:3:c0::19) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22d5b32e-7f53-42cb-55d7-08d60dfd012e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:5S8gxnzDRuUSoy4MViTTAXTZqytuHs2OV7NmO8DkhAKoLjU0AZhBhmyrMvAfxzgDXvOSN8NiZ4wRvrJE+D+mb4wdOYjjCwxYldC64zmAgrERDqoOAD/4baJilXl2VIAMGzfqkjPuf1f0yLJEWB5dZByL2RMsZv8fRj/A4HGvf0eX8Q+t0rlsxupT+ShTjDZi9ofUyVqIfeX98vV71bQSpD3jizD+Nd/7kSWe3/L7G6+0xj3aIfoL8vkKGEvqDNy/;25:6yMRPWhFl/Hp8lE9i6Xdk2n2dM+OJv+x//aXLS7MGpWr9Ni1YWMWUBz4eT9pDrsVEZZh5v7Fnc/2wdoQi91fphWYSBgFECFbjaOde/pMLepqgvWo/8eIrEvYA/2wWpp8EolIvjGkUOl8PEAgSPQKmMj9+A723pf0RUvjxxiWm415dNUPTY76fYo5lahvkVxU4S7P/AYoYxZzOcZa2QDq+1uGUWwAKcAJthNRbXAdOR0UAMUB4e7Qq/TjAroPoRINwlD2MZ/aO5osJPPy4toli18UW9LWZM6EORXT/yN7OEBkwdwBPtyCtZtXn+iUVbsQBXScU6sx9FqbKsiytxys7Q==;31:sFSTWfdAHY2JdA/zKAj/NkfrwFjri0o8pEwJyUIAunpIpGjTQ2b7wVQk0h0hlBJ4lxCVCM369QLKLGGg7FDgAVA5deB7r3OKo0xsNQUcXqhbO3pYY873PJ6MRawTT06M3NtqPkDpKv8kPL+2P5RBHbLO1JPyNesoANnTO5YNhlfw3fM5xs1T9Io+TB0mJnOM7hy751gQhCF6b1+57Y7VU/Z/jWSA+AjJrnOPtyKMBwM=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:mcHhIONFAeXpnuWE9wgRnPO2keZ1OlddW4A9n1UzCtmgAbB6IXoCJtNZuROHtg5RRlc9r95XzhO2R/+4QI9CohCWE+wR+FSF+c5TeaNDXrLvIRG+af8m03eS/NbNvNccRPKC9/6MDQjkYPEy7WNRgDp7W/gVoIy1q6pYWTF2e2j9kChWapAjKtmZ/P2OcxOpzECR3E9nuDPVmdIrBzn9UKEjdLgGyu4FU5kT1kVJMG4TX+CdB35A0uJnHvbImC0H;4:K7ZUQUI+xpbuVHS1Qk92NhS0I1qwj7wuuqZU0AbUQAVALCJBI5U9o/VOD6FemQCxB3Ks2ig9LGHAPgd+4nhNnWhieguPpzQwCg/eBhWt9JD74kT09ucindWCsMqWUv1u1ZlOMjgnbP2V2u8J41LrO0MdsG/BasNC2V8rm+TEwff2sxxvyKtFxHLlpUtl1B60uGLogcTVbOeAhkpqQL9zjDsTni9X96m/DkB2/YDTqKqVMtedDGXI1ckg91UsQVUPuPFrRj+GHXUI6fKFUZVcJA==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4933A923E4E89BD8F379E690C1090@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(366004)(376002)(39840400004)(346002)(136003)(199004)(189003)(2906002)(229853002)(47776003)(305945005)(23726003)(76176011)(386003)(6496006)(66066001)(4326008)(5660300001)(7736002)(25786009)(956004)(1076002)(44832011)(6486002)(33896004)(53936002)(9686003)(50466002)(52116002)(486006)(97736004)(6246003)(68736007)(476003)(3846002)(6916009)(8676002)(54906003)(6346003)(16586007)(33716001)(58126008)(16526019)(186003)(76506005)(6666003)(446003)(26005)(11346002)(8936002)(39060400002)(81156014)(106356001)(316002)(6116002)(81166006)(42882007)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:JU4X8jaCkeqIMwoNXR0+7gRu8IwZQ6BL83q4Pjw8F?=
 =?us-ascii?Q?fxm2dKVwjYADpkZL6f81B9o+mjqwXcvse8SiIDXyuNUruTsowrouFKBULBNl?=
 =?us-ascii?Q?5VM5MTvd84S2Uq6wKrfNifSymqmMm9NJMhRUeWovE5nXdRPAFX6MIKkGuq0N?=
 =?us-ascii?Q?phdZNWQcw00xgme7JbXfUaFzD6fhHZptIifrR51W/CvIlCR00P8/iwuG+ht7?=
 =?us-ascii?Q?qNh9+rnnZ1gLWr/5/SdHe7DlFgtnstj1YWKBpUkFvxnN+sypQW4El9GRRhWl?=
 =?us-ascii?Q?UIiqI5mLENsu1zE6Ne2gDkpE6fVtFbwLbfgpMRuf2yylNrdzlx4acEI1PWsV?=
 =?us-ascii?Q?lBy/e4bzLvtucptW25a5Py94BnXmQEAXhc/RXeAZ0vg4bp2SsX3fDtj89nkf?=
 =?us-ascii?Q?kgX8TLuogQpsPpt5kiNI/CFm0oemlX4RHk9WE8D/47dAlDFb+p6f7P8Hyfzv?=
 =?us-ascii?Q?qP9uaEAS6+AKA3BVXzfxb3y/uUAPDk8pdCtcDyii92/rzNVX/9ntrOgUZ4/C?=
 =?us-ascii?Q?ArW9aKMpxMxGPf6l7XEqrBFsrD5gBrc0vPzXi7jaIM7B3FyKoDd3YaWpfF0l?=
 =?us-ascii?Q?3XRJQJ2slGleHBRXKyy4Ym6yJtvnbWcftMEwsRNYb2ZHLtpL24JazeieZyRm?=
 =?us-ascii?Q?T44+BJsxQObyTvd4NkFA8PiJTSRz4JnQM+QFFVrIJ5WVSS+GuDuZEDhd98Z6?=
 =?us-ascii?Q?s5/wMNi3nGMusPmTA1De7FhpNgOqj92Wd1U23RRRtfsXMkKneUW6KGpbjkiQ?=
 =?us-ascii?Q?ozzV6eUZG2q97GFr8GkWfOMr536T5XvqWjZDV8eaNPEUtNWrIAfzJ/xYvVbT?=
 =?us-ascii?Q?svfG0tcgdVNN+gygUcp6HIdOWEs02q9gaUFTl9n/2rA4v7ceJkhOZlyMu7KV?=
 =?us-ascii?Q?5XAgH89mNyJarhbpC9PWMuUqi9wekSbKSqEuw1TaW/LM9VemT7X7KY7cu2l6?=
 =?us-ascii?Q?0PXKbgNqIU5P86y8MabI9D6w5IkhdDqtgtyAEHTq359krwAN5Mk5ZL8gfLTf?=
 =?us-ascii?Q?Gol0xLchdMQ1RJsx9kZs+OHnB5xyyGG3QSuH5FIQtCyYfSEJHV3ey8j4Xjt1?=
 =?us-ascii?Q?nuJUjGObrlhx1tCXbo8BsX+FLpPdhWVYaFUCx68Dmuw+fy3t6ApquUDRNw71?=
 =?us-ascii?Q?vrvI+K5cXKGrF0H80CZKq/7zeJ4SKMHpKd17rNe/Kd3WsudLoDcU/xZJhErt?=
 =?us-ascii?Q?9M0Og6FPMyc3H8LHQRRlo5LFhbw0XOFr2cizsZVtvU9j+WAdPH4ucNHn/ww1?=
 =?us-ascii?Q?kat56rWR8kglqDrz5EAH3hHdVULWFLs588CFitDEvg9tQFizqv2O6nnDtDiE?=
 =?us-ascii?Q?aY07bKIHih9z/rKJsrA4UJojLHBud/2EQu1A1oGpsqfmp0lJC2BZUm0z56vT?=
 =?us-ascii?Q?2XsxA=3D=3D?=
X-Microsoft-Antispam-Message-Info: TeGy3Yg40MGhX9+jeD5XmhaWR4C97tY1t/bylBMWiwhlJS2Kn7znp6e3YTS1j1nHFcDMNaGWEfV8HsF8l82h8QWvyIgcr1E8A4MC/WzJMeHT/9j0CKM9L8aupuEP88mS1/ejUBp+fgPMQjmPLsiJymmbaZYXM+39+uSWGDxsTz+vAP5hMjuo1aQBf3VwaJMXHt3wQR5W6AImD7eblMV2DQI/7AcU7Pd5AhYSarbeHXA/Oj2mbJps9kGrN86JS+5IiTL5E8lK/Jre+1aWlCCM+To7fEs2uof0I39xgf+Hu1Y+6kk6afq+zdrkc6w3uxzhlLMMmlIoctNCpw1mgGLu+QYXxqYbX+91ONlSIucr10g=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:75n+Zm82yRZXHs/fTeShYFld5AI4cyoaT+GSvYbTby60iX2xC3LTN9i5Zn/ow6LGr2rTYLuCPpqvxPXq+TX2YwR/PB9EqkStZS3zRQGUX2w9YtK7INbAcdWib0fcZSkgxYMcjdmuxdOQgA1t+WwoUP1YuRBzLzcz9c0y99QwIfVgwvelEahOW8lFQ1csLOMXSqu54RWBICb9/T+yU/VuDk+wqcphYYzoIhxbow9FSbc8qEw3+l2Ei2z6X+KIxbj7Tob3tZBLCMKLy90hs7wqc4ro7DBQ9vb1/Dnqxs8hnaYXsHlM5aCxArUhnGW1FWjm9xm+0A+uyuG1ywJIXXOe7h4dSv0SaaT2kmdhVRfOEMHnQcbFJx36QXukBH10PlNbjQVbsr3Nlyo61Qnhr3AgGxGwWM06rZBlAIo5J+QWgGGUUx9UixxVSEz+Z/d1m06BdvULfK2wwS8ddJPcoVt2UQ==;5:xeUvCmqkGwZJsbESTrat5TPO3q88E22ZHX9A+kkjg7N5RXTgB5GG0BvSCW1mggaWZs8iFuswvaChQvqAe+Rc/6hndeHkWDr+4i0tO7zilZIl8M9OT9tmFQAfvb1BaosSLFLKM5LfctRMAt5TYLfI3CMRaVlKqZ/zmw3XWIAa+JA=;7:hns2qMfOmaLEgKYNZz2OrDErY8bm3EpmUOaV4W07Ub2z82RqZf0fY4SHqqDQt3A/Yk6TtcRXeHGyLGH5toD4+7jx96l7gQTKnJG5EkiByqKIAmMChRu1VgWf3U54FU4akcPKmObEqA6kAcqF391IIQv9nvCXozi0kon/QF/xmFesAZR42dhFWQ3s4IZA6IHEonBSn9wgrt6sbRwXARnO1QHDb1ST4kWiMkL/PCeFStyxTSOP9l5jUPfRn+x28AWo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 22:16:01.4860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d5b32e-7f53-42cb-55d7-08d60dfd012e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tuomas,

On Sun, Aug 19, 2018 at 10:20:23PM +0300, Tuomas Tynkkynen wrote:
> Setting GPIO 21 high seems to be required to enable power to USB ports
> on the WNDR3400v3. As there is already similar code for WNR3500L,
> make the existing USB power GPIO code generic and use that.
> 
> Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> ---
>  arch/mips/bcm47xx/workarounds.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

It'd be nice to see this stuff move towards DT, and configuring a GPIO
to enable power doesn't seem so much a workaround as a normal expected
part of operation.

But I've applied this to mips-next for 4.20 since it doesn't really make
things any worse for now...

Thanks,
    Paul
