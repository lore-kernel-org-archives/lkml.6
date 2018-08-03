Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57370C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111F8208B2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111F8208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbeHCVQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:16:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728324AbeHCVQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:16:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D297C4021CC2;
        Fri,  3 Aug 2018 19:18:37 +0000 (UTC)
Received: from [10.40.204.20] (ovpn-204-20.brq.redhat.com [10.40.204.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 366752026D65;
        Fri,  3 Aug 2018 19:18:36 +0000 (UTC)
Subject: Re: [dm-devel] LVM snapshot broke between 4.14 and 4.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru
References: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
 <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru>
 <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru>
 <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <b2bbd8ec-ac5b-fa8a-d3f7-8615d87f73c3@redhat.com>
 <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
From:   Zdenek Kabelac <zkabelac@redhat.com>
Organization: Red Hat
Message-ID: <bc71118d-3003-6260-6ab3-ddcc4277aeed@redhat.com>
Date:   Fri, 3 Aug 2018 21:18:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 03 Aug 2018 19:18:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 03 Aug 2018 19:18:37 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'zkabelac@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 3.8.2018 v 18:37 Linus Torvalds napsal(a):
> [ Dammit. I haven't had to shout and curse at people for a while, but
> this is ABSOLUTELY THE MOST IMPORTANT THING IN THE UNIVERSE WHEN IT
> COMES TO SOFTWARE DEVELOPMENT ]
> 
> On Fri, Aug 3, 2018 at 6:31 AM Zdenek Kabelac <zkabelac@redhat.com> wrote:
>>
>> IMHO (as the author of fixing lvm2 patch) user should not be upgrading kernels
>> and keep running older lvm2 user-land tool (and there are very good reasons
>> for this).
> 
> Yeah, HELL NO!
> 
> Guess what? You're wrong. YOU ARE MISSING THE #1 KERNEL RULE.
> 
> We do not regress, and we do not regress exactly because your are 100% wrong.
> 

Hi Linus

Sorry to hear you so crazy about this :) -  but my comment was mainly targeted 
to 'distribution maintainers'  trying to push the latest kernel and preserving 
old tools  (not providing upgraded packages).   If it's worth to upgrade 
kernel - it should be worth to upgrade surrounding packages, especially if 
they are very tightly bind to work with kernel.

I just think you are overreacting here and you could trust me I personally do 
A LOT to keep everything as much usable & compatible in lvm2 as we can across 
all kernels, all distributions and many architectures.

Lvm2 is always tracking individual bugs in kernel and reports them to user or 
tries to bypass...

>> Kernel had a bug which has been fixed
> 
> That is *ENTIRELY* immaterial.
> 
> Guys, whether something was buggy or not DOES NOT MATTER.
> 
> Why?
> 
> Bugs happen. That's a fact of life. Arguing that "we had to break
> something because we were fixing a bug" is completely insane. We fix
> tens of bugs every single day, thinking that "fixing a bug" means that
> we can break something is simply NOT TRUE.

 From my userland POV - leaving kernel write to devices that are supposed to 
be read-only  'just because' it's kernel is wrong - the fact it has NOT been 
discover for so long means - there are not many users and not many testers of 
this combination.

But if kernel people do want to make a big stress case about this - I'm the 
last one to object - I'm just unsure what kind of bugs are supposed to be 
preserved and how it's going to be recognized which bugs are usable and which 
are fixable....

On a funny note - security exploits had also many users - so why fixing them....


> So no. Your rule is COMPLETELY wrong. If you cannot upgrade a kernel
> without upgrading some other random binary, then we have a problem.

It's was not meant as a rule, just recommendation - and I think we can end up 
this fight over nothing here - there is probably very low number of users of 
this combination....


Regards


Zdenek
