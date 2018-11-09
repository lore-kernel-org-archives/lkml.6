Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5941C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FA420827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FA420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeKJGSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:18:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48196 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeKJGSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:18:48 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01AFCC46;
        Fri,  9 Nov 2018 20:36:34 +0000 (UTC)
Date:   Fri, 9 Nov 2018 12:36:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, jreck@google.com,
        john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org, hch@infradead.org,
        Al Viro <viro@zeniv.linux.org.uk>, dancol@google.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Lei Yang <Lei.Yang@windriver.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, minchan@kernel.org,
        Shuah Khan <shuah@kernel.org>, valdis.kletnieks@vt.edu
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to
 memfd
Message-Id: <20181109123634.6fe7467bb9237851250c9c56@linux-foundation.org>
In-Reply-To: <20181108041537.39694-1-joel@joelfernandes.org>
References: <20181108041537.39694-1-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 20:15:36 -0800 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> Android uses ashmem for sharing memory regions. We are looking forward
> to migrating all usecases of ashmem to memfd so that we can possibly
> remove the ashmem driver in the future from staging while also
> benefiting from using memfd and contributing to it. Note staging drivers
> are also not ABI and generally can be removed at anytime.
> 
> One of the main usecases Android has is the ability to create a region
> and mmap it as writeable, then add protection against making any
> "future" writes while keeping the existing already mmap'ed
> writeable-region active.  This allows us to implement a usecase where
> receivers of the shared memory buffer can get a read-only view, while
> the sender continues to write to the buffer.
> See CursorWindow documentation in Android for more details:
> https://developer.android.com/reference/android/database/CursorWindow

It appears that the memfd_create and fcntl manpages will require
updating.  Please attend to this at the appropriate time?

Actually, it would help the review process if those updates were
available now.

