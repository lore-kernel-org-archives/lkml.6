Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E36FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32EE218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="JqUO4Ec5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfBGQ1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:27:03 -0500
Received: from mail-eopbgr820135.outbound.protection.outlook.com ([40.107.82.135]:20704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbfBGQ1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FARnEwqkOSRajl/E6Ry23luQLMmuhbk5RDV/5SSaxM=;
 b=JqUO4Ec5vC8gTnT/DGVvPPgt2pBuMHa+MIUyn8spHNCi8ABTF7KeElVqWQjwdj+cA2onJtGZfwF5Wr4ek3Pfuti/XhYeOV35hfO2xiQNm8OFO/25rKzoenNAf4/Et8+8ZigmU2sHJPlB7IibrSQV3a5sill8KTgp5SNYfJvmm8I=
Received: from CY4PR01CA0010.prod.exchangelabs.com (2603:10b6:903:1f::20) by
 CY1PR01MB2043.prod.exchangelabs.com (2a01:111:e400:c610::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 16:25:19 +0000
Received: from CO1NAM03FT039.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by CY4PR01CA0010.outlook.office365.com
 (2603:10b6:903:1f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Thu, 7 Feb 2019 16:25:19 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT039.mail.protection.outlook.com (10.152.81.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 7 Feb 2019 16:25:18 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x17GPGaQ004048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Feb 2019 11:25:17 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 24DA27A2DD4; Thu,  7 Feb 2019 11:25:11 -0500 (EST)
Date:   Thu, 7 Feb 2019 11:25:11 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Greg KH <greg@kroah.com>
CC:     Sasha Levin <sashal@kernel.org>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 4.14 "random: add a config option to trust the CPU's hwrng"
Message-ID: <20190207162511.GD7387@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg KH <greg@kroah.com>, Sasha Levin <sashal@kernel.org>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <b6532199f855e48fa53b8c3725a2eb93f949b32a.camel@nokia.com>
 <20190206192613.GB4119@sasha-vm>
 <20190207112809.GC3120@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190207112809.GC3120@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(189003)(199004)(6916009)(1076003)(50466002)(36756003)(90966002)(33656002)(356004)(75432002)(476003)(103686004)(786003)(305945005)(8936002)(336012)(106002)(23726003)(11346002)(126002)(16586007)(26005)(186003)(316002)(42186006)(246002)(54906003)(2616005)(58126008)(86362001)(76176011)(8676002)(446003)(52956003)(4326008)(229853002)(26826003)(47776003)(478600001)(36906005)(2906002)(6246003)(6266002)(88552002)(486006)(46406003)(97756001)(106466001)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR01MB2043;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT039;1:3SKP/B/hZmqZAHGTTyk36CKt3naWYxcYVeXUGzY4aFg+WDtJOdkhIPJ55LOt/kQNKO/TTUEl+BDRxzDJWq4PiXY5zvgrnainPKe91lYccc7Em+QmhoTQyKflxsTBOHqQV6hA1Fe/6s1KJWb07XhegKg7v0l52YSkr08G1aOXaD8=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27a4cd97-be74-4a21-b072-08d68d18d9cf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:CY1PR01MB2043;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR01MB2043;3:wuf/8nbgC7kuZL338bH29pbeZF3O8GJ7nCmblBcOkysYznwG+uBNJMzw1lsjlcZxIA81RxETusf5BhKVox7swLKoxsMvIAfaqL7/6KnFQBYZe0rzPraQbwMU4HjDYUvTD3uN48YeLMgw0x53AMiA2ASITzuWOBbtnhSR3cxzW19lFWO1UwPbv5e80W9aCFkTiqLHuWahTdl05mA0UoJOLewvwLsQtD/8mF2LizrGZaM1GMqAtBmIGviYdRfPH9BOT8NcAAz2I29nxt/WSXyOrhqWIb3+rRbNI3BSrYRcRCaOagX96T4MVH2RvxH2BNMhqslPDhtCLgb/Ey/DTJlYQd266NZoK6MJaTpnH6ISzG+Lw9aD3ol7EyxFE6AzQRt+;25:UrMN5lrsKgEGOf0I3fsf3NWpA4+4kDpW3QbYhZf9Ons8QhyV/QYSsdVb9ZgVUWxErQNtcseLc6qj0Myxg9uYqlOvN0LpoUaDxsS++bGJVACyX0lrsoXkFXOlNCGovYe5UD82akQZwBTwJZ+9gjprvmp+h+7FoVnoxgQn8fkU/cjO9n0ZX0U/sSbo8snc3EQ8DlSQkN6dqxwkITLeyheaBmDMN2fncFMGPryBk3aLjCN47dxjPJYjMbxELASl16kxLlBp//9hiEz9QuvAwFSmJ9vDlpNtuxTi6jk5j7Vfo4rDnmFOJGnMOcKKo2thKABuDlPW3hs/wvTwSjrTwleZZA==
X-MS-TrafficTypeDiagnostic: CY1PR01MB2043:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY1PR01MB2043;31:v+qQfUY61E1gr5TRp1eI0RE19g+GHGqbVi9tpMFL+7ehvUiXOYoDUhQazTUleTGC7oyynWHC5IaHZFArs8slhIVD+DgLJPM45RrT7npUrXmetWlc6OzceNDEoOnhjmVKuFzztkYcqwge+bM6aWCfqpYT6aZKus2dSC4ekyINA+XZ4GzuFCq2tcRGpn02ONLTz+ZPQ0nfDx2doqTEwu153KOgJF8l0hX9aSzsWMjT2Po=;20:1jJSSMAtb+Q8igSUxQvaRXdlkvpwwwZhM09xHXM5cuHsB9sTRpOIMy+m8UXWqts2l89ynL1xwlAWzfBc5M1jMcj44qXf3c75qmq/PZYW06m1kPWKmkMgDCcVQoAiCWkAXSZByAUUNfPy54M3Pf00YPpjL74FDSl4dEBzHgid8dZzOKnlvE5niqiDOq5ani5QhVmkajWFjyWLzQBr/YYLOo/nm/FkY/1S28NvROyiqzN1peB7QZisP6TE4raAkdx5BMXpB/CUHuuemu7UxmtWF0Acwmwh3gu+YOHDn+SxR1f5T4jGHlohO1W0L286q9EGb/aO2TJSJ0QfVMFxTMc554W1ExF/raw5m+HzDGj/x4SqN70HkwGhY9KNmM78zszeGarLeF4U4D/FsNJOD6Z60WQlunrK/hK2t15jUW08oEwDtCVIjAv0QiYFP5qRV7nBHRpF4VWZHEgLU8gO8oMhw97gUkoiWwEn7ICBo+trqOKESRQWpG+AjMok4OAN/2y59jbF1J2roW8uDRvG4Il0ZzeBK8q4beMY4MF3Ca+zs9FLxiNQmFkQIGTwVuqE1qLRtSzouCWFE6qSDGZ92oTa/xu9WlgwdrVfY27hkqgGz6E=
X-Microsoft-Antispam-PRVS: <CY1PR01MB2043724D0EBC1022278C17E7B5680@CY1PR01MB2043.prod.exchangelabs.com>
X-Microsoft-Exchange-Diagnostics: 1;CY1PR01MB2043;4:xaPyPuWunNsyTkK7BdyHxCeuE/M5reg4l9L0Kzv1dCxFQSAccND4EIl/xhC3T0gBcmHgMV+RqadqgcxzCv6yhmi5fFrxT3zXGleQ7sTU8SpBdCOOBM8cKMiMVo5BXEj6xiviu7EEK/XmGt0HybZV2+MlRn+BWH8VvYF54NGFLnJYYpUMLo6myW/FTnl+0nfoVEvvgjkWF5FSUsWDhhGvlVMfPHCLgHGRdBPwBB/n655HtfFZEWNIrVahNmmJO9EGx9GtiiWOfbuCBr5++VHKt+e3tEpHjverskDVEWGphppo44ZwPwekFVP9VQ5mjJFn
X-Forefront-PRVS: 0941B96580
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR01MB2043;23:91ERZq1RbAixNQP1Ff8Wu+wRomqBr34KVHhRPj7eA?=
 =?us-ascii?Q?C7pSQo7PnryC+GaeSKjLaBAITkv3SewTWzBsG01XxlruVJY96Bt2xkPQcbtv?=
 =?us-ascii?Q?FC9ntte/k2zapdGTTAHp673Lzk3l3IZNpkISMFrzzFygIykynM9m6mCeh8Tl?=
 =?us-ascii?Q?VIYLeFA2TpYpPld2V53RpyipmnFxWMAlaPFbaZnyRpAkEi3Dud/V0G01ztPx?=
 =?us-ascii?Q?rYWZzK9CW7TgwZZtFerZodyfjyk7rjx9CJ8PKzZB/CwJyZR20srYlOyqDK2T?=
 =?us-ascii?Q?BNYzXFcXb8HeEDcEBINaot7gYwz8cmpU8+WI3La6DRIz2iw9I4pI8yAB4ldZ?=
 =?us-ascii?Q?SGV1F5dYUA5hap5tsW86JK9q71sDfIo+KRL+dOOTW5W8TJlXmHEcGlGMA2rH?=
 =?us-ascii?Q?sXdofAT9u0kYpLwo52kmxCYx/FzrdH0uMGljdCvbJdF8Aj61ug1ZPK+s0VNr?=
 =?us-ascii?Q?3ILquF+wwWPSUQyRjj37stnE/cYeaa1Kj/sEYx//t4dZkWWjur+lHQwO0Pkw?=
 =?us-ascii?Q?6J6FBFToSSOXPhTGxY68vCBs5Eyx2Luh2CXz7Fj2Q7Go1FnDhH71kHEcjHA6?=
 =?us-ascii?Q?e4CSxdd65wQ74tfEVJTMjpj/YWiA8O1wj+QhnvxZFc2OX9W9KtDUUI+E9q23?=
 =?us-ascii?Q?FZYsT3ErY4jEpTPBiMUGMf2OtnDrcgAKvZBhS2uBkyCkmlV5Kx1UuXAjzvfo?=
 =?us-ascii?Q?BOANvbzZnC8TqPkmThR3QiniS1ljQaCXf4WJWBYMBoe1HLS51vL+tblL7GQM?=
 =?us-ascii?Q?c2L9wFwiiTEbRG0Nuz/N+pVUaQNW4wT0TAGOIGlbjWTpe+ntzOox8w4iftoj?=
 =?us-ascii?Q?K0YdkcEnEdakn5SbREJgHuxdxyU4M3cGKcHZIXWevdVJv8eA9BQHAlZ+BG12?=
 =?us-ascii?Q?3ehSOB1uBcq2rvkK6BNHlwGH1JtOuUxObNZKAZ4IKuMiZC+LtFAXcoHo2ZO6?=
 =?us-ascii?Q?fFqnpqEQGgcXEHO5Hie1JQoOhAO12xh0CgNvAZyxIxO6R4m8M2vdiPDIiybK?=
 =?us-ascii?Q?+udgLnladrBj8o3H3DElR+a7K40gp9U2lTEz6l9ur0xh0yXYlla5OOmlTfs0?=
 =?us-ascii?Q?nbiwEE96Tju4zHDlPUP7KduUPzYt2PTvEResC4SHe6fbNpxxPMj6oU9p/Buv?=
 =?us-ascii?Q?1TB44y5awiPKUXzIXRixm6TWeR7yCawpYNmD/jrcACzRtly8hMrRcKkbcwjy?=
 =?us-ascii?Q?ZQLaPr4HFck1tgQnm24VZQDPwu2XcX340imYfJeSrcphwrCNexR31QADw=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: HCYQ1WWz/s7cffm0IIZnK0vlgfEhhCsKa27hnFqx/yCMHT7nZ35A0/9rI+x6YowI2SP2GEVe/pXaUPvJLnlZFixP2tctVroNbb4p+bAKtSThSQLDfVwiFpwSRoxQpLawhUppSnBt93bgXsD6bnoNvPr7nD9Y1XR/KoRvKThUsrggBw/s4d7mt6DuN7egIFqiTUG4xwC2Bsdfq/Gls5Thz+2KUHDvS6woCb85x8Ki1yDFLVWoPqvjT+5YuInroLJd/V/x8TRSKqpKLfFyYFuXhV4Qklq3XBxxMAqLcP10tRuuCtRNPhYKJkFWkhgfnRpZpgBNsaK//lvDqx1U50bViU9mpzOgiSngsToMVAxbcQOiJcf0dQQyDDK3oxk8DthfPukqACq2cQwSZUbibLDeLTCinclDHud3R/EXN3FE+DM=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR01MB2043;6:mmKoZYpJC22nXKtk96aoJGjTnFN+uTHeXHUpbLFkxvGXDJcsZL7kdOYnci3VC7+yzL8Z36On55Mo0+RGZS67Qy23NcHYjNtIaukzEvgcqO0izBxQtYzrLB7ELGLaXb/UCnQ8rCZfjfWThA9h509g6gfg/+04QuoPQpHgp+3w+8H4zA7YY1qvUOvu9szkeXV6MgSoLdziPK/Wtrs1dc5VYL71u1pm3F0XOPMu9sdggGoWtyXRxfHdQBAb+OYtSbHY6ccRM0nLs3ukQeoifQA0DmhNrkoAt4YhilmT05TxUdGJutYQjVyGHKfLJHutF4I3FLX5NBLMwNkY250YXDZ3LVKsYx9CfCszIi/f4s/QXY2U6FQQzG0ZwGg7PjF+KBTom4FGt/vU7+4p6AgV/m0/LEp7iVGUJF2u0ERd5RmfXw8m2nh6x7Kihnkj2viVw5LzmMf9qKgpEFT8W56dO2Trnw==;5:sOUeJtU6mfHI7/GFuD464dTVEW/iPS6rDtcLuUQyOHXUUofLmZH5tEpk1EokD7lvQP+vBCr7i+E87nS/t3POJuenobqhMNi3cXQQOoCw1pA0FyUKqq1iQVYUGiPgpChwrWSyvJlv5LvazNK6Pa3EOo397mv+O+DprLO+lB9vba4r+K7c60hreUsAuvyOD+aaLnrD4bl1UCjk6S06+D56yQ==;7:lO8uHIr8DvDX5+rT/479iP61cY6DQugxxiZ3CntXFfj7rQJBGX8z6ab79YcnoUqul2gqInLApqPGMlZZmhzZNBqK62G5bvbBy9mU+PW2DnFfO9xTPQs+aKwmIpcmjGLasw+cnaxf3fvULVvbUwKOQA==
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2019 16:25:18.7538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a4cd97-be74-4a21-b072-08d68d18d9cf
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB2043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 12:28:09PM +0100, Greg KH wrote:
> > > These are very useful in fixing esp. first-bootup delays of VMs due to
> > > entropy starvation.
> > > 
> > > 
> > > commit 39a8883a2b989d1d21bd8dd99f5557f0c5e89694
> > > Author: Theodore Ts'o <tytso@mit.edu>
> > > Date:   Tue Jul 17 18:24:27 2018 -0400
> > > 
> > >    random: add a config option to trust the CPU's hwrng
> > > 
> > > commit 9b25436662d5fb4c66eb527ead53cab15f596ee0
> > > Author: Kees Cook <keescook@chromium.org>
> > > Date:   Mon Aug 27 14:51:54 2018 -0700
> > > 
> > >    random: make CPU trust a boot parameter
> > 
> > This really looks like a new feature to me. The "old" behaviour of not
> > trusting RDRAND-like randomness was by-design rather than an oversight.
> 
> I agree with Sasha, this looks like a new feature.  If you really want
> this new functionality, just use 4.19 or newer, right?

This is a borderline case in my opinion.  The argument for why this
should perhaps be backported is the patches to address CVE-2018-1108,
which were backported to stable kernels, cause kernel boots to hang.
So to the extent that a newer stable kernel would cause operational
problems for consumers of the stable kernels, they would pretty
naturally view it as a regression.

Whether or not this should justify an exception is a policy question
that I'll leave to the stable kernel maintainers.  The downside is
that some consumers might elect to stay on an older stable kernel
since it would work for them, and newer stable kernels would not work.
Whether this is outweighed by prodding stable kernels users to new
newer kernels is an interesting question.

						- Ted
