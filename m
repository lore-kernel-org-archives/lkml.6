Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4BDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35044218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="FVUoshR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfABUFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:05:36 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45336 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfABUFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:05:35 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so26016815oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 12:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwNzLMTXb+K6/MpjHKyHQEI4PyVQzu80D6rs7MUtTdg=;
        b=FVUoshR6kTZsAcEIlAy811Gn+sD88fDMXWF8uWPdUFp89IZpOvZpAARU1UwUPf4knd
         IYVH3843fsz4ValbAcrlfx7/Fi8mF5KXcxbrukGYj3xWVRUz+Gk50iCfpPWRzF+DvTbR
         LRmlxBeFdq0VoTBqVljyhFq6paxGdiziW7vhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwNzLMTXb+K6/MpjHKyHQEI4PyVQzu80D6rs7MUtTdg=;
        b=DwezmX7x7++9dqMNiqpu3IRStt5IovITLjWTz5XVeXF+XClNvJdxGaqDEJgjYiwkHe
         3FfTlh8TtArnXgaBpUbwcG9KYBZptEz/22L+PFdFUUSqjjwAsVQel39kU4JOgD0plduc
         xk0jJafzBZEWgfa+PzZtSn8fnpZEu++eR6gpTgO2jjf9/rvbPFESddeJh5a6IRq3sSkO
         Lj9XbnPhLtW6SSmwSqE9g13xPI1ig2dhYkUADjMTyWSrMR4aF6pLlfhjVKJHllxoL9vN
         5Xo/gDaQqlfVGJUgIenxWfkWtnYQGmWkt6ls7sylzGGuxBx0Je1qXriwLSrp65LhYd72
         WhTg==
X-Gm-Message-State: AA+aEWZB6VzfP/EuS6VyMk51A7VovUjQMbbLQLjJKM+HmqHKNaG8iRPP
        m8SrOsIPUDoEW106HSIJP+/TWASsr0vrrQ63KhPGKw==
X-Google-Smtp-Source: ALg8bN6ENcIppHwHJfZ9Pot+DtaRMePk0FeFzNPj46Ihtl46V9A1CMs9WBV0x8ugovRz1Grbej5V07lZvgVzqNZZLpU=
X-Received: by 2002:aca:4506:: with SMTP id s6mr28611606oia.115.1546459534608;
 Wed, 02 Jan 2019 12:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20181203170934.16512-1-vpillai@digitalocean.com>
 <20181203170934.16512-2-vpillai@digitalocean.com> <alpine.LSU.2.11.1812311635590.4106@eggly.anvils>
 <CANaguZAStuiXpk2S0rYwdn3Zzsoakavaps4RzSRVqMs3wZ49qg@mail.gmail.com>
 <alpine.LSU.2.11.1901012010440.13241@eggly.anvils> <CANaguZC_d2EBmNuXtcJRcEcw8uXK234tYSXx6Uc2o9JH_vfP4A@mail.gmail.com>
 <alpine.LSU.2.11.1901021039490.13761@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1901021039490.13761@eggly.anvils>
From:   Vineeth Pillai <vpillai@digitalocean.com>
Date:   Wed, 2 Jan 2019 15:05:25 -0500
Message-ID: <CANaguZDcJa9NxZU4Z3Q7DqvQK5zsDXZKNbhbO8fcppnYrTxMHw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: rid swapoff of quadratic complexity
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 2:43 PM Hugh Dickins <hughd@google.com> wrote:

>
> Wrong.  Without heavier locking that would add unwelcome overhead to
> common paths, we shall "always" need the retry logic.  It does not
> come into play very often, but here are two examples of why it's
> needed (if I thought longer, I might find more).  And in practice,
> yes, I sometimes saw 1 retry needed.
>
Understood. Sorry, I missed these corner cases.

> I don't use frontswap myself, and haven't paid any attention to the
> frontswap partial swapoff case (though notice now that shmem_unuse()
> lacks the plumbing needed for it - that needs fixing); but doubt it
> would be a good idea to refactor it out as a separate case.
>
I shall rework the shmem side to take care of the frontswap and retain
the retry logic in a simplified manner.

Thanks again for all the comments and insights..

~Vineeth
