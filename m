Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F73C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0F220857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0F220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeIJAJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 20:09:50 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:56225 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeIJAJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 20:09:50 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B08D020062;
        Sun,  9 Sep 2018 21:19:04 +0200 (CEST)
Date:   Sun, 9 Sep 2018 21:19:03 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     kernel-hardening@lists.openwall.com, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] kconfig: add hardened defconfig helpers
Message-ID: <20180909191903.GA2344@ravnborg.org>
References: <1536516257-30871-1-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536516257-30871-1-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=HtJaMnaozw0hSPeDYtIA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Salvatore.

On Sun, Sep 09, 2018 at 08:04:17PM +0200, Salvatore Mesoraca wrote:
> Adds 4 new defconfig helpers (hardenedlowconfig, hardenedmediumconfig,
> hardenedhighconfig, hardenedextremeconfig) to enable various hardening
> features.
> The list of config options to enable is based on KSPP's Recommended
> Settings and on kconfig-hardened-check, with some modifications.
> These options are divided into 4 levels (low, medium, high, extreme)
> based on their negative side effects, not on their usefulness.
> 'Low' level collects all those protections that have (almost) no
> negative side effects.
> 'Extreme' level collects those protections that may have so many
> negative side effects that most people wouldn't want to enable them.
> Every feature in each level is briefly documented in
> Documentation/security/hardenedconfig.rst, this file also contain a
> better explanation of what every level means.
> To prevent this file from drifting from what the various defconfigs
> actually do, it is used to dynamically generate the config fragments.

In the above you nicely describes what is done.
But there is nothing about the target group for this feature.
Who will benefit from this?

With respect to the actual implmentation we now
have two ways to handle config fragments.
Current solution is to save the config fragments in kernel/configs.
And the new solution is to parse the config fragments from an rst file.
The changelog fails to mentions why we need a new way to handle
the config fragments.

If we want to go the "parse from rst file" way - can it then
be abstracted in a way so this is the only way to handle
these in-kernel config fragments?
And then move the current config fragment to the new way.

It most be possible with a little careful design to make this
a general solution and not a hardening thing only.

	Sam
