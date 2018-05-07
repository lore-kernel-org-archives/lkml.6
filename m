Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AB8JxZor3TBBXuX6X5JQNskB4tNtkqo4zmpm4R1nDczmbbx/b3KyoxlJWSmMn9q2l6I2JWleKH14
ARC-Seal: i=1; a=rsa-sha256; t=1525689403; cv=none;
        d=google.com; s=arc-20160816;
        b=F9pb/MopP45XN8ZU6KKvnpn5hXNiFUiMovJ4LNlIGXb9g/YktYhtWs4u0gcDmJo3sc
         N70kcQUqgOcGSHg8GxOUaYaMbcyuS9wjvc7k9W64/RHuXyX4uTDmH0y44rhBkO6tFxfh
         q/KtlFuCVVvRfC/rT8mPEhMuLeqhGp8xzFSwLOZQPh4HbvXuGCzVlaupCGr9cCTpK2Qg
         9jCbeZvkabakjwtEgbKF/KcU97tUF5k4xuX3BN3fddfKGqGPMYkE0CZ4NdzgkWzY9E8W
         Xq/PzuiB9aYc/DOer2XpeOqO9+ydy0yY243DBEk5Hzw6q2Y+osVxok8m2gNCMqxZJe44
         K+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=0YbNBzefztt5GIGJNkbezKI+SqxuLT6qDbL22ppqFV8=;
        b=LMHF5RS1K4VP8v/6ecMB8AOeMe4b2bFMY6hZ58Syv6o+BzrT+Q1XPVVV0IvDGV4O3J
         sFXwJ77VH0ogL9M3BtDYlmglOoUjqJPBD2FlM4KYw61QPFrWhgeXhCyvlVv/twTpFqPy
         JqUKPtiqFi0yFenxQdIuIa+zkra46AClF9x8AETD7ZhSLvgCsURBAtrCqzk8RfYuEImx
         CzMc3+kmA6LO7+4pdpJYy/O0c08u+Tpo0zc1IJB9eOAGEGcNMUwQtfCq1dLjbamNh8/Z
         K0dS9RrPfvE/T+5bmCrWCyl5wanfagB8UrLG5Roq9rHLWW/M592zmarod1doKxEQwDrk
         XEaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/15] powerpc/powernv: opal-kmsg use flush fallback from console code
In-Reply-To: <20180504153717.4806d9c4@roar.ozlabs.ibm.com>
References: <20180430145558.4308-1-npiggin@gmail.com> <20180430145558.4308-5-npiggin@gmail.com> <87muxg80ga.fsf@concordia.ellerman.id.au> <20180504153717.4806d9c4@roar.ozlabs.ibm.com>
Date: Mon, 07 May 2018 20:36:39 +1000
Message-ID: <87wowfbvm0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183451122520462?=
X-GMAIL-MSGID: =?utf-8?q?1599801292219852207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Fri, 04 May 2018 15:16:37 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> > Use the more refined and tested event polling loop from opal_put_chars
>> > as the fallback console flush in the opal-kmsg path. This loop is used
>> > by the console driver today, whereas the opal-kmsg fallback is not
>> > likely to have been used for years.
>> >
>> > Use WARN_ONCE rather than a printk when the fallback is invoked to
>> > prepare for moving the console flush into a common function.  
>> 
>> Do we want to add a WARN in that path? If we're panicking things might
>> get worse if we WARN (which takes a trap).
>
> True, probably a good idea not to... oh there's a printk_once so
> that'll work nicely.

Cool.

I have this series in a tree so you can send me an incremental diff if
it's reasonably small.

cheers
