Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELua5zB/Ox8uEIaNFG2Lb8OjUPh7LFT6hZz4vag/Mfo84vvjBNnLbzzwxI18HGIldZD83DuJ
ARC-Seal: i=1; a=rsa-sha256; t=1520691549; cv=none;
        d=google.com; s=arc-20160816;
        b=oGspeSw4ZRiPCCOlY27GoafMf/peeESb4NIyXti3ETIdsrf7+w1+x624ibNCzvxhTn
         h9DCQqL2D3CcF1atOQgDWL4eqyO5VsYV694fya6Pw2sD9gKkmd8l1TAzvRYMPe3gSsdF
         TIzivK7RxIZl2LjyDzeLlhSCQGTWR58F1X2x6zJeBAgfR4CyC6crHB/4KKJfzRjz5dwv
         W16Iov4V9zCbe4tRP1a9FDa4R8aqGkXMVW5ZZorMp2RZmGNUAlJveZZ64B4HkKNZUQPx
         oxPSfOrVeJe+DtBh1iUiDB/Xv9Q35jZHUbBy7pXEJ0G2+AZmxlJQF8KwitDaygynr8FT
         FA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=qm46F7jFJRbJZrYa8RGIDdztkaKc3gPoxT5SaCFTMKM=;
        b=zqXUKTwCJNBVda4Xqza/nBy9I21Ni1BGISQyGkf95ljDF0Mpk7qZuSoQFBb6h083FU
         /P6KVs4Ez2uHuU/uUqZ1/STd28S2alR1mERKsa/2scr7+MsPK5SnVePlWjtlQFqefdoy
         3my1wdPXx9UwEGu7xK+ErYS0HIC+Jiz1p3V6oT/iLOaR9UWccy0VsL6cfAHEiu4dHls6
         2wzJc9np1mpZV+Y829NggqPGAPrPkWBI72hZXyaIdaT8YAI+eFkXuCYhrPcmOWMdkTIw
         0twLeleyl3T8Fl4jsUMYW7v/k4mf6QauJ9jI/Z3NHqQBlryEqLIMwNVUyoMurLaZopmi
         wzCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CFF217B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180309221243.15489-1-andresx7@gmail.com>
References: <20180309221243.15489-1-andresx7@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Sat, 10 Mar 2018 06:18:47 -0800
X-Gmail-Original-Message-ID: <CAB=NE6US0qwDVeGvcng1zjN37N0PsibU5vP1sMoGb_F4LR5h=g@mail.gmail.com>
Message-ID: <CAB=NE6US0qwDVeGvcng1zjN37N0PsibU5vP1sMoGb_F4LR5h=g@mail.gmail.com>
Subject: Re: [RFC 0/1] Loading optional firmware
To: Andres Rodriguez <andresx7@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594499879677109400?=
X-GMAIL-MSGID: =?utf-8?q?1594560661582809842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 2:12 PM, Andres Rodriguez <andresx7@gmail.com> wrote:
> Hi Everyone,
>
> Wanted to inquire your opinions about the following matter.
>
> We are experiencing some end user confusion regarding the following messages
> being printed to dmesg:
>
> [    0.571324] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris10_pfp_2.bin failed with error -2
> [    0.571338] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris10_me_2.bin failed with error -2
> [    0.571348] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris10_ce_2.bin failed with error -2
> [    0.571366] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris10_mec_2.bin failed with error -2
> [    0.571404] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris10_mec2_2.bin failed with error -2
>
> These firmware blobs are optional. If they aren't available, the graphics card
> can still function normally. But having these messages causes the user to think
> their current problems are related to missing firmware.
>
> It would be great if we could have a mechanism that enabled us to load a
> firmware blob without any dmesg spew in case of file not found errors.Currently
> request_firmware_direct() implements this functionality, but as a drawback it
> forfeits the usermodehelper fallback path.

Yeah, this is a common enough reported type of feature request that I
think it makes sense to add now. I'll reply to your patch with a bit
more details.

 Luis
