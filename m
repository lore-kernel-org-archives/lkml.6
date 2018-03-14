Return-Path: <kernel-hardening-return-12576-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvDPzUQjuyeG8jQ3EI3QJLj2Hjr7Fp3eBzkYkwqCkVmkc/ZDTtL8PBIKatSNyNpJfHgAewO
ARC-Seal: i=1; a=rsa-sha256; t=1521019218; cv=none;
        d=google.com; s=arc-20160816;
        b=JrgOWKmGGYu8qmSC3a8Gvy0jloBag6BILqWgEybrsh38w7mzUt9RBksSfY2SFiP/9N
         PTHTIQc+IPHkptv5FfzLqYkatxhIWHTHs1G1qL8JXXRwr/wRxORwubTgwc32xXWL+unY
         SAUjBgtaDYggcyb7svhHoPQgkHu9A7G6TgjO6yzBBqTqOzSfDGcUsO8cipbR8BlwAXJ1
         Zt2gN4zVjgP8zJMQmDuvJlI82Irvj3MhzmqEJnqF2kwqZcpX1y/YU0iXC75JfSKFiO4K
         Edlk++nIKXbDnzL3eBftXGHaKWPpzt29DOkaCpciM0sqdVEaGbwhAjOeubWYkBfiEkzI
         D/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:dmarc-filter
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=M34PL1nf3MdUCQlB3NdAOovq7XcPKmq0C4Ki0B1Muq8=;
        b=luFratamAPo484sVftLPZwUvjmDzOtJy8uuNDJU74KwgUVDlMlmRKEEr36mrp8NkNw
         a0LudK733zECI+61fnD36ATyD0N77GaOQRVDo4P+uZmV8C0FGCagE6Lgy5rHWX12fVY2
         CAieVYKKuVMlqH5b85TCI3PoFH2bBE3uZF7LvVNAuVrs8l3WQZgWfabDTVdcpoPzlLws
         gfv3X3qr7LM8JIgM4ux6JMYwhbxz79C7MYIQPD58g7zOpQL3vEan+BwqESUAV/oKvXpY
         zHKeuWhfaA5KwKyFmYYkMM6RwgAX+fnjX+lM5s3lkOcx7tkHkukYYAc6hQ1l37NYLZZ3
         q7bQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XPKbBfQF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bcFU9PG5;
       spf=pass (google.com: domain of kernel-hardening-return-12576-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12576-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XPKbBfQF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bcFU9PG5;
       spf=pass (google.com: domain of kernel-hardening-return-12576-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12576-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63D8060590
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
	<20180314034303.GB11666@eros>
Date: Wed, 14 Mar 2018 11:19:53 +0200
In-Reply-To: <20180314034303.GB11666@eros> (Tobin C. Harding's message of
	"Wed, 14 Mar 2018 14:43:03 +1100")
Message-ID: <87fu536mkm.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594904248358312837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Tobin C. Harding" <me@tobin.cc> writes:

> Added Konstantin in case he is in charge of administering patchwork.kerne=
l.org?
>
> On Tue, Mar 13, 2018 at 07:53:34PM -0700, Kees Cook wrote:
>> On Tue, Mar 13, 2018 at 7:11 PM, Tobin C. Harding <me@tobin.cc> wrote:
>> > On Tue, Mar 13, 2018 at 11:00:47PM +0200, Andy Shevchenko wrote:
>> >> On Tue, Mar 13, 2018 at 10:17 PM, tcharding <me@tobin.cc> wrote:
>> >> > On Mon, Mar 12, 2018 at 09:46:06AM +0000, Kalle Valo wrote:
>> >> >> tcharding <me@tobin.cc> wrote:
>> >>
>> >> I'm pretty much sure it depends on the original email headers, like
>> >> above ^^^ =E2=80=94 no name.
>> >> Perhaps git config on your side should be done.
>> >
>> > Thanks for the suggestion Andy but the 'tcharding' as the name was
>> > munged by either Kalle or patchwork.  I'm guessing patchwork.
>>=20
>> Something you're sending from is using "tcharding" (see the email Andy
>> quotes). I see the headers as:
>>=20
>> Date: Wed, 14 Mar 2018 07:17:57 +1100
>> From: tcharding <me@tobin.cc>
>> ...
>> Message-ID: <20180313201757.GK8631@eros>
>> X-Mailer: Mutt 1.5.24 (2015-08-30)
>> User-Agent: Mutt/1.5.24 (2015-08-30)
>>=20
>> Your most recently email shows "Tobin C. Harding" though, and also
>> sent with Mutt...
>>
>> Do you have multiple Mutt configurations? Is something lacking a
>> "From" header insertion and your MTA is filling it in for you from
>> your username?
>
> Thanks for taking the time to respond Kees (and Tycho).  I have mutt
> configured to reply from whichever email address I receive from so if
> patchwork sent an email to 'tcharding <me@tobin.cc>' (which is the
> details it has) and I hit reply it would have come from 'tcharding',
> hence Andy's reply.  I wouldn't bet my life on it but I'm kinda
> confident that I cannot initiate an email from 'tcharding' with my
> current set up.
>
> Super bad form to blame someone (or something else) but I think this is
> a problem with how my patchwork account is configured.  Either way, that
> is still my fault I should have added my real name to patchwork when I
> signed up (not just username 'tcharding').
>
> Is patchwork.kernel.org administered by Konstantin Ryabitsev? Added
> Konstantin to CC's.

Like I said earlier, just send a request to helpdesk@kernel.org and
admins should fix your name.

--=20
Kalle Valo
