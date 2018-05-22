Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2845700-1527010646-2-4658644752324478018
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527010646; b=UGkP0v0MVm0sQtoAT/0PzZjiaFhUGpYxwqA9xXqsLKJTWQ3KbG
    XCKEuKptP3+8Nauxk69A6D3koVA7wBS6nKGVW1XIoE85Hp6BEp/N+SxK91bvKIrt
    BFyBE/dEtwou/tlAEYQz5/q1o2EBoT4KSEH28ZVIyR4sxZCK5AehpT66yzTmffKK
    Vm3zc1SCmZLAQfVfYzNNY0oF66BZH4gI/iZuKQSxfkHEvy7Lk/YYVnQAtamvFv2m
    nnbIDTGiNeTT3oIyBVG9ekU8JVH+bsjjTLs3xPpt1Jwz2x/qi2m1HXiT6SxeejKE
    gZmTa6DSWjP+ne+nc5gZR7JjSATAobxJotgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:references:from:message-id:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :subject:sender:list-id; s=fm2; t=1527010646; bh=v33VM48NA18nOdy
    aEW62RnPsRoItIqt3sOWQ5FZ5D58=; b=GN13cvyL7Pi7QN7MZVcfjolqij/KjoZ
    z33u0VbC7YUQv+4KwuMLxhAEkTxr2ZEgh3eHlUgAkL9lbti9KXdKERO2alpsDw4p
    oxIC5dCYtQo/hdp7HRH59FA7hV3/LalJ6caFfCIlik0QTjH5yfy12VS+82jziCC/
    L+M8su53DgxW5/OdPSfAulW0Vp+cSIX/oM+baMS9A3tlJpCqvvs2P+SyXDG56nYu
    wrb0Kup0rdhqBWTeCHQQHoCq20XACNUx2jhid8ZVw9a/wqVjoOfIq6IsMoBA9UpO
    /rLP35BvwkXZx/+MbTfUCejxgbSUgZaKEfF+Tc8VWowoYUFVfU4ocAQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=deltatee.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=deltatee.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=deltatee.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=deltatee.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDbF4WY3wMRWcgQ+ioCDSYWdvPAOeyF7F+UP+e4CQ3H+8LJUol/yue15bk9P4SdFlbG8W0GGqW/Sxs86B+YXh/Jn989a5BStrqJPvMmHI0KZnR0c+mnf
    GmEikiF8YvI1R1N3RZ4EFx1q/eRsP0knuC6KBqQNcbImQXc3sHlVP3nBCaeaeJsnwYOPYxkKt0iehvQUYWJSLyREZbNMHIL/mu2PPY7IO7MHaQNPrpdSPu6v
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=zIk4BBHEXdlaJITVt0kA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeEVRhH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 13:37:07 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48850 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbeEVRhF (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 13:37:05 -0400
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152694212460.5484.13180030631810166467.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180521161026.709d5f2876e44f151da3d179@linux-foundation.org>
 <CAPcyv4hMwMefMu3La+hZvN6r+Q6_N5t+eOgGE0bqVou=Cjpfwg@mail.gmail.com>
 <860a8c46-5171-78ac-0255-ee1d21b16ce8@deltatee.com>
 <CAPcyv4i-MAYLsmT1M4=D_fwMNF98MupDyNBjWNmOzwY5Lzz0Lw@mail.gmail.com>
 <b636aa5e-205b-4d67-09f8-230755de31b6@deltatee.com>
 <CAPcyv4ga3e0WSe4LeGbzpwj2QNU-XMezYDh54TPon6UKbhpP0Q@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8fa535d5-7f8d-8036-0e02-1aee7768bdef@deltatee.com>
Date: Tue, 22 May 2018 11:36:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ga3e0WSe4LeGbzpwj2QNU-XMezYDh54TPon6UKbhpP0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com, hch@lst.de, stable@vger.kernel.org, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on ale.deltatee.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.1
Subject: Re: [PATCH 2/5] mm, devm_memremap_pages: handle errors allocating
 final devres action
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 22/05/18 11:25 AM, Dan Williams wrote:
> As far as I can see by then it's too late, or we need to expose
> release details to the caller which defeats the purpose of devm
> semantics.

In the dax/pmem case, I *think* it should be fine...

devm_add_action_or_reset() only calls the action it is passed on failure
not the entire devm chain. In which case, it should drop all the
references to the percpu counter. Then, if on an error return from
devm_memremap_pages() we call dax_pmem_percpu_kill(), the rest of the
devm chain should be called when we return from a failed probe and it
should proceed as usual.

I think dax_pmem_percpu_kill() also must be called on any error return
from devm_memremap_pages and it is currently not...

Logan
