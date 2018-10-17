Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6BCC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8009A2147E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhAFAkYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8009A2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeJQICy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:02:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39734 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:02:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id e67-v6so2788585plb.6;
        Tue, 16 Oct 2018 17:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WOuGkTia4C0w5UeuexsyGjBNNNcNgBW91REJgJbX2LQ=;
        b=UhAFAkYHkljBM9Fb7r7Y7K6F3YiaI2yA1xyeSyCkLnS1jow0+kAniIaaf0ttCx3mhW
         IpVLXh5xzuOgwtfCzJGKTyxGdhObhoVhLwWS26ekpFAarX6/8HF8jlrZBg/61RtYJxDx
         OIIMiN4KFkVtQMVh3J4nQxBLAif6j7THsj50K/JsaWsoDAnL4x/f+1yv2tiZk7w4NslI
         oF7RB48Yq1QtNdfcS5UaVYXIQnAoHZlXNIEO1xRkSWI3D8fjwbE0AnAkl9RvDnGYRaSo
         NQPhq/WbpKfdMcL96IsYfDZQvdmty7AxN504vbtcM5jhwNJ7ZvJU39uyvErJ6hYNWiUT
         xj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WOuGkTia4C0w5UeuexsyGjBNNNcNgBW91REJgJbX2LQ=;
        b=TS0hCmVfCo5GYpahhFRl/zb5L2ohraf+3JxRZY+4dzw2ccLuvBLVxF8i3t/3djqf4j
         NS8NAfVXcb8MI/T8oasEqZDQJWXPYbCvdwbAyisBaZb+Ieyig4TIMpHWkH6VhVgW63XV
         3LjMMIxVyQngdQ1lpRG7JrDjN3v/o4b6Hj555W3i4GaeO/DVlKPyBiVW3/8HOzhCvlua
         Qdzq9AtGfKQprjZxBvy5/8B3CDpPKHPjHkoGWRQJzd6JQa3tI/ef6X2bdlP2am2FWCXB
         /YKGnKRr+4gLO1nAvrpfQM80rVVmbtFl4uw1rP2aZGtUbZ8IU3465UiXAWDBcTsHAHBq
         CxmA==
X-Gm-Message-State: ABuFfohXZh15Re0mviO7JGvgyAXlbWWc/jYYCSvHRS+vJMXRdvI6Oo4E
        4UsUyzyWZKRep1PLVhspVx0=
X-Google-Smtp-Source: ACcGV62Gx5gGNYoCdqgdHk5DiKWEKq4p9e07CSci0SbJ7YXAPwc3R4Xn/qX5sWD29Z2kuWKTFW77xQ==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21-v6mr23479666plo.21.1539734999461;
        Tue, 16 Oct 2018 17:09:59 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q127-v6sm32602137pgq.19.2018.10.16.17.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 17:09:58 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:09:55 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christopher Lameter <cl@linux.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
Message-ID: <20181017000955.GG230131@dtor-ws>
References: <000000000000e5f76c057664e73d@google.com>
 <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
 <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com>
 <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
 <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com>
 <20180924184158.GA156847@dtor-ws>
 <20180927143537.GB19006@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927143537.GB19006@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 07:35:37AM -0700, Matthew Wilcox wrote:
> On Mon, Sep 24, 2018 at 11:41:58AM -0700, Dmitry Torokhov wrote:
> > > How large is the allocation? AFACIT nRequests larger than KMALLOC_MAX_SIZE
> > > are larger than the maximum allowed by the page allocator. Thus the warning
> > > and the NULL return.
> > 
> > The size in this particular case is being derived from a value passed
> > from userspace. Input core does not care about any limits on size of
> > memory kmalloc() can support and is perfectly happy with getting NULL
> > and telling userspace to go away with their silly requests by returning
> > -ENOMEM.
> > 
> > For the record: I definitely do not want to pre-sanitize size neither in
> > uinput nor in input core.
> 
> Probably should be using kvzalloc then.

No. No sane input device can track so many contacts so we need to use
kvzalloc(). Failing to allocate memory is proper response here.

Thanks.

-- 
Dmitry
