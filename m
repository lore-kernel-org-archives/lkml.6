Return-Path: <marcus.wolf@smarthome-wolf.de>
X-Google-Smtp-Source: AIpwx4/l+FcnjoFNEBjTGjeK5xDkSAiEzPPi+eOJQhzB/Yjf1nl55YkDmLNK2bZ7/5mqvM1sguwa
ARC-Seal: i=1; a=rsa-sha256; t=1524129920; cv=none;
        d=google.com; s=arc-20160816;
        b=JvEORU/9coE3dozKF1LpkwbJkeA9/naoZTZkvY1oAsVcgzzXqbp6d4OxBU/CgveznI
         EPDUcK7TgsJch6pK7bcNEMRciPM6yGOwIW2fvi+3IlzsQM5HXVSYzBy2j/eynLt69d+s
         HPNC+OQNVq5Gtlww7s+pW3cv9ecePLb8GrDyQF609w0wKGaE9PhKWnFVgJSshK0yagrZ
         H/iXC7GqqdgQPO/a27cPWnOmmv1J3+PRx1hUJpno7Q+amq2ivYexCz5TBXPU4QMIodqC
         +ZoQgLrgFFrMwIfHdFy/Rypzet+FElRiLUzsLhylvNV1RYvByA7ly7iyhhQsHZg52Not
         OEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:openpgp:from:references:cc:to:subject
         :arc-authentication-results;
        bh=h0P+BY6i1b3FjMXYhH1dfDx1eVPE3rRPwWkB3iK53S0=;
        b=e/ehFnitLQ3anUgyXVLnH77/lgMx1RtpqZ9zwIsdt8SMvLFaxQW28GpQSJUMvZ4WR6
         T04IRQc+c9z1nmUOEO9VqXjzUVYwsw4zeq5TKWqv6H/KJqmggE+s5LtXSe58/hPhmQrM
         C9YkcYkF+Im0C1YsDrDr4mRUyFOMDJtkHgdxzHLGWvje6/4++wtXVK1ulo7ThERer9/Y
         jt3gz02Gd2kLzhY2ZF9kv9qjmYzLDn3PEDZ1iUhoRDl/cIyZOLc0kEdOp85n4E/4r/mw
         2IiEAYy5mhIBvW8fPASuyH94QwSKPTQfJqJFAYb7XAOyxz3YlS5d0tX6/rZxz54j7faY
         jLHA==
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
References: <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
 <20180323114254.GL31333@gavran.carpriv.carnet.hr>
 <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
 <20180323180027.GM31333@gavran.carpriv.carnet.hr>
 <20180323221821.GP31333@gavran.carpriv.carnet.hr>
 <8544b858-673f-0f59-0d8b-0474036068ce@smarthome-wolf.de>
 <20180325130944.GU31333@gavran.carpriv.carnet.hr>
 <8eba67bc-7480-f07e-9022-1aa19a4881f5@smarthome-wolf.de>
 <20180325142414.GW31333@gavran.carpriv.carnet.hr>
 <849553ae-5f62-0a06-f545-4d0fbaa513c3@smarthome-wolf.de>
 <20180412171504.GU3257@gavran.carpriv.carnet.hr>
From: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Openpgp: preference=signencrypt
Message-ID: <61ce1de5-6562-2843-7e63-6a15c16b42a8@smarthome-wolf.de>
Date: Thu, 19 Apr 2018 11:25:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412171504.GU3257@gavran.carpriv.carnet.hr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595721331728718925?=
X-GMAIL-MSGID: =?utf-8?q?1598166055777316984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Am 12.04.2018 um 19:15 schrieb Valentin Vidic:
> On Sun, Apr 08, 2018 at 04:15:30PM +0200, Marcus Wolf wrote:
>> The hardware of Pi433 is working with every Raspberry Pi (on zero, you
>> need to solder the GPIO-pins) and with several other fruits like banana
>> pi. The only thing is, that you need different versions of the driver,
>> according to the processor, mounted on your fruit.
>>
>> If you'd like to test more then ther is no hang up or crash, you will
>> need a second party. You could use a 433MHz socket for testing TX or a
>> 433 thermometer for testing RX. An example code for communication with a
>> socket is available on the Pi433 productpage (www.pi433.de). The sample
>> for the thermometer isn't published yet (as always lack of time).
>>
>> If you want to test more deeply (using different features of the Rf69
>> chip or even do some long time testing, you have more options, if you
>> use to Pis with Pi433.
>>
>> Just let me know, what you'd like to do and what equipment, you need.
> 
> At the moment I have Rpi2 but not any other 433MHz equipment, so I
> could only do some basic testing unfortunately.  In case I get the
> new Rpi3 some time soon I would be able to do something better.
> 
Hi Valentin,



let me know, what you like to have. For sure with just one station and
no other 433MHz equipment, options for testing are quite limited.



Marcus

-- 
Smarthome-Wolf UG (haftungsbeschränkt)
Helene-Lange-Weg 23
80637 München
Amtsgericht München, HRB 223529
Umastzsteuer-ID: DE304719911
Geschäftsführer: Marcus Wolf
