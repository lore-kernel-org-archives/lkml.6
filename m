Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-848599-1525692733-2-14661269009270232561
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525692733; b=c1c7Etm+L9SYgdITypf4pqEmQLwhNCDRHAZ0f59TXTH1ogBoQD
    hq/iyXoUr6x/35+x3lxZH4lUe2RPgzPns0DZdTzdPTFHhC4/v6MD2g39CMVRukkR
    Jj3CZz/mHbFC6wVyRXkQ6aNAnvSMa25RRPLlphE66w4N3CWot8lVzeFZ+nR3Avzz
    G1fGIx1dKmx8xA/gudHpVM+m5l6/oAMHb5Uyiibr5j4s6xe1lYZBcE1KzdRW2ykV
    l8vpUnsCjNUWr7cxrrrlZ6bunmDygeVYtI44M/xO71AULRmVznxDEC+kgxJGNyey
    324wmPkW6kcinl4E6kwbCCqDEaA+8TWjhGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525692733; bh=w+dd4uxn40E8oZdgsueHUZtN9gNTDN7xrV227qVEE8
    M=; b=Txim8Ev/W0GZH6G+gfHHenKdhwQHcPFNEpx20W6LO6tsfp7tNqIbGZUZhI
    oQ6zPAYjCalZNOu5ZY0hF7ZKIMPyEE/QWN+9IIIBJUNHkHCJ5IKn3liyCUaA5yie
    VybzSlXp6vIMXyCRbtZV4UH/Blo4uqt1w9oKxefQ8HTD6/BzCogco3nx0JRs3I3Y
    uVLE6gD8+5DxSjiVLh7EOC8tNaRUcNLfzvrGWDeklfTGbJAk53hnazI1bXrmcwdi
    IPrIaszMzN+8SBY/bFFR6UzHfSX5MLjD9juXYCgl4Yr8PC77WH4oVhKkFSKQrdzz
    Tg7olqAsMGfIIcJQvQlcvp7ijQ/A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=COGRPPM+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=COGRPPM+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN346ciFcMkJhCW6l3Kf7UUolRXErWUjlouC6HKya2vo1xkgSeGF3PpnJntkqvNxd4cZ2aoMA8Hzl+fmrv1Guugn+2ghOECbNxDOIX0jZZOHhIOpwbMm
    BIbnu1QBIAIqsa92rRPFjO7emBaS0H2AKdY9Z9qQSv5M222F9owEX1eNxN/C2uG1Jsc6rLzCuplmjNc0F6oKu+cwUiY/wLiPuKqrdURlYpFPDEir64EsQVEA
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=A2dn_LWby-bcAtiSJO0A:9 a=cuWTA9sZCVWSH8kd:21
    a=6Y3LBeycOhDmgUSw:21 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeEGLcL (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 07:32:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39172 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeEGLcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 07:32:10 -0400
X-Google-Smtp-Source: AB8JxZqL26yZ03BApknjCpS3nMuo1ibt9oIQaLRwV17gAZXGLNSkw0rNEecPkWSTTyGa1RUFeSxXsIYKySy/WSAqzk0=
MIME-Version: 1.0
In-Reply-To: <20180507111142.GA18116@bombadil.infradead.org>
References: <20180507082108.28186-1-mszeredi@redhat.com> <20180507082108.28186-2-mszeredi@redhat.com>
 <20180507111142.GA18116@bombadil.infradead.org>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 7 May 2018 13:32:09 +0200
Message-ID: <CAOssrKebppZhRbvM-3qk=S0aY57skYCEn2axknOtF9LcJcu8yA@mail.gmail.com>
Subject: Re: [PATCH 1/3] vfs: dedpue: return s64
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 7, 2018 at 1:11 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, May 07, 2018 at 10:21:06AM +0200, Miklos Szeredi wrote:
>> f_op->dedupe_file_range() gets a u64 length to dedup and returns an ssize_t
>> actual length deduped.  This breaks badly on 32bit archs since the returned
>> length will be truncated and possibly overflow into the sign bit (xfs and
>> ocfs2 are affected, btrfs limits actual length to 16MiB).
>>
>> Returning s64 should be good, since clone_verify_area() makes sure that the
>> supplied length doesn't overflow.
>
> Why s64 rather than loff_t?  Particularly since the next patch turns
> the paramters into loff_t.

Next patch turns the offsets into loff_t and leaves "len" as u64.  A
size is definitely not an offset, I'd consider changing the type of
"len" to loff_t a misuse.

Thanks,
Miklos
