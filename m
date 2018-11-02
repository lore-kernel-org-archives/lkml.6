Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D70FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED892081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED892081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeKBTA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:00:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:48678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725986AbeKBTA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:00:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07A41ABDC;
        Fri,  2 Nov 2018 09:53:51 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen: remove size limit of privcmd-buf mapping
 interface
To:     Jan Beulich <JBeulich@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: =?UTF-8?B?PDIwMTgxMTAxMTIzMzA3Ljg0MjTvv70x77+9amdyb3NzQHN1c2Uu?=
 =?UTF-8?Q?com=3e_=3c5BDB0B240200007800142507=40prv1=ef=bf=bdmh=2eprovo=2eno?=
 =?UTF-8?B?dmVsbC5jb20+IDxiNjRmN2ZhNO+/vWE1NTPvv71iY2I077+9NjA1Me+/vWM5MTA4?=
 =?UTF-8?Q?0642b8e=40suse=2ecom=3e_=3c5BDB20AB020000780014251B=40suse=2ecom?=
 =?UTF-8?Q?=3e_=3c12dd8625-2cad-f156-8bae-487e909af412=40suse=2ecom=3e_=3c5B?=
 =?UTF-8?Q?DBFC1402000078001F7101=40suse=2ecom=3e?=
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f1c413ba-f867-1521-86a3-35f00bffe9d3@suse.com>
Date:   Fri, 2 Nov 2018 10:53:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2018 08:26, Jan Beulich wrote:
>>>> On 01.11.18 at 17:27, <jgross@suse.com> wrote:
>> On 01/11/2018 16:50, Jan Beulich wrote:
>>>>>> Juergen Gross <jgross@suse.com> 11/01/18 3:23 PM >>>
>>>> On 01/11/2018 15:18, Jan Beulich wrote:
>>>>>>>> Juergen Gross <jgross@suse.com> 11/01/18 1:34 PM >>>
>>>>>> Currently the size of hypercall buffers allocated via
>>>>>> /dev/xen/hypercall is limited to a default of 64 memory pages. For live
>>>>>> migration of guests this might be too small as the page dirty bitmask
>>>>>> needs to be sized according to the size of the guest. This means
>>>>>> migrating a 8GB sized guest is already exhausting the default buffer
>>>>>> size for the dirty bitmap.
>>>>>>
>>>>>> There is no sensible way to set a sane limit, so just remove it
>>>>>> completely. The device node's usage is limited to root anyway, so there
>>>>>> is no additional DOS scenario added by allowing unlimited buffers.
>>>>>
>>>>> But is this setting of permissions what we want long term? What about a
>>>>> de-privileged qemu, which still needs to be able to issue at least dm-op
>>>>> hypercalls?
>>>>
>>>> Wouldn't that qemu have opened the node while still being privileged?
>>>
>>> Possibly, but how does this help? As soon as it's unprivileged it must not
>>> be able to hog resources anymore.
>>>
>>> Anyway, with Andrew's reply my point may be irrelevant, but I have to
>>> admit I'm not entirely sure.
>>
>> I guess we want Xen tools to close /dev/xen/hypercall (or more precise:
>> don't dup2() it) when qemu is de-privileging itself. This will make it
>> very clear that it can't hog memory via mmap().
>>
>> When you are fine with that I'll send a Xen patch for this.
> 
> If that doesn't prevent the process from making the hypercalls it
> is permitted to do (I have to admit I don't recall if there are any
> still needed besides the dmop ones), sure.

Turns out that is already done: the restrict_all callback of libxencall
will associate /dev/null with the file descriptor of /dev/xen/hypercall.


Juergen

