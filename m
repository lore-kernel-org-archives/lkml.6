Return-Path: <sam@ravnborg.org>
X-Google-Smtp-Source: AB8JxZrlrkLaSNj8BLr1OFaJuEPW1vUmnIoTwJ6/tP/Ov5ExYzosJtV517EDazaXWQUE7Axqniqt
ARC-Seal: i=1; a=rsa-sha256; t=1527004169; cv=none;
        d=google.com; s=arc-20160816;
        b=UrmIxLeCOY4Yz8v5EKDtxbqh65t1rkLSre8xZN7kmthTMsif7Ujd31f13tBYXwLGGU
         J2Hqz29mtQmLLdqFwljFHjBLvSxSYSxd0bwCFW6whh8XaRQzyl4D1QkvdCA8sAoxyHWN
         IJaF9QNm9q+6UHIbseBFRw863didNb/ncGAJPhwnMj/avjceIkaOgBfgqi7UOp8YU3WE
         3sDyV5b2540FTzDI+zVNWes7K1fNwILYIX7ofDfMKMS44Qy9tBuTxv2W/lRUweUJWbkj
         W68CzBYUzH3DHZdxADkEVQbgQNiQgjcBV+L+PPtnmaCeGxSYnHO8E0QYrPGes9jdB7qF
         90ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=OfCQrAo1LzsCdba57j0HErtc+erLepxOCeg/bNUWSoU=;
        b=Dcl8wmrT+IeftkcbbD+HDM7Wt1Aku/ayUcS8+NUtGFqNhYoM7TNAbYkDu1qLqZnWU+
         Qc2yFjzEQMQ2zzwzAaPH5XyPxXZBAyJElyHlWsDchCONSLjGpp7ID7L2qvS7OYAxiKw6
         WWX5roJQJ3EEQLb/n6RsUViFDtGRVMr6N9VkCLGOI3sQDRVXt8rjsmI0eoW1AbGJEpdB
         1SjXaMzG+0iAo6e4+3ZDtmKu0KB+hBnxR0PxuTfskhzIH7L0ciU0/xtps3Wrc/WDvMrC
         Ie7ZrgfivbzhIIwVbp0t+Af5eBSEc1AemVcm5n8Qx+RQyGY112uDW83KRydDSZUazC8V
         bfGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Date: Tue, 22 May 2018 17:49:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	"Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arvind Prasanna <arvindprasanna@gmail.com>
Subject: Re: [PATCH v2 4/5] kconfig: refactor ncurses package checks for
 building mconf
Message-ID: <20180522154924.GA23783@ravnborg.org>
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
 <1526804213-8238-5-git-send-email-yamada.masahiro@socionext.com>
 <20180520100601.GB18441@ravnborg.org>
 <CAK7LNASfQBw4O=etKBmEJFLcvq+NqetwJjo4Dt0XzzRdmen2Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASfQBw4O=etKBmEJFLcvq+NqetwJjo4Dt0XzzRdmen2Eg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
	a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
	a=kj9zAlcOel0A:10 a=SHlIeKMNTbNT9HPsbQQA:9 a=CjuIK1q_8ugA:10
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600970303979180771?=
X-GMAIL-MSGID: =?utf-8?q?1601179924669075167?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masahiro.

> > Any chance that the ugly hack in check.sh could be ported over to use pkg-config?
> >
> Rather, I have been wondering if we could rip off the gettext stuff entirely...

I did a little research.
update-po-conifg is broken in current kernel
The part of the Makefile that implement update-po-config hasseen very little
activity the last 5+ years
There is very few hits on google for "update-po-config", first
real hit was something related to a path I made loong time ago.

So it looks like the infrastructure could be dropped in the kernel.
I did not try to check if any other users of kconfig utilize this,
but I do not recall anyone that have mentioned this.

So ack from me to kill gettext support.

	Sam
