Return-Path: <axboe@kernel.dk>
ARC-Seal: i=1; a=rsa-sha256; t=1522441030; cv=none;
        d=google.com; s=arc-20160816;
        b=PVHKocdQy04B0LsUlM4jNeguwk90ClG99dDOdC1LWTcXZMD61Z7XnWVmV035uHmUV0
         MdBDZpGZXZyTrwM66Bk+ctr2o59JOImeVV3eRsxin5xOGs0hB1RGsazWeh+Qp5n5WBfb
         wYy3UjaVYjkZWrZtIPBywEGiEqwF/F9XWH7AroxfgZBKZuY54YvHN8+QlY1lT86wiVOV
         zkDWRt2d19xRX8XVBnjiYFtKePpidkWsAkgEa8rD5ALDeGWrHLEJAHQJMcTMVbWNe05Q
         kbPOlp4XxrQvDQBOjTpwNbJSnfdJ6Jn7nE2uIoYsKGLxWtDfVTLUPKudNVMs6hrif7Nf
         Rh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Rz/kGwnAXDOKjS8alA09Ae5gtIQ1lOgprPl4oSTlHUc=;
        b=YAn0OtHSVk01DtPSLtfYZPnkGKN7u66XG9qXWFrtrNLI+2dBXyGV0Rjc6swxYKsAnW
         s3S2PGf8jIVshtiaz+VA4ajl2CryAhpVvsU7RnQ1P7PeIDiJ/cZ+6Xry3edy5XIgxTQG
         6t8lsuJNHuhrghVqEeZA+K0OnCufkAp5RnfLvoM2NlQYCUFrreFT3I9gi9IW0TX4+Vmt
         pamDkbpiJ2zUka1DAXy5nxNaP/mO978IEAgPO4ScIKrOhEQIVKJ50lFVCneL2klf5czs
         50ahGcU7ZT+AGVMbzVaz5pzPbPthsqlpCJHOqgb9zI103GoPYJSe2P7V7BmmXDLmAUW2
         VpoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=WMcRvtG1;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.41 as permitted sender) smtp.mailfrom=axboe@kernel.dk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=WMcRvtG1;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.41 as permitted sender) smtp.mailfrom=axboe@kernel.dk
X-Google-Smtp-Source: AIpwx4/EDznfNNzxUE5RRC1aIUx3B2ZOvrKhxEjrcpuQMAzR6U7LLm9oqYzz01rIMnDu6nTPXt5/og==
Subject: Re: [PATCH] blktrace: fix comment in blktrace_api.h
To: Souvik Banerjee <souvik1997@gmail.com>
Cc: Eric Biggers <ebiggers@google.com>,
 "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shaohua Li <shli@fb.com>,
 linux-kernel@vger.kernel.org
References: <20180330193243.26044-1-souvik1997@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c13a34d5-9e4f-6c57-2b56-63dcb6c9ae27@kernel.dk>
Date: Fri, 30 Mar 2018 14:17:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180330193243.26044-1-souvik1997@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596392351859701170?=
X-GMAIL-MSGID: =?utf-8?q?1596395126287519651?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/30/18 1:32 PM, Souvik Banerjee wrote:
> The `__u64 time` field of the blk_io_trace struct refers to
> the time in nanoseconds, not in microseconds. It is set in
> __blk_add_trace, which does the following:
> 
>     t->time = ktime_to_ns(ktime_get());
> 
> ktime_to_ns returns ktime_t in nanoseconds, not microseconds.

Thanks, applied. Back way back when it used to be in microseconds, iirc,
I'm guessing the comment dates to back then.

-- 
Jens Axboe
