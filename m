Return-Path: <schwidefsky@de.ibm.com>
X-Google-Smtp-Source: AH8x226vx/Zi3wrDTMkzGXAn5eW9t7ukHPaZl4LWY+zjhpj5cVXR5HEn7w9lhnZz2O1kxD85iobA
ARC-Seal: i=1; a=rsa-sha256; t=1518004318; cv=none;
        d=google.com; s=arc-20160816;
        b=kKfoQZKIP7ngeN6a6IXek/A5/11DyvciyagPwf34/lst2/chrsID4TcedgtQl3zJ4k
         619vur8gnA3mB4w4BoHw6QJ0rcWM9uFW+hmZ3bDlGfqPr/lvS3CVlq2YWQpwgkZmBkHL
         ORpvMSzT6DvciVFELtWzwRlYjcKmr7RplDC326s5mbSC+o88PQqkXP7xxSRcQGCnDhEs
         yGmHwsUni9MXX5NDW/Zo2xN7qA3BiHfNJclkvXHAsqfQojp5iaz7ANmwZ2fGHR2J7bF7
         m4iPGkaOgs5mZkv4WX+BkS3pqdXb4TT0Qnsij4mIIeXeqZ3pAojGhSFPCfKpodh43DF3
         hCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:subject:cc:to:from:date:arc-authentication-results;
        bh=kH7wxyOvbo4UNI8Fgih8INXA9ikUSKUypSjYfRzVKxM=;
        b=UAcqVsz+bPB2TfO8BwTZ6k6AvPPXDIZITlUClixpbTTcI3pQ3QL0psY5sARkXGpIJ4
         3a4fu9PLeXAJfRqgL5icISawA3ElXMOa729P36IL5ODD1oYVsPthxWOYSN4x8CKzHmIB
         1d7ycAJQ2BWUqeQ6te8zFB/+JLqt5eKZdvNZWFfKLAD/x+jwAHBqvvyUlto45VkU223A
         LCgCIjdLruiIkrs71bjOHALWb7ygJTWHsRKqFYyXVB3qRQoNl0nNIgYz7q2UvBvPUJvm
         M8pucqEc01QQwATxJHJOW6gy8W0axpa53my0KgzgZs+N5PUAofsu+dVmgip2xqsZGgBp
         NAGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Date: Wed, 7 Feb 2018 12:51:48 +0100
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
Subject: Re: [PATCH 6/6] s390: introduce execute-trampolines for branches
In-Reply-To: <20180207100726.GB31392@amd>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
	<1517986811-27819-7-git-send-email-schwidefsky@de.ibm.com>
	<20180207100726.GB31392@amd>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020711-0040-0000-0000-0000042D53C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020711-0041-0000-0000-000020D10629
Message-Id: <20180207125148.2c657e58@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070149
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724559737732044?=
X-GMAIL-MSGID: =?utf-8?q?1591742896247944633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 7 Feb 2018 11:07:26 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> On Wed 2018-02-07 08:00:11, Martin Schwidefsky wrote:
> > Add CONFIG_EXPOLINE to enable the use of the new -mindirect-branch= and
> > -mfunction_return= compiler options to create a kernel fortified against
> > the specte v2 attack.
> > 
> > With CONFIG_EXPOLINE=y all indirect branches will be issued with an
> > execute type instruction. For z10 or newer the EXRL instruction will
> > be used, for older machines the EX instruction. The typical indirect
> > call
> > 
> > 	basr	%r14,%r1
> > 
> > is replaced with a PC relative call to a new thunk
> > 
> > 	brasl	%r14,__s390x_indirect_jump_r1
> > 
> > The thunk contains the EXRL/EX instruction to the indirect branch
> > 
> > __s390x_indirect_jump_r1:
> > 	exrl	0,0f
> > 	j	.
> > 0:	br	%r1
> > 
> > The detour via the execute type instruction has a performance impact.
> > To get rid of the detour the new kernel parameter "nospectre_v2" and
> > "spectre_v2=[on,off,auto]" can be used. If the parameter is specified
> > the kernel and module code will be patched at runtime.  
> 
> This is really unfortunate naming of kernel option.
> 
> spectre_v2=off sounds like we are turning the "bug" off, but i somehow
> suspect you are turning the bug _workaround_ off.
 
Well, that is the 1:1 copy of the x86 option. Do you want to change that
one as well?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
