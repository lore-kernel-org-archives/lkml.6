Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A109C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3415622419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3415622419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbeKOERZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:17:25 -0500
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:45736 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOERZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:17:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 9E91F16010E;
        Wed, 14 Nov 2018 10:13:09 -0800 (PST)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hmbhwn2BKonS; Wed, 14 Nov 2018 10:13:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 96602160107;
        Wed, 14 Nov 2018 10:13:08 -0800 (PST)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rxTvXQwmwph4; Wed, 14 Nov 2018 10:13:08 -0800 (PST)
Received: from Penguin.CS.UCLA.EDU (Penguin.CS.UCLA.EDU [131.179.64.200])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 64085160106;
        Wed, 14 Nov 2018 10:13:08 -0800 (PST)
Subject: Re: Official Linux system wrapper library?
To:     Joseph Myers <joseph@codesourcery.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Daniel Colascione <dancol@google.com>, nd <nd@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
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
 <875zx2vhpd.fsf@oldenburg.str.redhat.com>
 <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <20181113193859.GJ3505@e103592.cambridge.arm.com>
 <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
 <1C1B38FC-1266-4A91-B8F6-20A0C49ED1E2@amacapital.net>
 <alpine.DEB.2.21.1811141735070.16571@digraph.polyomino.org.uk>
From:   Paul Eggert <eggert@cs.ucla.edu>
Openpgp: preference=signencrypt
Autocrypt: addr=eggert@cs.ucla.edu; prefer-encrypt=mutual; keydata=
 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
 uNcby4U=
Organization: UCLA Computer Science Department
Message-ID: <00dc083b-2e56-af27-30b5-1effe5a7c8c4@cs.ucla.edu>
Date:   Wed, 14 Nov 2018 10:13:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811141735070.16571@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/18 9:40 AM, Joseph Myers wrote:
> Historically, there was once an attempt to rework POSIX into a separate
> language-independent definition and language bindings (for C, Fortran, Ada
> etc.), but I don't think it got anywhere, and it's probably doubtful
> whether the idea was ever very practical.

That effort did produce IEEE Std 1003.5-1992 (Ada Bindings to IEEE Std 
1003.1-1990), IEEE 1003.5b-1996 (Ada bindings for realtime extensions), 
and IEEE Std 1003.9-1992 (F77 Bindings to IEEE Std 1003.1-1992). The Ada 
group simply translated the POSIX standard from C into Ada, repeating 
functional text and coming up with a "thick" standard; in contrast the 
Fortran group did a "thin" standard that focused on Fortran mechanics 
and deferred underlying functionality to the main POSIX standard. The 
thin Fortran standard was harder to grok and was less successful in 
practice.

As you write, these efforts were probably not worth the trouble. Non-C 
language systems can provide a standard way to invoke C APIs, and then 
let user-level programmers have at it. The performance advantage of 
having a pure Ada/Fortran/etc. API for POSIX are so minor that it's not 
worth the major hassle of standardizing and using a language-independent 
POSIX API.

