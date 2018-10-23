Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF240C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D05204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXeQER+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D05204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeJWU16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:27:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42843 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWU16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:27:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so545578pfn.9;
        Tue, 23 Oct 2018 05:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VNKnMiwBOqALk63eHod04cZGppVy4M+HlTTPYN7x+hQ=;
        b=UXeQER+9XTQrI94qK0s9AccZPMgBWIR4SUamefeMhx/p9Vp+KAB+2KLttHO7N2RdMb
         B5LfgOpRct7DO2KbVGzb5H4rVedsmt1gfYU22EKifam4ny5YrjZFNnd9heHdQ4NF9hyp
         iAqAVpq98LiFrJmOhocFBt0X1JcbxLwMRbSkU5MpH7df62nhkqpdTaeJbLKS81DiTBs0
         ddZ/I/FTWlYGQt6WK0JQvi/0b6uTu9Taw2PX76v1hGRMs30fTiM6+Jj3vV0SoZoStCbh
         BxvQrpyX3GVlm9JZqyQiJogDfEhc0ifZ5iMLVDsUpi0oWnfSApPgz+tzvpF25kvpFxGi
         lC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VNKnMiwBOqALk63eHod04cZGppVy4M+HlTTPYN7x+hQ=;
        b=a7Dm+umU3YNXrX1iD4Pi6JdN/cAJQ/jjT8H1/30UaX1Svo8xs0EE/OlO/oIQOxwgS2
         t+yb9sY3Cel4jY+nk4fZkqPcZRjNQZtRgZV089GeVSvb/X0VrMZg9sop1DFLi/+qoRhK
         0W/evIqb6HQHoLsuGv22SsdYbbfu6VOeEZ5mYu6O4apLGANvY1OFPS6eUJHk2EHm3JKN
         efO68CmQZOHPTXvZ3MqB0Teyi8MtNTdO+5MC/27Fnii+fnxpYYoEMTRVa7eS9gqeKtEC
         eOCDYci0sLcQ9KQwdaNlNJREsWb+FY6sKfeMt4ZqoSuH0eJ9es3MjXSTytZ+QLK9bTWF
         5sAw==
X-Gm-Message-State: AGRZ1gJFcd+y7/Ig5PAMYn3okYnKuktiT6HgXSmWqjfdOPoQChML4onr
        +YPoHZfslBFGR2L73FkjTyI=
X-Google-Smtp-Source: AJdET5fWn7ryG7gk6+TbvB9Ftw+vHQnY5ifXcC7SU4nTJfWTvWrUAOU6TC0QmLynDXVjf2FtVJNRxQ==
X-Received: by 2002:a63:c802:: with SMTP id z2-v6mr7021666pgg.78.1540296285663;
        Tue, 23 Oct 2018 05:04:45 -0700 (PDT)
Received: from localhost ([175.223.11.183])
        by smtp.gmail.com with ESMTPSA id o9-v6sm3276680pgn.30.2018.10.23.05.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 05:04:44 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:04:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Message-ID: <20181023120441.GB10251@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
 <20181023115433.GA10251@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023115433.GA10251@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/23/18 20:54), Sergey Senozhatsky wrote:
> So I did look at what lib/bust_spinlocks.c does; and I agree that waking
> up klogd makes little sense, on the other hand it just sets per-cpu
> pending bit, so not a big deal. console_unlock() should do there the
> same thing as console_flush_on_panic(). Yes. However, a bit of a bigger
> argument:
>    __attribute__((weak)) suggests that bust_spinlocks() is arch-dependent
>    and it's up to arch to do some extra stuff there [if needed]. So that's
>    why I decided to keep bust_spinlocks(0) in panic() and, thus, call into
>    arch-specific code (or common bust_spinlocks); then bump oops_in_progress
>    so serial consoles become re-entrant and finally call
>    console_flush_on_panic().

Seems that s390 is the only arch which defines its own bust_spinlocks().
Not sure why... Just to play games with console_loglevel?

---

void bust_spinlocks(int yes)
{
	if (yes) {
		oops_in_progress = 1;
	} else {
		int loglevel_save = console_loglevel;
		console_unblank();
		oops_in_progress = 0;
		/*
		 * OK, the message is on the console.  Now we call printk()
		 * without oops_in_progress set so that printk will give klogd
		 * a poke.  Hold onto your hats...
		 */
		console_loglevel = 15;
		printk(" ");
		console_loglevel = loglevel_save;
	}
}

---

The "printk(" "); without oops_in_progress" part is a bit worrisome.
This thing technically can deadlock. Unless s390 has no NMI panic().

	-ss
