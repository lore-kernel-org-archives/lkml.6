Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39FCC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80FB2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80FB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeJXOm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 10:42:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:42286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbeJXOm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 10:42:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36843AC90;
        Wed, 24 Oct 2018 06:15:48 +0000 (UTC)
Date:   Wed, 24 Oct 2018 08:15:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Minchan Kim <minchan@kernel.org>,
        Arun Sudhilal <getarunks@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
Message-ID: <20181024061546.GY18839@dhcp22.suse.cz>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
 <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel@perches.com>
 <15247f54-53f3-83d4-6706-e9264b90ca7a@yandex-team.ru>
 <CAGXu5j+NsDHRWA5PKAKeJCO_oiGkFAUeWE8O-1fEBQX80MDu1A@mail.gmail.com>
 <7a4fcbaee7efb71d2a3c6b403c090db4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4fcbaee7efb71d2a3c6b403c090db4@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-10-18 10:47:52, Arun KS wrote:
> On 2018-10-24 01:34, Kees Cook wrote:
[...]
> > Thank you -- I was struggling to figure out the best way to reply to
> > this. :)
> I'm sorry for the trouble caused. Sent the email using,
> git send-email  --to-cmd="scripts/get_maintainer.pl -i"
> 0001-convert-totalram_pages-totalhigh_pages-and-managed_p.patch
> 
> Is this not a recommended approach?

Not really for tree wide mechanical changes. It is much more preferrable
IMHO to only CC people who should review the intention of the change
rather than each and every maintainer whose code is going to be changed.
This is a case by case thing of course but as soon as you see a giant CC
list from get_maintainer.pl then you should try to think twice to use
it. If not sure, just ask on the mailing list.

-- 
Michal Hocko
SUSE Labs
