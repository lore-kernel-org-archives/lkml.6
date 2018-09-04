Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C57C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E11E2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Ptc+fP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E11E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeIDGOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 02:14:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45466 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeIDGOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 02:14:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id x26-v6so815451pge.12;
        Mon, 03 Sep 2018 18:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M6ncJl9HyZr5cLuYDo+nU0Lfl/cjCiI5Pz5GSaBRt8A=;
        b=d6Ptc+fP65UlLTeSXdAnIgbv/yGH9hzEUE4MDDu0558z+2A8CN2BPjLrjVwkewiF1O
         69nwO3M0RDndedJ5CbiGvtGS3E30Xy5Pipmqb+ljdzdWApYb4YJFWlX4vzALHQcUV/zs
         K1NeC6A6EBrk1dhe8wXl7iCtJdw3gviz2Ml9+Z1IHbgmTIvaS2FmvyefMbdbeE/bGXgd
         pO2AeMq06gEgdp1ujuRrBfofB2CnCRuk3HhgylZOIstkFa0pFuwbxEWamSXQjcEZgEpz
         WzLtjdPF70OwQe/sKNRq9iE+aTlwRs5voP7izVJMx19legSb/WBTrhnlXquMVGhph0OL
         0k7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M6ncJl9HyZr5cLuYDo+nU0Lfl/cjCiI5Pz5GSaBRt8A=;
        b=tQjdZjC2R5X1JWnWf+18xuivms7dGZ522ZE3pk45juhAD7zxxB6B/mST92NHfdW4fO
         eqypC5WZyOurSmvDhg3AYh/n72dXcaCUIgF8xggSibTl8niOlKgolOb2oPmbOCoFpoY7
         JDB2AVkQF6/0buh4F00/6FsZXaSWOQi5Bg1GEu6VOV73rVkTYnXec31Sjd2ghINpLC0d
         94wbh1/eyx5IqCKKEb3dt3W7BsmIyKi276XUjZ4dcy6dREUaUSytZOxs0vUdI/3iguAY
         Y6ZxewSyBwcZIIyy+QfJub4PYfm5ANvWUTeDavKkmKP1yQ/4ytUcXrLtJd0PbBKkXeCn
         4BwA==
X-Gm-Message-State: APzg51CleRgJWMvhwQ3qIArwuvKPqOyyteRrBvONg/sRTxRscyw8qTck
        /Y0L+FRNavOhPYZ45cQbNMc=
X-Google-Smtp-Source: ANB0VdaJniGMKD/AF5P+qM2TDigJ+uRuR0f0yUh713yKMlTzgFhMIiRiRzUN1xA9LGs0WPcJ45ycNw==
X-Received: by 2002:a63:e811:: with SMTP id s17-v6mr28948883pgh.176.1536025903579;
        Mon, 03 Sep 2018 18:51:43 -0700 (PDT)
Received: from localhost ([175.223.26.230])
        by smtp.gmail.com with ESMTPSA id e190-v6sm43670109pfc.81.2018.09.03.18.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 18:51:42 -0700 (PDT)
Date:   Tue, 4 Sep 2018 10:51:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 2/4] tty: Hold tty_ldisc_lock() during tty_reopen()
Message-ID: <20180904015139.GA4251@jagdpanzerIV>
References: <20180903165257.29227-1-dima@arista.com>
 <20180903165257.29227-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903165257.29227-3-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/03/18 17:52), Dmitry Safonov wrote:
> 
> We've seen the following crash on v4.9.108 stable:
> 
> BUG: unable to handle kernel paging request at 0000000000002260
> IP: [..] n_tty_receive_buf_common+0x5f/0x86d
> Workqueue: events_unbound flush_to_ldisc
> Call Trace:
>  [..] n_tty_receive_buf2
>  [..] tty_ldisc_receive_buf
>  [..] flush_to_ldisc
>  [..] process_one_work
>  [..] worker_thread
>  [..] kthread
>  [..] ret_from_fork
> 
> tty_ldisc_reinit() should be called with ldisc_sem hold for writing,
> which will protect any reader against line discipline changes.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: stable@vger.kernel.org # depends on commit b027e2298bd5 ("tty: fix
> data race between tty_init_dev and flush of buf")

I believe there's a "Fixes" tag for that

Fixes: b027e2298bd5 ("tty: fix data race between tty_init_dev and flush of buf")
Cc: stable@vger.kernel.org

	-ss
