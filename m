Return-Path: <kernel-hardening-return-12575-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtfqwDsdthWgF2Ldxup2Ki/d/Zkzckmq35SdN1QfWO+qe2yn++RUI6/3AGLRa95QgIqugHH
ARC-Seal: i=1; a=rsa-sha256; t=1521018700; cv=none;
        d=google.com; s=arc-20160816;
        b=H85antXFwW3p1mudi9limLE77GIz0ute+UVLyA20I4fGJOPuk0eyVaVYLExQINQDLU
         Qlis9pV53qPjNKw8nINmB336SQQ/twpn800v2kDiWj40ZaHeIeP+m0Ib8ywxMt4kOMmw
         Glv7O8kYyfAHdi3WFmA8al+rxXcI3L2FsrpYn6iXAZ+d4FphzlpebV9c0z+oBWeYea0Q
         oEdZy8GWCaYFHsJi3g4+I7GUpJ4zFtEivFl9wSxL1hsYswgZM6PK+NNJpL6H7XjKSGjy
         TbjXXhCZvde3+3SeDZ+IaL3iOBnD0f2qUfnorc8sAZsworSgu6aTMrjj1S3EzYZktWBA
         6AiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:dmarc-filter
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=rZw+8uYyQNXTQcP/0PT02ko1xoNFxLrQ0u6iV69v5d4=;
        b=DZmY9I6sIbGDKvMBN80hh3XmPRG/ygk01YE/PY820/LZpr4RdAFvusrVjepZwNV6uv
         jQq6MjyGFw0/D/hTxj1xayO4oS9SE90q+TdLD7vxa3cFnRt54sMo8yXgx3kX5/hnaULT
         BVseYIX/yAyISsNvJIqTVZdPzn9CJvHTM1NW0pE6tDMgYl/WxNUKEQQV++/RmTEPBhRc
         hwGY31qZ2ZFHSri8I51Gl0jWEaoyn2Wvc739NTIe8SVld4HxMebpkyIw+VIDYt4+UjZF
         Q20XusxV5eG4reeEOPuZLTAwQdJuKCcc7SIW7FOpsSpIexLSEjCOBNhs4fwByRsxGhX8
         PXGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YmoHiue/;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YmoHiue/;
       spf=pass (google.com: domain of kernel-hardening-return-12575-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12575-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YmoHiue/;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YmoHiue/;
       spf=pass (google.com: domain of kernel-hardening-return-12575-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12575-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5261F60314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,  kernel-hardening@lists.openwall.com,  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,  netdev <netdev@vger.kernel.org>,  <linux-wireless@vger.kernel.org>,  Tycho Andersen <tycho@tycho.ws>,  Kees Cook <keescook@chromium.org>
Subject: Re: [RESEND] rsi: Remove stack VLA usage
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
	<20180312094606.8192B6081A@smtp.codeaurora.org>
	<20180313201757.GK8631@eros>
	<CAHp75VeM1zNyNtHvsn0=rg_xibcitVHREY73cAk=KCSK3Ti3vw@mail.gmail.com>
	<20180314021151.GA11666@eros>
Date: Wed, 14 Mar 2018 11:11:12 +0200
In-Reply-To: <20180314021151.GA11666@eros> (Tobin C. Harding's message of
	"Wed, 14 Mar 2018 13:11:51 +1100")
Message-ID: <87k1uf6mz3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594903705069348761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Tobin C. Harding" <me@tobin.cc> writes:

> On Tue, Mar 13, 2018 at 11:00:47PM +0200, Andy Shevchenko wrote:
>> On Tue, Mar 13, 2018 at 10:17 PM, tcharding <me@tobin.cc> wrote:
>> > On Mon, Mar 12, 2018 at 09:46:06AM +0000, Kalle Valo wrote:
>> >> tcharding <me@tobin.cc> wrote:
>>=20
>> I'm pretty much sure it depends on the original email headers, like
>> above ^^^ =E2=80=94 no name.
>> Perhaps git config on your side should be done.
>
> Thanks for the suggestion Andy but the 'tcharding' as the name was
> munged by either Kalle or patchwork.  I'm guessing patchwork.

You guessed corretly, patchwork is here to blame. I sent my "please
rebase" mail earlier in this thread using my custom patchwork client
script (pwcli) which takes the name and address from patchwork.

Andy, this is definitely a bug in patchwork and I have seen this issue
multiple times already. I have understood that it has been fixed in a
recent version but patchwork.kernel.org is still running an old version.
In the original mail Tobin did have the correct From header which can be
checked from the headers in patch page[1]:

From: "Tobin C. Harding" <me@tobin.cc>

[1] https://patchwork.kernel.org/patch/10274983/

--=20
Kalle Valo
