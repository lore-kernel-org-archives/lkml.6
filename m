Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D43EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E64222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="eqiTrGkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501934AbfBNPWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:22:30 -0500
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:35616
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404698AbfBNPW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA6wnO/edSjaUoWyIRbxkdUJ9Ugrp77Y2faFycUq+ow=;
 b=eqiTrGkZAm4PjPR4wSqQxbVdMriIqGCbUC9c0YpE0pSyW8Q5clIO1uwG4ksrw9dzOnfIrjQ6t4OW39n9Nq6fMTgw6s0EeT6SX7Q8PZOHxe2yhDym6Kmbf4VHkaLfNHMGzm9+QWid3XA0GlnHCrgt0WgUPx49K+9CDeCRNV1pBcA=
Received: from AM5PR0602CA0020.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::30) by DB7PR06MB4725.eurprd06.prod.outlook.com
 (2603:10a6:10:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Thu, 14 Feb
 2019 15:22:26 +0000
Received: from AM5EUR02FT055.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::204) by AM5PR0602CA0020.outlook.office365.com
 (2603:10a6:203:a3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 15:22:26 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT055.mail.protection.outlook.com (10.152.9.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 14 Feb 2019 15:22:26 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 16:22:24 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Thu, 14 Feb 2019 16:22:22 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Joe Perches <joe@perches.com>
Reply-To: <federico.vaga@cern.ch>
CC:     Andy Whitcroft <apw@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: Re: report: scripts: checkpatch: Spell Checker Does Not Run with '-f'
Date:   Thu, 14 Feb 2019 16:22:23 +0100
Message-ID: <18906867.g0OWnkFYVf@pcbe13614>
In-Reply-To: <d9ad7fb05178dd9afb4906cacdb03f86802c23c3.camel@perches.com>
References: <3030138.e1gdHPWlgN@pcbe13614> <2899994.xJFnvJAAA5@pcbe13614> <d9ad7fb05178dd9afb4906cacdb03f86802c23c3.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB4725;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6332a037-c283-4503-374d-08d692903a1d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:DB7PR06MB4725;
X-MS-TrafficTypeDiagnostic: DB7PR06MB4725:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR06MB4725;20:oAb0sDd/FniOFQkUdhPly778zZU2FbHD9Hp4FRh77IDYgx1nx0qjeHIksobhM7VlKP3ZmaLX24/p8FWJCU4sT094yvhI+SFlweOlcd7T/63JsV1B0hBg91i1kQBt0QX/Om4uXrJCieFxNLcupdoN2edqso8vlhuMZheMPnkIq/txhR6hAAsD1jEP0etorXMhQOc1SrDPDG8zsh9bS115BtYzajLZojWM4rSJXXVOWQt8PaNNoW0tMrccg3pXlY9+3L6pyPVMYBIyUw3WfB89w0FzUAXGhiWjCSGnXtRxd8XxXooiVE4F9OX1IKg9ogtc8PX3l6eNa+J5iZzDqyAtTsEzWhRxxYsn+HDXMMSc7xXIz0GKRJkeH6wRgC6THeCwWZFjTXgPdd2oJaBJaxTiEWiQyOcpZ1jN+2tckICEeqeyDACXXhAfV7PXkya1gPE+8BhxVUTek7xITsonJLPDY/xB4S5Nu39zaNhO9iXu68rfOTIzkmMrO4B9g7i1hgb2;23:axZeP/UFAcQkZHgxXJcvldvKBjQQhXTVkoB94LH5vqEPSNSlLY0lmkAgFbABjtqyRfykMFaCLdnNvgzubqJzTIfTtzxukCjqtf9nd7EMzbTlCb0GD3dGu9YjFIcZhWu6WLu8tIsx+3WxtIxt/QzsHzVfKSgToCGJvfiaIJuXiJKI5z89msCV9HIo4aFaYgCY
X-Microsoft-Antispam-PRVS: <DB7PR06MB47253C2684D78CC046E380B3EF670@DB7PR06MB4725.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: gH7ZBQWZpgmBOc3F11z985Ip11kFtTQjFBMlGrNyBHKnhDWZS5HS7+tb7wNb4zucSm5GJF1eU76xjGnDUIKHFFJV253/5B8XSkiTdVQAvIWMpGldQFIeEiqoSOVM2kz+RoWV6PaWuYWuiTTd5OCVewJpnLv0UYG0R1cnBv7xwzDLXBwwmgMYguS9TrkjSP+3AJnajy8mAdTTByEjPLsGsa2VZRgapR0M99qa5KQBK5vuhQVzYHk43251z0BWSsHTjsrk6Iw44KY+ZGoRmk54SAclYKGS+rhKbg5GGSe1nX9dSRFrZfFGUZDYMWVtrcZPcRghhqjJv7m9cDHOa1qoDhmJEPbYw14l8brDU1lySVX7VOcUJguo5ugBZCIkIl0PUPgJCkP4vkAspUBbmiUtpxi0cC2seLQtAPdwaK5/t+AJLOSJ7aMMri23+otCIhLsXx203HAX77z4eS0LlV8BBRqeylPWWCGxK6TR1dQcmigdLqhcERArE0AiwIphIE+3aidLA1BHdbciJKEuJQsbwIaK8Li454kgmVmq0X2ctU0=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 15:22:26.4981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6332a037-c283-4503-374d-08d692903a1d
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 14, 2019 4:19:36 PM CET Joe Perches wrote:
> On Thu, 2019-02-14 at 16:03 +0100, Federico Vaga wrote:
> > On Thursday, February 14, 2019 3:44:55 PM CET Joe Perches wrote:
> > > On Thu, 2019-02-14 at 13:48 +0100, Federico Vaga wrote:
> > > > Hello,
> > > > 
> > > > Recently I have produce a couple of patches but I get different
> > > > warnings
> > > > if I run checkpatch on the file (-f) or if I run it of a patch file.
> > > > In
> > > > particular, the problem I found is with the spell checker which seems
> > > > to
> > > > run only when the option '-f' is not used. I am wandering if there are
> > > > other similar cases.
> > > > 
> > > > I do not know Perl, so I cannot investigate more, but I have a
> > > > practical
> > > > example. I have this simple patch applied on my tree that introduces a
> > > > spell
> > > 
> > > > error:
> > > If you want spelling fixes on files you have to use --strict
> > 
> > Thanks
> > 
> > Is it a design choice to have different checks enabled with '-f'?
> 
> Yes.
> 
> It was for a minimization of churn.

Thank you for the information.

> commit 66b47b4a9dad00e45c049d79966de9a3a1f4d337
> Author: Kees Cook <keescook@chromium.org>
> Date:   Mon Oct 13 15:51:57 2014 -0700
> 
>     checkpatch: look for common misspellings
> 
>     Check for misspellings, based on Debian's lintian list.  Several false
>     positives were removed, and several additional words added that were
>     common in the kernel:
> 
>             backword backwords
>             invalide valide
>             recieves
>             singed unsinged
> 
>     While going back and fixing existing spelling mistakes isn't a high
>     priority, it'd be nice to try to catch them before they hit the tree.




