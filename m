Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CBD31C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D54208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D54208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934511AbeFMGkd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:40:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:59253 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933657AbeFMGkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:40:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BCF22AC64;
        Wed, 13 Jun 2018 06:40:15 +0000 (UTC)
Subject: Re: [PATCH v5 1/3] xen: Sync up with the canonical protocol
 definitions in Xen
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, lyan@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-2-andr2000@gmail.com>
 <9c579567-ebe2-f465-5443-b3a3e71d34a5@suse.com>
 <20180612234020.GI38773@dtor-ws>
 <3605901d-4a72-3f5a-6d74-cb13d2414a0b@gmail.com>
 <D53587A2-5B1B-4D8F-8772-04D453B93D38@gmail.com>
 <e1d62036-708d-5087-83f2-0ea32f3a6e74@gmail.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e038df38-95be-b985-a2f8-2532f51736bd@suse.com>
Date:   Wed, 13 Jun 2018 08:40:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e1d62036-708d-5087-83f2-0ea32f3a6e74@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/18 08:13, Oleksandr Andrushchenko wrote:
> On 06/13/2018 09:11 AM, Dmitry Torokhov wrote:
>> On June 12, 2018 10:49:31 PM PDT, Oleksandr Andrushchenko
>> <andr2000@gmail.com> wrote:
>>> On 06/13/2018 02:40 AM, Dmitry Torokhov wrote:
>>>> On Tue, Jun 12, 2018 at 03:46:10PM +0200, Juergen Gross wrote:
>>>>> On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>>
>>>>>> This is the sync up with the canonical definitions of the input,
>>>>>> sound and display protocols in Xen.
>>>>>>
>>>>>> Changes to kbdif:
>>>>>> 1. Add missing string constants for {feature|request}-raw-pointer
>>>>>>      to align with the rest of the interface file.
>>>>>>
>>>>>> 2. Add new XenStore feature fields, so it is possible to
>>> individually
>>>>>>      control set of exposed virtual devices for each guest OS:
>>>>>>        - set feature-disable-keyboard to 1 if no keyboard device
>>> needs
>>>>>>          to be created
>>>>>>        - set feature-disable-pointer to 1 if no pointer device needs
>>>>>>          to be created
>>>>>>
>>>>>> 3. Move multi-touch device parameters to backend nodes: these are
>>>>>>       described as a part of frontend's XenBus configuration nodes
>>>>>>       while they belong to backend's configuration. Fix this by
>>> moving
>>>>>>       the parameters to the proper section.
>>>>>>
>>>>>> Unique-id field:
>>>>>> 1. Add unique-id XenBus entry for virtual input and display.
>>>>>>
>>>>>> 2. Change type of unique-id field to string for sndif to align with
>>>>>> display and input protocols.
>>>>>>
>>>>>> Signed-off-by: Oleksandr Andrushchenko
>>> <oleksandr_andrushchenko@epam.com>
>>>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>>>>
>>>>> I'm fine with this patch being added via the input tree with the
>>> other
>>>>> patches. In case I should take it via the Xen tree, please send me a
>>>>> note.
>>>> Juergen,
>>>>
>>>> I created an immutable branch off v4.17 with these 3 patches in case
>>> you
>>>> would want to merge them into your tree without waiting for them to
>>>> appear in mainline:
>>>>
>>>> git pull git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>>> ib/4.17-xen-kbdfront-runtime-config
>>>> Thanks.
>>>>
>>> Thank you,
>>> I would prefer the fastest path of course
>> It will be part of 4.19 pull request; the immutable branch is for
>> Juergen if he does not want to wait till 4.19 merge window to get the
>> changes.
> Ah, I see. Juergen, can we please merge this via Xen tree then which
> I assume will be faster?

As Dmitry has it already queued in the input tree I think this is fine.
I trust him to take the right decision for which kernel version those
patches are to be queued. They belong to the input tree after all.


Juergen

