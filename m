Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030604AbeBNOEK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:04:10 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:39803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030290AbeBNOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:04:09 -0500
Subject: Re: plan9 semantics on Linux - mount namespaces
To: Richard Weinberger <richard@sigma-star.at>,
        Aleksa Sarai <asarai@suse.de>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <CAFLxGvzxLP_UTQbwEY99bQfyftWzZHwaOP+WrzJ8099EKtbVLg@mail.gmail.com>
 <4864d279-9a3f-eaf4-c297-ea34be604e41@metux.net>
 <2658681.ustYaP9yci@blindfold>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <a2a6f189-008e-38f2-afcb-b9393d8d440a@metux.net>
Date: Wed, 14 Feb 2018 15:03:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <2658681.ustYaP9yci@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:jPJt3U98yecPvucmLb5KYtPDaJcUu/uCMugiRk7vyrQskva7Bpc
 7z2y860Z6banDXJFU1Exj1Q20xkD26sqMlCMcM1eKQnrdtLwnUBkV94r0LryZjxRVvHs/pG
 kYyVnWc7E2C+ynIk90k3M4XiLQEBXXRG/iPoVOHyxgv4uLl+8peoESjDWvV7SmIPPjrbmdI
 9PJGqwr3xZkFgzJ6NroRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lm/MtH9vknc=:RlqEHCGDmwGiKKq3803wa8
 pkCX6CmYvuo1UHJilPtwYbwdmc+wibiVuMTDBga7XYYPzeq+44ldYLofwFP79od33P5S33PHD
 dbJNB+I5Dc/1VkeEtB7oRrNy92b6LXAbLXiDJwtatHgXZUqqWpP/G0fJzSeBjy94dVUnWD8L1
 PIgjIitzZD51Ima5W5lnTIzhqRWc/btXY2OfFnTTZlci0/6gnhQ51Tq6IKPo7UD8c8JlU/cod
 cnxlSsp/5ff6DgC3qpg6MMq+Zwm5Evf/Y9BLqAYVfx5EHrk8/tGg7M4NlRelxw5u7rb8ZpP/+
 zNmznudDBhAlR+5kcorMxsAD2Miw7rGzJSJwYmKeQHCaZqcdtW/YTdFtBcjjbKk3BW0hHVDaO
 xw1AhA6vfj6900yrvpiEqdic1DsG4hISs+xKiT+VuNO3K59RqJBBmKe0Z+PkrFQ0uqlxMbqDK
 fffr7akoCoU3e8lQfUpP8h2agD8zG/vHIq1uTGrGwsnLroY6lYhhvXhM0OhPxN13v++45Nv1A
 wx5SAGQnO1CSuc9gUqP4nlZndQ5CARSSUeIhLuUGXc33X459AcWSyniklhoVlKtqePTyy4zZL
 L9raukGgKrF8G2a8Si4Kyx9173XsJdjPeg0zmA9rzD1RoeYzhBoebIDz2KTfWkYOaYqmZ6d8n
 MZqFNMNrc6SgX5BENS1f48IA6qIOdmfa1Rm7xdk3ea4Mlk+zOgdqyuvWcHXWirJZsX0fHQ12i
 15T2Hg8jbAsfz/WpWUXCRgKWSMhasOaDQGcO4jpvIjRuNrUCJWpib3uv99PJ08RNZ++5M7+lR
 YEspO/PXfoyhSFc3wzX9lBzBC9aa4OnJdALs7Hm4bBLVJnF1crd6sW0LbU+zbABs4nNTgL2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2018 13:53, Richard Weinberger wrote:

> It does what you ask it for. > Also see the --setgroups switch.> AFAICT --setgroups=deny is the new 
default, then your command line should just> work. Maybe your unshare 
tool is too old.
Also doesn't help:

daemon@alphabox:~ unshare -U -r --setgroups=deny
unshare: can't open '/proc/self/setgroups': Permission denied

>> What I'd like to achieve is that processes can manipulate their private >> namespace at will and mount other filesystems (primarily 9p and 
fuse).>>>> For that, I need to get rid of setuid (and per-file caps) for 
these>> private namespaces.>
> This is exactly why we have the user namespace.
> In the user namespace you can create your own mount namespace and do (almost)
> whatever you want.

What's the exact relation between user and mnt namespace ?
Why do I need an own user ns for private mnt ns ? (except for the suid
bit, which I wanna get rid of anyways).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
