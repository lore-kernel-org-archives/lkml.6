Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeE3Oli (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:41:38 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:39552 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeE3Old (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:41:33 -0400
X-Google-Smtp-Source: ADUXVKKl2i8ujVtBYIDZBd6M2qMIuN/vdBR/vxQHzc/drfuig5hUyXdEWh29In+Jr9JllpqYQLIKOA==
Subject: Re: [PATCH] sh: pass machine size to sparse
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180528164018.16064-1-luc.vanoostenryck@gmail.com>
From: Rob Landley <rob@landley.net>
Message-ID: <d396b6b2-0fa7-aac1-c23b-a31b1c0d446a@landley.net>
Date: Wed, 30 May 2018 09:41:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180528164018.16064-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 11:40 AM, Luc Van Oostenryck wrote:
> By default, sparse assumes a 64bit machine when compiled on x86-64
> and 32bit when compiled on anything else.
> 
> This can of course create all sort of problems, like issuing false
> warnings like: 'shift too big (32) for type unsigned long', or
> worse, to not emit legitimate warnings.
> 
> Fix this by passing to sparse the appropriate -m32/-m64 flag

$ ${CROSS_COMPILE}gcc -E -dM - < /dev/null | grep __SIZEOF_LONG__
#define __SIZEOF_LONG__ 8

You can ask the compiler, you don't need to redundantly add this to every
architecture's Makefile.

Rob
