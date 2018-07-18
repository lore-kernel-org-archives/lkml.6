Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8860ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0632084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="YyEOlLPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0632084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeGREMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:12:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35363 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeGREMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:12:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so1348280pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 20:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ju7cbAt9avMh692kQAz/QtD8SzT3nsmy7imi8f6rit0=;
        b=YyEOlLPWaNXHgBcNeRVgqcD/8/JICsjRn2fyzInvY4fC+GzpNwe2nD5YwbdPiEmr/n
         SvvmUmWo6b/oGOMfxA45jwbD66H0rhmJqDDJDaIfjBrIXGOb9kQ2ROpg0kTakNs/xlbx
         pIOQmaDdv5zk2wkUkn1PIow9YUVT9Rd553sEdQZhXirbu6+daPUoz2QBnBHNiMPVNn0V
         CwYXpUWwpnrmYab2r5Z018uJfC0Cni9lOyWFoOeGjPUVPmyCDgrUscPM0/1EwkTWwAco
         YebREKNI9/siAp8aej4Lr8edS+Hr/KKlm9060Mw0C8pL5qacwNro71YXiAy5L4LT5Gps
         yWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ju7cbAt9avMh692kQAz/QtD8SzT3nsmy7imi8f6rit0=;
        b=t5MHIcu7wEqhxoIEbs/A/4eabh+QVOH//ieT+LTRq9+fbg24i+A3ifZz8Vhpg41Krj
         MtHgPK4GmLoO52JwmfizbvxdxqV8K41EevWbKL+MyvDG33LUprDG/sfm8viZu7hfilu0
         U874Yo9zkvdc1d+2z0Y2CAgHr4lPlCF1l2MsYr+DXS97Y/U/4ks1XsPGivkBXcBvYQ3A
         eIsNmkG9deBaw/BIRgIe2w8strTXsxbYhMLTegHJ7fA1ec4d2+GW00mkgY314ix6QkCS
         OG7CEs/IAvbeMckE0L4TrXhU1I9ZJOUUKIJD6phhYJcTgp98eOfjdyPa6ssCkkWYOIhD
         sXJg==
X-Gm-Message-State: AOUpUlHOk5I7L+2Rdw/rRafkSCJsT1fCVFwOYmSMkA1KNZAZd5zKDxgs
        zJwOHF6bxErFCN5mjlt6IT9stw==
X-Google-Smtp-Source: AAOMgpfdvTrvLfMQtdIklpLcTdNQWkASzWOT3cy7CwK89/i6Xx8DC29HSRn4hozj+5gOGNk0vcCxOw==
X-Received: by 2002:a62:e106:: with SMTP id q6-v6mr3456088pfh.75.1531884996364;
        Tue, 17 Jul 2018 20:36:36 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::1:bc4f])
        by smtp.gmail.com with ESMTPSA id y85-v6sm5133387pfa.170.2018.07.17.20.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 20:36:35 -0700 (PDT)
Date:   Tue, 17 Jul 2018 20:36:34 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/7] proc/kcore: replace kclist_lock rwlock with rwsem
Message-ID: <20180718033634.GD29351@vader>
References: <cover.1531440458.git.osandov@fb.com>
 <783ba3becc424db45e5d5c93559fc40ef6173f01.1531440458.git.osandov@fb.com>
 <20180717193841.271d1c57b6f88d75c83892be@linux-foundation.org>
 <20180718032405.GB29351@vader>
 <20180717202753.d49795afde465d04b56efbfb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717202753.d49795afde465d04b56efbfb@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 08:27:53PM -0700, Andrew Morton wrote:
> On Tue, 17 Jul 2018 20:24:05 -0700 Omar Sandoval <osandov@osandov.com> wrote:
> 
> > > > --- a/fs/proc/kcore.c
> > > > +++ b/fs/proc/kcore.c
> > > > @@ -59,8 +59,8 @@ struct memelfnote
> > > >  };
> > > >  
> > > >  static LIST_HEAD(kclist_head);
> > > > -static DEFINE_RWLOCK(kclist_lock);
> > > > -static int kcore_need_update = 1;
> > > > +static DECLARE_RWSEM(kclist_lock);
> > > > +static atomic_t kcore_need_update = ATOMIC_INIT(1);
> > > 
> > > It's unclear why kcore_need_update was changed to atomic_t - it's still
> > > updated under kclist_lock?
> > 
> > Not in the hotplug notifier (kcore_callback()) anymore, so I need the
> > atomic_cmpxchg() in __kcore_update_ram().
> 
> Well that's just
> 
> 	kcore_need_update = 1;
> 
> and turning that into an atomic_set doesn't change anything(?).
> 
> It's not a harmful change of course, but a bit ... odd.

The change from read, ..., write to cmpxchg in __kcore_update_ram() is
the important part, not the change from = to atomic_set(). I needed to
change that because now kcore_need_update could potentially be set again
by the hotplug notifier while we're in __kcore_update_ram(). But I'll
just put all of this in the commit message in v3 :)

> > That could use a mention in the commit message.
> 
> That never hurts ;)
