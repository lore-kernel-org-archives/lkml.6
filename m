Return-Path: <herbert@gondor.apana.org.au>
X-Google-Smtp-Source: AG47ELsLyLkA5JE9j237nCte2+7H9HHXH7JILVTyadSZlUydMG879xPmQKPxTRx1XjkkMUMdcjHF
ARC-Seal: i=1; a=rsa-sha256; t=1520008447; cv=none;
        d=google.com; s=arc-20160816;
        b=ZkMNQ6vLInZS1kEPJPIjZT2XER/WTuefU9TlT2a7KV3f6vRQ63pGVpWSKL3tNj7/jT
         9DnjM3SSFrnM6rakVDPnThYEpAYEdxIDhyPLUOsvDLBhse/oCMfKXgBDUxk+MIffKNne
         c8Vu3+Rfv7NR+W6xEGU79K0wyxEA3uyji39xO7WoQbTfYOyI2fJoWD20O4DEjqnUGgLA
         fALqAF9yJBtadyeKTejY20It0KGvdW75cknsor+f00zMHKqqlxISNTA+3G277ahKmHhY
         j9HbL/BLSYASZHGIMxl9QS5lui0cCESkI7zB/GIWFrqTB5aNZzHwAgPBByvXVdGIlF6T
         DaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=d5hZWiSYMIMKxqJY1lmm54oQLg5joLmoVGy96l6zyRM=;
        b=S1ikvmw0RF5s39167vnk0ywx41iMJyQpcusOGnDFKkTuCERmeNdb0ObQLfSxlUU1OM
         bzAsUP3+7DbvI3cJd6wJ5YfB4nX5oyCDUMg/j43eviCd1bE/lO1VRg7qiMc7FioZ24BY
         /6ldPjXSh/Z3AUWWDighMFPJiDX0jFH5hSc+E+82D3mSQ/zSkj3PSk+O5J2PWNu8Lqjd
         zJ54z50xmQND9o7Gi1tVjZSgzp+zNkBdHpO5L1TJrJiH60+X19vJbi+q4Okkb9teXlKp
         peeQkFngZi/LHshFOkGmYRwHQtiQXFslqcM+UJNqLc7RIRFxw3hA4OpGGP/mWDCkpHse
         J8Qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Date: Sat, 3 Mar 2018 00:33:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lionel Debieve <lionel.debieve@st.com>
Cc: Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Rob Herring <rob.herring@linaro.org>, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>,
	Ludovic Barre <ludovic.barre@st.com>
Subject: Re: [PATCH Resend 0/5] hwrng: stm32 - Improvement for stm32-rng
Message-ID: <20180302163350.GA21579@gondor.apana.org.au>
References: <20180215130312.23612-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215130312.23612-1-lionel.debieve@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592472174804694074?=
X-GMAIL-MSGID: =?utf-8?q?1593844377445713720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 02:03:07PM +0100, Lionel Debieve wrote:
> This set of patches add extended functionalities for stm32 rng
> driver.
> Patch #1 includes a reset during probe to avoid any error status
> which can occur during bootup process and keep safe rng integrity.
> 
> Patch #3 adds a new property to manage the clock error detection
> feature which can be disabled on specific target.
> 
> Patch #5 rework the timeout calculation for read value that was
> previously defined based on loop operation and is now based on
> timer.
> 
> Lionel Debieve (5):
>   hwrng: stm32 - add reset during probe
>   dt-bindings: rng: add reset node for stm32
>   hwrng: stm32 - allow disable clock error detection
>   dt-bindings: rng: add clock detection error for stm32
>   hwrng: stm32 - rework read timeout calculation
> 
>  .../devicetree/bindings/rng/st,stm32-rng.txt       |  4 ++
>  drivers/char/hw_random/stm32-rng.c                 | 44 ++++++++++++++--------
>  2 files changed, 32 insertions(+), 16 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
