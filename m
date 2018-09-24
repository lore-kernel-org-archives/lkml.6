Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40894C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E214D20883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thYrGnJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E214D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeIYEJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:09:02 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:36638 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeIYEJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:09:01 -0400
Received: by mail-qt1-f173.google.com with SMTP id t5-v6so11264143qtn.3;
        Mon, 24 Sep 2018 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkF33MLWcoS57vPrnhsAQXvElpjprcaYw/rYh6a7lI4=;
        b=thYrGnJr/QaSj7b2okJRyfGxjrkgcm+3fhuu3skNx/crC+jzqE5aJCq07Ooqes21sN
         LTj1IKH9t4QOy98duisvSGjIQ1EQRAiv2IJ/H/w/obXCKK57L3q+6n6fUFFJvHrKeBj+
         5zTGw+ExMsCq8kOEL1mCf558Tk8j8VU4MI9ecfIe/ZXWlO9mLKaUZxcZWK+80LpUUaVx
         Z6M3JkiQVS8l3YJQZyuji6YrxiBt8ukZ/uYEkZ8lyUoMXP0EAP3dZsmwt3myN5clDbH2
         fdeC4qe+LeXSjIS9MPJPYFqRFoH/Y1XII2Jt057JRK2PGjblqG4lll7XEnA63UvU2Qum
         K8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkF33MLWcoS57vPrnhsAQXvElpjprcaYw/rYh6a7lI4=;
        b=IOFT9ayyBgsD3FUaOe9OHBeCq1fDbTGtxeCaCvBTBaoc/cnyYiLNMikxW0UDI4bQ7c
         1CtUkz7HFt8lpKiIQwYHdblGZSDMigxNI6KlaNDbRIrelqj/lX2Tb02EYZxxdx2kt464
         7xRJLWn9cOQiK7NXVW4jBz/fUyca++mJHhXhmaTFLu4ngbIjsrC0BywezP0EpQd7D4I2
         +3ltQykrBxOUNQTerCZjO6XME1iu5OEZ0muhF4nG9nQ3DXTVravuFEwLbyTsy1jmkwmH
         Yy79JQCOt5LKnF7rn9Un3mlGgFMxLwVBErSdAAje75nE4zCRJKJw3hY5f/+IHKlYuHD3
         qAuw==
X-Gm-Message-State: ABuFfojhPgCdMfbHep17gWNgN1EMW5HN97aW/OFX19kOwimJ8ST1fU1P
        hqmuL1bQo3mLGq+e7tdtcFQxttPD0cii3EeadvE=
X-Google-Smtp-Source: ACcGV620oyuf1h1TxNxL976Dkbo00pxf06j0A5n+B1/K1RuiW6+2cLxGqfI0vAa3kDI9HSUpreC+ifRIwcNOBXgTBks=
X-Received: by 2002:ad4:420a:: with SMTP id k10-v6mr692542qvp.212.1537826682058;
 Mon, 24 Sep 2018 15:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180921224700.10524-1-guro@fb.com> <20180921170929.2d278d65@cakuba.netronome.com>
In-Reply-To: <20180921170929.2d278d65@cakuba.netronome.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 24 Sep 2018 15:04:31 -0700
Message-ID: <CAPhsuW4fdormBduhrVChMATpxkQ16whYSv9DvGoS0oXnrrNxiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: add support for BPF_MAP_TYPE_REUSEPORT_SOCKARRAY
 maps
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     guro@fb.com, Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, Kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:10 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Fri, 21 Sep 2018 22:47:20 +0000, Roman Gushchin wrote:
> > Add BPF_MAP_TYPE_REUSEPORT_SOCKARRAY map type to the list
> > of maps types which bpftool recognizes.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Cc: Yonghong Song <yhs@fb.com>
>
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Acked-by: Song Liu <songliubraving@fb.com>
