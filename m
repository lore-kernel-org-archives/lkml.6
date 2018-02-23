Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x226/6wI7TNo8M/PYoU52eU7OShQ9S5mJfQrNu33soavXHQOmfeR/FhNmTeEHs4F2oo7qsNTX
ARC-Seal: i=1; a=rsa-sha256; t=1519363674; cv=none;
        d=google.com; s=arc-20160816;
        b=Y5GR9mvW+3hRGnnKbfrSF9b2qVkOqpNkTTZwypYyGT0+S9eyokiMjy39SUOZ+DQ2vA
         ooa8/to8GaKXqF3UYoAxQCfGfXo87/T0Ptz2E8aSE2ThC3J0azDluigoZ3lc571u187s
         W0kUB6f1JWfbv/v+9121avIXm8/TCZoWP3BhA63W6U4/gG6yeyKD4Ee+4auvXcvqPJIH
         aV+OAT+6GLQaH1Di+cZ9rq6wd0wVfsGITUfrPGhhI+JlwtuU0JeNzId3ybGQfQjl9T9u
         AmukZ5hv1RyCFDUTwxPYRv6lXwu2hrfONQvhP0x6+TaTYY+X8u20ZbiNQ3D0aW/4Sk4m
         NX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=vHGlYwWdEPw3LsuEbVmfh4mIMbtzlw8KhEW4FE35WGg=;
        b=kzhI3CFGKdqGGQEPdKtmR9lHWiss7EVRM7h7/WBVQCkUWpt/6V0lU4oyJrsrZzDJYr
         Xty5FOcnQPCDRz2Tht5sLhCIXTS9rUupRh8BQlidGqboR2/oau6Ui3hz529rgORCj0+A
         WYhf6Bt544JYga/D58RQgL/R1IY8ycInGbXTXaGvjr4Xz3E9JRIquGJjXHoxaZIAq93m
         aB+TMR9ETSe9ok7xwJKkpcXhOd6hsFKmb77VGqeFp4lr8WKQxsZbWnGArNUNIZ4vgRlf
         lBYakeDj8Y2u/AWWlQk39a/AXA5PCt/nLVzy1YXAD3Xhbl4HvCi0Ra1nC1rAxuohLcL3
         3SvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HmwR+hMV;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eSW4PSGd;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HmwR+hMV;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eSW4PSGd;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Feb 2018 10:57:53 +0530
From: poza@codeaurora.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v10 3/7] PCI/ERR: add mutex to synchronize recovery
In-Reply-To: <20180222183602.GC6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-4-git-send-email-poza@codeaurora.org>
 <20180222183602.GC6267@infradead.org>
Message-ID: <2f79e5c643858e13f5ac9d6aef6e536c@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086412177501980?=
X-GMAIL-MSGID: =?utf-8?q?1593168284398739933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-23 00:06, Christoph Hellwig wrote:
> On Thu, Feb 22, 2018 at 09:32:08PM +0530, Oza Pawandeep wrote:
>> This patch protects pci_do_recovery with mutex.
> 
> Do we really want a global mutex for this and not one per root complex
> at very least?

This protects pcie_do_recovery, which is called by port service drivers.
mainly aer and dpc as of now. so the association is not root complex 
agents
instead service drivers who attempts to do link recovery.

so I think we are good here.
