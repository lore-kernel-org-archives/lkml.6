Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0486C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C23B2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C23B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeIDV0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:26:40 -0400
Received: from uhil19pa10.eemsg.mail.mil ([214.24.21.83]:49555 "EHLO
        uhil19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeIDV0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:26:39 -0400
X-EEMSG-check-008: 332928334|UHIL19PA10_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Sep 2018 17:00:34 +0000
X-IronPort-AV: E=Sophos;i="5.53,329,1531785600"; 
   d="scan'208";a="15481024"
IronPort-PHdr: =?us-ascii?q?9a23=3AS7KgvxywWRRoBJjXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uwUI/ad9pjvdHbS+e9qxAeQG9mDtLQc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYQhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcpcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98MqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1b9mkEJ5KuCGbMYt7WsciQ2JtuCY+0LEGvo?=
 =?us-ascii?q?S7fCcMxZ86xBDfc+SKf5WH7x/sTuqcISp0iGh7dL+wmRq+61Wsx+vhXceuyl?=
 =?us-ascii?q?lKtDBKktzUu3AI0Bzc99aIR+Nm/kekxTaPzwfT6vxYIUwslarUNZohwrkom5?=
 =?us-ascii?q?oPq0vDBC72mFjtjKOMd0Uk/Oao6+P8Yrr4upCQLZN0iwHiPaQuncyzG+I4PR?=
 =?us-ascii?q?QVX2eH4+i80bzj/UnhTLVLiP05jLXZvYjHKckUqaO1GQ9Y3ps55xqhADqqzs?=
 =?us-ascii?q?4UkWQfIFJAYh2HjozpO1/UIPD/CPeym0+snypwx/3dIr3gAonCLnjEkLv7e7?=
 =?us-ascii?q?Z98FRTxBA8zdBY+ZJYEqsBL+7rWk/tqNzYCQc0PBGqw+fnFdV91YQeWXyUD6?=
 =?us-ascii?q?+WN6PStlCI5uYxLOWWeIAVvzP9IeA/5/HylX85hUMdfa6x0JsPcn+4A/BmLl?=
 =?us-ascii?q?6BYXX2n9cBFX4Gvg85TOztkl2NTyRfaGq1X6I5/js7Ep6pDZ/fRoCxh7yMxD?=
 =?us-ascii?q?y7H51XZ29dDVCMDXDke5uZV/sQdS6fI9JtnzIYWbe6V4Ms1RKjuBPgxLdjM+?=
 =?us-ascii?q?Xb5CMVuonj2dVu/O3SlRAz9T9uAMSZ12GCUXt0knkSSD8uxKB/ulR9ylCf0a?=
 =?us-ascii?q?h9mfNYFNhT6+lVXQc9MJ7W1/Z6BMzqWgLdYteJT06rQsmmADExT9I+39wOY1?=
 =?us-ascii?q?1mFtq+lB/D2S2qA7kUl7OXHpM09rjQ0GT2J8Z403zGzrUuj0E6QstTMm2rnq?=
 =?us-ascii?q?x/9w/TB47PiUmZlaGqdaQG0y7L72eM02yOsVpEXwFqV6XFWnYfZkrKotvj4k?=
 =?us-ascii?q?POVaOhCbMiMgFZ086NNrNKasH1jVVBXPrjOtHeY2Wrm2eqBBaI3aiBbIzwdG?=
 =?us-ascii?q?UYwirdCVIIkwcJ/XaJLQI+HDuuo3rCDDxyElLie0fs8eh4qHOmQU441gKKYF?=
 =?us-ascii?q?N717qz5BEVgeeRS+0c3r0aoictsTZ0E0in39LQFdWAoxBtfKJGYdMy+F1Hz3?=
 =?us-ascii?q?7WtxRhPpy8KKBvnloecwVxv0Pz2BR7E55AntY2o3M31gpyKL6Y0VNYezOd2p?=
 =?us-ascii?q?D/J6DXKm3s8x20da7W1U/R0MyM9qcM9vs4sVPjsx+tFkY49HVnydZV2WOG5p?=
 =?us-ascii?q?rWFAoSTY7xUkEv+hhhub7aeCY96J3P2H1sK6a0tjvC2tIvBOc/1hmgeNJfOr?=
 =?us-ascii?q?ueFADuC80aG9SuKOsylliybhMFPeNS+7QwP8OiafSGwrenM/19nDKplmRK+4?=
 =?us-ascii?q?990kWL9ypzTu7HwZkFw+uf3guaTzf8l02tvdzwmYBBfTsSBHawyTD4BI5NYa?=
 =?us-ascii?q?1/ZYQLBnmgI8252NVznJHtW3lf9F6sA1MJxtWldgaVb1z4xQdQz1gYoWS7mS?=
 =?us-ascii?q?ukyDx5iysprreE3CzV3evicB4HN3VXS2lljlfjP5K0g8oGU0ivaggljgGq5V?=
 =?us-ascii?q?vizahBuKt/N3XTQVtPfyXuNG5iU6Swtr2EY8NU9Zwnrz5YUOWmblCcULL9pA?=
 =?us-ascii?q?Ea0yywV1dZkRw+di2wq93HjgF5j3zVeHptvWfaft9YyhDY69jRA/VW22xVaj?=
 =?us-ascii?q?N/jGzsGlWkP9Svte6RnpPHv/H2A3mtTbVPYCLrysWGryL96mp0V07s18uvk8?=
 =?us-ascii?q?HqRFBpmRTw0MNnAGCR9U7x?=
X-IPAS-Result: =?us-ascii?q?A2DlAgCruY5b/wHyM5BbGwEBAQEDAQEBCQEBAYMkgQ9tE?=
 =?us-ascii?q?iiDcohxjBwBAQEBAQEGgTWIY4hyhlIqhE0Cg1g4FAECAQEBAQEBAgFsHAyCN?=
 =?us-ascii?q?SQBgl4BBSMVQRALDgoCAiYCAlcGDQYCAQEQgk4/AYF0DQ+jJoEuhC4BPYURB?=
 =?us-ascii?q?YELiWR5gQeBOYJrgwIZAYRjglcCjXGNZQmGNIk/BheOWSuKfIoWIYFVKwgCG?=
 =?us-ascii?q?AghDzuCbB+CBheIWYVaIzCNLgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Sep 2018 17:00:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w84H0Qri014846;
        Tue, 4 Sep 2018 13:00:27 -0400
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
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov>
 <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
Date:   Tue, 4 Sep 2018 13:02:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 11:38 AM, Dmitry Vyukov wrote:
> On Tue, Sep 4, 2018 at 5:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> So why not ask for help from the SELinux community? I've cc'd the selinux
>>>> list and a couple of folks involved in Debian selinux.  I see a couple of
>>>> options but I don't know your constraints for syzbot:
>>>>
>>>> 1) Run an instance of syzbot on a distro that supports SELinux enabled
>>>> out
>>>> of the box like Fedora. Then you don't have to fight with SELinux and can
>>>> just focus on syzbot, while still testing SELinux enabled and enforcing.
>>>>
>>>> 2) Report the problems you are having with enabling SELinux on newer
>>>> Debian
>>>> to the selinux list and/or the Debian selinux package maintainers so that
>>>> someone can help you resolve them.
>>>>
>>>> 3) Back-port the cgroup2 policy definitions to your wheezy policy,
>>>> rebuild
>>>> it, and install that.  We could help provide guidance on that. I think
>>>> you'll need to rebuild the base policy on wheezy; in distributions with
>>>> modern SELinux userspace, one could do it just by adding a CIL module
>>>> locally.
>>>
>>>
>>> Thanks, Stephen!
>>>
>>> I would like to understand first if failing mount(2) for unknown fs is
>>> selinux bug or not. Because if it is and it is fixed, then it would
>>> resolve the problem without actually doing anything (well, at least on
>>> our side :)).
>>
>>
>> Yes, I think that's a selinux kernel regression, previously reported here:
>> https://lkml.org/lkml/2017/10/6/658
>>
>> Unfortunately I don't think it has been fixed upstream.  Generally people
>> using SELinux with a newer kernel are also using a newer policy. That said,
>> I agree it is a regression and ought to be fixed.
> 
> 
> How hard is it to fix it? We are on upstream head, so once it's in we
> are ready to go.
> Using multiple images is somewhat problematic (besides the fact that I
> don't know how to build a fedora image) because syzbot does not
> capture what image was used, and in the docs we just provide the
> single image, so people will start complaining that bugs don't
> reproduce but they are just using a wrong image.

I'll take a look and see if I can provide a trivial fix.
