Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525751434; cv=none;
        d=google.com; s=arc-20160816;
        b=iBxXwinYe6+7HoLiYyRrYb4JkZeJgRP5VyM7+iQn+4eb6KUz55biXrz/50gMWUZXHL
         OkxWFoX0L3gihHiyHIWTSZZJmyegkSqLmNSdK10r/yAL5MY+SrS+B0XUuc/CNIQLbrGN
         2Ax/xrNoya8yy+3t4oLY8ODFRSzi9tgQnf3Xij+LC4JVeRF95OCCTAkOJWz9EXGyo770
         tBW7meDRYrJNeAl2TY6bXgs8OwTVCHVpS61B6oMumP6+neNNk08kUT9DPMYDbJn/rB6m
         zFrGKp9MaBK6pHSrpvI2ipMYQ67/+J8EKVl6nUOtn9RSefywh61MXywB1e09IB7EQQho
         tTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=J1qEEEG3I2BCK5yhoRn+O+z7Pmqxs4kA6jaiWaLIE7g=;
        b=enQ2NUlPFjbb2/4R82yooj+AcCQPgHYfZ2335HHLkwmmRPuPiTVn7W7oqo296axZo7
         Y59bAgbIXSNE9osroDxOM190cyVUZ7uKwP+Xqpg/RHulmqnklrTEttrZ6FD+diqqYFDt
         PuR9nv4G+tbkkswetrEHh1YXjFfsKcMsCdvtgJfiWzK+2FCOw96gVjoHU5mSEOnypLO7
         eKaoc0DI8xGTe/9CSoKJP6wCA4ec7r4w24VZDLbJ4uO2VpQkit1PhSTVcnNwbj1iXv06
         PMkmr7TqHoD6M2kqbOicIaSVCWueEzEXRkbj65zh2WEtMesQGrLDRvgXP942HBlcVQM1
         rniQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kXTxNawl;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kXTxNawl;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrw1tSyhdAX2JdpBFTBhJdyHAiJak2E+cTURLDy9svtgvCkQTb4tKxRXehdOPib/WUtsRo2Cg==
Date: Tue, 8 May 2018 13:50:19 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com, corbet@lwn.net
Subject: Re: [PATCH v2 6/7] ocxl: Add an IOCTL so userspace knows what CPU
 features are available
Message-ID: <20180508135019.3e08d57a@roar.ozlabs.ibm.com>
In-Reply-To: <1525740115.7796.46.camel@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
	<20180418010810.30937-1-alastair@au1.ibm.com>
	<20180418010810.30937-7-alastair@au1.ibm.com>
	<eec7dceb-0b25-8644-7f32-3700c3c4ed46@linux.ibm.com>
	<1525740115.7796.46.camel@au1.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598044369272237673?=
X-GMAIL-MSGID: =?utf-8?q?1599866336608065107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 08 May 2018 10:41:55 +1000
"Alastair D'Silva" <alastair@au1.ibm.com> wrote:

> On Mon, 2018-05-07 at 20:14 +0200, Frederic Barrat wrote:
> > 
> > Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :  
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > In order for a userspace AFU driver to call the Power9 specific
> > > OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can actually
> > > make that call.
> > > 
> > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > ---
> > >   Documentation/accelerators/ocxl.rst |  1 -
> > >   drivers/misc/ocxl/file.c            | 25
> > > +++++++++++++++++++++++++
> > >   include/uapi/misc/ocxl.h            |  4 ++++
> > >   3 files changed, 29 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/accelerators/ocxl.rst
> > > b/Documentation/accelerators/ocxl.rst
> > > index ddcc58d01cfb..7904adcc07fd 100644
> > > --- a/Documentation/accelerators/ocxl.rst
> > > +++ b/Documentation/accelerators/ocxl.rst
> > > @@ -157,7 +157,6 @@ OCXL_IOCTL_GET_METADATA:
> > >     Obtains configuration information from the card, such at the
> > > size of
> > >     MMIO areas, the AFU version, and the PASID for the current
> > > context.
> > > 
> > > -  
> > 
> > 
> > Intended?
> > 
> > Other than that,
> > Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> >   
> 
> Nope, I'll fix that, thanks.
> 

Just to be clear, this is for OCXL features. I would just make that
explicit in the title (s/CPU/OCXL).

Thanks,
Nick
