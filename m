Return-Path: <atull@kernel.org>
X-Google-Smtp-Source: AIpwx48/qVjqzVhHbCLVchBKOOL/dMkYhYWy4F7WSaf/ZbxIPGmfL1Enk2iuKp80mK27mZdEcbBt
ARC-Seal: i=1; a=rsa-sha256; t=1522355965; cv=none;
        d=google.com; s=arc-20160816;
        b=fBn3feVp/Yo7UZ2UMvhXaOkdwD+CffFTModqACJyUM8XnPBsWdAGLjEIOBOfXZo925
         x9Jtsquw/vVq12MK4KquFVA4AHZM3JRdUzmiHvaj5sHWgO39mT3B6sqXmePPNRDYKD3N
         W97uGn/RaeRAtwfN5EK/Zd+aOe1chbw83F/tXvIxtrLmwHQaiZuxO4WloiDlVyVoq3Ms
         tTFkO+I28kDhH+DQejr+9WGSnem3IPYL8bxJcQ1EnUes0Kv809xrx4FDLuvvRfpE65+m
         wANDN6UcnOz0tlLRT/t4PIb7PciCqRTGiIb1lmrvBOff1020LNpri57WFOH1MOS47l4c
         kCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=+7VBfQtNehGP5if7WhUnA+oT1s3KgOl1myFEqx3c8vo=;
        b=N1nnB/+fBirYVZbuno8j3DW2N9vvRhaEL0QVZUj4N2BPSs+oHNTq26sUQN9fkmTwB0
         8uG5/9jGPPRoah+v081Z6XP9rip/JlMvH7E4jrDZPb8y6//hvd6mkHdTDz4QqCsYZzUd
         BVkezFzFSTYWQV1VhlZZxE2UByR2TlCtqljQ5vTl4QcyHD2k0v+rlWvTxISBnnotUnAB
         D7XENnLQopw0sXonTPXO1dBUeKq8LJmkA8247nrUBHRCk92WFkGfBYIdqHiaYEJTrZcT
         B/lh52jYP2HkSpvvDLE96AhbzJNpBbP5mYfEs8fTiTWNuptpv2klFSgkk+dWoqc1HDTk
         8fgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA99217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180329170142.GB8501@kroah.com>
References: <20180329153658.11614-1-mdf@kernel.org> <20180329153658.11614-2-mdf@kernel.org>
 <20180329170142.GB8501@kroah.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 29 Mar 2018 15:38:43 -0500
X-Gmail-Original-Message-ID: <CANk1AXT_hKKgi8G1pkDrgfg425i-jLkjiC3TZ2AUee11_PSSYQ@mail.gmail.com>
Message-ID: <CANk1AXT_hKKgi8G1pkDrgfg425i-jLkjiC3TZ2AUee11_PSSYQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] fpga: region: don't use drvdata in common fpga code
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596287276477563606?=
X-GMAIL-MSGID: =?utf-8?q?1596305929100517136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 12:01 PM, Greg KH <gregkh@linuxfoundation.org> wrote:

Hi Greg,

> On Thu, Mar 29, 2018 at 08:36:53AM -0700, Moritz Fischer wrote:
>> From: Alan Tull <atull@kernel.org>
>>
>> Part of patchset that changes the following fpga_*_register
>> functions to not set drvdata:
>> * fpga_region_register.
>> * fpga_mgr_register
>> * fpga_bridge_register
>
> That's not what this specific patch does.  Please do not write generic
> changelog text that is identical for 3 patches that does different
> things in each one :(

Thanks for the guidance, it's always helpful.  I'll clean up.

Alan

>
> thanks,
>
> greg k-h
