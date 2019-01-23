Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FABC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C27621019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfAWJ2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:28:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37992 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfAWJ2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:28:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F93BA78;
        Wed, 23 Jan 2019 01:28:39 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BADEA3F5C1;
        Wed, 23 Jan 2019 01:28:37 -0800 (PST)
Date:   Wed, 23 Jan 2019 09:28:36 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2] PM / EM: Expose the Energy Model in debugfs
Message-ID: <20190123092834.hj5v6lup4422wrmf@queper01-lin>
References: <20190122164247.19439-1-quentin.perret@arm.com>
 <20190122184136.GD31777@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190122184136.GD31777@kroah.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 Jan 2019 at 19:41:36 (+0100), Greg KH wrote:
> On Tue, Jan 22, 2019 at 04:42:47PM +0000, Quentin Perret wrote:
> > The recently introduced Energy Model (EM) framework manages power cost
> > tables of CPUs. These tables are currently only visible from kernel
> > space. However, in order to debug the behaviour of subsystems that use
> > the EM (EAS for example), it is often required to know what the power
> > costs are from userspace.
> > 
> > For this reason, introduce under /sys/kernel/debug/energy_model a set of
> > directories representing the performance domains of the system. Each
> > performance domain contains a set of sub-directories representing the
> > different capacity states (cs) and their attributes, as well as a file
> > exposing the related CPUs.
> > 
> > The resulting hierarchy is as follows on Arm juno r0 for example:
> > 
> >     /sys/kernel/debug/energy_model
> >     ├── pd0
> >     │   ├── cpus
> >     │   ├── cs:450000
> >     │   │   ├── cost
> >     │   │   ├── frequency
> >     │   │   └── power
> >     │   ├── cs:575000
> >     │   │   ├── cost
> >     │   │   ├── frequency
> >     │   │   └── power
> >     │   ├── cs:700000
> >     │   │   ├── cost
> >     │   │   ├── frequency
> >     │   │   └── power
> >     │   ├── cs:775000
> >     │   │   ├── cost
> >     │   │   ├── frequency
> >     │   │   └── power
> >     │   └── cs:850000
> >     │       ├── cost
> >     │       ├── frequency
> >     │       └── power
> >     └── pd1
> >         ├── cpus
> >         ├── cs:1100000
> >         │   ├── cost
> >         │   ├── frequency
> >         │   └── power
> >         ├── cs:450000
> >         │   ├── cost
> >         │   ├── frequency
> >         │   └── power
> >         ├── cs:625000
> >         │   ├── cost
> >         │   ├── frequency
> >         │   └── power
> >         ├── cs:800000
> >         │   ├── cost
> >         │   ├── frequency
> >         │   └── power
> >         └── cs:950000
> >             ├── cost
> >             ├── frequency
> >             └── power
> > 
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > 
> > ---
> > 
> > V2: removed check on return value of debugfs_create_* (Greg KH)
> > ---
> >  kernel/power/energy_model.c | 57 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks !
Quentin
