Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AH8x225eWgMsxa9JPZfU+Np3sJd7f/ctTcxriwvrR30cBEj4+RBNVGOn3N0B2BIQ4lCp4dGqDsHH
ARC-Seal: i=1; a=rsa-sha256; t=1517505830; cv=none;
        d=google.com; s=arc-20160816;
        b=tArsyxBZzK2dIvmeguIWZjjsUUEd5BFfdMRCuGdtPifJGEFx/Iv4asQEICkwvWNEoc
         tiZmNq69diLq0kaRPbYUQpekbWnbyUA28rBSf0PCVkQIRlgTRW106Wxl97JIeschlYXF
         kN7wcRDPrtO8ZhLwgGf9PYAWfafKn53wwnZnuaB4gc9ckNDjwKEoRr26aVEaznIgQILh
         3b9ST9P36B7bR7b3qp3IQMrGzg5RX9x7TmcaszdUCcQ6GTKosSmnJPKO6pQ1cEeD9ZTx
         y4bW1ueut8P8qlU+6WE0HW7tvW5mmarzxHGCnN57Ovc0xizVDiI2WYeogTcDoiGd31N1
         OVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=KZiEoXewjmq/i+GFIopXNJy+0Eb49wNXzp5O+ruFwU0=;
        b=B8xqewCNkV7z5/eR0sO4vwlXHcjsOXmSHrPsjsGKYHk5MENyrnRU5rmrqDKFn36ObS
         hYmHoyfQisLZOGEcDPMK8Gb8IdyChBRA5ouYD4OuASuaGf9gdJY7t2fsvs27gatIeysk
         a1Mmr5kcJk8IUojATkMihZCqffXcUM+RNvmaVfpH+r21K9TV+pZt8Z7+16Kks14UIHAv
         xvwby/uMcuwloT7EXgTT+5oy4CJSkEz5V5oFgDSqCNsq61qttjOfhDQ6FUcMY8sjur7l
         E46QqeEa0Oj2A7Gy1McIaUVPEeH6cGRo1NWNdZ9coDX4e4fsgDVi6Dfz7t78wwai4Cz8
         ik3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Subject: Re: [PATCH v2] irqchip/gic-v3: Ignore disabled ITS nodes
To: Stephen Boyd <sboyd@codeaurora.org>, Thomas Gleixner
 <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rajendra Nayak <rnayak@codeaurora.org>
References: <20180201170329.26916-1-sboyd@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <38dd5843-9290-28b2-8acb-aabb81acf00d@arm.com>
Date: Thu, 1 Feb 2018 17:23:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180201170329.26916-1-sboyd@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591218916774125343?=
X-GMAIL-MSGID: =?utf-8?q?1591220193509335343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/02/18 17:03, Stephen Boyd wrote:
> On some platforms there's an ITS available but it's not enabled
> because reading or writing the registers is denied by the
> firmware. In fact, reading or writing them will cause the system
> to reset. We could remove the node from DT in such a case, but
> it's better to skip nodes that are marked as "disabled" in DT so
> that we can describe the hardware that exists and use the status
> property to indicate how the firmware has configured things.
> 
> Cc: Stuart Yoder <stuyoder@gmail.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Queued, thanks Stephen.

	M.
-- 
Jazz is not dead. It just smells funny...
