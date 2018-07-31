Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C284C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B158C2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="NOv8yeKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B158C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeGaSos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:44:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38044 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbeGaSor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:44:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so1894548plq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bD+dI/ZDU652DT+E0YXXjPjGHldz5JsY8+U6ZRkcsXs=;
        b=NOv8yeKj1ZmQxUrC6V6ji1WN0vKMWoRMacfTkg16swtfsLEqK5IGn+8LV6cphK+VM0
         aLQVnqdZfi3nzAKtPbQIiFhXwJ9avffbosrGzj8gvNBI7XqHIYunSFjAsvhI7C9p82BD
         6c7vP3Y/8eWEzTUkAmTv1+D3en/cDXZvU1cMmf+4kRGT3ifd1RXoN49qtiZJOUUZ6yF3
         HkMiB7fOkwWEmvhfIZV3jGNV4mo/Q+5xDTgQNwXm9UIdYbIBddgyO5r1LWGXZnuvoO28
         3ov9l3cEaR9GAPHass2+msJ1rV/7HFTL88zQAwMcCy1ovqRyIQ2sUDx9UYuiIuxwzsDG
         9Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bD+dI/ZDU652DT+E0YXXjPjGHldz5JsY8+U6ZRkcsXs=;
        b=mwhRb/etHa4+LRhuv6hroz/EhfmV85gRd4kOpJ/671R4jqir4HZNk2JbYXWG9YZle6
         lnW1oUjUsLKPrX9Twu61iKcklQslVHZ13RCad5HFiyzsdeTLEccv/9pFHBLWJjTBMoYa
         IYJyM4DJlK+VXN/aiwcUciJG0jpMhs6A9koIcZ4mRdIoWzrXArI8aLE4/lKiIkxiyFnt
         6WmSyqWTbPV4tBl/SarvkAkW3SYZLQ2RaQHBSyNr+sRD5WBpAw7uZwp3/YqMGBsqYYT5
         DfNHcIEFZZBBRXpRfcYwhRy4BIrZEtCZY8oxnWc0Cp1ZWOkZyZO7+jnbNxRHrbJx1GZZ
         sa9A==
X-Gm-Message-State: AOUpUlG5eerR39VK83W0woQxNi3m1lh3hwUwwNvu/nyUxfG9SBWthLJt
        p8INltdhSSPbiGDUWT2wAbLdig==
X-Google-Smtp-Source: AAOMgpfPaFKiQoHnNImLvebdYpPFRSAdeE067f0UdB0EVBJUa2WWW7RnwgS5D3AHrdSZByr35VcDRQ==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21-v6mr20811009plr.264.1533056614093;
        Tue, 31 Jul 2018 10:03:34 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id h10-v6sm29220031pfj.78.2018.07.31.10.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 10:03:33 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id AE5303002A5; Tue, 31 Jul 2018 20:03:28 +0300 (+03)
Date:   Tue, 31 Jul 2018 20:03:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>
Subject: Re: Linux 4.18-rc7
Message-ID: <20180731170328.ocb5oikwhwtkyzrj@kshutemo-mobl1>
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
 <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
 <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1>
 <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils>
 <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <alpine.LSU.2.11.1807301940460.5904@eggly.anvils>
 <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
 <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 09:29:22AM -0700, Linus Torvalds wrote:
> On Mon, Jul 30, 2018 at 11:40 PM Amit Pundir <amit.pundir@linaro.org> wrote:
> >
> > This ashmem change ^^ worked too.
> 
> Ok, let's go for that one and hope it's the only one.
> 
> John, can I get a proper commit message and sign-off for that ashmem change?
> 
> Kirill - you mentioned that somebody reproduced a problem on x86-64
> too. I didn't see that report. Was that some odd x86 Android setup
> with Ashmem too, or is there something else pending?

I've got report from youling privately:

"mm: fix vma_is_anonymous() false-positives" cause my userspace boot failed，
our Androidx86 userspace can running on linux mainline kernel，
revert it boot succeed with 4.18rc7 kernel.

"mm: fix vma_is_anonymous() false-positives" cause these

07-30 11:04:19.556 1609 1609 F DEBUG : pid: 1304, tid: 1304, name: zygote
>>> zygote <<<
07-30 11:04:19.556 1609 1609 F DEBUG : signal 7 (SIGBUS), code 2
(BUS_ADRERR), fault addr 0x7494d008
07-30 11:04:19.556 1609 1609 F DEBUG : eax 00000000 ebx f337bb68 ecx
000001e0 edx 7494d008
07-30 11:04:19.556 1609 1609 F DEBUG : esi 7494d000 edi 00000000
07-30 11:04:19.556 1609 1609 F DEBUG : xcs 00000023 xds 0000002b xes
0000002b xfs 00000003 xss 0000002b
07-30 11:04:19.556 1609 1609 F DEBUG : eip f40f5c76 ebp ffa8d288 esp
ffa8d238 flags 00010202
07-30 11:04:19.581 1609 1609 F DEBUG :

-------------------------------------------------------------------------

The report also had screenshot attached about system info. It's a Baytrail
tablet with LinageOS, so I believe it's the same issue.

But it's not the only issue unfortunately. Tony reported issue with
booting ia64 with the patch. I have no clue why. I rechecked everything
ia64-specific and looks fine to me. :-/

-- 
 Kirill A. Shutemov
