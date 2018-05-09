Return-Path: <linux_dti@icloud.com>
X-Google-Smtp-Source: AB8JxZpDkDq24KiE2HOQPcJaf4Uwvd5/d0V7Sq0o9fxGInwcj61dfQEKuSZ8ieIzlSkcSQI4NS0L
ARC-Seal: i=1; a=rsa-sha256; t=1525893378; cv=none;
        d=google.com; s=arc-20160816;
        b=do/bSA1HOhOu5MLxc/WSA6O31s9b1esV3ntzB19JJYk8ru4Iks/39j8pDOOLwoqxNh
         K1BPAGx1ccrhZ3wSudiBErjfVNue+PsnonwqzozI37UuiBk7KwpFQsl6mawZaSGNOlMK
         5UTIjwaHVT7m9lY6rJF9elhSX6QrRK7Zh1Gw82NgtbJ+c/R64M/pxZyNv2PrZQ88jKbB
         yGYAqpZvN7zoeGDRhF2ViYARzL3Xd1G9khfvDSb+q3Ls+9wA998OKBV04YLFOnw6yBQH
         Xpd7g5nubfppCDPkgtOOr7guEYZnq4AyN3FvhoEskyKtgl3j5HyOtSWmSrDbAhIvtpUe
         A/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=YTYYyPEPiFmmhxoWG1xGm3I8V7qNsSd0p8mBW3/6R5A=;
        b=00Y+XBTFtNYgpoyrq7uCgM3rgrdPR3+66dBDiAfKTX/jeVb9s9vqQ4qj0mqBz5WC3j
         pVf0HiWKnmfl6yYScCMy8m81Wl4JDPmHp8kkrLkkqG0OU7vyKYkYGNxhgTmkVWDLhmgS
         9RXs9e4rDnR06N/foVONX4BJXqEUl4AvRY5nBEW1LGnqzL8YvtXNfANSHUwcXb4XPCuh
         T1jYWeAZ0j15UW7QRtcDnCfdBWStVVAfCRAI7gRqUt2DyRi0tB8axVvjnw0SP9vOC2tB
         M7o2LgPCs4CXEXHBzcVnv1Ed7yMAsTPhEAXX0T7/YGm2G0aOY0PBw2H13yePiWCLHObx
         4QaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=DAdpZRcx;
       spf=pass (google.com: domain of linux_dti@icloud.com designates 17.58.37.18 as permitted sender) smtp.mailfrom=linux_dti@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=DAdpZRcx;
       spf=pass (google.com: domain of linux_dti@icloud.com designates 17.58.37.18 as permitted sender) smtp.mailfrom=linux_dti@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-09_07:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805090181
Date: Wed, 09 May 2018 21:15:58 +0200
From: damian <linux_dti@icloud.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, peterz@infradead.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: Kernel build with gcc 8 a lot of warnings
Message-id: <20180509191557.GA1969@zrhn9910b>
Mail-followup-to: Josh Poimboeuf <jpoimboe@redhat.com>,
 Greg KH <gregkh@linuxfoundation.org>, peterz@infradead.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20180505192112.GA18728@zrhn9910b>
 <20180507045453.leou4zypnlcck4vr@treble> <20180508055126.GA18724@kroah.com>
 <20180508133226.uwjbx44fwlxgyzu5@treble> <20180508142515.GA16111@kroah.com>
 <20180508143241.5kz4poxcdhajjorl@treble>
 <20180509034646.7qftdvummkz7b2pi@treble> <20180509073503.GA2116@zrhn9910b>
 <20180509152339.mszrivslsrrkkoq6@treble>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20180509152339.mszrivslsrrkkoq6@treble>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599903094060891144?=
X-GMAIL-MSGID: =?utf-8?q?1600015175300971022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 09. May 10:23, Josh Poimboeuf wrote:
> On Wed, May 09, 2018 at 09:35:04AM +0200, damian wrote:
> > Hi Josh,
> > 
> > i tested the patch on my maschine it works fine. 
> > 
> > Best regards
> > Damian
> 
> Thanks.  0-day found a few more issues.  The latest patches are at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux objtool-gcc8
> 
> Waiting for 0-day to run them again, then I'll be submitting them
> shortly after.
> 
> -- 
> Josh

Hi Josh,

my test was successfull.

regards
Damian
 
