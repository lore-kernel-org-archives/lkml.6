Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A9FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6381C2077B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6381C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeKLLnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:43:22 -0500
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:38568 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbeKLLnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:43:22 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2018 06:43:21 EST
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id E610C160093;
        Sun, 11 Nov 2018 17:44:53 -0800 (PST)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UFukRyYj5VgG; Sun, 11 Nov 2018 17:44:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 26ADE160098;
        Sun, 11 Nov 2018 17:44:53 -0800 (PST)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DqQtkmm0HEOI; Sun, 11 Nov 2018 17:44:53 -0800 (PST)
Received: from [192.168.1.9] (cpe-23-242-74-103.socal.res.rr.com [23.242.74.103])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id CAA0B160093;
        Sun, 11 Nov 2018 17:44:52 -0800 (PST)
Subject: Re: Official Linux system wrapper library?
To:     Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Message-ID: <11149279-14f7-68b4-dc5e-d90924d40d0c@cs.ucla.edu>
Date:   Sun, 11 Nov 2018 17:44:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Colascione wrote:
> This resistance to exposing the capabilities of
> the system as they are, even in flawed and warty form, is what I meant
> by "misplaced idealism" in my previous message.

With my application-developer hat on I prefer some resistance to flaws and 
warts, as the resistance gives me a better feel for which functions are 
problematic and which can be used more reliably. If glibc is missing Linux 
syscall functionality that I really need then I can use syscall (with the usual 
caveats) and I've done that on occasion (and have regretted it later too :-). It 
is helpful for glibc to prefer mild curation to slavishly copying an API that 
can be a bit helter-skelter at times.
