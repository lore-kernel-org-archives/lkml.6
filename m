Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AB8JxZqocCHZXCJ+19QzTYk4X9+j2zwM3APlYF6UKP/fTB6MMli5QHcouRDJrOP7lp1FT0KwbtP2
ARC-Seal: i=1; a=rsa-sha256; t=1526112238; cv=none;
        d=google.com; s=arc-20160816;
        b=KywbUVDLI08H2RtGJSSVC4h4N9mLn+3gG33jfJYJfrxfApkw7dB0GO6LVBcDl+R9As
         X4So7VGMgPPUHTZnhpz6Lr3H5PR4v0IW2B0G/tzuBo8bN9Y3duxiYCTyN9UYdr8dJ4jA
         UW1lDPiisi8AYcxgp/8Czo6e3Qwq2Ck+z2/b2fRuNkNYGfP1ppAX9Vm4EvWwV5/I02QS
         2PMh5UeJTX675Ux7bkyc4hT59pWPa33//ZDZ032fQyvZ6sK7btqZNmRxX49Lsr8XWmlo
         FmatXvJPJhN75j2yEX4RSIK9tfB5zUXwfboUc4//9f+tb5pJ9ZTK6BRbWue5sPpd8sNt
         sZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=vwF/Gdolb7M4HLIgt97Q/U7Oh0xH2lqXlxShRan1Kao=;
        b=xkNp6AgKuiCV4ADFnbflj7K3/JlisqVGNJpBU87fM4FPNMjMqbj7hhmXmgN6d9zQrh
         lSknbYzgwkLsMrv8IW7tev6uAriecGObSLD8LCBQ9iNgqRPhrYzCewOz5tIbl2mT7sCP
         nNY95h/UqaGxe2mceccMxf+Ad/qUr7wd11CL2Crx9EHgG0R/btTo91bNo07Gdi2A0hqb
         hKEmAZNBW8ZnOviLchjQAiextuk3e26MJ72EdmcooBTpJwNJnZHEk8gbUnMIKRniFNKN
         SsYUrM5CYAAWpZND/RNZyEQIUyR8ZP89TZaEfYKXrj0ne+OR94nGS9fLxRVbiDBvCAGt
         QhGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=gC+w0cfd;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=EpVi1YAE;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=gC+w0cfd;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=EpVi1YAE;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FF09602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Andres Rodriguez <andresx7@gmail.com>,  linux-kernel@vger.kernel.org,  gregkh@linuxfoundation.org,  alexdeucher@gmail.com,  christian.koenig@amd.com,  arend.vanspriel@broadcom.com,  linux-wireless@vger.kernel.org,  ath10k@lists.infradead.org,  hdegoede@redhat.com,  Kees Cook <keescook@chromium.org>,  Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/9] firmware: print firmware name on fallback path
References: <20180423201205.20533-1-andresx7@gmail.com>
	<20180423201205.20533-7-andresx7@gmail.com>
	<20180503234235.GX27853@wotan.suse.de>
Date: Sat, 12 May 2018 11:03:52 +0300
In-Reply-To: <20180503234235.GX27853@wotan.suse.de> (Luis R. Rodriguez's
	message of "Thu, 3 May 2018 23:42:35 +0000")
Message-ID: <8736yxb8rb.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569151610038779?=
X-GMAIL-MSGID: =?utf-8?q?1600244666968903401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

(sorry for the delay, this got buried in my inbox)

"Luis R. Rodriguez" <mcgrof@kernel.org> writes:

> On Mon, Apr 23, 2018 at 04:12:02PM -0400, Andres Rodriguez wrote:
>> Previously, one could assume the firmware name from the preceding
>> message: "Direct firmware load for {name} failed with error %d".
>> 
>> However, with the new firmware_request_nowarn() entrypoint, the message
>> outlined above will not always be printed.
>
> I though the whole point was to not print an error message. What if
> we want later to disable this error message? This would prove a bit
> pointless.
>
> Let's discuss the exact semantics desired here. Why would only the
> fallback be desirable here?
>
> Andres, Kalle?

So from ath10k point of view we do not want to have any messages printed
when calling firmware_request_nowarn(). The warnings get users really
confused when ath10k is checking if an optional firmware file is
available or not.

-- 
Kalle Valo
