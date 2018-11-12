Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0045CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0A322419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="L36GGJvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0A322419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbeKMEJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:09:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42376 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMEJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:09:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so220778pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YGO2jd51XvOsLgr43DLnUI1wSxnyHD1LoQp9n76+Aik=;
        b=L36GGJvckBz4c6wLH9bufrswV2l5wsQR+ZIHz3I3dJLtFmhYtGvl3hon19PV/HFmvu
         kiNNJIa/aMwFBjqekMuLKbtgdbIl8CToWVZnd7iAENqEppM1tPjVHO+OPNzTB0TGPALE
         tQoEU7EQCX+PhoeOs5F8P9DIf9Wd8GVasLnp7qKzYO7pnl/yzeZlGw08gwtElp2onnHf
         k2USpd69+HVrwjR3j25MXj8Yv3MhpBcYdmLiMDhhvFzGzRO059+KhkMTVLVIrpjVXhvV
         6JXJVKPrp3INsGeiQQGPpmZxG+d/uw3hDDYtzjgDVE04E+mIusQpqyjkx2N1PLGaYC4h
         V7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YGO2jd51XvOsLgr43DLnUI1wSxnyHD1LoQp9n76+Aik=;
        b=YuxG4Fh+BGcowgK5PLzS90Xpl/ag0rxO+Qbms4jsDKe0jLrH9Ev6rG5zR3CWEXELOC
         8eFwWA7u+/dKKwDWOVGQqrcN1odVuqEPEZOhmUNPVEAt4igNdj1IrIqEyq3079SNEBJl
         nvY/ec/jacy+WhVbg3x0KNt13gBq2dXilA3aBseAb/Wdzswj+EgJpZV7OdtS9EaBkk07
         8futiavnOLELJS0H1/hYpUx9yhZhzKae3GSmTKCKJBuOQZRsxNF8atznIDKyN/Cj7DY4
         Da0POD+IvsuYVZPQxkUF2k2LM48zZ7Ipb82WY/wKgpzqD/s00lHLuZmb4sXH4W/itYFT
         doCQ==
X-Gm-Message-State: AGRZ1gL0czd8RYqiybHJCsFD7ECIqrXle3e9No82GaFtX9Tqm9l3mtmY
        2XkkO2QkSh0bXIIXH8rnsjzQbQ==
X-Google-Smtp-Source: AJdET5ecAWXQv2tq5eGrdc3dEgFVfIJxyx7FySBg03sL2eSYcHdFesaq3vAmMsIJi3J8v4DYsHUU1w==
X-Received: by 2002:a62:4c6:: with SMTP id 189-v6mr1952057pfe.110.1542046529460;
        Mon, 12 Nov 2018 10:15:29 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id 85sm5189349pfw.17.2018.11.12.10.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 10:15:28 -0800 (PST)
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
        linux-doc@vger.kernel.org, kernel-team@android.com,
        Paul Lawrence <paullawrence@google.com>,
        Theodore Tso <tytso@mit.edu>
References: <20181106230117.127616-1-salyzyn@android.com>
 <20181106230117.127616-2-salyzyn@android.com>
 <20181108200106.GB3663@redhat.com>
 <b057da99-adc6-b355-fb57-b314a29f298f@android.com>
 <CAOQ4uxjVPKSaJ2oscvM7jtsDVabnq_qMPg7k4KQEyOLAVPojcg@mail.gmail.com>
 <c6518e90-9429-85a1-fe19-83e058154e2a@android.com>
 <CAOQ4uxgwQAf4NtaE+qhLUTVnvu0ixNZ6Gwotc4q4zR-y35NmZA@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <ad41a028-f0d4-296f-79fd-f00f73f25ce6@android.com>
