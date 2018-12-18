Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79FCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AC321850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+q4GS5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLRLRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:17:07 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:37990 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeLRLRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:17:06 -0500
Received: by mail-pl1-f178.google.com with SMTP id e5so7690207plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 03:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AAhV60gjLPi+uPXQSvPbLAB0Ic18RRXevOb0ibYLBjQ=;
        b=W+q4GS5gszUcBrFh7f1l5k5JJAPVXrK7tML5+W3KwEAqgsP7tux3ciRbVoqc5S9WlO
         45/rs359P+mL3i6XkQq3rq/2pBDjP+ZK3Uweu0dHIwHElhWVJ2bpO0vTXjlICLsdaJO/
         5EwaR9hcf5CPYb2mbsZ6EgRuU76IkKqSG1zMvMF/M9ZXpf0GSA7NPcQcHg39yhCEsUQs
         +qDL8wXMPBTmFqznqJDLBc7ANnA+WW72PykaRt/ViLSv2mqygo8R1RKgCfZlRfxIy2xK
         nxFlIojL4uOw754wdpCTWe5gvDXjZ6cKJd1yjYaogKoV+d9qeZoeEGGuDo64Bn6ItQVY
         RIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AAhV60gjLPi+uPXQSvPbLAB0Ic18RRXevOb0ibYLBjQ=;
        b=byLd7o8XXvhuFjEpEiQCqlTmo+IEWJOd+XvD5oHhYTfBlpbjZw3wog5J6CdBsueHDn
         tGSadbuiUjcyr2W/Dmh+26QnlmGmWMboWwl24xmBxZS5WpwAzLBcbWspd57DUEA+iTGV
         L9v6+0Q5XI0A5w8yNpuBkvwlvw1EE0S2YzbVySADZ9wIOMIGbVC3Nsen8YJKaENpRU9O
         TEqqvOKwoXeK6r5qnajT6X/58eF0hdYiVdh2cK9XAx9gJATdciwd/kaA7Xm7c6WxkroW
         84xFs36Mvv3X1bhkqjQzaS90Attb0pivGZdRwQPNNivrX5OIJ+Xw3y/FGzBJExOerrwM
         j2kw==
X-Gm-Message-State: AA+aEWa5ikqcBoFZSM81vi+I2uJhIzlehBUs9/9f/cjDsCzVlLS1S5TO
        xjJrrqD/u259gwL3EoCkhIY=
X-Google-Smtp-Source: AFSGD/WanpjJYcY0PCeJzE5TmC8T623oZd2UUXoyhzqvL26VoSPOhuTq+ldvNBx9l29snpZdcXD5Og==
X-Received: by 2002:a17:902:1127:: with SMTP id d36mr15544631pla.299.1545131825938;
        Tue, 18 Dec 2018 03:17:05 -0800 (PST)
Received: from localhost ([175.223.2.245])
        by smtp.gmail.com with ESMTPSA id p77sm29011960pfi.85.2018.12.18.03.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 03:17:05 -0800 (PST)
Date:   Tue, 18 Dec 2018 20:17:01 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218111701.GA32522@jagdpanzerIV>
References: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
 <20181218104812.GC15430@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218104812.GC15430@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 11:48), Peter Zijlstra wrote:
> > I know that there is a "kernel.printk_devkmsg" interface; do we
> > expect every systemd-enabled distro to find that out and to tweak
> > kernel.printk_devkmsg or shall we change the default devkmsg
> > ratelimit instead?
> 
> How about we complain to systemd instead?

We certainly can. As far as I understand, they log shutdown events
(including errors and warnings): what they kill, what they stop,
what they umount, etc. The more partitions, services are running
(I guess), the more things they need to umount, kill, stop; hence,
the more messages. I kinda can imagine what they will answer ;)

The below (and a bunch of other) messages are getting ratelimited.
I'm not sure what will happen should any of those steps fail and
print warning-s. My guess would be that we probably can ratelimit
those warnings:

...
 systemd[1]: Unmounting /home...
 systemd[1]: Unmounting Temporary Directory (/tmp)...
 systemd[1]: Unmounted Temporary Directory (/tmp).
 systemd[1]: Stopped target Swap.
 systemd[1]: Unmounted /boot.
 systemd[1]: Stopped File System Check on /dev/disk/by-uuid/a0737dff-e797-44f0-aea7-d0df1107ff63.
 systemd[1]: Stopped File System Check on /dev/disk/by-uuid/5d773b72-e200-4d11-a219-176d62a16d8d.
 systemd[1]: Unmounted /home.
 systemd[1]: Stopped File System Check on /dev/disk/by-uuid/35319ddc-9b92-4ab0-aaa4-9922db636a5e.
 systemd[1]: Unmounted /media/edev.
 systemd[1]: Stopped File System Check on /dev/disk/by-uuid/da00daaf-5601-4531-912e-bd69103b379d.
 systemd[1]: Unmounted /media/dump.
 systemd[1]: Reached target Unmount All Filesystems.
 systemd[1]: Stopped File System Check on /dev/disk/by-uuid/b52da2df-161b-4c33-b700-277d95b9672f.
 systemd[1]: Removed slice system-systemd\x2dfsck.slice.
 systemd[1]: Stopped target Local File Systems (Pre).
 systemd[1]: Stopped Create Static Device Nodes in /dev.
 systemd[1]: Stopped Create System Users.
 systemd[1]: Stopped Remount Root and Kernel File Systems.
 systemd[1]: Reached target Shutdown.
 systemd[1]: Reached target Final Step.
 systemd[1]: Starting Reboot...

	-ss
