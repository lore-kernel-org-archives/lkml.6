Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32448C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA322064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="hyTD9KYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA322064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeH2Vls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:41:48 -0400
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:40698
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2Vls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oADzQV4zV7dFtUOn0R4EC8P+fnjK4rmk6t0VEvuZrP8=;
 b=hyTD9KYXjv2g1zGhWXF8H9OYO6+i9auFv40qUAJY0UKZ6VztqjQdh7CrjaD8PKRa2fY94q8cNJx6MsExB+x0kvLPevRh7DoiDjvWsf0T1ttLTcM0Feb0/TbU+owpeP37lBDFFiGvR63b0mN4heKMNiQYsMFaYXmkEnbl4y2KHQ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Wed, 29 Aug 2018 17:43:44 +0000
Date:   Wed, 29 Aug 2018 10:43:41 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
Message-ID: <20180829174341.nbcebor5herksvld@pburton-laptop>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-6-paul@crapouillou.net>
 <20180828172305.bohg6cggnzm3wsuj@pburton-laptop>
 <62569807-7be8-51df-4683-82392224432d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62569807-7be8-51df-4683-82392224432d@linaro.org>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:300:103::23) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db5086f-1430-4742-5f7d-08d60dd6f7d4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:D7LpoHL518gMzRrb7+F1MM5pE1atvKsnqdo6xH3ia7BTNLFPKsN8ndrYtI9c7ezAQyW0R+RSVYDi/rvd1ldTsAZJsLMtFeNadKV3PkZbjDu6Fe0kPhIV7agnLITQIGw1SdBzONKLdcJupPAsud0WVUZa6c3SHoBuauaLfIVqnuEReQQnHMlUhbvywqLWY9gif0cOy7veZzIxV551Irswd0C+u2B+aa1ZePjKneLVfdkXdzuAXYGJJcztKfoWvuLT;25:YxH4rPfzjFVsR9JstI8DSziFPb7a+i5kQiWJrQz9RnJhkPQ3Mzo5rXrA/J8bnSnGRgxPYfdB3TAWKOgNZg2363Z1Fr/33vpueJxoKK4DIdShoAQKSNFqyY5jLVoAVdvaRUtlGUfzicqaZimuJA5TYJeW/ueBa70bH8jjamgGOJkNW/s7TOuTsaknhdiRqt14sW0EGZPwhTI3jMlUBkSuVy7+8D7HYyk58yNWZmS5z3JMYaBFfRAqVh3dje0eCZZuG3TCQM3yj9vjy43eKzvscW6ze/eROCpXwXTPKA9HIt9QcSlgRQvdn8d4gstWlmH2+6+WbWPEC0oEgGFDbi8yeg==;31:1X0iDWIh7Wovu1Nj/oI7YFh6A6SEsw2GBuSHSi+qz3an6IVAh7YoShq+opT+aMWTJrisfhfEMt+iz5aCOdJeSnxnSIRjL8YXO6VZuq7meJeu6qelzASpTxwPgCIByBmpNw1/zgRGCeWKHwUP81MtVG0AUzzYjNn7Uelc4uCnxUE89AvauS9mC+hd5LTXIpiXckv24UJ2yYkMQfiwBlopzBuswHwQhhb+QiKjPGkIIGQ=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:232CFd1QNBtOYzaax/mwjiKtxPKgt7LyE5mO4ibqZ99TuKQI0OaPIKrJ+/Tykz0LHCjuf2iJZOw9+O57s/MG7TtjaJ9ZNHzYP01pc2oAwW7n8l9mabpUsfiwH2jVA0QC1rZF88jlt0RQs6mgCkXYkJGPgImuoDVdFxRV0QV0YcJNzB3XIQUIDGT3y7UFHoN3/R44LP8cy6kQNFrI3opMeqlYtf4ZRWcdLPKIM6wNL8PyVr4oOvqRrC8Crk211xKA;4:4hn3XLlbTEglOyOotO59/AFUrKirU7Z8NlKCLsDrYEYQxC2iIw78iSerybudgZtPKuQDHrSw+yA2UPTy16SC0GCEg/cfH2lRgzTlN0LB8E3SeKG3iM1qJB7zDZLDV48kxkOgi8qWaCLzUoRaddzEJJvT2cJwwueIcnYvl/WYR7gUWEErwopSEVuQobK9CVk7ytDdp9vlaQgP4/2MaRzyw7/gBMyvV9L5JEc4Oda0RcHCh0E9Ypj/a5oc9LEb/1tW0s0X6GxUxLvRP+TX8kbsGA==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4932EEFCE4A62D019B13ED08C1090@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39850400004)(346002)(366004)(396003)(136003)(376002)(51914003)(189003)(199004)(478600001)(6916009)(53546011)(386003)(6486002)(54906003)(53936002)(5660300001)(14444005)(16586007)(58126008)(6666003)(4326008)(9686003)(25786009)(97736004)(7736002)(6246003)(33896004)(6496006)(52116002)(7416002)(93886005)(305945005)(229853002)(76176011)(50466002)(76506005)(39060400002)(81166006)(81156014)(8936002)(106356001)(476003)(956004)(1076002)(33716001)(23726003)(6116002)(3846002)(2906002)(446003)(47776003)(68736007)(11346002)(16526019)(186003)(42882007)(66066001)(316002)(26005)(105586002)(8676002)(486006)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:+e5KPORf/i8ZvFw2rifSdYrWySt9E2zZrl8uA/uqx?=
 =?us-ascii?Q?xBFI/l28/8o1aiqLFDe5e+uyNhAVrcSzxH+uJjVXfO/mjRxMxblrgRj5Ogzb?=
 =?us-ascii?Q?0Pt3P1MLF1W+HXJw0VhqYjcA3N7vE+0tz8NA6ijCAzPhk3BqOt9+zntT6Lap?=
 =?us-ascii?Q?e1BK9Irc4LeEG4ixk1XRSbKCHaQUrqBAxMI25NnSGGQ8yQMqJtkUt42D1gw2?=
 =?us-ascii?Q?TXXhlP5ItcMCO0h6CzSxdbp6vSU+NdElHPhIglifJpObol5D/icNHHhV80r4?=
 =?us-ascii?Q?sDMCdAjqZaXM7ET/SEGQYLoqVBU9BI7UNSVVNLiWj4xt45NmDykfJkw0r6mJ?=
 =?us-ascii?Q?AMfXVbONRefsBRweq8CP62UKjivh/MZ3h9n3g1lxPk+jDSVPegfftHnFZwUj?=
 =?us-ascii?Q?2XZDgtmaLqlREmkpFuSnfGcfy2ZWe/ppyY7IvmjULhpHZ/hzprr1ewS3Rkr0?=
 =?us-ascii?Q?j0w1bZv54we0J1dfRUqyuj2EfHQWKccce+cLqlliTDP7h+btOL0arm305kgH?=
 =?us-ascii?Q?sjGkDgpSK9YCsZ2tLI/ZuGPv5xu3QtJF4GIe/Kbjww5xNFr9rdoJCkeiDzjD?=
 =?us-ascii?Q?YHYcc35FC8Ns7O4JUs5N5uO1+NVWicTavTtNPWDl0zw7lZSPHnnkdTidMldb?=
 =?us-ascii?Q?6XtGixM9LODvJrxqigSlapFhrJedNNA5Pck+rTWrZuO/ZpivreQEDS0nPeuH?=
 =?us-ascii?Q?J3cYgf1Qkp/5DKrvdeNmUZCF6KwqRoREtMjxENiCIR5AZ9Cci8mNxo8UV4Do?=
 =?us-ascii?Q?E6C6O4L9jHvE+97GQ+rGShW86VgH0CrUNcDuqCQo7IKV3Ot/Q7meuQR6uQiP?=
 =?us-ascii?Q?uXtxTsSW7qZdKSHRlpqkJdJZ9AkykzpQ5R8OP4E2uYhC9Rdj/7SkHDuPQzxL?=
 =?us-ascii?Q?oxLe4S8bq7Vaj45nQoXwGljextXsBeSQsKaPQtJumdJRsGUno8m8xwnjr6uZ?=
 =?us-ascii?Q?x15fIGCsIvy88mhUfpAhcuCFGaIZ1Z2C93neP9ZGJTWONEBc0Kmxes5D4lRd?=
 =?us-ascii?Q?4u3jMQq4yj+ROhv6Y6lAOEwpY9AlauXOnUNN3LnVCBamw+rgIo5aYzI6K6T0?=
 =?us-ascii?Q?WvlmfsUh+foEB2gvUsNTABH+WJbDz/Ytvm4UBM/fX9KWoq1UuG7mmZt7H+Cl?=
 =?us-ascii?Q?+Z8BnboDsyqIn5MR81UYelV/4fYiBFF/fXTvDxzmCH0GqQtIUEJD9mnzlDEa?=
 =?us-ascii?Q?x5spP9D8lqLFgYq04fM16sTe4HXb/07YsHeloJgJyU0Ar3YXhN1Uj8FVHoNo?=
 =?us-ascii?Q?NoCP2EY7HJ/DUNC6hRPrNoUOamX5gX41WYrvAN/YifMPlm0BRDo8Xfo6O1pu?=
 =?us-ascii?Q?xhfkgZVAX6QzaDR3NhMyTYMMp65Y4vZfck26L8UTjArUickGVFKPaIyJBg/A?=
 =?us-ascii?Q?2oAyJjx02FkPPFxjefklXChjnTTi9eIwS1MkcPmPF/hQCgBni9NcU5NlY9Eu?=
 =?us-ascii?Q?fjvGciqbSaqVZYxmx81tG2kC0DmUrg=3D?=
