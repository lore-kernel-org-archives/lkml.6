Return-Path: <kernel-hardening-return-12573-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvzFZgF+uSoEl3vlUPmk9toUjQfkefpyJMexNxamp/o+o2zyyIUYyekvkvIgQTso6oblZQU
ARC-Seal: i=1; a=rsa-sha256; t=1520999005; cv=none;
        d=google.com; s=arc-20160816;
        b=jKA4jnd07Nff3CTxvE45oKL2NLHhq41KsN/iqAUchp/8OBuNDo6zSpUbbAf1SNfEnB
         FYh+WiEb9MXH2L6cI93qsrGB2Y1Q+9XfJhCSakic8lQRDXyPcOZoVLNG6rsN3/ujcuK0
         v+isVE9ZItmJtiI4il3/YaeuzJDPY7NbUsN6jy6O4LH8j75OvfErke9x1ZnUvb/Z02oa
         GYJF7C6zXmBfLVxwzO8/IK2qOLyF/jlhr7q5DTm3fqjfD+E6yFQ9tPuzz7zSrLu/ugVF
         /AKInnBBjnuoYfaP4pN1nitbzofOXBXFns/6aW5gTsq2HrkivkXAc2O/Ry70qE9IX7rM
         uaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=yJBA6nm2z+x2kavWMOPLrIooZDz93CHq2aQdLuAFVVY=;
        b=A3GWOXlcijtXNmZoERmxAq5O/k2t9pWVgiID8a6pOD1QeBiCi6fz78yZqsxvMtN9Wb
         Mh1dIjCRyop9tVN7iLkpT2i7fZeJtXidlPsYX87NOfmi093lHOHgS3DhdMI3bbB0Xdt9
         R2b0DqBwpd8L79zqzzuwOI6P35oglP1Q6LSXIBP7xXFjZgG9kIldyUZtRT2U+JDmGD0r
         D4d6bgKHygmfus75JCDnQnUEEeUE31HKxZsH/4KtcXVnVVTmFvCKrCgzu9W1uJyLDisd
         j19mH/LmKsnCbFEXxs5i2pHFAwuS2bFw3zVyHI6qIXJ95NWwYAPS+kCvPBQK61FJzsHj
         FdnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=VsGpSEgG;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Nli4YNpu;
       spf=pass (google.com: domain of kernel-hardening-return-12573-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12573-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=VsGpSEgG;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Nli4YNpu;
       spf=pass (google.com: domain of kernel-hardening-return-12573-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12573-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:SpqoWhlmCUUolyTHfpXU2ncOuSqqpmvHSgGPo38iUIRb6edO0H0dEg>
Date: Wed, 14 Mar 2018 14:43:03 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	"open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
	Tycho Andersen <tycho@tycho.ws>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [RESEND] rsi: Remove stack VLA usage
Message-ID: <20180314034303.GB11666@eros>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
 <20180312094606.8192B6081A@smtp.codeaurora.org>
 <20180313201757.GK8631@eros>
 <CAHp75VeM1zNyNtHvsn0=rg_xibcitVHREY73cAk=KCSK3Ti3vw@mail.gmail.com>
 <20180314021151.GA11666@eros>
 <CAGXu5jJsDsegY+EZFq1Hip+sRNLR5SS+-Euf1rm22okAq7REJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXu5jJsDsegY+EZFq1Hip+sRNLR5SS+-Euf1rm22okAq7REJw@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594883052931283233?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added Konstantin in case he is in charge of administering patchwork.kernel.org?

On Tue, Mar 13, 2018 at 07:53:34PM -0700, Kees Cook wrote:
> On Tue, Mar 13, 2018 at 7:11 PM, Tobin C. Harding <me@tobin.cc> wrote:
> > On Tue, Mar 13, 2018 at 11:00:47PM +0200, Andy Shevchenko wrote:
> >> On Tue, Mar 13, 2018 at 10:17 PM, tcharding <me@tobin.cc> wrote:
> >> > On Mon, Mar 12, 2018 at 09:46:06AM +0000, Kalle Valo wrote:
> >> >> tcharding <me@tobin.cc> wrote:
> >>
> >> I'm pretty much sure it depends on the original email headers, like
> >> above ^^^ — no name.
> >> Perhaps git config on your side should be done.
> >
> > Thanks for the suggestion Andy but the 'tcharding' as the name was
> > munged by either Kalle or patchwork.  I'm guessing patchwork.
> 
> Something you're sending from is using "tcharding" (see the email Andy
> quotes). I see the headers as:
> 
> Date: Wed, 14 Mar 2018 07:17:57 +1100
> From: tcharding <me@tobin.cc>
> ...
> Message-ID: <20180313201757.GK8631@eros>
> X-Mailer: Mutt 1.5.24 (2015-08-30)
> User-Agent: Mutt/1.5.24 (2015-08-30)
> 
> Your most recently email shows "Tobin C. Harding" though, and also
> sent with Mutt...
>
> Do you have multiple Mutt configurations? Is something lacking a
> "From" header insertion and your MTA is filling it in for you from
> your username?

Thanks for taking the time to respond Kees (and Tycho).  I have mutt
configured to reply from whichever email address I receive from so if
patchwork sent an email to 'tcharding <me@tobin.cc>' (which is the
details it has) and I hit reply it would have come from 'tcharding',
hence Andy's reply.  I wouldn't bet my life on it but I'm kinda
confident that I cannot initiate an email from 'tcharding' with my
current set up.

Super bad form to blame someone (or something else) but I think this is
a problem with how my patchwork account is configured.  Either way, that
is still my fault I should have added my real name to patchwork when I
signed up (not just username 'tcharding').

Is patchwork.kernel.org administered by Konstantin Ryabitsev? Added
Konstantin to CC's.

thanks,
Tobin.
