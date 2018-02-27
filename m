Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-379639-1519703596-2-18061924268169775862
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CN'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519703596; b=ozhSGFdo1C99Tac7Innt3PtSNYlsmKAKxNn/kSMfjWzsiCP
    WlF8yRzsc7l7Tuh4eq1IPRL382rfp0arbN/gfdxUki0ltKRiA83/Avt9ght/l9nJ
    BSpMPxUKKB2Z3dbQ3seq/XRD+I1Lb6fVxVdduv695wr+EBzUM021jGznqUkqVwBk
    e74/CG45PaeN7pT5WqrhdD6ZkecFXwJj1S6EIqNfZHi2NJUClyUyXoOwlg4XFxDk
    ZM5gvJxZXufYgyNpKnPR1hmkb2qDm9zCn35zslB8VHdeo5TANclsvMUN/0K7sMFA
    xCc4lxbsjJ16tyGV8N6UTh6XATbhFBeOHwrK0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519703596; bh=NR3POnThAiXYBvNytWdHA1EGRwCsbFTvoDY1vtJuMHg=; b=I
    qyHZyIvD0PJ6FrxfomXfPueCViUSmS1dwxPupvm5qwjBnFVIZgD4FWFZ7UIFLvEG
    HE2kK5PKBmVix9h0F5j3IuxelwNnmDy58QrTB2cXG2T8q0dJyggSUPa8FS/deJr3
    DCSiW3OllTKzzBDDq98pmTn6pFTRT17R1tI1ShjxfsySBFW6ziveXnk4CD36lo+X
    4BHeasChT7YQohLSMURZAHVbIpNowLUs9W+emOF0kA/669Hq5p79mVWETykD8IXs
    aSMqffzFcxHdl55k/t9D8Qr2VVSUUGMJX+5gjGKWEWhxC1CA6RJAOFEzczrGdfJg
    eXTcszwQdaqOgliAzF7SA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=GzYrFAXZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=GzYrFAXZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbeB0DxG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 22:53:06 -0500
