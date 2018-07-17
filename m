Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75576ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5C920684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IxCKzGuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5C920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbeGQRnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:43:16 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38078 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbeGQRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:43:16 -0400
Received: by mail-it0-f54.google.com with SMTP id v71-v6so175847itb.3;
        Tue, 17 Jul 2018 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nk68BKGLW6HORrwdpPvfI+NaBh2nimNlB1HeZ0XGSjs=;
        b=IxCKzGujbcTHCjcrZbjlbs6QGlMkuyrVZ3rAPitnrMH+JJIhlZTcH9eHgAazUt11l1
         lXx2LsYitWdwyjQYnCCD9NXVivdXDf33v9OywDZvogciLNQJz1rUuGW0YVGB575/ifMM
         YBJc2+JV+d6qisPB9v5Wz0ANU1zczkXxDXhbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nk68BKGLW6HORrwdpPvfI+NaBh2nimNlB1HeZ0XGSjs=;
        b=jE9aHk5twtrXGykMa3sVwoRHqYJl0f+u84VoPAzJRGTAcdl5+Twqtf2Ze/A7TrCD4X
         G7nvEroJOHMChK5HrUo9m9cfxhOU3jZzHnrowONd/UHKJeqT6hjsK5elDPLDXVKNEgQy
         qheH4VayRNuexmsgcN6Hzg1igCQRVyyu4PDHU+h+tEnlqkMPZIH/qG8eOUazpHya5Szt
         Em0gMiH+DulNOVElN0B9N7pD034dS4ONR9hM9MZQMa9JHWuuG91AGxjkCtU0pGhHgvyj
         haKg2JkWP6nVEZwUPPcjpjmeHDIAUZqv11fIaDjVd+zv+kfHC9bA3TiUSY9o2k6UGoeT
         ofeg==
X-Gm-Message-State: AOUpUlHEAoOrwM+ceiuLEOttntZ2Lje5J4XeT96is4D6x12oaz/LOM6W
        GpGlR9qyFabz2joAxqKFTWXoQeD+5+MU5SSz7+k=
X-Google-Smtp-Source: AAOMgpdKWzF6HIyN4w8v6ZrlFoP7Or9DRoBSUoeFaPwra/2pzKbzjmKaPvkX9Vgrf5pwgsDc+zaRYzGvqsSgYqcn1h0=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr2258742itg.1.1531847380008;
 Tue, 17 Jul 2018 10:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFwuAojr7vAfiRO-2je-wDs7pu+avQZNhX_k9NN=D7_zVQ@mail.gmail.com>
 <1d3d0fe3-bc02-7720-15ac-6bc06e00067c@marvell.com>
In-Reply-To: <1d3d0fe3-bc02-7720-15ac-6bc06e00067c@marvell.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jul 2018 10:09:28 -0700
Message-ID: <CA+55aFwb5hPtPFbB02SSn+wTkqTDSgHGFkiw7LB57mj42VzyZQ@mail.gmail.com>
Subject: Re: dvb usb issues since kernel 4.9
To:     hannah@marvell.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josef Griebichler <griebichler.josef@gmx.at>,
        Hannes Frederic Sowa <hannes@redhat.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Ingo Molnar <mingo@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        dma <dmaengine@vger.kernel.org>, vkoul@kernel.org,
        Dan Williams <dan.j.williams@intel.com>, nadavh@marvell.com,
        thomas.petazzoni@bootlin.com, omrii@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:58 AM Hanna Hawa <hannah@marvell.com> wrote:
>
> After some debug/bisect/diff, found that patch "softirq: Let ksoftirqd
> do its job" is problematic patch.

Ok, this thread died down without any resolution.

>- Using v4.14.0 (including softirq patch) and the additional fix
> proposed by Linus - no timeout issue.

Are you talking about the patch that made HI_SOFTIRQ and
TASKLET_SOFTIRQ special, and had this:

  #define SOFTIRQ_NOW_MASK ((1 << HI_SOFTIRQ) | (1 << TASKLET_SOFTIRQ))

in it?

I think I'll just commit the damn thing. It's hacky, but it's simple,
and it never got applied because we had smarter suggestions. But the
smarter suggestions never ended up being applied either, so..

                       Linus
