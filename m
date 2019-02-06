Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126BCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A0C207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhh1iuSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfBFDZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:25:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33598 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfBFDZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:25:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so2485893plo.0;
        Tue, 05 Feb 2019 19:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6rorQDMO3FDb0/kjyAPfQvlsHjOV41wgtRdzX0XMGI=;
        b=Nhh1iuSMVdYkzzkh05BgjKsvzGATXBO8cstzzW+TvS5D51sFHhLx/1pIe2NWlO92LI
         mr094lm+XBq5uNBfSRI8Eck6T+GDuB20GLEyB3VvH9VHejbkTQCtFUSrZzEI9C9gaena
         aoddeUXnwZ7ym79TOVNrvfeZtpK6r0fe9qlc+y4uJ+j1KnT9tu++lAiZpjNQWtU2dREA
         Un/h+ZkXl4m4zCODLiUOpCkj7TCRmYaPiWjLFS3NmWfCuCB15EG4E5ZMqepMwY06gWxl
         pMCqd13U3M/A5I2Lxi7hOyIEXB06ZXniYxDrdHKJ1Pa0y4v1rb7ximZgcPO11PHkPrmm
         Z2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6rorQDMO3FDb0/kjyAPfQvlsHjOV41wgtRdzX0XMGI=;
        b=XfdWTV8ArkBXlQPaa+fJBi0zXWQJ+fHbkEBrjQaSqWnz646MujnhrVzxT8lQL/5DuY
         ySwePeqoIjv2pekWSSuCtDkeRaEksAVgoaweRQuOD5Kgqos2gsEtMCkZ+NkOF9UKgknY
         Qx1Cchs7NsrOUHIFb0wAXcCKFjcOjRJnRj/o1PD7RzCWqKmnnLLZc81ARsw5GmqIBOZM
         QpFPeTtVn1I9waRRkPMF+HgQE5ZkfqyGir8/PIiKG7f8yWyAR7Q/+2afvQO4YE1XVTGU
         LxwubUyVkLL/ErYf00cIMHG/lzLxqTj08mE3jjXfB44Mza0R6xEuAiRFBNDUDlI+FxHs
         tNjw==
X-Gm-Message-State: AHQUAuY1CEtSEEhXphoPi2RJgpWGezOzBG+vpR0uIqYwZtkPG3sMJmo8
        ZOarBPMGISabKLUiNz6vRQGdxjyjFqA=
X-Google-Smtp-Source: AHgI3IZ0aLs/Nue7DaSH78rPZjHXEoehZo1mYYW7pgPVHusGpek2hfV5RbEgyw2kizw/+XivMBrt1A==
X-Received: by 2002:a17:902:42e4:: with SMTP id h91mr8621445pld.18.1549423524646;
        Tue, 05 Feb 2019 19:25:24 -0800 (PST)
Received: from Paul-HP (174-17-117-135.phnx.qwest.net. [174.17.117.135])
        by smtp.gmail.com with ESMTPSA id p13sm5478279pgs.89.2019.02.05.19.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 19:25:24 -0800 (PST)
Date:   Tue, 5 Feb 2019 20:25:22 -0700
From:   Paul Zimmerman <pauldzim@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
Message-Id: <20190205202522.2ab2ea40430e817d4f01cc4e@gmail.com>
In-Reply-To: <9e4332bf41d5d58a4fa6cf138fc9ea3b2f9a488f.camel@perches.com>
References: <20190205192733.b4bd98988d1e4695f740d445@gmail.com>
        <9e4332bf41d5d58a4fa6cf138fc9ea3b2f9a488f.camel@perches.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Feb 2019 18:52:18 -0800, Joe Perches <joe@perches.com> wrote:
> On Tue, 2019-02-05 at 19:27 -0700, Paul Zimmerman wrote:
>> On Tue, 2019-02-05, Joe Perches wrote:
>>> On Tue, 2019-02-05 at 12:04 -0800, Eric Dumazet wrote:
>>> > On 02/05/2019 10:42 AM, Joe Perches wrote:
>>> > > It's declared after a pointer so it is already is 2 byte aligned.
>>> > > 
>>> > > A lot of drivers wouldn't work otherwise.
>>> > 
>>> > Maybe these drivers are only used on arches where this does not matter.
>>> 
>>> Possible.
>>> 
>>> I had only grepped through the sources looking for
>>> declarations using:
>>> 
>>> $ git grep -B1 '\[ETH_ALEN\];' -- '*.c' | grep -A1 '\*'
>>> 
>>> It's quite a few files in net/ too btw.
>>> 
>>> I still think adding __align(<even#>) is unnecessary here unless
>>> it follows something like a bool or a u8.
>> 
>> Um, guys, this is practically C-101.
>> 
>> From C99, 6.7.2.1:
>> 
>> > 13/ Within a structure object, the non-bit-field members and the units in
>> > which bit-fields reside have addresses that increase in the order in which
>> > they are declared. A pointer to a structure object, suitably converted,
>> > points to its initial member (or if that member is a bit-field, then to the
>> > unit in which it resides), and vice versa. There may be unnamed padding
>> > within a structure object, but not at its beginning.
>> 
>> AFAIK there is no such language in the spec regarding variable layout on
>> the stack. So Joe, you are totally off-base here.
> 
> We're not talking about the spec, see the void * arithmetic
> bit, we're talking about what gcc and clang actually do.

Sorry, I see I was a bit unclear. In an earlier message, which I neglected
to quote, you said:

> It's declared after a pointer so it is already is 2 byte aligned.
> A lot of drivers wouldn't work otherwise.

But it's declared after a pointer *on the stack* (local variable), not in
a structure. I was trying to say that there is nothing in the C spec that
says that local variables have any kind of ordering guarantee, unlike struct
members. And I have never seen any kernel code that relies on the ordering
of local variables to work correctly.

I used to work a lot with low-level C/assembly code, and I know for a fact
that GCC does not lay out stack variables in the same order that they are
declared.

-- Paul
