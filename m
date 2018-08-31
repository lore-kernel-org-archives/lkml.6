Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753E9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B68B20835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B68B20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbeHaUYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:24:10 -0400
Received: from uphb19pa08.eemsg.mail.mil ([214.24.26.82]:34386 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727286AbeHaUYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:24:09 -0400
X-EEMSG-check-008: 76653508|USFB19PA11_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 Aug 2018 16:15:54 +0000
X-IronPort-AV: E=Sophos;i="5.53,312,1531785600"; 
   d="scan'208";a="15418151"
IronPort-PHdr: =?us-ascii?q?9a23=3A7jp7FxcyIhDMOlEXhRkCoDc/lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc28ZRSN2/xhgRfzUJnB7Loc0qyK6/+mATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbF/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwdWG?=
 =?us-ascii?q?RBQ91RVzRfDYygc4sBAe0BPeNCoIn8oVsFsB+yCAaoCe/qzDJHiGX23akn2O?=
 =?us-ascii?q?o/Fw/I0hErE9YXvHjJsNn5MaEfWv23wqbV1zXOd+5Y1zfj5ojGcR4vr/+DUr?=
 =?us-ascii?q?1yfsXNxkciDB/Fg1aKpID5Iz+Y2OYAvm6G5ORgT+KvjGsnphlsrDiz2Mgsko?=
 =?us-ascii?q?nJiZwTylvZ6Ct5xZw6Jdm8SEFlYd+vDZxdtzqHOIttWc4iX2Fptzo6yr0Bo5?=
 =?us-ascii?q?K7ejMKx449yx7QbPyHbZGF7xT+X+ifJjd4gWhqeLO5hxuq/kigy/H8Vsmp0F?=
 =?us-ascii?q?lRtCZKjt7MtnUV2xPJ8siHUuB9/l+m2TaTzQzc9uZEIUUymKHGKJAh2qY9mo?=
 =?us-ascii?q?ccvEnMBCP7mFj6gLWIekgr5OSk8fnrb7P7rZGGLYB0kBvxMqE2l8y6BuQ3Lx?=
 =?us-ascii?q?YBUnCA+eS5yL3j5Ur5QKhWjvEukqnWrpTaJcMDq66lGQBVyIcj6wukDzu80d?=
 =?us-ascii?q?QYm3cHLFVeeB2Zk4flIU3OIfDkAve/hFSgijFryOzdPrL9GJnNK3nDkLP5cb?=
 =?us-ascii?q?Z87U5T1hYzwMhC659bBbwNOvL+VlLruNDGARI1LRa4z/v/BNV4zIweWGaPAq?=
 =?us-ascii?q?GDMKPVtF+F/vkvLPSXZIIOpDb8K+Qq5/7pjXMjn18dZrOm0YEYaHC/APRqO1?=
 =?us-ascii?q?+Zbmb0gtcdDWcKuRIzTPTwh12fVT5efG6yULgh5jE/EY6mCIDDRoe3gLOfxi?=
 =?us-ascii?q?u0AppWZmVeAFCWDXjob5mEW+sLaC+KP8BhjDwFVaWiS48myxGjrwD6y71gLu?=
 =?us-ascii?q?rb/i0Xq4jv28Ry5+3WjRsy7yB7D9yB02GRSGF5hngIRj833a9kpkx91lCP3b?=
 =?us-ascii?q?Zlj/BECNBe5u5FXwkmOZHH0+B3C9P/Vh7bcdqNVVmpXNurDioxQ98q2N8PY0?=
 =?us-ascii?q?d8G9a4gRDH2yqlHaUVm6aRC5ws6qLcxGDxJ8Fhy3bDzqYhjl0mTtFTOm2hg6?=
 =?us-ascii?q?517xLTCJLRk0WFi6aqcrwR3DLN9WeDzGqBoEJYUBVrXKrZR38fYEzWrdL45k?=
 =?us-ascii?q?zeVbCuDa4rPRdGyc6HMqFKcMHmjU1aRPf/P9TTe2Cxm2CwBRaO3L+Mbo3qe2?=
 =?us-ascii?q?UH0yXbE0gLjQYT8G2aOgckACehpGTeDD1yGl31Z0Pg6/VxqHS+TkUs1QGFc1?=
 =?us-ascii?q?Vh16ap+h4SnfGcSfYT3rUeuCc7qjV0B02w39TMBNqFuQVhfb9QYdQn4FdIzW?=
 =?us-ascii?q?jZrRByPoS8L6B+gV4TawB3v0Lo1xVqBYRMiMsqo20wzAp0N62Y1EhMdy2X3Z?=
 =?us-ascii?q?/uIL3bMGry8w61a67QxF7e1Mya+qAV6PQ3s1/jph2mFlI+83V71NlYy3+c5p?=
 =?us-ascii?q?TMDAoPXpP9S103+AZmqLHHeCk95p/U1H11PamxtT/Nxs8pBO87xRu7YddfP7?=
 =?us-ascii?q?2LFBXoH80ZGceuMuoqlEatbh4eO+BS7qE0Ndu8d/SawK6rIPpgnDW+gGRc/o?=
 =?us-ascii?q?99yE2M+DRnR+7IxZkFx/WY3wuBVzvmkFihtcX3k5heZT4OBmq/1TTkBIlJa6?=
 =?us-ascii?q?1pfYcKCGSuLNezxtV6mZHtQWdU+0W+B1MJw8+kYhWSb1v63Q1f0UQYv3OnmT?=
 =?us-ascii?q?G/zzxpizEptbCT0zDJw+TnbBAHIHJERHF+jVfwJoi5l9IaU1ambwgnihuo/k?=
 =?us-ascii?q?n6x69cpKRwK2ncX11EcDTxL2FnAeOMse+6atNLoLYvtj9aGLCkaE2eYqb0vh?=
 =?us-ascii?q?9f1iTkBWYYzzc+IXXitovogh99lkqSK3F8qHefcsZ1ljnF49mJfuJcxjoLQm?=
 =?us-ascii?q?FDjDDTAlWtd42y8c68i4bIsuf4UXmoEJJUb3+4nsu7qCKn6DgyUlWElPepl4?=
 =?us-ascii?q?iiT1E3?=
X-IPAS-Result: =?us-ascii?q?A2BAAgDLaIlb/wHyM5BaEwEBBQEBAQEBAgEBAQEIAQEBA?=
 =?us-ascii?q?YMkgQ9tEiiDcohwjCAGgQgtiGKIcoZSMIQBRgKDTTcVAQIBAQEBAQECAWwcD?=
 =?us-ascii?q?II1JIJfAQUjDwEFQRAJAhgCAiYCAlcGAQwGAgEBF4JFPwGBdA0Ph3mbS4Euh?=
 =?us-ascii?q?C0BhVEFgQuJKHmBB4ESJ4JrgxsCAhiESIJXAptWCYY0iT8GF4FAhDeIYiuKf?=
 =?us-ascii?q?IoVIjSBISsIAhgIIQ+DJ4IlF4NFim4jMAEJjh4BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 31 Aug 2018 16:15:52 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7VGFo5n007429;
        Fri, 31 Aug 2018 12:15:51 -0400
Subject: Re: WARNING in apparmor_secid_to_secctx
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Paul Moore <paul@paul-moore.com>, dvyukov@google.com
Cc:     syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com,
        tyhicks@canonical.com, john.johansen@canonical.com,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs@googlegroups.com,
        Jeffrey Vander Stoep <jeffv@google.com>
References: <000000000000c178e305749daba4@google.com>
 <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
 <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov>
Message-ID: <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
Date:   Fri, 31 Aug 2018 12:17:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 12:16 PM, Stephen Smalley wrote:
> On 08/31/2018 12:07 PM, Paul Moore wrote:
>> On Fri, Aug 31, 2018 at 12:01 PM Stephen Smalley <sds@tycho.nsa.gov> 
>> wrote:
>>> On 08/29/2018 10:21 PM, Dmitry Vyukov wrote:
>>>> On Wed, Aug 29, 2018 at 7:17 PM, syzbot
>>>> <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com> wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following crash on:
>>>>>
>>>>> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
>>>>> git tree:       net-next
>>>>> console output: 
>>>>> https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
>>>>> kernel config:  
>>>>> https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>>>>> dashboard link: 
>>>>> https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>
>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>
>>>>> IMPORTANT: if you fix the bug, please add the following tag to the 
>>>>> commit:
>>>>> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
>>>>
>>>> Hi John, Tyler,
>>>>
>>>> I've switched syzbot from selinux to apparmor as we discussed on lss:
>>>> https://github.com/google/syzkaller/commit/2c6cb254ae6c06f61e3aba21bb89ffb05b5db946 
>>>>
>>>
>>> Sorry, does this mean that you are no longer testing selinux via syzbot?
>>>    That seems unfortunate.  SELinux is default-enabled and used in
>>> Fedora, RHEL and all derivatives (e.g. CentOS), and mandatory in Android
>>> (and seemingly getting some use in ChromeOS now as well, at least for
>>> the Android container and possibly wider), so it seems unwise to drop it
>>> from your testing altogether.  I was under the impression that you were
>>> just going to add apparmor to your testing matrix, not drop selinux
>>> altogether.
>>
>> It is also important to note that testing with SELinux enabled but no
>> policy loaded is not going to be very helpful (last we talked that is
>> what syzbot is/was doing).  While syzbot did uncover some issues
>> relating to the enabled-no-policy case, those are much less
>> interesting and less relevant than the loaded-policy case.
> 
> I had thought that they had switched over to at least loading a policy 
> but possibly left it in permissive mode because the base distribution 
> didn't properly support SELinux out of the box.  But I may be mistaken.
> Regardless, the right solution is to migrate to testing with a policy 
> loaded not to stop testing altogether.
> 
> Optimally, they'd test on at least one distribution/OS where SELinux is 
> in fact supported out of the box, e.g. CentOS, Android, and/or ChromeOS.

Or Fedora, of course.
