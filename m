Return-Path: <natechancellor@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524428704; cv=none;
        d=google.com; s=arc-20160816;
        b=Blc3uu2HhjhMMutHrio2B6GGUOMCGOzL+kgAsWpScyxquR1Oo+eiKFLEb2iZLG9z6I
         uGxYzbmVhdVOIcR8/29XLyuFMOFfjxu0DZ4L6YEPlH70MNIkX1VD+N8s6qoeg+fRPBB8
         jShmBdE97w5mh6SCgMrbYCMWy59OHK4useYF2KO91qsM3BIvlxHRLtKXijqcIroWZzdv
         S8zqS/gPXFdV8FpQbK5rQjtq9NEWOEE5OBytzP4+0eLamiFdfiJlqSxoUEUX/NFBeOMD
         ryT1+HUTPQv3To1Dp4wNw/ElBn7FyYNv+l8zvk4JIadUd+IkEMKde9J4a2lS1VlttUFi
         SL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=0L54MNaPKR9CBTU6eRCsVxL7PR6KY+fiQoHqYw4T/FA=;
        b=ib41RH1cbwYZ9dIzq7Pt1+oUojQ2wf49Ww9KcNcUAAJ7iERTMnAe+6y72V5ws/8g9x
         uCKo7XBLfHstIfFXwctVzNV1bEvIH/o6oUNCg9gbEnCmibyv5u1Z4BmN+CjaerUH6t5R
         9Owr5d5WvEhku2YPNQKQcpbbsvo0tODcpCBdJ4PhHVDK5CMkz1nyH1WVzYmdS05vcdon
         FDlXUMZl41yKSiNCR16+9QSWJ6bUhK4igrO0XS42uwjxNuu+iZN/nFJvUiqwh55oQAbT
         +nUDBy5u6Xns8SzHfPsRwowqZkUWZuNKJDo0mnqoo6+oDyIwVKTsRkd6/P15oNH03tqO
         6SbA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g2dJGnW6;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g2dJGnW6;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+6exJChJLJGTamxfBtsLoxyDh66MFFzDooJuoZuIHZT1CXDQBAvvRknos76ArBUeb7tr23xw==
Date: Sun, 22 Apr 2018 13:25:01 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
Message-ID: <20180422202501.GA2319@flashbox>
References: <20180422135104.278511750@linuxfoundation.org>
 <9fcfb52c-bac2-bce5-f84d-929f1045b054@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fcfb52c-bac2-bce5-f84d-929f1045b054@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598454802503426017?=
X-GMAIL-MSGID: =?utf-8?q?1598479353176369456?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 01:13:53PM -0700, Guenter Roeck wrote:
> On 04/22/2018 06:50 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.4 release.
> > There are 196 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> 
> Build results:
> 	total: 143 pass: 141 fail: 2
> Failed builds:
> 	powerpc:defconfig
> 	powerpc:allmodconfig
> Qemu test results:
> 	total: 139 pass: 133 fail: 6
> Failed tests:
> 	powerpc:mac99:ppc64_book3s_defconfig:initrd:nosmp
> 	powerpc:mac99:ppc64_book3s_defconfig:initrd:smp4
> 	powerpc:mac99:ppc64_book3s_defconfig:rootfs:smp4
> 	powerpc:pseries:pseries_defconfig:initrd
> 	powerpc:pseries:pseries_defconfig:rootfs
> 	powerpc:powernv:powernv_defconfig:initrd
> 
> arch/powerpc/platforms/powernv/opal-nvram.c: In function 'opal_nvram_write':
> arch/powerpc/platforms/powernv/opal-nvram.c:61:11: error: 'OPAL_BUSY_DELAY_MS'
> 
> This problem affects _all_ pending releases.
> 
> Guenter

Looks like 3b8070335f75 ("powerpc/powernv: Fix OPAL NVRAM driver
OPAL_BUSY loops") has a dependency commit that was missed: 34dd25de9fe3
("powerpc/powernv: define a standard delay for OPAL_BUSY type retry
loops").

Nathan
