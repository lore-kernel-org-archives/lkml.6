Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95CBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891DE20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuykkmiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891DE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbeGXSdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:33:55 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:40697 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbeGXSdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:33:55 -0400
Received: by mail-wm0-f52.google.com with SMTP id y9-v6so2499819wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbsW5ZsbCTNMAb40mYjR9YiJ9HAi5X8Qd7iZ1KjWSGU=;
        b=fuykkmiGu4Kuk6EIdsVO+luTNU3loT75ceoKjjKqEWysuG436KyTz/T9gDHgUpZWM4
         Gy3kdBevx66n7OkHv9Bev/p+MQbAkOfB63w1NrMsxFONa5VCLCkGr7WwCx0G9HzIfsiX
         pir5G077h6bTnMkVeeMheVm3tHBCyJo+OBNKcWPVmIB+AF9DI4NSnolBRhCDyWZX+E5a
         qg9Pbmtk439bcCLGj7ckHPCVUJLFiuOUtKY7e7Z7Xvi3yg8SFk3jdx7cm50V6bpX1x40
         7TRUshpB3eR52KbVITPazMrGVdIZGJbWevEEtyZIS7aDl3zrPwgqxSy8O3gUo3JTobMf
         JWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbsW5ZsbCTNMAb40mYjR9YiJ9HAi5X8Qd7iZ1KjWSGU=;
        b=fs0/S7rE8ssBg51XIRwPYhd4quzE+I34mLkIIXyW0O+CtmQmiNZKvxpK34k6ELzA8j
         VxQZn00kzW2uTD6c8r8pXdIB6hTRcaZdaM0i3z6G0N5orV0VnnZwcbdGdApa0h9n/+wp
         7WakSJlgE+rF3fxdbUh1zgDL8s1S+l30dmXxn7/AOd1h9IBbR78r/ashRgvRSyA/OOKt
         05zXCMnbS48nrntlOSqd2lrKZE3KE2d1ZG8La5An6SUM5tnPN2ECaZvyO7yA8YwNFf9g
         P6z0vm/PFF8uTP67MU8ydHB9ZuoDMo820nBxTq6D7/3nIn7Wgkgo1XeqF4BrUCLoadCA
         jeHg==
X-Gm-Message-State: AOUpUlFoncCypI67MDfux8+mjLNubeLkwM268mrOQjvgOFRSv4EeCAoD
        DhGRsWW6WchEwAVHgAerjBy/YA1Kx+eJY4gMzuzPMQ==
X-Google-Smtp-Source: AAOMgpflOEBnbtkE5zGVgDjspAuRKt7kK9LtLTdTIo3k7doopNn4gGcjsYypp4Qxy1i9832/zImWtXTMuukPEoCJ2Mc=
X-Received: by 2002:a1c:6d94:: with SMTP id b20-v6mr2603265wmi.28.1532453183850;
 Tue, 24 Jul 2018 10:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180720180034.3964-1-logang@deltatee.com> <20180720180034.3964-5-logang@deltatee.com>
 <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com> <b14a3c42-4a23-bff5-3e1b-9a1423611230@deltatee.com>
In-Reply-To: <b14a3c42-4a23-bff5-3e1b-9a1423611230@deltatee.com>
From:   Allen Hubbe <allenbh@gmail.com>
Date:   Tue, 24 Jul 2018 13:26:12 -0400
Message-ID: <CAJ80saunKS6hbNFBKjbQqSo32+KeLZurksCtnHNw-C35Zjq2Xw@mail.gmail.com>
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

On Mon, Jul 23, 2018 at 12:08 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> I don't think you'll ever have a case where two peers have the same
> index, as the index is really an abstract concept the hardware doesn't
> really know about.

That is the point of index, that there should never be two peers with
the same index, and also that the range of index values is bounded.
Port numbers are problematic, so I'm worried about the change to use
port number in the client drivers instead of using index.  For
example, this change assumes that the index value is < bits per long
long, because the value is used in BIT_ULL(port number).

Maybe I'm missing something...  In the crosslink case, there is
another doorbell register on the other side of the crosslink.  Whether
to use the nearby or via-crosslink doorbell depends on the peer
index... making assumptions about the hw driver, but is that about
right?  Then you are selecting bits in the doorbell register based on
port number, ok, that must be how the bits of the shared db register
are associated with ports in your configuration.  Maybe what's
actually needed is a ntb_peer_db_valid_mask(peer index), and if only
the port-numbered db bit (or any other combination) is valid for that
peer, so be it, that can be an implementation choice of the hw driver
and below.
