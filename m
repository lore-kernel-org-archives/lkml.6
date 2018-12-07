Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4642DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B9B20672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuKD7Mfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B9B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeLGSfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:35:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32998 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGSfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:35:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so5580028qtp.0;
        Fri, 07 Dec 2018 10:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=59viu8g67J1hJGG27Yjr5cyTTyZ+Px83OvtPnvkNwkY=;
        b=GuKD7Mfzo7FW/kd/BN6igpoX4F2xUx/mz+6DnHzbMYbvxZznHQen9axXdg4fvA4+ce
         3QkormnRCFCSvt/rHmZN3Yc2+x7ERKGatMxAZunDMjZ5k9v87bMGnUE0XW/bCk+LgA5A
         ObOyoELTAgUEPSYeln3aNk5xKRLPHGEfRiPjWEwU4B7g7Q0LN0DXYDf7h8L8TZpVinQo
         SRRcfV8W5W9M2dcmBHX/OoqMZNPOSETBgOQFveoIRTfGaOI52duOpEPCaadqJeFvYcoU
         rwzbgLYDC+ykcxIUBMUoeu+XqO2XLQ9pWkvbb/dc+k4K6R5OyLBFaWy5Nais5ETdpfaX
         yItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=59viu8g67J1hJGG27Yjr5cyTTyZ+Px83OvtPnvkNwkY=;
        b=BHtHEYBxS0VaM2VmIncFPMqAQ4Um8HsXQnf65jNhK4qGMEBG7Zuse9a5GKFUpXQqZ9
         A+CnzK2WLKeEZiSm/wz83uBXYEE73R2LRWta6F7Rr4CvHcuNyoeFGnMa2D8hhZJtjWdk
         TJzdCzoJpbN2VNUeetCb5s1brDDvJzAMJZUgeYiJ9cptddy3UQrBxYxbINe6DlHDLmLe
         7jBkSduOIuoSPV1ons7+cqDXIjecxTfkdzaou5jMlU9G40pxdH8+ZWJrW1vjWBJePJvL
         fmBx6Lwey7iL56Mct115R8OoERFmKo6YWECxU+hKmpqH8/I/tovtt+ZB53PwW3vZwONx
         FJ9w==
X-Gm-Message-State: AA+aEWbejlamyzcOoyaFKZ6jCgSQA4unlm4TakiM1m8qiTK70iZu/Ov8
        p7TrvMLQOtgI4rzUfGwhww==
X-Google-Smtp-Source: AFSGD/WOgBa199KiotkswgHFnN0cj7HOJwdEET3r07YgdpD9E7kR22IJV6mg5bhO2TW52ESkfIBrVg==
X-Received: by 2002:ac8:3986:: with SMTP id v6mr3072102qte.1.1544207740021;
        Fri, 07 Dec 2018 10:35:40 -0800 (PST)
Received: from kmo-pixel ([69.5.123.9])
        by smtp.gmail.com with ESMTPSA id w201sm3917368qkw.11.2018.12.07.10.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 10:35:38 -0800 (PST)
Date:   Fri, 7 Dec 2018 13:35:35 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>, jeffm@suse.com,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>,
        Petr Mladek <pmladek@suse.com>, fsdevel@vger.kernel.org
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
Message-ID: <20181207183535.GA31228@kmo-pixel>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
 <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
 <20181204204701.GT28501@garbanzo.do-not-panic.com>
 <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 12:32:47PM +0000, Kieran Bingham wrote:
> Oh - although, yes - there are some good concepts there - but I'm a bit
> weary of how easy it would be to 'run' the said test against multiple
> kernel version libraries... there would be a lot of possible ABI
> conflicts perhaps.
> 
> My main initial idea for a libumlinux is to provide infrastructure such
> as our linked-lists and other kernel formatting so that we can take
> kernel code directly to userspace for test and debug (assuming that
> there are no hardware dependencies or things that we can't mock out)

I think this would be a really wonderful to make happen, and could potentially
be much wore widely useful than for just running tests, by making it easier to
share code between both kernel and userspace.

For bcachefs I've got a shim layer that lets me build almost everything in
fs/bcachefs and use it as a library in the userspace bcachefs-tools - e.g. for
fsck and migrate. Mine was a quick and dirty hack, but even so it's been
_extremely_ useful and a major success - I think if this became something more
official a lot of uses would be found for it.

I'm not sure if you've actually started on this (haven't seen most of the thread
yet), but if any of the bcachefs-tools shim code is useful feel free to steal it
- I've got dirt-simple, minimum viable shims for the kthread api, workqueus,
timers, the block layer, and assorted other stuff:

https://evilpiepirate.org/git/bcachefs-tools.git/

Going forward, one issue is going to be that a libumllinux is going to want to
shim some interfaces, and for other things it'll just want to pull in the kernel
implementation - e.g. rhashtables. It might be nice if we could refactor things
a bit so that things like rhashtables could be built as a standalone library, as
is.
