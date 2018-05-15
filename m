Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2900152-1526401595-2-15688134805408819869
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: from='utf-8', plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526401595; b=SWN2hqPatXmZigvNKsIARPZyiK/VdpyppC6vpZ5iDwFrmpdvBi
    /gix93VFLkxfIYQ8+2KqEU+JDSFGbhqWmgYUhlckQuZtrKPtdvL78lLXFr7xPFYs
    PuMrnI5PZf/zTJS21XSGhXvBlW8GT3yIkDRCkl1ikVdeSTgGTFiCfZzsjNwADADL
    4whv00FadXo5RgO/MZH05SUk3HnJO8v6V7HuhWdPHY5LPvNImRpqkawRTZwkhr7F
    kuzjK+asBTiMz76AJdE34sUhGEex3E4RWabHoaH6UcIJOuxrjH85OlNwQpV2yy0v
    +xbf8s9nQQ473PAHrRMmiGZiIa/1pdyfeMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526401595; bh=EFHyL3T9Pb1zMAoaRlqUvDyyPVCHvQ
    4NXTJ414NM/WA=; b=bl+sV8Mjd45qE3ZohHVCm5tObyBDjOVRa4pXqD9deX9thL
    mmHZarNiUFp1Ue8PpbGLdxEFmtGr4LEemO/cLjtIgEEl0TUZ34EFKhJq5o3eblJM
    6Fuki1JC0HcdW0T0qsUL1BGMOIT5YPkkrxGViGtjKFxCWCEj/YIGmuktr+uTk1/Z
    UKZSXx+W6lJGpghfdVELf4cW2+YW+Qd3GUAfKQi1TmMlw2ODcthNHYVHl8PaRwKU
    Ow8h9RSQhMTEoS9QKa48zNsorC/DgakT82sjPmRi5PDkOOsGD3kqq0urcephbLRx
    MVjpCoLrbDQXHLMtYKhIuF3w6TEbuSvqlGu87KQA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=KbLRzTvZ x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=QmAMqzCc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=KbLRzTvZ x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=QmAMqzCc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJdPdCsWh+bMKiwadUlpswaeY03fk8GgrCw7f5Rz5SR2gjXSmumhgm9qhBEGzcg/I8mW5vNxkCvjLoPtBBi9NI9jrpp9bqPihxTfxBBJP7fbNAuY4bJW
    7EvnqHmZ4qKdAKWoa7oW//AJHlK0ach8NZrj4fsZcOeBKBZ6nl2mUONACoNEc8RaMImiXY/sDCQ2vtVVO7yMaJy1chF6ckNSIw8kc91xLgAz86iaTWamHbE4
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=_QUm7bBfPsgA:10 a=VUJBJC2UJ8kA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
    a=drOt6m5kAAAA:8 a=OLL_FvSJAAAA:8 a=LSdmUDBBZZyydVr8SrAA:9 a=CjuIK1q_8ugA:10
    a=WGf8gWF5KiwA:10 a=3iWKb_mmEPwA:10 a=DcSpbTIhAlouE1Uv7lRv:22
    a=cQPPKAXgyycSBL8etih5:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=oIrB72frpwYPwTMnlWqB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932098AbeEOQ0a (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 12:26:30 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45915 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753581AbeEOQ01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 12:26:27 -0400
X-Google-Smtp-Source: AB8JxZqdYkpCErsKbtXIo2jdFOf4TMoUZcDu0mGGg/c0g/Cg2o7mzz3CWYKnGAo2v8boYpfQfpUpVg==
Date: Tue, 15 May 2018 13:26:21 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+4f2e5f086147d543ab03@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        akpm@linux-foundation.org, dhowells@redhat.com,
        ernesto.mnd.fernandez@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com
Subject: Re: [PATCH] hfsplus: stop workqueue when fill_super() failed
Message-ID: <20180515162619.wx7p5vk37nmansww@eaf>
References: <089e08e567a5b24ae90568bb75d6@google.com>
 <964a8b27-cd69-357c-fe78-76b066056201@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <964a8b27-cd69-357c-fe78-76b066056201@I-love.SAKURA.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 07:11:06PM +0900, Tetsuo Handa wrote:
> From ffd64dcf946502e7bb1d23c021ee9a4fc92f9312 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 15 May 2018 12:23:03 +0900
> Subject: [PATCH] hfsplus: stop workqueue when fill_super() failed
> 
> syzbot is reporting ODEBUG messages at hfsplus_fill_super() [1].
> This is because hfsplus_fill_super() forgot to call
> cancel_delayed_work_sync().
> 
> As far as I can see, it is hfsplus_mark_mdb_dirty() from
> hfsplus_new_inode() in hfsplus_fill_super() that calls
> queue_delayed_work(). Therefore, I assume that hfsplus_new_inode() does not
> fail if queue_delayed_work() was called, and the out_put_hidden_dir label
> is the appropriate location to call cancel_delayed_work_sync().
> 
> [1] https://syzkaller.appspot.com/bug?id=a66f45e96fdbeb76b796bf46eb25ea878c42a6c9
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+4f2e5f086147d543ab03@syzkaller.appspotmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/hfsplus/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 9e690ae..80abba5 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -590,6 +590,7 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
>  	return 0;
>  
>  out_put_hidden_dir:
> +	cancel_delayed_work_sync(&sbi->sync_work);
>  	iput(sbi->hidden_dir);
>  out_put_root:
>  	dput(sb->s_root);
> -- 
> 1.8.3.1
> 
> 

I sent this same patch a couple of weeks ago:

https://www.spinics.net/lists/linux-fsdevel/msg125240.html

I should probably have sent it in reply to syzbot to prevent this kind of
duplication of work. Sorry about that.
