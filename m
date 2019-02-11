Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA47BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A952083B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="njol1YSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfBKWz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:55:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37067 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbfBKWz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:55:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so272991pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KplfF3dDiknyhJPmcD3zP3gUkdi4lGnQlqW+Zff5OnA=;
        b=njol1YSaCg8wfOs75W7wPbCb3jEPLGS3D8vWlx34SiRyCjz54bf82P36X09M2ZhvhP
         Xm61hmolJCYs2P5/wNIiixmbOBA2pxDD4UaXyj3LEM+JtBAo+XgCzidbnTQAWwXHvCbA
         R1bYmhwOh1yR7rQsvLB2DOLpfI3bHf6Cc4l7O26KDF8sX+q9QhX8ocgpyWGDBZKyXqme
         7ev7W514jcnQOzIaM1Rgm2QgI+VBHMHUPb29ukKFQ6TSwzOBGBcX/+T+XZZrFiszYZWO
         mk7rrriZCdskYv8yLjD5LWKIVQrOvNah3MvEZKx+R+xKiTAzZq2Uni87oI4itAVgRcVt
         m1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KplfF3dDiknyhJPmcD3zP3gUkdi4lGnQlqW+Zff5OnA=;
        b=WwTxGp+vCExt+AdKwyYe4qsmv3vzRYtCjuw2ZTxXm4jhFxPfpUo/1QARn7DGDJqm7W
         YN1W9EpWcWWY8RHptiuSTv08/CCC/+p0qIQNlJ1M84ODN1EB6/vaN9t2Xl0fg+BUzS7b
         3L+7lHc5gf0uu9a45fTmsHAnnH66HUmLZCprqJHevSVp7d1kfZ6DKyBZYouppU+AF+EX
         wSxGDLrYMv/Awz5VSTMASzCy5aMiULmGH0J+EQWIjjn0bimKuhXeDMZO+6FBm+svL3Uf
         wbPLPhqhz0K4yws4gFgI5fZFtT3n8p+wmxxzFqq0F5gAUqUASu7rnqBZodEX4eaydQbi
         dZ+w==
X-Gm-Message-State: AHQUAuYnehpiIKunDNE0qGAvxjJZTtZCrV/je+U+2JaRPF5wmRrHLbuH
        UD+wN2Pbpqg+dnVu5+uQGPvGdgEBMhuDnA==
X-Google-Smtp-Source: AHgI3Ib5J1mi14Bra4k9Ib0cba8WTFmujoE1zbGF7cAwNm5igF+mzp2MEnazQf5rjLep6WCS1NLI5g==
X-Received: by 2002:a65:62da:: with SMTP id m26mr622452pgv.278.1549925725283;
        Mon, 11 Feb 2019 14:55:25 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n10sm18198901pfj.14.2019.02.11.14.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 14:55:24 -0800 (PST)
Subject: Re: Licensing of include/linux/hash.h
To:     Martin Steigerwald <Martin.Steigerwald@proact.de>,
        Domenico Andreoli <cavok@debian.org>
Cc:     Kristian Fiskerstrand <k_f@gentoo.org>,
        Ben Finney <bignose@debian.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "919356@bugs.debian.org" <919356@bugs.debian.org>,
        "debian-legal@lists.debian.org" <debian-legal@lists.debian.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <jens.axboe@oracle.com>
References: <20190115170017.5gxarqxzfezgr5ld@dumbo>
 <c3aa1b37-60bb-aceb-10ba-9768157a2a5a@gentoo.org>
 <20190211072259.GA19224@nouveau> <2977287.v5rPGuGa1n@merkaba>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f9f7dd8-3d47-d463-6322-c6d9865cd545@kernel.dk>
