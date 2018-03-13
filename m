Return-Path: <marcel@holtmann.org>
X-Google-Smtp-Source: AG47ELtm7XhkhhRqPhWB5d5ZPY0W9faz1ycZCvajNll5U2goFvcv0jTXxpL9ovSI1iUlwKrhqFxi
ARC-Seal: i=1; a=rsa-sha256; t=1520972359; cv=none;
        d=google.com; s=arc-20160816;
        b=JCfUdKA7oh/p5X/QBzFdz0ro9fhD3//pMECgUlUlBBzgoRflFCdAybkUPA9xhYADsW
         47OQDqOShXLxv1bDRRcdzKiIaWo5sackpWw0NAREShxJ32GWVnhctmW3+H6O4Nt9MWn/
         qicwKkpj3h4lw0EF1SGdR0zEVZsj0vDQ1VqBogdY8JUNa7uDhLP214QHwcnnIapR1vuJ
         GDHPTgG1spr8FUW/r0k+ClBoGSXVhsbH5395rC64ZiozzQ3huoj05zV9CWrI+Nw4OU00
         p0HVyUlm2WrdEjnlxg6eXZYTcTq4e4I3vTI13vIlnBbnRft2DFVq1f5XDXTm5OWLOWI2
         KWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:arc-authentication-results;
        bh=YX77+4qdcVLIVBXVl50A5N7gGQH0S1EfXJ+2cWKvjmw=;
        b=VK6m3z7Zkf6Vubma6Mjaa1bvll8FrllCa69ZYpdlT2P7fMQPsXGOJqdUAGMjxQykSA
         9DpXCOakoZFQimjvSsOLNSLqsjEoK0+mllQKImoyI0jYnbhXd5iMR8I3CUSWFKwkIl9c
         8+4u1rdFkZ9SOMYsc0CWPXR1B5J+G4FzapFZ4ptfcvHMmEZXwFgWNL/rMZ3F673YSfao
         LDue9QtcFUjNGN9Aq6BmGIs2bgIpnJnLbDGqrSCztvTz+Uv66qO1wD4J+6Equ9AhONwb
         EElRFqi+d0jVH6JV/ebXc8mvfUWI4nqhyOpzq9M0+fFiYPIFwsOP31FpqUB0HvLYyFFK
         A5wQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marcel@holtmann.org designates 212.227.132.17 as permitted sender) smtp.mailfrom=marcel@holtmann.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marcel@holtmann.org designates 212.227.132.17 as permitted sender) smtp.mailfrom=marcel@holtmann.org
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [2/3] mwifiex: support sysfs initiated device coredump
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5AA829A1.1090209@broadcom.com>
Date: Tue, 13 Mar 2018 21:19:18 +0100
Cc: Kalle Valo <kvalo@codeaurora.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <24B25258-E680-490C-B7FF-D34CEBBA8566@holtmann.org>
References: <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
 <20180312094115.2E1C1606DB@smtp.codeaurora.org>
 <5AA67616.2000602@broadcom.com> <87efkoazow.fsf@kamboji.qca.qualcomm.com>
 <5AA829A1.1090209@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398864870404?=
X-GMAIL-MSGID: =?utf-8?q?1594855112878060126?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arend,

>>>>> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver =
ops")
>>>>> it is possible to initiate a device coredump from user-space. This
>>>>> patch adds support for it adding the .coredump() driver callback.
>>>>> As there is no longer a need to initiate it through debugfs remove
>>>>> that code.
>>>>>=20
>>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>=20
>>>> Based on the discussion I assume this is ok to take to w-d-next. If =
that's not
>>>> the case, please let me know ASAP.
>>>=20
>>> It is up to the mwifiex maintainers to decide, I guess. The ABI
>>> documentation need to be revised and change the callback to void
>>> return type. I am not sure what the best approach is. 1) apply this
>>> and fix return type later, or 2) fix return type and resubmit this.
>>> What is your opinion?
>>=20
>> I guess the callback change will go through Greg's tree? Then I =
suspect
>> it's easier that you submit the callback change to Greg first and =
wait
>> for it to trickle down to wireless-drivers-next (after the next merge
>> window) and then I can apply the driver patches. Otherwise there =
might
>> be a conflict between my and Greg's tree.
>=20
> That was my assessment, but unfortunately Marcel already applied the =
btmrvl patch before I could reply. So how do I move from here? Option 1) =
revert brmrvl and fix callback return type, or 2) apply mwifiex patch =
and fix callback return type later for both drivers.

I can take the patch back out of bluetooth-next if needed. It is your =
call.

Regards

Marcel
