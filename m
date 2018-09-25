Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64998C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EFC20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYhfZqBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EFC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeIYPpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:45:04 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39540 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:45:03 -0400
Received: by mail-it1-f195.google.com with SMTP id w200-v6so6150510itc.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uUHXLFlK8h5allcLYt8mEcPOiAG8/XUjL02nAOfBDH8=;
        b=oYhfZqBcYUi0ZeIXUrQvrDSs75iNncSleOEE8ZwYYNxHtaaOlSy+4OLD4vQ7/xjiyk
         J/7k+vet8JY6cK61fPTLKHoKfhPVstCNq7fh1t63w6D5keZrGSnq8I3Nia/EpDQ++gmf
         YSK8PE863ldzPpccprEpcc4MwWkaiJLZo6W+IW5yXU1C8fKC9vKj49r2tnt45vdQsJP0
         SQT/UfMiJKggVTkIJzZtG8m+mpw8s/vJw4K0U/XlJ8yxytG3eb8MCAgG5GrNlR5vAceD
         ZkmI//dI8n0C27cBU86uOao2R6cjSl/72J5kL2Uj7bn4eJi9wdMqVLYNqZkcgEOf8JzU
         OUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uUHXLFlK8h5allcLYt8mEcPOiAG8/XUjL02nAOfBDH8=;
        b=jgxOhg1PSeCJZpY+y0yd6eHCGtGux0yr992RC2GKSNyIiuqwoi3aZ27rPh5ef3mXMA
         cYQ7NFd8Mld3Jrey8WMNELyz16OJLAeFvndvZ4/wDYCWLX1mpxcz1fP4U0J7TooD/oJQ
         GFWs6R7+f4ZesQ+mw9PPsDrZ53DZzj30azUCveSwn2z3oSz0X/srrs8zHKhsu04qEG3A
         jUjSFeaEdvvFbPvpnZTwC2ghCKl7MfGi846rUOc8nKs1jbleLc3KiZiRx6x8iyTGWbBY
         Fl6n4QxJoV1qG/oDmyNlDPi545xq9ctjtgeNfVlj1aS80J9U7p2ZhXhi6EBa0S+IBoYL
         WEVQ==
X-Gm-Message-State: ABuFfojQMtER5bFF59DUfLy+UtoyTU6AMGtu4XJFMvOFiY38KuB1I9F6
        Y7+4owMa2EhSe7mEF6irnShYQ2zyd7/wTQavVBJQKg==
X-Google-Smtp-Source: ACcGV638bobHpYwk85dq4MjjtywxRCvit2nTzMd+vhIuecZNnZp4i92FWAGAVzZdrbqh6eaKrfS1oS+x+Y7IddDzN8E=
X-Received: by 2002:a24:3383:: with SMTP id k125-v6mr97298itk.14.1537868301732;
 Tue, 25 Sep 2018 02:38:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 02:38:01
 -0700 (PDT)
In-Reply-To: <274aafd2-5076-6b14-f55e-360411fb8169@virtuozzo.com>
References: <0000000000006971fa05769d22f6@google.com> <CAJfpegu9hZjJOUa7wHAj9KiTpcUuitsqnEMYvQzp6Mha2Yat-g@mail.gmail.com>
 <274aafd2-5076-6b14-f55e-360411fb8169@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 25 Sep 2018 11:38:01 +0200
Message-ID: <CACT4Y+ZiVgNj6h4f7aNDyzCwH0e84Onvb6n3yZ-p690duJki2g@mail.gmail.com>
Subject: Re: WARNING in request_end
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:18 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 24.09.2018 17:44, Miklos Szeredi wrote:
>> On Mon, Sep 24, 2018 at 2:29 PM, syzbot
>> <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    6bf4ca7fbc85 Linux 4.19-rc5
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=159149c6400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=ef054c4d3f64cd7f7cec
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com
>>>
>>> WARNING: CPU: 0 PID: 9445 at fs/fuse/dev.c:390 request_end+0x82e/0xaa0
>>
>> And  there we have the bug likely caused by the set_bit(FR_SENT, ...)
>> not being inside the fpq->lock-ed region.
>>
>> So that needs to be fixed anyway, apparently.
>
> I can't confirm, since I haven't found yet the direct way, that set_bit() results
> in this stack...
>
> We have one more (unrelated) possible use-after-free here:
>
> cpu0                                       cpu1
> fuse_dev_do_write()                     fuse_dev_do_write()
>   req = request_find(fpq, oh.unique)    ...
>   spin_unlock(&fpq->lock)               ...
>   ...                                   req = request_find(fpq, oh.unique)
>   ...                                   spin_unlock(&fpq->lock)
>   queue_interrupt(&fc->iq, req);        ...
>   ...                                   ...
>   ...                                   ...
> request freed                           ...
> ...                                     queue_interrupt(&fc->iq, req); <- use after free
>
> Something like below is needed:

There is a bunch of open bugs in fuse on syzbot dashboard, perhaps
it's one of them:

https://syzkaller.appspot.com/bug?id=19aabec97cbf73dd0475d6e599113a7861c4b306
https://syzkaller.appspot.com/bug?id=24aa489e6929205e40ec4aa52cd8f47897f2ad63
https://syzkaller.appspot.com/bug?id=400d6a977a0dbd8836d7c7ec8481782a674ee855
https://syzkaller.appspot.com/bug?id=ff9ab4a23afa7553fb79f745a92be87ba4144508
https://syzkaller.appspot.com/bug?id=d0f258de27b6d7ccecbba09385b3376cc4a12ffe
https://syzkaller.appspot.com/bug?id=e8077bce636d52d9c40e1ea904699c27b7454354


> @@ -1875,16 +1877,20 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>
>         /* Is it an interrupt reply? */
>         if (req->intr_unique == oh.unique) {
> +               __fuse_get_request(req);
>                 spin_unlock(&fpq->lock);
>
>                 err = -EINVAL;
> -               if (nbytes != sizeof(struct fuse_out_header))
> +               if (nbytes != sizeof(struct fuse_out_header)) {
> +                       fuse_put_request(fc, req);
>                         goto err_finish;
> +               }
>
>                 if (oh.error == -ENOSYS)
>                         fc->no_interrupt = 1;
>                 else if (oh.error == -EAGAIN)
>                         queue_interrupt(&fc->iq, req);
> +               fuse_put_request(fc, req);
>
>                 fuse_copy_finish(cs);
>                 return nbytes;
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/274aafd2-5076-6b14-f55e-360411fb8169%40virtuozzo.com.
> For more options, visit https://groups.google.com/d/optout.
