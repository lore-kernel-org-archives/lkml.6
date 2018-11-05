Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E06C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9DF2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtBV4XPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9DF2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeKEXlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:41:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37485 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKEXlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:41:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id 131so14906614qkd.4;
        Mon, 05 Nov 2018 06:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOkXqKCkID7Hjl/cb2pDxytuh5XUsHiizgeV01X666M=;
        b=UtBV4XPS38ljeC1KZGrxlkHE/8eDRlik1PK7n26TN8VSneZJFWDBdLFQ85ZKj09xZB
         zDsdgpnBUxbxKIZudBp45+dwuoLVjuPzbAIFBstXmyWD77WZ1bAxljikfMe1JM/ksP6a
         wQYHrV0vvyEpgSZ5yoBJK71B+F0tla9im2EcxwYPeSdMAg5f36+vILRes3YpkWGg/kew
         Ib7PaE77eri6jjU9c1CkSBwRf6ATbFzJCAxoWWleD2tfBrUgp1kA80CFxE1sH/sZEnBW
         zaK8XuhQVrYTVHHJHYjjzirB1TV7oNgt9KQi11Bk0PQ11JIT1H+jR0Ws693ZXhDCRXUI
         O+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOkXqKCkID7Hjl/cb2pDxytuh5XUsHiizgeV01X666M=;
        b=psjtkKqyESAkB6t6bM7cxcaP0M9YUAWzVawhNzuTtWRPJ5t4SGHevyRN0iBbouxFCg
         U2zwuP0IjK5Wjo4wWZAlB3iXmSzIGNNTEcPP/aMVM3OVxso1lTTN/lfya3H4+fwPvY9J
         C+Kx8v/0E2cYd+o51uE3Rm5s+R2B4r+T1rHgtDzGjvlwkezek7scfeSSnQVlZmnSCkk/
         QoiAKfxQ8l9q+pf45m5iDsb/5GMFnv79hGdzr6dy6k0JIwoBSBMzHd1LjyOJRsvlmwCP
         aRVjkKSYXRoBIds9hs5IxvXXtc9L0SRHDRy2ltY3DlZo/fjHwAGQF1GKQZLOOcpXuLFK
         5ClQ==
X-Gm-Message-State: AGRZ1gJXJvUavYa53TvGoBwZ4X5ns70WlcY0iS6cvZq6ZG0MjmRM7IDR
        rOYHxZoCdilGQs0AkH0WM+7iZT0GXDD9nTShKKI=
X-Google-Smtp-Source: AJdET5f95MlCgBqZm73HnXZMH9eATa0RGydbqINllRX/i+PGr2WA/TD49rinMVwTGrNNVStNKe4TUyU8C2lN/QAtWlQ=
X-Received: by 2002:ae9:f50d:: with SMTP id o13mr724081qkg.137.1541427697716;
 Mon, 05 Nov 2018 06:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20181102182123.29420-1-v.mayatskih@gmail.com> <20181102142446-mutt-send-email-mst@kernel.org>
 <f7a5924f-b401-7b49-4734-9a21afc8cb3b@de.ibm.com>
In-Reply-To: <f7a5924f-b401-7b49-4734-9a21afc8cb3b@de.ibm.com>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Mon, 5 Nov 2018 09:21:25 -0500
Message-ID: <CAGF4SLjKnh21BuFfksJNgOisJbUWPafU2yLfGn=pJ=U2XNHbBw@mail.gmail.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
To:     borntraeger@de.ibm.com
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This should also work with other transports like virtio-ccw (instead of virtio-pci).
> Correct?

I guess it can. There's nothing in the code specifically asking for or
depending on PCI.
