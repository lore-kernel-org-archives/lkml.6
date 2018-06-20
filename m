Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26995C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23822083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aCWf3XQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23822083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeFTCo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:44:29 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50434 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbeFTCoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:44:25 -0400
Received: by mail-it0-f68.google.com with SMTP id u4-v6so3397582itg.0;
        Tue, 19 Jun 2018 19:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+FWQz0rXCmedyt4cMbmwK1B3pOX9q3DoFOC9AIwRvs=;
        b=aCWf3XQ/LIPB4cyxk2gFz5OHyhY551XlI+HvzMEHZQheLs5qYDfi96p7slnQbJmwZo
         r+0obAyATDoXcOUkOpuP315A2xE/8Ny7KPbzEWesrDbm7zQHd1INlxkjfjzTmBKUKtgH
         8v3t/lu4aLV1fljE4ovrfs7ROPwcT3ADsbRmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+FWQz0rXCmedyt4cMbmwK1B3pOX9q3DoFOC9AIwRvs=;
        b=ctCk1/2EmSXd+0XGy2o4u21k+Ei6dB60/r7rZzaQzoLGOwJjPLasuw4DaX5mkTXW7v
         etJGdv1qh0ODJYPk8j2mfZsKz85LjGUqWW575akDScVT+BPvAczA2uvMqZh61P6YbOdW
         sOjoQgcpz9aB2JqMwEzYJhVxp5HqGiCDIvE/U7xy9MFhEl4zgu3n+NQc+uIiXHp2nfFL
         oRKvXmSVquk9q6xtK9XLkEDF8cd23/4tjdERDINAbO4wpAOhuNGepBTVUCe4O/D9LAOm
         9oauZfv3c28ju3jYXt/uZ/ODS8YW8XSQ4mrNbvF9Tt7ip5Dbuzw+XQIUuiNS+9G0HGKv
         75OQ==
X-Gm-Message-State: APt69E2RjAvTbRPTdG57EeItAQ1H9QCuLtxc4RLZBgh9QJbVq6qopwuO
        Uaw17mnSFlDDqwRoQHgpRg5QeoaZa5O7ZbeSCnY=
X-Google-Smtp-Source: ADUXVKL7IIy3nu4udpEqE6ZO/pJOtgyrkoX18bkn1cFwHKFJhncyqtNmLOarltaZ6pu3MJTSw7s7/VSF6iRHOJuPiB0=
X-Received: by 2002:a24:5b81:: with SMTP id g123-v6mr150010itb.1.1529462664771;
 Tue, 19 Jun 2018 19:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop> <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz> <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180619223447.4369748b@vmware.local.home>
In-Reply-To: <20180619223447.4369748b@vmware.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jun 2018 11:44:13 +0900
Message-ID: <CA+55aFwpcbNO6FS4=O-BrsC4vMBaT3JeFG-_D9WtgmW+Dof3iA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port locks
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Perhaps we should do an audit of the console drivers and remove all
> printk, pr_* , WARN*, BUG* from them.

Only the actual _printing_ parts.

Just randomly, look at drivers/tty/vt/vt.c that does a lot of
printing, and there's a lot of valid printing. Things like

        pr_warn("Unable to create device for %s; errno = %ld\n", ..

is fine - it's done at console registration time if things go sideways.

But there are a few commented-out calls to "printk()" that are
obviously bogus, because they are in the printing path.

And they damn well should be commented out. The existence of something
like that SHOULD ABSOLUTELY NOT be seen as a "hey, let's make up some
crazy garbage locking ruls that would allow printing there".

Just don't do it. It's that simple.

                  Linus
