Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD6BC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980A620850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfARSFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:05:53 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:35349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbfARSFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:05:52 -0500
Received: from oxbsltgw66.schlund.de ([212.227.220.204]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxEYY-1h8x5s34zQ-00xZ54; Fri, 18 Jan 2019 19:05:36 +0100
Date:   Fri, 18 Jan 2019 19:05:35 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jeremy Linton <jeremy.linton@arm.com>, marc.zyngier@arm.com
Cc:     mlangsdo@redhat.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        julien.thierry@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
Message-ID: <575913854.422488.1547834735236@email.ionos.de>
In-Reply-To: <c99f5da9-259c-3fc5-6150-7327ba0ff429@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <884332236.499392.1547581848222@email.ionos.de>
 <c99f5da9-259c-3fc5-6150-7327ba0ff429@arm.com>
Subject: Re: [PATCH v3 0/7] arm64: add system vulnerability sysfs entries
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:ZoURWHSIlPpYkd2EnWsFsQ8SWv7CpPvZNTMHt3wz4UaeaNhZEzy
 iOxccCipZ7wm6wnJigp1k7fjQ/OlSNWmcFbQ1tv9x4nZldlWSLYK9BH8HiG8YYrBq9qrkRy
 mq26uzJRV5RmsCaC1AvbuiVLReROd831julPROi4BzrS0glCoJCud/CBXrfNBJXDOUwrIHO
 bff2QxmS9bCKRRNhFgnqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:31AmI8rdDIA=:pxW8TEtyU2nbIAidssiwFi
 YMzQ4SGC9vu8nYoFOEsnvBQcyAbiXYtoupCbhexv/xnMgXO3w6ndIB7iwjcL1oYv2sCVpxW2O
 qwyqslyuCVjY3GdyjZkmryCZx/Sa6OqMaAmd3ILL9RiwxOfs6M805K7IRLEpICCfGcxYRyT30
 N95+/tP41X72suqOGnJ5z+KaRRYHfHQKC85Hu/jlCWF6rWmRlao7WrboLRyx6gibTi0S2MkRX
 XS1Cpo7/+xloCxcQwDEO399e1VKIXp7lYn+zBpEf7qfDlPgyAbAscMvhw7Yme5kCET+2W2Pcv
 JLKu4TDsrF+ehYgrS7w/+k1dpifsqecntIgNlyN4+b6xVGo4q+uXjHTf5JG7d04AX0s5k4Zmi
 Nm+7Cvp0S55+00k+GBXtHkXMecWh9Oqgl+aUPgmuh8ptISkp6vAXLIM8Nau3fCHg6ZlbZik5k
 kKarDXnMOx0IcPs0ILhskBRWLJWw2ibfCRJSHf4i4Y3t8H10iXa6KuPndMknt7zZZ4lxQWCtS
 q495UWDGsJC1iKHVyvMM2Pmbcq+pBj9Mv6lwCu5blPZ8l6Fb1GRLeIpCPxXMszv7hLF61oFv4
 e3jNRJ7i4A/qPcmBQzd7B/mt+uYsdEbhMw17ucUSzAejeUqa3vW4vGWKmpWNqIuHCvYup7KVS
 GJmbb3CybBRh55jfH4jsO0Kvb/fsS2Q4vC+iizSxaW0nEUeudLvIQ8Uc4PVSi6v22uspEY/Kj
 1PbNSvwNfuVh8Y0O5ZbbfrC8cUzOblJHDTLd2PHSuV+KC2sAsoles5LKKec=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Jeremy Linton <jeremy.linton@arm.com> hat am 15. Januar 2019 um 22:21 geschrieben:
> 
> 
> Hi,
> 
> On 01/15/2019 01:50 PM, Stefan Wahren wrote:
> > Hi Jeremy,
> > 
> >> Jeremy Linton <jeremy.linton@arm.com> hat am 10. Januar 2019 um 00:55 geschrieben:
> >>
> >>
> >> Arm64 machines should be displaying a human readable
> >> vulnerability status to speculative execution attacks in
> >> /sys/devices/system/cpu/vulnerabilities
> >>
> >> This series enables that behavior by providing the expected
> >> functions. Those functions expose the cpu errata and feature
> >> states, as well as whether firmware is responding appropriately
> >> to display the overall machine status. This means that in a
> >> heterogeneous machine we will only claim the machine is mitigated
> >> or safe if we are confident all booted cores are safe or
> >> mitigated.
> >>
> > 
> > i applied this v3 series and Marc's v2 series.
> > 
> > Now i'm getting the following on a Raspberry Pi 3 B+ :
> > 
> > meltdown:Not affected
> > spec_store_bypass:Not affected
> > spectre_v1:Mitigation: __user pointer sanitization
> > 
> > So the entries l1tf and spectre_v2 disappeared.
> 
> Yes, the l1tf entry should be gone.
> 
> I believe there is a problem with the "1/2 advertise.." patch in that 
> the 'arm64_requested_vuln_attrs |=' line needs to be hoisted  to the top 
> of check_branch_predictor() and the '__spectrev2_safe = false' line 
> needs to be hoisted 6 lines immediately above "/* Fallback to firmware 
> detection*/"

a snippet or a new version would be nice

> 
> That should re-enable the spectre_v2 entry.