Date:   Mon, 12 Nov 2018 10:15:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgwQAf4NtaE+qhLUTVnvu0ixNZ6Gwotc4q4zR-y35NmZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2018 11:51 PM, Amir Goldstein wrote:
> On Fri, Nov 9, 2018 at 7:32 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> On 11/08/2018 07:05 PM, Amir Goldstein wrote:
>>> Mark,
>>>
>>> I have some Android internals background, so I have a general
>>> understanding of the
>>> use case, but I can understand why people have a hard time connecting to the
>>> motivation, thinking "their security model must be flawed".
>>>
>>> I am not sure if you are avoiding laying out the details of the model
>>> because you
>>> are not allowed to expose details or because you feel details may confuse us.
>> I am not a "great communicator"(tm), probably only 50K vocabulary,
>> propensity towards quantum leaps, so yes, I was worried about confusion.
>> non-overlapping security model is the key takeaway I feel.
>>
> I hope my comment below will serve as an example why explaining your use
> case is preferred to presenting the abstract and generalized problem.
> And still - no objections to your current patch, *because* it can solve your
> use cases and *because* we don't need to deal with the  abstract and
> generalized problem.
Alas, I personally object to changes to the kernel that have a limited 
(well, 1.8billion devices is not limited) use case. If they can benefit 
others, they become more useful. This paradigm helps prevent spaghetti 
and areas of the kernel that are not well understood and subject to bitrot.
>> [TL;DR]
>>
>> In Android there are two use cases this covers:
>>
>> 1) On userdebug (rooted development) builds, adb remount feature
>>      for readonly filesystems which include squashfs, ext4 dedupe,
>>      and any right-sized (zero space left over) filesystems.  In these cases
>>      the system will resort to utilizing overlayfs, and allow for
>>      updated content to a scratch backing storage.
>> 2) On operating system updates where new Hardware Abstraction
>>      layers have been added and the vendor/oem supplied components
>>      supplied to an older release.  In this corner case the operating
>>      system update may carefully select overrides that are merged into
>>      the vendor partition content directories as hosted by the
>>      operating system partition.
>>
>> The sepolicy model can be browsed at
>> https://android.googlesource.com/platform/system/sepolicy/.
>>
>> In the first use case above the possible insecurity is tempered by the
>> debug nature
>> of the system and the lurking big elephant in the room privilege
>> escalation possibility
>> (/system/bin/su existing),
> Since you already have an elephant in the room, might as well use it
> to mount overlay. I am guessing most of the work in developer mode is
> with sepolicy disabled anyway?
> Essentially, adb root/adb remount means gloves are off.
> Although with overlayed adb remount gloves could be put back on
> when you relinquish the overlay and get back to original /system mount.
adb starts far too late to be useful for the original mount operation. 
We have to mount at init first stage before sepolicy is loaded and init 
is re-exec'd. adb root / adb remount / adb push is relegated to updating 
the content before a reboot to activate _some_ of the possible things 
that developers adjust.

Yes, I find the ability to relinquish the overlayfs and restore the 
system to original an added-value, whereas if we could adjust the 
system&root filesystems directly, a complete reflash is required to 
restore back. We only activate/use the overlayfs for read-only 
system&root filesystems.
>
>> in the other a r/o and precise MAC. sepolicy
>> and credentials
>> will rule over transitions from one security domain to another for
>> execution, vendor components are managed by a separate vendor_init and
>> the actual xattr content is constant.
>>
> For this use case, you don't need an upper layer at all and you probably
> don't use lower layers redirect_dir. Right?
> So all the concerns about get/set trusted overlay xattrs and detecting
> opaque directories (do you need those?) are moot.
> If you propose that override_creds=off can only be enabled
> on lower-only overlayfs, the caveats section of your documentation
> would shrink down considerably to the point that it may even be
> comprehend-able to mortal users and I don't think you will see much
> resistant from overlayfs developers to that "safe side" approach.

Yup, no upper layers. If this was the only uses case, but it isn't.

Besides, I submitted this patch _before_ this second use case presented 
itself as required, it was a later development during the lifetime of 
this patch, so admittedly still focused on the first use case.

I should regroup in the documentation and present the use cases 
individually and specifically ... as you suggest :-) Off to consider a 
v9 respin (KISS documentation has always been troublesome for me) ...

[TL;DR]

The remain snapshot discussion is a distraction, I will have to defer to 
Paul to answer to them (and yes, we have discussed eye-to-eye over this 
and private emails). I agree with the details you have added to the 
conversation.

Sadly the CL in question needs to solve the caveats before we could 
consider overlayfs for userdata.

Thanks for these comments! We should consider when the dust settles.

Sincerely -- Mark Salyzyn


