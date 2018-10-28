Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041BEECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 10:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE03120843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 10:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE03120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJ1T3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 15:29:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45460 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1T3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 15:29:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id t10-v6so4814507eds.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 03:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rFKFQFEVLb4vxL9PJRhux+aUcuP2vv9bAAOzOM1curo=;
        b=EOIj4toITmEHkIisuHU3tVKuz13p1mnDoQnqVADru8YnomO6uI4EYifaKH/1OAuns3
         IxvqPYvWJkyx1uwBASm7bBIK9kuH/298GJ2Y5FUlFUXk5gzgi2MBbWYhhSykrD5icJod
         F+wQqr0Ho5GUEzLy9iFGMNumRiVKjbkcUCSUGEpZNwpqsZfMMORoIMHHS909zK7o4BGu
         XAFC9p1MKrMhUqpBNMnwVG2V7JSc9yTAJemFedy6cMtD6eoTVTaHVhnkblnUpEVypSoT
         7epUTtny3EE+69c9+EWyT2ev9tAuTBNKWCWsBRjSCSpjkXNqlMLyBF8+vyvRg0M515WK
         3IaA==
X-Gm-Message-State: AGRZ1gLQZk5WwMFq2TkKGRQh3dysdASTxuFm6oVym7lDtFn9oRyOCWSt
        btWKVJJ2TCXSVMYQpUFDM5kzkbbDhZk=
X-Google-Smtp-Source: AJdET5clAWYbDXxLfrbWgZmLnaPys2ro2RN3Gy5C0hm3IqvhyYCROFuqMbcXJMGwjSzbl8T13Hp/iw==
X-Received: by 2002:a50:d710:: with SMTP id t16-v6mr9857897edi.75.1540723502074;
        Sun, 28 Oct 2018 03:45:02 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id l22-v6sm3122820ejd.53.2018.10.28.03.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 03:45:01 -0700 (PDT)
Subject: Re: Oops in current tree in i2c
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>, Julian Sax <jsbc@gmx.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8d8e3771-0b33-2489-4e27-d3d63162df11@redhat.com>
Date:   Sun, 28 Oct 2018 11:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 27-10-18 18:08, Linus Torvalds wrote:
> Julian, Jiri,
>   On my laptop I'm getting a kernel page fault with the current git
> tree, and I'm tentatively blaming commit
> 
>    9ee3e06610fd ("HID: i2c-hid: override HID descriptors for certain devices")
> 
> but that's simply because it's the only thing that seems to touch this
> particular area in this merge window.
> 
> The oops looks like this:
> 
>    BUG: unable to handle kernel paging request at 000000007a25d598
>    PGD 0 P4D 0
>    Oops: 0000 [#1] SMP PTI
>    CPU: 1 PID: 888 Comm: systemd-udevd Not tainted 4.19.0-07715-g345671ea0f92 #4
>    Hardware name: Dell Inc. XPS 13 9350/09JHRY, BIOS 1.7.0 01/16/2018
>    RIP: 0010:strstr+0x19/0x70
> 
> where the code disassembly (and the register contents) shows that the
> wild pointer is the first argument to "strstr()", which just has a
> bogus value that is not a valid kernel pointer (RDI: 000000007a25d598
> - which is obviously also the address of the page fault)
> 
> The call trace is:
> 
>     dmi_matches+0x55/0xc0
>     dmi_first_match+0x26/0x40
>     i2c_hid_get_dmi_i2c_hid_desc_override+0x16/0x40 [i2c_hid]
>     i2c_hid_probe+0x28c/0x760 [i2c_hid]
>     i2c_device_probe+0x1e7/0x260
>     really_probe+0xf8/0x3e0
>     driver_probe_device+0x10f/0x120
>     bus_for_each_drv+0x66/0xb0
>     __device_attach+0xd9/0x150
>     bus_probe_device+0x8a/0xa0
>     device_add+0x48e/0x660
>     i2c_new_device+0x162/0x350
> 
> which is why I suspect that new i2c_hid_get_dmi_hid_report_desc_override() code.
> 
> I *think* the problem is that the i2c_hid_dmi_desc_override_table[]
> isn't terminated by a NULL entry, and I will test that next.

Yes that likely is the problem. I already had a bug report from one of the
Manjaro maintainers who was cherry picking this into the Manjaro kernel.

So I ran some tests on a laptop of mine which does use i2c-hid but I
failed to reproduce the issue, so we both (me and the Manjaro maintainer)
both assumed something went wrong with the backport.

Both of us seem to have overlooked the missing terminating entry,
as well as other people involved in the patch.

> What makes me *very* unhappy about this is that if I'm right, I think
> it means that code was literally not tested at all by anybody who
> didn't have one of the entries in that list.

That is not true, I've hit one of these unterminated dmi lists
issues before and it depends on what get put in mem directly
after the list by the linker, bugs caused by this do not always
reproduce unfortunately.

And as mentioned I have tested the patch on a machine with an i2c-hid
touchpad, which is not on the list and I did not hit this problem.

Anyways this is fixed now, thank you for catching this.

Regards,

Hans
