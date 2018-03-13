Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AG47ELvWsjcuafJNc2WuCX+y7k/nywKE3dhUhQ3GQDtaZBM0/LYNSrVTuogguCkHfJ0DL2nOpl1b
ARC-Seal: i=1; a=rsa-sha256; t=1520946646; cv=none;
        d=google.com; s=arc-20160816;
        b=Dy29fFi5ScyJnG3T8+0ewBcLRWfLYD8nyPJfBd77kCOU3Wn/mP3gjaiNMyJNBQ/S6Q
         ddcrwOLofx7ZMs6WWDKvKaV9IkiicAyrPsAT0bBYDuB1xk8/hpVJOIZ0t9ac0et43WZq
         wE8Jy/yt5IfJbaEumkWK9b0Yywa/xOMs/t7As77mbAJhvoYDFhRHUNZnk0M26hD7PigJ
         Z5kzjeYgPET8IZAomaGaOg0hCxUCbX9elkLE8EgSwRoTAVaUNaITAoEPZczvXvjpYvbC
         oIS3Uf5FCqiNYkLIsHT+pz3rvbKQf3RoX7om9SrMk5IU4LJi6fBIODzKBNNluAGHcHdJ
         uAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ZYlelQKHyyH3KvBYBuh/ci8xdTxp3I5Ca+zQcRM0jyw=;
        b=hgXWECz15qrIYbO44G0RLhvpf70xDNEOu51PaBeSqiSarfPTUex2ciqDlZuYXiiBWC
         FonxhaFvuo5m2o5U6xpx7cmoFCj3zH1ppFKqG5gZnvq9hffZtSo3rNY4l59NuwpIdoXJ
         fSwC97pb/FIy4KneBcAOuVg3jVxCw6p1jV5caDoFFOE0BqhcP6ykbkDGeolgaGDOx211
         UKIyZuExtUAKOqegh5ZLGJ3nJCVqxtITdL1vbi/WV3erdKGX7qmmJrhPgdxouSbk+xrs
         6xLkQxHNWf9p8/mQEG2RmvEQN9gnKfKK/YzsYz9dJQoS4l2ov8XRF2YOk4/lpyOryd1e
         CQkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G3PPaJSD;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=fYO8zmI5;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G3PPaJSD;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=fYO8zmI5;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8B3260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,  linux-wireless@vger.kernel.org,  linux-bluetooth@vger.kernel.org,  linux-kernel@vger.kernel.org,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [2/3] mwifiex: support sysfs initiated device coredump
References: <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
	<20180312094115.2E1C1606DB@smtp.codeaurora.org>
	<5AA67616.2000602@broadcom.com>
Date: Tue, 13 Mar 2018 15:10:39 +0200
In-Reply-To: <5AA67616.2000602@broadcom.com> (Arend van Spriel's message of
	"Mon, 12 Mar 2018 13:44:06 +0100")
Message-ID: <87efkoazow.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398864870404?=
X-GMAIL-MSGID: =?utf-8?q?1594828150391607782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 3/12/2018 10:41 AM, Kalle Valo wrote:
>> Arend Van Spriel <arend.vanspriel@broadcom.com> wrote:
>>
>>> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
>>> it is possible to initiate a device coredump from user-space. This
>>> patch adds support for it adding the .coredump() driver callback.
>>> As there is no longer a need to initiate it through debugfs remove
>>> that code.
>>>
>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>
>> Based on the discussion I assume this is ok to take to w-d-next. If that's not
>> the case, please let me know ASAP.
>
> It is up to the mwifiex maintainers to decide, I guess. The ABI
> documentation need to be revised and change the callback to void
> return type. I am not sure what the best approach is. 1) apply this
> and fix return type later, or 2) fix return type and resubmit this.
> What is your opinion?

I guess the callback change will go through Greg's tree? Then I suspect
it's easier that you submit the callback change to Greg first and wait
for it to trickle down to wireless-drivers-next (after the next merge
window) and then I can apply the driver patches. Otherwise there might
be a conflict between my and Greg's tree.

-- 
Kalle Valo
