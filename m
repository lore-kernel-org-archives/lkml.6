Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F278AECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B845521470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pNqkcI7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B845521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJSWsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:48:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53813 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeJSWst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:48:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id y11-v6so3892388wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=37iJmOmGflBJamskEDJHvC8FIWuDPqVYdR8BfPu9S9M=;
        b=pNqkcI7fCDhA/ncCMIWnGcJXM+6AFSTg5U0oxZa8crwV82Wj33fIdEeDv1Wym2fS0z
         bWegXKqaLNgiK3qVxKzhoICXWtJTJf3RjE/uiK5AuNQkCtSKX6XXWvLY5Fo78FTGek+a
         NC4PkSeOSAKZHLM6vQ2mFRoSOwYHehyol/KZDyqVmrRJ65iAQANK/7yjE8TIGaCTiEQW
         HznuiUXTw1LMeNXbIcryEFOH/tRsds31tpqbvIIGQ2zZOUFiSsBGv+hKA/qpblTrTq4R
         xNwqQ1llFZ+pW/kO1ahX4KBWa5TWf0eanke8KKjOuGI+DfTdFQ2n/p3XW8xo0MYXPftB
         S2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=37iJmOmGflBJamskEDJHvC8FIWuDPqVYdR8BfPu9S9M=;
        b=rwXqZ+nKvwjMHllDHxKl6fdOxcztPdzE7UtP8EC3h9UJgC72CYuJlxz94x+H+0iZU9
         BvEm+Pb5Ok2cH0VGDN49VrgN07rTXTNUjAbTY5Zi7b0K0uZX49+OiF+J4hSjLcPgLqum
         lQBNh/a3tFGSw82hTgCjSTVMVSF6HAmhhCJe2fDZLaY7T7QQDl4/6giodMbGA0pGirwo
         lsWu0JX0X7l+IvQl0kUj2fdfwdg7W849TPpbnGyboBAD4QnVM7zIegSS8Br9g+jQwYoQ
         iZbTwygtkPYF0E7w44uwongjYEhUVjROSQybYlM936poJyvrMUwVBvhXqUf6sPPZRvlR
         bTfQ==
X-Gm-Message-State: ABuFfojW2mJ9JdYK4Avh982jdzSaFUKZgz5C6V/ZI1wdn6gvoPmsKOaq
        IUjD4aW4Biu8wKru0PJ1Qlsq0w==
X-Google-Smtp-Source: ACcGV62nMSmjh9vTOfKgBt+owpOmErNVEHwwaqlHYgmUoR4DfJ37aSDIbrS0HCarWH3bsj42hwpzPg==
X-Received: by 2002:a1c:48d:: with SMTP id 135-v6mr5120038wme.102.1539960142429;
        Fri, 19 Oct 2018 07:42:22 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g10-v6sm18453067wrv.49.2018.10.19.07.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:42:21 -0700 (PDT)
Date:   Fri, 19 Oct 2018 16:42:19 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     andrew@lunn.ch, davem@davemloft.net, fugang.duan@nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
Message-ID: <20181019144219.GA8442@Red>
References: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
 <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com>
 <20181018184715.GA31736@Red>
 <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com>
 <20181018191612.GB31736@Red>
 <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:38:32PM -0700, Florian Fainelli wrote:
> On 10/18/2018 12:16 PM, LABBE Corentin wrote:
> > On Thu, Oct 18, 2018 at 11:55:49AM -0700, Florian Fainelli wrote:
> >> On 10/18/2018 11:47 AM, LABBE Corentin wrote:
> >>> On Thu, Oct 18, 2018 at 11:39:24AM -0700, Florian Fainelli wrote:
> >>>> On 10/18/2018 08:05 AM, Corentin Labbe wrote:
> >>>>> Since commit 58056c1e1b0e ("net: ethernet: Use phy_set_max_speed() to limit advertised speed"), the fec driver is unable to get any link.
> >>>>> This is due to missing SPEED_.
> >>>>
> >>>> But SPEED_1000 is defined in include/uapi/linux/ethtool.h as 1000, so
> >>>> surely this would amount to the same code paths being taken or am I
> >>>> missing something here?
> >>>
> >>> The bisect session pointed your patch, reverting it fix the issue.
> >>> BUT since the fix seemed trivial I sent the patch without more test then compile it.
> >>> Sorry, I have just found some minutes ago that it didnt fix the issue.
> >>>
> >>> But your patch is still the cause for sure.
> >>>
> >>
> >> What you are writing is really lowering the confidence level, first
> >> Andrew is the author of that patch, and second "just compiling" and
> >> pretending this fixes a problem when it does not is not quite what I
> >> would expect.
> >>
> >> I don't have a problem helping you find the solution or the right fix
> >> though, even if it is not my patch, but please get the author and actual
> >> problem right so we can move forward in confidence, thanks!
> > 
> > Sorry again, I wanted to acknoledge my error but I did it too fast and late.
> > And sorry to have confound you with Andrew.
> 
> No worries, here to help, let us know what your bisection points to. THanks
> -- 

So I can now confirm that adding "phy_remove_link_mode(phy_dev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);" fix the issue cause by 58056c1e1b0e.
The second problem (long time to got link) was due to my change of CONF_CARRIER_TIMEOUT.
I still dont understand why setting it to 3s (instead of 120) caused that.

I will send fixed patchs soon.

Regards
