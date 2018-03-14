Return-Path: <dmitry.torokhov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521046486; cv=none;
        d=google.com; s=arc-20160816;
        b=upvyhn1vta+JT0gN0fwES17EhtCFovDbbsvwlo+QZHao7pHb4yDXyIllAA2Qp7FOPe
         Brax4hH6Df24sip+FoxXTHFoYwlmM1zuyapRlW5BNJUJCtnfnzeUGpixWJUdQPAEAXfW
         JxQJdoFsW2Ic/q0Lxwwjo57fepj76OqK03q7jiUuHCWBePB1778kVUMW+Mw70P30HcBF
         AfvhSBC9dCjqchiTAysB7x99sz6lZGvRubv4MhKK1a19jcPlH/ioWE52s8ZCHCLJt75f
         PbGJeTwCydIsFpuqYD6L0IVGZRln18PdOXxSp7iVG9/AOlo44nICmisJtM0VVDXkWwJH
         7mpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=iXJxqlqmhce2d26t7zRoLNxO64vkJW+WayRO/H4DK2w=;
        b=tNq7Drh018so+mrnh/RIlkWZdjrJUvC3+JZsBZ9a+hRmvFUoZvu1k8I+hZ4D3qkTxs
         vQp9geYcka9zPWCcSZZ9DXZoCo4SvAToR/3nxQL0DuPgr8M3+bmMNE+4p+VZIzZ/y8uQ
         9sCER9WcNLeXCUzUuy94CnGq2SZMlgU27bF3WUSi8tq3PfWXnu/3UYxWnkTKvOOEBeaH
         /8gN5LsurEKAGJMZxBxIVEoDeDa9Kn53RjoS++CX6K4xJ9LgFXr++Dc8a/SpBOoeMF5m
         F1YIlD36qNZ3HN0yV2lerUZsYoZWabXhdiiXziP2uXTbrAg0igV1fp2h5nBdOy2UCGV6
         /h6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cJrnCPNi;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cJrnCPNi;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuyAHg99pbLq0cLxDDqezNv/U/Ne+c4imBnvvO73P1kboW1HNyZdXR4CgMyMGuDbfUiQ1wACw==
Date: Wed, 14 Mar 2018 09:54:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Joe Perches <joe@perches.com>, Mark Salyzyn <salyzyn@android.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
Message-ID: <20180314165442.GB74407@dtor-ws>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVwjP6cWM=Ku6KRVz9F8_n4OsgeK42UZa6BenKij4iu4Q@mail.gmail.com>
 <1519221748.10722.34.camel@linux.intel.com>
 <1519221953.10722.38.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519221953.10722.38.camel@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957911897092414?=
X-GMAIL-MSGID: =?utf-8?q?1594932840489887361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 04:05:53PM +0200, Andy Shevchenko wrote:
> > TBH, I don't see much consensus among developers on this topic.
> > I wouldn't like to send a new version until it would be a consensus.
> 
> I would love to see the comments followed by an agreement from majority
> of people who are in Cc list here.

Not sure why I am on the CC list, but if we add it at all I do not think
this should be guarded by a config option. Otherwise let's add options
for %d and %s as well.

Thanks.

-- 
Dmitry
