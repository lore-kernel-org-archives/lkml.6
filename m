Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELsHaoPtUThBe87IZkKILqVPtMd0ujASlxkvm1E3jY1vzpbstdSQ54hnz0AZGpof/Tj98Ms+
ARC-Seal: i=1; a=rsa-sha256; t=1521136656; cv=none;
        d=google.com; s=arc-20160816;
        b=Yw9pEZy01s0+hFpRIPY2HwgthZMJ4uCXTvzWRGBQZ5BeYqJkxb1N+mmfkEilLKvoYu
         31yaDBuS7OU1V0r3IOaP5SClNH8VqILC06cvbI28Ylwek6bGMX7rvGAiFwCE94ihxkVd
         Rp0AEtmoBoKXOirNpZKELm9xVQuL/kdRWaQY83X1ZC4HmBit3KHDcIXFE4NaSMGTA0/t
         LlZbQ/g1GChSWrY3DFgehINUEeZtIDiSL2C1kbyjDNA0IPnLTQT5bcvnS/U4APCKui+O
         HDnUmA5yCr6kIImv57ME4jji0jXLpP04z2NsepChN/b3zsbx5wC864Z+PGoFxAbD9Z5o
         v1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=4M4z3/LKTVPNt1GASs/20+5gAz/ZFS/BJf//Z1s4Wm4=;
        b=nHMwVDE/LtAc/ClN21nuQ/Ypse2p3lf+vhXeMDIJmn2UlCxRbGIy1epglSxBeLKH4F
         V8yQ+alOoxrWzGYIPAJ7ybC6q7zczkwGBKrQLhGESKeV2PENfJ+GQvtLXWq8ak22SZiT
         E3FkORbeATp3fSiBYcKkFaEc+D6uYR/oyuWb6IC60v0us4NlxXUSgYPk+MWeSozLXpQP
         EH10OxTGkSZwsQwG4VLoCWAaX5fHEixTGgvI69vSlb/9X+WfpXAqt+qE/4LbhshgU0lV
         UmwJoLlnd1PSmK1fe7dXdKP0dx/yvUjmZki+BktwtNNSdv8dIOyzx+YvsAShgMa1SZff
         BlOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, Rajan Vaja
 <RAJANV@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>
Subject: Re: [PATCH v5 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
To: Jolly Shah <JOLLYS@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-3-git-send-email-jollys@xilinx.com>
 <dab419e8-3afe-5bfe-240e-e9ee4f2300f2@arm.com>
 <DM2PR0201MB076735E33069DC6F0C84EFDCB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <2fb8ee8c-35ac-b7e6-e691-84464b0c8745@arm.com>
 <DM2PR0201MB07673298E409D07F0F748316B8D30@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <4cff1193-5345-0531-d81e-0dd6e0633b19@arm.com>
 <DM2PR0201MB0767229750776EF2AF8455F3B8D00@DM2PR0201MB0767.namprd02.prod.outlook.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <0a63e5d5-17b6-0be3-88e2-c8e56bcdfeb0@arm.com>
Date: Thu, 15 Mar 2018 17:57:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <DM2PR0201MB0767229750776EF2AF8455F3B8D00@DM2PR0201MB0767.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948934312896009?=
X-GMAIL-MSGID: =?utf-8?q?1595027390278797359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 15/03/18 17:53, Jolly Shah wrote:
> Hi Sudeep,
> 

[...]

>>
>> It's opposite, you are just adding whole lot of functions/APIs here with out the
>> users of those APIs. I am unable to visualise how they are getting used. So for
>> me even if you just add handful of above APIs with drivers making call to each
>> one of them along with it, I can better understand it. Without any usage of these
>> APIs in this series, I fail to understand the need of it.
>> So NACK to this patch without the users of the APIs introduced here.
>>
> 
> Ok. I will break series with users in next version.
> 

Thanks. Don't add any APIs which are not used by drivers in the series.
We don't want the whole set of APIs in that structure lying around in
the kernel without users.

-- 
Regards,
Sudeep
