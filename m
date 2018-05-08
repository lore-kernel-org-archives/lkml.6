Return-Path: <linux_dti@icloud.com>
X-Google-Smtp-Source: AB8JxZq7iIly6fCLQU03YqaFg2LG2yzo/+FF1V0sgmxN2Hs++QWI9zUzV7M90ZnYYKgVSBSw2rAx
ARC-Seal: i=1; a=rsa-sha256; t=1525808506; cv=none;
        d=google.com; s=arc-20160816;
        b=Z5rRRDslTuB61BKmeSj3ULSAPYmyZzfPEMxY0wHm9D4QNuX7OJi3LY++sBVIDCg86T
         qDY8jYBiqYXa/MSKHaAO8N7pBOiGKR0AU0HJsvh6J6ACyuGhDNoJ+X4zTgAv5uwZKI+j
         Uh2cfWF61nuK9mteNgckjFhBHX46aE+by+nFbbSSstvEtMw52tGF8vtZGxXhiQNBwSNy
         naXqFxji+QFTBQ3z5/CBM4SSfSJBkgYFQm13kVxuQQe3sFWQhItRK5vCDkWV3SIsb+HW
         7Nvh+2JBLStvsQL2cvWfbfSpZFzPwBjRE8g+TF4owpKsPLCQ+ONA6ekC1NxOkPNXO46m
         643g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=dPv9PGuPaJb3taWjombOEN0ff/CP5MLhBYSvZRetiEw=;
        b=hgW0f8TdX+TxN6qzkoUP+eswFYM44CUR4QsbIF2N/2+Av4xszmrSIwTVnquuuSQEfl
         +C/htwfJd5jDRh/vNNYbxOxRgoT0zR1xvjbJrnaN7uVpzIRdW5PAH92F+dpJaiHWpqAt
         laXtr+IPPKAts7V84xEgwAfMhdTqS+iZo6Ai2SGF+Hncv+X3id4dcUfbltDnpZvPtZQ7
         rzR7sxJ6rFjmQV2ewacug/Xk6HvwOPdIY9Wn+m+oVCCsXw4CuOhn67YYkncC8lQBlfLP
         BLmC0vIubJZMeLqg26+3ZP7YJJ9qrzOGGht9PdjnMWN/T9PhUnTehlnCh2tgTQUHS6KN
         p2sg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=qMVXuAbd;
       spf=pass (google.com: domain of linux_dti@icloud.com designates 17.58.37.19 as permitted sender) smtp.mailfrom=linux_dti@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=qMVXuAbd;
       spf=pass (google.com: domain of linux_dti@icloud.com designates 17.58.37.19 as permitted sender) smtp.mailfrom=linux_dti@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-08_07:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=2 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805080185
Date: Tue, 08 May 2018 21:41:36 +0200
From: damian <linux_dti@icloud.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: Bug in vboxguest: After commit Merge tag 'char-misc-4.17-rc3'
Message-id: <20180508194135.GA27020@zrhn9910b>
Mail-followup-to: Hans de Goede <hdegoede@redhat.com>,
 gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20180502193735.GA2444@zrhn9910b>
 <20180502200615.GB16341@kroah.com> <20180502204612.GA2089@zrhn9910b>
 <c589f2f9-e8e3-7f54-e1ab-9ac3baf700bf@redhat.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <c589f2f9-e8e3-7f54-e1ab-9ac3baf700bf@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599382342256929089?=
X-GMAIL-MSGID: =?utf-8?q?1599926179892611772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 08. May 13:42, Hans de Goede wrote:
> Hi Damian,
> 
> On 02-05-18 22:46, damian wrote:
> >Hello Greg,
> >
> >it is PATCH 3 virt: vbox: Use __get_free_pages insteas of kmalloc for DMA32 memory.
> 
> Thank you for the bug report, I've tried to reproduce this problem
> but for me everything works fine.
> 
> Does your virtual-machine have more then 4G of RAM configured for its
> use?  If yes then what is likely happening is that you also have
> the out-of-tree version of the vboxguest modules installed and prior
> to the commit in question the out of tree version of the driver is
> loading, because before that commit the vboxguest driver in the
> mainline kernel fails to load on machines with more then 4G.
> 
> Or alternatively before the commit in question you may not have
> any version of the vboxguest driver loaded.
> 
> Using the upstream version of the driver should not make a noticeable
> difference, but before the vboxguest driver became a part of the
> mainline kernel the virtualbox upstream developers have done a
> cleanup / redesign of the userspace API of the vboxguest driver,
> so the vboxguest driver will only work with recent virtualbox-guest-additions
> and since you are using Ubuntu 16.04 chances are that you are
> using that with Ubuntu's quite old bundled virtualbox-guest-additions
> which will not work with the new driver and may be causing this
> issue.
> 
> Can you try upgrading your virtualbox-guest-additions to 5.2.10
> please?
> 
> Also if the above does not help, a couple of follow up
> questions to help this pin down further:
> 
> 1) Are you using vbox's 3d pass through functionality
> 2) Which desktop-environment are you using?
> 
> Regards,
> 
> Hans

Hi Hans,

i will check my configutation and will come back
At the moment i dont use use the virtualbox-guest-additions, i use the driver from the staging area. 

because i had after every new kernel release problms with this driver. 


regards
Damian
