Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754620AbeD3AcU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 20:32:20 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33341 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754409AbeD3AcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 20:32:18 -0400
X-Google-Smtp-Source: AB8JxZohpC+g5Cyqf8304tmRf0I4FmQg76Fv7FLLFNombRIZUi7DFbgogGlGpgzuTQ0eoum444bB0g==
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
References: <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org> <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box> <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <b2c478b3-91bf-3ffa-b283-2b80e46a1165@redhat.com>
Date: Sun, 29 Apr 2018 17:32:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180429220519.GQ5965@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/2018 03:05 PM, Theodore Y. Ts'o wrote:
> What would be useful is if people gave reports that listed exactly
> what laptop and distributions they are using.  Just "a high spec x86
> laptop" isn't terribly useful, because*my*  brand-new Dell XPS 13
> running Debian testing is working just fine.  The year, model, make,
> and CPU type plus what distribution (and distro version number) you
> are running is useful, so I can assess how wide spread the unhappiness
> is going to be, and what mitigation steps make sense.

I'm pretty sure Fedora is hitting this in our VMs. I just spent some
time debugging an issue of a boot delay with someone from the
infrastructure team where it would take upwards of 2 minutes to boot.
If someone holds down a key, it boots in 4 seconds. There's a qemu
reproducer at https://bugzilla.redhat.com/show_bug.cgi?id=1572916#c3
I suggested a cat on the keyboard as a workaround.

Independently, we also got a report of a boot hang in GCE with 4.16.4
where as 4.16.3 works which corresponds to the previous report of a
stable regression. This was just via IRC so I didn't have time to
dig into this.

Thanks,
Laura
