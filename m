Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19458C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03232083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjjTilnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03232083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937468AbeFSI10 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:27:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43031 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937267AbeFSI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:27:22 -0400
Received: by mail-pl0-f66.google.com with SMTP id c41-v6so10543223plj.10;
        Tue, 19 Jun 2018 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cl5YUUfahVyIU9R3gjgQfDHBHuT86a9lKZ1k2NtdW/Q=;
        b=GjjTilnPZDabGAMBiuDKdojVpkzvxapfI68vtNbrNztyscWORRCvK9iOaLr88CTszZ
         9nUrSIO3ThKDMk51Rj/EE/OtdHajC+4s/dv+D0HKu4Vdxcfxb4r9QMQnzPuqQwR2MGnG
         HVsZKVkF3v3UR+OdYtVByityUyzGpyJNVzxbhrs/QA7Unv7frTztjHPN+k5fddi1cMV6
         zKQvIWhyUX+PoP4heimiuVGxCXRfRwU+gQjXHxAzuhCtL/feFYqqcqMYSi8A8JzGTYni
         Q8DkFelWoxtBOdBPEZ3B8BApmumtQvGNL3k6h16ec/+whQ2b9nlSlxBWlhvVOh5HvSfw
         FXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cl5YUUfahVyIU9R3gjgQfDHBHuT86a9lKZ1k2NtdW/Q=;
        b=NqFvOWJFHuBQU/9pMtOa1SSdgIfx0HVWQIIem3tBUNNeT143l3Mpp04Kv4g7K12aFt
         WTGB9NcKVtWKtMCUDgPp3hYl4uGVHTtuEgmGdfbRITijKPf8SMQz7K3pHgwaWBnEx2+G
         hWAvAQojcVX1ZuvGU+82SnRA4bl0hP9Jy87ZySDm3Eb+zeFpvEGHth5TyufJVhzOyi6r
         8k7RiQzfy+b4YaGLyuljiFgWUVhH1tn+9xKtA/hh2K6A+mo5KqBwGRz8lgfDzb7fF43r
         /6qhf7wGqM0McFPX5GjKGttIbEgADyZWR5vYjhECh0Z5ddbw6ZH76EBPY6FcLaIetBAq
         gy3g==
X-Gm-Message-State: APt69E1wkNUE9AJJxFqk5mmA62BkFO/D4CWCTKOkS0w+FUUZ5Iw0U4aG
        scRXOxzFBz829LuPclMwvMY=
X-Google-Smtp-Source: ADUXVKKiejMpK83JZB2IbnyktzealVMPcJMZnxLJRdQr2MomiHHXQssNZ8TYNMFYj1ntK5DKsW4jYg==
X-Received: by 2002:a17:902:8341:: with SMTP id z1-v6mr17988413pln.40.1529396841854;
        Tue, 19 Jun 2018 01:27:21 -0700 (PDT)
Received: from localhost ([175.223.26.106])
        by smtp.gmail.com with ESMTPSA id a11-v6sm21099193pgq.32.2018.06.19.01.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 01:27:20 -0700 (PDT)
Date:   Tue, 19 Jun 2018 17:27:16 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180619082716.GD405@jagdpanzerIV>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
 <20180606051029.GA19211@tigerII.localdomain>
 <20180606103356.GB19211@tigerII.localdomain>
 <20180608104825.e7xoxteelaxnwx66@pathway.suse.cz>
 <20180618063738.GC27996@jagdpanzerIV>
 <20180618093917.qeaatnlqh5if6t3r@pathway.suse.cz>
 <20180618100718.GA555@jagdpanzerIV>
 <20180619075219.iq7ztwu43bn4uua7@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619075219.iq7ztwu43bn4uua7@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/18 09:52), Petr Mladek wrote:
> On Mon 2018-06-18 19:07:18, Sergey Senozhatsky wrote:
> > On (06/18/18 11:39), Petr Mladek wrote:
> > [..]
> > 
> > Hmm. Can't answer right now :)
> 
> Please, let me know what name you would like ;-)

:) Wow, it's hard. Maybe we can derive some bits from the ftrace_dump()
function name? Dunno... Does printk_dump_nmi_enter() sound terrible?

Maybe Steven has some opinions on this?

	-ss
