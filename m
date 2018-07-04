Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC810C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A999220837
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A999220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934225AbeGDIRP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:17:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932346AbeGDIRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:17:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96971AFA9;
        Wed,  4 Jul 2018 08:17:11 +0000 (UTC)
Date:   Wed, 4 Jul 2018 10:17:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc:     andy.shevchenko@gmail.com, akpm@linux-foundation.org,
        rientjes@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        guro@fb.com, yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v11 1/2] Refactor part of the oom report in dump_header
Message-ID: <20180704081710.GH22503@dhcp22.suse.cz>
References: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com>
 <CAHp75VdaEJgYFUX_MkthFPhimVtJStcinm1P4S-iGfJHvSeiyA@mail.gmail.com>
 <CAHCio2jv-xtnNbJ8beokueh-VQ6zZgF1hAFBJKHCNyuOuz2KxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2jv-xtnNbJ8beokueh-VQ6zZgF1hAFBJKHCNyuOuz2KxA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-07-18 10:25:30, 禹舟键 wrote:
> Hi Andy
> The const char array need to be used by the new func
> mem_cgroup_print_oom_context and some funcs in oom_kill.c in the
> second patch.

Just declare it in oom.h and define in oom.c
-- 
Michal Hocko
SUSE Labs
