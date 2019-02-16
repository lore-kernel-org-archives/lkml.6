Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F70C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73188222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXwQlNwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfBPQwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 11:52:17 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38640 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730824AbfBPQwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 11:52:17 -0500
Received: by mail-qk1-f196.google.com with SMTP id p15so7611325qkl.5;
        Sat, 16 Feb 2019 08:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AZRpga7WZSwULEfcZxbF8AYTLLB/CdEksXg9BuCwV4=;
        b=RXwQlNweEgqjMfrSqzM7TqF8kwqLWyA32uf1nw2fQEHwr5dOufxFFnfNbsc8a4NnmW
         FyvWa8qdS94xxxzozhEuZgVAXSo++CaYPXFWlJusbI0JKKXu30EZ7Uvt8t20IkPT/pap
         /Ac/Tt4clhovyFLBATaYzuBExyoBb2TgyFngnPjav0P6tIHvmYQ9l3P81RkaugfhnlV1
         hoOUWHojcNGRGt6KmJjAFhTR3WvF6MYkcoS5SmRJUi3Fipv88hV0123Uxf/a4uCOHov9
         k1zCnz4pRk8WpVAnyI6cwsKT5b3/MU41wZE28JsyQhERYog1bWDheTHko6lex4cWDrot
         4zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AZRpga7WZSwULEfcZxbF8AYTLLB/CdEksXg9BuCwV4=;
        b=jlkjSTkakaXf6odMxvgGkRXJ2UPNQ0vGZbxd8Tt9uT8fpdHtWrQuif6rdgbN285Kyl
         YshSA1b30JDqNyK+N9RO4A72CA7uwWry5U3YsL4OlpBmhBLlA/JgHta5BO0yjKLsEEcm
         lIn1ryg311rkHNZ0tCcLpD0BUuxX1ueKmhzP+uX824AHxyjFGnyPdvY7gENQBm7JT80K
         RVboPH+zp1yNaxgaLM01IaNhe1QgJKkrSA8xZ9K6pXuWKQJcD6hdAa0v1FCMvJpsZqBk
         2XnkmcQcXOL54uEE1CcqVMK4CvuzaRQ3TgKleCJ83jNQgiQV1AqQyFEXwQqvGso5iv9J
         yIpA==
X-Gm-Message-State: AHQUAuaPoYYbYa0FWAL2owb2N3ROHuHZS7WlvB+rXnYkxf6VzhYTf/Ww
        XXQeesIN1tAhgfHZPjO14dH/CDizhH99nhTmGhY=
X-Google-Smtp-Source: AHgI3Ia/51l3iU6OVlJglvhJrxugtuNJeBqAINswl0Oq/jw5u2VueKRMfjw3KH0Zy4zrc6sMimd2GwHdGSqfPcCeSxo=
X-Received: by 2002:ae9:c106:: with SMTP id z6mr11046961qki.197.1550335935723;
 Sat, 16 Feb 2019 08:52:15 -0800 (PST)
MIME-Version: 1.0
References: <1550124158-1111-1-git-send-email-xiaoxiang@xiaomi.com>
 <1550124158-1111-2-git-send-email-xiaoxiang@xiaomi.com> <20190214130940.GV9224@smile.fi.intel.com>
 <CAH2Cfb8UYMLpxb5DDPxf_C0umgPgLK8FBedhcNUcYQ_gLs2dFw@mail.gmail.com> <20190215150620.GB9224@smile.fi.intel.com>
In-Reply-To: <20190215150620.GB9224@smile.fi.intel.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Sun, 17 Feb 2019 00:52:04 +0800
Message-ID: <CAH2Cfb-TDnmWYLFr_MQr7Uhvsyzf80nVaSbYGoQkVQGj-uTqiw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] rpmsg: add syslog redirection driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        alexander.shishkin@linux.intel.com,
        Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wendy.liang@xilinx.com, Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guiding Li <liguiding@pinecone.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:06 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Feb 15, 2019 at 12:31:17AM +0800, xiang xiao wrote:
> > On Thu, Feb 14, 2019 at 9:09 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Feb 14, 2019 at 02:02:38PM +0800, Xiang Xiao wrote:
>
> > > > This driver allows the remote processor to redirect the output of
> > > > syslog or printf into the kernel log, which is very useful to see
> > > > what happen in the remote side.
> > >
> > > > +struct rpmsg_syslog_header {
> > > > +     u32                             command;
> > > > +     s32                             result;
> > > > +} __packed;
> > >
> > > Isn't packed already?
> > >
> >
> > But, I want to make it more explicitly and prepare for struct expansion later.
>
> How? Why it's not in this patch / patch series?

Just for future, not now:).
Since this structure is shared by the different CPU/OS, it's better to
indicate the packed explicitly.

>
> > > > +     /* output the message before '\n' to the kernel log */
> > > > +     nl = memrchr(msg->data, '\n', msg->count);
> > >
> > > Hmm... To me it sounds somehow fragile.
> > >
> > > If your text contains binary data, how can you guarantee that it would be not
> > > in the middle of two \n:s?
> >
> > This driver is just for log/printf redirection, so we could safely
> > assume the data is pure text.
>
> Then I don't see a point to use memrchr() at all here.
>
> Use strchr or strrchr().

Yes, use strnchr is enough, I will remove memrchr in the next review.

>
> > > OTOH, if it text data, why do you need to take all strings at once?
> >
> > Remote side may decide to buffer more log to reduce the IPC number
> > since IPC is a time consuming operation.
>
> So, you always can do something like
>
> p = msg->data;
> while (...strsep(..., "\n")) {
>         pr_info("%s\n", token);
>         ...
> }

Can't use strsep here, since log come from remote isn't terminated by '\0'.

>
> >
> > >  It might be worse from performance prospective (if you know how and when printk() supplies buffer to the console).
> >
> > Yes, it's very slow if the log send to serial console. But in
> > production environment, printk normally just save in ram and viewed by
> > dmesg which is very fast.
>
> You may not do such assumptions. For someone it would be RAM, for some
> customers it might be a slow channel.

But we need reduce the IPC number, so both fast/slow channel could get
the benefit.

>
>
> > > > +             strncpy(priv->buf + priv->next, msg->data + printed, copied);
> > >
> > > Hmm... shouldn't be memcpy()?
> >
> > I use memcpy initially, but found that the unaligned exception happen randomly.
> > To avoid the cache issue, the IPC memory normally map as device memory, but
> > ARM just allow the alignment access to this type of memory.
>
> So, than it's an architecture level issue. With strncpy() here you will get a
> pretty rightful GCC warning.
>

Why GCC warning strncpy here?

> > > > +     /* flush the buffered log if need */
> > > > +     if (priv->next)
> > > > +             pr_info("%.*s\n", priv->next, priv->buf);
> > > > +     kfree(priv->buf);
> > >
> > > I don't see how it's serialized. Does rpmsg core take care of this?
> >
> > Yes, the callback come from a dedicated work thread.
>
> Please, add a comment explaining that.
>
Will add in the next review.

> --
> With Best Regards,
> Andy Shevchenko
>
>
