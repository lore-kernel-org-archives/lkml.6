Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54E8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 08:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81139206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 08:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550995507;
	bh=dmI+72Us7nVS12AzBhfRYpevtDgXhoSP7Vsp0iWzeIM=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=PBSGeY4I6fTnvAOWnly5iwNp1gZvqnJyM7zCydWF/4QOEZjp0eGIrKhhxDJOeZB/R
	 tih01FHgCjbxyspSYaeQ/TylAEn5IdzPZi9vA7FJs2QjlUUl6DRDZINlFSqR8sQYNq
	 sgKXYaK5BeNl3T71dZMKeI9jgXj2qLzvbSgH44Bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfBXH7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 02:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfBXH7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 02:59:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F4A20663;
        Sun, 24 Feb 2019 07:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550995163;
        bh=dmI+72Us7nVS12AzBhfRYpevtDgXhoSP7Vsp0iWzeIM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=SmzBflICoPhggL0xlmUk6GYe4AW9Wp1bbQ010bJKxniqcJq00hJ+h+kREz+fIQ40Q
         PvpiNf9PnhWz365lKMnvN9LXtckikFX8xWWLVjEhzzDms1wCzpwvYkBuOgZ80cjCoN
         vfoED2VOwzDztMSM55fgfAHs9QyByYFMwyq+rUTs=
Date:   Sun, 24 Feb 2019 08:59:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: Note that simple_strtoul can't simply be
 replaced by kstrtoul
Message-ID: <20190224075921.GA5937@kroah.com>
References: <20190223194219.qxvi7cwfp3etqdfi@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223194219.qxvi7cwfp3etqdfi@function>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 08:42:19PM +0100, Samuel Thibault wrote:
> We often receive patches which erroneously try to use kstrtoul in these
> places.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Awe, it's fun to try to see people do this and not really think about
the consequences :)

Anyway, seriously, thanks for this, I'll go queue it up later today...

greg k-h
