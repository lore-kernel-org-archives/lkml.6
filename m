Return-Path: <linux@roeck-us.net>
X-Google-Smtp-Source: AB8JxZr5toJtdzXcV+hli5Z3iwSPKVpOsrpS/ZV+9anT67GWMyZQ7LId3KDjNWsWp8wxHvyw8z+V
ARC-Seal: i=1; a=rsa-sha256; t=1525373170; cv=none;
        d=google.com; s=arc-20160816;
        b=rCeucMr6pWXnY6nEVK1h8RZ7NWKioVIR+r8HqsK/VAOY/cUq1nfS+L+zCl7MqixVl0
         O39GBOvX2dd5Dcf7qwfXaw4sxMS0q7d8OcQQlQx9NbBfmbEBQYgEyF9UJjjHiYo4OKpo
         nDM4H6/LjERJgyFZHoxchvsExfxU3az7K5mWTb7qTZQWdjNUCmeJasRYOTRcy1UFX+VF
         /EdScrpDzyyveBKsMNaXm/mzG07khOsYOvmIF+GgX1T+DQObbOOsiSIhqBllQKAt5rXM
         JJW3aRvmgLfLRsv1BGVe6/WwLHqm5J+1FHHPvnWEhUBW+ZjG6AFXHZNxx6PAbNKDolhX
         wJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=S3bYbTC/wSkTgKAnR/9UP7kYhXFCwOQVAZT7zJqjOsg=;
        b=kZNmUvWTZb4FYBMIaMYSW9hyaD0JYn+qR5lmiTBam6MCmNMWoHPDlPD8/dirTk57z2
         LBU+ua2PWEorWA9AmrjVN1ZZPup33w4DUkUtJGf6Sb6FfdmyV5RxHVPe4E8xCoVeofPY
         Sf+BOjVQ2RC1FMsBOCmonzJAR+s4F8GvAkb82cA4ng0ZGb1ToRpEuWNj5qIUlBQwtqFe
         zo0D9F7lLADGD8Hm+fnxR+J1S/ArlzCZnnfR4pDDTKz5hao+CI72OSCcLTQZOZpCzmqx
         3/2lYc5Oj/ampjO+yTEQSwB+DqwoiQa82UTmugE2EX0tj0ezla01fNXtGmH9g6Jk8ySU
         sTvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=OwfePpg5;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=OwfePpg5;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Date: Thu, 3 May 2018 11:46:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Willy Tarreau <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503184607.GA21155@roeck-us.net>
References: <20180503000620.GA29205@thunk.org>
 <20180503144612.GJ18390@sasha-vm>
 <20180503145205.GD23311@1wt.eu>
 <20180503150104.GL18390@sasha-vm>
 <20180503160046.GH23311@1wt.eu>
 <20180503161452.GP18390@sasha-vm>
 <20180503163516.GJ23311@1wt.eu>
 <20180503172926.GQ18390@sasha-vm>
 <20180503175723.GA23467@1wt.eu>
 <20180503181234.GT18390@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503181234.GT18390@sasha-vm>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599469697445666959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 06:12:36PM +0000, Sasha Levin via Ksummit-discuss wrote:
> 
> For example, how about extending the release cycle until the amount of
> fixes for regressions introduced in the current merge window drops under
> a certain thershold? (so go to -rc20 if we need to).
> 
Reminds me of what happened at a previous employer. We had a hard rule that
a product shall not be released unless it has no more than 2 severe or
critical bugs. Solution: Stop testing 2-3 weeks ahead of the scheduled
release day.

Here: We don't want to see -rc20. Solution: Stop applying bug fixes
at -rcX.

Guenter
