Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBF0C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BCF21473
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfA0Lqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:46:50 -0500
Received: from proxy01.fsdata.se ([89.221.252.211]:52320 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726443AbfA0Lqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 06:46:49 -0500
Received: from localhost (94.234.44.129) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Sun, 27 Jan 2019 12:46:42
 +0100
Date:   Sun, 27 Jan 2019 12:46:37 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     Darren Hart <dvhart@infradead.org>
CC:     <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <2pi@mok.nu>
Subject: Re: [PATCH] platform/x86: wmi: fix potential null pointer
 dereferences
Message-ID: <20190127114636.quqb2mjmb6rozzko@mok.nu>
References: <20190122200302.19861-1-2pi@mok.nu>
 <20190126204355.GA13882@wrath>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190126204355.GA13882@wrath>
X-Originating-IP: [94.234.44.129]
X-ClientProxiedBy: PROXY04.HMC.local (192.168.46.54) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darren,

On 2019-01-26, Darren Hart wrote:
> On Tue, Jan 22, 2019 at 09:03:01PM +0100, Mattias Jacobsson wrote:
> > In the function wmi_dev_match() there are three variables that
> > potentially can result in a null pointer dereference. Namely:
> 
> Is this something you have observed? This gets called when a new driver
> registered for each unassociated device on the bus, so I'm not
> immediately seeing how dev or driver would end up being NULL here.

I've observed that wmi_driver->id_table can be NULL, that can happen
when a WMI driver registers itself without specifying an id_table.

When adding a NULL check for wmi_driver->id_table, it felt wrong to not
do the same check for driver. After all, driver is a pointer given to me
from someone else, and can therefore be NULL. The same reasoning applies
to dev.

> 
> See: Documentation/driver-model/bus.txt
> 
> -- 
> Darren Hart
> VMware Open Source Technology Center

Thanks,
Mattias
