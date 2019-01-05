Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E5FC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C7F222BB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqx40GO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfAEWy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:54:59 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43175 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfAEWy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 17:54:59 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so33135341oie.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 14:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWttGSuK6p3ZjKI0uWuqGI1eUFhgSNn7XCSj6cGkh3c=;
        b=eqx40GO4zIHPgE+QjMGQalPzUUHZbK7ytCQV+2CmGTqAUsFauvbP9beoaPzxmfh4d+
         QU4cVFLFYhOt/plmBGqWDbEMqcof5mtji5luIYrMfZuR87Vmn9mcGAGLmARrd8WY8w5J
         wsnO2lspdw7kaXOjpkWdVqh3lt8wOKbujTIYogecUOZqLuhilFfHIEtaxiJuqjlwpjx7
         ITEVR+0BTJp+xdMwflGSwgGQPgU3Y3a4HfKHs6hF2QJFwys4JpD4J/WJNo9vfADUtat6
         7zW/F1xVn3DSNj8gWosEo4KlI2TRjW5aDrfDQidAT+Td6IYrQsMl4UGKPh6jF0qkafFu
         r+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWttGSuK6p3ZjKI0uWuqGI1eUFhgSNn7XCSj6cGkh3c=;
        b=T3wjjSx6qazPTWqe92r1vJPTYlqCwai2wf7g2e/le5soxl9Mm2k6qzI4vEFzGoTiEJ
         cOmbqrmQEP6pofBXbKrTnvvxGEy+O4IjVIBbDOI9uOFFg8szWXbTRJoxCBp6rOB38+J9
         uHWYaKn7zl5Hvr7O2iNP+wJtceYhXxvxukVIrBS1xF96JIFg2C7m4AM4JqxCLEvlgl9i
         3/VSEqpDPVa4mK3ke2t1z1QJpdz1Mx/3WvMKAUvcYzedH1vIf35e2Oe+1JcqXwi/iAr/
         05GayvwxMvKD4nwhmC8XpL6h21RYOIpIhE1IO5etF5FoyLpvndT1/PbOWA9WwpVS4Ejp
         J8iA==
X-Gm-Message-State: AJcUuke6e/SZ8IO9wJOFDWG6s8xJ51PZSxbzNJ1DnAaE3vfuSy8gNMN/
        PVLC/i5KgKnOY/ENBfn2enOiURbQ1kAeAqOb4hwQqQ==
X-Google-Smtp-Source: ALg8bN45fc2VvmbJfiQx1YNlOX4oneiJm8hW7M1GM74nSdXA6z2wJWuqs1L0ynaCy3lW11h4eN4mTWsIhK100VDBlvo=
X-Received: by 2002:aca:bcc6:: with SMTP id m189mr4630820oif.337.1546728898294;
 Sat, 05 Jan 2019 14:54:58 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 5 Jan 2019 23:54:32 +0100
Message-ID: <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 6:27 PM Jiri Kosina <jikos@kernel.org> wrote:
> There are possibilities [1] how mincore() could be used as a converyor of
> a sidechannel information about pagecache metadata.
>
> Provide vm.mincore_privileged sysctl, which makes it possible to mincore()
> start returning -EPERM in case it's invoked by a process lacking
> CAP_SYS_ADMIN.
>
> The default behavior stays "mincore() can be used by anybody" in order to
> be conservative with respect to userspace behavior.
>
> [1] https://www.theregister.co.uk/2019/01/05/boffins_beat_page_cache/

Just checking: I guess /proc/$pid/pagemap (iow, the pagemap_read()
handler) is less problematic because it only returns data about the
state of page tables, and doesn't query the address_space? In other
words, it permits monitoring evictions, but non-intrusively detecting
that something has been loaded into memory by another process is
harder?
