Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9E8C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111172087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MWRjuo9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111172087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeJEAPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:15:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45228 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeJEAPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:15:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so10759012wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mg/oh8t/Ds8Fq0VnewlBzCB2UjYG2eg4P9SikZmW0qo=;
        b=MWRjuo9HnSLQetw9mggskQOepok0ihVGKmQ7TdwCwtbd1nIIgdlq1DNDbNzbbdAD9t
         yJ5T28z+9r9H+O5oT/jCUO1Kl9a6bDpsNTjAhiAUKX3FKPnBl5+IlhIFTWFG0CIqzXmx
         fDKZ81B1LXi19ows8WPcehCB88IfVs92JBouDeH+wYGlAud0+7IKLqsjA47QUfk4CbSW
         MZTPeIxHhrk3OJEfv7pioOqYQ+4IJohiTIwZe+gYeglAtutBZgsQOG56CSOL4lvLmvjd
         CVA5ai5GDcRU3l1h2s8Dg92GF4TdhqqlFBs9td7yk4gJAi+PGD1jynpsK+NOlbscPvQp
         A9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mg/oh8t/Ds8Fq0VnewlBzCB2UjYG2eg4P9SikZmW0qo=;
        b=L6l8meGCu47c4S1yct5y9JvnwlUxk3d8MAbm4hSBKJPGEYIjuwgu/5SGKDT2E012J7
         T6I+oBl1DzeQhp3xC5entI3jxNtoPYMUNj+XrmV7GIZ3sbydJZqNL1TzaMFRZd5ES6Dl
         lu5jN6ISdGOTFDRQJWbRl7GVNqTNSdYtqykilVqlztGKnUr7x2OqrAytj4wlES5XIyea
         OVdWxu+F09iQPdfJMzeAqj+XRHPy5HJybMY2agTTHFzq1pQ0vxf3tw/LRTRmyaXOEjl3
         82MyS+ExIs/JPorfbKY8OTCJ+qfAlqjSKtpG46s4EE9zi9RnGz6wZWXVqnC/0uDN+Ehb
         uCkw==
X-Gm-Message-State: ABuFfojK+TCu/RqN0iY5ZV2EPZgLE3Ppl2I4/eJfq/ChdZNzFznjOcNT
        x0PDTF37qJAz0PR6qasAyam5JQ==
X-Google-Smtp-Source: ACcGV63gJQ+iTVOvB/XCKv+sjKAInbj2w6b1FlNFiEmdHPHMS3Ltck5iyxR2raV1lbmtT0MG+prO4Q==
X-Received: by 2002:adf:e808:: with SMTP id o8-v6mr5337755wrm.269.1538673658645;
        Thu, 04 Oct 2018 10:20:58 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:2824:7b8c:14f1:9980])
        by smtp.gmail.com with ESMTPSA id i7-v6sm5038814wrb.30.2018.10.04.10.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 10:20:57 -0700 (PDT)
Date:   Thu, 4 Oct 2018 19:20:51 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20181004172050.wja5nwjkfa3jjmzw@brauner.io>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929103453.12025-2-cyphar@cyphar.com>
 <CAG48ez17EQuJQAZUg5hDFXhkjnnVFh39=aD+j0FBdsoTONSGEA@mail.gmail.com>
 <20181001130038.s5ztphs3pl2zt3ut@brauner.io>
 <20181001160431.emb6b2hf32b754cl@ryuk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181001160431.emb6b2hf32b754cl@ryuk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:04:31AM +1000, Aleksa Sarai wrote:
> On 2018-10-01, Christian Brauner <christian@brauner.io> wrote:
> > On Mon, Oct 01, 2018 at 02:28:03PM +0200, Jann Horn wrote:
> > > On Sat, Sep 29, 2018 at 4:28 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > > * AT_BENEATH: Disallow ".." or absolute paths (either in the path or
> > > >   found during symlink resolution) to escape the starting point of name
> > > >   resolution, though ".." is permitted in cases like "foo/../bar".
> > > >   Relative symlinks are still allowed (as long as they don't escape the
> > > >   starting point).
> > > 
> > > As I said on the other thread, I would strongly prefer an API that
> > > behaves along the lines of David Drysdale's old patch
> > > https://lore.kernel.org/lkml/1439458366-8223-2-git-send-email-drysdale@google.com/
> > > : Forbid any use of "..". This would also be more straightforward to
> > > implement safely. If that doesn't work for you, I would like it if you
> > > could at least make that an option. I would like it if this API could
> > > mitigate straightforward directory traversal bugs such as
> > > https://bugs.chromium.org/p/project-zero/issues/detail?id=1583, where
> > > a confused deputy attempts to access a path like
> > > "/mnt/media_rw/../../data" while intending to access a directory under
> > > "/mnt/media_rw".
> > 
> > Oh, the semantics for this changed in this patchset, hah. I was still on
> > vacation so didn't get to look at it before it was sent out. From prior
> > discussion I remember that the original intention actual was what you
> > argue for. And the patchset should be as tight as possible. Having
> > special cases where ".." is allowed just sounds like an invitation for
> > userspace to get it wrong.
> > Aleksa, did you have a specific use-case in mind that made you change
> > this or was it already present in an earlier iteration of the patchset
> > by someone else?
> 
> Al's original patchset allowed "..". A quick survey of my machine shows
> that there are 100k symlinks that contain ".." (~37% of all symlinks on
> my machine). This indicates to me that you would be restricting a large
> amount of reasonable resolutions because of this restriction.
> 
> I posted a proposed way to protect against ".." shenanigans. If it's
> turns out this is not possible, I'm okay with disallowing ".." (assuming
> Al is also okay with that).

Sounds acceptable to me.
