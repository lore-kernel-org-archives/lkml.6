Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C829BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9778721780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9778721780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbeKOBB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:01:59 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35797 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeKOBB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:01:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so26208011qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 06:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z028cgqsCmXv3GFWGbN0+xGMfiiBM28+GJrxgaxUttM=;
        b=cRScOOzMKLDqJRZ7c6HWkV+Jwba1ts0mIPCEl5r0AobIgi0JsjDfgTcGBXFtayGB+T
         4H+wpXmgxEd68n7sp04jZT5W6GFJVGrr8WcKqOpmYGCX7yR8z15L49RU+u3/pdK5lQkJ
         JqrfItNzmdr1iDJkHuCHE7Th4t9osu+oXMuyWCinWj9J3cLLaeAKtBcfGLw3l2F2xtqM
         KvO2NkLcdRQZJqzHktDPMk2acdxRet7Ga0cELXDuzuu17WcvGdjsCZNhIkkmkI16nXPy
         CDPzFk0e7PqXU4hxTQoW/wJMA34iS4hhD9FWEHEyLPmbV87+rKZknVds+1i1Vz1RuaLP
         4mOw==
X-Gm-Message-State: AGRZ1gL7v8Z4ZkgyAvi+OWMFJkLcamPtHAAOS898/u90WwgC556kBO6b
        GPbyUXdJVhlgTOPETUJoeqthDw==
X-Google-Smtp-Source: AJdET5e1eE5PkjNirfItTcv1hbUJquU9SBbwkTGqxS0K7MaISB3UJ1+4YAXThDdGv3wL/x0SED52Sg==
X-Received: by 2002:a37:9604:: with SMTP id y4mr2043155qkd.279.1542207504761;
        Wed, 14 Nov 2018 06:58:24 -0800 (PST)
Received: from [10.150.73.190] (161.sub-174-227-144.myvzw.com. [174.227.144.161])
        by smtp.gmail.com with ESMTPSA id r16sm15632601qkh.71.2018.11.14.06.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 06:58:23 -0800 (PST)
Subject: Re: Official Linux system wrapper library?
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Daniel Colascione <dancol@google.com>
Cc:     nd <nd@arm.com>, Florian Weimer <fweimer@redhat.com>,
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
From:   Carlos O'Donell <carlos@redhat.com>
Openpgp: preference=signencrypt
Organization: Red Hat
Message-ID: <fb340c72-c484-7f55-a2bd-71e072d7f1f5@redhat.com>
Date:   Wed, 14 Nov 2018 09:58:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/18 6:58 AM, Szabolcs Nagy wrote:
> an actual proposal in the thread that i think is
> worth considering is to make the linux syscall
> design process involve libc devs so the c api is
> designed together with the syscall abi.

Right, I see at least 2 actionable items:

* "The Checklist" which everyone making a syscall should
  follow and we create the checklist with input from both
  sides and it becomes the thing you reference e.g.
  "Did you follow the checklist? Where is X?"

* Programmatic / Machine readable description of syscalls.
  This way the kernel gives users the ability to autogenerate
  all the wrappers *if they want to* in a consistent way that
  matches this syscall description format.

-- 
Cheers,
Carlos.
