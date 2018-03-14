Return-Path: <kernel-hardening-return-12570-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELukgTkhAhX/euKNRSk9Z3kXUdISLaFt3kDnuMjiFngkGAEEer7IGhbmJ9g03mWev6N32eSn
ARC-Seal: i=1; a=rsa-sha256; t=1520993533; cv=none;
        d=google.com; s=arc-20160816;
        b=WAHt+KGXccOBbPimmdPSBtezhkQOxvzPzaj+0APRQXxTEPMT1om7a5sKluIDSxHizw
         AomDE1jy8ieuTeMu1QrbulVjyq+8+KE49W1mM4qyTqD9RyXuIg5JkGF013sWNcgDNB6r
         +hxzA1yYeM/gl1VGlsB+J6SvhxQ2iq2aHq+bCUC9GBYphZyRCLioUraD1WrDc01GzDmG
         RIcqK06xJqN4HeTmauyGQczcdvCZZSHajlfrGo6o4liVN9hU+Lit40hzmWwi42UZhuMW
         RwS3Ti4XpR6v2mKh8DyURoXn9KDixhi2uvrhzPcobHCMf+J7k7o7c9MJhr62qT3MYC4/
         QiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Ox7y2y6xj3HpxSM4HD+JtZ2N8Jymv5Uj19floDRXvdE=;
        b=UFewQNNa3SBxLm2pDMSp6t3hoh4X4hfTwbWQGBcNfAtk5z53XArzl5i348kJHQDJlG
         Q51EAF2WpS45b7VV+YYiolL+oEbEmAQUIK6bLdJgN+HEnDhtnpP6evaYxSJ82Ix7c8gm
         sfjKB9AIX5dL1dLZ+shTAVx81pRgM9F5SUxENLSBIP7OkA9W8TYUEChxc5JVeSuzV0vL
         Kpn2H4e/l/X4q8hgEcAyNwwL0v6xJAik6eykKl0jWSCJIUYoGfrQfGGRunPE/w/dpGWj
         NEyv/SmmidtB2ozKMAh8l7jXHv40dAOMERvM+GTGgiMWEdewFZKT61aeIT5igsN+MIt2
         rtFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=WFi54tJD;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=g6lk+g44;
       spf=pass (google.com: domain of kernel-hardening-return-12570-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12570-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=WFi54tJD;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=g6lk+g44;
       spf=pass (google.com: domain of kernel-hardening-return-12570-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12570-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:64SoWq6j7L-hbr0f5LBjN_cfB9pKxao1qBYhDJCnmPmCNOQn_TEl6A>
Date: Wed, 14 Mar 2018 13:11:51 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>, kernel-hardening@lists.openwall.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	"open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
Subject: Re: [RESEND] rsi: Remove stack VLA usage
Message-ID: <20180314021151.GA11666@eros>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
 <20180312094606.8192B6081A@smtp.codeaurora.org>
 <20180313201757.GK8631@eros>
 <CAHp75VeM1zNyNtHvsn0=rg_xibcitVHREY73cAk=KCSK3Ti3vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeM1zNyNtHvsn0=rg_xibcitVHREY73cAk=KCSK3Ti3vw@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594877315645424201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 11:00:47PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 13, 2018 at 10:17 PM, tcharding <me@tobin.cc> wrote:
> > On Mon, Mar 12, 2018 at 09:46:06AM +0000, Kalle Valo wrote:
> >> tcharding <me@tobin.cc> wrote:
> 
> I'm pretty much sure it depends on the original email headers, like
> above ^^^ — no name.
> Perhaps git config on your side should be done.

Thanks for the suggestion Andy but the 'tcharding' as the name was
munged by either Kalle or patchwork.  I'm guessing patchwork.


thanks,
Tobin.
