Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B6FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC068222E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/ZAOh68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407931AbfBNQba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:31:30 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33047 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfBNQba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:31:30 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so7569924qtz.0;
        Thu, 14 Feb 2019 08:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCPhC79Ynq2GtzpgHtutBm6gZohbYSC1Gc/5fhxTbHE=;
        b=L/ZAOh682bmeCwXiw0B97mMhot3GuGtPpGLnjk5NrnjiboxTg5eU4DfDFkquQUESxc
         35hTyLfS2tiOzWGmn26mdEv7jm8fI8T9kU9IoPgaY9c6v2yWhHrv5eJpvZALzpVOJUZJ
         KXQbg+qzI8rY4P68I6ikHbHy4s+Eqd8NC6WSkbi6vGV5Hi6q/RkjSmUJ0SOekCpqLWzb
         oTCAo3nk2IvzbqaOfi2w6SR3nZejzwiJU22yzEeNqPIZeOEbecqMomKCQOhACe0wYgX/
         cW5RZ4zyDwXE29Tkr/9PYVufgSQhkE8kd21k4/VRgdzUw0vU2fgYx6pRtqYx03xqEG7n
         YsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCPhC79Ynq2GtzpgHtutBm6gZohbYSC1Gc/5fhxTbHE=;
        b=D7jCaCpRlx6HkvJs64O2F2ijrJW1JTIOwNhrduF7BXAmHx4QYf3ZXlXeBmIEgZlz9J
         zCqgg5Bp+siOMXsf6z5Mk7gLodlkRFLYiE0f3exV+s6ibfHfoZNdB/zCXHZ4xixUCTh0
         yI5ezS0HconPIIkBs3Jh13yodGyv/zWDqKUFol2mEeKP1i212PQSNMuy2fIKIrDQo+JY
         szxCXJfO7pPItnJ8JTfXeDbQqeM7TWD+PQicwdYBiSqH2AGWikGfQVr9FNkl71QUfypB
         oQcbBp4UrstN41aSh1qGmxrwufrgAx8z882nzVpfLVCT20XMO5UAnYBpS6jAXUVJhQIw
         X7hw==
X-Gm-Message-State: AHQUAuaD3S6YjFy4OBcREo1XIoBBUQgs8UGGaLEnyZ5IR2Jpl8inFphC
        JbhCVK6hMS654xXrFYTUxjfbZ3VMhk9JNAVXx5o=
X-Google-Smtp-Source: AHgI3Ib+mT1o4iC9MbCdxnTlEUxYe8k8QB3csfG0ouVTwMsE2XEtRCU1wYJk56n3VaSZ4mzVHebOIJ/NcY8qaJJNX54=
X-Received: by 2002:ac8:1625:: with SMTP id p34mr3677365qtj.95.1550161889019;
 Thu, 14 Feb 2019 08:31:29 -0800 (PST)
MIME-Version: 1.0
References: <1550124158-1111-1-git-send-email-xiaoxiang@xiaomi.com>
 <1550124158-1111-2-git-send-email-xiaoxiang@xiaomi.com> <20190214130940.GV9224@smile.fi.intel.com>
In-Reply-To: <20190214130940.GV9224@smile.fi.intel.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Fri, 15 Feb 2019 00:31:17 +0800
Message-ID: <CAH2Cfb8UYMLpxb5DDPxf_C0umgPgLK8FBedhcNUcYQ_gLs2dFw@mail.gmail.com>
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

On Thu, Feb 14, 2019 at 9:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 14, 2019 at 02:02:38PM +0800, Xiang Xiao wrote:
> > From: Guiding Li <liguiding@pinecone.net>
> >
> > This driver allows the remote processor to redirect the output of
> > syslog or printf into the kernel log, which is very useful to see
> > what happen in the remote side.
>
> > +struct rpmsg_syslog_header {
> > +     u32                             command;
> > +     s32                             result;
> > +} __packed;
>
> Isn't packed already?
>

But, I want to make it more explicitly and prepare for struct expansion later.

