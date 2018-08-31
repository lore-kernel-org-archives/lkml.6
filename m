Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5B5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66642077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66642077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeHaUc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:32:26 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:38679 "EHLO
        UCOL19PA13_EEMSG_MP11.csd.disa.mil" rhost-flags-OK-OK-FAIL-FAIL)
        by vger.kernel.org with ESMTP id S1727268AbeHaUcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:32:25 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Aug 2018 16:32:24 EDT
X-EEMSG-check-008: 618668559|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.53,312,1531785600"; 
   d="scan'208";a="618668559"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA13_EEMSG_MP11.csd.disa.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 Aug 2018 16:14:26 +0000
X-IronPort-AV: E=Sophos;i="5.53,312,1531785600"; 
   d="scan'208";a="15418056"
IronPort-PHdr: =?us-ascii?q?9a23=3AJtqhpxY9kO2Cx/G4F9k4Tf7/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsq7ZB7h7PlgxGXEQZ/co6odzbaO7Oa4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahY75+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQctQHS2?=
 =?us-ascii?q?pcRcZRTzJODZ+gb4UBCOoBOPxXr4j7p1ATqRezCg2hCObpxzBGnH/22bAx3f?=
 =?us-ascii?q?onHw/IwQcsG8sCvGnIoNnwMqoZTOK7w7TSzTjbcv1Yxzn95ojLfB4vr/6DUr?=
 =?us-ascii?q?B/ftbex0Q0CwPIjE+dpZD5Mz6b1OkAtXWQ4ep6VeKojm4qsxx/oiSxycc0io?=
 =?us-ascii?q?nGmIQVwU3Z+yV82ok1Idm4R1B7YNW5F5ZQrDyVN5BtT8M+Q2BnpCY6yroctZ?=
 =?us-ascii?q?69ZygF0o4rxxHYa/yZaoWF5A/oWuiWITd9nn1lebS/ig698Uih1u38VtS030?=
 =?us-ascii?q?1QoiVZldnMs2gB2AbL6sifUft95kCh2SqV2w/P7eFEJEY5nrfYJZ452rM8i5?=
 =?us-ascii?q?UevEvZEiL2hUn6lrGae0o69uSy9ujqZKjtqIWGOI9ukA7+N7wjmsm4AeslLA?=
 =?us-ascii?q?cDR3Ob+eGg1L37+k35XalKguU2kqbHtJDaItwWprKjDA9P04Yj9g2/Ay2n0N?=
 =?us-ascii?q?Qek3kHK0lFdwybgITzJ1HPIOz3Dfe4g1i2ljdk2+vGMaH7DpXIL3jDlK/tfb?=
 =?us-ascii?q?d760FC1Ao+1c1T6p1bB70bIP//R1X9uMLXAxMnKQC43v7rCNBn2YMfXWKPDL?=
 =?us-ascii?q?WZMKTXsVKQ/eIgPvKMaZQJuDf9N/cl5/nugWU/mV8GZ6alx5QXaHemHvh+OU?=
 =?us-ascii?q?WWfWLsgssdEWcNpgc+VPbliECGUTNIf3a9Rb885jUiBIKjCofDQZqtj6Kb0C?=
 =?us-ascii?q?inGZ1WY3hMCkqQHnfwa4WER/AMZTqPLc9/kj0ESLuhS4g/1Ry1uw/6zL1nLu?=
 =?us-ascii?q?XQ+iIGr57syN915+jLnxEo6TN0F9id032KT2xshWMJRz4307t4oUxhzVuPz7?=
 =?us-ascii?q?V0j+BFGdFS+v9EXBs2OoXAw+F6CN3+RhjOc9OUR1m4TNipGjE8Q8kqw94OYk?=
 =?us-ascii?q?d9GM+tjhTH3yW0Gb8ZjaaEBIQs8qLHx3jxINp9y3Pc26kgi1kqWNdANWqjhq?=
 =?us-ascii?q?Rn7QjcG5bJk1mFl6atbakcwC7M9GeCzWWSv0FYSxV9XrnfUnAZYUvWq9X56V?=
 =?us-ascii?q?/YQL+qE7goLgxBycuaIKtQdtLplUlGROvkONnGYWKxnGewBRCSyrOOa4rqe3?=
 =?us-ascii?q?8S3CPGCEcalQAe5mqJOhI4BiempWLeDSBhGkjrY0/27eZ+r3a7RFcuzw6Wd0?=
 =?us-ascii?q?1hy6a1+hkNiPyeTvMT2agEuD0gqzVvB1u92cjZC9+eqApgZqlcZsk94Fhf32?=
 =?us-ascii?q?LDqwN9JoCgL7xlhlMGdwR3vkXu1wh4C4lZksglsmkqzAxsJqKcy15BaTyY0o?=
 =?us-ascii?q?7qOrHNKWn94gqva6jI1VHaytqW/b0P6PsgoVX5oA6pDlYi82lg09RN13uc55?=
 =?us-ascii?q?PKDBcdUJ7oSUY46QR1p6zAYik8+4PV1WRgMayzsjDfxtIpAPUqxw2+f9dQLq?=
 =?us-ascii?q?yEDhX+E84ECMi0LuwlhVypYggDPOBI+64+J9mmeOee2K63IOZgmyqrjX9Z74?=
 =?us-ascii?q?Bn3UKD6TFxSu7S0JYBx/GZ3g2HWy3gg1emt8D9gZpEai0KHmqj1SjkA5ZcZr?=
 =?us-ascii?q?ZyfIcKCmehOcm3xtFgiJ73QnJX70OjB1wd2MKydhqSaFv93QJU1UsJrnyngy?=
 =?us-ascii?q?y4zyFskzEytKaQwCvOw+H6fhodJmFLXHVijUvrIYWsjdAVQkaobwY3lBa+6k?=
 =?us-ascii?q?b6wK9bpKt7L2bNW0tHYy/2L2QxGpe344KLfsoHzZQvqygfBPy1fFSyUrfgp1?=
 =?us-ascii?q?4f1CT5Ei1VwzVtM3mmpITknBtkoG2aK3l3oTzSfsQj6w3Y4YnnWfNJ3jcADB?=
 =?us-ascii?q?J9gD3TC0n0a8Kl5v2IhpzDtaa4TGvnWZpNJ3q4hbicvTe2sDU5SSa0mOq+z5?=
 =?us-ascii?q?i5SAU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BAAgDLaIlb/wHyM5BaEwEBBQEBAQEBAgEBAQEIAQEBA?=
 =?us-ascii?q?YMfBYEPbRIog3KIcIwgBoEILYhiiHKGUjCEAUYCg003FQECAQEBAQEBAgFsH?=
 =?us-ascii?q?AyCNSSCXwEFIxVBEAsYAgImAgJXBgEMBgIBAReCRT8BgXQND6NEgS6ELQE9h?=
 =?us-ascii?q?RQFgQuJKHmBB4ESJ4JrgxsCAhiESIJXAo1xjWUJhjSJPwYXgUCEN4hiK4p8i?=
 =?us-ascii?q?hUiNIEhKwgCGAghD4MngiUXg0WKbiMwAQmOHgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 31 Aug 2018 16:14:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7VGEMRu007414;
        Fri, 31 Aug 2018 12:14:23 -0400
