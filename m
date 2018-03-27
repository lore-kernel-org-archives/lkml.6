Return-Path: <mpatocka@redhat.com>
X-Google-Smtp-Source: AG47ELt7UG/jJOJSUR8YyT9m/CLdJrxgjehqXwhDon9NIv6Pm6GTn7uKAUNqrFzGoPImLJ4YS+zm
ARC-Seal: i=1; a=rsa-sha256; t=1522153132; cv=none;
        d=google.com; s=arc-20160816;
        b=r88J7vjyY/z044MZX6ziMvMc2tukR6x9U5y1nHRppzlnvlqrzsxXeTY0FX7yUUO6yc
         C/xUbOn0D6dZwD5ga1YrMleSqj0Lpjv3Dqjv5K9870lOhCGA7w3RM3V1adb5gNhpk8wI
         astEfqNLCkhlDkR+X1hnbTit0jGmBle9AfEorMrWQN9OTBAtFMU88SabGyy92JBTiNXW
         /lq1vjiYPU1Xc5o2gGoA3TCA/elnmGZJ94ioMw9Hk8cmnu+QZMrfCEEpFT6YXTsuL6HP
         ztgA6Ka7oCddghilL5tgDFZEX/qMAO7RenFd0JPWMJ9c1o/mv5yfdgH6v/nU5JPUByoj
         PJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=lIYSYI6d9iFLjuiBWUCnvv3FhZd1KMf5CVIiBIHI+c0=;
        b=JJbJRLNAtM8dA/gLaGHljBk1fNtT+2t1HclNaz4biJQt+oikRzNV3n9WVhjIwoeqDf
         hwtsT0zIspra9EN+NC97PObz+9gq6eOH3PVXsZro02Gd17FK0BSGTgy6kvlyG60bZ0kR
         1P7cSbLR+MxU95FwomsqWxBizNfCwjgtiWCDXjAFzVqEMqHC2mDDW2rHOrV4S4HNbxCR
         D6Iqr/7zEo2+siUpO7pgBo6N90E8d6Jk4TiDNrGPFryDhIVYa+BHkwdwK2qxwAKlkm0l
         6OmTDej4inyDwvOLGgXldZWsFr+sUqe6XoNdy9HtUYreeLtbGo1qOPMmgsgBJz6APwJH
         C6Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mpatocka@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mpatocka@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mpatocka@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mpatocka@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 27 Mar 2018 08:18:50 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Daniel Axtens <dja@axtens.net>, Michael Neuling <mikey@neuling.org>,
        Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tty crash in Linux 4.6
In-Reply-To: <20180322140554.GA3273@kroah.com>
Message-ID: <alpine.LRH.2.02.1803270818150.30055@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1605161555430.8188@file01.intranet.prod.int.rdu2.redhat.com> <573A5996.3080305@hurleysoftware.com> <573B3F84.5050201@hurleysoftware.com> <573B5E4C.8030808@hurleysoftware.com> <alpine.LRH.2.02.1607071855150.19053@file01.intranet.prod.int.rdu2.redhat.com>
 <CAEjGV6zRghiCCMC1+-n+YPeA0Lrq=-vcvdoYpbwE4G=TXWzY3Q@mail.gmail.com> <87po3wusq1.fsf@linkitivity.dja.id.au> <20180322140554.GA3273@kroah.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1534517131154419915?=
X-GMAIL-MSGID: =?utf-8?q?1596093243091071950?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Thu, 22 Mar 2018, Greg Kroah-Hartman wrote:

> On Fri, Mar 23, 2018 at 12:48:06AM +1100, Daniel Axtens wrote:
> > Hi,
> > 
> > >> This patch works, I've had no tty crashes since applying it.
> > >>
> > >> I've seen that you haven't sent this patch yet to Linux-4.7-rc and
> > >> Linux-4.6-stable. Will you? Or did you create a different patch?
> > >
> > > We are hitting this now on powerpc.  This patch never seemed to make
> > > it upstream (drivers/tty/tty_ldisc.c hasn't been touched in 1 year).
> > 
> > I seem to be hitting this too on a kernel that has the 4.6 changes
> > backported to 4.4.
> > 
> > Has there been any further progress on getting this accepted?
> 
> Can you try applying 28b0f8a6962a ("tty: make n_tty_read() always abort
> if hangup is in progress") to see if that helps out or not?
> 
> thanks,
> 
> greg k-h

It doesn't help. I get the same crash as before.

Mikulas
