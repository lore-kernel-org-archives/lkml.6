Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC907C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C82920843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C82920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeIDTwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:52:36 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:62028 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:52:35 -0400
X-EEMSG-check-008: 311772770|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Sep 2018 15:26:52 +0000
X-IronPort-AV: E=Sophos;i="5.53,329,1531785600"; 
   d="scan'208";a="17757831"
IronPort-PHdr: =?us-ascii?q?9a23=3AQ66kGBGzNAYyJuSR/HwwmJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76oM24bnLW6fgltlLVR4KTs6sC17KJ9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa/bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Ses4URX?=
 =?us-ascii?q?daXsZJSSNOHp+8YYUID+oEJ+lYro/9rEYKoRaxAQSgAeXixTFShn/ywKY0ze?=
 =?us-ascii?q?IvHw/b1wAkBt4DsXHYodPoP6kQTO+11rHFwyjdYfNY2Tnz64bGfR4urv6OQb?=
 =?us-ascii?q?1+ftHcyVUtGg7fklmctYLoMjGT2+8Qs2ab9e1gVee3hmA6twF+vCCvxscyhY?=
 =?us-ascii?q?nPm4kb11XE+j99wIYxO9K5SFNwbNm/EJRNrCGXLJd2Q8M+TGFovyY20LsGuY?=
 =?us-ascii?q?WhcyQQx5QnwADfZuWBfoOV7BzjU+ORLi15hHJjYL+/gxWy8U2kyuHmUcm0yl?=
 =?us-ascii?q?lKojJKktnNqnAN1wHT5dOdRvRh+Ueh3C6D2BrL6uFcOkA0ja3bK4I7zrEskZ?=
 =?us-ascii?q?oTtELOFTL1lkXulKKaa0op9+ey5+nnf7nqvIGQOoBqhg3kL6gjnNG0D/4iPQ?=
 =?us-ascii?q?gURWeb/Pyx1Ljk/ULkXrpHluY2kqzFsJDCIsQbu7K5DxdV0ok97xa/CC+r0M?=
 =?us-ascii?q?gCknkdLVJFZQmHg5LoO1HILvD4Cuy/jEqwnztx2/DHPqHuApXKLnTZlrfuYa?=
 =?us-ascii?q?195FJGxAo2zNBf44pYCrAHIP3tRk/8rMHUAxA2PgCuw+vrFc9x2p0RVG6RGK?=
 =?us-ascii?q?OVLbvesVqS6eIuJ+mMapUVuDH4K/U9/P7hkGQ5lEQBfaipwZQXaHe4Eu5gI0?=
 =?us-ascii?q?WCe3XgmNgBEWAUvgYmVuzllEWCUSJPZ3a1R68z+y87CYK7DYfAQYCtnqeM3C?=
 =?us-ascii?q?i8Hp1RaWBGDk6DHW30eIWDXvcGcDiSLdN5kjwYSbihTJcs1Qm0uw/nz7pqNf?=
 =?us-ascii?q?LU9TcFtZLnzdR14urTlRYo9TNqFciSz2aNT2RslGMSWzA2xLx/oVB6ylqbyq?=
 =?us-ascii?q?h5g/1ZGsdU5/NVVQs2K4PQw/BnB93zRw7McMuFR026TtimAjw9Usg+ztsTbE?=
 =?us-ascii?q?ljFditlRDO0jGxA74Vlr2LB4Y78qbY33fvPcZx0WzJ1LE5j1k9WstPMnGmhq?=
 =?us-ascii?q?tl+AjSA47FiVmWl6Gvda4Exi7C6H+DzXaSvEFfSANwTaXEXXAeZkTKrtT5/V?=
 =?us-ascii?q?jPQKO0BrQhNQtBz8+CJbdQZd3tl1lJWPDjONHGaWKrh2iwHQqIxq+LbIfyeW?=
 =?us-ascii?q?Ud2yXdCE4enwAR+naGNRIxBiG6o23ACjxjDk7gbFnq8el5rnO7T1M7wBuOb0?=
 =?us-ascii?q?F7y7W1/RsVj+SGS/wPxrIEpDshqzJsEVa/2tLWDMCApxBgfKVHet495k1I1W?=
 =?us-ascii?q?fHuAx8JJCgKLpihlEGeQRto0zuzwl3CplHkcUyqHMqzQxyKb+X0V9YdDOXw4?=
 =?us-ascii?q?rwOrvJJWn25x2vdaHW1U/E0NqM+acA9u44q1P9swGtDEYi9G9n09ZN2XuG+p?=
 =?us-ascii?q?rKFBYSUY72Uksv8xh6prfaYjQy5o/Nzn1jL7W7siLY29IoGOskyg+sf9JYMK?=
 =?us-ascii?q?yZCQ/yF9MVCtOwKOwlhVepdAgIPONM+64uOcOpaf+G1LSsPOZ6kzKslX5H75?=
 =?us-ascii?q?xl0kKQ6yp8TfbF340bzPGC0QuISSzxjFe7vcDznYBFZTcSEnCjxijjAY5bfr?=
 =?us-ascii?q?dycpoTCWeyP823wc1zh4XtWn9Z916sHVcG2Mu3dhqIdlDyxhBQ1UsMoXG8li?=
 =?us-ascii?q?u4yDt0kz4trqWB0yzO2ePidAcfOm5QXmVtkVDsIY2shdAAQEeodxQplAei5U?=
 =?us-ascii?q?vixahUuqp/L2fNQUpTcCj2KGZiUqS0trWcecJA9JQosSBPWuSmfV+aUqL9ow?=
 =?us-ascii?q?cd0y77BWte2Ss7dyq0tZX9mxx3k36SLHFwrHXHY8F83wvQ5NvZRfJLxDUGWT?=
 =?us-ascii?q?FyiSPLCVikI9mp4dKUmo/YveC/WGKhUZtTfDL2woyeryS75HdlARulk/C0gN?=
 =?us-ascii?q?3nHlty7Siu+9xrST/Z5Cjtf4rsyezuPfx2Y0pvGnfz7M11How4mYw10sI+w3?=
 =?us-ascii?q?8f066J8GIHnGG7CtBS3abzfTJZXjIQ68LE6wjinkt4JzSGwJyvBSbV+ddoe9?=
 =?us-ascii?q?TvOjBe4Sk69c0fTfrL4Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ALBQAQo45b/wHyM5BaEwEBBwEBAQQBAQoBAYMkgQ9tE?=
 =?us-ascii?q?iiDcohxjBwBAQEBAQEGgRAleIdriHKGUjCEAUYCg1Y3FQECAQEBAQEBAgFsH?=
 =?us-ascii?q?AyCNSSCXgEBAQECASMVQRALDgoCAiYCAlcGDQYCAQEQB4JHPwGBdAUID6M1g?=
 =?us-ascii?q?S6ELgE9hQwFgQuJZHmBB4ESJwyCKjWDAhkBAQIYhEiCVwKNcY1lCYY0iT8GF?=
 =?us-ascii?q?4FAhDeIYiuKfIoVIjSBISsIAhgIIQ87gmwfggYXg0WFFIVaIzABCY0kAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Sep 2018 15:26:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w84FQbV4001506;
        Tue, 4 Sep 2018 11:26:37 -0400
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        "russell@coker.com.au" <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>
References: <000000000000c178e305749daba4@google.com>
 <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
 <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov>
 <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
 <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov>
