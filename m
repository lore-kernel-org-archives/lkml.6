Return-Path: <sam@ravnborg.org>
X-Google-Smtp-Source: AB8JxZp31DteDrLGBIgBNuh6BJjSizpBgBikNuQ4Yb6hlL03qrtNYKNWx3DGbp5DJ/U+A+wI3IMW
ARC-Seal: i=1; a=rsa-sha256; t=1527004421; cv=none;
        d=google.com; s=arc-20160816;
        b=rKqwbnkBrxEBvkOQOjjFCtBQ3wHcooiJv896+RgM6Z58ylxiKlHQkhojAsnTUJjCcp
         Cx3cT5Z+cevv15fGZsKTbAAl8YEvW62GCNMkJGJoFH208sAJR71xNK/RN40sSPXu2wD3
         Pmrfivye6Rv6702g2e7L6FhfsSznUga1Iid9yjjVSOTVbKepJ36qB0DEb/JKpKbP6m6v
         9ny/+H69ZGk8+eRwZek5B8p3lIO6ot5rBMf3TG6L3B+jGqQs8/tle/nRCrcuQRTEgjRS
         0LymwxyehOxvvcITOAUxVPFZcFQ1GsSWngOQyWjJgOFXjqaHh9nEzRBrODpX6KG67iqP
         +Uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=0k0+DvXzi537ovfeaWmT6EsTEFPoeIvjVgu9HTsoEps=;
        b=DiNs4TONLP3RienWsvqsr/HT9Uw+J4cAlxnY/9Oll5haaUgeYRN6UW3Fw6JjcnM3ik
         2MXEtYHGHrHYWrKxiR7Z65OxSh4BFijHxxhpEPsSA3ecgAMw6rgUhtSIFr/7aL0y6DCm
         R35+k2u+dF7SdKkZyr2TvCdOt8gbnj6Fe+LxpV9WGGcfIuO4OVe5La4KBXvV23sDiJja
         lbgKQVKvKDlWXw+qL3xfK6VHckAa6r63ULsq8my/CWk+R/+KaJ5XW3sOir5hFZxyBqV2
         wx5AFqiEQHvew/VnmFxdw2oelj8NFoVUAT9H0/O+aU/Tto3w6NyAIvcU3cDjhLHPB2I/
         Uy2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.247.116.15 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.247.116.15 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Date: Tue, 22 May 2018 17:53:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Michal Marek <michal.lkml@markovi.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arvind Prasanna <arvindprasanna@gmail.com>
Subject: Re: [PATCH v3 0/4] kconfig: refactor package checks for GUI frontends
Message-ID: <20180522155339.GB23783@ravnborg.org>
References: <1526973741-664-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526973741-664-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
	a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
	a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=7gkXJVJtAAAA:8
	a=gVRd6cgqtpjkFhrk46YA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
	a=E9Po1WZjFZOl8hwRPBS3:22
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601148064396459595?=
X-GMAIL-MSGID: =?utf-8?q?1601180188328768220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masahiro.

On Tue, May 22, 2018 at 04:22:17PM +0900, Masahiro Yamada wrote:
> 
> Kconfig supports 4 GUI frontends.
> Each of them needs some support packages, but checks them differently:
> 
>   qconf, gconf: check packages in Makefile (pkg-config is required)
>   mconf: lxdialog/check-lxdialog.sh
>   nconf: needs ncurses, but its presence is not checked
> 
> This series refactor the package checks so that all of them work
> in the same way.
> 
> The package check scripts have been moved to scripts/kconfig/*conf-cfg.sh
> 
> The motivation of this clean-up is Randy's following patch:
> https://patchwork.kernel.org/patch/10277723/
> 
> I want to clean up existing code before adding more checks.

All patches in the series reviewed - fine.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
