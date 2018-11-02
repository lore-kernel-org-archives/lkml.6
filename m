Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2266EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996FD2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996FD2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeKBRmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:42:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:36420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeKBRmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 13:42:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0A74AEAD;
        Fri,  2 Nov 2018 08:35:58 +0000 (UTC)
Date:   Fri, 2 Nov 2018 09:34:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v15 1/2] Reorganize the oom report in dump_header
Message-ID: <20181102083413.GR23921@dhcp22.suse.cz>
References: <1538226387-16600-1-git-send-email-ufo19890607@gmail.com>
 <20181031135049.GO32673@dhcp22.suse.cz>
 <CAHCio2jpqfdgrqOqyXQ=HUc-9kzDmtaYXH+9juVQS6hBHhSdPA@mail.gmail.com>
 <20181101103050.GG23921@dhcp22.suse.cz>
 <CAHCio2jZ-RRuJ02ARmio5YON4mn0jwtuK_purFRxqSuVD=JsPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2jZ-RRuJ02ARmio5YON4mn0jwtuK_purFRxqSuVD=JsPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-11-18 14:18:59, 禹舟键 wrote:
> Hi Michal
> The message-id is as below
> https://lkml.org/lkml/2018/7/31/148

David said
: It's possible that p is NULL when calling dump_header().  In this case we
: do not want to print any line concerning a victim because no oom kill has
: occurred.

This means that we should check for p rather than oc.

-- 
Michal Hocko
SUSE Labs
