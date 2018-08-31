Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B5B20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCF95UHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B5B20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeIACsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:48:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35358 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeIACsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:48:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so6133865pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=39oUzhWanYbohlAO1xPZEjXibqGwXCUrfrY7MazkFng=;
        b=GCF95UHdaoMTfBQ7BtgRq9awbriYTFx/unjZRYMvMmBt21nkuVHc7r+03l6GsX9uOw
         ffKij+RLqFZuoaDaT948FFCZ4gmpjCFVZ52X7dI1Dd4uW4ZIkes9v/JvThl9WSKixcfH
         5ovx+fCbsoIlfDg3Xj1X1P/WZoXt0JcSZ/b9oZSie2/tAJ+2ZTe4+tRAj8qJad+eSj2l
         lPIY53FgmpOM3rl5/uj/5SymOTTvZpMDPJ79z7Gsr9g+6MjYFFKopWtRIlRjLMsLhpGD
         bZxU1ZQgaJnNT1gSV3i69Myyqk0dWghxfOcYKmSi/DclbeAuuIq2mxSjqqz+Z3O7qPvB
         EgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=39oUzhWanYbohlAO1xPZEjXibqGwXCUrfrY7MazkFng=;
        b=iZ2V73wW+ZgEJiZIVGDVWrzlk7WbJdHedMlbJOtfUHKq7DrhF1P2PfWjuSEcbxs9jo
         0zYtyk66bbCxzaC44i4E7BYH8LjdhxIc2d+u5fMtW2NY4dvt7U89OCodvxJnFZgjbYvU
         fXBo1nGhjes75aqo71nRMl47wjTDFza43Mq1QVQJ21+9V/QC9T4po9L03RKd68bn7/H3
         JkiTe0+d2+S5AR3RRS7f3FK97uYllYfH8XxrzeRiFMI+mxIhPYuMllpWJblK0SbPigNY
         lwLG5jtkl2XuUX5ZU+QItqOzPDRPy0gIKojKYDAwiulIp/AAbB6cU9rIr/Uc4qWbTvKg
         7Z8Q==
X-Gm-Message-State: APzg51CQj/7aXxZnw0oYHSSUDleFyEc656OQaXzmvSS7DTr5LdMK6su5
        eyneZryDzC90RwjZjRkMYbLfMOGbbRND0LvyOZFSzA==
X-Google-Smtp-Source: ANB0VdbaCMMKrmZ4wHmiW7DQQEA1zIAFTfLPIlEsI0tq8qwrg/s4qZ2hgz5Oidmttauf6muGcRC0pj+IRc7ussGLPjw=
X-Received: by 2002:a63:5c5e:: with SMTP id n30-v6mr16454529pgm.253.1535755113145;
 Fri, 31 Aug 2018 15:38:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 31 Aug 2018 15:38:12
 -0700 (PDT)
In-Reply-To: <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
References: <000000000000c178e305749daba4@google.com> <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov> <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov> <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 31 Aug 2018 15:38:12 -0700
Message-ID: <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 9:17 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 08/31/2018 12:16 PM, Stephen Smalley wrote:
>>
>> On 08/31/2018 12:07 PM, Paul Moore wrote:
>>>
>>> On Fri, Aug 31, 2018 at 12:01 PM Stephen Smalley <sds@tycho.nsa.gov>
>>> wrote:
>>>>
>>>> On 08/29/2018 10:21 PM, Dmitry Vyukov wrote:
>>>>>
>>>>> On Wed, Aug 29, 2018 at 7:17 PM, syzbot
>>>>> <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com> wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following crash on:
>>>>>>
>>>>>> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
>>>>>> git tree:       net-next
>>>>>> console output:
>>>>>> https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
>>>>>> kernel config:
>>>>>> https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>>>>>> dashboard link:
>>>>>> https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>
>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>
>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the
>>>>>> commit:
>>>>>> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
>>>>>
>>>>>
>>>>> Hi John, Tyler,
>>>>>
>>>>> I've switched syzbot from selinux to apparmor as we discussed on lss:
>>>>>
>>>>> https://github.com/google/syzkaller/commit/2c6cb254ae6c06f61e3aba21bb89ffb05b5db946
>>>>
>>>>
>>>> Sorry, does this mean that you are no longer testing selinux via syzbot?
>>>>    That seems unfortunate.  SELinux is default-enabled and used in
>>>> Fedora, RHEL and all derivatives (e.g. CentOS), and mandatory in Android
>>>> (and seemingly getting some use in ChromeOS now as well, at least for
>>>> the Android container and possibly wider), so it seems unwise to drop it
>>>> from your testing altogether.  I was under the impression that you were
>>>> just going to add apparmor to your testing matrix, not drop selinux
>>>> altogether.
>>>
>>>
>>> It is also important to note that testing with SELinux enabled but no
>>> policy loaded is not going to be very helpful (last we talked that is
>>> what syzbot is/was doing).  While syzbot did uncover some issues
>>> relating to the enabled-no-policy case, those are much less
>>> interesting and less relevant than the loaded-policy case.
>>
>>
>> I had thought that they had switched over to at least loading a policy but
>> possibly left it in permissive mode because the base distribution didn't
>> properly support SELinux out of the box.  But I may be mistaken.
>> Regardless, the right solution is to migrate to testing with a policy
>> loaded not to stop testing altogether.
>>
>> Optimally, they'd test on at least one distribution/OS where SELinux is in
>> fact supported out of the box, e.g. CentOS, Android, and/or ChromeOS.
>
>
> Or Fedora, of course.

Hi,

Yes, we switched from selinux to apparmor. The thing is that we
effectively did not test selinux lately, so it's more like just
enabling apparmor rather than disabling selinux.

The story goes as follows.
We enabled selinux, but did not have policy and selinux wasn't enabled.
Then Paul (I think) pointer that out. After some debugging I figured
out that our debian wheezy actually has a policy, it's just that
selinux utilities were not installed, so init could not load the
policy.
I installed the tools, and we started loading policy.
But then it turned out that wheezy policy does not allows mounting
cgroup2 fs and maybe some others even in non-enforcing mode. As far as
I understand that's because the policy does not have definition for
the fs, and so loading bails out with an error.
We need cgroup2 both for testing and for better sandboxing (no other
way to restrict e.g. memory consumption). Moreover, we did not test
any actual interesting interactions with selinux (there must be some?
but I don't know what are they).
So I had to uninstall the tool and policy is not loaded again.
I investigated building a newer debian image with debootstrap (which
should have newer policy I guess). But they don't work, some cryptic
errors in init. Other people reported the same.
So that's we are. I don't have any ideas left...
