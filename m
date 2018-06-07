Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OOotKj5RGVu+DQAAmS7hNA
	; Thu, 07 Jun 2018 15:39:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DD248608BA; Thu,  7 Jun 2018 15:39:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zve2IkXh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 70C9860590;
	Thu,  7 Jun 2018 15:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70C9860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935211AbeFGPjw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933193AbeFGPjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:39:49 -0400
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com [209.85.214.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D23C120896
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528385988;
        bh=K2K5f4TU+IqqOaLG++7PxVszhXQtKYnAib863khdimA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zve2IkXhA6kI+PdGVwxlyrda3p9+ZDB69d+lMi/ZvKvr2Tj9O2G6YxHF3eHfXmGTl
         jTEQGteAvtvv6NTNMPMt084i3nuwjV7Bdw31JJhkyLzYXGWWGQZ93xMTQUIp0Mw6R3
         au2xusAy083vpbwXNPP6+/QhOTt3/F07x+bGrzas=
Received: by mail-it0-f45.google.com with SMTP id j186-v6so13188397ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 08:39:48 -0700 (PDT)
X-Gm-Message-State: APt69E1YgDy9saVfEKjkMzCXC3CdZ0GaBXDAMCHfdTckBV15lpuNHbhz
        v/3b5F2e2UvQEe4kovCNaGrfUccRu353aOWevRlD5Q==
X-Google-Smtp-Source: ADUXVKJeifGxClWetEM14/uRDJdyI4tiKA7zyhthdXd4HZZ2lsGQzaczi/gUmlgMw+fldU/kCvnK//FTEt253c9gKh8=
X-Received: by 2002:a24:490:: with SMTP id 138-v6mr2557373itb.95.1528385988301;
 Thu, 07 Jun 2018 08:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143544.3477-1-yu-cheng.yu@intel.com> <20180607143544.3477-6-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143544.3477-6-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 08:39:36 -0700
X-Gmail-Original-Message-ID: <CALCETrWVZfWUSOy6wRyVBfP2b2TzZuPt8bCe6q0Pa5r7onO+VA@mail.gmail.com>
Message-ID: <CALCETrWVZfWUSOy6wRyVBfP2b2TzZuPt8bCe6q0Pa5r7onO+VA@mail.gmail.com>
Subject: Re: [PATCH 5/5] Documentation/x86: Add CET description
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

Fix the subject line, please.  This is more than just docs.

>
> Explain how CET works and the noshstk/noibt kernel parameters.

Maybe no_cet_shstk and no_cet_ibt?  noshstk sounds like gibberish and
people might need a reminder.
