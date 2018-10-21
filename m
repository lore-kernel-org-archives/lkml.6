Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB4ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D982083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 16:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="fQWYY3pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D982083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJVAPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 20:15:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40002 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeJVAPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 20:15:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so42269239wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5MSccZOEqnjhNSGPQZpGq+VkRvsflpd/GtKRNqMBv+c=;
        b=fQWYY3pntG1FgTWwxDLCGWNgpifXxy61XwIDqvyCbdanmpy4dwInjO22FkHxCy/5Vi
         /EcVZ3XWzyfsikXx1X50zPfnHkSuubnSKjT5dg/hCmp1vap0b9ehDzAHDiDM3xRQUNow
         S1pp4KAtCsHW8GP/jOxibxsnJmR5/oYo/txZ//ATRbgYrm888g+2+0ccMtXow5kl4RO9
         D9I2h62AxNy024Ub5ctryDjbZneSNPrkyd2ggs1VJ+GbxFY7N+Kc61mYxTTMSEsgz9R4
         DBJbNUuLr3DSaAN6QBbx1NExZDelzbp5bavRmct56CFKfb8uDg2I/BPdZB8VpubLl2Rg
         8hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5MSccZOEqnjhNSGPQZpGq+VkRvsflpd/GtKRNqMBv+c=;
        b=AofKy8Bwip1ewgW888JRFN8kdrl6e47NZWjgwyzKZO2NRMLN8cFaeirZHk3sEKRNBe
         btHKVxit+0i9Zcbm+5Egujd6CO0lIxmGBK6NTc3zLCDi4dWAgEfsBEmpn5LqN+C2S8mc
         lPioAIZGPL7djdhBwgnPX9rmJ2pULwHLTJkRCWOS2Tfv4SQgeVuh7KDyoOYKafFDbKxq
         oUvZQtkamM0xbkpyl8VHsT31Ogte8ALIw+WRdPDYBsEHghbEVuTfd7/DEChR/1KupQ5Q
         H7K/iM6JR0Vv2brLry/AucAHm4g6l8P6hegR5KqNyMdYvhV5Ty3DyrScQ0xe5Ylp+uLo
         vbFw==
X-Gm-Message-State: AGRZ1gLkkY3D8r3uRHPoZ12meltcTTE5CjzurrOIqHL2VXMh8KE5m/To
        fVzxuLT78jYmoEhIiZWA9PK43FTR1kq4dw==
X-Google-Smtp-Source: AJdET5dGc0Jxnp2APoFCxnDlW1Z6kka9cMEKoW3KHp0iXpgLxUGfRTjwNsREd5jLdVhn+0nPhA93Vw==
X-Received: by 2002:adf:df11:: with SMTP id y17-v6mr14237516wrl.58.1540137648041;
        Sun, 21 Oct 2018 09:00:48 -0700 (PDT)
Received: from cisco ([109.144.219.53])
        by smtp.gmail.com with ESMTPSA id 90-v6sm43785083wrg.86.2018.10.21.09.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 09:00:46 -0700 (PDT)
Date:   Sun, 21 Oct 2018 17:00:45 +0100
From:   Tycho Andersen <tycho@tycho.ws>
To:     Michael Tirado <mtirado418@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v6 3/5] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181021160045.GA25202@cisco>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-4-tycho@tycho.ws>
 <CALCETrXGBZyqDb7DEysHmOkxaBrXUp4s2X08HfqZkpjM28s3Hg@mail.gmail.com>
 <CAMkWEXNN2_saQN-yQ7Pwgau1YTYQQuih+KLnKj5-cOYa6CyMPw@mail.gmail.com>
 <20181017150022.GA7544@cisco>
 <CAMkWEXM1c7AGTH=tpgoHtPnFFY-V+05nGOU90Sa1E3EPY9OhKQ@mail.gmail.com>
 <CAMkWEXOywaUUy3=G+26G1uYOPw-pq-Wq68xSPmShuAMCGwfcbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMkWEXOywaUUy3=G+26G1uYOPw-pq-Wq68xSPmShuAMCGwfcbQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 06:15:47PM +0000, Michael Tirado wrote:
> Tycho, Sorry for the duplicate, I forgot to CC the list :(
> 
> On Wed, Oct 17, 2018 at 3:00 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> >
> > That's one of the use cases, but there are a large number of others. I
> > discuss a few in patch 1:
> > https://www.spinics.net/lists/linux-containers/msg33956.html
> >
> 
> Thanks this is making more sense to me now.
> 
> I haven't been keeping up with the list and just did a bunch
> of reading. It seems that stackable LSM's are making some real
> progress now, and I wonder if those patches are merged would
> using a stacked security module approach be worth exploring if
> it provides the same or greater flexibility, and assuming all
> syscalls of interest can be hooked somehow?

Sorry, I somehow just noticed that this was a duplicate and the one I
replied to was the off-list one. Anyway, no, I don't think that'll
work. The LSM code right now can't do anything besides refuse an
access, and that's a very specific design constraint of it. In
particular, it can't mutate any task state or anything.

What we want in this series is basically the equivalent of
SECCOMP_RET_TRACE, without having to involve ptrace (for a variety of
reasons, mostly that applications want to use ptrace for their own
things). So seccomp seems like the most natural fit.

Tycho