Date:   Tue, 4 Sep 2018 11:28:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 11:02 AM, Dmitry Vyukov wrote:
> On Tue, Sep 4, 2018 at 2:57 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>>>> <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> syzbot found the following crash on:
>>>>>>>>>
>>>>>>>>> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
>>>>>>>>> git tree:       net-next
>>>>>>>>> console output:
>>>>>>>>> https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
>>>>>>>>> kernel config:
>>>>>>>>> https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>>>>>>>>> dashboard link:
>>>>>>>>> https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
>>>>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>>>>
>>>>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>>>>
>>>>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the
>>>>>>>>> commit:
>>>>>>>>> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Hi John, Tyler,
>>>>>>>>
>>>>>>>> I've switched syzbot from selinux to apparmor as we discussed on lss:
>>>>>>>>
>>>>>>>>
>>>>>>>> https://github.com/google/syzkaller/commit/2c6cb254ae6c06f61e3aba21bb89ffb05b5db946
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Sorry, does this mean that you are no longer testing selinux via
>>>>>>> syzbot?
>>>>>>>      That seems unfortunate.  SELinux is default-enabled and used in
>>>>>>> Fedora, RHEL and all derivatives (e.g. CentOS), and mandatory in
>>>>>>> Android
>>>>>>> (and seemingly getting some use in ChromeOS now as well, at least for
>>>>>>> the Android container and possibly wider), so it seems unwise to drop
>>>>>>> it
>>>>>>> from your testing altogether.  I was under the impression that you
>>>>>>> were
>>>>>>> just going to add apparmor to your testing matrix, not drop selinux
>>>>>>> altogether.
>>>>>>
>>>>>>
>>>>>>
>>>>>> It is also important to note that testing with SELinux enabled but no
>>>>>> policy loaded is not going to be very helpful (last we talked that is
>>>>>> what syzbot is/was doing).  While syzbot did uncover some issues
>>>>>> relating to the enabled-no-policy case, those are much less
>>>>>> interesting and less relevant than the loaded-policy case.
>>>>>
>>>>>
>>>>>
>>>>> I had thought that they had switched over to at least loading a policy
>>>>> but
>>>>> possibly left it in permissive mode because the base distribution didn't
>>>>> properly support SELinux out of the box.  But I may be mistaken.
>>>>> Regardless, the right solution is to migrate to testing with a policy
>>>>> loaded not to stop testing altogether.
>>>>>
>>>>> Optimally, they'd test on at least one distribution/OS where SELinux is
>>>>> in
>>>>> fact supported out of the box, e.g. CentOS, Android, and/or ChromeOS.
>>>>
>>>>
>>>>
>>>> Or Fedora, of course.
>>>
>>>
>>> Hi,
>>>
>>> Yes, we switched from selinux to apparmor. The thing is that we
>>> effectively did not test selinux lately, so it's more like just
>>> enabling apparmor rather than disabling selinux.
>>>
>>> The story goes as follows.
>>> We enabled selinux, but did not have policy and selinux wasn't enabled.
>>> Then Paul (I think) pointer that out. After some debugging I figured
>>> out that our debian wheezy actually has a policy, it's just that
>>> selinux utilities were not installed, so init could not load the
>>> policy.
>>> I installed the tools, and we started loading policy.
>>> But then it turned out that wheezy policy does not allows mounting
>>> cgroup2 fs and maybe some others even in non-enforcing mode. As far as
>>> I understand that's because the policy does not have definition for
>>> the fs, and so loading bails out with an error.
>>> We need cgroup2 both for testing and for better sandboxing (no other
>>> way to restrict e.g. memory consumption). Moreover, we did not test
>>> any actual interesting interactions with selinux (there must be some?
>>> but I don't know what are they).
>>> So I had to uninstall the tool and policy is not loaded again.
>>> I investigated building a newer debian image with debootstrap (which
>>> should have newer policy I guess). But they don't work, some cryptic
>>> errors in init. Other people reported the same.
>>> So that's we are. I don't have any ideas left...
>>
>>
>> So why not ask for help from the SELinux community? I've cc'd the selinux
>> list and a couple of folks involved in Debian selinux.  I see a couple of
>> options but I don't know your constraints for syzbot:
>>
>> 1) Run an instance of syzbot on a distro that supports SELinux enabled out
>> of the box like Fedora. Then you don't have to fight with SELinux and can
>> just focus on syzbot, while still testing SELinux enabled and enforcing.
>>
>> 2) Report the problems you are having with enabling SELinux on newer Debian
>> to the selinux list and/or the Debian selinux package maintainers so that
>> someone can help you resolve them.
>>
>> 3) Back-port the cgroup2 policy definitions to your wheezy policy, rebuild
>> it, and install that.  We could help provide guidance on that. I think
>> you'll need to rebuild the base policy on wheezy; in distributions with
>> modern SELinux userspace, one could do it just by adding a CIL module
>> locally.
> 
> Thanks, Stephen!
> 
> I would like to understand first if failing mount(2) for unknown fs is
> selinux bug or not. Because if it is and it is fixed, then it would
> resolve the problem without actually doing anything (well, at least on
> our side :)).

Yes, I think that's a selinux kernel regression, previously reported here:
https://lkml.org/lkml/2017/10/6/658

Unfortunately I don't think it has been fixed upstream.  Generally 
people using SELinux with a newer kernel are also using a newer policy. 
That said, I agree it is a regression and ought to be fixed.

>> As for exercising SELinux, you'll exercise SELinux just by enabling it and
>> loading a policy, since it will perform permission checking on all object
>> accesses.   But you can get more extensive coverage by running the
>> selinux-testsuite.  We only test that on Fedora and RHEL however, so getting
>> it to work on Debian might take some effort.
> 
> That's good.
> I just thought that there is some potential in making the policy
> interact more with what the fuzzer does. With respect to fs accesses,
> it works within own temp directory, and I guess the policy is actually
> all the same for everything it does in that directory. There also may
> be something related to extended attributes, context changes, etc?

Yes, by default, your fuzzer is going to just run in a single security 
context and all files it creates will have a single security context. 
So the policy side of things won't be interesting and probably 
everything will be allowed (if it runs in the unconfined context), but 
you'll still exercise many code paths.  The selinux-testsuite would 
trigger many process context changes and create files under varying 
contexts, so that would be more complete in its coverage.