Subject: Re: WARNING in apparmor_secid_to_secctx
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov>
Date:   Fri, 31 Aug 2018 12:16:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 12:07 PM, Paul Moore wrote:
> On Fri, Aug 31, 2018 at 12:01 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 08/29/2018 10:21 PM, Dmitry Vyukov wrote:
>>> On Wed, Aug 29, 2018 at 7:17 PM, syzbot
>>> <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com> wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
>>>> git tree:       net-next
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>
>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>
>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
>>>
>>> Hi John, Tyler,
>>>
>>> I've switched syzbot from selinux to apparmor as we discussed on lss:
>>> https://github.com/google/syzkaller/commit/2c6cb254ae6c06f61e3aba21bb89ffb05b5db946
>>
>> Sorry, does this mean that you are no longer testing selinux via syzbot?
>>    That seems unfortunate.  SELinux is default-enabled and used in
>> Fedora, RHEL and all derivatives (e.g. CentOS), and mandatory in Android
>> (and seemingly getting some use in ChromeOS now as well, at least for
>> the Android container and possibly wider), so it seems unwise to drop it
>> from your testing altogether.  I was under the impression that you were
>> just going to add apparmor to your testing matrix, not drop selinux
>> altogether.
> 
> It is also important to note that testing with SELinux enabled but no
> policy loaded is not going to be very helpful (last we talked that is
> what syzbot is/was doing).  While syzbot did uncover some issues
> relating to the enabled-no-policy case, those are much less
> interesting and less relevant than the loaded-policy case.

I had thought that they had switched over to at least loading a policy 
but possibly left it in permissive mode because the base distribution 
didn't properly support SELinux out of the box.  But I may be mistaken.
Regardless, the right solution is to migrate to testing with a policy 
loaded not to stop testing altogether.

Optimally, they'd test on at least one distribution/OS where SELinux is 
in fact supported out of the box, e.g. CentOS, Android, and/or ChromeOS.
