Return-Path: <kernel-hardening-return-12623-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvDAY6ylJjxtFzdmH0SD0Q0pSkqFnTkF9YvUPvT87M1t85U+TesERaxTRzcb4Vp+aUP4qEJ
ARC-Seal: i=1; a=rsa-sha256; t=1521104872; cv=none;
        d=google.com; s=arc-20160816;
        b=o89EA5+23vU7IZOPv2OsXUUKQyhGVHQhdIevJ1SumTvmdxx2mrBwhIEMKJXHI/+Ibi
         RYAIPaFR3JB+DRWH3BWmOjM/06zKk4xCvSKcB8QcnbNH2eZw2Eet+vPqXBO86xM2VrY+
         YHsdpyFBna74oXg4FKUPEDuY5jAb35wEVWxJcPPR3s/1M50yL5hyKT/RWGXL2EI54f1v
         kAoZXN0/t2hD4C85mIADJBHTL9vWhMacYHAjrg61lX7DdIAGXrLB0wydS7SbiWtEkzG+
         wGWGlDUuca83JSE4MhF/f8ey76sh7bo2s+6SdiuyDLbGUNwnZCYDeiONKZ21ejeHauU+
         KHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:dmarc-filter
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=TNIdWc7xqg9+f6c42swPN7VJc5rzT53x9PaHi5WAsdM=;
        b=h537JhvIDOeCSTGsuTGXC8G/briP6rev9rKGuFNObs1Q0FEi46QSV+XUFWIRUacq1c
         lMzGZZwKrcwOn05y2ORMwEgEMCbbqPA1oS9u8xtcDuhouyoxC+uLki5TUIPcCEbC2f7J
         ymnff6kmg7gptXwxjUvofoUiBQEaofdotqC8ve1eBd8bGutagGz+Zh+UvQyktQh6XxOZ
         FM2o62vCx62EbPZnJjjBHzI8IFVPmZ7HxSBRYfbjaEbVX6NvMwHDnPLdbUei2KyzKy6g
         xn7eUPdG/7TrPNxgoCQZqz2SSsoxMOmNkcwKh54addm1MZunU5LUEGCcVAJyCNF0y9AS
         GshA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WK1R4l0s;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=oASHgbwy;
       spf=pass (google.com: domain of kernel-hardening-return-12623-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12623-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WK1R4l0s;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=oASHgbwy;
       spf=pass (google.com: domain of kernel-hardening-return-12623-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12623-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53107603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Kees Cook <keescook@chromium.org>,  Andy Shevchenko <andy.shevchenko@gmail.com>,  Kernel Hardening <kernel-hardening@lists.openwall.com>,  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,  netdev <netdev@vger.kernel.org>,  "open list\:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,  Tycho Andersen <tycho@tycho.ws>,  Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [RESEND] rsi: Remove stack VLA usage
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
	<20180312094606.8192B6081A@smtp.codeaurora.org>
	<20180313201757.GK8631@eros>
	<CAHp75VeM1zNyNtHvsn0=rg_xibcitVHREY73cAk=KCSK3Ti3vw@mail.gmail.com>
	<20180314021151.GA11666@eros>
	<CAGXu5jJsDsegY+EZFq1Hip+sRNLR5SS+-Euf1rm22okAq7REJw@mail.gmail.com>
	<20180314034303.GB11666@eros> <87fu536mkm.fsf@codeaurora.org>
	<20180314201944.GC11666@eros>
Date: Thu, 15 Mar 2018 11:07:28 +0200
In-Reply-To: <20180314201944.GC11666@eros> (Tobin C. Harding's message of
	"Thu, 15 Mar 2018 07:19:44 +1100")
Message-ID: <87woyd7lm7.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594994063010609020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Tobin C. Harding" <me@tobin.cc> writes:

> On Wed, Mar 14, 2018 at 11:19:53AM +0200, Kalle Valo wrote:
>> "Tobin C. Harding" <me@tobin.cc> writes:
>>=20
>> > Added Konstantin in case he is in charge of administering patchwork.ke=
rnel.org?
>> >
>> > On Tue, Mar 13, 2018 at 07:53:34PM -0700, Kees Cook wrote:
>> >> On Tue, Mar 13, 2018 at 7:11 PM, Tobin C. Harding <me@tobin.cc> wrote:
>> >> > On Tue, Mar 13, 2018 at 11:00:47PM +0200, Andy Shevchenko wrote:
>> >> >> On Tue, Mar 13, 2018 at 10:17 PM, tcharding <me@tobin.cc> wrote:
>> >> >> > On Mon, Mar 12, 2018 at 09:46:06AM +0000, Kalle Valo wrote:
>> >> >> >> tcharding <me@tobin.cc> wrote:
>> >> >>
>> >> >> I'm pretty much sure it depends on the original email headers, like
>> >> >> above ^^^ =E2=80=94 no name.
>> >> >> Perhaps git config on your side should be done.
>> >> >
>> >> > Thanks for the suggestion Andy but the 'tcharding' as the name was
>> >> > munged by either Kalle or patchwork.  I'm guessing patchwork.
>> >>=20
>> >> Something you're sending from is using "tcharding" (see the email Andy
>> >> quotes). I see the headers as:
>> >>=20
>> >> Date: Wed, 14 Mar 2018 07:17:57 +1100
>> >> From: tcharding <me@tobin.cc>
>> >> ...
>> >> Message-ID: <20180313201757.GK8631@eros>
>> >> X-Mailer: Mutt 1.5.24 (2015-08-30)
>> >> User-Agent: Mutt/1.5.24 (2015-08-30)
>> >>=20
>> >> Your most recently email shows "Tobin C. Harding" though, and also
>> >> sent with Mutt...
>> >>
>> >> Do you have multiple Mutt configurations? Is something lacking a
>> >> "From" header insertion and your MTA is filling it in for you from
>> >> your username?
>> >
>> > Thanks for taking the time to respond Kees (and Tycho).  I have mutt
>> > configured to reply from whichever email address I receive from so if
>> > patchwork sent an email to 'tcharding <me@tobin.cc>' (which is the
>> > details it has) and I hit reply it would have come from 'tcharding',
>> > hence Andy's reply.  I wouldn't bet my life on it but I'm kinda
>> > confident that I cannot initiate an email from 'tcharding' with my
>> > current set up.
>> >
>> > Super bad form to blame someone (or something else) but I think this is
>> > a problem with how my patchwork account is configured.  Either way, th=
at
>> > is still my fault I should have added my real name to patchwork when I
>> > signed up (not just username 'tcharding').
>> >
>> > Is patchwork.kernel.org administered by Konstantin Ryabitsev? Added
>> > Konstantin to CC's.
>>=20
>> Like I said earlier, just send a request to helpdesk@kernel.org and
>> admins should fix your name.
>
> thanks Kalle, I'm on it.

Thanks. Looks to be fixed, now patchwork gives me:

From: Tobin C. Harding <me@tobin.cc>

--=20
Kalle Valo
