Return-Path: <marcus.wolf@smarthome-wolf.de>
X-Google-Smtp-Source: AG47ELvx/BDTEyY3wVMJthVjtqHjA0JdQn/BRzux40ggG6QkPvypanAXIdpa1W0wgmHmax6vNkbC
ARC-Seal: i=1; a=rsa-sha256; t=1521982812; cv=none;
        d=google.com; s=arc-20160816;
        b=LB74Vq6dTJ2ejcj0VZtaRgmtuSZxepenBzfvqKsj/0lLPANN39KzyF8KRS3StFzP+1
         01BwvQ9wmS6FOwU+tNWRdc9hXjM22EK9VUcJ26QxMQ+UTWvNDhkyD7kGEKDEBbgmS3VE
         uSYmbvgYYtDbVPDmC1ew7k//a/0uK9Aa8jAixxX/aHBc/1mtGtJuit8hhZOC+o2YObpQ
         Tb173CeArlh9w2atIsCV16jEyM4wry4tTL6+eNh9HYUwk6xz8ToBbuziSfYvDJaUx83O
         Kr+RiHbXFpm5FAfs+c5sldSpZ7ybLSkKLlUDZuKkhFmiyjCnwrMy4jmhXAMRD3K0RGcA
         7EMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=G4oWVCVoYdS6hlszMMBHzBP2+9jx5z/suOVqaC3OBaY=;
        b=M7i9w5RlvLFxVGtSntQidrSWUSJ1f8fea1bqLrduGoCWFY+W8cxXhlujohBKBKSbDT
         JnvpnKhgh0rGkdRGNUFnGUm10s3pDluT+yZQ2mq71vgahx+woZpqC//fslPyoxzJAoFP
         AT/Az9uWeAnr/xunKmfPczRfxCsY8NVRI/YmnxpPgSZcZV8vNbDhm90P6vIXFD3nJQ0G
         +ppA0vSYqGKlQEAwKE9mT/zFydwEih4T20PkVliNxN26YVQhKdZdDEb+MFqeWItTwJr+
         VRMRwesGUhstMNV3io1bsTAZ8BVyMnNC4U7nM/88AG/eRK9L7tMINRPbRdeuyeXrpauo
         PjSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 85.13.155.146 is neither permitted nor denied by best guess record for domain of marcus.wolf@smarthome-wolf.de) smtp.mailfrom=marcus.wolf@smarthome-wolf.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 85.13.155.146 is neither permitted nor denied by best guess record for domain of marcus.wolf@smarthome-wolf.de) smtp.mailfrom=marcus.wolf@smarthome-wolf.de
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Simon_Sandstr=c3=b6m?= <simon@nikanor.nu>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>, =?UTF-8?Q?Luca_S=c3=b6the?=
 <luca@acul.me>, Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>, Derek Robson
 <robsonde@gmail.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
 <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
 <20180323114254.GL31333@gavran.carpriv.carnet.hr>
 <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
 <20180323180027.GM31333@gavran.carpriv.carnet.hr>
 <20180323221821.GP31333@gavran.carpriv.carnet.hr>
From: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Message-ID: <8544b858-673f-0f59-0d8b-0474036068ce@smarthome-wolf.de>
Date: Sun, 25 Mar 2018 15:00:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323221821.GP31333@gavran.carpriv.carnet.hr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595721331728718925?=
X-GMAIL-MSGID: =?utf-8?q?1595914649678136876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Valentin,

> But I have an idea to remove this kfifo_reset call in pi433_write
> handling partial message writes:
> 
>   kfifo_reset(&device->tx_fifo); // TODO: maybe find a solution, not to discard already stored, valid entries
> 
> The writer could acquire the lock and than use kfifo_avail to check if
> there is enough space to write the whole message.  What do you think?

Unfortunaly I can't find the time to have a closer look on the code this
weekend - still busy with tax stuff :-(

Idea sounds great. I'll try to look at the code and think about it
during Easter hollidays.

Cheers,

Marcus

-- 
Smarthome-Wolf UG (haftungsbeschränkt)
Helene-Lange-Weg 23
80637 München
Amtsgericht München, HRB 223529
Umastzsteuer-ID: DE304719911
Geschäftsführer: Marcus Wolf
