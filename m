Return-Path: <kernel-hardening-return-12616-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsaT/bMESZHi1CZwqisij4iJtTWMW9lhTO4s7BhiXaqLFNn3Z4CNd9y7yvqi0IgJXDjqww4
ARC-Seal: i=1; a=rsa-sha256; t=1521058808; cv=none;
        d=google.com; s=arc-20160816;
        b=Zpd2nPZsVlcwf6P0NbrLg8QKBOlFOmocloLQfAGC09umpxdu29HLP5t72CrLHVgCxO
         rduNEP7SLkA3a6jqtDS2I/dxDotA4iAcA2bjOwqszS7irJ2A1pPyO6y4SXGMKSvA2Vl4
         U3uZ94+ew/YAlNLcpGMQB06eWy6W2bt2WGb+NRPeZof2ntOmo5WZ24BT4n7Q7EPvAOd6
         8eandD/jQi6BOaF6szzeraHGWRM3Sqm28CiHlsuLGfhIpVvJ7Lt4mAARcQSMYFUoANi/
         heznMkTnFGNtU/LaPIDAJetVe4/hVUW+wfQ20tzCaLgei344do+lSiEJTo9RLIgaEG2l
         uccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Tfwi64gUYP005TIrD9TGoA4zlKyijKp9YEF6Nf0jYmM=;
        b=GlAh4z/AfeGndAVZ/mL9kUWCezgi9YYaAOZubSbJKIOpz9iCBQzB1Juedc1sZGIiWo
         7Jdzl6+i8pL8rphfw1nbpjK9RzUNxG12hKHItk2d556q1XeVEGT7YJ3fnYof1qfEGHqU
         ZXDBMB4hVemIVcxxtmxC65sBbFPXc2leQ+VvVk7w5FADYiya5HTwutmfeQV2c+D7aFMG
         23moug/fRR63d3j9//0mpUSy75iuIuvFo8v0H9X89U1Ot0i1V9ER7HRNVaAGl6LC3giB
         jIwluwogs3Xk4g+mVno1+MbIQB2qKpF4rB4CLwnOpIZ/2Igz9B0pkOq08VllPa2smH0h
         +VfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=JAw9UiLQ;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=J2gcEE3v;
       spf=pass (google.com: domain of kernel-hardening-return-12616-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12616-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=JAw9UiLQ;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=J2gcEE3v;
       spf=pass (google.com: domain of kernel-hardening-return-12616-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12616-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:5IOpWmErdA32jrIBkqYSvEYnD-xRGdZb_ncdTjhBPgverdRgyfPfLQ>
Date: Thu, 15 Mar 2018 07:19:44 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	"open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
	Tycho Andersen <tycho@tycho.ws>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [RESEND] rsi: Remove stack VLA usage
Message-ID: <20180314201944.GC11666@eros>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
 <20180312094606.8192B6081A@smtp.codeaurora.org>
 <20180313201757.GK8631@eros>
 <CAHp75VeM1zNyNtHvsn0=rg_xibcitVHREY73cAk=KCSK3Ti3vw@mail.gmail.com>
 <20180314021151.GA11666@eros>
 <CAGXu5jJsDsegY+EZFq1Hip+sRNLR5SS+-Euf1rm22okAq7REJw@mail.gmail.com>
 <20180314034303.GB11666@eros>
 <87fu536mkm.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fu536mkm.fsf@codeaurora.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594945760466307457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 11:19:53AM +0200, Kalle Valo wrote:
> "Tobin C. Harding" <me@tobin.cc> writes:
> 
> > Added Konstantin in case he is in charge of administering patchwork.kernel.org?
> >
> > On Tue, Mar 13, 2018 at 07:53:34PM -0700, Kees Cook wrote:
> >> On Tue, Mar 13, 2018 at 7:11 PM, Tobin C. Harding <me@tobin.cc> wrote:
> >> > On Tue, Mar 13, 2018 at 11:00:47PM +0200, Andy Shevchenko wrote:
> >> >> On Tue, Mar 13, 2018 at 10:17 PM, tcharding <me@tobin.cc> wrote:
> >> >> > On Mon, Mar 12, 2018 at 09:46:06AM +0000, Kalle Valo wrote:
> >> >> >> tcharding <me@tobin.cc> wrote:
> >> >>
> >> >> I'm pretty much sure it depends on the original email headers, like
> >> >> above ^^^ — no name.
> >> >> Perhaps git config on your side should be done.
> >> >
> >> > Thanks for the suggestion Andy but the 'tcharding' as the name was
> >> > munged by either Kalle or patchwork.  I'm guessing patchwork.
> >> 
> >> Something you're sending from is using "tcharding" (see the email Andy
> >> quotes). I see the headers as:
> >> 
> >> Date: Wed, 14 Mar 2018 07:17:57 +1100
> >> From: tcharding <me@tobin.cc>
> >> ...
> >> Message-ID: <20180313201757.GK8631@eros>
> >> X-Mailer: Mutt 1.5.24 (2015-08-30)
> >> User-Agent: Mutt/1.5.24 (2015-08-30)
> >> 
> >> Your most recently email shows "Tobin C. Harding" though, and also
> >> sent with Mutt...
> >>
> >> Do you have multiple Mutt configurations? Is something lacking a
> >> "From" header insertion and your MTA is filling it in for you from
> >> your username?
> >
> > Thanks for taking the time to respond Kees (and Tycho).  I have mutt
> > configured to reply from whichever email address I receive from so if
> > patchwork sent an email to 'tcharding <me@tobin.cc>' (which is the
> > details it has) and I hit reply it would have come from 'tcharding',
> > hence Andy's reply.  I wouldn't bet my life on it but I'm kinda
> > confident that I cannot initiate an email from 'tcharding' with my
> > current set up.
> >
> > Super bad form to blame someone (or something else) but I think this is
> > a problem with how my patchwork account is configured.  Either way, that
> > is still my fault I should have added my real name to patchwork when I
> > signed up (not just username 'tcharding').
> >
> > Is patchwork.kernel.org administered by Konstantin Ryabitsev? Added
> > Konstantin to CC's.
> 
> Like I said earlier, just send a request to helpdesk@kernel.org and
> admins should fix your name.

thanks Kalle, I'm on it.
