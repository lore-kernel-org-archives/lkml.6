Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAB5C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B0D21476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B0D21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeIMHkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:40:40 -0400
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:5632
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbeIMHkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtrP2aOJSIY/LAc9awN/5eQDpyr2Sq/gJRfF0LzMED0=;
 b=sWxWx3+8RHmKSTEGCUSAXUMhS9/BRwOzfRa+2MSoc1kF3h3PXCZQWZf1d4Z8Mo8Z2a/o3zHlUB0VCEHqutUVqb1DjUMtc4yBtcysn7+X0qifnVPvO1+jTeMVJORa8maEXdvPUnIFXSn6z7Fi/ZyxL5P3gSOr4LZQpQZzwp1PBzQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1575.namprd03.prod.outlook.com (2a01:111:e400:526e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Thu, 13 Sep
 2018 02:33:12 +0000
Date:   Thu, 13 Sep 2018 10:29:46 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] vendor-specific cpu enable-method
Message-ID: <20180913102946.41a43d88@xhacker.debian>
In-Reply-To: <CAK7LNASWfncdHRkRs=tq=TRaM+KUbb8bcMHMs8LiCgZzuFKCAg@mail.gmail.com>
References: <CAK7LNASWfncdHRkRs=tq=TRaM+KUbb8bcMHMs8LiCgZzuFKCAg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAXPR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:402:19::28) To BY2PR0301MB1575.namprd03.prod.outlook.com
 (2a01:111:e400:526e::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a6d37e-c811-4e0b-f205-08d619214195
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1575;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1575;3:+lcV0WeV5VWIP/9jKVeLqfJksldLWXyfXUQNeh4dtDHA6PJ3TCy2d3XYW5S5IIiv1NzcufqgO2groBecE8OQLS811zaSwDaOx/GEPjAoNsKgtyx6rVenoM3rkwQj3LO5eooIDc3DUCHcgLeuX4B6PJUM0CYgNOjpj3a1pfcU9LX0REj31FOKn146/D/MnHnczVKWSlDmvTsSt6mB9eewwcwHCy71t2cStlBJVSPTEblYmQke3XzTuYyL+0Tlujzm;25:L/vuXNIAiGIE3ACbCNt0M5PI242KZ02sdgrsH57BiUuHvBVDz+3VDnZgK3SGghrnSJRvpQpvKfLCoOmxN0bMSUY15/vmOYkrp9Vs61C+H0wUzOBs7vZp+IhSGVyhxbaSGCQcww5XRtau1dhxQFeLYgVtA9u1rl6ItpoW8TdjGvJzc8x0Oq2T1HzJPj4/bcjfvbh6hwu+QfJhW4FgL3E7hO8C+T4gDTO8rMM8u94QZpHAFgL0Dk6ytll8NNPasD5uUw+0b+PTR/wHoPrm9yYanvZB0ruxED5hHcJHZ3qFt3OjsiPmaoONyEAXM/+nQuGBdBeZQGKDTQ/xD4z734M81A==;31:ZRosAET6bpBUk9yQKhxF5c87D3t6uIa/Mri6c4PsDeqr4ZdVMMPinvvHL/hWlhCwF7hrLHvS8qTUkt6Tm9+WPODPgPOBiuwkYZXFER5Rrowr8QzSAgmxzlDZw9lEZ9+42SJ4mFW6+ZLV2ohZezCt6pLYcS9DamSLQaX+ymivtiyv/73t2f6+SchWFE2ySTnaE0hdyNNIk1JqT135xvgoTPKN+J6w+M1JpDMyxG0Z0AE=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1575:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1575;20:MATV385spZ4zdM5dU5Vw23vqtzMSjyHU21LAoo9QksGL8oQussHtH114hS45NMQTDpHI3epIhMGDsScTLRjPqW4+0KJCkwK4S+d/KSuQVg8WoxUdOAGt5yiRWDVg/8sjke9dW5cxhoc9QkupeyMyHe7G9ffL0z6PUYz+/BG7BTU+NTJw0ntL/oVxjM9bkQOdQsdNEg2ZC6rDJCn2M73vhxth2B6VA4TeHT0u5bbUIExhny192AcNrcN4KMCjYjldNb88ozfeme9FBYwqXDWYeRcMotClriqxMGhI6ibCjDXe5KwmyQlNa9Qsdhshm/7kMXr/pcZ4BmN0w9QzifpK4kMdgnqlkZO3kqrBZDQ6PrlLZTChd5liYNIT0aGs9L+g51bO1iJ4kO9CoeU6Bo4d5ZWaYsUs74jxZCAQy6Q3r6gBsNYq1L8nRg46mgOeAI2fXD5UMd/xj6fvb2+t6CdiA/xYvToVX/YWaTtpxftg4Nen34MrltaUILsrCFKOpJgH;4:kyWoM2L0hL+DB3mxJ0uePDWIz1Xh9NnDhPu/u14SqZ9ov8oejRfzcNBNnjQOEJDYBupHr4C15WFmvPia9zV7qkL5H2lYJZnJz7cs+IFTeCCy0Y2HQ7BPj7iDiJ6YHLgSs5XlPr0sGkPYdFDu+RnB5MeNg8YYAfgCwU5u/qhTF46k6L8GvM/DaeB1JM2m64fTgMJjQaLROgoq+xB/jj9uY3mQ6gn2LAmY2sYNcpYdm/XlmBQyTuKT/JGqj93wEA6Ly6LXyipvXDQmqWpXWu8SClEfuVMKs5Hg+qGrlgTFRN0TtGpyv4XYdh1iELfvWY3O
X-Microsoft-Antispam-PRVS: <BY2PR0301MB1575E22295148346BBB4E69CED1A0@BY2PR0301MB1575.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BY2PR0301MB1575;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1575;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(50226002)(97736004)(33896004)(8676002)(5660300001)(478600001)(81156014)(26005)(76176011)(229853002)(8936002)(106356001)(81166006)(52116002)(7696005)(6246003)(6506007)(186003)(105586002)(16526019)(68736007)(386003)(6116002)(23726003)(47776003)(230700001)(4326008)(1076002)(53936002)(55016002)(6666003)(50466002)(9686003)(14444005)(54906003)(3846002)(6916009)(2906002)(7736002)(476003)(956004)(305945005)(86362001)(72206003)(66066001)(25786009)(316002)(486006)(11346002)(446003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1575;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1575;23:PnzVnqvwgnzJXD6wM2FUxK4VQUrXbY56ew6CB/7?=
 =?us-ascii?Q?3+44r1Fx+w5VYayJZlBVCVrRv+VzF1J0nW1oT8Zup+yPLOY34HhkCtBRAQsR?=
 =?us-ascii?Q?znK2s0vD0Q1gj+2kJRM2QwxboNDt4jDGsC4IQCqL29JgrqrgiDyqZdEfU8GC?=
 =?us-ascii?Q?7nVXCgrpJojse0XPn50J83lHZhj3+GLJYiZUX+TLeExH7RtEZLE/3bJQteHx?=
 =?us-ascii?Q?E2dUoetrKHIeQBIWjy28LCEQAHN/wxlS/blDGvWbm1NONpYOlrosXETyhE5N?=
 =?us-ascii?Q?TBxlXnsItXp+wkS5jhw0Nx0A+S/wJOK9e5tFttENAqSU+YDji/4d45XaQ+2l?=
 =?us-ascii?Q?OtWMXsMFbBJRFo+fFy3ognfBpUTy0Qb993C/HremJdO0AisemMlTQxXM9pef?=
 =?us-ascii?Q?iRPNtED/kNL9UIomD6DkCYEqPdKakvrqah/b0xdvRx/sjNr9vxzYqlfez/aP?=
 =?us-ascii?Q?YrRwyVmQtgBSPIUnZbeMA9QlDzFDJ9u93sK/JfUplsQR2N/DOX5akILGxcNd?=
 =?us-ascii?Q?bkT0rdv+R2apkhrNKQRg61LQFuyHxwDUEr9zIoMRZIQEIjE+il/cgYMeb1to?=
 =?us-ascii?Q?F/J3avZuUqsX6y3BmNJnnUoYqnTMsmZ7Loj8jWvdSAZjFQXMvNpPy5UE7wpX?=
 =?us-ascii?Q?F1W0mSCu5Xou+U/0IQVBSseqcBrLCet8lxA9HhdonWWbimq39nSlGIFq740X?=
 =?us-ascii?Q?+U86LdJd+acN8anAj6tsnxl6YOVT9ehrw5ukbIgd2SzQZZ57G0qc7jfxzfvo?=
 =?us-ascii?Q?LyB5UqSZENWLaib0ajhEm9YIXdU5MGThXTFc4+dwC9ZCsJa2UefxNXCJ4poK?=
 =?us-ascii?Q?Pdy32hXjgRQs06xHun85aXP58o3iaUn6NeJya0vlsHZBzF7nzVgTp47bYN2E?=
 =?us-ascii?Q?0QR3hS30VpWK6WTRHxtvAjjnwrV10xwh9L1/MYsVzySYNR0JtsYbNqPWQqnd?=
 =?us-ascii?Q?/q0vouP/5k6ND57yTXhOm/Bd4+YPX9nVxgt0z8I0WgDU922MT/hE5WRlB8XX?=
 =?us-ascii?Q?QyND7UngMtEP5xVyT4vUsiTH8P1JrsUafDBtidqYNtqLpjFsbmuopLXj4pX3?=
 =?us-ascii?Q?Q2cggjIifYKf2iEr8mmqbWdBl0IQkNRhTMfKSz00HLtp6WXPmpHtGE76kLoU?=
 =?us-ascii?Q?OWqttRJchn/4UQF23pyJUKqtDp8PyqVP5Me9e4QPbNHra8/elFfDwJMt0bw9?=
 =?us-ascii?Q?mDS6YnR6AdmYlQqjHPnHe0jBXU8n/D7UcYkCV+qsc5gt2NCT0INpbkzhxD4e?=
 =?us-ascii?Q?Ogd/MLGSvMxZXOAuz7rE1L0l7jqwt7JQTHI26v6tww5y+Wo+5Juvdc3mY/UK?=
 =?us-ascii?Q?J7A=3D=3D?=
X-Microsoft-Antispam-Message-Info: F52mBaRxd0GHC22IXAI0Nl8z66ZKP0UWsAeN7ZpcPp/aWCon9NGJ2gUzyS5/iMfQO9SYX8/W8QZZJsVHsK6lHmIMb5SUD8Qqr0XV/KWealBcu42i5TUDW/YwbwviozdQUGCQ4QknmI9E/2XWBnPvn84bs8XFPOLlPz+x3uKAfU9+xPcK/o7HSGblrAI2DTqBNLZvwNAT+5yHMXqPHRKpVjdaj68VmbJH9N2F8Sorz3b/N5FJEiExt3OLAn9RupHXvsg4Z7soLEPeDvSMEfxHrT+nM49Yc5IxNZAUma+bJVazKCr73ao+V2nSlvQvKxjCshs4c0iF8N+580lnRiJVhVrJXgxiB531txo1ZBltquY=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1575;6:A1uBg44BtRJbkOowMDMwCIxeWbycTRNdxR7WC57/qbMdG3x+cYDh9e0ioaz5/CW9wFj+djez8xEFHQMdXSrbMqYIWUcuruvi0CqkV8/mzz4nhTnAKkhsei3fvlO2UAgy1yb+E5WBZQ9ePAsP3hghrhMOgw8D+ZBxnVzQr1tIAjTTb1hAx1cm2bDaFtNQm0bH80kj8kNscudyz0P7wSiMuej3DYczb+rgbkYI/KlCHHF37Y87X5QqD9wYbJ72VFyA6z04qdp6GwDKQRxfACgWmjSDF7jTX6c/vuM9D0RJouleANOpAN5QdwINMU+B4cika843rZtWCFrotGCwBvmRuo7fJP5Lpj3I6uOJBPAYTKykqnrtsMEyCtV4w1xVsyYmNbol4VsU1ieelKDuL9IjQ2CZtWcuAMtlwW5QhAES35TGzBCoOAC85/CXpJ7zoG5crnCCpXf56nLQSFzAOZlpwg==;5:/s39P6uCyhQIgg9B0yZrwroz8dktT+9Hr6B4okf5QmAMmBE2FIBkFkztMLVyqwrqIisHYLbpIjEs1xw4IzRB+9Y0lo86KVeChoTVUYqbHbCLyStF8VXL1zmyxRWDnwuS4FdZ5k+6HMl/5q7mB4G2m8gvJ/NloCukKcnchwPhiuo=;7:4d1q8geovVZoWFd90xe/AjF+9d2syWq29PPHYV6QUOdzDMuVIbFlnXkRAJyte8ja3CRuFAy5x/TI+GSmhBGOSshyRrd07SzCgBxjpQaoVapJe4P3grFq9qaNJU7EkfLhXx84jioEb3+wl50EqD9qewIdUSOIzOCzPzUdVJh7nMaP8p99C7rqRkRFP2j4e+c/irXzh7gSKRCMbscY4PS/QsoMKROuhQWCaHsoeh+LPktYLXhP4bdgls8s2RBg0Nqh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 02:33:12.7120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a6d37e-c811-4e0b-f205-08d619214195
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 10:23:35 +0900 Masahiro Yamada wrote:

> Hello.
> 
> 
> Sorry if I am asking a stupid question.
> 
> 
> For arm64, there are only 2 cpu methods, psci and spin-table.
> 
> Why do we still allow vendor-specific methods upstreamed
> for arm 32bit ports?
> 
> To me, it looks like SoC vendors continue inventing
> different (but similar) ways to do the same thing.
> 
> It is a historical reason for old platforms.
> 
> However, if I look at Documentation/devicetree/bindings/arm/cpus.txt
> enable-method properties are still increasing.
> 
> 
> psci is available in arch/arm/kernel/psci_smp.c,
> but not all SoCs support the security extension.
> Is there a simpler one like spin-table available for arm32?

Per my understanding, spin-table is similar as the "pen" based
solution in arm32, both can't reliably support kexec, suspend etc...

> 
> If we force generic methods like psci or spin-table
> for new platforms, we can stop proliferated smp code.
> (Of course, we are just shifting the complexity
> from the kernel to firmware.)

psci is good but not all SoCs support secure extensions. spin-table
can't support kexec, suspend. Except prefer psci for news SoCs
with secure extensions, no better solutions AFAIK.
