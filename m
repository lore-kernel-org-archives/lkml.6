Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E423C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7952184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nldxZ75+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbfA3Q0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:26:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35050 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfA3Q0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:26:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so122971ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3SVNRQz+X4Hk9bSAF5GyFdZKD0z7Vt5Oq5UNt9Q9q6Q=;
        b=nldxZ75+1lLZYS1pcbAgSQ18WXPSb7H9T4+DSVwhkjeYNDaRZ+3cd/fzHKh7q0hp1v
         kVZwh5M50p4Lpqd88YRvIfWL5QH05Y8z2/Cb/KpU44L/x324pnQ1ycEhVXa7GbJLMVit
         0WDPvGw9gQIgEfjP8Bo/qQgb9fMCzqF+vfRdetA5nMkblr4N1y0h/ATSrcYzFMiN9UMm
         iy4FKBdJnJ9nT3dqz+CQ0LzFgQ0hWVvmuM8eTCLj5m7xg8RO2ANjpBAqDMbfb0dYGFX3
         AHkNcyBWC4R+xgSKn5XSSJ/KoiPhi6vjLGpgo5MKomDp9Q+epyi8DpMT52lOLqFfn3P+
         m6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3SVNRQz+X4Hk9bSAF5GyFdZKD0z7Vt5Oq5UNt9Q9q6Q=;
        b=D53bwkw8TD8vSOur7lJVPsn8Izul+KxV5sVAviTYwxvDCYLOdmHHUjmkcyosYJnCP6
         dtwPN1KlKYrjjW7w8rL7Fz/Zwf8Je3001STMwjYR9Y3XNsvQqlvTBP5hsfbKmgCiG0Zh
         3h+zAgDfTFQo0jBuw9jtXrMQIMX3bOuvZnRhe/0mdxwzeek5eRA2qpyn7HWyJyBOGvW5
         R68pRAWpa9NzOgGN27bUaazkEzSV/3F9P6lgZMBrtEc0ZpjG/qjbjETRMFDbc+vfvDUm
         Ly/yl7Qc25So7ODumrfbMjEgsK5UPoBzfpZR7pW+LAmstEuG7Q91WdDMUN7Zekx5jx16
         REyQ==
X-Gm-Message-State: AJcUukf4BkJc181SsgBWsQZqeDaOnLsQ2yrZEPv+zR1DbEP/xi04lvnG
        7onr/2E0/WxjoD/K2AKjTpvuElXj
X-Google-Smtp-Source: ALg8bN4pRQjnb36ixk+6o86Pzm/aqRRsQ6PYtW7uDc9JBrul8QnYPDEnDyccaTvUues47rdDduvTmw==
X-Received: by 2002:a2e:9cd5:: with SMTP id g21-v6mr24742223ljj.48.1548865601896;
        Wed, 30 Jan 2019 08:26:41 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id 11-v6sm345985ljv.1.2019.01.30.08.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:26:41 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id DFA9E46077D; Wed, 30 Jan 2019 19:26:39 +0300 (MSK)
Date:   Wed, 30 Jan 2019 19:26:39 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next] fs/splice: iter_to_pipe -- Use PIPE_DEF_BUFFERS
 instead of hardcoded number
Message-ID: <20190130162639.GA25251@uranus>
References: <20190130153911.GJ2332@uranus.lan>
 <20190130154245.GK2217@ZenIV.linux.org.uk>
 <20190130154851.GK2332@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130154851.GK2332@uranus.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:48:51PM +0300, Cyrill Gorcunov wrote:
> On Wed, Jan 30, 2019 at 03:42:45PM +0000, Al Viro wrote:
> > On Wed, Jan 30, 2019 at 06:39:11PM +0300, Cyrill Gorcunov wrote:
> > > And use ARRAY_SIZE for easier code modification if we ever need in future.
> > 
> > Umm...  Why PIPE_DEF_BUFFERS, though?  Because it's a constant from more or
> > less the same area that happens to be equal to the value we use here?
> 
> Yes. Since plain 16 value completely unclear where it comes from. I looked
> into your commit which made this change and seems previously we've had this
> constant related (79fddc4efd5d4de5cf210fe5ecf4d2734140849a). Am I wrong?

Thinking more I'm more convinced that i'm wrong. Also it is related to
this default size, the code can pretty well use (alsmost) any other
constant here. Al, drop it please.