Date:   Mon, 11 Feb 2019 15:55:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2977287.v5rPGuGa1n@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 3:50 AM, Martin Steigerwald wrote:
> Adding in axboe@kernel.dk, as I am not sure whether the oracle.com address
> from Jens is actually valid / up to date.
> 
> Domenico Andreoli - 11.02.19, 08:22:
>> On Mon, Feb 11, 2019 at 12:08:32AM +0100, Kristian Fiskerstrand wrote:
>> >
> Mit freundlichen Grüßen / With kind regards​
> 
> Martin Steigerwald	 • 
> 	Proact Deutschland GmbH
> 
> Trainer
> 
> Telefon: *+49 911 30999 0* <tel:+49%20911%2030999%200>	 • 
> 	Fax: *+49 911 30999 99* <tel:>
> 
> Südwestpark 43	 • 
> 	90449 	Nürnberg	 • 
> 	Germany
> 
> *Martin.Steigerwald@proact.de* <mailto:Martin.Steigerwald@proact.de>	 • 
> 	*www.proact.de* <https://www.proact.de/>
> 
>  
> Amtsgericht Nürnberg
> 	 • 
> 	HRB 18320
> 
> Geschäftsführer: 
> 	Oliver Kügow	 • 
> 	Richard Müller	 • 
> 	Jakob Høholdt
> 	 • 
> 	Peter Mikael Javestad
> 
>  
> – Delivering Business Agility –
> 
>  
> 
> On 1/23/19 9:50 AM, Domenico Andreoli wrote:
>> > > Ben Finney <bignose@debian.org> writes:
>> > >> Domenico Andreoli <cavok@debian.org> writes:
>> [...]
>>
>> > >>> the only knot left is now the license of hash.h
>> > >>>
>> > >>> This file is also present in the kernel [0] with an updated copyright
>> > >>> but still without license.
>>
>> [...]
>>
>> > >> To know that work (that file) is free software, we need a clear grant
>> > >> of
>> > >> some specific license, for that work.
>> > >>
>> > >> If the work is not free, it would be incorrect to have the work in
>> > >> Debian.
>> > >
>> > > Is it possible that for the kernel it is instead correct because it is,
>> > > as whole, covered by its COPYING?
>> > >
>> > >> Alternatives, for complying with the Debian Free Software Guidelines
>> > >> with
>> > >> this package, include:
>> > >>
>> > >> * Find a credible grant of license under some GPL-compatible free
>> > >>
>> > >> license to that exact file. Document that explicit grant in the
>> > >> Debian
>> > >> package. This demonstrates the work is DFSG-free.
>> > >>
>> > >> * Convince ???dwarves-dfsg??? upstream to replace that file with a
>> > >> different> >>
>> > >> implementation (I don't know whether such an implementation exists)
>> > >> under a license compatible with the same version of GNU GPL. Document
>> > >> that explicit grant in the Debian package. This demonstrates the
>> > >> modified work is DFSG-free.
>> > >>
>> > >> * Replace that file in Debian only, with a different implementation as
>> > >>
>> > >> above. Document that explicit grant in the Debian package. This
>> > >> demonstrates the modified Debian package is DFSG-free.
>> > >>
>> > >> * Move the work to the ???non-free??? area.
>> > >>
>> > >> * Remove the work altogether.
>> > >>
>> > >> Those are in descending order of (my recommended) preference.
>>
>> [...]
>>
>> > It was [pointed out] by one of our license group that [hash.h] is the
>> > same that has a GPL-2+ in [fio] which has a signed-off-by.
>> >
>> > References:
>> > [pointed out]
>> > https://bugs.gentoo.org/677586#c1
>> >
>> > [hash.h]
>> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/fio.git/commit/hash.
>> > h?id=bdc7211e190482f0c17c109a0d90834a6611be1c
>> Yes, the Signed-off-by is from Jens Axboe (in CC) but he's not the
>> original author, I guess he just copied the file as Arnaldo did. The
>> file he committed has not any reference to the license.
>>
>> > [fio]
>> > https://metadata.ftp-master.debian.org/changelogs/main/f/fio/fio_3.12-2_co
>> > pyright
>> I'm afraid that this entry in wrong. I'll seek confirmation with Martin
>> Steigerwald.
> 
> Which entry to you refer to? I assume the one about hash.h.
> 
> Well the file has in its header:
> 
> /* Fast hashing routine for a long.
> (C) 2002 William Lee Irwin III, IBM */
> 
> /*
> * Knuth recommends primes in approximately golden ratio to the maximum
> * integer representable by a machine word for multiplicative hashing.
> * Chuck Lever verified the effectiveness of this technique:
> * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
> *
> * These primes are chosen to be bit-sparse, that is operations on
> * them can use shifts and additions instead of multiplications for
> * machines where multiplications are slow.
> */
> 
> It has been quite a while ago. I bet back then I did not regard this as
> license information since it does not specify a license. Thus I assumed it to
> be GPL-2 as the other files which have no license boiler plate. I.e.: Check file
> is it has different license, if not, then assume it has license as specified in
> COPYING.
> 
> Not specifying a license can however also mean in this context that it has no
> license as the file contains copyright information from another author.
> 
> Of course I can update copyright file in case my conclusion from a long time
> ago was wrong.
> 
> Jens?

Right, if nothing else is noted, it's GPL v2.

-- 
Jens Axboe

