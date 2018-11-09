Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92AEC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A74A2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="vy0ifGYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A74A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeKJDNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:13:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46390 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbeKJDNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:13:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id c13-v6so1225538plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 09:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YSVOvcKc4Ekb8Ybcill7AdR5D689HT93hFxScubrg7k=;
        b=vy0ifGYkELHU0pMxERWWn8fc/tZjrIl4oGaS1u05ad00qIs+npM+GRi69GMnnsRdM5
         VUgNQxJL71vJAgD03CL0I94TopJbdhGfo1CSTeY9koyZ61vZ44bKJOPG6BJ9HgKPwegr
         jA/JvWCZSD18s06kzOSEChthCT00wWlRN2GGkej0qG3TPAsnELwu6jej7bNrKRJ7ZjyV
         KuTGYe1vwL5UFhYNmeQ5GV39NEcL3z7lfWnplKNS49/3qzbE0Xkc0Wst3tSGx2ZCX6nF
         BhMdvaTKmoKWCZpmcgqjhaUteUqK6VFkYMy0SmRKWUwa+8If8N1JLq7BOuBeRowjFKRX
         4zKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YSVOvcKc4Ekb8Ybcill7AdR5D689HT93hFxScubrg7k=;
        b=hi83ZBYEqX9eNp3ZEIlZVmp28oMTcszsah1EjirnoCJBq9t7okXOiJLBbAh+TvqO8X
         d+t4+zWhEa+xESZAyRTYRuXVkNaoQHJfbNx9MwhRb8rRBM/1Y6/aBsRFIKkKI+CxHJWL
         z0vCYMH/tsES+DQdAR7Uf1Vfdl3UvuGqWFm8zuhUbS1iM8RBHMjE253OEKqcKwcnlwMZ
         DSo63MYxC1cvScUA4wv55ZKPsVtJq/GKqY1+QbaCP2ZwhF3lzClCXwNGeXDksf30KObk
         6jj/GQ+5Dz/+VGOlni6jnQxO2/OXKVYSjfAy3d6gQtzv3Q4Uje+VdGufd/2AamRMe0gC
         wxnA==
X-Gm-Message-State: AGRZ1gJmACB9WZAcZijLM2f/T83bi20jZkwNrzD4gHEeS3jJWzqWDKla
        HC9TZWF5UYyrgalaPfrTH2tWsA==
X-Google-Smtp-Source: AJdET5ccNBeGfRr1ig8sAbcNq7ZrhybfbT9qbgUmVtzy91V6xw9kVz1i5Zj9/9KslGqYYlk1Ipaf8Q==
X-Received: by 2002:a17:902:bf0c:: with SMTP id bi12-v6mr10074721plb.330.1541784733202;
        Fri, 09 Nov 2018 09:32:13 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id e204-v6sm8397440pfh.68.2018.11.09.09.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 09:32:08 -0800 (PST)
Subject: Re: [PATCH v8 2/2] overlayfs: override_creds=off option bypass
 creator_cred
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org, kernel-team@android.com
References: <20181106230117.127616-1-salyzyn@android.com>
 <20181106230117.127616-2-salyzyn@android.com>
 <20181108200106.GB3663@redhat.com>
 <b057da99-adc6-b355-fb57-b314a29f298f@android.com>
 <CAOQ4uxjVPKSaJ2oscvM7jtsDVabnq_qMPg7k4KQEyOLAVPojcg@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <c6518e90-9429-85a1-fe19-83e058154e2a@android.com>
Date:   Fri, 9 Nov 2018 09:32:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjVPKSaJ2oscvM7jtsDVabnq_qMPg7k4KQEyOLAVPojcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2018 07:05 PM, Amir Goldstein wrote:
> On Thu, Nov 8, 2018 at 11:28 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> On 11/08/2018 12:01 PM, Vivek Goyal wrote:
>>
>> On Tue, Nov 06, 2018 at 03:01:15PM -0800, Mark Salyzyn wrote:
>>
>> By default, all access to the upper, lower and work directories is the
>> recorded mounter's MAC and DAC credentials.  The incoming accesses are
>> checked against the caller's credentials.
>>
>> Ok, I am trying to think of scenarios where override_creds=off can
>> provide any privilege escalation. How about following.
>>
>> $ mkdir lower lower/foo upper upper/foo work merged
>> $ touch lower/foo/bar.txt
>> $ chmod 700 lower/foo/
>>
>> # Mount overlay with override_creds=off
>>
>> $ mount -t overlay -o
>> lowerdir=lower,upperdir=upper,workdir=work,override_creds=off none merged
>>
>> # Try to read lower/foo as unpriviliged user. Say "test"
>> # su test
>> # ls merged/foo/
>> ls: cannot access 'merged/foo/': Operation not permitted
>>
>> # Now first try to do same operation as root and retry as test user.
>> $ exit
>> $ ls merged/foo
>> bar.txt
>> $ su test
>> $ ls merged/foo
>> bar.txt
>>
>> lower/foo/ is not readable by user "test". So it fails in first try. Later
>> "root" accesses it and it populates cache in overlayfs. When test retries,
>> it gets these entries from cache.
>>
>> With override_creds=on this is not a problem because overlay provides
>> this as functionality as long as mounter as access to lower/foo/.
>>
>> But with override_creds=off, mounter is not providing any such
>> functionality and we are exposing an issue where cache will make
>> something available which is not normally available.
>>
>> I think it probably is a good idea to do something about it?
>>
>> Thanks
>> Vivek
>>
>> Good stuff.
>>
>> That sounds like a bug in cache (!) to not recheck caller's credentials. Currently unsure how/where to force bypass of the cache (performance hit) as it is wired in throughout the code without a clear off switch, or rechecking of the credentials at access. This does need to be addressed to make this 'feature' more useful/trusted for non-MAC controlled, use cases.
>>
>> This is not a problem in the Android usage case since DAC is simple and all can be read, execute bits might be controlled, the owners and perms are otherwise unremarkable in the affected arenas that are utilizing overlayfs. Not using it for a generic r/w backing except in rooted debug scenarios by developers, otherwise everything is r/o, MAC on the other hand is complex and heavily inspected. We do, however, want multi level security in that both DAC and MAC can be trusted and can protect each other from holes.
>>
>> Sounds like the caveats in the documentation need to be expanded if _no_ solution for this kind of access pattern becomes apparent.
>>
> I think maybe you could append the "behavior of the overlay is undefined" clause
> to the caveats to cover issues like the one raised by Vivek.

