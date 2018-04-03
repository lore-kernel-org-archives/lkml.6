Return-Path: <Matt.Redfearn@mips.com>
X-Google-Smtp-Source: AIpwx4+Vwv253iI1xXjFNJkcoMHiYhBYDst+rqjmTPGjOsbdVGNMHgRY9jsiBXQFMb3hyi3ZAIbt
ARC-Seal: i=1; a=rsa-sha256; t=1522747418; cv=none;
        d=google.com; s=arc-20160816;
        b=exoTnQukw+yEWU2iyYeey11v3shvkRu1360oSFhhVD5WjDkJZ8Gcxb6h5CDY/KRHiX
         Ou9SxPF99f90rZfKVFwnEkYkrhn9drnv83iVYnAzZkOHGlqvn8k3iPb1xJH634H+h5LB
         AdAOmB4C0N2nIlEUOrae0dL8rYOl3mCfSWhx6ai2NoP2aAEWtcL/ukSx9bGInU9zzSec
         85HpxEAY/F0GmdB4kuRAVNEe57+h8+auHPf01IudJk077DKKXr4JhUoyafBj2lZrdrrD
         /rMD7W6GWZrguD5IIKL6oS/EwAdplJgHMWstMbzE+wVINRlbfV+C8h0IhsSAAKLaxshH
         CKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=U7zgpF701YOhY97C+JevmW7ddEfEmGMwrm8ZlgHLntM=;
        b=y7uWyDDroYS7D9zjWvsGrKlEZWYaz+RbM1htrsBJoofa3NgUd2ZdI1989GdFte5zgV
         ln/a4AVDjltn/QTlB7mi/lP4xliLYWVbHX/hlY15IVfa3Vg1mNk28Et9Lo6BgRZaMpt9
         0Dm76CkClJJdjQkX/82j/fTGdMPDvCX/jnAMspj7olgfQeK/XdS2pmW3+lcA3FcWBGLc
         1AXUMp6C29GIbmH4/UnBM2x4CiMKB456nio6U4gfYOiKcN3c/a0Hlc+72pHJpkIoy222
         0nhGEKrgcPMWs8xcW2ULrug5e+UOsSqlTyRUta3UhZrprrBQpulHpUDapAsXriNbdUgV
         2dxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.150.225 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.150.225 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
Subject: Re: [PATCH v4 3/3] MIPS: use generic GCC library routines from lib/
To: James Hogan <jhogan@kernel.org>
CC: Palmer Dabbelt <palmer@sifive.com>, Antony Pavlov
	<antonynpavlov@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
	<linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Paul Burton
	<paul.burton@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>
References: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
 <1522320083-27818-3-git-send-email-matt.redfearn@mips.com>
 <20180403085354.GC31222@saruman>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <b0eaccce-a316-0515-cab7-a026be1720b1@mips.com>
Date: Tue, 3 Apr 2018 10:23:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403085354.GC31222@saruman>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1522747382-298552-8656-22664-1
X-BESS-VER: 2018.4-r1803302247
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191650
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
	0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596278698028411080?=
X-GMAIL-MSGID: =?utf-8?q?1596716396182411087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/04/18 09:53, James Hogan wrote:
> On Thu, Mar 29, 2018 at 11:41:23AM +0100, Matt Redfearn wrote:
>> This commit removes several generic GCC library routines from
>> arch/mips/lib/ in favour of similar routines from lib/.
> 
>> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
>> index e84e12655fa8..6537e022ef62 100644
>> --- a/arch/mips/lib/Makefile
>> +++ b/arch/mips/lib/Makefile
>> @@ -16,5 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
>>   obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
>>   
>>   # libgcc-style stuff needed in the kernel
>> -obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o multi3.o \
>> -	 ucmpdi2.o
>> +obj-y += bswapsi.o bswapdi.o multi3.o
> 
> Have you missed deleting the files?

Oops, got lost during the rebase :-/

Thanks,
Matt

> 
> Cheers
> James
> 
