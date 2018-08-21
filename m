Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05F9C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548D521837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KpqGNWbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548D521837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeHUX3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:29:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54397 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeHUX3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:29:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so1707wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=84h8Fo5YlLJ4rzOOl9q4jp5XjgxuxGrzq4zR+2yR+Z0=;
        b=KpqGNWbHqehBh8jP54vF+0cFC4eWGlHrc3gzy8wORkPpSCm81Z8FHsM7szqRxEbp7A
         ixC8q1UMv7uxkXqtWyEMJ+rN7JFBOfNLOhC6XcyFCczx3+UdSuriHtz4Bct3Vy86LAPk
         sIka46+3IpW3gLl0Uc3oLWueW4n3rUb0XS7j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=84h8Fo5YlLJ4rzOOl9q4jp5XjgxuxGrzq4zR+2yR+Z0=;
        b=jTkfx50WRAzJgAijavsGOtV7XaxrFgQgJ+eoLclCOr3lMzndukk6f7roM3uKkM0leq
         cYuKTN4Dg/VNkzbly5xlZTzPQx/uiFlh8Uuqj1m23FOWTAoOhWHFtJUUCOiPqqSTggo8
         wsTAXyHMR30hpSf1+CSt+UMErqofylDZLMQnVEIqG2nCcz1VUOIJYUZGgYBm2PdSr2pc
         pgnknGwwLbsCZnWiht62Fp1lKodHF+6FsPUteVOajFogy6xS4mcdTs8n66M0fPncaloT
         fyMqVL0psN0T3u9xYrARQAEMuqAF72sjWDG4lgkQpP0y8UVLiXcCNJfoXTfp0y5bVHgB
         jftw==
X-Gm-Message-State: APzg51C9JKy4ZYqqUQyHOhAMvDWbpjz3hPYVCucRZeSa0JZPRjSk4uuw
        h6Vq37CGaair7TmigWdW/+Ap6w==
X-Google-Smtp-Source: ANB0VdYKgEfxyG3imh4HSocPlAG+oYh3lKhm+JAj/jBg1AkCuSH+SNCKVEb0vKyzCRKeYww1WfMxxA==
X-Received: by 2002:a1c:1182:: with SMTP id 124-v6mr525997wmr.75.1534882064558;
        Tue, 21 Aug 2018 13:07:44 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id j3-v6sm11108331wrt.70.2018.08.21.13.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 13:07:43 -0700 (PDT)
Date:   Tue, 21 Aug 2018 22:07:36 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 4.19
Message-ID: <20180821200736.GA10412@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-4.19

This contains various bug fixes and cleanups.

Thanks,
Miklos

----------------------------------------------------------------
Andrey Ryabinin (3):
      fuse: Don't access pipe->buffers without pipe_lock()
      fuse: use kvmalloc to allocate array of pipe_buffer structs.
      fuse: reduce allocation size for splice_write

Arnd Bergmann (1):
      fuse: convert last timespec use to timespec64

Kirill Tkhai (1):
      fuse: Add missed unlock_page() to fuse_readpages_fill()

Miklos Szeredi (6):
      fuse: fix double request_end()
      fuse: fix unlocked access to processing queue
      fuse: umount should wait for all requests
      fuse: Fix oops at process_init_reply()
      fuse: fix initial parallel dirops
      fuse: simplify fuse_abort_conn()

Souptick Joarder (1):
      fs: fuse: Adding new return type vm_fault_t

 fs/fuse/dev.c    | 69 ++++++++++++++++++++++++++++++++++++--------------------
 fs/fuse/dir.c    | 10 ++++----
 fs/fuse/file.c   |  3 ++-
 fs/fuse/fuse_i.h |  5 ++--
 fs/fuse/inode.c  | 45 ++++++++++++++++++++----------------
 5 files changed, 80 insertions(+), 52 deletions(-)
