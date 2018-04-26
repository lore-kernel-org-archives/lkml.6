Return-Path: <nikolay@cumulusnetworks.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524743371; cv=none;
        d=google.com; s=arc-20160816;
        b=UCD3M5S3Qckmd5lkTba0g9wkrUqELT6+aCDAyo0San9vfEEq5t2C1xwcKCdUQEwYl9
         JMAmYu4HUCaWCm58uONDEwwwVBh4YTHdTz2LT/JL7vZwPICpDVpNqIrc4nzvhfUzhPU/
         rCH8bRJj82KV3i5Cdj7p/qPDQ47uk8meafoAMY5jQCBuQc7sXCL8EWOEv5HXrjUXt9mJ
         DkQTeQm3qWgMLDkEA2wmkrGj3NgVREsD962rKPGpXtyZSORi34yyfJUesqJOQYPIy4Ol
         4HV5yMuSn9jtXcCkCiAS63zVJgMDtDH0unlOFVQ67uzmQ5L01pmvBbKFQw4AJmrY6q/Y
         geJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=NB0f3fgW08tUwhiQ1mgIpTI1d4fYEVFEjd66rSUUBIs=;
        b=bA0ej88+d4CNY/bHD8jLzVT3qYjpxJkJ5Hcs6ALekR3Wm9IePh5QoFfFS4+SaL3KI5
         wf/AptGhAs3DoZ+Sbg5YZV5nhBR2n54eRCFikCn+KkZXGYMnlPZfhCvzEvD721H9qo2s
         Y3HjSzMZf3r31jsaJU73CNMmTVEh6j8dZXEdVm0uo3OREV0s9DwcVcpcDq2IImlh0l/U
         F0DuxgYPmL/RIDLeqYDGN8eR9pqDfC5hRE6/1wry1/Jjvf3QYkR8Y4iGQq71quMB82Op
         6tYbSIG+2BMPzI5FH3AJcpau7VxM/cRVjuP0OGMKR6pQB8pSEAEkwR+jPmogJCektNc0
         2L1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cumulusnetworks.com header.s=google header.b=ZAWblokV;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of nikolay@cumulusnetworks.com) smtp.mailfrom=nikolay@cumulusnetworks.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cumulusnetworks.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cumulusnetworks.com header.s=google header.b=ZAWblokV;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of nikolay@cumulusnetworks.com) smtp.mailfrom=nikolay@cumulusnetworks.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cumulusnetworks.com
X-Google-Smtp-Source: AIpwx48dWm8jMA6NocX4Ull9u/sFcv0MfF5f7nXMWnKmILmd90raCzPB7d0kKN2WLKknl87WGjWRfQ==
Subject: Re: WARNING: kobject bug in br_add_if
To: Hangbin Liu <liuhangbin@gmail.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com>,
 bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>,
 LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 stephen hemminger <stephen@networkplumber.org>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <001a113de2d878ade40569941a21@google.com>
 <CACT4Y+afuYwoWEp1PJ-Noo-YBXmKKRErntBWy2fR6iz=_xFByQ@mail.gmail.com>
 <20180426061314.GH20683@leo.usersys.redhat.com>
 <CACT4Y+aDko-kKP-u2S_UGBbB-uwnGw4dWTOSmXVDR3=osLJeFg@mail.gmail.com>
 <20180426103702.GI20683@leo.usersys.redhat.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2170a49c-be84-1bf4-4c73-bf7a668e5288@cumulusnetworks.com>
Date: Thu, 26 Apr 2018 14:49:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426103702.GI20683@leo.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597463513858460385?=
X-GMAIL-MSGID: =?utf-8?q?1598809305921922136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26/04/18 13:37, Hangbin Liu wrote:
> On Thu, Apr 26, 2018 at 10:04:16AM +0200, Dmitry Vyukov wrote:
>> On Thu, Apr 26, 2018 at 8:13 AM, Hangbin Liu <liuhangbin@gmail.com> wrote:
>>> On Wed, Apr 11, 2018 at 05:18:23PM +0200, Dmitry Vyukov wrote:
>>>> On Wed, Apr 11, 2018 at 5:15 PM, syzbot
>>>> <syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com> wrote:
>>>>> kobject_add_internal failed for brport (error: -12 parent: bond0)
[snip]
> 
> Re-checked the error. This is a -ENOMEM. So normally we could ignore it.
> 
> But on the other hand, although we could find out the slave iface's
> master in netdev_master_upper_dev_link(). It already go much further
> and allocate some resource and change iface state. e.g.
> 
> [54273.968516] br0: port 1(em1) entered blocking state
> [54273.973979] br0: port 1(em1) entered disabled state
> 
> So I think we'd better return as early as possible. I will post a fix
> for this.
> 
> Thanks
> Hangbin

If I'm not mistaken the bridge allocated resources for the port are
cleaned on kobject_init_and_add() error return. Or are you talking
about some other resources ?
