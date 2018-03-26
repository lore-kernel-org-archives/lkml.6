Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AG47ELtCNZIeb1hg4em0LkIqmhu4PAFHCIoAILor0OPfw7SPsjO6lh/Zl8pU4JV7iFPc0Tkebd3A
ARC-Seal: i=1; a=rsa-sha256; t=1522096400; cv=none;
        d=google.com; s=arc-20160816;
        b=QPsXrZrOTkg/Caty3wjKGrRmSWOBsnpZ4GUc3bmiaB5g/wGa8UvX/PXkYhw6wpgUN+
         nJui/81rTjxZ8mcg4z/MQ6bR5b5qGkt1gZqxdYodhDzQAQhJvzN7aZpGnPnLDRfhhXmz
         ATVlc9V5f/u++Uny75kDwWTJJWl/GlQL6UcESXv9fxCsJlIsWeZyb206aqtUp9ZhEaZ/
         xIesvg/dUyQlNAi9lvAUUQluKG/bYhBbrbTj7MgO4l5YDJFHmCV2F6z7LSrDQpjLC6fL
         bdEtwXTa2AxaXDQG+rjpBGJbE1fPZYdG0gdJA6z1Y8MGK07EcUX21bmT2AYhPspvN2co
         kkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=R5KU4EDu+c/hSFqgGsYuHGUiMQ2wubcaxjTV6hiHypw=;
        b=PlFkBwyVbt4o+2iUJSH+4AKYTF9xKzTlTSL6cHJeR7Q8JyKyA2p4loaAji038O6pHA
         aplLyXUkNhdRWaqoMLaCvH4WYI1qjEsOfQxJh57k5ZhVJ9vzB4DMGR89RBqnAkDIHrDy
         5gEHPDtXUIJ9ZN0618ogRw5gqfWQqYD4G3S2PK7H1vV6c+rU7M37NrhtZ6XVMCQJ2Ljy
         +WJRBzkQS0de1qIMG+0GoU6/Q1uU9lLmXJ7KqC/9awkQ2gmx4CpYlx6ycS5QIdiM8yx5
         qq4O3KUHq5m+ZuaqmOsnymUElOCTqgl6WwF3gio1Cs995oJB8JPqFv/LbSUMRTjRYqtP
         iWHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20180321163745.12286-1-logang@deltatee.com>
 <20180321163745.12286-2-logang@deltatee.com>
 <CAK8P3a25zQDxyaY3iVv+JmSSzs7F6ssGc+HdBkGs54ZfViX+Fg@mail.gmail.com>
 <726eb143-2cca-b221-b569-e193a962e357@deltatee.com>
 <CAK8P3a2HGW=PWBtFL_96rztqa7KUAhuYBHTL3cGKY2VE=Ag1rA@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6a063b65-668a-ef9c-696e-8c378e6b2640@deltatee.com>
Date: Mon, 26 Mar 2018 14:33:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2HGW=PWBtFL_96rztqa7KUAhuYBHTL3cGKY2VE=Ag1rA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: luc.vanoostenryck@gmail.com, kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com, horia.geanta@nxp.com, andy.shevchenko@gmail.com, gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org, linux-ntb@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v13 01/10] iomap: Use correct endian conversion function
 in mmio_writeXXbe
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595565968042571455?=
X-GMAIL-MSGID: =?utf-8?q?1596033755493695230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 26/03/18 01:50 PM, Arnd Bergmann wrote:
> I wouldn't expect it to matter: the byte swap is almost always much
> cheaper compared to the actual bus access for the MMIO, and I
> would also guess that modern compilers can eliminate the double
> byte swap on architectures where writel() is an inline function. Most of
> the important architectures use ARCH_USE_BUILTIN_BSWAP, which
> guarantees that.

Fair enough. Sometime this week I'll update my patch set to change that.

Thanks,

Logan
