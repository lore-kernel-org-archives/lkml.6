Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1974BC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA41D20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMhRqtha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfAUVZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:25:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53683 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfAUVZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:25:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so12193233wmb.3;
        Mon, 21 Jan 2019 13:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7RtVWnI7IlB/Hix+NvRDOmFAi75yUvewN2ZyW5xLqYc=;
        b=MMhRqthamkozvZX6NByVgJP7saX9eD80xi7/JkKLyWVgoHx03bdkA7GZ97da8yBHd8
         OiXmTyg/OuRPjcQ3JiMR3Zz5J+2oB9cDs+WI5pCWzaY/5467JlhQKA5dQAUk0VhLoUu7
         MFJzsa3mlC2o/CNtGMhgE4gZ9c5D861UtkCd42e6TCmATJfMz/evy7XDvniVPuYPrtoV
         R3/NWtDKkvgg5ZANLiZbbYIhoZ68UFH5FiQDouul5sEmoJaG3ssGgQxiW7J0DPQW5ZBk
         dLBQpvgJ4X56hShwt/wbPQlGUfQRPKkbtPPUkZPaoIxhDL/hCY7wUC/fwwe54JEyC+qP
         Isew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7RtVWnI7IlB/Hix+NvRDOmFAi75yUvewN2ZyW5xLqYc=;
        b=OzxpOjGp9oLfI4wJ2IHwYZKVGhQqWVAR3RmariJuQsZQ8xry+j73niJHprSMuWFH9F
         yUIStWsbeDPNrvV1y2vNWkAkgqucK5skHzaVoehFnSIVghKV4o+7v0xgnpQaPKtn+5mH
         QABOYnbsjTagZhEv/w3Kg55MZe6Vi+3lZcKJdMdEPR6qY3P4Yylfq690tdtkfV9exc2K
         jxIRHWgHHltA9kWEd9wrpVnwuX+UMRghhFREoqSYsnP3nczzdkOud1/mfV82exmGsf+0
         QFs5qtjaNF/sG2O5cCqaot+PwWTwGSWF69ZHCqyWyW0vWTYVrOHsmyFSJse9+oummX51
         iJZA==
X-Gm-Message-State: AJcUukcEShZ8WENjq0lEIUWE+5+g9WWxZ4Cgw1pYhhk7NeqqzG4sJUC8
        vbVSBeheVemRxzfr8LFw7A==
X-Google-Smtp-Source: ALg8bN6nGHilyvsvwLcTiGPMJ/N0snBFSy//cK7LZC6/QpPBhdlX6KbQ5PE2WuA5Xg6u1n2WCy4bgQ==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr927468wmj.48.1548105919932;
        Mon, 21 Jan 2019 13:25:19 -0800 (PST)
Received: from avx2 ([46.53.246.246])
        by smtp.gmail.com with ESMTPSA id s8sm108333112wrn.44.2019.01.21.13.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 13:25:18 -0800 (PST)
Date:   Tue, 22 Jan 2019 00:25:15 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>, LKP <lkp@01.org>
Subject: Re: [LKP] [/proc/stat] 3047027b34: reaim.jobs_per_min -4.8%
 regression
Message-ID: <20190121212515.GA18118@avx2>
References: <1546873978-27797-3-git-send-email-longman@redhat.com>
 <20190118084456.GA10690@shao2-debian>
 <CAGXu5j+aEs3bq5Ym+VCYGmPQNJZC44vFk9MJDxH1zq=hZ3N4CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXu5j+aEs3bq5Ym+VCYGmPQNJZC44vFk9MJDxH1zq=hZ3N4CA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 09:02:53AM +1300, Kees Cook wrote:
> On Fri, Jan 18, 2019 at 9:44 PM kernel test robot <rong.a.chen@intel.com> wrote:
> >
> > Greeting,
> >
> > FYI, we noticed a -4.8% regression of reaim.jobs_per_min due to commit:
> >
> >
> > commit: 3047027b34b8c6404b509903058b89836093acc7 ("[PATCH 2/2] /proc/stat: Add sysctl parameter to control irq counts latency")
> > url: https://github.com/0day-ci/linux/commits/Waiman-Long/proc-stat-Reduce-irqs-counting-performance-overhead/20190108-104818
> 
> Is this expected? (And it seems like other things in the report below
> are faster? I don't understand why this particular regression was
> called out?)

No, but the sysctl has been dropped, so the point is moot.
