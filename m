Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B006C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3515821476
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXDq66+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3515821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeIVEED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:04:03 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:43421 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbeIVEED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:04:03 -0400
Received: by mail-ed1-f51.google.com with SMTP id u23so2742666edx.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3I0E3/hKuAvlufgkqJGNnRF0q8rJKnQPmuc42z3erSk=;
        b=bXDq66+G6tJBcqN6BZILsWYAkMJzhHhklwwCLzedKPQ8zM7MTXTrCOgjFLmShq4+Zp
         GJ3P4HE8aHsr1MT34lL0YwWPP2ES9wk9/QVOelcqTY3YbD3QJVlVKRZit0zwOFnvlqw0
         e8ex1PlrOo7HzWWxiCkABXTd5Ker2z4oXz101wAZ1/zXFE0dpSSpiKKkYe2d/+EOR0Rf
         P2neJ+P5XrAY6cDSyS1eGi44aVfVzlHYfCF4K3Y9QB7XWL+mKh1X2O1tVGqfMv4eHVOg
         pfE7XJiK/0IfRtGCJlT8Urbxk1Is/JEPyhBOo+2h7uRCrkpOsckLcV8Oor7PgaRRuODx
         IXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3I0E3/hKuAvlufgkqJGNnRF0q8rJKnQPmuc42z3erSk=;
        b=iDA+2Yl5LKZND7cnC0F9CZMrnOCtXrkev9HsxsUwNAqTTLxrmxl3OkJ7GRI0vrJ04J
         SsqCPF29c2SETZ+dlbPRPzP2OkjoGliDccrI9qbsQG5mARKPOuh19lWJDjGPx7lqS1ay
         bqnix8DdliOQT/2+s5H3q4oepOgab8Zoso4mr3iS5Yi1zyf4ieTlO3daQnMYK2da0PYp
         LsH3DRv6LFz2FcdJjMC6VcScuKIWC9Xu0Vn1ItGBGAPx2bvR3/ogOl05iyCMVKA3Q5yU
         B4FbupMZMI0OtJjS6p6wqVh7/eKdzrcrXYsyYaRxSznXBWUm6vcSP6k6G18HIIhfQdbL
         ko5Q==
X-Gm-Message-State: APzg51BBe4vgEhthakRRNxRrKHsm9WdSfme+YkEsfgSk1MFFTx6tQFeM
        ocKsqhcSomjZcwagq0/9gCXdugzH
X-Google-Smtp-Source: ANB0VdaTQi2cpNRvYJhit5InW3yHqtGgdieu8Te0jmgz7PXfLB3fGUlBa0AAzWFT9hCJVToiRKQ9wA==
X-Received: by 2002:a50:b5a5:: with SMTP id a34-v6mr11262192ede.88.1537567991028;
        Fri, 21 Sep 2018 15:13:11 -0700 (PDT)
Received: from a.local ([23.92.127.2])
        by smtp.gmail.com with ESMTPSA id d12-v6sm2909879ede.78.2018.09.21.15.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 15:13:10 -0700 (PDT)
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
To:     Pavel Snajdr <snajpa@snajpa.net>
Cc:     linux-kernel@vger.kernel.org
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
 <93424bb0-180e-71ff-f0d6-602caa2d5883@gmail.com>
 <260205ec45d097fb037f71ae42e7b69e@snajpa.net>
From:   Michael Woods <michaeljpwoods@gmail.com>
Message-ID: <1c2397bc-6f6d-ead5-9381-1d9729d73497@gmail.com>
Date:   Fri, 21 Sep 2018 23:13:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <260205ec45d097fb037f71ae42e7b69e@snajpa.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> and how about if we viewed the new Code of Conduct as about the same 
> thing as BitKeeper was for the development process?
You should view the Code of Conduct for what it is, as I referenced 
previously with real world examples, the evidence shows that it is just 
a ploy to take control away from the competent and give it to the 
incompetent.

An example of the hypocrisy Linus is in for:
a) From Coraline Ada Ehmke's Code of Conduct:
> Our Standards
>
> Examples of behavior that contributes to creating a positive environment
> include:
>
> * Using welcoming and inclusive language
and
> Examples of unacceptable behavior by participants include:
>
> * Trolling, insulting/derogatory comments, and personal or political 
> attacks
> * Public or private harassment
> * Other conduct which could reasonably be considered inappropriate in a
> professional setting
b)
> https://twitter.com/CoralineAda/status/1042249983590838272
> Coraline Ada Ehmke, @CoralineAda
> 40,000 open source projects, including Linux, Rails, Golang, and 
> everything OSS produced by Google, Microsoft, and Apple have adopted 
> my code of conduct.
>
> You can make me have a bad day, but it doesn’t change the fact that we 
> have won and you have lost.
In software projects, there will be no "calling out" of bad behaviour 
for the self identifed victims this was written for, whom are invariably 
the least useful contributors and most capable of inventing victim 
narratives. The CoC will be used by the mentally ill and incapable to 
create accusations for attacking competent individuals.

> It was not perfect, but wass *something* for a start.
A Code of Conduct is not required, to the contrary, all successful 
software projects, if they wish to remain so, should never adopt one. I 
previously referenced preferable alternatives.

> I've been always looking up to the guys leading major community 
> projects and how they go about things - and I think, that most of the 
> bad fall-out in them is caused by insanely high expectations - firstly 
> from the leader themselves, and secondly from others as well.
Linus has excelled up to this point, the Code of Conduct will stifle his 
ability to maintain the kernel.

> The new Code of Conduct is a guarantee for us, that we won't be 
> laughed out of the room  and that our members won't be demotivated to 
> contribute upstream - if we can all agree to be nice on each other; 
> yet we still need you guys to tell us, when we're trying stupid things 
> or going about things the wrong way, in some way that we will notice & 
> can learn from.
The one thing you do not understand, which is key to understanding why 
complex projects are successful, most people are not intelligent enough 
to contribute. Their contributions if accepted, would create chaos, and 
if not simply rejected, would create long backlogs due to the amount of 
effort required to explain why their code is not of the standard required.

> If I understand the context correctly, the previous "regime" could be 
> the culprit, at least to some extent, why still don't have the VM 
> look&feel-having containers with vanilla. So I'm just really trying to 
> say, that I'm really excited about the signal this change has sent.
This is not a believable position, that you were waiting for a Code of 
Conduct before contributing successfully to the Linux Kernel.

Regards,
Michael
