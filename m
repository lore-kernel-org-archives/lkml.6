Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C540BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C10208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YiDLEQKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C10208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeHBAG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:06:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46065 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732211AbeHBAG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:06:27 -0400
Received: by mail-pl0-f65.google.com with SMTP id j8-v6so59748pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 15:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OXEpGHZaJPBI/wv0tgH9/HIeou9DWLBclefECW5TGg=;
        b=YiDLEQKDAC2S/Ef+Lf7dh8SE8KGVrdPpbjxt5npdKLzTcyaE+PFuhA02r0DKLU5m2q
         8q8m06bIpvx4mQPVhkzEyGux7W1Lcm9JAxoCE7Eg4DvO6R4EIiBzVYTzJr1Nsix6LK1m
         4k81CFpYt6r3kA4puNTX15x50t5Z1KzzvMdwnLArHaJMs3Tcnvw8aGCGV7BVCTvIKfl2
         zz3GfRKf7qAu/6Jleuhl0lXnE44mlyWkY8RwpR0cfy/y05Q9Ca2dSPHwlktxNOiVEIJT
         7CNGjg6Qv/YAz16dt0uRXbzL4TSf27v5Andg++EnlsYXkN79HVyzwl3qoaKqzTQjb8u6
         xPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OXEpGHZaJPBI/wv0tgH9/HIeou9DWLBclefECW5TGg=;
        b=lZeTvJC97W52A1FiHqlfEJqlx3TKeb+SbLjBfHf3E/03iH54VOikU3l7CT4YdbkEn4
         nA/piIMY8j08I3pABLmnrjKH0D+HB6PRmdDETC5hXWlFctqpL02kFi32T8+pCre12x8L
         YvtuMnab3lFlLP4T/gQHxjhng+g2thhrdvPIQy3KnHWIiMkOJIAA1CTRnkChVy5noBDi
         GXRoxZYrL2LQSKIVA4oHfYCBNv7hSkcuZMopL/TpuI5mgUG1fchzjcKFrXG1cuYUDzSt
         bBcefz0oHhPXRTyRVjWso052HyErscX89GCPbrBBw1si0DuSt2cdzGPkQC6Ocj0z8MDa
         Gv2A==
X-Gm-Message-State: AOUpUlE7QAolIaBoNOvCgKv1Op+5By2uvEf+ddBOeYOUPOQW0YqJWumJ
        79KhIeOrgPs7fefFwEnb708N3fU9qElB41cF8YsgMw==
X-Google-Smtp-Source: AAOMgpfRSI9wokLUuoT+edqskIU08ZD0+uPGug2CTc5GIh7c2eElmzwLiKRz9KHrnNCOt7qg1Xf6aZlKUBzo8gzstvU=
X-Received: by 2002:a17:902:708b:: with SMTP id z11-v6mr143064plk.262.1533161910263;
 Wed, 01 Aug 2018 15:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180801182258.17834-1-ndesaulniers@google.com>
 <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net> <CAKwvOdmdrA+UvAWyqe8sNJt5nxHXHsSwf5Yxih9HYgVL+kovxQ@mail.gmail.com>
 <fe7b57d8-b586-a390-31d2-2274f69db3c0@bell.net> <CAKwvOd=CLBFZRQ4HQb_+VCydDEvsbC2w2gD4hTwvp_jm1zqN9Q@mail.gmail.com>
 <54b2139b-53d2-01c5-f240-93a692cdbc59@bell.net>
In-Reply-To: <54b2139b-53d2-01c5-f240-93a692cdbc59@bell.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 1 Aug 2018 15:18:19 -0700
Message-ID: <CAKwvOdktvrZL8T_5K2VtQtgt_mscS7kzVXYVy0O7CSuGX53Y5A@mail.gmail.com>
Subject: Re: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement expressions
To:     dave.anglin@bell.net
Cc:     deller@gmx.de, jejb@parisc-linux.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        pravin.shedge4linux@gmail.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 3:12 PM John David Anglin <dave.anglin@bell.net> wrote:
>
> On 2018-08-01 5:49 PM, Nick Desaulniers wrote:
> > Thoughts?  Idea being there's only one call site in your tree that has
> > this requirement (and the other one in
> > include/net/inet_connection_sock.h I don't think is correct, and will
> > send a patch out imminently).

Turns out it is correct (I assumed by caller, they meant _RET_IP_, but
they're in an inline function). https://lkml.org/lkml/2018/8/1/1687 is
the patch.

> What about the uses in the fs support, etc?

Sorry, I don't see it?

$ ag current_text_addr
and
$ grep -R current_text_addr

turn up nothing in fs/.  Is this torvals/linux with no out of tree patches?
-- 
Thanks,
~Nick Desaulniers
