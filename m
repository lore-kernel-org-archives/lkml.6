Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AG47ELtJHYazXE9A/IIL0dtBt9p3MCZBE+e2DHXJc2Bp7p2lNtt9Nupxk4pqLkvzS5FjupFrY7ay
ARC-Seal: i=1; a=rsa-sha256; t=1520355395; cv=none;
        d=google.com; s=arc-20160816;
        b=H0igNt7osOPOGHLet5xgU38uSmnOn4cEJNS2J8m4VgyPuwMcw9eqGSLdAANrsEu25z
         K7iEu9/nZGlUkOwYEcvERIFrfM3hLEs0preMB0W3wulD6h2DMFdUCfe0C3ua0QHTofYs
         aBCDDWVb75jc8y1L70fgXxxb6NHCOE9ObffdonVN3FiP3Svxp8lxKt1KD0/2StGBBmJF
         V9NW67nvqTO7qgQcM3wecYOuUqA26mH9avlCMtzgR0yZRxClMmMdVl64/rVvMsmoY/um
         oR+ulWHtqJ17Pc7e76Mf/6vfniI5Y4wcua7d0VT3SGy6Jn3pfz2/yMyLBsYHz4A7h97/
         BknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=8Cg3Zxy1nsyO77NqU5ysw4PQwLO/iK35yjTANHrnXC8=;
        b=u0IiQ8eRVPzDRHawaGDxKTzj+Afrj8FSviEU4QQg1yC+6zjZxeeH4dx0vunyIDBCo7
         FjkRRDw74p4SpKGUSJlqK9jj8yDTrS48mALr6WLHIB3dOM+ahYN39dT21HiJufxVCDEK
         FkPK6yQhzNlUBRU7V7ZY/mGsMFSFcx4Q4k+3oD2VrarfjimrRgtZ8Dcoif/Mwg7GYNY4
         ClcGi5+L2sLMK1rIP8jVk7dcHvvC7dv6EiRenzd5HP8Xz96Toyh4fx7NPp9eKvlkc0ty
         MZwfzBtBEw+0cJkmCbf01w1zza11sxjb6ILIbmpBV5LQIpHLFlmhjttbw3uEVHGDuozQ
         +rJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Dan Douglass <dan.douglass@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
References: <20180305190824.847-1-logang@deltatee.com>
 <20180305190824.847-7-logang@deltatee.com>
 <VI1PR0402MB33422D83AE168D84FDED974698D90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <06d07fd5-a73c-34b0-079c-f4b44ef7a0cb@deltatee.com>
Date: Tue, 6 Mar 2018 09:56:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB33422D83AE168D84FDED974698D90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: davem@davemloft.net, herbert@gondor.apana.org.au, dan.douglass@nxp.com, andy.shevchenko@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org, linux-ntb@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, horia.geanta@nxp.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v11 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594125902706060258?=
X-GMAIL-MSGID: =?utf-8?q?1594208178783873554?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 06/03/18 05:37 AM, Horia Geantã wrote:
> On 3/5/2018 9:08 PM, Logan Gunthorpe wrote:
>> Clean up the extra ifdefs which defined the wr_reg64 and rd_reg64
>> functions in non-64bit cases in favour of the new common
>> io-64-nonatomic-lo-hi header.
>>
>> To be consistent with CAAM engine HW spec: in case of 64-bit registers,
>> irrespective of device endianness, the lower address should be read from
>> / written to first, followed by the upper address. Indeed the I/O
>> accessors in CAAM driver currently don't follow the spec, however this
>> is a good opportunity to fix the code.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Horia Geantã <horia.geanta@nxp.com>
>> Cc: Dan Douglass <dan.douglass@nxp.com>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: "David S. Miller" <davem@davemloft.net>
> Reviewed-by: Horia Geantã <horia.geanta@nxp.com>
> 
> Please get used to carrying Reviewed-bys from previous iterations when patches
> stay the same:

Sorry, I usually do this but I must have missed the email. Thanks.

Logan
