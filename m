Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336CAC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA632081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5y+oCDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA632081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbeKFBfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:35:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40404 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbeKFBfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:35:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so14440247qki.7;
        Mon, 05 Nov 2018 08:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGKTyEwBkiHmoOnGxaQVM3cDnobgjRiO8NfZn/SNB9Y=;
        b=h5y+oCDbjotCqeiVlaEkeGoHFHaUkK3i38dgFK028c/hQez4Q9RXmb/TMzIhW4siQs
         p4KxaSdoQ5eeXBa9Psel3pHdPiPF4B+Irq3gXYp086bm5MiHvR1Mt0verIfpfmHDyF/V
         FKjGvTE4w7u3x0YNeSo4+oqD6Qb0GVUTWEkZZmBCL93XkduFV95scrPAcLq6ouJNr2gG
         5azw+LmGKm3o01f46o906NqQMIBBIUm3F15L8J0Evr4njbZFoQWiFAi+OVWJbR3fn4pz
         xXaidO1EY2RAVhaRDT3Sym9xIceMcA0Nn3GK4vBbKY+T43+S6RmfkuBAqTAQPDKJNWwQ
         U6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGKTyEwBkiHmoOnGxaQVM3cDnobgjRiO8NfZn/SNB9Y=;
        b=ToSUu/ixKk2TBLfZsLFZEVeGE0Usp7JtmfjuL5K/48CSeV7zx3OsI95dXnJPkSpU5I
         uGq5dFz+3jb7G+oSvN6LdURwOSjiD4Ek/PzBTxPJf16Y1llkpdF8/yfk9gTVqfyPASkL
         iMUX/nfi76IufPCKwfVt4vhSbSweexV2/KW2SMnLSKADGWkUq9zfRCF0nujYn3JTCxWh
         yXeADw1B2tGRsKFeVnoY7kFtcDlRhzZ77FE3aQglXPztOF6lZ9M3IQ27faVJvxZ1Nfpx
         k6UE9b79q4ZHZCLeNxF9Bs9Mx7SOUttqLp5d6cKD818Awsw+V+3UBi8D+S1R6N9YajE7
         Z2rg==
X-Gm-Message-State: AGRZ1gIUFJ39ZHfisii4xGqoqaJ1mu+bb6jplauYk59fx5wZyVm/QCkI
        ekpy9rscBrkOUAbuKFaegX8vwdgdhz8MA8kB6kI=
X-Google-Smtp-Source: AJdET5e8v7u/fm7em3OuZhHOrvTK4dfrUm3i5TtBlbIKtiC5WPFOGGVIgMzP2CFsBpJzcG1LQoQLLhUVll6UKi5I8M4=
X-Received: by 2002:ae9:f50d:: with SMTP id o13mr1186402qkg.137.1541434517189;
 Mon, 05 Nov 2018 08:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20181102182123.29420-1-v.mayatskih@gmail.com> <6a7f1668-bf2d-0caa-2efd-c8fab5f1db24@redhat.com>
 <c042686f-db95-514d-8bd8-92b72e4e087a@de.ibm.com>
In-Reply-To: <c042686f-db95-514d-8bd8-92b72e4e087a@de.ibm.com>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Mon, 5 Nov 2018 11:15:04 -0500
Message-ID: <CAGF4SLjC5Gs33k1XzK8vFF5FWE0pwHvB56iQ--DJ_4ADw5yuGg@mail.gmail.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
To:     borntraeger@de.ibm.com
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 10:48 AM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:

> For the record, we still do use virtio-blk a lot. As we see new things like discard/write zero
> support it seems that others do as well.

Yes, trim/discard and writesame support is planned, at least for
submit_bio path (not in this patch).
-- 
wbr, Vitaly
