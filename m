Return-Path: <schwidefsky@de.ibm.com>
X-Google-Smtp-Source: AH8x226krr5QOfsS89+zNS/FZiJeOiexWDvH6jKW1niQQVpfB0ai4RZNcG+w17/pezLtcAjMZOuR
ARC-Seal: i=1; a=rsa-sha256; t=1518004184; cv=none;
        d=google.com; s=arc-20160816;
        b=JLcxxrT+rGEZSNqfD5MnWOokKAlTfqmt6HFaxgJSCB9bvm92Ydx4nPD1fZNrC5o10I
         3YcBvsY2XvSSA0CfrIWap3UDf3yiCbShiIm8EtDdbx+w6a27Gv4WpLFFjcRwWNUkWXEm
         K6itYROhame9LP5XAgxmJpOU+8y5XhwGvaaEOZ3BbFdWFWqno83ZQRNXSLxQzLFgU531
         /2YIbuH27ElLcyfAx3qeSKWvyF/1sTaHfLz+k5udStFB3n5VXiaK1Fb6c70685BwR7mq
         b+Z2vUVInH9rm4/hF1OIXIPw9v+74QMdGSVWa2b1NHOUhxe5OkicsIRlXJdK266qRoXG
         976Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:subject:cc:to:from:date:arc-authentication-results;
        bh=jAWuHe3JfahbRv7dtdVBq2HJ+531/Vq1gB4xmCIITjU=;
        b=Mr98MMyMXgY9Ja+my9JCkKGxy8N90EdqZbhlTs0Y/ZI3/lZvzoJYGelv5WPUGLOdLF
         RqvCYGViK/KXHSieh45MpLKtVbqJ0+uM1hq83PDoFSL7SvQY3SQjCBHj9/SjVCKQu5rE
         hhHnKY1jL4dw6uymhu90vXTS8MwqGJ48WUgmKAiLEPf55+p8DrjEXY2JdOOjrdNiWNLi
         gJN5egHZX5oBAhBsAIJirmzT7hx5Jl1BK/7U9vHzeqxpqJj0rtedhzBZhyD0PYkRnyjW
         GVl9sz0S9jy+TT+TQ+UMAzttYTzar2nA8NXJiXPxHJvWXZKOnyihFlVBIy+f3pja6ciS
         LVTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Date: Wed, 7 Feb 2018 12:49:35 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens
 <heiko.carstens@de.ibm.com>,
        Christian Borntraeger
 <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David
 Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Jon Masters <jcm@redhat.com>, Marcus Meissner
 <meissner@suse.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Dominik Brodowski
 <linux@dominikbrodowski.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        David
 Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 4/6] s390: add options to change branch prediction
 behaviour for the kernel
In-Reply-To: <20180207100252.GA31392@amd>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
	<1517986811-27819-5-git-send-email-schwidefsky@de.ibm.com>
	<20180207100252.GA31392@amd>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020711-0040-0000-0000-0000042D5391
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020711-0041-0000-0000-000020D105F4
Message-Id: <20180207124935.46406c60@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070149
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724562454954787?=
X-GMAIL-MSGID: =?utf-8?q?1591742755999557948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 7 Feb 2018 11:02:52 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> On Wed 2018-02-07 08:00:09, Martin Schwidefsky wrote:
> > Add the PPA instruction to the system entry and exit path to switch
> > the kernel to a different branch prediction behaviour. The instructions
> > are added via CPU alternatives and can be disabled with the "nospec"
> > or the "nobp=0" kernel parameter. If the default behaviour selected
> > with CONFIG_KERNEL_NOBP is set to "n" then the "nobp=1" parameter can be
> > used to enable the changed kernel branch prediction.
> > 
> > Acked-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > ---
> >  arch/s390/Kconfig                 | 17 ++++++++++++++
> >  arch/s390/include/asm/processor.h |  1 +
> >  arch/s390/kernel/alternative.c    | 23 +++++++++++++++++++
> >  arch/s390/kernel/early.c          |  2 ++
> >  arch/s390/kernel/entry.S          | 48 +++++++++++++++++++++++++++++++++++++++
> >  arch/s390/kernel/ipl.c            |  1 +
> >  arch/s390/kernel/smp.c            |  2 ++
> >  7 files changed, 94 insertions(+)
> > 
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 0105ce2..d514e25 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -540,6 +540,23 @@ config ARCH_RANDOM
> >  
> >  	  If unsure, say Y.
> >  
> > +config KERNEL_NOBP
> > +	def_bool n
> > +	prompt "Enable modified branch prediction for the kernel by default"
> > +	help
> > +	  If this option is selected the kernel will switch to a modified
> > +	  branch prediction mode if the firmware interface is available.
> > +	  The modified branch prediction mode improves the behaviour in
> > +	  regard to speculative execution.
> > +
> > +	  With the option enabled the kernel parameter "nobp=0" or "nospec"
> > +	  can be used to run the kernel in the normal branch prediction mode.
> > +
> > +	  With the option disabled the modified branch prediction mode is
> > +	  enabled with the "nobp=1" kernel parameter.
> > +
> > +	  If unsure, say N.
> > +  
> 
> This could use some improvement.
> 
> Afaict the config option only changes the default behaviour? Do we
> need the option in such case? (CONFIG_CMDLINE_APPEND can be useful to
> avoid some options).

# git grep CMDLINE_APPEND

returns nothing. What are you referring to?

The idea of this config option is that a distributor can decide what
default behaviour the system should have if no command line parameter
is specified.
 
> Plus, it is not clear what "modified branch prediction mode is" and if
> "improves behaviour" means "faster" or "safer".

Naturally "improves behaviour in regard to speculative execution" is
indicating that the system is safer. In general that means slower as well
but as always it depends. What exactly is done is up to the machine.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