X-Microsoft-Antispam-Message-Info: c2iEtF+qBWOpLfsJUoxdY4I5N8u9URRU3gHoY/08l1U/9cmuM7xE3nXTi9yjnZ4YxmmPHDYaDXwsiL/J2YMOY+PvlWHdpDbLokkCiJSLA1j48UIYJEKUPOlM7gVCyUtJvGB3bVdFeq3IdZ+S0C1i9VNGgNkXxrB7gIMEVSEjGr2WdzKc2+YtspeOprNhD5SliBNgq7lT0R+REkPoxBwoG/xE32rS3PvBE7RlFt32xOUYuNjhTW9ahKvfcl5ailgo1pEQh/0xiMVXrLHWqYAon0Uwa06KdKwiSHaCbNzR3QRjwHHV641xPVUlevDLh6pdbAPfrbjzyajTBDEwSbejYTH6ma7eW9T5TzRNe5Gq/ag=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:qNBpz3cr8XUOrAMUzZcaWi+oJrb7VgmhSPH1gfJNnb85XcDoBqhRJSqLwNoGZIztm7xL2AoOSx8RwhziUa+zYPp8PKmribf1OTdNs3xaxTs/SSqhbloy2vPH1k35wdKN/z27u98Df6Zg73Cd7yW9o1ozl24E3tOgKUyZ5iq1z7A4IdNM1tSKyOh9uiJYAwDmhhx180TPz+59BydtaHvPdvrQC4/bduT/fsLyA758IbRtEvOZ9NqTPIf1Se/8DBmWxlYAjMfOx/vgKyaz4BUpLdOTd4G0XVX5t794KYCu77u5UU6dSoLF5shNmOIfbDjSZFxxMQ166mG6fOy9kZUwAlP67+Ac+7aXabcn+avWg4z7bojqNBMB4CqayWDspPTa0sdWxkN1sF96Pt4OpCUpG4HBiLakdrci+KEs9rVuSy6NAKv1YLlsMgHjCUSxFTPLY11GzwxrAJ0ocLKbEMLB6w==;5:iyZamDikokg/+QScLJYXu5Fo88hjXLcLJSaHCGMuP22951n2TRHitNFyuw88YXmzv45/+H5ZO6/XK3R2/4rJzstg4b+5Esk+2HDO84YbM1u1iByt0JhAnPEVJ8poxyurASKd6dMCm4DwhnuxdSuvUPfgD9D9ubPuHsyMcYD8cR4=;7:W6wv12iHchooXc6dCgBGDoJflxO9kgiADd0aIem9HCqkz2TByMqh9jwPQnVnCe+jes4N1EmhXIrE3UqRN/KFXYgrRnwLcW4Wr8ethuMg5UxaI/eK60CH0bi99+H4FkIije6i7EH/PHV68LeC17d5GmxWXhxCBrS/t8WZBsni/rdwqEFbptTauSJIbLJwPbK2sT8MXn+D3QZOA+ux5H7SI3L5IAsApTsZF8RONEDm6zGavAUBdZMzi8xvPqlscoX+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 17:43:44.9212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db5086f-1430-4742-5f7d-08d60dd6f7d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Aug 29, 2018 at 11:10:42AM +0200, Daniel Lezcano wrote:
> On 28/08/2018 19:23, Paul Burton wrote:
> > On Tue, Aug 21, 2018 at 07:16:16PM +0200, Paul Cercueil wrote:
> >> This driver handles the TCU (Timer Counter Unit) present on the Ingenic
> >> JZ47xx SoCs, and provides the kernel with a system timer, and optionally
> >> with a clocksource and a sched_clock.
> >>
> >> It also provides clocks and interrupt handling to client drivers.
> >>
> >> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >> ---
> >>
> >> Notes:
> >>      v2: Use SPDX identifier for the license
> >>     
> >>      v3: - Move documentation to its own patch
> >>          - Search the devicetree for PWM clients, and use all the TCU
> >>     	   channels that won't be used for PWM
> >>     
> >>      v4: - Add documentation about why we search for PWM clients
> >>          - Verify that the PWM clients are for the TCU PWM driver
> >>     
> >>      v5: Major overhaul. Too many changes to list. Consider it's a new
> >>          patch.
> >>     
> >>      v6: - Add two API functions ingenic_tcu_request_channel and
> >>            ingenic_tcu_release_channel. To be used by the PWM driver to
> >>            request the use of a TCU channel. The driver will now dynamically
> >>            move away the system timer or clocksource to a new TCU channel.
> >>          - The system timer now defaults to channel 0, the clocksource now
> >>            defaults to channel 1 and is no more optional. The
> >>            ingenic,timer-channel and ingenic,clocksource-channel devicetree
> >>            properties are now gone.
> >>          - Fix round_rate / set_rate not calculating the prescale divider
> >>            the same way. This caused problems when (parent_rate / div) would
> >>            give a non-integer result. The behaviour is correct now.
> >>          - The clocksource clock is turned off on suspend now.
> >>     
> >>      v7: Fix section mismatch by using builtin_platform_driver_probe()
> >>
> >>  drivers/clocksource/Kconfig         |   10 +
> >>  drivers/clocksource/Makefile        |    1 +
> >>  drivers/clocksource/ingenic-timer.c | 1124 +++++++++++++++++++++++++++++++++++
> >>  drivers/clocksource/ingenic-timer.h |   15 +
> >>  include/linux/mfd/ingenic-tcu.h     |    3 +
> >>  5 files changed, 1153 insertions(+)
> >>  create mode 100644 drivers/clocksource/ingenic-timer.c
> >>  create mode 100644 drivers/clocksource/ingenic-timer.h
> >> %
> > 
> > How is this & patch 6 of the series looking to you from a
> > drivers/clocksource perspective?
> 
> The presence of completion, mutexes, etc ... makes me think the driver
> is not going to the right direction.
> 
> I have to review the drivers again but it will take some time because
> I'm returning from vacations and there are a trillion emails to sort out :/

OK no problem, thanks for the heads up!

Paul
