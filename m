Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD67C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CFB208A4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LV+UAhe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CFB208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeFTI76 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:59:58 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41214 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932892AbeFTI7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:59:54 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so1179418pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VOK8USHparm5N7E38dx1B6Nztpe6aZJXEGADrfJmh+k=;
        b=LV+UAhe3x7o6U7OMjLO2iJR6/DA3zrqlNYSlduILUo50qG7podloR8q+pGgX8IwvRf
         Q84hLUOvfuFAfwzQ0W9L8r68KnOI/krkjLmEG71y2McUZz08kpWA8XMZXSULkAkYW4yj
         OZ9masQHFzabDHO+jPk72TFRaz4geeWMhy+Vc6BZtMasrgMrtz7oXw0NfqSk6nEum8P+
         e+HEKdiQEobvC90HTEl9J84CYyeGADnrcrd6s4b/yRGpKV/biTOVQ+qjIQgwysVBRTdx
         viBuqp1WCGwA4PbUwkwgKNJtrYs3RKVpetg6tuSwcKJiTAkUv5MYyZr/euTEYtwZAIyr
         fzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VOK8USHparm5N7E38dx1B6Nztpe6aZJXEGADrfJmh+k=;
        b=QVpevR0uAF6mrVM9wUit5x1sdSXrqnM0g1KVPpsSh4Gj6db23Tc5HfSwC35NjnatJQ
         /m9PVYjlLUqQ5taa9dTWJbEVqD0D0E//2Iz5Rza5F7Gn6VDWgLTshCyXaViB9l+1/eMp
         hjRlYvCNX2rdorjrcACXs3tgg8OFoEwaodHt9dbzGH60ICqlnPkv/ahb1bo3i15bXfBF
         Fox1pSygbd4grpGRhBY17lZt+HR/TVz5heHz28osXCsPSrDye8bx/uZcj8AcvtqNO1+q
         KwdqzsqmBC8dNeZRU6Dq3n2PSsUCakOKmVlcjjKDDkVIhsvCy7xgmoSR9tmTg8aXbD+t
         UhCA==
X-Gm-Message-State: APt69E0dYW3m/+yLvtXB7hI9stKww5dqoOR2xfwCtLqsgxauBjjowA9E
        aSKDjDo/XLHIhoJjOXYloPWcXIy+FPtRwoj5WZQ3eg==
X-Google-Smtp-Source: ADUXVKKlRyKXvqNd2MYar5S/GpvnFHVBQI2p6cK9+pM6zWHpMHgmeeFvKeJFINt7jfmmf67WdUQvlObNOocX7HAU1ls=
X-Received: by 2002:a62:9652:: with SMTP id c79-v6mr21795025pfe.114.1529481154073;
 Wed, 20 Jun 2018 00:52:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 20 Jun 2018 00:52:13
 -0700 (PDT)
In-Reply-To: <CACT4Y+Y0d4O3Mgz5fH1nCWdoFOstWPmaRixavb4hfjqOuwhGrg@mail.gmail.com>
References: <0000000000006370c3056d1855e7@google.com> <CACT4Y+Yqkon84bMamFNQTsn4npJtJnhOOd1ZHx+AkuKG-_eMsg@mail.gmail.com>
 <79eb119f-efc3-35b7-1377-9e4c03182ebd@redhat.com> <CACT4Y+Y0d4O3Mgz5fH1nCWdoFOstWPmaRixavb4hfjqOuwhGrg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Jun 2018 09:52:13 +0200
Message-ID: <CACT4Y+ZdPtSV0pky4j=gAe7U+8PA5jGk3Sm5UB9=m1i=e=FZoA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in do_general_protection
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     syzbot <syzbot+a1264132fc103340628f@syzkaller.appspotmail.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 10:16 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, May 28, 2018 at 1:25 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 26/05/2018 11:29, Dmitry Vyukov wrote:
>>> KASAN: stack-out-of-bounds Read in do_general_protection
>>> KASAN: slab-out-of-bounds Read in vmx_vcpu_run
>>> KASAN: use-after-scope Read in vmx_vcpu_run
>>> KASAN: stack-out-of-bounds Write in notify_die
>>>
>>> See full info at:
>>> https://syzkaller.appspot.com/bug?extid=a1264132fc103340628f
>>>
>>>
>>> There seems to be 2 problems:
>>>
>>> 1. msr_write_intercepted doing something notoriously bad.
>>
>> The faulting line is
>>
>>         msr_bitmap = to_vmx(vcpu)->loaded_vmcs->msr_bitmap;
>>
>> so I suppose to_vmx(vcpu)->loaded_vmcs is bogus?  That seems like "just"
>> a corruption of the struct kvm_vcpu, because the loaded_vmcs field is
>> pointing elsewhere inside the same struct.
>
> This is reproducible and the reproducer only uses KVM syscalls. So it
> seems that KVM corrupts itself. Perhaps it's KVM_SET_MSRS that messes
> things?

This one looks like the same root cause as here:

KASAN: stack-out-of-bounds Read in unwind_next_frame
https://groups.google.com/d/msg/syzkaller-bugs/MGQ_W8DPYXA/k-xK7sBrBgAJ
