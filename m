Return-Path: <kernel-hardening-return-12574-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt+N9dOR2d4yWQ4JAB6aIhP154MNrtJjUZH4n6z2kq3YLNzk7CM9aSa5ydjJGYyvkMxEe39
ARC-Seal: i=1; a=rsa-sha256; t=1521018371; cv=none;
        d=google.com; s=arc-20160816;
        b=R/8WLzg/0XEtYaO5FjIE6QkyqvhmJKPeE2vS1LUblkuzLOrKL8wTV+ka6ua1vV1Cj+
         7nVc1yx1C264ZyS/Jo+SzgAdU+rUBOeOPL73KRZHGDc3E2SRBhc3xJXpZnTk7B1JaTPM
         o39z3NkkNDO8BxiH+fy+Pq5Sh0pYTnlu4WAi2jfstvFOQQEetttyh8mbAZoWt+EjzEvu
         MLS5fbfiF8JVd0o6ZfBhmz7SdVltWm2a/j5PbYjiazwGcccIH3jiPIr41nkHbNsmrPx8
         V2P/fGZM07Z0Vsvw0eEe+y2vhW/HYR83fhX4BvkDxaf5ZZj3O60TPvWg6K4Oei1ka4UJ
         yJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=1iSDNnYi7D2BYgiPUoaTIDCCpR8CKPZoh+bYLadlHQA=;
        b=CoJsrHsqHrtXiNwbCQ2KQYV2QA1Y8PIUSNVrLqpDgH1AF5T7QAAYZyHNCfYWfF0rd0
         vW862chEYwjYV0ZzLZKhhJ5LkPx02FaS2NgLm+BuIytPu1X1Io5TiwasrFd4cHqyJ50k
         xBncY2kKEr4SKKW2cdIi8EGIBgzqoudqce90hVMaMVP+HizyPdalESuNPNcr2MuGenlf
         Isk4WAf8jhly3E2OxsUmjX22IsnzNzLSo0bGLStMUI9Hs4Z9EutmhZNqtdgOc8fOCrAn
         3KYWg0dkaG8iE/RbWKXe+F+2/B5Lv/PeQXOPyznhFjyvQCfGR9e+3Ufc0S//X4dGteek
         35Sw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=oPD7UHMi;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cHhGun0u;
       spf=pass (google.com: domain of kernel-hardening-return-12574-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12574-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=oPD7UHMi;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cHhGun0u;
       spf=pass (google.com: domain of kernel-hardening-return-12574-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12574-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13B98603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: tcharding <me@tobin.cc>
Cc: kernel-hardening@lists.openwall.com,  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,  linux-wireless@vger.kernel.org,  Tycho Andersen <tycho@tycho.ws>,  Kees Cook <keescook@chromium.org>
Subject: Re: [RESEND] rsi: Remove stack VLA usage
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
	<20180312094606.8192B6081A@smtp.codeaurora.org>
	<20180313201757.GK8631@eros>
Date: Wed, 14 Mar 2018 11:05:32 +0200
In-Reply-To: <20180313201757.GK8631@eros> (tcharding's message of "Wed, 14 Mar
	2018 07:17:57 +1100")
Message-ID: <87o9jr6n8j.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594903360081726561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

tcharding <me@tobin.cc> writes:

> On Mon, Mar 12, 2018 at 09:46:06AM +0000, Kalle Valo wrote:
>> tcharding <me@tobin.cc> wrote:
>> 
>> > The kernel would like to have all stack VLA usage removed[1].  rsi uses
>> > a VLA based on 'blksize'.  Elsewhere in the SDIO code maximum block size
>> > is defined using a magic number.  We can use a pre-processor defined
>> > constant and declare the array to maximum size.  We add a check before
>> > accessing the array in case of programmer error.
>> > 
>> > [1]: https://lkml.org/lkml/2018/3/7/621
>> > 
>> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
>> 
>> Tobin, your name in patchwork.kernel.org is just "tcharding" then it should be
>> "Tobin C. Harding". Patchwork is braindead in a way as it takes the name from
>> it's database instead of the From header of the patch in question.
>> 
>> I can fix that manually but it would be helpful if you could register to
>> patchwork and fix your name during registration. You have only one chance to
>> fix your name (another braindead feature!) so be careful :)
>
> Hi Kalle,
>
> I logged into my patchwork account but I don't see any way to set the
> name.  Within 'profile' there is only 'change password' and 'link
> email'.  I thought I could unregister then re-register but I can't see
> how to do that either.

Ok, maybe you have registered (=logged on for the first time) already
earlier so it's not possible to change the name anymore.

> Is there a maintainer of patchwork.kernel.org who I can email to
> manually remove me from the system?

helpdesk@kernel.org should be able to fix your name in patchwork, at
least they have done it in the past. This is not the first time this has
happened.

-- 
Kalle Valo
