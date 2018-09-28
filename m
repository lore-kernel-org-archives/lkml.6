Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED0EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EA9206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="GkoXDwZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EA9206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeI2DWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:22:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37936 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeI2DWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:22:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id r77-v6so5288046pgr.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 13:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ObDouDItvDbBB1kaU/M5VglmBpR6LkHJ8vh0jm5niVw=;
        b=GkoXDwZrQfA61EtwbX8WPYgkeY3T4JQ9XZgCTMktGJNMAuehDR4caExDJxGereATDV
         65QyXYBAMng3Tbihk+tiaKEFwWa4hYTT3wQAlC5hTb2gfOLt1WPtIsQpv7xDutZ3lwzD
         nmn5HD45Mzhsf4emyUbkTjKhF88RQh2FTQ4BE4UtnrRQI01GYY2pzDTFNvi80eapEO5N
         b75M3jo14QpezolBNWPDarqIvkxgchbQWampuoUNOrlxFUcREP4AnphEW6105eE+LDpN
         ZEkuf384fcd9XDtCcEtsT49zjz0zRq/2/35qqVinUdXvCai9XbeMDdt4hzuuT6uWg7pL
         EkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ObDouDItvDbBB1kaU/M5VglmBpR6LkHJ8vh0jm5niVw=;
        b=QPWHSlMiGiMZ/qNG+siYV0Ulygxlz11Dj3z+WRwoop1G98tUPvjgzkSwY+xFBdLjki
         CYXSu54mZs1Yiho/iigHUQzwyEE8TEF25gW3oEtHs34qdxvba0o7pDCKy92uPAsMuysX
         XYtvpNwsqzEQJAml2EkcJOIDZGzuIeAvGB5DEF8zg0iT7+0zT24sBTsQSXrbF7roAv+H
         hew22+PWSLntIF7Lb0u413MoEOLGCrwlV7Suq9JH+XnSAmFZZwp1xp2pn991FmGv9bqP
         0wH3kgOqwX0r6eI6ACDTpNckruB8s+Rn+9XWZ30t88UiREi9YtoXtcv2GdZfhn34t24W
         GVFQ==
X-Gm-Message-State: ABuFfoigejTEca09PEozzgj/qU7gPMao7f+it5ZSmUDxXCkkL1z0RBqT
        xBmP7K6I4RAedjPdxpFTlsH7uiE2toc=
X-Google-Smtp-Source: ACcGV60zkqSWpji7ZhvvernjsUxON+xGzQPonpcrpOgllrAUUrR+1Flt2cbUtU6c6QVrtQ3QAssGxQ==
X-Received: by 2002:a62:7788:: with SMTP id s130-v6mr285005pfc.189.1538168215002;
        Fri, 28 Sep 2018 13:56:55 -0700 (PDT)
Received: from cisco.lan ([128.107.241.171])
        by smtp.gmail.com with ESMTPSA id t63-v6sm9769451pfa.158.2018.09.28.13.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 13:56:54 -0700 (PDT)
Date:   Fri, 28 Sep 2018 14:56:52 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 3/3] seccomp: introduce read protection for struct seccomp
Message-ID: <20180928205652.GC18045@cisco.lan>
References: <20180928154648.6320-1-tycho@tycho.ws>
 <20180928154648.6320-3-tycho@tycho.ws>
 <CAG48ez2h51s1VG8hf1ASHHq88r5b+6rS4nSkgvre77jgsJLbhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2h51s1VG8hf1ASHHq88r5b+6rS4nSkgvre77jgsJLbhg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:33:34PM +0200, Jann Horn wrote:
> On Fri, Sep 28, 2018 at 5:47 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > As Jann pointed out, there is a race between SECCOMP_FILTER_FLAG_TSYNC and
> > the ptrace code that can inspect a filter of another process. Let's
> > introduce read locking into the two ptrace accesses so that we don't race.
> 
> Hmm. Is that true? The ptrace code uses get_nth_filter(), which holds
> the siglock while grabbing the seccomp filter and bumping its
> refcount. And TSYNC happens from seccomp_set_mode_filter(), which
> takes the siglock. So this looks okay to me?

Oh, yes, you're right. So I guess we should just change the comment to
say we're using siglock to represent the read lock.

Tycho
