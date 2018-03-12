Return-Path: <arend.vanspriel@broadcom.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520858646; cv=none;
        d=google.com; s=arc-20160816;
        b=v0qzohD/Uq68PJZMMmsXSw1ApLgGbnannZphvSBAhO9bMAkXGBnYI3bB56uwOn+WhV
         F+PeSG7Cmhm3QbU3tDJ/bUflRm8yXaaneOBgSNSiYwflC6gP0nuH5tUVG/mZxHPhiCPO
         nnaOi2+XQ0k82iru5B/riV8wgfspEWLTtPsf2+vNiEljJHTHzt4lillYiKQ9+ILyjjRR
         l/yQn+m0gu4OxTD4orXDZJ+rf6x3WAFuX2IfBfoANZm5QIhJ3uBj6OouxYAShrComFHU
         Nzu9tP6wo9QD8vXioqt/sJuHNLgZl/5csQqq6Pn7Ez0v95Ujo+IyJAzgnPOMXg+bpJbC
         PYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=L9cUA+L8P0ffOxZyCYJpZV90evMbVNjVRkDI+UVTt3I=;
        b=NLJNtR2aR/TwGxlWO4dv7+3ZzWC4BrJ0VRpzO7UacwGwtGPJqlo5FAjL4oxdFWMVkR
         HveInKsEEeNAr7a1e0i04sNj3K2w+57T576w6ibVWpq9qREPLXySFdNuOXeaZEROP9ao
         3xiC6ufITVSQBDBlmNiFtwn/nKAPuEsVyvauzsaNS7pFF0soS24dgK7vhI9X8zSwC1Rn
         Pr0Sy2kO/TvGh8IaheTqjZUr8ZPBNfix/h5qply/OIyLzwKWE6rEclrdC1CwftO2FygM
         4RbH7pg1H+iNXvH40vNO0KOzIGSY4X5hmqPlGM3ce1EP7/hpZLeYIbio39mS0T/E7ka7
         Ejww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=W+w4kav9;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=W+w4kav9;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
X-Google-Smtp-Source: AG47ELtpEuVr1U/chY+WcnXD06weqeHnhZvRn1qjJ7bhbYkG+KXZHOAo4F6axhwFwTr80L43UbMGOg==
Subject: Re: [2/3] mwifiex: support sysfs initiated device coredump
To: Kalle Valo <kvalo@codeaurora.org>
References: <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
 <20180312094115.2E1C1606DB@smtp.codeaurora.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wireless@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA67616.2000602@broadcom.com>
Date: Mon, 12 Mar 2018 13:44:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180312094115.2E1C1606DB@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398864870404?=
X-GMAIL-MSGID: =?utf-8?q?1594735876332383815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/12/2018 10:41 AM, Kalle Valo wrote:
> Arend Van Spriel <arend.vanspriel@broadcom.com> wrote:
>
>> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
>> it is possible to initiate a device coredump from user-space. This
>> patch adds support for it adding the .coredump() driver callback.
>> As there is no longer a need to initiate it through debugfs remove
>> that code.
>>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>
> Based on the discussion I assume this is ok to take to w-d-next. If that's not
> the case, please let me know ASAP.

It is up to the mwifiex maintainers to decide, I guess. The ABI 
documentation need to be revised and change the callback to void return 
type. I am not sure what the best approach is. 1) apply this and fix 
return type later, or 2) fix return type and resubmit this. What is your 
opinion?

Regards,
Arend
