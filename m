Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AH8x2250q3eti1Uiw6q724tyKLwXKbwF5fAOk8V0jxAZ0E7cheKLksvpiDc8Px+N0+cVh0L6lAgO
ARC-Seal: i=1; a=rsa-sha256; t=1517937359; cv=none;
        d=google.com; s=arc-20160816;
        b=rZUc/FGSxHQCgd5JEF/Ck6I6ZTpLufj9oS7e0aFbHgs7q5h0pxe6GRsrDYLlNtOphX
         I1gxETjNaXG43Wi7yZrhKxDrvFAkJVcoNV7PGAYoBE6jX8ThfznVx4Lg+VB9aA4aHfJQ
         vc9tNcfGR4t98gePc3pH0nx6KuTNnt0oe/B47zrQdcagspjfevmcEecRVg9WKA7a1c00
         b7/hbKldMZXpTWGEmAf36kGbaiODZXz9lPVGttxixVmIvHxatbslCcg0MUPztz2qGzQ9
         HiSy47EE5nRFzlHcJxAg237diqunMm7B0pPKyK28amHVQKW/gXopCoBE7dPIzs8ROG/X
         A2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=U7FIt6OXaZTmaBodNzFJKdKKuKwy03Y5C6kRfjdm2qc=;
        b=JqNkhl3i6KB0aFy6PkhM6h6n2hA9jZDDtKxSc1WLsX08Wjer0R7h8XoWa+2UORSX6N
         dNw6ecHHIZtzZ+XWp6pDRhYMZsbjBJi810XwW2xcOgCb789uslD+P63+H9ikUt6ET7w8
         FP5H5bBIurXCz8kHc/Y+FZ1qLEQAXFG+D3b4Xlt5y5697Bvbh/GxIFCtj8qF8c5rW0iG
         vDW63fcUmIp4lP7PUv4USdwP/0OWS0Q478WIbjg9u7RDjO9vfwofhU0Uii524qVzDSYr
         klbzpiKvCYIOT1j4ep2mo8OVPcQAAiWWwiLGioXc9ZHY27QOMv3cA+d8/mSnY7Nwx6Fg
         rOfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, gregkh@linuxfoundation.org
Cc: axboe@kernel.dk, jlayton@poochiereds.net, bfields@fieldses.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
 <151788391701.28069.13145257664735983272.stgit@srivatsa-ubuntu>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2550ca60-5f02-56e7-ff4c-6cd96b20a4d0@deltatee.com>
Date: Tue, 6 Feb 2018 10:15:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <151788391701.28069.13145257664735983272.stgit@srivatsa-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, bfields@fieldses.org, jlayton@poochiereds.net, axboe@kernel.dk, gregkh@linuxfoundation.org, srivatsa@csail.mit.edu
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/2] block, char_dev: Use correct format specifier for
 unsigned ints
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591616659826839373?=
X-GMAIL-MSGID: =?utf-8?q?1591672684480341103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/02/18 07:25 PM, Srivatsa S. Bhat wrote:
> From: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
> 
> register_blkdev() and __register_chrdev_region() treat the major
> number as an unsigned int. So print it the same way to avoid
> absurd error statements such as:
> "... major requested (-1) is greater than the maximum (511) ..."
> (and also fix off-by-one bugs in the error prints).
> 
> While at it, also update the comment describing register_blkdev().
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
