Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0E9C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D65E205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qnmetnd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D65E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeKBBCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:02:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40581 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBBCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:02:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so18499247lji.7;
        Thu, 01 Nov 2018 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VblXFF5BYqyBPIfRjNtcaglg3kxUmrfgtO12sNoK3KI=;
        b=Qnmetnd6fkgk9PiavbPuxrjFpQ7cDwnlKVgV5I2fbioaKl7HK42mgQyuOXIx38qHz5
         EdTpChdg5aBW3ruw/34Z/lA4VzTKSk1DnDq8m8oVRMlDiXjn6PS4XNZWx6tpsfWQHC2B
         BvdMPj9Bhy78Gmr0FOOxO8UfunXEWIkGN7s97tX7CXxTm3qHLW1Vcz5tnaQrJKHO0Afv
         M5/8aOadXN69Zbl8/HOvTROnsHiDTpoHmd21Fy94ySdQJcInD6MwFLMf7h7kw7+OZenS
         q+KGDTebxyB/5b2u14f8my4Cny52RyOQylDo5odBvbnz2DCPNjAIqGR+L7ktaOPeNyRO
         L19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VblXFF5BYqyBPIfRjNtcaglg3kxUmrfgtO12sNoK3KI=;
        b=rdqmW813PoXuJldoUpKYgW8fKLDq9uGMz/93UVnr5uIjfL5S/ShS2lZAKOlGLpgtJG
         189WXH4EvwovmsUBcBh0hfqsxG3FJ0OxC+836umx4F5vloxgVmbksj+MzgoRE+TZ8ZmV
         ssb01YY0mtcNjnM6y01bbiIDDdnRMIqcWbtVDgBVhMCiCvda7A4RKKBuaPqlcaMfXVaB
         GqEa9aFQq1L2IwormI3raYuE5yILaC29+9Ye0vybttHcxMhGnWMmv1hd5VS0YDRe0Pba
         81YYfnlh064WAd633+OrzWlExB2uicobG5Kel5REyd91kv/9y6Ol84oDvzanpHaBfuQi
         VcLw==
X-Gm-Message-State: AGRZ1gLaDx49BbAkAM7fEhaCT4cfLpYDK/hK1QGTnkHrb1odExLLNRPG
        M2pFu4fGQrRsnHkhq8h4ul68l3PW+qw=
X-Google-Smtp-Source: AJdET5fAKGsvRTBWbsD5cdHcp7QTOs2QTjGIyRTHm5nUCN1NecTipgNYaFlnzHmXRqsGbZW6URqa6g==
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr5716163lji.60.1541087926864;
        Thu, 01 Nov 2018 08:58:46 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id b22sm3680233lfg.32.2018.11.01.08.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:58:46 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org> <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
 <20181030213557.GE10491@bombadil.infradead.org>
 <CALCETrW1FcT88u0QY9k_PMOeZj0G8H6KNb5Bnreo-12NvmmCEQ@mail.gmail.com>
 <20181031100237.GN744@hirez.programming.kicks-ass.net>
 <659CFC78-22BF-492B-B2E4-B8E89AA08446@amacapital.net>
 <20181031210032.GA3159@hirez.programming.kicks-ass.net>
 <2E29C35B-3F98-473D-A874-0D9B9B15B399@amacapital.net>
 <4124995b-4363-9b37-19b1-1879bf04978b@gmail.com>
 <CALCETrWCvAfyfBWgcmhy8TGByiX3ZXXSOkLtZFdM385fDqYJVw@mail.gmail.com>
 <8675e9d8-0ef0-7515-a894-097d4be25b73@gmail.com>
 <alpine.DEB.2.21.1811010909480.1642@nanos.tec.linutronix.de>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <f344a62a-07be-8424-d4cd-73afacc4da76@gmail.com>
Date:   Thu, 1 Nov 2018 17:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811010909480.1642@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2018 10:21, Thomas Gleixner wrote:
> On Thu, 1 Nov 2018, Igor Stoppa wrote:

>> The rework could be done afterward.
> 
> Please don't go there. The usual approach is to
> 
>    1) Rework existing code in a way that the new functionality can be added
>       with minimal effort afterwards and without creating API horrors.


Thanks a lot for the advice.
It makes things even easier for me, as I can start the rework, while the 
discussion on the actual write-rare mechanism continues.

--
igor
