Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43628C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6F320858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6F320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389067AbeKPHJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 02:09:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45655 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeKPHJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 02:09:43 -0500
Received: by mail-qk1-f196.google.com with SMTP id d135so34057019qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 13:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xp2ona9E8uIkAWkzQq/Qm1Usibdrg/gG0CvEePIelmg=;
        b=Ay+Sed2JGTySJgaaWpx60N0fiPsZIDjPZ4+SXyMNcPPDeoYFM2l3SeqrxBCs7n6wYX
         yoPO/lisFgpYK0DYbBMufWZacZvNCPQfLtN9KAdmTyNvK9WUwuuso61xJ8rgx0zbPSak
         t9MOkiLH2lVszQ1VoFbz8MUbv+qhwRV53Wvea7VQZYKKo8S+xFauR130RqTapj1SqVQC
         45RHw8m7A5nPo/EJyfmKcTw503FA/tUA2i9zk4MGscstewrO43KUhJAQAxrrfrWWl4eA
         fwXunwXjrre34C77ytvM0aVbq22VzMQvSN//aMQP76VzK9fFEGYBAqvQz0fPN/zaI7Jc
         2oiw==
X-Gm-Message-State: AGRZ1gJPUCKoC7AFrUBoKp7CDMML2kjdyi0dQuGSjsczZKb/xl3d+jaY
        2aZbNKTmjxLInil7onExknwTOQ==
X-Google-Smtp-Source: AJdET5eOX2MKMIRd7mU4p2BGvghh3X91nVkLiwoiqa88SWXxrFCYONNMZo9kdxsVlK2kaq5N76xTRQ==
X-Received: by 2002:a37:10cf:: with SMTP id 76mr7372175qkq.99.1542315616135;
        Thu, 15 Nov 2018 13:00:16 -0800 (PST)
Received: from [10.150.73.190] (161.sub-174-227-144.myvzw.com. [174.227.144.161])
        by smtp.gmail.com with ESMTPSA id l30sm6947604qte.44.2018.11.15.13.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 13:00:15 -0800 (PST)
Subject: Re: Official Linux system wrapper library?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        Daniel Colascione <dancol@google.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>, nd <nd@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
References: <875zx2vhpd.fsf@oldenburg.str.redhat.com>
 <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <20181113193859.GJ3505@e103592.cambridge.arm.com>
 <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
 <CAKOZuesta_V=doXsVLc2E6WCQvywdur3F+u2pFKaPN+CEQd+ZQ@mail.gmail.com>
 <alpine.DEB.2.21.1811141741000.16571@digraph.polyomino.org.uk>
 <CAKOZuetCGCfNdJ2QM0phu3_3Q29f5Yeh=NHiM_A9MhHsCjK48A@mail.gmail.com>
 <alpine.DEB.2.21.1811141840140.16571@digraph.polyomino.org.uk>
 <20181115053026.GA20617@thunk.org>
 <alpine.DEB.2.21.1811151628490.27351@digraph.polyomino.org.uk>
 <20181115170807.GB20617@thunk.org>
From:   Carlos O'Donell <carlos@redhat.com>
Openpgp: preference=signencrypt
Organization: Red Hat
Message-ID: <48868f73-53b4-a01a-de73-4a7b56b91c60@redhat.com>
Date:   Thu, 15 Nov 2018 16:00:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115170807.GB20617@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 12:08 PM, Theodore Y. Ts'o wrote:
> On Thu, Nov 15, 2018 at 04:29:43PM +0000, Joseph Myers wrote:
>> On Thu, 15 Nov 2018, Theodore Y. Ts'o wrote:
>>
>>> That's great.  But is it or is it not true (either de jure or de
>>> facto) that "a single active glibc developer" can block a system call
>>> from being supported by glibc by objecting?  And if not, under what is
>>> the process by resolving a conflict?
>>
>> We use a consensus-building process as described at 
>> <https://sourceware.org/glibc/wiki/Consensus>.
> 
> So can a single glibc developer can block Consensus?

Yes.

I think the comparison to the "liberum veto" is not a fair
comparison to the way the glibc community works :-)

(1) Community consensus.

Consensus need not imply unanimity.

Consensus is only from the set of important and concerned
interests. The community gets to decide that you're a troll
that does no real work, and can therefore ignore you.

Consensus is blocked only by sustained objection (not just
normal objections, which are recorded as part of the 
development process e.g. "I don't like it, but I leave it
up to you to decide").

Therefore an involved glibc developer can lodge a sustained
objection, and block consensus.

(2) The GNU package maintainers for glibc.

There are 8 GNU package maintainers for glibc.

The package maintainers created the consensus process to
empower the community, but they can act as a final 
review committee to move issues where there are two
reasonable but competing view points.

As Joseph points out we haven't ever used the GNU pakcage
maintainers to vote on a stuck issue, but I will arrange
it when the need arises. If you think we're at that point
with wrapper functions, just say so, but it doesn't seem
like it to me.

-- 
Cheers,
Carlos.
