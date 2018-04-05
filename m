Return-Path: <stuyoder@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522902300; cv=none;
        d=google.com; s=arc-20160816;
        b=vXx4gPBg6Hn6+GhxESiSjaq3lx10Iykc0KlavmcyEUQpP5sFeuxgdkYsIUiXu68PoW
         u8XQilnQE5U9xpk7rZ02Jf5gsvCJD+zkiNhbLW8FG2lRRGW8vuwQiLFvDjI1loxSwXXs
         PCQujrLPYf6XgapXacs46BY4HbMWGvC2W5/q1fyxQVSvWGb/bpO/Ia1Y6wGG1QnZQSDc
         GgEig1czYkJFamRU0Ae9cINNMFyuI0nYDGc3vWooTj9mh+FwfCWlGwo2MPOcUHI0JXEr
         SxpyaVM2FxtpRf6ZrqNPy5HaMJeBEcHsV0vnFQFXoB/DZEBfX7YcEZhpz5tOc9kKoQS2
         DMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=xSmUBV8c16x47J/FWjcBl7ulgxoDjd/BukH+enNQrZ8=;
        b=Dv/H7LVgZnI1KSAU7fyfdX3aEfhUW5BySwl8vRbEclCRFlZ3g2C54vgvSyYCAoEoyD
         E0alAIbO+OzMTm+Q36FZFQiXorv9FYpEwqCvfprnXTrKSnmfU9jtHgbc8vzwi4nIvs9o
         u/lRNMOO0znhKFwYse1LsBaEbGznnlMEjleOMgt3tWVQtSgt8MPfazeIGXMUrC7qJayC
         B0xDLuE8VxFTRK9dl3C3ghqTJsrqiNysXO1ERWREqG+YkbutElA/fa9XoY+9zs+y9WjA
         J3wtpnVUeSko/pm5NX/gfiF2mWjNzzNFypljEQl8uO3gj9ob6HdG9YQT9hDh+NLpaxpW
         KDwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZJ0M4D5p;
       spf=pass (google.com: domain of stuyoder@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=stuyoder@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZJ0M4D5p;
       spf=pass (google.com: domain of stuyoder@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=stuyoder@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49FllmBk/jiqvt+qoTgoXEKnxS2EBRwBmdsYx/kUOMNGlqK5jnkxPpUIahfBSYoeQkud66IoEA5mJ2xprUp+xE=
MIME-Version: 1.0
In-Reply-To: <20180404124246.GA20869@lunn.ch>
References: <cover.1521818402.git.ioana.ciornei@nxp.com> <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch> <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch>
From: Stuart Yoder <stuyoder@gmail.com>
Date: Wed, 4 Apr 2018 23:24:59 -0500
Message-ID: <CAEac7tYkCck8kUY4b0F437XbKS5Vc2n-WWvkUXpQhZvyXxyGLg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	gregkh <gregkh@linuxfoundation.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596878802819804960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 7:42 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> I hear you.  It is more complicated this way...having all these individual
>> objects vs just a single "bundle" of them that represents a NIC.  But, that's
>> the way the DPAA2 hardware is, and we're implementing kernel support for
>> the hardware as it is.
>
> Hi Stuart
>
> I see we are not making any progress here.
>
> So what i suggest is you post the kernel code and configuration tool
> concept to netdev for a full review. You want reviews from David
> Miller, Jiri Pirko, Jakub Kicinski, David Ahern, etc.

I know Ioana has other feedback she is addressing so a respin will be coming
soon, and she can include those additional reviewers.

Thanks,
Stuart
