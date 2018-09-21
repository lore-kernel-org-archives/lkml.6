Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB6B21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="c7J7+08B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB6B21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390410AbeIUVNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:13:07 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40633 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390298AbeIUVNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:13:06 -0400
Received: by mail-it1-f195.google.com with SMTP id h23-v6so2282920ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NTb6q2/6NvaCo2lEt+p87YCjpJd5nfZ1KeuAd5Uysos=;
        b=c7J7+08BdKhaj4y7n6MLBwJXysdocIOQrE23ANkHmvVfVisB6beIi0SRxQxgCxYfwE
         Dj++aRUGV10LipwsEoL1jB0wsW2bTEL6/2PmCDsiRIqCVLJqtPUzzZmYnHt00RjW4b/h
         n0dOiOt4qU+FKBONkULWHiLEm2C1iNCBTwUu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NTb6q2/6NvaCo2lEt+p87YCjpJd5nfZ1KeuAd5Uysos=;
        b=eJbmXSA4mwtXKi0DLELXTN02VXkeee9E39y01hPgoS7cSUqhmk4Le51KsUZHGdaRez
         Ne7/zYzNvbJ9oEQrQ9ORC8e7FR0inpNN4AKAct1A+fA9Do9R6B+ecAWK3VqqUGiaPKxY
         pUPe9ZfSFg1qkzC7zncWAK8DXj5mD0VS9aTFEAvwY7Qzb5i4ytjPF4lwiCiM1zb6fnvu
         qb41LK/4p+baEcAT2Yy1FKTgISDXxx/hmyyovMd+lmXGvd7mIaCxn6/nbEQxHHfNSe1Q
         ke4Ffyq/iVX0/sOSpRoFZ9lzC86g3VbTZXvzE+UQEO0WLnlGnBD3MTEJmtHi5ufPjvX/
         Flnw==
X-Gm-Message-State: APzg51CDG8xrk9Vn/z+tOzZuzkCfG1lhRgcUdqkDJD2dK9uBZ8St0aNL
        k/sfvOpbNGAtyG3RP1jBjH8AXZk2wenloi0Lci0idw==
X-Google-Smtp-Source: ANB0VdZU7k69iy4uvA4zGkxCWumRel/OTyaYR5e2F9BwnYgL5owrDUy4SH/Kxo3A+gZyLA5IXXsoD/wek7yueZ0pmsE=
X-Received: by 2002:a24:e084:: with SMTP id c126-v6mr6331029ith.136.1537543423604;
 Fri, 21 Sep 2018 08:23:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 08:23:43
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <17547.1537542706@warthog.procyon.org.uk>
References: <20180920151214.15484-1-mszeredi@redhat.com> <20180920151214.15484-7-mszeredi@redhat.com>
 <17547.1537542706@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 Sep 2018 17:23:43 +0200
Message-ID: <CAJfpegueVku24snfr+RwdsdzLc_s5VrS1=TPhTJp6Tw1ZPf=PQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] fsconfig: rename FSCONFIG_CMD_CREATE to FSCONFIG_CMD_OBTAIN
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:11 PM, David Howells <dhowells@redhat.com> wrote:
> Miklos Szeredi <mszeredi@redhat.com> wrote:
>
>> The old name strongly implies that a new superblock will be created from
>> the fs_context.  This is not true: filesystems are free to retuse an
>> existing superblock and return that (for good reason).
>
> Kind of like open(O_CREAT) only ever creates files, right;-)
>
> Actually, FSCONFIG_CMD_OPEN might be a better name.

We've already opened the context with fsopen() and about to open a
file referring to a subtree with fsmount().  And this one doesn't
actually involve opening any files, so IMO it should not be called
_OPEN.

Thanks,
Miklos
