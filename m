Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC901C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D812084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt584VDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D812084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbeKFMTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:19:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36567 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeKFMTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:19:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so17641420qkf.3;
        Mon, 05 Nov 2018 18:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYEScDKH7H5C2FE8RXTZoURjDyAeUU3j9UnmtL89pAI=;
        b=jt584VDe95pxHkRZ7xxIAFvFmcG5NzDh+TKLewRZD+V0f5cNSBh4or+em8GMwCuJJ4
         2jwmDzUIzZHykjcyEUfOrNTwmiEqZP1F+U8fXizhDmIE/UD+q91oxXPpE/bhtrFkJ8ve
         b9uLqrBvysLqkBrEnmiRIFQfM4bjmo9SzQCGRDr1et8TRA2A+xnYs6dnTJ1X2X4gft7q
         bJvL5hGwsg8RdAw7YjKiQtu8qIJRE8Nx0unmvGpb7tpHkyw4eM/KopP6N6/pyiRLUB38
         l6bmosqExCLCmc1klWbhsFJ7JBvAAZv5XbYf90PRxhfMXwKAx1eYqbV/N2Qg2SHhCVpj
         Vt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYEScDKH7H5C2FE8RXTZoURjDyAeUU3j9UnmtL89pAI=;
        b=HxtaBPTopMTIGKD4DLyvSEnSkcpFnLjgQNy5kN8fan0E96/ZtMNgHeQ7E3/HYivang
         VwusKVoZfaIINaE9B250jx5ICmNrBRiIepMOkK3YiiKwlqRg7x77vwB9pcXLUysfhhLD
         9zF0860b2oGgsJ1BHkWMNyfI9EwqGI8AqfgQKLQ5FbEqlsb+We1GLD180M8z56BN0NYQ
         ql+7aUTRY9h+H6LNhViN686Qhv08A+SqvWKGLrIVgLF1hT6+dPVQTn1AgzTn/9Iqx1w8
         14gAYN5DghO3vyv631VtViGXm2/JzD8dzCL23yx7xaO8IrVOAyKl31pALdcNuOpvi510
         nxVw==
X-Gm-Message-State: AGRZ1gIyRk6g3CPoRAy6TC8WV7B0exsrTG0/4ZvwV4PftwC7aTP3ca1/
        nDwnQExOYg6iQwmA2s+MTuh/KvUqHuKbcWwGidkREiU+
X-Google-Smtp-Source: AJdET5dM5n88TZwRBIexFtO3lp0rOWm47BZblNLVIXQDYfc/oT4Gph8LbO96lDhLGhokAjzNoATi+U4EndlmwLOOFkI=
X-Received: by 2002:a37:24c9:: with SMTP id k70mr23063383qkk.281.1541473008602;
 Mon, 05 Nov 2018 18:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20181102182123.29420-1-v.mayatskih@gmail.com> <6a7f1668-bf2d-0caa-2efd-c8fab5f1db24@redhat.com>
 <CAGF4SLg6+nt+zV4haXys4Wz2dWPDyx7xHXuA+h01NcQ94j0E1A@mail.gmail.com> <57eefa62-7e66-786d-441c-5dd6b0d451a5@redhat.com>
In-Reply-To: <57eefa62-7e66-786d-441c-5dd6b0d451a5@redhat.com>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Mon, 5 Nov 2018 21:56:36 -0500
Message-ID: <CAGF4SLgkgjkLjmPWWJRBo44B+mcR4jRcjQ+PdqJuUGxZVuEECw@mail.gmail.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 9:45 PM Jason Wang <jasowang@redhat.com> wrote:

> > Storage industry is shifting away from SCSI, which has a scaling
> > problem.
>
>
> Know little about storage. For scaling, do you mean SCSI protocol
> itself? If not, it's probably not a real issue for virtio-scsi itself.

Yes,  the protocol.

> >   I can compare vhost-scsi vs vhost-blk if you are curious.
>
>
> It would be very helpful to see the performance comparison.

I will try to find comparable hw with fast enough SAS SSDs. That one
was done with NVMe's sitting on the very bottom of storage topology.


-- 
wbr, Vitaly
