Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70C7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7FC21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Ov1XYkHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfBSUQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:16:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36185 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfBSUQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:16:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id v62so27626959otb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sqvq9WOCXxY9vLv/Rse2Zu7GWBX6BH0N+O595XQs04g=;
        b=Ov1XYkHmAtXJJwOlz6WpWNLRjouvNTg6FqiLhNyeGcaRbz+EZ8xj8AWusv/VN7221i
         RPHIzg9yiFhZao0wIMOaH7U6o28ept0FonQiY9ODipSTL8IzlotLHFveT4SoZEq93TKr
         aWcr1i8LSXkUHryCAZpzUQbgYsQfpkfTzv6zYCrYJlPDOMkJPxjFhsPoyiczeDwooony
         B1sx9kPAt4fWfKKYLrMMjWwDYQ5XKtcmP1cXN7p3GyTDY3rIqvHuR32sEdU0ERsOma26
         YfaxtYn3i4//26oSxsfQkTSyyRY3H09tOIfZ5iJhNWUjYB9MKAMSEpUREC2UunglwRMc
         2s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sqvq9WOCXxY9vLv/Rse2Zu7GWBX6BH0N+O595XQs04g=;
        b=o5VL9Bhi6Xh2QGSn3lOAKNyO8BwpXIlu6sb2UpNN2cP2hPZapXXNYuiEZotnGNSHw1
         t3eU+zPVLtcLT1RxsMrd87VhrDGOBTqJRFQo7IBwAr05u6ZP53J642we//WohKrI1UMz
         OnNh0p+StmNL/Ov25v5nfh2S4DMxaRFgaZEYCxmHGx1Ynhz/XtJuvgTc5N3BaG7SfPSn
         fRTnbaXMF2xe78ee/A5Rrk8KNajutR/8DLVKQK6HDPge1lmII1o3boXeIvpr9DENi1gv
         raLSDy2+fREjXQ5sfUzil0TaFybn9BA5pofouZ7CKsDLYs3V6b3v054LCmrXqHY4V2FK
         6RAw==
X-Gm-Message-State: AHQUAuZHxMKAmRShF6Wb6QSoS6Cs9sqoS3SRpSqVgcxs7UqH/zagcqYm
        F6L5HQp1AyPWtm3scoReTklF0Ksxp4alfXwi1IrjwQ==
X-Google-Smtp-Source: AHgI3IZuuZYL163cx5TXOjdw2RfWgoFCi7spqelc8kItl+zNUREvx4gFxmqO7tZx5Xno0pxM5tcGGXxD2PHQQ5vsZ50=
X-Received: by 2002:a05:6830:1c1:: with SMTP id r1mr9926774ota.229.1550607367114;
 Tue, 19 Feb 2019 12:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20190219200430.11130-1-jglisse@redhat.com>
In-Reply-To: <20190219200430.11130-1-jglisse@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Feb 2019 12:15:55 -0800
Message-ID: <CAPcyv4gq23RXk3BTqP2O+gi3FGE85NSGXD8bdLk+_cgtZrn+Kg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mmu notifier provide context informations
To:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        KVM list <kvm@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:04 PM <jglisse@redhat.com> wrote:
>
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>
> Since last version [4] i added the extra bits needed for the change_pte
> optimization (which is a KSM thing). Here i am not posting users of
> this, they will be posted to the appropriate sub-systems (KVM, GPU,
> RDMA, ...) once this serie get upstream. If you want to look at users
> of this see [5] [6]. If this gets in 5.1 then i will be submitting
> those users for 5.2 (including KVM if KVM folks feel comfortable with
> it).

The users look small and straightforward. Why not await acks and
reviewed-by's for the users like a typical upstream submission and
merge them together? Is all of the functionality of this
infrastructure consumed by the proposed users? Last time I checked it
was only a subset.
