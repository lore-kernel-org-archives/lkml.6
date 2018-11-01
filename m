Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C735EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A762081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A762081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeKATdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:33:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727453AbeKATdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:33:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26389ADD3;
        Thu,  1 Nov 2018 10:30:51 +0000 (UTC)
Date:   Thu, 1 Nov 2018 11:30:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v15 1/2] Reorganize the oom report in dump_header
Message-ID: <20181101103050.GG23921@dhcp22.suse.cz>
References: <1538226387-16600-1-git-send-email-ufo19890607@gmail.com>
 <20181031135049.GO32673@dhcp22.suse.cz>
 <CAHCio2jpqfdgrqOqyXQ=HUc-9kzDmtaYXH+9juVQS6hBHhSdPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2jpqfdgrqOqyXQ=HUc-9kzDmtaYXH+9juVQS6hBHhSdPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-11-18 18:09:39, 禹舟键 wrote:
> Hi Michal
> The null pointer is possible when calling the dump_header, this bug was
> detected by LKP. Below is the context 3 months ago.

Yeah I remember it was 0day report but I coundn't find it in my email
archive. Do you happen to have a message-id?

Anyway
        if (__ratelimit(&oom_rs))
                dump_header(oc, p);
+       if (oc)
+               dump_oom_summary(oc, victim);

Clearly cannot solve any NULL ptr because oc is never NULL unless I am
missing something terribly.
-- 
Michal Hocko
SUSE Labs
