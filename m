Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C61C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F033D2082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6l/2fJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F033D2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbeJ3Hzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:55:40 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36036 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbeJ3Hzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:55:38 -0400
Received: by mail-ua1-f66.google.com with SMTP id w19so3744436uaj.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jPr8P9Yb6cTAfPKz4G37rJkKpt8pjHR2nbgyaSZtI28=;
        b=b6l/2fJ1IHh7Q6/FqKNHFXdPndabf7nkyugFOSeIIqrmulvRd7oftuAEgM+67JAS6n
         hoEO+lPYFXQ1aUCm7klGJTU9Z2WJGGVI6qXiBbQreyIRIEmxWsjaSbB8HtIgE4AAubeQ
         H6OeK73JYmTaqQ11Eb7ver1ENbv7n1KJywt0XT9G0GHBjqiaP6ZMpRPPAXNI3raWbkCc
         gi4RIvUk9lflgYwfcsj3Cky4pls3LDwWtGyIScpVgrXGPCmlIdl3clOdX9SNy6oRCjBS
         MPikXgLGakxl4O2lqH/E4b+DlJYIjEA7GvOCq5BbwaCzZA1vMuKPIrc4m3vbhw6tsT++
         PmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jPr8P9Yb6cTAfPKz4G37rJkKpt8pjHR2nbgyaSZtI28=;
        b=qwVgUtoG0OW3Yg/JTtqj5sIaoOEIop2DIHkUigOxn+J2g30TRhubruMqhCpodo7lWC
         sCErdUV5qxVbdFWLK28mWDZNxyEtvTxb+Qp7Dn7To6eR0O1cfEDXt5tG8yguByhuS2ZN
         +Hb0s+sM30dTHQrYeKIUHZEqxPNpuV3PCELU/LogSz4Djb4lS4tEObcm3rWmhdM1wcVM
         y1xZldRokZGmOXH2JVSkXX91wSbOvB0gR1HPQGkCJrhDyavBLg0S6gbMQmwTZU0dzIcl
         4hK/JbLk7FXhF1/pPoX3xe4d3VlM/NSQ9YXchkXDSErf/IiO1dtYhoFBdoUeWa35CCwW
         7pWw==
X-Gm-Message-State: AGRZ1gLGMrP3D6AcgeQ6rHAelgWUx9uDa8H34mWh/2pBr7Zzr/LJ1r9A
        G0B2cHRpdRTVfiOJ/xjjpuvUPi56c0ol/2+Z77LJmw==
X-Google-Smtp-Source: AJdET5dRsmbmnI0+J6mV1vEHY3Yc/9Wq0fRwbhQbxQw4VSFVm485EekVgBZbZeQS/OHgiRrwQfzdlKb7zNqPfC24heE=
X-Received: by 2002:a9f:262a:: with SMTP id 39mr7150912uag.13.1540854286301;
 Mon, 29 Oct 2018 16:04:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f492:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 16:04:45
 -0700 (PDT)
In-Reply-To: <20181029192521.23059-1-dave@stgolabs.net>
References: <20181029192521.23059-1-dave@stgolabs.net>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 29 Oct 2018 23:04:45 +0000
Message-ID: <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, longman@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 7:25 PM, Davidlohr Bueso <dave@stgolabs.net> wrote:
> This patch introduces a new /proc/stat2 file that is identical to the
> regular 'stat' except that it zeroes all hard irq statistics. The new
> file is a drop in replacement to stat for users that need performance.

For a while now, I've been thinking over ways to improve the
performance of collecting various bits of kernel information. I don't
think that a proliferation of special-purpose named bag-of-fields file
variants is the right answer, because even if you add a few info-file
variants, you're still left with a situation where a given file
provides a particular caller with too little or too much information.
I'd much rather move to a model in which userspace *explicitly* tells
the kernel which fields it wants, with the kernel replying with just
those particular fields, maybe in their raw binary representations.
The ASCII-text bag-of-everything files would remain available for
ad-hoc and non-performance critical use, but programs that cared about
performance would have an efficient bypass. One concrete approach is
to let users open up today's proc files and, instead of read(2)ing a
text blob, use an ioctl to retrieve specified and targeted information
of the sort that would normally be encoded in the text blob. Because
callers would open the same file when using either the text or binary
interfaces, little would have to change, and it'd be easy to implement
fallbacks when a particular system doesn't support a particular
fast-path ioctl.