> > +struct rpmsg_syslog_transfer {
> > +     struct rpmsg_syslog_header      header;
> > +     u32                             count;
> > +     char                            data[0];
> > +} __packed;
>
> Ditto.
>
> > +static int rpmsg_syslog_callback(struct rpmsg_device *rpdev,
> > +                              void *data, int len, void *priv_, u32 src)
> > +{
> > +     struct rpmsg_syslog *priv = dev_get_drvdata(&rpdev->dev);
> > +     struct rpmsg_syslog_transfer *msg = data;
> > +     struct rpmsg_syslog_transfer_done done;
> > +     unsigned int copied = msg->count;
> > +     unsigned int printed = 0;
> > +     const char *nl;
> > +
> > +     if (msg->header.command != RPMSG_SYSLOG_TRANSFER)
> > +             return -EINVAL;
> > +
> > +     /* output the message before '\n' to the kernel log */
> > +     nl = memrchr(msg->data, '\n', msg->count);
>
> Hmm... To me it sounds somehow fragile.
>
> If your text contains binary data, how can you guarantee that it would be not
> in the middle of two \n:s?

This driver is just for log/printf redirection, so we could safely
assume the data is pure text.
We have another rpmsg driver(rpmsg-tty) for binary data transfer.

> OTOH, if it text data, why do you need to take all strings at once?

Remote side may decide to buffer more log to reduce the IPC number
since IPC is a time consuming operation.

>  It might be worse from performance prospective (if you know how and when printk() supplies buffer to the console).

Yes, it's very slow if the log send to serial console. But in
production environment, printk normally just save in ram and viewed by
dmesg which is very fast.

>
> > +     if (nl) {
> > +             printed = nl + 1 - msg->data;
> > +             copied = msg->count - printed;
> > +
> > +             if (priv->next) {
> > +                     pr_info("%.*s%.*s", priv->next,
> > +                             priv->buf, printed, msg->data);
> > +                     priv->next = 0;
> > +             } else {
> > +                     pr_info("%.*s", printed, msg->data);
> > +             }
> > +     }
> > +
> > +     /* append the message after '\n' to the buffer */
>
> > +     if (copied != 0) {
>
>
>
> > +             unsigned int newsize = priv->next + copied;
> > +
> > +             if (newsize > priv->size) {
> > +                     char *newbuf;
> > +
> > +                     newbuf = krealloc(priv->buf, newsize, GFP_KERNEL);
> > +                     if (newbuf) {
> > +                             priv->buf  = newbuf;
> > +                             priv->size = newsize;
> > +                     } else {
> > +                             copied = priv->size - priv->next;
> > +                     }
> > +             }
> > +
>
> > +             strncpy(priv->buf + priv->next, msg->data + printed, copied);
>
> Hmm... shouldn't be memcpy()?

I use memcpy initially, but found that the unaligned exception happen randomly.
To avoid the cache issue, the IPC memory normally map as device memory, but
ARM just allow the alignment access to this type of memory.

>
> > +             priv->next += copied;
> > +     }
> > +
> > +     done.command = RPMSG_SYSLOG_TRANSFER_DONE;
> > +     done.result  = printed + copied;
> > +     return rpmsg_send(rpdev->ept, &done, sizeof(done));
> > +}
> > +
> > +static int rpmsg_syslog_probe(struct rpmsg_device *rpdev)
> > +{
> > +     struct rpmsg_syslog *priv;
> > +
> > +     priv = devm_kzalloc(&rpdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     dev_set_drvdata(&rpdev->dev, priv);
> > +     return 0;
> > +}
> > +
> > +static void rpmsg_syslog_remove(struct rpmsg_device *rpdev)
> > +{
> > +     struct rpmsg_syslog *priv = dev_get_drvdata(&rpdev->dev);
> > +
>
> > +     /* flush the buffered log if need */
> > +     if (priv->next)
> > +             pr_info("%.*s\n", priv->next, priv->buf);
> > +     kfree(priv->buf);
>
> I don't see how it's serialized. Does rpmsg core take care of this?

Yes, the callback come from a dedicated work thread.

>
> > +}
>
> > +#ifdef CONFIG_PM_SLEEP
>
> You can consider to use __maybe_unused annotation to the below function.

Ok.

>
> > +static int rpmsg_syslog_dev_suspend(struct device *dev)
> > +{
>
> > +}
> > +
> > +static int rpmsg_syslog_dev_resume(struct device *dev)
> > +{
>
> > +}
> > +#endif
>
> > +static const struct rpmsg_device_id rpmsg_syslog_id_table[] = {
> > +     { .name = "rpmsg-syslog" },
> > +     { },
>
> Terminator better without comma.

Ok.

>
> > +};
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
