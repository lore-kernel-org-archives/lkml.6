Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42289C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E292168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E292168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeI1Te0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:34:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:50536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbeI1Te0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:34:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57686AD00;
        Fri, 28 Sep 2018 13:10:42 +0000 (UTC)
Date:   Fri, 28 Sep 2018 15:10:43 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lijiang <lijiang@redhat.com>, dan.j.williams@intel.com,
        brijesh.singh@amd.com, bhe@redhat.com, thomas.lendacky@amd.com,
        tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        baiyaowei@cmss.chinamobile.com, hpa@zytor.com, tglx@linutronix.de,
        dyoung@redhat.com, akpm@linux-foundation.org,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 3/3] resource: Fix find_next_iomem_res() iteration issue
Message-ID: <20180928131043.GB21895@zn.tnic>
References: <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153782730364.130337.17794279728329113665.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <13084ce6-e29a-c244-3f9c-cf0725646d9f@redhat.com>
 <20180927140351.GA257735@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927140351.GA257735@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:03:51AM -0500, Bjorn Helgaas wrote:
> Since I think the current interface (using *res as both input and
> output parameters that have very different meanings) is confusing,

FTR, I too, think that this whole machinery in resource.c with passing
in a function and a struct resource pointer and is clumsy and could use
a rewrite. When there's time... ;-\

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
