Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF858ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488E32145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tcZHWPlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488E32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeJTCEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:04:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44547 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbeJTCEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:04:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id m18-v6so25886620lfl.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=URFdpKmR7MBDOg1F2ktj6/bvR16V6cHwaXYS8cjdJ9g=;
        b=tcZHWPlkmY2dWEEGj+fNVwRLJfThsAX1mwdfqLbUe6a9ToC15YXoM6sUgQGXNlDeDC
         SlaSQJEP+uqWMlWdmxHrNe11H9u+KLDHfyLCnvzMA1bYcV7Er4cyuOFvTMkvJMC+E7c7
         nqHets4YqJExT56C4z2BbluR5uJdpDfJ8xxrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=URFdpKmR7MBDOg1F2ktj6/bvR16V6cHwaXYS8cjdJ9g=;
        b=Wrx5Lv2fbfexFes2ORRyy8peEM2Kr3AJ/zbA1kR35ZBV2mbDUX6+kIRSOXqiCNfeq7
         +v6Qw9cCo6U9vs6jlv4UALDo2TG3gKCOTxeY4Tkris7W6X5hcqetNn0ZwgG2GvGx4ZkA
         rf2F4RIJzMLZ1u0yUcc8nKFao94HCziL7dfCLigrqG8Cq43r4uuf7p1eHSAqw+g0bjII
         Wd0HjiIw+nzlkqUUn/1MdE0msDQCHKKD4kxla/GLmS0YZ3tkUIe5tuYWfg95RHE7CLJ4
         BkyFvFAHTKmqP6pVgvwET4Br0RU5SF8RBc5gWdz8Tx8X5tBacfb5cqE2gDimB46o6zjQ
         Woog==
X-Gm-Message-State: ABuFfoisd8WgIYyF+sYOTcgV4Jm766XvfYIDRNBWriCVOhdlmds6NTzS
        o0uJ1noCeF7wif+3kWbmE2Xa3uDqSEExnY06C0R/6Q==
X-Google-Smtp-Source: ACcGV601wTjwMig9IJYjE9wtCjqHlsDfxvHZZHPQz86Z7B/C3x+Guqd+c35ktaJCOVpXRk9vOBkYZOWKzHqISL2xhjc=
X-Received: by 2002:a19:639b:: with SMTP id v27mr2759168lfi.95.1539971852486;
 Fri, 19 Oct 2018 10:57:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:8e91:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 10:57:31
 -0700 (PDT)
In-Reply-To: <42922.1539970322@turing-police.cc.vt.edu>
References: <20181018065908.254389-1-joel@joelfernandes.org> <42922.1539970322@turing-police.cc.vt.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 19 Oct 2018 10:57:31 -0700
Message-ID: <CAEXW_YTS2n2tOpXs3eVQZhYu7tmM_at0ZBA-04qYkHw4UE80nw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
To:     valdis.kletnieks@vt.edu
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 10:32 AM,  <valdis.kletnieks@vt.edu> wrote:
> On Wed, 17 Oct 2018 23:59:07 -0700, "Joel Fernandes (Google)" said:
>> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
>> To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
>> which prevents any future mmap and write syscalls from succeeding while
>> keeping the existing mmap active. The following program shows the seal
>> working in action:
>
> What is supposed to happen if some other process has an already existing R/W
> mmap of the region?  (For that matter, the test program doesn't seem to
> actually test that the existing mmap region remains writable?)
>

Why would it not remain writable? We don't change anything in the
mapping that prevents it from being writable, in the patch.

We do test that existing writable mmaps can continue to exist after
the seal is set, in a way, because we test that setting of the seal
succeeds.

I could test that processor stores can continue to happen my doing a
memset into the existing map, but I feel that is like testing 2+2 = 4,
in a way ;-) Do you really think its worth testing? If you do, then I
could add a test for that.

- Joel
