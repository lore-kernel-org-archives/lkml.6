Return-Path: <ghackmann@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523293340; cv=none;
        d=google.com; s=arc-20160816;
        b=ISowlSeDLxMeqqZwkfLO67ZyuoM1+A0eFDLPGJjhqtgmb59Jy9MGBFZ+DvppwTvJNJ
         b8cmUIzYxZLbriJ2kGfr7k3g3J30TJkcopM8TC9wPAvzNTfgvNsUYay3YTeoR7S5Y74R
         z1nAPdY/jspf9yu47cgUdhrJFvoPZ4+nLuoHU8V+zzDgD+3INshwbZBstogU5f+EDpp4
         5tnx5cl6p7fXUVthCkLpGaH7sbWNA5ub94ze6foXWjptSuUjWJZfetMeE36xEP95mIno
         RuR+nXnEsuBBWTjlrWe3wWAD8oIFs3R5z3gaggnBMBRth6tPsq1UY0KjcOyiEb2IemXe
         JUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=HJJOMXOrKHFlqFI0cbJT1U7NtLbWoyEZIDEPWIyZdRs=;
        b=k41/7m2x39Jc+L9yrstu85Cj7lswBUWxczuFI9tX4m8WuPRuzZBUhRuGYq/a0jJ8Pk
         lc34Q0WZHqlrtBD5aohjVZkfysi+H+Us6fHvyXcbpFMx7h8NIOni2+RrRrHsgOrBJAln
         6D8JGlVlstlQlNSDhA1rIzWp8MSOAQ+wMTWIVZXB7FCzRWnU7Uk39JPl7MIipDw+b4zw
         XDLfGD4Zggcmz3RFPcW3X47vamLhV7xc4XLuUaoZ2w2wx/Mr1wAbrXWaQkZtbP6yRJyw
         0glqGt72XK+PcUxd7vfFLXe8Nlgsyfc6sgrEqA9RBD3MkWFYFgWDYaUT/cM3LueRzWtA
         w9TA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Yeh7HdyE;
       spf=pass (google.com: domain of ghackmann@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ghackmann@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Yeh7HdyE;
       spf=pass (google.com: domain of ghackmann@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ghackmann@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx483xtwJuK0+5exIXU/kyh1FUE5KKoRJEi5ckDci2NAhKzckS649v7B8ZbGQ/iXsfkyd5JnRgA==
Subject: Re: Linux 4.9.93
To: Greg KH <gregkh@linuxfoundation.org>,
 Jean-Baptiste Theou <jb@essential.com>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, Dan Rue <dan.rue@linaro.org>,
 Mark Brown <mark.brown@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>
References: <20180409180534.1768583293d0abe207168c5a@essential.com>
 <20180409093028.GA3398@kroah.com>
 <CAKv+Gu9Ny=EatuqrVOEFbOt+h0rH5uqxxDyHFT-PLH72ZzvZiw@mail.gmail.com>
 <20180409185751.247a0ac7@jbtheou> <20180409114146.GA20636@kroah.com>
From: Greg Hackmann <ghackmann@google.com>
Message-ID: <fbd6de8b-d2ab-9fcd-75b6-7151f24309e9@google.com>
Date: Mon, 9 Apr 2018 10:02:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180409114146.GA20636@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597258846269332204?=
X-GMAIL-MSGID: =?utf-8?q?1597288837768485914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/09/2018 04:41 AM, Greg KH wrote:
> On Mon, Apr 09, 2018 at 06:57:51PM +0900, Jean-Baptiste Theou wrote:
>> On Mon, 9 Apr 2018 11:49:37 +0200
>> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>>> On 9 April 2018 at 11:30, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>> On Mon, Apr 09, 2018 at 06:05:34PM +0900, Jean-Baptiste Theou wrote:  
>>>>> Hi,
>>>>>
>>>>> After this patchset, a kernel built with CFI fails. Disabling
>>>>> UNMAP_KERNEL_AT_EL0 fix the issue obviously.  
>>>
>>> How does one 'build a kernel with CFI' for arm64?
>>
>> From Google work on Android-4.9
>>
>> https://android.googlesource.com/kernel/common/+/00a195e7c0752ff5d65c9caadfbcc226270ca232
>>
>> I am not sure what is the plan on their side to upstream (Greg?), but definitely
>> useful to isolate actual issues.
> 
> Ah, yeah, if you are taking anything from the Android tree, all bets are
> off :)
> 
> Greg Hackmann can probably answer the questions about CFI and these
> patches, as he's working on merging this stable release into the
> android-4.9 branch this week.  I'll let him deal with this...
> 
> thanks,
> 
> greg k-h
> 

I've added Sami Tolvanen, who's handling CFI in the kernel.

Sami, what are the plans for upstreaming this work?
