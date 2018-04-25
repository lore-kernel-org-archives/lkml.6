Return-Path: <kernel-hardening-return-13138-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZpSb3AJo2BIVlDkK6pWHqLwVyf7BcJlHZyMhqGkrBps3MUfHJYCR9nmepAt59zYTXxP6AVK
ARC-Seal: i=1; a=rsa-sha256; t=1524665731; cv=none;
        d=google.com; s=arc-20160816;
        b=PWq7XTEhbZ1vuhTeN5Ubc1vV0jtzI2/9/xcZfO2p0l/Ulr1BvzaKxk9Zwp9uS+UWcy
         0TtMr2Blm8y9km7UuLF49B2foNkjEYEloAemaBD3atqpFqOQqFujBT+5obF8+XW+aavV
         uQThALrIJelxk7/ND2s/3wboj+57AyaQREOVeO+44UmS6gszIsSmLCwtkPAvkKG6LIyr
         ivoXEwoihoVYDbCT8BuEQbILlISpdMrNCu0aq3I3WnuivagB9WSM0M3e5XTBS37lkKyM
         HPttIL4ZSbzF3S3g5DWKWkGdEI6P9y67jsOk9VOmcPv3ey+JSmncmi8h7pMwJr4H5E26
         qfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Gg09D7JR+QJJS+gMBBY0SPSzRgTOt1RcAWNbHILe6Nw=;
        b=Dwt7mjd9PTTGxE4RP7oW3tP14rlLcV2cCy/Bpej0rDRBRsbFzkoL9x8vvhI4kD9hXR
         HgF5knjpTy41bdgxCwQdutu3TnwdKHj9NCNO/wCg5liWWbNYSLMN4sPHTHkBTW+7LW9X
         B0NKFkYJQYJq6Nh6D3L2BiZzb344axzQf1m7fK9Ibnsk12ybLnpq3n/D5MG+oPhq+1oP
         dfMtotPXuzrpXZGpSl8XTg/wkD25SNm82ge8Sy2TPhKOeDycI3RPPamhbZXbj/KqITuP
         alrQRYmiWLNfSNz5MAY9/WMjU+fdFTfvLy7CZrg+LiIjmTFNFqX8CBwM+QmFOgscJ4Hx
         gfTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=qBnQQNGj;
       spf=pass (google.com: domain of kernel-hardening-return-13138-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13138-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=qBnQQNGj;
       spf=pass (google.com: domain of kernel-hardening-return-13138-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13138-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 25 Apr 2018 08:15:07 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: keescook@chromium.org, serge@hallyn.com, ebiggers3@gmail.com,
	dhowells@redhat.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com, jmorris@namei.org,
	Jason@zx2c4.com
Subject: Re: [PATCH 1/3] big key: get rid of stack array allocation
Message-ID: <20180425141507.GA4240@cisco>
References: <20180424143539.GB3125@cisco>
 <201804242346.FHI69745.SQMHFVOOFLFOJt@I-love.SAKURA.ne.jp>
 <20180424145104.GC3125@cisco>
 <20180424195845.GB23575@mail.hallyn.com>
 <CAGXu5j+SXCJpm9xnX1UaY0Qz2+E0qNETc+s8kwrH6hE9LLjgpw@mail.gmail.com>
 <201804251936.GAG73463.HOJtFFOQSLFOVM@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804251936.GAG73463.HOJtFFOQSLFOVM@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589451187807410?=
X-GMAIL-MSGID: =?utf-8?q?1598727893867383044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 07:36:21PM +0900, Tetsuo Handa wrote:
> Kees Cook wrote:
> > On Tue, Apr 24, 2018 at 12:58 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > > Quoting Tycho Andersen (tycho@tycho.ws):
> > >> On Tue, Apr 24, 2018 at 11:46:38PM +0900, Tetsuo Handa wrote:
> > >> > Tycho Andersen wrote:
> > >> > > > > +     if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
> > >> > > > > +             WARN(1, "big key algorithm changed?");
> > >> >
> > >> > Please avoid using WARN() WARN_ON() etc.
> > >> > syzbot would catch it and panic() due to panic_on_warn == 1.
> > >>
> > >> But it is really a programming bug in this case (and it seems better
> > >> than BUG()...). Isn't this exactly the sort of case we want to catch?
> > >>
> > >> Tycho
> > >
> > > Right - is there a url to some discussion about this?  Because not
> > > using WARN when WARN should be used, because it troubles a bot, seems
> > > the wrong solution.  If this *is* what's been agreed upon, then
> > > what is the new recommended thing to do here?
> > 
> > BUG() is basically supposed to never be used, as decreed by Linus.
> > WARN() here is entirely correct: if we encounter a case where
> > crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE is not true, we
> > run the risk of stack memory corruption. If this is an EXPECTED
> > failure case, then okay, drop the WARN() but we have to keep the
> > -EINVAL.
> 
> big_key_init() is __init function of built-in module which will be called
> only once upon boot, isn't it? Then, there is no point to continue after
> WARN(); BUG() is better here.

I don't think so. The machine can still boot and work just fine, but
big key crypto will not be available. I suspect there are some
machines out there that don't need big key, so there's no reason for
the boot to fail. That's the rub about WARN vs BUG -- that in most
cases things can continue on happily.

> Moreover, if this is meant for sanity check in case something went wrong
> (e.g. memory corruption), it is better to check at run time like

But the algorithm is hard coded at the top of the file, so one check
is enough.

Tycho
