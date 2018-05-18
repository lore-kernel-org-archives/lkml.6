Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AB8JxZqMsXGymUB8716fz8ANHDlFp3oqc4k7kyJKrIOU+NKmIbvblCA5ZAdP88aP7orzieaqGoXO
ARC-Seal: i=1; a=rsa-sha256; t=1526661442; cv=none;
        d=google.com; s=arc-20160816;
        b=GhPR0YeQEPiC0vcvIOTuYXf8L1sZSimrUQ1yiEH2bwyRmwSkC3E8mwgsjacPzKdmvA
         OzkFZxy+q34JdkMfp6V2SYRtTFM0H648uDQMqBlDWzlHFguN1exJyR7sIQLh7Ei4MX0z
         hYXpoPfu9beUGVUms120EvYGlu7U2DTjEHx8PTruZF75UqngeXbCji89nQyaRO9FdOfc
         SZ/joBdT+ZAwNarpjpRaPIO+adI5HlSjs/v//WR2bn3SLt6W6SUsI4hN0f6xH4nGSH2s
         RjhW7JMOODzOHt9b2r2dK+QDB61n8aMDZ2LicZMoEAuZ6KQMhjQNGAn2lMSPtde/qiuE
         Tu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=JlvAKZqbGsWJ+hHUDCxqXcJVaeor6tSatSeemrq+3LE=;
        b=LJ9bQ50/XT7EcLy9DRi5YPs117jXkAbPqU78IRRNg3ia8QeeYVydN1DcQh1TPLdlWt
         yElNYacVp7CFyhIdba6vBO9Dm1ODdIKXuwvLbJAC2R3q5SchXT0HuMc79K1i43g7CJ2b
         YcPWvmTIosRMpqrojvI989lsBXshoTYn3EkXbtVN5pmrLpL1pSO6GUORQ51tEXeBfZ5x
         asxkJ/0xsmSwTLM0KUmfyccOUvh9mMCbyDDqsYd1TccBH6Y/SQer9EdHZMKpXBIjB8Ev
         eMrLKh9rMaFIMQh/AxLDBjCtPHjZyNwjlaB6cEMaq+8sM7FrMl96MALzotfB63f5SDcJ
         tx/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=LAiXVmhQ;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=LAiXVmhQ;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix packet leaking in dual_mac
 mode
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju
	<naresh.kamboju@linaro.org>
CC: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <nsekhar@ti.com>, open list <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20180501174122.11323-1-grygorii.strashko@ti.com>
 <20180502.110841.378324128079268584.davem@davemloft.net>
 <CA+G9fYv5yXD4_hyUSxWra+gxux1NFv+sD2HgB7LyJ4E78bgh+A@mail.gmail.com>
 <20180517191037.GE504@kroah.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <9e2ef403-4b67-f141-aed7-9f18714e16a6@ti.com>
Date: Fri, 18 May 2018 11:37:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517191037.GE504@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600734413444103525?=
X-GMAIL-MSGID: =?utf-8?q?1600820548270783412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/17/2018 02:10 PM, Greg Kroah-Hartman wrote:
> On Thu, May 17, 2018 at 11:18:16PM +0530, Naresh Kamboju wrote:
>> On 2 May 2018 at 20:38, David Miller <davem@davemloft.net> wrote:
>>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>> Date: Tue, 1 May 2018 12:41:22 -0500
>> <trim>
>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>
>>> Applied and queued up for -stable, thank you.
>>
>> 4.4 stable-rc build failed for arm32.
>> MACHINE=am57xx-evm
>>
>> Build error log:
>> --------------------
>> drivers/net/ethernet/ti/cpsw.c:
>>   In function 'cpsw_add_dual_emac_def_ale_entries':
>> drivers/net/ethernet/ti/cpsw.c:1112:23:
>>   error: 'cpsw' undeclared (first use in this function)
>>     cpsw_ale_control_set(cpsw->ale, slave_port,
>>                          ^~~~
>> drivers/net/ethernet/ti/cpsw.c:1112:23: note:
>>   each undeclared identifier is reported only once for each function it appears
>>   in
>> scripts/Makefile.build:269: recipe for target 'drivers/net/ethernet/ti/cpsw.o'
>>   failed
>>   make[6]: *** [drivers/net/ethernet/ti/cpsw.o] Error 1
>> scripts/Makefile.build:476: recipe for target 'drivers/net/ethernet/ti' failed
>>   make[5]: *** [drivers/net/ethernet/ti] Error 2
>>
> 
> Now dropped, it's nice to see I got 3 reports about this :)
> 

Sry, my bad. I've tested till 4.4 if it can be applied without 
conflicts, but not tested build.

-- 
regards,
-grygorii
