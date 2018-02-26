Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AG47ELtgcgGgH/BQMNlIG/mL1TEGUPv4sI1dLkzDd3QAIQywqhPtNZ/e0MJILjL3+iT7gBJAUTMV
ARC-Seal: i=1; a=rsa-sha256; t=1519681523; cv=none;
        d=google.com; s=arc-20160816;
        b=OqkZUflpuNjM4vOgzIZEyaRulKPuh6aBw/H/bafXMCcHSaPC2xuJUx0mT2AjzHxQEg
         mIsmA9mp3JRDiSCJ451vEeZD5RtPromUYi1oKdEzBQevbt3kpCbz1cG9AiVnrNSoFMFb
         XkMqyHUArLE2sskIPXkDSd6DRv3r4EJc6iRncULYCv3M9enTlDo90N64RVSOYPrCajEn
         5HjCN5F/Ifth2Jpkp0oxpDaZ6A02x7cXdZl4vTexVFKQypU0DIqbXUo0cM+06kM2WDvf
         4IxkJVP+/jvqKwgC/JSqkrf3ou58bn1g4XYRs73OaMcSis6qWmvfXF+s1ncEC6R2qs7u
         ZeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ZlS7vHYGKpWaXI+Qr53uxtZKZm64FiFl0eKAURw25lA=;
        b=SDk8YX8mFXGYuvaPr6V9b3vsmKir09oq7VxsNpNm12duIztNI1ZHmIaEq4A1/8BPLy
         dfJvwNa5vlpcMMro6UVQu4RmZ3LL6t2OS4QTsZaDzNPc1aMrBzX+sJru2pgMGQ7W3PM0
         DN2PMZtDT4gWXWGaEHNXzI1DekjfzS4LieBgoc1aQX0fOAzVTjyBaARNvfWcsI6d9mCI
         fYqOE4ds7GcCyX4N0L/T/9Nozy3J6vAwAaJZXF0cx2jNyua0T2OabN0dQsVWRjJ4IWKG
         OK4jIu7Z/TtjOWskb97z1VWb3U7ui2cHqImNbx6aR5h6y3WFGSUkf164XjG4lIr6NVmu
         IX0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Mon, 26 Feb 2018 13:45:19 -0800
From: Tony Lindgren <tony@atomide.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dan Murphy <dmurphy@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
Message-ID: <20180226214519.GF16043@atomide.com>
References: <20180226202144.375869933@linuxfoundation.org>
 <81b4e3e9-b631-6fbc-f45c-6fa740e33494@ti.com>
 <20180226211917.GA2211@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226211917.GA2211@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593496512090917624?=
X-GMAIL-MSGID: =?utf-8?q?1593501573365802346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Guenter Roeck <linux@roeck-us.net> [180226 21:20]:
> On Mon, Feb 26, 2018 at 02:58:24PM -0600, Dan Murphy wrote:
> > Tony L/Greg
> > 
> > On 02/26/2018 02:21 PM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.14.23 release.
> > > There are 54 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Feb 28 20:21:22 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > We have a build issue on 4.14.22 and can be re-created with this rc as well.
> > 
> > arch/arm/mach-omap2/omap-secure.o: In function `omap3_save_secure_ram':
> > omap-secure.c:(.text+0xe4): undefined reference to `save_secure_ram_context'
> > make: *** [vmlinux] Error 1
> > 
> > The issue was introduced with the back port of
> > 
> > b59a1da647f163d0bf035f823a908b45c357643a ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context
> > 
> Looks like you may have CONFIG_PM disabled, is that correct ?
> Is there a default configuration that we can use to reproduce
> the problem ?

It should be fixed with this commit in mainline kernel:

863204cfdae9 ("ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds")

Regards,

Tony
