Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AG47ELsYCGdh5BOQg63fLCUpSs9DZoAJtGE8ngxOVPgAfRaUR7u4lW3IANJ5xILI1JAbtwp37rU8
ARC-Seal: i=1; a=rsa-sha256; t=1521026152; cv=none;
        d=google.com; s=arc-20160816;
        b=d2Y9fcW1xh1fYDnXlnNw03rTzMXoZMYvzD3bAC3dWhRj4R2OySWn+OCkCrLzrx7lCX
         olQDps97sDKxEln67JMxf+irw6S/uw+VzOWWBdg4MvIj0nekNE4I90U65nHx/ad1hJ/l
         JhiRhL2tb5+yfxiuyOkzMOlqdHwl2HSR7tH/TlH7ynA0fpF+qMLf69QTlC5ELLxwvkbK
         XIBy72Pm8ILdUdEB0ItVtPAhH+qbrDlMvh7Y9UDeCGSFz5/MaS1P8aYA6OHx67vwV1Sc
         RTBbICaJWL9CgxSYxWqdoOIoDCMIHYIs4M1APbkxIVAQOt0I1q7rmqki/wK/xZX13NUO
         gatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=ovhrdjbhtfFwawZBg98c/abei+yOrqv66CTf1nPvOuQ=;
        b=Hn/iX2D8EutDYEJseFUnhlJ0uz1x3acp1TS6Vz2AIimazFmZ2+b2JR7UCdjR8ZDYKG
         pgGD/4JXpArRnG70jIcPdhWJpYH0m3dv/7oIB3FtmSWfh8qeN2haerxCLbK3BFMp57GA
         /1Qp7qNUtFj/6P0HNYwNbyvfBUzaj5DZG5wrkvyWOYYcZhB2L3c32RLXAdA+NVdhD75f
         shHXRhJRfkpoFezsbteyZe7Ch2ddt7QHK/HDpdwKLmi4Ab8bgz/NVsi4k1eXBJ+vWpFT
         1tE/NnZlkVoMzM4COJebFNo+8mQjYMamMOxhEyfSpfibv8DnOjeFWxd624jTCOv/P1L5
         cpBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Subject: Re: [PATCH 0/6] irqchip/mips-gic: Enable & use VEIC mode if available
To: Matt Redfearn <matt.redfearn@mips.com>, Ralf Baechle
 <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
 Dengcheng Zhu <dengcheng.zhu@mips.com>, linux-kernel@vger.kernel.org,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Paul Burton <paul.burton@mips.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <c9b5d20c-7adf-5308-1a45-21471d206d10@arm.com>
Date: Wed, 14 Mar 2018 11:15:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588748156278723185?=
X-GMAIL-MSGID: =?utf-8?q?1594911518718733419?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Matt,

On 05/01/18 10:31, Matt Redfearn wrote:
> 
> This series enables the MIPS GIC driver to make use of the EIC mode
> supported in some MIPS cores. In this mode, the cores 6 interrupt lines
> are switched to represent a vector number, 0..63. Currently all GIC
> interrupts are routed to a single CPU interrupt pin, but this is
> inefficient since we end up checking both local and shared interrupt
> flag registers for both local and shared interrupts. This introduces
> additional latency into the interrupt paths. With EIC mode this can be
> improved by using separate vectors for local and shared interrupts.
> 
> This series is based on 4.15-rc6 and has been tested on Boston, Malta &
> SEAD3 MIPS platforms implementing a GIC with and without EIC mode
> supported in hardware.

What the status of this series?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
