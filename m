Return-Path: <cwahbong@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523931539; cv=none;
        d=google.com; s=arc-20160816;
        b=nbQPNpJvxDuyhlNCVwpH+XxBj3xrChyFKMxwWAcTqXCkgEliOUMo4V6oLRB/dQoesk
         QweR8df1jntCc4GQ51aT8F3is+M7DNJLgEr+6cjK9K92+ub+3ONlUdGryCqRzH1b/ixC
         Cdjdr1huRtTnHkr5I4W97iqjQQtff57VuMhqmn7Oi4theOAcLuamSL577TAHY0Rb68qj
         oNKQFedy9mCNPMo6xV+KaU+Z2x198PynsadvWfMc8OFRKTMAjqYEGtBMrEJ0kfPF64hM
         GAJ9iCthKxTi/t0AODVogeawVO7IJ6I8jOX43JXm5nECMbu272qB7wd70KuMxegNw8Sq
         O4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/2YU+M9HkyYVtoda8qoYKKFH0+vq4qOd7nfGKQNf9Ew=;
        b=hDokGlxt4osuvZaLpStzeKVEXa2WWEBQNJ4M+i92L9hx9NxLiSVnNtXVwuABeEkqz+
         L9MLmoeXG5FWbRu8AwcBGCQkL9a6A4YRtf2QQzFUhGjieUnKD5Qh5D9UTVC1HHjog76I
         BE0BtmM4tjJikySNs1klJyIYyqfyF0pKB1EN3j0DCKWuj9lyf8WkTtGRCPYgZ+JXeCaT
         /Zii4dhAaXHpbejcWihc943hY6/tyZ6o6uXmUgHm6Y9SLR4eFgO43HLFBwHllfCWX7Ek
         1rJ/zFqmdHZEpLe3mna3lBhkOlJstSzki9zocibMUVpOkgt7lIEuo1Vx48jSEWlnKhor
         Y+NQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SRyq7L01;
       spf=pass (google.com: domain of cwahbong@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=cwahbong@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SRyq7L01;
       spf=pass (google.com: domain of cwahbong@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=cwahbong@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+LQxPIJInuEk0bumg/QH9MzdwWiA9F+t/LiLEdLbt9Eys4Tce6fdpNIizcScjx3c247Ta9nOeum4r3XJiVDUc=
MIME-Version: 1.0
References: <20180416023626.139915-1-cwahbong@google.com> <20180416092444.05ec6434@gandalf.local.home>
In-Reply-To: <20180416092444.05ec6434@gandalf.local.home>
From: Ahbong Chang <cwahbong@google.com>
Date: Tue, 17 Apr 2018 02:18:47 +0000
Message-ID: <CAEvWiR--DLM2Tp8-OaZSh4LV9o8x2K47c9=-+VZFoDhedy=nZQ@mail.gmail.com>
Subject: Re: [PATCH] trace: add missing forward declaration
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Todd Poynor <toddpoynor@google.com>, Philippe Ombredanne <pombredanne@nexb.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597868580333311001?=
X-GMAIL-MSGID: =?utf-8?q?1597958037705398886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It does not fail with any config without this fix. This is for new work.

-- Ahbong

On Mon, Apr 16, 2018 at 9:24 PM Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 16 Apr 2018 10:36:25 +0800
> Ahbong Chang <cwahbong@google.com> wrote:

> > Without this forward declaration compile may fail if this header is
> > included only for registering other probe event without struct
> > pool_workqueue.
> >

> Is this for new work or is there a config which this fails with today?

> -- Steve

> > Signed-off-by: Ahbong Chang <cwahbong@google.com>
> > Reviewed-by: Todd Poynor <toddpoynor@google.com>
> > ---
> >  include/trace/events/workqueue.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/trace/events/workqueue.h
b/include/trace/events/workqueue.h
> > index 2f057a494d93..9a761bc6a251 100644
> > --- a/include/trace/events/workqueue.h
> > +++ b/include/trace/events/workqueue.h
> > @@ -25,6 +25,8 @@ DECLARE_EVENT_CLASS(workqueue_work,
> >       TP_printk("work struct %p", __entry->work)
> >  );
> >
> > +struct pool_workqueue;
> > +
> >  /**
> >   * workqueue_queue_work - called when a work gets queued
> >   * @req_cpu: the requested cpu
