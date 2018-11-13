Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B112C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B7F22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synesis-ru.20150623.gappssmtp.com header.i=@synesis-ru.20150623.gappssmtp.com header.b="PioLzb2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B7F22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synesis.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbeKNDKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:10:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45861 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeKNDKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:10:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so11463077ota.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 09:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synesis-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sONZB0oIFUK5PlOoydpDm/JsssT9XxKAV6Zt/3fKM44=;
        b=PioLzb2MX1KI/x5KZkRLtrhZZ38Dc+MbNqq0yObAVIwK/g4dZsktDK8BdiIstRLhn9
         l91asblLoqzsTm4EeQ7ZCCszATbFvpqlAyEaJaRVAro8EG0quxD8Kqrnedlflk95RGIp
         OWykGnRGFebXD9hcev8JPf66izjha4wM3ve1CPjR2CnEyQvxpg21DzMFvVD0JrxQ9apb
         bi6SYQpjoxWOnQCuL/lH3Z8yO5W854Ty+sw0n7kYj8uzXw/5uMZks8PO4N3qjrnjS1UY
         kuzZtmpjVn3S2NqcJVluJRw5qCswwhyfl0Q6oZ1KCS85c4FvayfmoQCw5JsxF24ka643
         KsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sONZB0oIFUK5PlOoydpDm/JsssT9XxKAV6Zt/3fKM44=;
        b=CVCmu3guVRXgp+3lDaLOBXQkDE54j92cry0O99HVr6xz+J2+QdChnd4fyZjFyL42se
         OgItpMbTh2u4hbT4SqZ3aF9hrEeGVQ+twVuRLDjwYbyTIPKCu/Y8R8a3uO3IPRUPHFFc
         0Lu2cdxzC3fRektIbRB0+UTk7XVzx8mkOMBUUSYHp9lgV7rgDJvifKePTxRLQ4M6tySp
         7aDzNCLHwHJJgNpBFbU3fCooJPC7gg/2e810Wf0I+YXPJ/qrjSiIjGJvAtSN34oucFv8
         tjCNcW+NR1mTT7wv2B3HW0xAuKEhB4R36FysQ3B1OLRFUf8v7taaDVKzEuywpxCHqJON
         MFMg==
X-Gm-Message-State: AGRZ1gLrTmZWHIjFRJjd7f6nAypHrZyh10qJgDcUY47qJC1B413bBWq2
        2TGUhiXVrkAE1ZlQ8O0QlUljoQWHGWLAlE/D
X-Google-Smtp-Source: AJdET5dXioI5+J89FlfTDGPr3L1XwxdQ0QDV22K/Rs++TYhBDcDhOnL8VRkMN4nnAIgI3dCt8oWXfg==
X-Received: by 2002:a9d:118a:: with SMTP id v10mr3336728otf.281.1542129086016;
        Tue, 13 Nov 2018 09:11:26 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id u8sm10567479ota.81.2018.11.13.09.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 09:11:16 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id t5so12050054otk.1;
        Tue, 13 Nov 2018 09:11:00 -0800 (PST)
X-Received: by 2002:a9d:7597:: with SMTP id s23mr3326905otk.370.1542129052936;
 Tue, 13 Nov 2018 09:10:52 -0800 (PST)
MIME-Version: 1.0
References: <d45addefdf05b84af96fb494d52b4ec4@natalenko.name>
In-Reply-To: <d45addefdf05b84af96fb494d52b4ec4@natalenko.name>
From:   Timofey Titovets <timofey.titovets@synesis.ru>
Date:   Tue, 13 Nov 2018 20:10:16 +0300
X-Gmail-Original-Message-ID: <CAGqmi77Ok0usUt5gfyPMYx22FdgqntSrwiap7=DT81HZuvNm_Q@mail.gmail.com>
Message-ID: <CAGqmi77Ok0usUt5gfyPMYx22FdgqntSrwiap7=DT81HZuvNm_Q@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     oleksandr@natalenko.name
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 19:33, Oleks=
andr Natalenko <oleksandr@natalenko.name>:
>
> So,
>
> > =E2=80=A6snip=E2=80=A6
> > +static int ksm_seeker_thread(void *nothing)
> > +{
> > +     pid_t last_pid =3D 1;
> > +     pid_t curr_pid;
> > +     struct task_struct *task;
> > +
> > +     set_freezable();
> > +     set_user_nice(current, 5);
> > +
> > +     while (!kthread_should_stop()) {
> > +             wait_while_offlining();
> > +
> > +             try_to_freeze();
> > +
> > +             if (!ksm_mode_always()) {
> > +                     wait_event_freezable(ksm_seeker_thread_wait,
> > +                             ksm_mode_always() || kthread_should_stop(=
));
> > +                     continue;
> > +             }
> > +
> > +             /*
> > +              * import one task's vma per run
> > +              */
> > +             read_lock(&tasklist_lock);
> > +
> > +             /* Try always get next task */
> > +             for_each_process(task) {
> > +                     curr_pid =3D task_pid_nr(task);
> > +                     if (curr_pid =3D=3D last_pid) {
> > +                             task =3D next_task(task);
> > +                             break;
> > +                     }
> > +
> > +                     if (curr_pid > last_pid)
> > +                             break;
> > +             }
> > +
> > +             last_pid =3D task_pid_nr(task);
> > +             ksm_import_task_vma(task);
>
> This seems to be a bad idea. ksm_import_task_vma() may sleep with
> tasklist_lock being held. Thus, IIUC, you'll get this:

Yep, that one of the reason why i move code from ksmd thread, i'm not
fully understood how to properly fix that.
But i misunderstood problem symptoms.

> [ 1754.410322] BUG: scheduling while atomic: ksmd_seeker/50/0x00000002
> =E2=80=A6
> [ 1754.410444] Call Trace:
> [ 1754.410455]  dump_stack+0x5c/0x80
> [ 1754.410460]  __schedule_bug.cold.19+0x38/0x51
> [ 1754.410464]  __schedule+0x11dc/0x2080
> [ 1754.410483]  schedule+0x32/0xb0
> [ 1754.410487]  rwsem_down_write_failed+0x15d/0x240
> [ 1754.410496]  call_rwsem_down_write_failed+0x13/0x20
> [ 1754.410499]  down_write+0x20/0x30
> [ 1754.410502]  ksm_import_task_vma+0x22/0x70
> [ 1754.410505]  ksm_seeker_thread+0x134/0x1c0
> [ 1754.410512]  kthread+0x113/0x130
> [ 1754.410518]  ret_from_fork+0x35/0x40
>
> I think you may want to get a reference to task_struct before releasing
> tasklist_lock, and then put it after ksm_import_task_vma() does its job.

Maybe i misunderstood something, but currently i do exactly that.

> > +             read_unlock(&tasklist_lock);
> > +
> > +             schedule_timeout_interruptible(
> > +                     msecs_to_jiffies(ksm_thread_seeker_sleep_millisec=
s));
> > +     }
> > +     return 0;
> > +}
> > =E2=80=A6snip=E2=80=A6
>
> --
>    Oleksandr Natalenko (post-factum)


That's good that you got that in any way (because i can't reproduce current=
ly).

You mean try do something, like that right?

read_lock(&tasklist_lock);
  <get reference to task>
  task_lock(task);
read_unlock(&tasklist_lock);
    last_pid =3D task_pid_nr(task);
    ksm_import_task_vma(task);
  task_unlock(task);

Thanks!
