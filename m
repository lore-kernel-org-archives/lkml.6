Return-Path: <sam@ravnborg.org>
X-Google-Smtp-Source: AB8JxZr4rM5XV4i9h7RlEpyBQMPKU4hpSzQrHMp9t5G+OcK0mkpKPkAvFzpqebyMrqo79xuWnfKq
ARC-Seal: i=1; a=rsa-sha256; t=1525535726; cv=none;
        d=google.com; s=arc-20160816;
        b=oGRTUGteJv+ZWrtyDQhse9EqYLaXJw95UyFa8T+qvildckAB226oN6V2jo0c3SViIV
         HOZT8L1tsN++u0FmW4/kglB2M7NbZOXJlMEsP5Sf8UFlwS5lHZ7I2h3FAOrTT33+RCa1
         Jqk6EyCLoVMmpbnThfO6a2A7h5t/dJ5H0vCKOor3YHgxrjwnTLJ2Y4axLiRWjGrmV0rZ
         UJaN4sHd8gwVf3oc4Hq+pt4pLkufAQTYxAZZbFtwaT0NJ06VsIQrHkTf5scpVAu8W4Y+
         SBDSLstT0GaCoriig4IXj6pvsRys2ar7uhzaBFiFvw4AdCbGjszjkt1AjLiT/luNqIQ2
         mOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=M5ZPH2ou+BTas3P85akSUpTqDUHJxkfiWNLV2vAXmGU=;
        b=dG8LCiKQ+9/ToVAY3hhyv0LcTj+WpKxcWqarmxvg1aVwZTKn96+1g7zZ+kAdg7mD+c
         gyt/70mL5cu85W5d/R6umrv/ACsZZ97JqxrQ9MCJkQ71hMARIIXVsKLowdmfoJiNEkfx
         xqkm+nmo2n5Nc39ieGeqhQcxKNRn3uOE3aMpfRBApBMzYdn0usQeFvAAaBcfEoRcSrDG
         dsovBpJ39r5paBS315RKT8y5zyt6wkIQZuCSXeRrKNZWluLqevJMVgNFG31JIWAKOhOI
         lmm6GYY6XNxKHMvpcDl08c7orry29GS/STtB7wxnM+gNQc4KFQ/UrMSNlcnVhRMxxBea
         gijg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Date: Sat, 5 May 2018 17:55:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch <linux-arch@vger.kernel.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Steven Miao <realmz6@gmail.com>, James Hogan <jhogan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC] Removal of CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
Message-ID: <20180505155523.GA17349@ravnborg.org>
References: <CAK7LNAR59KjaJdDNwJaSR_79s84hBj_MqMQ=PaFqJqzBKLUsJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR59KjaJdDNwJaSR_79s84hBj_MqMQ=PaFqJqzBKLUsJA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=QZlIQPTv c=1 sm=1 tr=0
	a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
	a=kj9zAlcOel0A:10 a=qYGqzQJWzbwzNlO2xnsA:9 a=CjuIK1q_8ugA:10
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599618878977275794?=
X-GMAIL-MSGID: =?utf-8?q?1599640150263683314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 05, 2018 at 07:16:13PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> 
> CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected
> by BLACKFIN and METAG.
> 
> Now that both architectures removed in the previous
> merge window, there is no more user of this CONFIG option.

No need to keep this around, just in case someone steps up
to add support for these archs again.
There is no users so it will bit-rot over time anyway,
and will confuse new readers.
And if an arch shows up there is now a good incentive to
do what everyone else does, rather than having
special handling in the kernel.

Removing the symbol has the extra benefit that the kbuild
files becomes a little more readable, something we should
always welcome.

In other words - drop the symbol.
And well spotted!

	Sam
