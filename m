Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521653768; cv=none;
        d=google.com; s=arc-20160816;
        b=UOjSmbMb97ORXVdqL9buVbRJ7dyMdqSd4N7emgwUbcseWE5zWiU6xuOjuz/U3mR0u5
         1GnLHyJHsDc4BErYbQvRkhUWNTAY3pkqxypQ1lmZ/16kGG0pBK9XpIqBRnhBbwpQh5rZ
         lpzZ2zI8aREyXZwjOu+yBh/Nxm57VvWVeBn7WOjlo4UsZhNlE6/L1B/7bY1kWUoyLECL
         gmngxSkqzN+zYToYBQR1tsghejSAn/uyS8QQcpmTBRH40Zc1qGEMaF+bPrmiCLjoncIE
         mK2VCstPbyqcDox0s+tmIx4wiA2bZGIsjzvCLiAWLca1j2FTmK0kWIIqut3hVLGjaraJ
         hK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=eYKPCRXW+q/YF1TfF/Xt0WGXTqaXAllKf9LX/m6Lmmw=;
        b=JVtIGpEWY2UZMMYAAV3UVs6ngozFoqFEY9VDXlPAzTLKwS0KJZEMbG+7vgHaOvTDKd
         j6D39op4NoFgMYAnPs9leyCIxBjAmqWMBqeiEsm0lQ6/IslUYJMXm/2XKmWGfE8VUhWq
         ZmbRSUV/xPL4kbsNWg/JVcWvDgBo6D6/pXdqUUASZpQBqMxV5ElTGe77WD/Mza3/8bas
         xJVrx82ZitaXupyNbBWThvv7+awhdRwyL+f4S1Kd1eMR3CHGRoOb1Es2YLCuVnZ9/NRn
         6nMlkvwL97/A91iJXpt+3npIzgtVi+Mi2w+ckAtNj2JiCpqnwWckWZ0hnph/dXucecDl
         glpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ceSELJOO;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ceSELJOO;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELuiHypuSlOfEXp8OfHz0XB21wCPMJETOjZksYkMkErKfILLehCEJ9rhxDWTzoYwXPPLm1sOoQ==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Mar 2018 10:36:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
Message-ID: <20180321173605.GA6008@roeck-us.net>
References: <20180319180751.172155436@linuxfoundation.org>
 <20180320074945.GA10034@kroah.com>
 <20180321132005.GB27151@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321132005.GB27151@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595391137042363427?=
X-GMAIL-MSGID: =?utf-8?q?1595569621995028580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 02:20:05PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 20, 2018 at 08:49:45AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Mar 19, 2018 at 07:04:25PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.9.89 release.
> > > There are 241 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc1.gz
> > > or in the git tree and branch at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > > and the diffstat can be found below.
> > 
> > -rc2 is out to fix a bunch of arm32 build errors:
> >  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc2.gz
> > 
> 
> And -rc3 is out to fix some more arm32 build errors, as well as an x86
> one I noticed showed up in the build tests:
>   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc3.gz
> 

For v4.9.88-238-g369cbfd:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Guenter
