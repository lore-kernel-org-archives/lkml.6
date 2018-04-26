Return-Path: <nikolay@cumulusnetworks.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524743483; cv=none;
        d=google.com; s=arc-20160816;
        b=jVChD0plmzETCBtJpEO1VR1j02khx2g9pQ4mYILMgi06vU/9E8ydsIX1Z7evn6QE/j
         Q73f0vXxMUUanWeaI9ih5CpjbVHZFNQcUnU/ypHNb4L1m+14em4MfJg6C+6/wxDwp4tG
         RUKgc+iA1YXhNzwrA/tAjB6TkYQFCBRLd+lL70zEQ2bk5Kfwxint7Mtqr6oel416Pqgf
         yiXSjpauvHDNCnMVCTUeYvUKmPUMHy7Gh3vA54z/ab5ycQASXrA6qXMjvA8w7SiIzuhm
         MgM8o5PVBDZdwz2iIDOorteF8L8Oiw+yv/167MXuMOXKbDEyqBqq34MnI53n4sSxmuFb
         NwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :dkim-signature:arc-authentication-results;
        bh=mN4Hy8Pe7XdJN4US9s0ES1otIlKI++aQrbwu3fHJfC8=;
        b=YEYdKSE5XTk+1Y2yTe+Z6eJQ+Co/5R7q8puWYHKJnNKpMGhcq6xknxFrh0xxb+TAJA
         Q6idcL0eOSLQOjv/hInlRiGwWYlz8HQH7kQlW2LvBeqLSQ3/P2HshEyGASxfO2yDENzS
         0iGjjW6ljHw483F+Gsx3yqg0tg6Sokmxa1h1bEequ6mcRdEiGRBwk4OkdI6aYxMDt5w0
         lfJ+W4+IvnqfphUKpP//HkG35YWaWbMpoaIUFR87g3wGoYjpLdHviwdBleDvRd2PNVkF
         1Rgu5pdRErQHjvELDpbov7h0mmW+vgKaJ3k1k2D0A95CNqjWmauobLaplsX+VFx8289S
         1zyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cumulusnetworks.com header.s=google header.b=VJIYSWge;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of nikolay@cumulusnetworks.com) smtp.mailfrom=nikolay@cumulusnetworks.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cumulusnetworks.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cumulusnetworks.com header.s=google header.b=VJIYSWge;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of nikolay@cumulusnetworks.com) smtp.mailfrom=nikolay@cumulusnetworks.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cumulusnetworks.com
X-Google-Smtp-Source: AIpwx48EsCljZeLn8i2tETPx6zYC2owTpk2p4C1Z4nFLfSwS2r1zsutzIQ/C+Tv4f0UQpvP988ysTA==
Subject: Re: WARNING: kobject bug in br_add_if
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
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
 <2170a49c-be84-1bf4-4c73-bf7a668e5288@cumulusnetworks.com>
Message-ID: <90eb7466-35de-f1cf-c186-dc367ad5257f@cumulusnetworks.com>
Date: Thu, 26 Apr 2018 14:51:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2170a49c-be84-1bf4-4c73-bf7a668e5288@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597463513858460385?=
X-GMAIL-MSGID: =?utf-8?q?1598809423009562166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26/04/18 14:49, Nikolay Aleksandrov wrote:
> On 26/04/18 13:37, Hangbin Liu wrote:
>> On Thu, Apr 26, 2018 at 10:04:16AM +0200, Dmitry Vyukov wrote:
>>> On Thu, Apr 26, 2018 at 8:13 AM, Hangbin Liu <liuhangbin@gmail.com> wrote:
>>>> On Wed, Apr 11, 2018 at 05:18:23PM +0200, Dmitry Vyukov wrote:
>>>>> On Wed, Apr 11, 2018 at 5:15 PM, syzbot
>>>>> <syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com> wrote:
>>>>>> kobject_add_internal failed for brport (error: -12 parent: bond0)
> [snip]
>>
>> Re-checked the error. This is a -ENOMEM. So normally we could ignore it.
>>
>> But on the other hand, although we could find out the slave iface's
>> master in netdev_master_upper_dev_link(). It already go much further
>> and allocate some resource and change iface state. e.g.
>>
>> [54273.968516] br0: port 1(em1) entered blocking state
>> [54273.973979] br0: port 1(em1) entered disabled state
>>
>> So I think we'd better return as early as possible. I will post a fix
>> for this.
>>
>> Thanks
>> Hangbin
> 
> If I'm not mistaken the bridge allocated resources for the port are
> cleaned on kobject_init_and_add() error return. Or are you talking
> about some other resources ?
> 

Ah, my bad - you weren't talking about resource freeing.
Nevermind my comment.
