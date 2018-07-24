Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5344C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9EE20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKYHt5bI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9EE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbeGXTUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:20:05 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37201 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388436AbeGXTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:20:05 -0400
Received: by mail-wm0-f42.google.com with SMTP id n11-v6so3445506wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3elQdLne5LPkd+vmZTPUOaGdqdb9m7zCuJuwDIywFM=;
        b=AKYHt5bIG/VsO6QSEjC+1P0Ok5m2GiyfCT0wVa5Fe/miHu5VvUxkoe2hkLrlGsUu6v
         kZUsq1sHqhvftnxS8h9PSXj93PG8UZX86hqhKubIdG5w6yG1Hb6TouQ9Sg6erJW5kY4t
         MtpNs90xtrfjKGCDFHkvu7joDDyCfb2+mdi3Z1x5qABKf/++uBwxXT5ep3yFpCGWXsdp
         ksmFRr5GsUHO8JcLi3Ci4fhdbQUKTAHfr23QXBohOURUFkubx8NvWQpoFTKUfMZmvAfx
         +x+O8FeRb1GhFnsfoRL4xVcw8ZjRgayoKPlZliITSDlpYfMMMQ8WUDA8C44qOzUiiiBJ
         E5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3elQdLne5LPkd+vmZTPUOaGdqdb9m7zCuJuwDIywFM=;
        b=CPdFRxliMXARQxaqZVNEfqgAJmu90cM5TPEBeTsCDcpU40fYx9qFU9JvdyvphDeI/Y
         u6VG19XSVIY8+tU97o1ib25aRNWmDXAVbtzO93AukcOxrCsQT8nT6Dx4LW3kYfx9JwPh
         Db+tM4Gch9cDquJCGyTDyUtnv9QRnvsKudE6v/LYrwupUvDtjBfqlbCYeDcWIuYH/d+J
         Wdf7yK4b9DM9JqMU2i3AgmOTa3GU36Wj6Ik7vqwEipo0jhDqjXa8YRcTsho1or5jZhAV
         KmkJf0f00ugDoINKigiWIJ+tqRjgzv5lX5uGkIpNMecc8ZQF9nIT1qtQjOF5nuu6k0Fv
         aQNg==
X-Gm-Message-State: AOUpUlFcI6TcWn4jZoUQZjuWfnOpNIMVSagLZKWXtQP/6fA8H+Lhgsy2
        jk8/g0qdbXFAjkk2mQ9dCz7U8MNVLCxF/8YbaXM=
X-Google-Smtp-Source: AAOMgpfE0Y/qBK322caOnl48SOrmzRz+4VBNOn9ffsIJohrv+bqPZvLA82TWYGsJVg6KafYRY1PeCQjrKmOkCfgIAmo=
X-Received: by 2002:a1c:57c1:: with SMTP id l184-v6mr2652897wmb.16.1532455943269;
 Tue, 24 Jul 2018 11:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180720180034.3964-1-logang@deltatee.com> <20180720180034.3964-5-logang@deltatee.com>
 <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com>
 <b14a3c42-4a23-bff5-3e1b-9a1423611230@deltatee.com> <CAJ80saunKS6hbNFBKjbQqSo32+KeLZurksCtnHNw-C35Zjq2Xw@mail.gmail.com>
 <8809f02e-93de-f81a-31e0-90f2c1983b70@deltatee.com>
In-Reply-To: <8809f02e-93de-f81a-31e0-90f2c1983b70@deltatee.com>
From:   Allen Hubbe <allenbh@gmail.com>
Date:   Tue, 24 Jul 2018 14:12:11 -0400
Message-ID: <CAJ80sauPtUBJ5q9iSGPArwvetBwEkjNaRmS_6adP5moK5ejLqg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] NTB: ntb_pingpong: Choose doorbells based on port number
To:     logang@deltatee.com
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>, fancer.lancer@gmail.com,
        Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 1:37 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> Not really. Given that we know there are only two peers, we always use
> the other side's doorbell register. You'd only use the nearby doorbell
> register if you wanted to trigger your own interrupt -- that would be
> weird and we don't really have the API sophistication to do that.
>
> If we wanted to support multiple peers with some number in crosslink
> then we'd need to revamp things _significantly_. In this case we'd have
> multiple doorbell registers which each apply to a different subset of
> peers. This gets _very_ complicated and hurts my head.

...huh, looks like peer index was omitted from ntb_peer_db_set and
friends.  Adding peer index there would make the interface consistent
with other ntb_peer functions.  Peer index would allow the hw driver
to select which doorbell register to use for each peer.  Adding a
ntb_peer_db_valid_bits to that would allow a subset of bits in the
shared register to be associated with each peer.

I think that's all that would need to change, not significantly more,
to support multiple doorbell registers associated with different
subsets of peers.  The complication would at least be hidden in the hw
driver, where it would need to maintain some mapping from peer index
to the right set of registers.

> But as I said,
> I'm not trying to add new functionality for multi-peer crosslink or
> anything like that. I'm just trying to fix the 2 crosslink peer case so
> it works like it did when it was originally merged.

I thought for sure ntb_peer_db_set already had peer index, and I was
wrong.  Go ahead with the change as in your patch, I won't force the
issue or that you to do that extra work and touch all the drivers
again for this.  It can be addressed when there is renued interest in
making things work more than one peer.

This patch, and the others in this series:
Acked-by: Allen Hubbe <allenbh@gmail.com>
