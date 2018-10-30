Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F47C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AF92081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcTJS7QC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AF92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJaGVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:21:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40898 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaGVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:21:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so12833482lji.7;
        Tue, 30 Oct 2018 14:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NLKPI1BnDwFDEKm4noZtQgcSTQdYxB7TqGJK27cJVDw=;
        b=PcTJS7QC7g4+ogRwPx5/Fnl7G43wSZLHdjCs3XunEkhgXdWjquCpLAewwAuYKyacOO
         k5Hg0qrRNan2stGoZ+spArfdAyn9LvQkZElrHDwmddLGu3IXk0pKbQIXKRDjc6RHbY3/
         t1hTTTQUmaU53wtZT0POm3DGJq6ybPurDYN1jdLee5G+jUZ7O54blcnHZhVX+y5zyncc
         zIDwPDS1phJJPzTvIS9gi0wMYBs6kWDMseBt7wPDOK/hmnbzyVlAjs1dzxlxeyM/ppZ2
         IG7s8Blvmas1HcODUvj/fmZ/WTunww6bWLdR/3n+CWi1+xrI4jYjXoHsbPUzFUrteKe6
         2mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NLKPI1BnDwFDEKm4noZtQgcSTQdYxB7TqGJK27cJVDw=;
        b=qRL7Mp7LEruUDp8bCAYRUmlTpE8F1b0l0/BwHrrjiu/r5G4vQE/Qwcf8csvxflYwgf
         5mxC8F/I/zP6Y2pnOAhcMmyD94YPsluQ3Tuv/ZWxoqoSJ+vTQraVRlM+b9SIgHrUbcfP
         TEdflPq5vKsd4/t0R/bC1k4BsR0WBC3fqHyCE/41zn4bCfhXLwftLdMcWdMjN74bq33D
         pTJ2G42aupvZCPi9MQfMrdN6q8HVm9/+7VMVTZg4CKJqoFs0zq4h8y7AM0MkNnOz1id1
         EkFdx96M2SbAL0gpRZqP38h9KErJYa7ajjm1x+9zyr1+OFd+4z/igY+2dXrfE6kWcVhl
         ArJw==
X-Gm-Message-State: AGRZ1gIghizGR4OkUqI9j0Jj/fTbqj4UtEVGWxHvbyiFMJd+qxfgV8Vl
        GU4S6bg7So/wtrhgw0e/1sH3NP/VyhA=
X-Google-Smtp-Source: AJdET5cdEqbWu55wVNHYS/caoPxX6Sqiug2YawmH6LWkvn/AiOYVIfCKAudT2Ain4WmiUlweRmrlSA==
X-Received: by 2002:a2e:7011:: with SMTP id l17-v6mr232859ljc.147.1540934753386;
        Tue, 30 Oct 2018 14:25:53 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id g3-v6sm3506480lfj.3.2018.10.30.14.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 14:25:52 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org> <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
 <BAA65A07-F3AF-4209-9D18-7075CEF11EE8@amacapital.net>
 <CAGXu5j+58PcvXmt6qp4aZdDz_pBFV-P_rmp3zg6vQnpMvoMdXA@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <66a34590-a6d0-ff19-b765-cef8f76f7755@gmail.com>
Date:   Tue, 30 Oct 2018 23:25:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+58PcvXmt6qp4aZdDz_pBFV-P_rmp3zg6vQnpMvoMdXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2018 23:07, Kees Cook wrote:

> We still have to deal with certain structures under the write-rare
> window. For example, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/write-rarely&id=60430b4d3b113aae4adab66f8339074986276474
> They are wrappers to non-inline functions that have the same sanity-checking.

Even if I also did something similar, it was not intended to be final.
Just a stop-gap solution till the write-rare mechanism is identified.

If the size of the whole list_head is used as alignment, then the whole 
list_head structure can be given an alternate mapping and the plain list 
function can be used on this alternate mapping.

It can halve the overhead or more.
The typical case is when not only one list_head is contained in one 
page, but also the other, like when allocating and queuing multiple 
items from the same pool.
One single temporary mapping would be enough.

But it becomes tricky to do it, without generating code that is
almost-but-not-quite-identical.

--
igor
