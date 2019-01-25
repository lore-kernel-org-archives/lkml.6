Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9443C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C14218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="gp70rwtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfAYG2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:28:11 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46092 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfAYG2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:28:10 -0500
Received: by mail-oi1-f195.google.com with SMTP id x202so6900401oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 22:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Mv5wuebRzoalbCk7v0arDMNle3VSxPxLSOwttSePtY=;
        b=gp70rwtRHbqz/Kj7KbZjRxy4Tiu+ZnkP1IVeLNRLzlqV6rncaLAO5NAGYGjGXoS8gK
         ghskggWCWW0/Y56HMc6J0RP/BEDdM+5S89h/5Cy1fqiGtUUAVQyXB/ORHmUGRy/oVpFD
         jMCs5wh+ZhweLK8ozanvFtp4ieRPha1WYgQeDsmnm9fl4UFMzOYA94+DeZs4uNwwoCdY
         +DxPEymsYhIVEz6R2Y6Vl89GH6bbLXa3U6ALFkXcsWfSqmY7Me4P6C8n9ndQBhvMktgI
         rRBQhQzH2Ybhz13Z/tt62bSi5xLOJbx7thOHGBEegMudekMopSbTeJ/KfrU9TP18CIEM
         DM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Mv5wuebRzoalbCk7v0arDMNle3VSxPxLSOwttSePtY=;
        b=CXEfgH3bgNxoKUIMuSnp3yBz2l7TMbziaIoeeu+SUGHnMoM28kQdu9JC4AoJkyGVLr
         uzukswwIIvjW+RvBbLRI1sJ4BuwurjUUA++Saj6CVOclL0UAOU1qsGHI7ea9av2VHkFE
         AbdvPXPaeWAz1UI84ntnSZ5mspAvTALrTSTqU94bNWv2fkQyify2G4B8DCLe7N2TZ26l
         Sv1uC5/hY4GdMAgVAkSFh2Lqgtw/2EioU4MO6hG0lRF70WyWWbUN6kl3scprp/TEd8tR
         dQPf5YO4yKyVwfWedO37fuRxUq2T4YKiaWbO71I50YiAr2ckaTt4aoV597mOY55QVLu4
         ocCg==
X-Gm-Message-State: AJcUukd3wqzeNtUiSGZtqMcNHAW0w5d7O+xVGvQykG9OwPd0/RB/lzm6
        r3d/57olg7svcNcVlVYybuHvpWZbXhBgUcUg+lZe6A==
X-Google-Smtp-Source: AHgI3IaAd7/Bz4rL67ZFLiO3E0QWfxNZbkq3MoXd0sjw9uIOtxAfi2CtOXobVGBBel159D3EmKXvi06BZYuigPT2ldQ=
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr502126oit.235.1548397689037;
 Thu, 24 Jan 2019 22:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231448.E102D18E@viggo.jf.intel.com>
 <0852310e-41dc-dc96-2da5-11350f5adce6@oracle.com>
In-Reply-To: <0852310e-41dc-dc96-2da5-11350f5adce6@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 24 Jan 2019 22:27:58 -0800
Message-ID: <CAPcyv4hjJhUQpMy1CVJZur0Ssr7Cr2fkcD50L5gzx6v_KY14vg@mail.gmail.com>
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like normal RAM
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Takashi Iwai <tiwai@suse.de>,
        Ross Zwisler <zwisler@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 10:13 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> Hi, Dave,
>
> While chatting with my colleague Erwin about the patchset, it occurred
> that we're not clear about the error handling part. Specifically,
>
> 1. If an uncorrectable error is detected during a 'load' in the hot
> plugged pmem region, how will the error be handled?  will it be
> handled like PMEM or DRAM?

DRAM.

> 2. If a poison is set, and is persistent, which entity should clear
> the poison, and badblock(if applicable)? If it's user's responsibility,
> does ndctl support the clearing in this mode?

With persistent memory advertised via a static logical-to-physical
storage/dax device mapping, once an error develops it destroys a
physical *and* logical part of a device address space. That loss of
logical address space makes error clearing a necessity. However, with
the DRAM / "System RAM" error handling model, the OS can just offline
the page and map a different one to repair the logical address space.
So, no, ndctl will not have explicit enabling to clear volatile
errors, the OS will just dynamically offline problematic pages.
