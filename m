Return-Path: <axboe@kernel.dk>
ARC-Seal: i=1; a=rsa-sha256; t=1525443610; cv=none;
        d=google.com; s=arc-20160816;
        b=i4IIVAFUhhNEdNEXOpU5oWm/ALDXAWSb7KKcdpL6maAikuvgnVJQn5KYfr86D3dXiL
         5eXeDsSH9KTV9FnixWVktnlXn+bZKZa+norwpJSao0HnJ67a9o94HJeFTR70JIFgkE+R
         O+UsGXXBtpygSMsayojtZ/cFFzP03I+KcSNNU8O0O0uHdsobRKRMTW/jfSpe0sBNLOPi
         ivyAGpKqauTGkpEasUhnMt8ZfVyxS8SVjfqJK1sGIGFBz6Te42OKzDrCkJxV5RE1GqKT
         eM/IMCWxPD6lfKdQ3G4nn8VF7jSk6gv1tYCxmCORyCtUuMvXXhcYuHQ+wq50w3Zg/kqz
         dp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=DdIGctgHhhV3koVUR8xil9IsQ6sZ75on5I+ljt60Lt8=;
        b=T5o4cEG2b7Z4x+dbidXAYz+3bUzONDsPa6/kGkm6z7EcCyBBj78yCHmOWj7lS/BZbq
         fO4YQZSU0ISQrMmUSgI78KUSe7+uX75Y7CxXbjjgHivIWRFvKzxSZatZ2W4mz/frsanO
         wmeunESBMqu/hbw8Bf1bdZdABXh8JjiMjzexqYWovVWDioxLWZPJWD7CUxjsAGWe/CR1
         iVHhckA7ic41eF62gm1+JMox9wHZe5vzK6uXQePyhbwsVf6784SVnlEzAEOMJikxkDMH
         VzYaEg++VixXH3tnqvxcszKU+sQ/3OsZ8WsSU2nZU2TbRxbxEzl7n/japD6TPoyGbUK4
         Z6aQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=k/dUMshf;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.41 as permitted sender) smtp.mailfrom=axboe@kernel.dk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=k/dUMshf;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.41 as permitted sender) smtp.mailfrom=axboe@kernel.dk
X-Google-Smtp-Source: AB8JxZps13XtKIZBLdtDFcu0JmsJt6rrV+mRbHMSZzR2EFFqoFmWIxo2mWurFl8EWEF6kMcKI9BgXg==
Subject: Re: [PATCH] block: add verifier for cmdline partition
To: Caizhiyong <caizhiyong@hisilicon.com>, Wang YanQing <udknight@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiangheng <jiangheng@hisilicon.com>
References: <20180503111748.GA904@udknight>
 <C3050A4DBA34F345975765E43127F10F8B77159A@dggemm511-mbs.china.huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3267b3ec-0500-5772-949e-49570395085d@kernel.dk>
Date: Fri, 4 May 2018 08:20:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <C3050A4DBA34F345975765E43127F10F8B77159A@dggemm511-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599441484038057319?=
X-GMAIL-MSGID: =?utf-8?q?1599543559495493276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/4/18 1:07 AM, Caizhiyong wrote:
>> -----Original Message-----
>> From: Wang YanQing [mailto:udknight@gmail.com]
>> Sent: Thursday, May 03, 2018 7:18 PM
>> To: axboe@kernel.dk
>> Cc: gregkh@linuxfoundation.org; pombredanne@nexb.com;
>> tglx@linutronix.de; Caizhiyong <caizhiyong@hisilicon.com>; linux-
>> block@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH] block: add verifier for cmdline partition
>>
>> I meet strange filesystem corruption issue recently, the reason
>> is there are overlaps partitions in cmdline partition argument.
>>
>> This patch add verifier for cmdline partition, then if there are
>> overlaps partitions, cmdline_partition will return error and log
>> a error message.
>>
> 
> Partition overlap was intentionally designed in this cmdline partition.
> some time, the cmdline partition save raw data(not filesystem), the overlap makes data  access very convenient.
> 
> reference  http://lists.infradead.org/pipermail/linux-mtd/2013-August/048092.html

Might make sense to warn about it at least, it can be very surprising if
it happens inadvertently.

-- 
Jens Axboe