Will respin with adjustment to documentation and head towards v9.

I would prefer to have a complete solution to the non-overlapping 
security model,
and maybe in time it will come, but admittedly only if motivated to use 
overlayfs on
Android's userdata (see below) where all these issues would need to be 
solved.

Consider this (far simpler) patch a shot across the bow that an 
overlayfs use case was
removed in 4.6, and for completeness at least we would like to see it 
back. Would the ideal
be that the creator's credentials are only used to facilitate some 
workdir or r/w upperdir
operations, and user credentials are rechecked in more places in cache. From
my perspective feels like whack a mole for a few iterations. In that 
case, this option is
the start of those iterations "if you build it they will come"?

The first one would be an investigation on how to solve Vivek's scenario 
in the face of this change? (not volunteering today to do that, 
admitting to a shortcoming, and a need for a deeper understanding of the 
code for the moment)
>
> Mark,
>
> I have some Android internals background, so I have a general
> understanding of the
> use case, but I can understand why people have a hard time connecting to the
> motivation, thinking "their security model must be flawed".
>
> I am not sure if you are avoiding laying out the details of the model
> because you
> are not allowed to expose details or because you feel details may confuse us.

I am not a "great communicator"(tm), probably only 50K vocabulary,
propensity towards quantum leaps, so yes, I was worried about confusion.
non-overlapping security model is the key takeaway I feel.

[TL;DR]

In Android there are two use cases this covers:

1) On userdebug (rooted development) builds, adb remount feature
    for readonly filesystems which include squashfs, ext4 dedupe,
    and any right-sized (zero space left over) filesystems.  In these cases
    the system will resort to utilizing overlayfs, and allow for
    updated content to a scratch backing storage.
2) On operating system updates where new Hardware Abstraction
    layers have been added and the vendor/oem supplied components
    supplied to an older release.  In this corner case the operating
    system update may carefully select overrides that are merged into
    the vendor partition content directories as hosted by the
    operating system partition.

The sepolicy model can be browsed at 
https://android.googlesource.com/platform/system/sepolicy/.

In the first use case above the possible insecurity is tempered by the 
debug nature
of the system and the lurking big elephant in the room privilege 
escalation possibility
(/system/bin/su existing), in the other a r/o and precise MAC. sepolicy 
and credentials
will rule over transitions from one security domain to another for 
execution, vendor components are managed by a separate vendor_init and 
the actual xattr content is constant.

Being able to block reading a file or directory is not a big concern in 
the associated trees, because all of the originals are backed by a r/o 
filesystem image, the content
is generally visible by all, and if not they are locally restricted 
views into a public filesystem image, that themselves can be mounted on 
a desktop. There are no privilege escalation or privacy issues.

An Android use case this does not cover securely is when overlayfs is 
used as a
snapshot of the users data during the update process to permit easy 
rollback of user data due to an
update failure (very unlikely 0.01%, but alas there are tachyons with 
our names on them).
For those use cases we have opted to add snapshot-ting to
f2fs and ext4 (using dm-bow in another patch set under discussion for 
the time being)
and abandoned overlayfs as insufficient in a dynamic non-overlapping DAC 
and MAC security model.
Built in filesystem snapshot-ting is always preferred for performance,
efficiency and access to the free block pools they maintain so that was an
easy choice.

> If the latter, then I think that actually listing the details of the
> overlays used in Android
> and some concrete examples of access policies to those overlays could
> benefit the
> discussion on the feature.
> To clarify, this only a suggestion. I have no objection to the patch.
>
> Thanks,
> Amir.

-- Mark


