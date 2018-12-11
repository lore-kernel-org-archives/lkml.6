Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE2FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A968520851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A968520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeLKRCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:02:48 -0500
Received: from ivanoab6.miniserver.com ([5.153.251.140]:34110 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbeLKRCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:02:47 -0500
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gWlPt-0006lP-RZ; Tue, 11 Dec 2018 17:01:54 +0000
Received: from amistad.kot-begemot.co.uk ([192.168.3.89])
        by smaug.kot-begemot.co.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gWlPp-0002WK-Av; Tue, 11 Dec 2018 17:01:53 +0000
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     brakmo@fb.com, Knut Omang <knut.omang@oracle.com>, jeffm@suse.com,
        Brendan Higgins <brendanhiggins@google.com>,
        dri-devel@lists.freedesktop.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-nvdimm@lists.01.org, mpe@ellerman.id.au,
        Eric Sandeen <sandeen@sandeen.net>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Matthew Wilcox <willy@infradead.org>,
        Felix Guo <felixguoxiuping@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Kent Overstreet <kent.overstreet@gmail.com>, jdike@addtoit.com,
        Tim.Bird@sony.com, linux-um@lists.infradead.org,
        Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com,
        kunit-dev@googlegroups.com, richard@nod.at,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@google.com>, joe@perches.com,
        linux-fsdevel@vger.kernel.org, khilman@baylibre.com
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
 <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
 <20181204204701.GT28501@garbanzo.do-not-panic.com>
 <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
 <20181206153718.GD24603@bombadil.infradead.org>
 <20181211140926.7wzd5jh6klcfsfgz@pathway.suse.cz>
 <20181211094140.2a928fe7@gandalf.local.home>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys Limited
Message-ID: <34f9e9f3-6bca-f11f-097c-c6e0cb779b61@cambridgegreys.com>
Date:   Tue, 11 Dec 2018 17:01:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181211094140.2a928fe7@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/11/18 2:41 PM, Steven Rostedt wrote:
> On Tue, 11 Dec 2018 15:09:26 +0100
> Petr Mladek <pmladek@suse.com> wrote:
>
>>> We have liburcu already, which is good.  The main sticking points are:
>>>
>>>   - printk has started adding a lot of %pX enhancements which printf
>>>     obviously doesn't know about.
>> I wonder how big problem it is and if it is worth using another
>> approach.
> No, please do not change the %pX approach.
>
>> An alternative would be to replace them with helper functions
>> the would produce the same string. The meaning would be easier
>> to understand. But concatenating with the surrounding text
>> would be less elegant. People might start using pr_cont()
>> that is problematic (mixed lines).
>>
>> Also the %pX formats are mostly used to print context of some
>> structures. Even the helper functions would need some maintenance
>> to keep them compatible.
>>
>> BTW: The printk() feature has been introduced 10 years ago by
>> the commit 4d8a743cdd2690c0bc8 ("vsprintf: add infrastructure
>> support for extended '%p' specifiers").
> trace-cmd and perf know about most of the %pX data and how to read it.
> Perhaps we can extend the libtraceevent library to export a generic way
> to read data from printk() output for other tools to use.

Going back for a second to using UML for this. UML console at present is 
interrupt driven - it emulates serial IO using several different 
back-ends (file descriptors, xterm or actual tty/ptys). Epoll events on 
the host side are used to trigger the UML interrupts - both read and write.

This works OK for normal use, but may result in all kinds of interesting 
false positives/false negatives when UML is used to run unit tests 
against a change which changes interrupt behavior.

IMO it may be useful to consider some alternatives specifically for unit 
test coverage purposes where printk and/or the whole console output 
altogether bypass some of the IRQ driven semantics.

-- 

Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

