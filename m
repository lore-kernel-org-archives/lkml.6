Return-Path: <kernel-hardening-return-12571-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtWbjZ/5JEIb6aZgcSNep/BH7a7YA023XShyvJ7cQcqnOn8JAf9V/anv0CcudGsn7NO+mbt
ARC-Seal: i=1; a=rsa-sha256; t=1520996035; cv=none;
        d=google.com; s=arc-20160816;
        b=ysVKke59Xycq26BfnOAKuI6W/vyziaXqzBgryw2HzUFRWEWH3ooc5z76tVLWrdnrNy
         9oOL9UV80XYg9VxZYo79usofYd+2wE2TvrZA5vuJT/6lmgUmiP9/ljQ6AhFwa/5D+nSh
         ZyULpmqQzeiCfaJei5wBQGkgtUj9fjjk6f1BzwvGhTN/xm77zH5WEPHvVCRdy2AaW/kf
         ZcMckMYbL1Ro/B8kWIi/byTQjMFroR6PoJMXO2IWrjREehHZ1kZAARCeXxJVSjgriBNw
         d594zNBjZCRKSHHFFeQgkq7leWMMhvcAywkB79TxI61peLs31mCQNMsFqGWOYjCoJdsb
         sltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=H7PzIZCzrZhcHZxrkgIwDwLlFEpfC3qOq38m1u7wanA=;
        b=h+RjnHe51GZHtwQRjJf1hn8IHlY3YmbrV51x+K245htsIODoKLRTR3LnKRMNnNX6ZT
         cOKVckDIPeyKW80vCTgogV5X3m44SaNoDDh+Lz1D4YUFEXue+a8yz1BVt2BTiFDikK7E
         MwS7cv4B4n0jq1pKXz12icq/ppTvV2GsO8f60/9+FsJJ4GbXChReopxZoOMVoSPr2JVh
         ompEW+2XugVpkEsKlcYen3dHBn+v/xsTmzdhFU7dJpGtgaGI8WbnZSH0UiXTFVTndmU/
         KWJua5xE6M7aNHPpXsw8h+3JODlmhwLfnN5Rluge1i/CUXKlBAhQdOG9TG5mVW537czW
         Eh/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=isRvmozB;
       dkim=pass header.i=@chromium.org header.s=google header.b=egh+7uGX;
       spf=pass (google.com: domain of kernel-hardening-return-12571-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12571-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=isRvmozB;
       dkim=pass header.i=@chromium.org header.s=google header.b=egh+7uGX;
       spf=pass (google.com: domain of kernel-hardening-return-12571-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12571-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180314021151.GA11666@eros>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
 <20180312094606.8192B6081A@smtp.codeaurora.org> <20180313201757.GK8631@eros>
 <CAHp75VeM1zNyNtHvsn0=rg_xibcitVHREY73cAk=KCSK3Ti3vw@mail.gmail.com> <20180314021151.GA11666@eros>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 13 Mar 2018 19:53:34 -0700
X-Google-Sender-Auth: H98tt09ar5K0QTFzoLtj-Tco3e8
Message-ID: <CAGXu5jJsDsegY+EZFq1Hip+sRNLR5SS+-Euf1rm22okAq7REJw@mail.gmail.com>
Subject: Re: [RESEND] rsi: Remove stack VLA usage
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Kalle Valo <kvalo@codeaurora.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
	"open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>, Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594879939279959401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 7:11 PM, Tobin C. Harding <me@tobin.cc> wrote:
> On Tue, Mar 13, 2018 at 11:00:47PM +0200, Andy Shevchenko wrote:
>> On Tue, Mar 13, 2018 at 10:17 PM, tcharding <me@tobin.cc> wrote:
>> > On Mon, Mar 12, 2018 at 09:46:06AM +0000, Kalle Valo wrote:
>> >> tcharding <me@tobin.cc> wrote:
>>
>> I'm pretty much sure it depends on the original email headers, like
>> above ^^^ =E2=80=94 no name.
>> Perhaps git config on your side should be done.
>
> Thanks for the suggestion Andy but the 'tcharding' as the name was
> munged by either Kalle or patchwork.  I'm guessing patchwork.

Something you're sending from is using "tcharding" (see the email Andy
quotes). I see the headers as:

Date: Wed, 14 Mar 2018 07:17:57 +1100
From: tcharding <me@tobin.cc>
...
Message-ID: <20180313201757.GK8631@eros>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)

Your most recently email shows "Tobin C. Harding" though, and also
sent with Mutt...

Do you have multiple Mutt configurations? Is something lacking a
"From" header insertion and your MTA is filling it in for you from
your username?

-Kees

--=20
Kees Cook
Pixel Security
