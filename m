Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6637208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546529536;
	bh=1PBUnyFFnT+ckceflGEs0gnLLS0Z22bGDdZnxh5jlzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bLLztqfjoyhpEA7mbuL6GzevItgqlE9/lJ0/1AqNxhEpRFAv4xdtbIqR3Z/Fx/3pa
	 yv4tz3gC6t9G0Q7YjeQnAKHYUrM2UnWOm0gHjdfEkPLC8/HykCuE1lwYxAseCLtphJ
	 ZPEc2sHe99d2wAfBhzoykQYW8bOjETPnm4h/VakQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfACPcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:32:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:37036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730901AbfACPcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:32:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83A58AF1B;
        Thu,  3 Jan 2019 15:32:12 +0000 (UTC)
Date:   Thu, 3 Jan 2019 16:32:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        David Windsor <dave@nullcore.net>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] mm: Mark 'stack_vm_area' with __maybe_unused
Message-ID: <20190103153209.GT31793@dhcp22.suse.cz>
References: <1545965190-2381-1-git-send-email-yuehaibing@huawei.com>
 <20181228085804.GR16738@dhcp22.suse.cz>
 <20190102105531.GI3781@kadam>
 <ae41ee4b-4e3f-d39b-1ad8-40d0096b713d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae41ee4b-4e3f-d39b-1ad8-40d0096b713d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-01-19 19:40:15, YueHaibing wrote:
> On 2019/1/2 18:55, Dan Carpenter wrote:
> > On Fri, Dec 28, 2018 at 09:58:04AM +0100, Michal Hocko wrote:
> >> On Fri 28-12-18 02:46:30, YueHaibing wrote:
> >>> Fixes gcc '-Wunused-but-set-variable' warning when
> >>> CONFIG_VMAP_STACK is not set:
> >>
> >> Isn't this warning disabled? I can see the following
> >> # These warnings generated too much noise in a regular build.
> >> # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
> >> KBUILD_CFLAGS += -Wno-unused-but-set-variable
> >>
> >> in the main makefile. IMHO this warning doesn't really give us much.
> >>
> > 
> > It would be nice to enable that warning.  YueHaibing and Colin King have
> > been whittling away at the problematic code...
> > 
> > YueHaibing, how many of these warnings do we have remaining on an
> > allmodoconfig?
> 
> about 1300+

This is way too much. Is any of them actually pointing to a real bug?

-- 
Michal Hocko
SUSE Labs
