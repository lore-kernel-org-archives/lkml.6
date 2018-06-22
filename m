Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9439C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8971924266
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8971924266
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754067AbeFVNG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:06:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33768 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeFVNGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:06:24 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fWLlJ-0000R6-1z; Fri, 22 Jun 2018 13:06:01 +0000
Date:   Fri, 22 Jun 2018 14:06:01 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the vfs tree
Message-ID: <20180622130600.GY30522@ZenIV.linux.org.uk>
References: <e6a26908-67b2-e32e-06b5-d2e62acce305@intel.com>
 <20180622115346.1e9cc433@canb.auug.org.au>
 <29411.1529671523@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29411.1529671523@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:45:23PM +0100, David Howells wrote:
> Reinette Chatre <reinette.chatre@intel.com> wrote:
> 
> > Thomas and David, please let me know what I can do from my side to help
> > with this.
> 
> You could try basing on Al Viro's for-next tree which has the mount API
> changes in it.

Umm...  That would be a massive headache for everyone involved; the changes
in there have very little in common with what you are doing in rdt_mount(),
so it might make sense to start with a minimal never-rebased branch that
would
	* define rdt_pseudo_lock_init as 0
	* define rdt_pseudo_lock_release as empty
	* do the rdt_mount() part of a3dbd01e6c9d
	* have commit message along the lines of
"hooks in rdt_mount() for rdt_pseudo_lock to use

Functionally a no-op right now; the only reason for having that
as a never-rebased branch to get rdt_pseudo_lock and mount series
out of each other's hair"

Base that on -rc1, then pull it into your rdt branch and David could pull the
same into his.
