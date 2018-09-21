Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD44C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD1521523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g7/qPZKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD1521523
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbeIUOlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:41:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37275 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeIUOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:41:25 -0400
Received: by mail-io1-f67.google.com with SMTP id v14-v6so11475072iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KDnfvxYnxAD9LXJbNe2dImhpX2hi5+YpkVe0sxC7FE4=;
        b=g7/qPZKUTRIr1WQw3BThglHA8SUUKe9+X+3O4s/0/Xe1tXAE+tckREdBT0vBd2sz/b
         Rume+eG3mImGB21v6rSh0GoqKKnGVwCJDLS54kT4SnUMwuHDInwTGcCsi6mJZJ/QZCQj
         YJA+ScAFr3MJgk9qzh3nSGfNHziauQ/ca442zp1sXXZVEydVoL5STuU70niH3QJ/ZSa7
         XfA6T7LlE/F14quOd+RyAkCpcD3k/T3/xlSJmIt+X5+ct21IeekoaNgwPQtS1s7TN7a/
         w+PN4ytOfEhfGBwfTIN5/4GlKOxlN8cButfm2KZav6aUKb8Z8YM13hDKUuqp1tr+NQRB
         YMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KDnfvxYnxAD9LXJbNe2dImhpX2hi5+YpkVe0sxC7FE4=;
        b=pwo2QnStfFluxlWcjtG/5k5i9TbuRR4wr8gj+kH79C/c+aRctKuAm+jtOvu9SWC3aw
         emIKr3F1Td/28Nfw/RrzPoOFozu2+iC9JuCBMVd1//H5MzlOUUzaN+I8OCYWobBVayD0
         qrUCOK6qMQbWMYM0rZKZBaMZWpmCDZCXTnAZ8a4FNn6PnjVDrr7ni6xEmsClS71IjIu4
         j+qLPg70aRIzzAhO1xaMqqRFwi8BZQ3YGtDjXu2jrfUfE+PPMAJ/QHGn+FXkyNebTjK/
         axOqn6nRWQBvOaWNr3u20BHM9OzlQFoOzkNfpaA3b9CccJUjH3UYvbUg3zQzvXQfv310
         dk4A==
X-Gm-Message-State: APzg51D/D3Dcu2Kea/53nWoApoxA/5/hZpBigVvi6IKNVOVP+NDqn/iB
        wyzJi2urCsHDXuzYUXAcI86rv0ZfzNUBCZOnblLC9Q==
X-Google-Smtp-Source: ANB0VdY/zTnAdul5g3LCioo/D/61KOk7ts0NauHtxniEbwHvSoHwy0+hMWcEr4bxN4xwzzt49MJ5JiBMdNxT8VYmKuo=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr33343476ioe.282.1537520013804;
 Fri, 21 Sep 2018 01:53:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 01:53:13
 -0700 (PDT)
In-Reply-To: <CAADnVQL8=8O1W8-G-UP1akLijdGN82hnOJAY=sknTH_S0Y1rVQ@mail.gmail.com>
References: <CAADnVQL8=8O1W8-G-UP1akLijdGN82hnOJAY=sknTH_S0Y1rVQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Sep 2018 10:53:13 +0200
Message-ID: <CACT4Y+aLiH3zNTVqpxOwuT3_F007fUo4Q65LFnrUvAbDjy8nBw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in _decode_session6
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 8:21 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Sep 6, 2018 at 12:17 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>>> but I have a hard time reproducing the issue, so will appreciate
>>> if somebody can test the following patch:
>>
>> syzbot can:
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
>
> was the patch tested?

Hi Alexei,

syzbot tests patches on request. I don't see anybody requested any
testing for this bug. When testing is requested syzbot replies with
results generally within 30 mins. You can read more about patch
testing here:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

> it seems to me syzbot doesn't care about kernel quality but rather
> about the number of issues syzbot can find.

Finding and reporting bugs is a prerequisite for fixing them and
improving kernel quality. syzbot simply automates that part of bug
handling process, something that otherwise would needed to be done by
kernel developers. But active developer involvement and interest are
still required as not all parts are automatable.
