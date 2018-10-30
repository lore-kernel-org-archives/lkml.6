Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635AAC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C2A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d72Byb2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C2A2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeJaFCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:02:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42972 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeJaFCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:02:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id q6-v6so9883783lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHlA1Gy9bikOKYy8gzOAw1wz0+eQluWCb2m298a9UsA=;
        b=d72Byb2QHgPqTgAXvhHNvfoMjdDL+qRXq8PyQsTUBX+BSh1aY+dF33CZzrYg8JSsSn
         /HZRfN5/n7oQ/Dg4G9zq20D61EXR1n9qOKtknZY+dxm6Wn7pHGrgtl2aohmKZF9AiuVE
         Fmy7UPs8GF+4fssy3XS+X2ixM640fNszugEqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHlA1Gy9bikOKYy8gzOAw1wz0+eQluWCb2m298a9UsA=;
        b=SgVA3xU+KAPhESHhYWGCHZP61EQR+idvV3aIRdUVdRwdMK1BLVPf2P24ImFQMvTGwH
         Jsh9byCD2lE3iGTGfV2X3R2htkxyHPyLboe9qT9vEqPeD/4QhF+KivX9zUfFlU/Q1DdV
         jni7MiBZoo/iYB2/gvs3y1yM6jUd627mWwuIoMp0Txf11t3fi9nqv9Hl9fF68tS3lxND
         FiIV0I9sJzwsBSVUdF3cjZcr02Vhi5Kou5k9xbimlrpxszH30nQYHnfYNQjDDhjGwLsi
         Q//RTdd8qigwWvP48802KONTI2x1rY0EuNNbLuZMTG7m/6wtEXekQFawSqgTne1qg/oq
         x8fQ==
X-Gm-Message-State: AGRZ1gJsp1CP9ioLSePs5E/3cSu9VNYGg2Z8cVvR0ss5F+CEeSG/DvBM
        1LCBd8mTWF4XBJ4Ne1A+6uC6PeQO7McwIw==
X-Google-Smtp-Source: AJdET5eRzWQaLsVA4CbB+vJvvBaVJ6xTPbPUQ6xeL4+Z23HI/hOTfmNRBYvf9HF+k4kpVNLGv7TvfQ==
X-Received: by 2002:a19:6719:: with SMTP id b25mr88728lfc.38.1540930035468;
        Tue, 30 Oct 2018 13:07:15 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id f76sm678670lfl.74.2018.10.30.13.07.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 13:07:14 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id h192so9917251lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 13:07:14 -0700 (PDT)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr68821lfc.147.1540930033935;
 Tue, 30 Oct 2018 13:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181030191710.GA23042@fieldses.org> <CAHk-=wi+-POnmS41x9SKR+CB9va3ZnmRmCF8S7wNEw0QVATHXA@mail.gmail.com>
In-Reply-To: <CAHk-=wi+-POnmS41x9SKR+CB9va3ZnmRmCF8S7wNEw0QVATHXA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Oct 2018 13:06:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgeJzBWjCafB3nKP0QMJCyh3rAjN+s6Z+T+5hfAT81YMw@mail.gmail.com>
Message-ID: <CAHk-=wgeJzBWjCafB3nKP0QMJCyh3rAjN+s6Z+T+5hfAT81YMw@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd changes for 4.20
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jlayton@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Pulled,

Oh, I take that back. Semantic conflict with locking name change
(recv_lock -> queue_lock) and new code in

   net/sunrpc/xprtrdma/svc_rdma_backchannel.c

exposed by my build test.

And looking around, it was reported in linux-next, but you didn't
mention it, which kind of makes the whole reporting pointless.

Guys, what is the point of linux-next if you then don't *react* to it?
The correct reaction is to say during the merge window that "hey,
linux-next showed this issue", just so that I know about it and it
doesn't take me by surprise.

Yes, my normal build tests caught it, and I've fixed up my merge, but
this isn't how things are supposed to work.

                      Linus
