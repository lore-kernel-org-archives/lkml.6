Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7E6C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3212081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3212081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeJXOxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 10:53:00 -0400
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:53647 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbeJXOxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 10:53:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 99186182CF669;
        Wed, 24 Oct 2018 06:26:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: eye20_36fc791bcd956
X-Filterd-Recvd-Size: 2474
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Oct 2018 06:26:17 +0000 (UTC)
Message-ID: <0e1fc40af360ed55fd32784f6973af5940232f99.camel@perches.com>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
From:   Joe Perches <joe@perches.com>
To:     Michal Hocko <mhocko@kernel.org>, Arun KS <arunks@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Minchan Kim <minchan@kernel.org>,
        Arun Sudhilal <getarunks@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 23 Oct 2018 23:26:16 -0700
In-Reply-To: <20181024061546.GY18839@dhcp22.suse.cz>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
         <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel@perches.com>
         <15247f54-53f3-83d4-6706-e9264b90ca7a@yandex-team.ru>
         <CAGXu5j+NsDHRWA5PKAKeJCO_oiGkFAUeWE8O-1fEBQX80MDu1A@mail.gmail.com>
         <7a4fcbaee7efb71d2a3c6b403c090db4@codeaurora.org>
         <20181024061546.GY18839@dhcp22.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-24 at 08:15 +0200, Michal Hocko wrote:
> On Wed 24-10-18 10:47:52, Arun KS wrote:
> > On 2018-10-24 01:34, Kees Cook wrote:
> [...]
> > > Thank you -- I was struggling to figure out the best way to reply to
> > > this. :)
> > I'm sorry for the trouble caused. Sent the email using,
> > git send-email  --to-cmd="scripts/get_maintainer.pl -i"
> > 0001-convert-totalram_pages-totalhigh_pages-and-managed_p.patch
> > 
> > Is this not a recommended approach?
> 
> Not really for tree wide mechanical changes. It is much more preferrable
> IMHO to only CC people who should review the intention of the change
> rather than each and every maintainer whose code is going to be changed.
> This is a case by case thing of course but as soon as you see a giant CC
> list from get_maintainer.pl then you should try to think twice to use
> it. If not sure, just ask on the mailing list.

Generally, it's better to use scripts to control
the --to-cmd and --cc-cmd options.

Something like what I detailed here:

https://lkml.org/lkml/2016/9/14/482


