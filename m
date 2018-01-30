Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbeA3J3R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:29:17 -0500
Received: from mail.netline.ch ([148.251.143.178]:41584 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeA3J3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:29:15 -0500
Subject: Re: [RFC] Per file OOM badness
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christian.Koenig@amd.com, linux-mm@kvack.org,
        amd-gfx@lists.freedesktop.org, Roman Gushchin <guro@fb.com>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <20180118170006.GG6584@dhcp22.suse.cz>
 <20180123152659.GA21817@castle.DHCP.thefacebook.com>
 <20180123153631.GR1526@dhcp22.suse.cz>
 <ccac4870-ced3-f169-17df-2ab5da468bf0@daenzer.net>
 <20180124092847.GI1526@dhcp22.suse.cz>
 <583f328e-ff46-c6a4-8548-064259995766@daenzer.net>
 <20180124110141.GA28465@dhcp22.suse.cz>
 <36b49523-792d-45f9-8617-32b6d9d77418@daenzer.net>
 <20180124115059.GC28465@dhcp22.suse.cz>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <60e18da8-4d6e-dec9-7aef-ff003605d513@daenzer.net>
Date: Tue, 30 Jan 2018 10:29:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180124115059.GC28465@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-01-24 12:50 PM, Michal Hocko wrote:
> On Wed 24-01-18 12:23:10, Michel Dänzer wrote:
>> On 2018-01-24 12:01 PM, Michal Hocko wrote:
>>> On Wed 24-01-18 11:27:15, Michel Dänzer wrote:
> [...]
>>>> 2. If the OOM killer kills a process which is sharing BOs with another
>>>> process, this should result in the other process dropping its references
>>>> to the BOs as well, at which point the memory is released.
>>>
>>> OK. How exactly are those BOs mapped to the userspace?
>>
>> I'm not sure what you're asking. Userspace mostly uses a GEM handle to
>> refer to a BO. There can also be userspace CPU mappings of the BO's
>> memory, but userspace doesn't need CPU mappings for all BOs and only
>> creates them as needed.
> 
> OK, I guess you have to bear with me some more. This whole stack is a
> complete uknonwn. I am mostly after finding a boundary where you can
> charge the allocated memory to the process so that the oom killer can
> consider it. Is there anything like that? Except for the proposed file
> handle hack?

How about the other way around: what APIs can we use to charge /
"uncharge" memory to a process? If we have those, we can experiment with
different places to call them.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
