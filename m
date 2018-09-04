Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B26C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527BF2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527BF2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeIDRVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:21:04 -0400
Received: from uhil19pa13.eemsg.mail.mil ([214.24.21.86]:53445 "EHLO
        UHIL19PA13_EEMSG_MP11.csd.disa.mil" rhost-flags-OK-OK-FAIL-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbeIDRVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:21:04 -0400
X-EEMSG-check-008: 319601163|UHIL19PA13_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA13_EEMSG_MP11.csd.disa.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Sep 2018 12:55:40 +0000
X-IronPort-AV: E=Sophos;i="5.53,329,1531785600"; 
   d="scan'208";a="17746233"
IronPort-PHdr: =?us-ascii?q?9a23=3A70FYnh2TnHh37+tPsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesQI/rxwZ3uMQTl6Ol3ixeRBMOHs60C07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwdFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfV5Y63dYMgaRX?=
 =?us-ascii?q?JfUclNSyxPDIS8b44VAOoAO+ZTso3xqlQKoBe7AwSjCvnvyjtVjXHo26M03f?=
 =?us-ascii?q?kqHQXf0AA9A94CtXLZp8j3OqgPS+C41LTGwyvNb/1W2jnz5obHfR8jrv6QUr?=
 =?us-ascii?q?x9atbRxEs1Gg/Zklmdp47oMjWI3eoNqWib6O9gWPqyhW47tQ5xujivydkqio?=
 =?us-ascii?q?LUm4wVz0rL9SF9wIkrJdyzVUl2YcW5H5tLrCyaK4t3Td8iQ2Fvoio6zKYGto?=
 =?us-ascii?q?ShcCgFz5Qn2QfSZvqaeIaG5RLjUfyeITZ+hH99d7K/hgqy8Ui9yuLnTMW7zF?=
 =?us-ascii?q?FKri9dntbWrnANzwfT6tCASvth5EuuxTGP1wXV5+pZIk40jbLWJ4Muz7M/jJ?=
 =?us-ascii?q?YesVnPEjXolEj5kqOabFgo9+614Or9eLrmvIWTN4pshwH7NaQhh9KwDPwjMg?=
 =?us-ascii?q?gLQ2ib4eO81KD//UHhQLVFkPk2kq7BvZDGP8sbvK+5AxJO0oo56ha/CTmm0N?=
 =?us-ascii?q?MDnXYZMF1JYg6Hjoj1NFHOJ/D0F/G/jEi3kDh33fzGO7zhApHVInjClrfuY6?=
 =?us-ascii?q?p95lZBxAc8wt1T/ZJZBqwbLP7tVUL9qsbUAgIhPwyx2ennCdF91o0EWWKIB6?=
 =?us-ascii?q?+UKLjSvkKT5u80P+mNZJMauDb6K/Q/4f7ulmU2lUUSfamuw5sbcGq4Eeh+I0?=
 =?us-ascii?q?WFfXrshc8MHnoUvgs+Uezqi1qCUSBIana9WKI84T47CIa4AovZWo+th7mB1j?=
 =?us-ascii?q?+hHpJKfmBGFkyMEXDweoWcQfgMdSaSL9R5kjMeSLihT5Yt1RSptA/90bpoMP?=
 =?us-ascii?q?DY9TEftZLmzNJ1/fHclQku9TxoCMSQy3qNTmF1n2wTQD82wKdzrVJgxlufzK?=
 =?us-ascii?q?R1guFUGNJP6/xSTgs3NZ3Rw/BgBN32Rw3OYNmER02mT9i9GjEwTtMww9wUbE?=
 =?us-ascii?q?Z5H9WtkArD0zCwDL8Nj7yLH4Q08qXA33j0Pcl9ynLG2LM9gFkhR8tFLXemib?=
 =?us-ascii?q?Jn9wjPG47JlF2Ul7qqdKQc3S7C6GSDzXGVsU5ESgFwV6LFXXYeZkTKt9v54l?=
 =?us-ascii?q?nOQKOpCbQiKgFB09KNKrNWat31ilVLXPXjONPeY2K3gWuwBxGIxrOWY4rsYG?=
 =?us-ascii?q?USwiPdBVMYnA8J+3aGMg4+Bia9rG3ECDxiD07gY0Tp8eNmsnO0Ulc0zx2Wb0?=
 =?us-ascii?q?1mz7e1+BsVhfuGS/MJ37IEozwsqzNuE1a4wd3WCsCMpw17fKVTedk9+ktI1X?=
 =?us-ascii?q?rFtwxhOZytN6Rihl8YcwRqsELizhZ3BZtakcgssnwqyBF/KbyX0FxfbTOUx5?=
 =?us-ascii?q?PwNaPNKmn04h+vb7Ta2lbE0NaZ4q0P8ug3q03/vAG1EUov63Fn09hT03uB6Z?=
 =?us-ascii?q?TGFRESXoztXUYq7Rh6pq3aYykk64PR0n1jLLS0sjvc1N8yGuslxQivf81FPK?=
 =?us-ascii?q?OHCgDyCcsaCNaqKOAwnFipdB0ENvhI9KEoJ8Oma+eG2KmzMeZ7gj2ml2tH75?=
 =?us-ascii?q?5m30KM7SV8TurI3pYDw/2CwgSHUDL8hk+7ss/rgYBEeS0SHm2nxCj/BI9QZ6?=
 =?us-ascii?q?5ycpwPCWeqPcK33MxyiIXwW35X716uHFwG2MiueRqda1zywwJQ1V4QoXy6gS?=
 =?us-ascii?q?u41CZ4nC0urqqaxCbO2fjtdAIbOm5XQ2lvlVXsLpa6j9AUQkildAcplByi5U?=
 =?us-ascii?q?b1w6hUur5zIHXUQUdNZyL2NX1tUrOstrqeZM5C8IkosThMUOSnf1+aTrr9rg?=
 =?us-ascii?q?AG3CPkHGtR2io7eyu2tZX+mhx2kniSLGtrpnrDZc5w3Qvf5MDbRfNJxTUGRS?=
 =?us-ascii?q?Z4iT7RBlWnItam486bl5bZveC4TW6hUYdTcSa4hb+H4Qe+5HFwEFWBju2wnc?=
 =?us-ascii?q?OvRQQkwDL40MdCWiLPoxLxJILs0vLpH/hgexxTGFLk68d8Urp7m480iYBYjW?=
 =?us-ascii?q?MWnb2J7HEHliH1Ktwd1qXgOileDQUXysLYtVC2kHZoKWiEksenD3g=3D?=
X-IPAS-Result: =?us-ascii?q?A2CkAwCxf45b/wHyM5BaEwEBBgEBAQEDAQEBCQEBAYMfB?=
 =?us-ascii?q?YEPbRIog3KIcYwiBoEQJXiHa4hyhFiBejCEAUYCg2A2FgECAQEBAQEBAgFsH?=
 =?us-ascii?q?AyCNSSCXwEFIxVBEAsOCgICJgICVwYNBgIBARAHgkc/AYF0DQ+jFoEuhC4BP?=
 =?us-ascii?q?YULBYELiWR5gQeBEicMgio1gxsCAhiESIJXAo1xjWUJhjSJPwYXgUCEN4hiK?=
 =?us-ascii?q?4p8igYCLzSBISsIAhgIIQ87gmyCJReDRYpuIzABCY0lAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Sep 2018 12:55:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w84CtEcg013103;
        Tue, 4 Sep 2018 08:55:17 -0400
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
Date:   Tue, 4 Sep 2018 08:57:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 06:38 PM, Dmitry Vyukov wrote:
> On Fri, Aug 31, 2018 at 9:17 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 08/31/2018 12:16 PM, Stephen Smalley wrote:
>>>
>>> On 08/31/2018 12:07 PM, Paul Moore wrote:
>>>>
>>>> On Fri, Aug 31, 2018 at 12:01 PM Stephen Smalley <sds@tycho.nsa.gov>
>>>> wrote:
>>>>>
>>>>> On 08/29/2018 10:21 PM, Dmitry Vyukov wrote:
>>>>>>
>>>>>> On Wed, Aug 29, 2018 at 7:17 PM, syzbot
>>>>>> <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com> wrote:
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> syzbot found the following crash on:
>>>>>>>
>>>>>>> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
>>>>>>> git tree:       net-next
>>>>>>> console output:
>>>>>>> https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
>>>>>>> kernel config:
>>>>>>> https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>>>>>>> dashboard link:
>>>>>>> https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
>>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>>
>>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>>
>>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the
>>>>>>> commit:
>>>>>>> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
>>>>>>
>>>>>>
>>>>>> Hi John, Tyler,
>>>>>>
>>>>>> I've switched syzbot from selinux to apparmor as we discussed on lss:
>>>>>>
>>>>>> https://github.com/google/syzkaller/commit/2c6cb254ae6c06f61e3aba21bb89ffb05b5db946
>>>>>
>>>>>
>>>>> Sorry, does this mean that you are no longer testing selinux via syzbot?
>>>>>     That seems unfortunate.  SELinux is default-enabled and used in
>>>>> Fedora, RHEL and all derivatives (e.g. CentOS), and mandatory in Android
>>>>> (and seemingly getting some use in ChromeOS now as well, at least for
>>>>> the Android container and possibly wider), so it seems unwise to drop it
>>>>> from your testing altogether.  I was under the impression that you were
>>>>> just going to add apparmor to your testing matrix, not drop selinux
>>>>> altogether.
>>>>
>>>>
>>>> It is also important to note that testing with SELinux enabled but no
>>>> policy loaded is not going to be very helpful (last we talked that is
>>>> what syzbot is/was doing).  While syzbot did uncover some issues
>>>> relating to the enabled-no-policy case, those are much less
>>>> interesting and less relevant than the loaded-policy case.
>>>
>>>
>>> I had thought that they had switched over to at least loading a policy but
>>> possibly left it in permissive mode because the base distribution didn't
>>> properly support SELinux out of the box.  But I may be mistaken.
>>> Regardless, the right solution is to migrate to testing with a policy
>>> loaded not to stop testing altogether.
>>>
>>> Optimally, they'd test on at least one distribution/OS where SELinux is in
>>> fact supported out of the box, e.g. CentOS, Android, and/or ChromeOS.
>>
>>
>> Or Fedora, of course.
> 
> Hi,
> 
> Yes, we switched from selinux to apparmor. The thing is that we
> effectively did not test selinux lately, so it's more like just
> enabling apparmor rather than disabling selinux.
> 
> The story goes as follows.
> We enabled selinux, but did not have policy and selinux wasn't enabled.
> Then Paul (I think) pointer that out. After some debugging I figured
> out that our debian wheezy actually has a policy, it's just that
> selinux utilities were not installed, so init could not load the
> policy.
> I installed the tools, and we started loading policy.
> But then it turned out that wheezy policy does not allows mounting
> cgroup2 fs and maybe some others even in non-enforcing mode. As far as
> I understand that's because the policy does not have definition for
> the fs, and so loading bails out with an error.
> We need cgroup2 both for testing and for better sandboxing (no other
> way to restrict e.g. memory consumption). Moreover, we did not test
> any actual interesting interactions with selinux (there must be some?
> but I don't know what are they).
> So I had to uninstall the tool and policy is not loaded again.
> I investigated building a newer debian image with debootstrap (which
> should have newer policy I guess). But they don't work, some cryptic
> errors in init. Other people reported the same.
> So that's we are. I don't have any ideas left...

So why not ask for help from the SELinux community?  I've cc'd the 
selinux list and a couple of folks involved in Debian selinux.  I see a 
couple of options but I don't know your constraints for syzbot:

1) Run an instance of syzbot on a distro that supports SELinux enabled 
out of the box like Fedora. Then you don't have to fight with SELinux 
and can just focus on syzbot, while still testing SELinux enabled and 
enforcing.

2) Report the problems you are having with enabling SELinux on newer 
Debian to the selinux list and/or the Debian selinux package maintainers 
so that someone can help you resolve them.

3) Back-port the cgroup2 policy definitions to your wheezy policy, 
rebuild it, and install that.  We could help provide guidance on that. 
I think you'll need to rebuild the base policy on wheezy; in 
distributions with modern SELinux userspace, one could do it just by 
adding a CIL module locally.

As for exercising SELinux, you'll exercise SELinux just by enabling it 
and loading a policy, since it will perform permission checking on all 
object accesses.   But you can get more extensive coverage by running 
the selinux-testsuite.  We only test that on Fedora and RHEL however, so 
getting it to work on Debian might take some effort.
