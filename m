Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AA8C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984F2241B1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984F2241B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeFVMTl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:19:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:44492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbeFVMTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:19:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4842ADD5;
        Fri, 22 Jun 2018 12:19:38 +0000 (UTC)
Date:   Fri, 22 Jun 2018 14:19:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v9] Refactor part of the oom report in dump_header
Message-ID: <20180622121936.GX10465@dhcp22.suse.cz>
References: <1529056341-16182-1-git-send-email-ufo19890607@gmail.com>
 <20180622083949.GR10465@dhcp22.suse.cz>
 <CAHCio2jkE2FGc2g48jm+ddvEbN3hEOoohBM+-871v32N2i2gew@mail.gmail.com>
 <20180622104217.GV10465@dhcp22.suse.cz>
 <CAHCio2j-z5y8sQrZ9ENLH2sOzuoH=vsC+q9Nj5DbSXUnQK-uPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2j-z5y8sQrZ9ENLH2sOzuoH=vsC+q9Nj5DbSXUnQK-uPw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-06-18 19:40:54, 禹舟键 wrote:
> Hi Michal
> > You misunderstood my suggestion. Let me be more specific. Please
> > separate the whole new oom_constraint including its _usage_.
> 
> Sorry for misunderstanding your words. I think you want me to separate
> enum oom_constraint and static const char * const
> oom_constraint_text[] to two parts, am I right ?

Just split the patch into two parts. The first to add oom_constraint*
and use it. And the second which adds the missing memcg information to
the oom report.
-- 
Michal Hocko
SUSE Labs
