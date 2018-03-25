Return-Path: <marcus.wolf@smarthome-wolf.de>
X-Google-Smtp-Source: AG47ELsUiJ+seBU1phrpPVaHaTVqap+vLzDhw+htH7ekslQ9ICcrm+4GLm5ZyKkVardykhxLYo0g
ARC-Seal: i=1; a=rsa-sha256; t=1521983574; cv=none;
        d=google.com; s=arc-20160816;
        b=vsU4QKqHCrHYZhrr3D291aAt0CcKmY0yqOU5aGSPoRh75k5VbAtLO/6y2MvvMoI5qQ
         lzsvJl4K83T9csFOmrwRRjN4G7fQbMuVmTpU8LHLVSbMvsf/+Wiqds2LYwsOo9bYP9H8
         5CfslIDsBCN8pXGpMQiMAeV6IFQNHj1HLBt+FP1Le4jVKg3H58X0TOi/m/w88dYf0wks
         sLHBJrcqDJvfFyUWp0PuuqHR6FyaJjc4Qbdpvutz5WudOcqKz+G9sStTcv/vf/uk6Q0+
         GcdlPn46h45efsUr6swSzTqG8K8I35LWpQcMlCvTP/XH6Z8/PFddmHXBdiPkYZP7q6eR
         voIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=uVWFfR94tfoBqre8Uf82C2f9izkVx7liF6RBKVX8tIo=;
        b=aruNEULAntGGMFEXOA3W2Q89rdKs4RcwjaU1EP52Qx9bwVI2hIa5ebhsgA0Ta+12vc
         SuOUTE0gI77Gpm9y8eEWAXqru+arfv0M0zfKqMeYCEokP7ThZZ3Hf8vxgCB7GCSZsf37
         ArxrodQg9jqE8b0kYFG13t7vyOA8hogt5WMCtpF5VvtflEItSUuwdet0WQI2cJ+mY+75
         yQ4WdlYwFlN0z+6SvwmmgqgxzDURyqyv613CauC+dYjJT7+SIldrFVwHvBkH5BUoQh03
         nVjxlhyXRa1e26tQDCTEe8faPwRfd3GSQIHsqF831FBCLz7PTX7JPuCD0eTJ2PcQeRCN
         vTZw==
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
 <8544b858-673f-0f59-0d8b-0474036068ce@smarthome-wolf.de>
 <20180325130944.GU31333@gavran.carpriv.carnet.hr>
From: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Message-ID: <8eba67bc-7480-f07e-9022-1aa19a4881f5@smarthome-wolf.de>
Date: Sun, 25 Mar 2018 15:12:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180325130944.GU31333@gavran.carpriv.carnet.hr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595721331728718925?=
X-GMAIL-MSGID: =?utf-8?q?1595915449069471397?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Valentin,

I am not at home the next two weeks. So I can do a codereading on
Easter, but testing will not take place earlier then mid/end of April :-(

If you are interested, I can provide you an engineering sample of Pi433.

Cheers,

Marcus

Am 25.03.2018 um 15:09 schrieb Valentin Vidic:
> On Sun, Mar 25, 2018 at 03:00:09PM +0200, Marcus Wolf wrote:
>> Unfortunaly I can't find the time to have a closer look on the code this
>> weekend - still busy with tax stuff :-(
>>
>> Idea sounds great. I'll try to look at the code and think about it
>> during Easter hollidays.
> 
> No problem, there is no hurry. But please do test the patch I sent yesterday:
> 
>   [PATCH] staging: pi433: cleanup tx_fifo locking
> 
> As I don't have the hardware this is just compile tested now :)
> 

-- 
Smarthome-Wolf UG (haftungsbeschränkt)
Helene-Lange-Weg 23
80637 München
Amtsgericht München, HRB 223529
Umastzsteuer-ID: DE304719911
Geschäftsführer: Marcus Wolf
