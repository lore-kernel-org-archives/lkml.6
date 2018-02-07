Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3793448-1518000399-2-17874142798294425586
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518000398; b=bvaVr/4SVXfHRq90R4weZrzgqyn4fj2RvcGhQv7T1zRSVja
    vVx5/93SkYim2X8vjG3GJ23MR5ASd05LJDiPmP2ZgbcXRaCOvEOKa3OwO6M92LrB
    Gwbj2uf/bbq/+vFfr1oQ6nt+9xLOkPHd5FPsDIugPaSNFS4lnCnT8+kvHkL4Tjo2
    OCgUYqKzWD13oGUONlE1NBO3W3YkHfe0osEdSxh7S7NN5Z8CdipLOLxCc4+4qTrU
    EeOLFzLP8IbtMTS/ORo8AOn/+YYHiXNhuDhYoRNA7XHLKKD/sf9WTLyNZwcp77V1
    NjnkWidRnMpYCgxBATxPj/QwK3iKnVUEohCWY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518000398; bh=EVGo61MoeA8q+48pnHP20Oo7rD1PSeEylmAe6POvXVA=; b=g
    jVIbA+dgJ7xfUHfDPvONpNs292NT3wdLm0jIH4kfF/afCvf/tjKNh/Fa+6v69hhA
    Mq8c+uISa4Ac57Bp0PqLudyeBSxDpPeH5XGsgCvc9lGd6+bU8ipkcTU2C5dqhrDU
    f1TolcY2MqBX29sgQEeBneM02rnUqsYqsI2sMJoBSHAv8XOb9kjy/BeBG5uZwp3j
    VDe2RlZc5MIdL+HbnwPeow0bsC64rBdkEG91tzMkHnF7mIvEiVpMAW6lgMDeg5K7
    ASmEUjITqwccKmkNSuWjMzMcnT6EaAkVQBpu5slj7nEr+PHU/8qVIOg7ibBda49r
    kTcSQZ+xQnKoaze1t4SXA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmx.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmx.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeBGKqh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 05:46:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:62243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753424AbeBGKqg (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Feb 2018 05:46:36 -0500
Message-ID: <1518000336.29698.1.camel@gmx.de>
Subject: Re: [PATCH 4.14 023/159] mm/sparsemem: Allocate mem_section at
 runtime for CONFIG_SPARSEMEM_EXTREME=y
From: Mike Galbraith <efault@gmx.de>
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org,
        Vivek Goyal <vgoyal@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 07 Feb 2018 11:45:36 +0100
In-Reply-To: <20180207104111.sljc62bgkggmtio4@node.shutemov.name>
References: <20171222084623.668990192@linuxfoundation.org>
         <20171222084625.007160464@linuxfoundation.org>
         <1515302062.6507.18.camel@gmx.de>
         <20180108160444.2ol4fvgqbxnjmlpg@gmail.com>
         <20180108174653.7muglyihpngxp5tl@black.fi.intel.com>
         <20180109001303.dy73bpixsaegn4ol@node.shutemov.name>
         <1515469448.6766.12.camel@gmx.de>
         <d71ba136-71ba-333a-f99b-b8283e2dc545@cn.fujitsu.com>
         <20180207104111.sljc62bgkggmtio4@node.shutemov.name>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:N1GxF9QZ7r4gH5ljkDt9xSbAl6fWfvDq3jwMGxThA3poEIPDBj6
 +O0ZgvyAvWySQJBeWL1VpF0S5Cssv7Ni5fsdPCrO8o6lgrByov/07IeABOeBUJOr4SdMw1W
 CY+RwMGCzDU7vHsm9IX5GMeSNEX2xq7/QK2SwYl71EogNd3T/6Er0sbtE+1ZO1cf5/HnWyY
 x6ch6hcxBjE0JGqatfawQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E0am1paqjTg=:OQlZ8XVr9q5vyzr9nt2tTX
 xHdXW0xBxZpr8aT9oLYfFgB9G5qIegT6+18/LyYqR3B22ytG/8bz7tvp8ZodPkfwsPYnMMx4m
 yq0/gwuk5NGHQmNBnkobWqv+mN6J/uhJiY4Z9xmpWg7ZEN15BPKQcpjH4IZgG3lIIXjkMqU5U
 lRYC00Z6cRygk4VSkK1tp5TeudnAidWQAgo1JzC1fdyPTG/uJ9ESJSx843YYEx9Ca+uNYR3Pj
 HHqNXvv7Ehw9VhWmolrfq3OyQL/lRiERoe3AbQfZtZwnAFT2W7PVikURXMOZNXwBvgvZm/DzJ
 WqOzEMnaH6sY5tO8CW9b3Y6VvjjFxUO7rSPJ1YpYBRA6sPU/+m6CpE/3VSczJL3fc8LSI6gt6
 ScYhVhsqgA4gGLQyPxsuhd7Nm2QWUDgSIO9VQbrUVQzbkuKg1FvRARP7Wcr3sXqhbp3IfvEGE
 g88CijNO+K+W7IM9QoaP82pJt4FTjCqxJTXe49qDxL4+lPxWL1zXzLUz0V/BRenwA/9RKAdKf
 t/NT6aggZ09Vhho4JaZQSh4043/9D1naOZVPzXj2uz7z8kLACz6f5b8dVESeLPB4Go9kmTwb1
 Hkh1m7E0qIImQRxolay7yAO9VSPGAIROOwotdzl1Nkgdsiwn0vk4qvcBT7Z2Zkcv2gb41LYx/
 q17e0990962UE8a0CnlXSWnht7pGiuCAGfazLrKsC5M5ptp9X6BlQPxgZh0pwtVSnprAcDUQQ
 oBNBjo1DU8zyNghsUZhvOhnIojfyGsrfmYHZA2qPIDQqAS0iL9kkbK9vPiS46ZV877eh31kxt
 wDSIfbfVm3DYgAItdkbZY8K55Ff9SWo56tkA62mg4vvJDiW5ho=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-07 at 13:41 +0300, Kirill A. Shutemov wrote:
> On Wed, Feb 07, 2018 at 05:25:05PM +0800, Dou Liyang wrote:
> > Hi All,
> > 
> > I met the makedumpfile failed in the upstream kernel which contained
> > this patch. Did I missed something else?
> 
> None I'm aware of.
> 
> Is there a reason to suspect that the issue is related to the bug this patch
> fixed?

Still works fine for me with .today.  Box is only 16GB desktop box though.

	-Mike
