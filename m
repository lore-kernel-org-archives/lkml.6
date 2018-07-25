Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECCDC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300BC20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="pDIhWlVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300BC20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbeGZAsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:48:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42570 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbeGZAsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:48:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so6276759pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UbcnQ9ngTeOsn/XRP5L+38RrQ6GGaLD1Bg00W9uD32U=;
        b=pDIhWlVX0tipzauoLAUbBZJNYMFhab8OWfAlmUDWwkAg49tvJh3XC00goQlbSl1HxC
         A9CqEkrGm+RIrb0J13YB+AgwiWdPaSraADNwcC/c3bVF7jvSbvp7fql4RKsDK/FOjgpi
         DrSOCBHxFwSs3N4HzG+hiNTODZwZm0aB3YWhI8mdsMNJ/fRQab3AdUHTWHB21S6XKC3/
         68v57ZDnVto9QGeKIEaQkDkk9nS5It6ltKYy4G/NkoyPpbPVwuY9j1XFb10zGVgxK7C+
         wYoRDY1fhGjCAahpWTax+09Wk2VK+B1wvxBWboPazi/OanFGKHTd1hpqkUtSr2lbA/zy
         T9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UbcnQ9ngTeOsn/XRP5L+38RrQ6GGaLD1Bg00W9uD32U=;
        b=WRezFH5OwE61Z8Eay2Y2cos63BZSZiKfdzaBJeipX7HLbgx18aYHbEFVZinbzoMsZ7
         QSGC9e5aA80weJ8iK9Wh7W6517JFwVuPFpsnd2ggLyatFnSHfs81XS+qbE4PHBgeekXl
         X9qVn4DiWur8o8iEtjbKHHVxaHy/p88GxVUPo4H+FEGQ/+g+/5SYkqcHLtGxbUkrannx
         AK+436Wo+LpmoZAKp3xejiPzxbu3oa7LFdnVVh1TsiGxgBVsr+9WHp4qNA30UE/dOjkz
         okLMri/3uqMSjtOtGXzTKV4fBilwiRKO3MIT33LxG1WNaWYKHezIG1HOefCLDlu6JtPq
         9hVw==
X-Gm-Message-State: AOUpUlHjv2C4Jlah/sX/Qt7CT9HnYlpDcEGex/p4vxqnp/Vwbo5fFjX2
        bl4NKndYoMAbFIg98PA+NT3WVQ==
X-Google-Smtp-Source: AAOMgpcJpHUSINZZIofs40FG/ptFPY0zX/wn/hbPZU8+1w/izMG+Gz5Ly5DpUU7dTokF09NwZU8ExQ==
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr22972379pgh.216.1532561653496;
        Wed, 25 Jul 2018 16:34:13 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::1:8d38])
        by smtp.gmail.com with ESMTPSA id v6-v6sm27124640pfa.28.2018.07.25.16.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 16:34:12 -0700 (PDT)
Date:   Wed, 25 Jul 2018 16:34:11 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v3 5/8] proc/kcore: hold lock during read
Message-ID: <20180725233411.GF16847@vader>
References: <cover.1531953780.git.osandov@fb.com>
 <d7cfbc1e8a76616f3b699eaff9df0a2730380534.1531953780.git.osandov@fb.com>
 <7f905293-5c30-f001-987f-03caf8f36737@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f905293-5c30-f001-987f-03caf8f36737@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 12:11:26AM +0900, Tetsuo Handa wrote:
> On 2018/07/19 7:58, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Now that we're using an rwsem, we can hold it during the entirety of
> > read_kcore() and have a common return path. This is preparation for the
> > next change.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/proc/kcore.c | 70 ++++++++++++++++++++++++++++---------------------
> >  1 file changed, 40 insertions(+), 30 deletions(-)
> > 
> > diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> > index 95aa988c5b5d..e317ac890871 100644
> > --- a/fs/proc/kcore.c
> > +++ b/fs/proc/kcore.c
> > @@ -440,19 +440,18 @@ static ssize_t
> >  read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >  {
> >  	char *buf = file->private_data;
> > -	ssize_t acc = 0;
> >  	size_t size, tsz;
> >  	size_t elf_buflen;
> >  	int nphdr;
> >  	unsigned long start;
> > +	size_t orig_buflen = buflen;
> > +	int ret = 0;
> >  
> >  	down_read(&kclist_lock);
> 
> (...snipped...)
> 
> > +out:
> > +	up_write(&kclist_lock);
> 
> Oops. This needs to be up_read().

Yeah, thanks, I'll fix this and rerun my tests with lockdep.
