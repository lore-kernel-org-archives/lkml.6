Return-Path: <dave.anglin@bell.net>
X-Google-Smtp-Source: AIpwx491MjKFo7QBKJIWSpaoTx9qgLtGAvaN4VweW9iUFUwvDTJhxrbLwdvq/s/SaK5K++xxjqfF
ARC-Seal: i=1; a=rsa-sha256; t=1523920184; cv=none;
        d=google.com; s=arc-20160816;
        b=ae5pgp2hZwyg1AjgZZO10U+X3uIHqWDiQeQXpHitKdFsrf8+SdZ/u5/Kk4kV6crhYO
         zLO2/geSMudpMKZkmLkJCnUX2/zzj+EsHeWI2cUyNUXAvmUKFt0MC7S3GaiGXqOAA7yD
         RrIj84JB0DsMKVIhfhsjau3rUd6gvzyJ4Hloj13OwV4lVv7ldVybr4Oa3vUbTsQZo50a
         ZiaYObvNKXgx66Sf0yt6xmOzY7E4jUGBswdyUN632Tc5TW2Z8iLWOJSb+IlGC23HqORb
         UP0K6rhr/GGpJ6faVCZcNsm3sOhB5BmEtkzp0eVpP8TwS0kLcXlgro6wfo0YdUICLeVf
         JGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=HMZZ+vuNL+ySDodU2nqB09b/Ef45MM4Qe3EeXU7o7f0=;
        b=pXe8XnDhDOz6l8+qw1qLPaG5P+s0FKOR6guKDiVdybq4uJ7kVvphFC/Al0ISecJMkc
         x3J5IuAaO71i/uwCz2KYX3ebFp8r5n893jRdkx3bA//C6+TQ8gnyzpJAL6bJ2GdHSKYM
         hcNNTn+eLTmmL3gvKrwuF50JyJTYKaK1m9WxQRWjekMgSMJqDSPqpywbPObzWFnKz8LM
         a+KDbGlJZllD6JVjxNlGBie3gKQ2r4D+Jg764FENcYJ94NxRPw7daNe80sIhw6vokz1x
         h2Sh0aN09jdf7gfxFmlbpKFx/Gf6Bp9JCPVofG/6vOulA85B577XD9ORYX+np2uCNz3m
         uEMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dave.anglin@bell.net designates 184.150.200.207 as permitted sender) smtp.mailfrom=dave.anglin@bell.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dave.anglin@bell.net designates 184.150.200.207 as permitted sender) smtp.mailfrom=dave.anglin@bell.net
Subject: Re: [PATCH 1/2] parisc: use the asm-generic version for writeX()
To: Sinan Kaya <okaya@codeaurora.org>, linux-parisc@linux-mips.org,
 arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller
 <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
From: John David Anglin <dave.anglin@bell.net>
Message-ID: <a727e74f-610c-4722-76e9-c1aca2f9e9bd@bell.net>
Date: Mon, 16 Apr 2018 19:09:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Cloudmark-Analysis: v=2.2 cv=JtkelIwC c=1 sm=0 tr=0 a=V8DPTAhloC/wURew+oITug==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FBHGMhGWAAAA:8 a=M82E00bDOwz00zPftycA:9 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597941834039295294?=
X-GMAIL-MSGID: =?utf-8?q?1597946131447902063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-16 6:01 PM, Sinan Kaya wrote:
> parisc architecture seems to be mapping writeX() and writeX_relaxed() APIs
> to __raw_writeX() API.
>
> __raw_writeX() API doesn't provide any kind of ordering guarantees.
> commit 755bd04aaf4b ("io: define stronger ordering for the default writeX()
> implementation") changed asm-generic implementation to use a more
> conservative approach towards the writeX() API.
>
> Drop the arch specific version and rely on the asm-generic version for
> parisc since parisc version doesn't seem to do anything special with these
> macros.
   HOSTLD  scripts/mod/modpost
In file included from ./arch/parisc/include/asm/hardirq.h:13:0,
                  from ./include/linux/hardirq.h:9,
                  from arch/parisc/kernel/asm-offsets.c:34:
./include/linux/irq.h: In function 'irq_reg_writel':
./include/linux/irq.h:1114:3: error: implicit declaration of function 
'writel' [-Werror=implicit-function-declaration]
    writel(val, gc->reg_base + reg_offset);
    ^~~~~~
./include/linux/irq.h: In function 'irq_reg_readl':
./include/linux/irq.h:1123:10: error: implicit declaration of function 
'readl' [-Werror=implicit-function-declaration]
    return readl(gc->reg_base + reg_offset);
           ^~~~~
cc1: some warnings being treated as errors
make[1]: *** [Kbuild:58: arch/parisc/kernel/asm-offsets.s] Error 1

Dave

-- 
John David Anglin  dave.anglin@bell.net
