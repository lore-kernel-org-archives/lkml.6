Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34524C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56E32077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56E32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeIESXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:23:55 -0400
Received: from fieldses.org ([173.255.197.46]:58440 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbeIESXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:23:55 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 33CBC1EF5; Wed,  5 Sep 2018 09:53:36 -0400 (EDT)
Date:   Wed, 5 Sep 2018 09:53:36 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        R.E.Wolff@bitwizard.nl, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180905135336.GB22395@fieldses.org>
References: <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180904161203.GD17478@fieldses.org>
 <20180904162348.GN17123@BitWizard.nl>
 <20180904185411.GA22166@fieldses.org>
 <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
 <CAJDTihxE07BuXMBmShXuj=TbJCK1mq3ZMFMxP1-T=xjhPF5ySw@mail.gmail.com>
 <09ba078797a1327713e5c2d3111641246451c06e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ba078797a1327713e5c2d3111641246451c06e.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 06:55:15AM -0400, Jeff Layton wrote:
> There is no requirement for a filesystem to flush data on close(). In
> fact, most local filesystems do not. NFS does, but that's because it has
> to in order to provide close-to-open cache consistency semantics.

And these days even NFS can delay writeback till after close thanks to
write delegations.

--b.
