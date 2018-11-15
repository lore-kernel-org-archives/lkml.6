Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858D9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548DE2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548DE2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbeKPGnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:43:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40844 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeKPGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:43:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so33962034qki.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TTyPnkNEqZFrgHmg0jDUPsOGygrlMJCrZDLyT7Gr54g=;
        b=PMNNo9OqYfLU3WmUoZlT+iABx+Z9BBeWlRFB1sqHrRiKwJxtSQbuZZnspePjTiVwGT
         jTVxOcHPyM4tEBduMcoxQGJmDCEirkDIPMHrbRhCNKSy4vPGyyE9JE5rVcKpGvn9V3wW
         gN7LAlnV8Q9KaijulZ4p5yyxkG6QSDGDueojm91y/YjNQLbmwz63O6eXfl09y/jbV20X
         T9qrjDrLWs3rTFAuiar4gK4GFudSu/l9wvmxl0YqoW95brC451f3cwvKsWhe0Sr7ppqR
         63WSfKodMAVEL4NKmi1WQXwBEou6Bg77641NPsQiz1w0pGkQCEll7ms2k9MSjQYzLwFS
         XNxQ==
X-Gm-Message-State: AGRZ1gLZrsVdi+zAU9bi9RFDhFZanCboXqZiVUiEHy0h7ZHiysp7r73W
        WqNk3o+uJUcJ57Tzw4lsL5TL+g==
X-Google-Smtp-Source: AJdET5fvt9qfP82FaR29tkT67+T/iLioDsTPTIZb0qdBT03NbTwMECfodH21MJwlfc4aRdE2ilrIKg==
X-Received: by 2002:ac8:3b42:: with SMTP id r2mr7584739qtf.364.1542314058406;
        Thu, 15 Nov 2018 12:34:18 -0800 (PST)
Received: from [10.150.73.190] (161.sub-174-227-144.myvzw.com. [174.227.144.161])
        by smtp.gmail.com with ESMTPSA id v32sm11875849qta.37.2018.11.15.12.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 12:34:17 -0800 (PST)
Subject: Re: Official Linux system wrapper library?
To:     Joseph Myers <joseph@codesourcery.com>,
        Daniel Colascione <dancol@google.com>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>, nd <nd@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com>
 <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <20181113193859.GJ3505@e103592.cambridge.arm.com>
 <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
 <CAKOZuesta_V=doXsVLc2E6WCQvywdur3F+u2pFKaPN+CEQd+ZQ@mail.gmail.com>
 <alpine.DEB.2.21.1811141741000.16571@digraph.polyomino.org.uk>
 <CAKOZuetCGCfNdJ2QM0phu3_3Q29f5Yeh=NHiM_A9MhHsCjK48A@mail.gmail.com>
 <alpine.DEB.2.21.1811141840140.16571@digraph.polyomino.org.uk>
From:   Carlos O'Donell <carlos@redhat.com>
Openpgp: preference=signencrypt
Organization: Red Hat
Message-ID: <8189c55f-8869-8d54-bb23-1234bc6728b8@redhat.com>
Date:   Thu, 15 Nov 2018 15:34:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811141840140.16571@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/18 1:47 PM, Joseph Myers wrote:
> On Wed, 14 Nov 2018, Daniel Colascione wrote:
> 
>> A good demonstration of a new commitment to pragmatism would be
>> merging the trivial wrappers for gettid(2).
> 
> I support the addition of gettid (for use with those syscalls that take 
> tids, and with appropriate documentation explaining the properties of 
> tids) - and, generally, wrappers for all non-obsolescent 
> architecture-independent Linux kernel syscalls, including ones that are 
> very Linux-specific, except maybe for a few interfaces fundamentally 
> inconsistent with glibc managing TLS etc. - they are, at least, no worse 
> as a source of APIs than all the old BSD / SVID interfaces we have from 
> when those were used as sources of APIs.
 
I agree. Documentation is important.

-- 
Cheers,
Carlos.
