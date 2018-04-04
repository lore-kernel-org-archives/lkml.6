Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AIpwx4/KjTbP2mKGuUHdfXDZDF1L4/SaAxPJq8DUq8proJZn9as+0NJhCqTCBK0GhRpEqcx/mHYT
ARC-Seal: i=1; a=rsa-sha256; t=1522857297; cv=none;
        d=google.com; s=arc-20160816;
        b=fPyFANGNS8dFP0aQH9EuOXbfqlS3G9DYYT8zMORU7asLiTM92jSPDVUC3kypk/GK5i
         /BeIQIlHMz/AiASt3FeUmpmtrxSPuczPkpRAY1VlphlJnwqTqoOfuwNeDUdE75E2Of5l
         IJTNWF5fQbcOG1oS4hhMgNSmdRyQTSRNowNvll/xQ8Qs6epYFd5dj8EZp7d8shBCqFBj
         gSw8WdBQyBEqoGAqnqPkk+Ub8tkdfyooXY0LfiUIOOGbNzIGusixoY1Hu5jLFHWO5bpy
         m+SjsTy84TG7ZrYD5fdC0SxqLOytUjkpTH1Da6z3hgzjMGWc37tHUfFMU+877HNgCTQc
         6Geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=u+jehJXtVcJNFz9/2l+oAir5XDIH9v277/3uWsZZKDY=;
        b=ytY1v5cDCtRtFxHf+c0mZlU1j1YhSByTZ7uKK2sjs5V8/N9HU2cAsH3sBq1oM2d5eC
         o6D/ZFBR2rAabZecWG4usggSaZdD6mmjs5mdN4m5dN5UAyTPsyL8B1xeolmyHuDB0eFf
         TsRUyaX7vGU3V7aJ4sFPnK6iYrYjcae2xc3mRrcWiB6Avk1GFYBHW4G+gEROC7igMMuL
         RWWfYorHHgp3xC6TROdkPc8EDpuUX/4HpqmeJC4IDozWyGxLCdQFyDjRKIK3vc4VHuxg
         dGhOBTzJw7ytGkTjvPSIqfoODV7Cxzsd1ql46Uf5y9FvFE0N+U1PbgcvJeNgzXvyzc2l
         7cQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-ntb@googlegroups.com,
 linux-crypto@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, akpm@linux-foundation.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, =?UTF-8?Q?Horia_Geant=c4=83?=
 <horia.geanta@nxp.com>
References: <20180327230834.5931-1-logang@deltatee.com>
 <87r2nvmf3b.fsf@concordia.ellerman.id.au>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <515f5c92-ac02-6e09-830e-46ea4d462652@deltatee.com>
Date: Wed, 4 Apr 2018 09:54:41 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87r2nvmf3b.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: horia.geanta@nxp.com, andy.shevchenko@gmail.com, arnd@arndb.de, akpm@linux-foundation.org, gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org, linux-ntb@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mpe@ellerman.id.au
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v15 0/9] Add io{read|write}64 to io-64-atomic headers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596134127286634027?=
X-GMAIL-MSGID: =?utf-8?q?1596831613781259613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/4/2018 4:38 AM, Michael Ellerman wrote:
> What's the plan for getting it merged? Seems we don't have one?

Yeah, so far there is no plan. I'm not really sure who's attention I 
need to get or how to get it.

> Given it touches two arches and generic stuff and drivers and crypto,
> it's a bit of a mess to merge. It's not really something I want to merge
> via the powerpc tree.

Understood.

> Is there any way to split it? I couldn't immediately see what the hard
> dependencies were between the patches.

Yes, a couple of patches have already been taken by their maintainers 
over the last few cycles.

> eg. It looks like I could take the two powerpc patches on their own for
> 4.17, and then the rest could go via other trees?

Yup! If you can take the powerpc patches I can keep trying to get the 
rest in. They are largely independent and shouldn't really change 
anything without the following patches.

> Is patch 1 stand alone?

Essentially, yes, but patch 5 depends on it seeing it's changing the 
same area and is trying to avoid creating the same kbuild warnings that 
patch 1 suppresses.

> The other option is to ask Andrew Morton to take it, as he often carries
> these cross-tree type series.

Thanks for the tip! I'll copy him when I repost it after the merge window.

Logan