Received: from mail-sn1nam01on0062.outbound.protection.outlook.com ([104.47.32.62]:47664
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751582AbeB0DxE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 22:53:04 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Tue, 27 Feb 2018 11:52:43 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Evgeniy.Didin@synopsys.com" <Evgeniy.Didin@synopsys.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation
 for 32-bit systems
Message-ID: <20180227115243.7ca84b3b@xhacker.debian>
In-Reply-To: <1519676841.2997.7.camel@synopsys.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
        <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
        <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
        <1519658060.31245.4.camel@synopsys.com>
        <CAHp75VeJhHWhxc4DBiqiu4n6raXbNQ0+W5YX_jthQd2OFF9F=w@mail.gmail.com>
        <1519665265.31245.6.camel@synopsys.com>
        <CAHp75VcABGN+awEUzNiTAc985EM0XVS6eiNLGYYD1_vCrRC00Q@mail.gmail.com>
        <1519676841.2997.7.camel@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To MWHPR03MB2637.namprd03.prod.outlook.com
 (2603:10b6:300:46::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65af8705-4b53-486a-e7c5-08d57d95989d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR03MB2637;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;3:gMH/lD009Lbm+GgOW3GHtEjUEJnWkGZGHCZaY9Zz2EjMoozvZboiLO9fb/D5N/N0IVzGydWB8B/0UL4CmSuGky3LB/+9yr/aKYFS9zhlpZLB+sRrwKbgaorxORckDpev7PqrvfQBxx/qSwjFDIBOXZ88k9rjhICETtAyk4KQvoblrQGFJCnKiPcDkb5dU7EBm4nXkguXYv7vAipiBZSwM13/UBwM2BTJJ7NY67iOUSjlzv5uau25HzRg6jXJsPbM;25:VX2GGY1Q6eEDO41rHHvi0ElS34obQ7mAT7EEfX4JwpZw+T/5u8zANlDCIzXRx2sRdgtMNToW++TSqgPaAumQdnv/5yEpjlIQR+nzUp4lWP0jo3LJ/06KSWDE57fuf/TfCFe3nM4ggLsO0XVm5Cas7U9luO2XkigFg/mryuC8RtmQg/PH1m/nxinGHOLAl/x8zPZOKC/T2mD9rwBVBXlG+A+DRdttQfLzaFcHqiFsxAZZkS2uIJbC9FLs1M8b0msZe47iv9w17eYYAWS5oZHJM6Ek7GmtpRHaRyyGL4/rsLLC0hwrwOievB8dIeLz0AEPvloAKx4QHoNfimC+vP/mvg==;31:5c93vwtvdeDhR/77z2HbgpKKSe3U68AkWdl3r9992UUbLVELfkzkZrwEoF/lsB0yudmwBO9w+jV4KYYrADQQEv5EhjJ7wV32dxI/qwVlvla86F0vwiMw5HJpCkgrp9Q4OlJcF38Q6yKyJtahahGMlLLZYLklyOZdYbVISsvCQmX8BLLkPDzhlUWRjv9UkKJzre3r3Ubn0zl7o/c9RNXOU4Fdlyn92c9B2I3Qm11uNUQ=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2637:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;20:oLpDzj+1wF00xWDtVyjj0b5GMIdmlSHDSnaH26AOY9zz9vJ1dDcKyJVMm0AA7ov+pPay4DNCTuI5YQUAyK8AqBQW5W9jQO/izZY+AHH+001evtcsxOFLiqqZfBgo6AMvOaeJu4i1xpuVWZ0mByRReWlsvardZnv3F7GL6Tx5qYOiI6AWOWEK8s/oQo+i2exv5YvDPmye6lB+lLA6bCjc/ARt9S6kA18GOnSRCqSDyH19O5/9MN5g8sdXOblWuC00OPcBSISeAZ/z8mKBYl81XQT4QI0//UR1e/xnvGnKSMIKjQD7nVI3wVsA5hm2SaNKVOuXFo/7lW7GxqEdhNnbq39f1HHfWftjF44rp6ZTZeJCArtt/fLdL4HoNi2NKOFb0KBLACmoUeOBbrzNg+QWnuGU8WOmwcY0ZpZ4MEE49f0=;4:JWTf4dp41L2EexctaZxSVpWil0KB9g9hH1V4LERKWWQJ7UfCegqlAq/AVXlqMZBGvIaYddy8MRkjxOqZf0q3mXPs5Ge62eWNrA6l+G7Uz0FVSI6rNuWQqEqoHqIuRKMBj29qZFKehGhpgjQhJMz8Is2QNZr2DBg5gE9BpjUNAsfUfz/vfaitKgT3EMEd796n3f3hOLBPYV2GaVZIJUCzymrEWgO5bjl/4pMyfxA3eRv1uOxLnMNCD+sE12nTT5hbRIiTIPn+N0i/ihJicOhDzw==
X-Microsoft-Antispam-PRVS: <MWHPR03MB2637C6819752125F6E8DE43FEDC00@MWHPR03MB2637.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501161)(52105095)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR03MB2637;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2637;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(377424004)(189003)(199004)(76104003)(2906002)(4326008)(966005)(7736002)(305945005)(25786009)(55016002)(6306002)(9686003)(5660300001)(6246003)(50466002)(53936002)(106356001)(230700001)(229853002)(47776003)(16526019)(97736004)(7416002)(86362001)(39060400002)(6666003)(1076002)(2950100002)(6916009)(3846002)(23726003)(6116002)(76176011)(33896004)(81156014)(7696005)(52116002)(66066001)(186003)(478600001)(26005)(54906003)(8676002)(53546011)(386003)(6506007)(81166006)(50226002)(105586002)(8936002)(68736007)(316002)(93886005)(72206003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2637;H:xhacker.debian;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2637;23:kIh8lmTTkUlZGl5CttxSO4C6n7XGkkgiS6zjrgeTG?=
 =?us-ascii?Q?Aj2Brpf5oRpYkZv4/dTJxJsmWoHnucBGFkDU0a0o5nZfJYlWPr76SKyInfPX?=
 =?us-ascii?Q?AxCAngoIcHsMKRqDMWcNn1XXYPRSooAXFnBj9aUxs0kfHaQOR2MQS5BaA3ld?=
 =?us-ascii?Q?8w4VQyGVoNcFxTONfDhKE8ILBeA9rS1MqUudEKJAR5mWM1D7LBaF+ur7kC5x?=
 =?us-ascii?Q?wIFbkkBkwcVdZNxF0r+cmlXujNsqW31pRGu/bGeB+LuOnKKe3bRTEQQ3UW22?=
 =?us-ascii?Q?NjqfYDwrVBhWkIoaCZCTopwxh3anwvxHU6gV7T3viM5PR0Gfw6OKX4JWKhGe?=
 =?us-ascii?Q?aqImwXG6DSJWOA6Fn+8vRbgmkUwo9Oj8rDH1N0wS1WNEmZo4/lEd8f6TIFPs?=
 =?us-ascii?Q?xiaRNYZSbR+BECSgbp+SDmm02rCFPMiadRLRNClO+ZrFSY5EDColz7GBCuhJ?=
 =?us-ascii?Q?1lOI1EOU7aHCkuoaM3FXoaXqvcrSBZ7nsIcCIXex5SVCXhcCjQuojvsVdSZe?=
 =?us-ascii?Q?MfFcdcWetYjo7FWiWsG6dnzOxhMjdBAhi4Q2kiwAu1a2PPfPWz/SkTwaMS7Z?=
 =?us-ascii?Q?BhRuX4w154SkoTI7THxkhz25G8y9aaGdXkSUu+ST0ECIvuXoDrxgPAKFzcl0?=
 =?us-ascii?Q?bqIveHTKWCrFFtaBw9Y/29MkkXzhWObTse25jsgbkByUavtMnZ7eOEqV6o7R?=
 =?us-ascii?Q?K0+8U13xgq46M4KIUjrvxMrwHZPtx6Iw6ankQL3c1lp0CD6aGbKSSGKOkutw?=
 =?us-ascii?Q?WaG3PvNkMQGfv/XVCmp4vYQiTTpFGT3OU2V8/Xq37kTS0lySCmgzRE5rd9Fu?=
 =?us-ascii?Q?Du4I0oUtRRwUGtCHwvwIfks5rjnM8+KBMKzsQixI6K0/X9BwXY2y9GhgXlno?=
 =?us-ascii?Q?hmqYbBMtoLheBf+xFiMOnzzyi79Ml+98nUdFo6WtrSfPNvpEXfM1jNkRagUW?=
 =?us-ascii?Q?o3FpzUK2n/kGUwBHvTTcFPq4PJ3H+Y2qAwk/8WjOg2AZ+1sTtV6vRaxGCyEA?=
 =?us-ascii?Q?UpSZ8wQ6BG8SMYneCfMH2txN+e22m2vCqe3eGNd3A61jNyOX++QghwRCnKTN?=
 =?us-ascii?Q?28OGEMagCX8Ut+JaHLvksQqj6g4FmX3ZXYT0f5v/jc9F66hRkr81ZNjsFjoo?=
 =?us-ascii?Q?Y5Fq++oXNSfoxKgQ5yCHn7Rfe+hQ7J3J0OSqagBRWQhFDKQIw+QO83SOhoVA?=
 =?us-ascii?Q?gst7En1LunDkO1st/FNvq2OP0WiffK/cGIE+/lde1udPn6WNyU0QOmh9d9LC?=
 =?us-ascii?Q?c2rk6VsSSQt4FyoIzBIahMLSWSJ9b7jlmz7xx+jvzmrfy2tYBcAwkSJZbI/1?=
 =?us-ascii?Q?S/r+F3JTUu3vmZfJS5ENTccJntoChgWcGwNXtlDVL6Uc/yaT3BihcuU4S+4j?=
 =?us-ascii?Q?foCOmRBJ6eigW1G1SnPZhQlv7Gv0NkbgW+bRpmwvgsWVBVI?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;6:+2UpBiB31JOXWaQzFrzQJwUdgVj7dyPX6w0OQ4BGmbwXNL2G9pxx5QTu10bob2Sxji3jACHZkUiFSvvN0Of0E+yOkkj+7JtdEpdnULVNaS3Lfy9QlsuioSDKqqEYlmX0NHssjgyWG+cJZ1NugfHOc4/yHew9tPhmB62CGcEcbM5ugV+glJcottE2BCy7vfIvIgVEWlNTqHFmR5cDhy+V5pdT4L7cc2QvkVpOSwYLPtT55mJS1F+4YcbfkXd8SfwA6UUcLqO0U5HJ11K7fDFzsVc9/6jB+VEJ+OtMSEyiOJ0UPhjdIiNW2O8yy5vc4Fg1FrAccj9SNeDAzbmGUmvkLhcBrmrgALv1zA5uc3szVaQ=;5:O2qVmo2LXowjoe8gfLCnA+mL2tAEKxAfMiPtSJsnhYcoqRvQccjG6GHk4icAdaU2adt3m/uMy2fucIuQBp3JersENd7L1lSSX/IA6I1qMnlNKjayZsEwbeCeuu2eCN3TPQ0tGHzs7KpoCnwgElCtPYBqCXufynm398n0QqQl+sw=;24:zn/g1bnmcwzpby564tEPEGP5dqcjWXUyBzWUspObguNSaNYM1LgRwVWGBjUb8NTS0pGy1S/O4ES/Qd7JJUQ8J/rq0Ar3gbptl9uPb4Q8A1w=;7:L+O7uliHfqQMld8F03Uco9/b0BmVds1Zb7CWWFLXE7g1uVMwJgRghnjcM7FkWVpg6i8tdZGnZMkwf7C3n9hHAIOK7zARPboFfBWiU8SdOYIz1tjXE8fvDuq77OYGGL7Eb1rU2+ibTCQp1GKKosrPe380kXStvsiZKmf3aF3Ygjc6wqe474aUOShAxSnJ/YG/YfiYWys29dxVW+9vxjKeQ15W+5FCF0KkcI7C3SlQyCHmju2LxiNZcs9KWBQS+4Jf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 03:52:58.3596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65af8705-4b53-486a-e7c5-08d57d95989d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2637
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 26 Feb 2018 20:27:22 +0000 Alexey Brodkin wrote:

> Hi Andy,
> 
> On Mon, 2018-02-26 at 20:30 +0200, Andy Shevchenko wrote:
> > On Mon, Feb 26, 2018 at 7:14 PM, Evgeniy Didin
> > <Evgeniy.Didin@synopsys.com> wrote:  
> > > On Mon, 2018-02-26 at 18:53 +0200, Andy Shevchenko wrote:  
> > > > On Mon, Feb 26, 2018 at 5:14 PM, Evgeniy Didin
> > > > <Evgeniy.Didin@synopsys.com> wrote:  
> > > > > On Mon, 2018-02-26 at 16:39 +0200, Andy Shevchenko wrote:  
> > > > > > On Mon, Feb 26, 2018 at 4:34 PM, Evgeniy Didin
> > > > > > <Evgeniy.Didin@synopsys.com> wrote:  
> > > > > > > In commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
> > > > > > > have been made changes which can cause multiply overflow for 32-bit systems.
> > > > > > > The value of cto_ms is lower the drto_ms, but nevertheless overflow can occur.
> > > > > > > Lets cast this multiply to u64 type which prevents overflow.
> > > > > > > -       cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
> > > > > > > +
> > > > > > > +       cto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);  
> > > > > > 
> > > > > > IIRC, someone commented on this or similar, i.e.
> > > > > > 
> > > > > > DIV_ROUND_UP_ULL() ?  
> > > > > 
> > > > > Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL is not reasonable
> > > > > because overflow happens on multiply and DIV_ROUND_UP_ULL helps
> > > > > with sum overflow.  
> > > > 
> > > > Did you try to compile your code for 32-bit target?  
> > > 
> > > Yes, we have compiled code for 32-bit system.
> > > I am wondering why are you asking that?  
> > 
> > Because I simple didn't believe you.  
> 
> Well world around us is much more complicated than it sometimes looks like :)
> 
> > ERROR: "__udivdi3" [drivers/mmc/host/dw_mmc.ko] undefined!
> > ...scripts/Makefile.modpost:92: recipe for target '__modpost' failed
> > make[2]: *** [__modpost] Error 1  
> 
> That's right __udivdi3() is not defined for some architectures but it is defined for
> some others including ARC, Xtensa etc, see
> https://elixir.bootlin.com/linux/latest/ident/__udivdi3
> 
> What happens __udivdi3() is implemented in libgcc in one form or another form
> be it pure assembly or generic implementation written in C.
> 
> So maybe we need to add export of __udivdi3() for other arches, what do you think?

Per my understanding, Linux kernel prefer to make use of do_div or implementations
in <linux/math64.h> for 64bit divide

Thanks
