Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DEAC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C413A208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A/TRGQ/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C413A208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbeGKBuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:50:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52849 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbeGKBuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:50:32 -0400
Received: by mail-it0-f68.google.com with SMTP id p4-v6so1454445itf.2;
        Tue, 10 Jul 2018 18:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxkyOn/QIS6pU9oXaGfQafuVWHGJkT+Qcz/JR0fwk7A=;
        b=A/TRGQ/rQT/smpA/xQMo1OieoZNpg5PyOAYN6xf46/qgyvX0+dPrEpK21CW0swjlVL
         xfGWdMixUp5Kikx9YVuAMD1wbYoc/HbzcQNOOJCZE5sR5d6lpKR/70slquNyU48QbhD6
         lKIOEtqJspIEEK+M/HkGxpWnTgFMDXrJEkxAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxkyOn/QIS6pU9oXaGfQafuVWHGJkT+Qcz/JR0fwk7A=;
        b=kOGPitZWr8uI7j8rAvskccLn6aaYukRrAPvvXmHw2wsk6hkE9bsC+T6oNuUKKvVAPf
         /YTx7yazdV35goM7Zix3FN46uzQdtyXXJeplUb9f1rib3ZQXKMAN3xsPtVXr4xnyvWB1
         sdvlN+QO8bm1Z7JB3z6ybiUoheY9/kGS41SnRsp3KoVt9Qh38nCu7M3Xh+lST+8ZDpF1
         ActrbdiMZHDJQnQfJT+8Ulr5dBrzKalsBMYbxtRtCmar1hxqMTmC5JgsrhlAzRR7zD0G
         IQqMgQuUjvS2W+Av77rRUgfnF1rP3yxKnHyP94XPDw9enqRTc1C6GF3qsdyUG/iFCMez
         lHfQ==
X-Gm-Message-State: APt69E3xJcB/nluQZUPuSuc16o3sGAH7DHVKxphNiO9k14dDrW91z5PJ
        btq8ktOljrHxv48I+287q63ixOKweN5qmyR2nFM=
X-Google-Smtp-Source: AAOMgpcB/S/88iJwWAEnAtJx/B/4hiz6t+lGdFm++EP954H3lgDvwt4WfJdm4X/tAenDwjYM9k7OUXJF5GLcM2/RwKU=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr20590388itg.1.1531273721639;
 Tue, 10 Jul 2018 18:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <CA+55aFzknfBLjg4-pRSCUeBFY3DWq04zX3PPyc949M0OygHktw@mail.gmail.com>
 <20180711011520.GL30522@ZenIV.linux.org.uk>
In-Reply-To: <20180711011520.GL30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 18:48:30 -0700
Message-ID: <CA+55aFznwKKy0Vj4Wxe16=2EUmgas_Dcr9QQ1tOJOQOEAVfr+w@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 6:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  How about "use credentials of opener for everything"?

yeah, we have that for writes in general.

Nobody ever actually follows that rule. They may *think* they do, and
then they call to some helper that does "capability(CAP_SYS_WHATEVAH)"
without even realizing it.

But I'm certainly ok with writes, if it's just filling a buffer.
Preferably a standard buffer we already have, like a seqfile or pipe
(hey, splice!) or whatever.

And then you have that final op to actually "commit" the state. Which
shouldn't be a write (and not the close).

           Linus
