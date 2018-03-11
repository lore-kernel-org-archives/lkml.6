Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520784356; cv=none;
        d=google.com; s=arc-20160816;
        b=cUCDfL7zoecHOhcYBKGLsW0VMAVwYtMapXpAqRXBvtbhSDFX26P01T5SbLnhVyxIUM
         6cG5xiHAyldrSSFszFtQgNFfR2lKq7W951cMZprH3PDdasswrmyjGx0utFJ57LB7hRFL
         YOYNTaqy6aAw5dLXL5RewvZVnA1AzglJumuxRKOc7iEQhbE4AdCQTuqQjDPvBiutsabi
         j5xWXxKv+SW59o5soxwh8Ik/x3BTEwbknwjvNNfm6kD8E4j3KzYzpiZJh4v/dkvpX+hl
         sHqTLsf4JTgyYscrHO+bsdXC8bjpKHZ6Ye2qGZOPd0aijiZk7tkQTXHefD4yqV1vqRHQ
         dJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:cc
         :dkim-signature:arc-authentication-results;
        bh=w0ftyF4iTzeVUVx+vEc0WAJ6Xb81lECVm5NSGac/HBE=;
        b=AaK5IiLZ6p3/hItAkporkmh8k/HKdXvFKu+o9h5Xzl4vwUZxRp8w/fO5ABjI6lb+cZ
         cQ8XHMcAMFWSPoe2wguAO1fdpsAquklhwCSf7q3NfCRo1MML4tXXAg4XUBfEV4L2bjX0
         zTexW/8cuSetf/eHPQ8SuRhhblmqFiJJZTVgEaT/3CcZ9LYX3MdWES6/wkjHThRSzqHd
         U6Bgl1U57Es+UwjC/GXvmEMwqhpdYZ9HxYkxmwmcq211C3isTMY/myKEwQ7ahM/BD8sm
         MmSKHZABKbaW0Chau82UVm4SorRwGWw3kijbxvEBxP9nbtkuj64lHewObypd52b2TfQj
         nDlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SiJLdq93;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SiJLdq93;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELumaIf96RY7ZzDSDKgVmAIR7QUaF5+7FwKilVCgnjzCE5NzBueHyzLwe05aWTD2YD5h44DSxg==
Cc: andresx7@gmail.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@codeaurora.org>, Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
References: <20180309221243.15489-2-andresx7@gmail.com>
 <20180309230925.3573-1-andresx7@gmail.com>
 <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
 <CAB=NE6XpY4LuDwnakCa6gZ_HjjhZDnu=gDeHwmpNRaSkqQOB2g@mail.gmail.com>
From: Andres Rodriguez <andresx7@gmail.com>
Message-ID: <bbdc304f-edd5-38df-ea88-012fefc54b90@gmail.com>
Date: Sun, 11 Mar 2018 12:05:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAB=NE6XpY4LuDwnakCa6gZ_HjjhZDnu=gDeHwmpNRaSkqQOB2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594657977859758970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Luis,

Thanks for all your feedback, greatly appreciated.

On 2018-03-10 09:40 AM, Luis R. Rodriguez wrote:
> On Sat, Mar 10, 2018 at 6:35 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>> You also I take it have users in
>> mind? I'd like to see at least one user of the API or this fixing a
>> reported issue. Ie, if users have reported this as issues incorrectly,
>> referring to those incorrect posts as issues and how this created
>> confusion would help.

The current user I have in mind is amdgpu. I've got some local patches 
for changing it to use request_firmware_optional() for the optional 
firmware files. I will include them in the v3 of this series.

I've also queried some devs from the other DRM drivers in case this 
might be useful to them. So far I've gotten a reply from the nouveau 
devs who are also interested.

> 
> Your patch series then should also have the driver callers who you
> want to modify to use this new API. Collect from the 802.11 folks the
> other drivers which I think they wanted changed as well.

Arend, Kalle, would love to hear your feedback.

> The old up on
> that front was that the firmware API was in a huge state of flux and
> debate about *how* we'd evolve the API, either through a data driven
> API or functional driven API, ie whether or not we'd add a flexible
> one API call with a set of options, or keep extending functionality
> with new exported symbols per use case. The later is how we'd keep
> evolving the API as such the way you are doing it is fine. Ie, if
> there is a use case for an optional firmware also for the async case a
> new API call will have to be made. As stupid as this sounds.
>

Seems like I got lucky with my timing for this request :)


> Also please take a look at lib/test_firmware.c -- I don't think it
> makes sense to add a new test case for this API call, so at least
> worth documenting why somewhere if you find a suitable place for that.
> > Also - I forgot to ask you to extend the
> Documentation/driver-api/firmware/ documentation accordingly. Please
> do that.
> 

Will do, for these and the feedback in the previous Email.

-Andres

>    Luis
> 
