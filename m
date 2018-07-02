Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D97C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B24225C8F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B24225C8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965705AbeGBL3L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:29:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:49460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965174AbeGBL3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:29:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6CFCBAE13;
        Mon,  2 Jul 2018 11:29:07 +0000 (UTC)
Date:   Mon, 2 Jul 2018 13:29:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Rodrigo Freire <rfreire@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: be more informative in OOM task list
Message-ID: <20180702112906.GH19043@dhcp22.suse.cz>
References: <7de14c6cac4a486c04149f37948e3a76028f3fa5.1530461087.git.rfreire@redhat.com>
 <20180702093043.GB19043@dhcp22.suse.cz>
 <1113748807.15224076.1530530533122.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113748807.15224076.1530530533122.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 07:22:13, Rodrigo Freire wrote:
> Hello Michal,
> 
> ----- Original Message ----- 
> > From: "Michal Hocko" <mhocko@kernel.org>
> > To: "Rodrigo Freire" <rfreire@redhat.com>
> > Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
> > Sent: Monday, July 2, 2018 6:30:43 AM
> > Subject: Re: [PATCH] mm: be more informative in OOM task list
> >
> > On Sun 01-07-18 13:09:40, Rodrigo Freire wrote:
> > > The default page memory unit of OOM task dump events might not be
> > > intuitive for the non-initiated when debugging OOM events. Add
> > > a small printk prior to the task dump informing that the memory
> > > units are actually memory _pages_.
> >
> > Does this really help? I understand the the oom report might be not the
> > easiest thing to grasp but wouldn't it be much better to actually add
> > documentation with clarification of each part of it?
> 
> That would be great: After a quick grep -ri for oom in Documentation,
> I found several other files containing its own OOM behaviour modifier
> configurations. But it indeed lacks a central and canonical Doc file
> which documents the OOM Killer behavior and workflows.
> 
> However, I still stand by my proposed patch: It is unobtrusive, infers
> no performance issue and clarifying: I recently worked in a case (for
> full disclosure: I am a far cry from a MM expert) where the sum of the
> RSS pages made sense when interpreted as real kB pages. Reason: There
> were processes sharing (a good amount of) memory regions, misleading
> the interpretation and that misled not only me, but some other
> colleagues a well: The pages was only sorted out after actually
> inspecting the source code.
> 
> This patch is user-friendly and can be a great time saver to others in
> the community.

Well, all other counters we print are in page units unless explicitly
kB. So I am not sure we really need to do anything but document the
output better. Maybe others will find it more important though.

-- 
Michal Hocko
SUSE Labs
