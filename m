Return-Path: <herbert@gondor.apana.org.au>
X-Google-Smtp-Source: AG47ELs7dBx4Oot/vR32d9f7nc7GbxlThxSzHitNwSnISTJtJEC9/3+cE1l6zVBu6St6fXecv8p0
ARC-Seal: i=1; a=rsa-sha256; t=1520008448; cv=none;
        d=google.com; s=arc-20160816;
        b=JozL62i1X0kYrlNzs82U508hMar9PY+RY5aBc5f4JpCymzDdnrl4lUwoQR2ykGoDXH
         fyMcSisBd6lrXxEsqYtvYBKjmwnsmSqL75PTuwYnwwOdUREvTQslSqi95PHZ/V8RWotf
         mWoIxtoecC9+KYkw+F/+XF3u7Qy9fpt9bsz1Eg8TRSksBJ/EO1GRR6O8j5i+psCeqear
         CyARxtiiTzTpHGTTht9WjZpwiZLtrcWdD8XUzuKBbvmC7L0ESLBcH9DPHWaVdDz+MQoi
         IvnZQVeNLkyXDBJEufYyrCaqH8jnpnKxrPMfes1C38Sj29ggS2nkppLbDCwzQhhxl47V
         7g1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Gc8nqTvGwRBerotx3xNTWH1sree4ICuKLTmTT+0r1nA=;
        b=a8B948eD+kRlwUBtZ/++SZqK9vAGIreOlMeBaAyLQGZkp+KgfV/IFHRTe0EO2TaV5d
         f/upFJtDyVXZZeFsWAnWjWP2JcH64mXNqepppZ1tdstZrM/k1erOsrt/WSlMU510BsVX
         pc+sKsLNPkYIo5xuKTY78iRWM7eU2NsSoWADpmzmMCuPHOdsTEfWTGaTexKvGzQk1Dql
         sBnghJ8o6sAftAeigN7CDR1PCS1RosGY4NskQntak6vk3hg3pNg3ZpQxUUp5mRk+CHeH
         MBu+ohnxykMQt5LWdKiz/B3GOxvjeLaqRiQCLUw+QqttnhrpjL9wUnSI82I5vD24WyJ6
         dHAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Date: Sat, 3 Mar 2018 00:34:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Lionel Debieve <lionel.debieve@st.com>, Matt Mackall <mpm@selenic.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <rob.herring@linaro.org>, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>,
	Ludovic Barre <ludovic.barre@st.com>
Subject: Re: [PATCH Resend 0/5] hwrng: stm32 - Improvement for stm32-rng
Message-ID: <20180302163359.GB21579@gondor.apana.org.au>
References: <20180215130312.23612-1-lionel.debieve@st.com>
 <20180222140328.GE28447@gondor.apana.org.au>
 <8dcbcea1-78f7-27ff-66a0-a6180d32a05e@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dcbcea1-78f7-27ff-66a0-a6180d32a05e@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592472174804694074?=
X-GMAIL-MSGID: =?utf-8?q?1593844378381040260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 04:25:46PM +0100, Alexandre Torgue wrote:
> Hi
> 
> On 02/22/2018 03:03 PM, Herbert Xu wrote:
> >On Thu, Feb 15, 2018 at 02:03:07PM +0100, Lionel Debieve wrote:
> >>This set of patches add extended functionalities for stm32 rng
> >>driver.
> >>Patch #1 includes a reset during probe to avoid any error status
> >>which can occur during bootup process and keep safe rng integrity.
> >>
> >>Patch #3 adds a new property to manage the clock error detection
> >>feature which can be disabled on specific target.
> >>
> >>Patch #5 rework the timeout calculation for read value that was
> >>previously defined based on loop operation and is now based on
> >>timer.
> >
> >I should take only patches 1/3/5, right?
> 
> You could take all (dt-bindings + drivers part).

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
