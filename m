Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13767C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E93820843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E93820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeJ0OzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 10:55:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35068 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeJ0OzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 10:55:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id l17-v6so1561479pff.2;
        Fri, 26 Oct 2018 23:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5RUxgAeRllEqFsxcL9igamONp6WlcNYbhqm877iH0tY=;
        b=eVs7y/0ZqfjAeZ2Du9G6pq2WSRNBAkkwTdLGz97/PLae/8jU2nguHEwpYVHbIM70ea
         fCWtajAonq8IhznrEKFCmkEsOZJdI/ZIQlGW8Kl9niOqZJiUNIKkqKTIPCBwC4vQJRu8
         /fttnLVYpVOl3mhjuwOUteHXMhK5SKaCZBD9tPEU9qIKjuCAJeP5cSxDcMp16mUHpHBy
         ORiYn33QFXVbOOzg8R9W/GVCE+6x/TjhFsiMv3OPx9Y81aPRdZlNWoeibkE12Pa2bhBI
         hxi5h9oQ131FAarxPXkHxv0nXgMo+E8c4/nsI4bCSOkp3Bx1716KIMSpjvoyIfF9yrU4
         GU3Q==
X-Gm-Message-State: AGRZ1gJk9j+kEgd27a7NB4JWmv+DhNu2bCGnCQnZlc8xP7ODqo+/kteG
        qAn1mw3uJBqRS2dC+NxM/iY=
X-Google-Smtp-Source: AJdET5dA+qUa2OVj9AxDMh7P3vVK8xBGn7CO1GUhxJ5yJWQgOSASgmSZoTbXmGzqwwggqzpdMBey9g==
X-Received: by 2002:a62:30c7:: with SMTP id w190-v6mr6580362pfw.188.1540620914647;
        Fri, 26 Oct 2018 23:15:14 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id v8-v6sm5534833pgk.54.2018.10.26.23.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:15:13 -0700 (PDT)
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ooo@electrozaur.com, Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
References: <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox>
 <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org>
 <CAKwvOdnYx60JkJHJkD7CYA9yx5Oa7Tn9q4aZ3-tcZGx++yoduQ@mail.gmail.com>
 <1540589437.66186.124.camel@acm.org>
 <CAKwvOdm-xYRqCBXhLC1ceC44_rEmggW4qiSgGpRkpL+p-NadVg@mail.gmail.com>
 <1540591147.66186.127.camel@acm.org>
 <CAKwvOdmUhtK10cbYFoEJJp4O8LA_F-+f68A_NcL_fm_FH6QodA@mail.gmail.com>
 <20181027033552.GA29237@thunk.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ac63f6d2-d9f3-c512-892d-2e4450fd4c1e@acm.org>
Date:   Fri, 26 Oct 2018 23:15:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181027033552.GA29237@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 8:35 PM, Theodore Y. Ts'o wrote:
> The second observation I'll make is that if someone is proposing a
> cleanup patch, it's unfair to dump on the person proposing the cleanup
> patch the (non-trivial) effort to drop a driver/file system/subsystem.

Hi Ted,

Maybe I was not clear enough. It never was my intention to suggest that 
Nick or Nathan should remove the OSD code. This is something I'm willing 
to do myself. BTW, I'm still waiting for someone to explain me why the 
patch at the start of this thread was submitted by people who never have 
used the libosd driver and who do not have any plans to use it ever.

> If the maintainer wants to drop a driver/file system, that should be
> the maintainer's responsibiltiy; not someone proposing a
> cleanup/maintenance patch.

I think anyone who makes tree-wide changes has the freedom to suggest to 
remove a driver. Having to modify drivers that are no longer maintained 
when doing tree-wide changes can be a real pain.

Additionally, you may have missed earlier discussions on the linux-scsi 
mailing list about this driver. The first time it was suggested to 
remove this driver was several years ago. The outcome of a discussion of 
a few weeks ago is that there is agreement about the removal of this 
driver. See also the following messages:
* https://www.spinics.net/lists/linux-scsi/msg123738.html
* https://www.spinics.net/lists/linux-scsi/msg123742.html

Bart.
