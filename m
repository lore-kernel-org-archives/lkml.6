Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3227126-1525386994-2-13563029643202203445
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525386993; b=UseTultpVzakYNC1gU7ygUCf9n65kTKq/AqqIdpUkJdI7frciM
    VD8vLIAG4s07sgrZWMC/fcWKtLon2gMtaDaawZFummNMLKTKjr+ysbh4jBZHitvV
    Co82apy4HDVIGxP5effCFqQAlvXbmEi/7pcngqGOSAABJmi/Me50bC8yz8FuTeWy
    nJ23j+S9Ad5vWUNCzcj2U78bSVv0wIvSPzXlo7d0ZIn5evxkCInWozxos+Xfq7br
    /XF6a6kVxwUQ9Sfpx8i8/HZrF6wwltWD6sIfKzgxrJKfPTbXo3Q0qSWyoZB0Jt2N
    uRVO5yCPyAWdXs2ry9GXZoOjLx+QxyyhslFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    fm2; t=1525386993; bh=DX3LXcDK/Jsj4UBJDBn4DYCbHB9PbOH1N1yP1NwWBo
    0=; b=Hwadaycd9I5J6UReWNYOSpfyFPWj49ah2IIh8BUSo1BE2A7E/9li54LwYN
    4Qu18OIEEgBmI0MvwzxXIhlnm6L9+4xx7LV/JHQyAO6vUa/WJFdinO56aiZ1KVO+
    dDQNHwukbhFOkixLCCCx6MgO8hVjn5BMgdBuwUj1NJYKLY6vG4ef+yaGCjxF7IQY
    aYmEDMNsoD9Qs2/JOE8Ydlqvnz4wsfoe+kx8fZoEpwOq1660eySJl/SjFGXOwpaU
    dnN7esspxZ8iAwBbmJqmq8NakMEPrUreqDEHet8VnbhrfZrPxXuKmAXP5OKA5xco
    Ma08R9mN+Eo1v2+wYftavSDdnWhg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMeHGSTY3E8G1XBSd3p1898pnhNxz3nRJmj6CmeGSjXp9uRPM/YMI3h6l2Iko1FXmlpBRAtljywYD5I/Hpkq3BBsdYXP4Dfd1I/3atMymnwLI/tKIXJ8
    uGmvWFkGi+6FpurYl+i+RqdwA4R48cIZ78gdQNyeuamvshuXVZH/a8NxkGZ8YQPmaApSsAkcezvZ5b/p8vfdFDq3xJvv+mHEnNlKJ7gq6NZyO+c7zUp487U5
    Oo/TWeqewBOXsKHi4T/LJg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=13zjGPudsaEWiJwPRgMA:9
    a=20KFwNOVAAAA:8 a=GfyVyMdr-37WVbhFusYA:9 a=QEXdDO2ut3YA:10
    a=jPdnbbFCA0-t1ScOwTMA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=6nUXITN49fC6jhMlmTEA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeECWgb (ORCPT <rfc822;linux@kroah.com>);
        Thu, 3 May 2018 18:36:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50628 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbeECWg3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 May 2018 18:36:29 -0400
Subject: Re: [PATCH v2 3/4] seccomp: Audit attempts to modify the
 actions_logged sysctl
To: Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Eric Paris <eparis@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
 <CAHC9VhSq=56twBxnzZ8T=APGvtZV39FrHFVqmDMiKOK=WeWJRA@mail.gmail.com>
 <d8e1c48b-70d0-13a7-e563-755a8760b25f@canonical.com> <2397134.HQDQRr6h1X@x2>
From: Tyler Hicks <tyhicks@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tyhicks@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e23b61ec-9400-4c40-cdb1-92d224f05967@canonical.com>
Date: Thu, 3 May 2018 17:36:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2397134.HQDQRr6h1X@x2>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9kzE7y2OHYL2UW2KxreBjb6n6R9MuqpRR"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9kzE7y2OHYL2UW2KxreBjb6n6R9MuqpRR
Content-Type: multipart/mixed; boundary="Z6x5O0M52QzElqflQ6iCsyOYlIR0un3Cs";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Eric Paris <eparis@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-audit@redhat.com, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-ID: <e23b61ec-9400-4c40-cdb1-92d224f05967@canonical.com>
Subject: Re: [PATCH v2 3/4] seccomp: Audit attempts to modify the
 actions_logged sysctl
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
 <CAHC9VhSq=56twBxnzZ8T=APGvtZV39FrHFVqmDMiKOK=WeWJRA@mail.gmail.com>
 <d8e1c48b-70d0-13a7-e563-755a8760b25f@canonical.com> <2397134.HQDQRr6h1X@x2>
In-Reply-To: <2397134.HQDQRr6h1X@x2>

--Z6x5O0M52QzElqflQ6iCsyOYlIR0un3Cs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05/03/2018 04:12 PM, Steve Grubb wrote:
> On Thursday, May 3, 2018 4:51:36 PM EDT Tyler Hicks wrote:
>> On 05/03/2018 03:48 PM, Paul Moore wrote:
>>> On Thu, May 3, 2018 at 4:42 PM, Steve Grubb <sgrubb@redhat.com> wrote=
:
>>>> On Thursday, May 3, 2018 4:18:26 PM EDT Paul Moore wrote:
>>>>> On Wed, May 2, 2018 at 2:18 PM, Steve Grubb <sgrubb@redhat.com> wro=
te:
>>>>>> On Wednesday, May 2, 2018 11:53:19 AM EDT Tyler Hicks wrote:
>>>>>>> The decision to log a seccomp action will always be subject to th=
e
>>>>>>> value of the kernel.seccomp.actions_logged sysctl, even for proce=
sses
>>>>>>> that are being inspected via the audit subsystem, in an upcoming
>>>>>>> patch.
>>>>>>> Therefore, we need to emit an audit record on attempts at writing=
 to
>>>>>>> the
>>>>>>> actions_logged sysctl when auditing is enabled.
>>>>>>>
>>>>>>> This patch updates the write handler for the actions_logged sysct=
l to
>>>>>>> emit an audit record on attempts to write to the sysctl. Successf=
ul
>>>>>>> writes to the sysctl will result in a record that includes a
>>>>>>> normalized
>>>>>>> list of logged actions in the "actions" field and a "res" field e=
qual
>>>>>>> to
>>>>>>> 0. Unsuccessful writes to the sysctl will result in a record that=

>>>>>>> doesn't include the "actions" field and has a "res" field equal t=
o 1.
>>>>>>>
>>>>>>> Not all unsuccessful writes to the sysctl are audited. For exampl=
e,
>>>>>>> an
>>>>>>> audit record will not be emitted if an unprivileged process attem=
pts
>>>>>>> to
>>>>>>> open the sysctl file for reading since that access control check =
is
>>>>>>> not
>>>>>>> part of the sysctl's write handler.
>>>>>>>
>>>>>>> Below are some example audit records when writing various strings=
 to
>>>>>>> the
>>>>>>> actions_logged sysctl.
>>>>>>>
>>>>>>> Writing "not-a-real-action", when the kernel.seccomp.actions_logg=
ed
>>>>>>> sysctl previously was "kill_process kill_thread trap errno trace
>>>>>>> log",
>>>>>>>
>>>>>>> emits this audit record:
>>>>>>>  type=3DCONFIG_CHANGE msg=3Daudit(1525275273.537:130): op=3Dsecco=
mp-logging
>>>>>>>  old-actions=3Dkill_process,kill_thread,trap,errno,trace,log res=3D=
0
>>>>>>>
>>>>>>> If you then write "kill_process kill_thread errno trace log", thi=
s
>>>>>>> audit
>>>>>>>
>>>>>>> record is emitted:
>>>>>>>  type=3DCONFIG_CHANGE msg=3Daudit(1525275310.208:136): op=3Dsecco=
mp-logging
>>>>>>>  actions=3Dkill_process,kill_thread,errno,trace,log
>>>>>>>  old-actions=3Dkill_process,kill_thread,trap,errno,trace,log res=3D=
1
>>>>>>>
>>>>>>> If you then write the string "log log errno trace kill_process
>>>>>>> kill_thread", which is unordered and contains the log action twic=
e,
>>>>>>>
>>>>>>> it results in the same actions value as the previous record:
>>>>>>>  type=3DCONFIG_CHANGE msg=3Daudit(1525275325.613:142): op=3Dsecco=
mp-logging
>>>>>>>  actions=3Dkill_process,kill_thread,errno,trace,log
>>>>>>>  old-actions=3Dkill_process,kill_thread,errno,trace,log res=3D1
>>>>>>>
>>>>>>> No audit records are generated when reading the actions_logged
>>>>>>> sysctl.
>>>>>>
>>>>>> ACK for the format of the records.
>>>>>
>>>>> I just wanted to clarify the record format with you Steve ... the
>>>>> "actions" and "old-actions" fields may not be included in the recor=
d
>>>>> in cases where there is an error building the action value string, =
are
>>>>> you okay with that or would you prefer the fields to always be
>>>>> included but with a "?" for the value?
>>>>
>>>> A ? would be more in line with how other things are handled.
>>>
>>> That's what I thought.
>>>
>>> Would you mind putting together a v3 Tyler? :)
>>
>> To be clear, "?" is only to be used when the call to
>> seccomp_names_from_actions_logged() fails, right?
>=20
> Yes and that is a question mark with no quotes in the audit record.
>=20
>> If the sysctl write fails for some other reason, such as when an inval=
id
>> action name is specified, can you confirm that you still want *no*
>> "actions" field,=20
>=20
> Its best that fields do not disappear. In the case of invalid input, yo=
u can=20
> just leave the new value as ? so that nothing malicious can be injected=
 into=20
> the logs
>=20
>> the "old-actions" field to be the value prior to attempting the update=
 to
>> the sysctl, and res to be 0?
>=20
> Yes

I came up with one more question after hitting a corner case while testin=
g.

It is valid to write an empty string to the sysctl. If the sysctl was
set to "errno" and then later set to "", you'd see this with the current
revision:

 type=3DCONFIG_CHANGE msg=3Daudit(1525385824.643:173): op=3Dseccomp-loggi=
ng
 actions=3D old-actions=3Derrno res=3D1

Is that what you want or should the value of the "actions" field be
something be something like this:

 actions=3D(none)

Tyler


--Z6x5O0M52QzElqflQ6iCsyOYlIR0un3Cs--

--9kzE7y2OHYL2UW2KxreBjb6n6R9MuqpRR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPgU+cN5AsTrekT5+1pIAPaoCxwoFAlrrjuIACgkQ1pIAPaoC
xwqu0BAAwyRlqGQ5TStWh6CvMpMXQqKCq8yZysZNTnq2jjwpgNro/Hx4dYIBkHe4
C+FpRdV4w726wrp0GR9iR4UCAUeCKS6KfAMFech6fh4kdRX8mlN9txrUf4ZpiBr0
NT6IPCD0B/fRdxP9/FDwWSnIvD8TjcWD4XtW5v90NZMrUvVcfr6OugWVbzsgTdmK
w4Fvbac1FmV4g/qr616UXF6O53JPDJ1+40kRVMWYciz5wRRcbxZEru8HcE0FHaKX
xPVzUTnfi9ikoTGPIDxdKt4iabgxwv+95TIhBuGSt9Zi9sAovD5lQ/3Up6uGEOZ9
ou6wk9Sco/M8vdUM20479uV4JDaP+vL2bkeTa8LHhumFH3r0Y3Mi7WBww0MNJjXV
R2UIkzI/xmE7c8PaKVyiKsvKdjyDHmQZqJyrLhSUPpa1AEQRLyto/ynItA1wRcF8
Ul+BvNbEhhnyAUGVvcQ4NbLRSja4i+iXTzRKeKjlA1im1UH4TVTCXb2tsMtPfTZM
45gytgvY2z/+TR8z8ABWNhEdmu+eJ8pidbrXhe9iLXTBVgB1EftV5TSM1ZrWsD1j
c0GEbB0RCwLuDeCt71vgOPIisXQ4nd7heAbY25o8bLl/v7J17WQYuf5WAFmkVvvR
6SIPAcPfewR9e680zu5GWG/mWU2TPokm2GGQuw/2WyCS/5rEfQs=
=1oYl
-----END PGP SIGNATURE-----

--9kzE7y2OHYL2UW2KxreBjb6n6R9MuqpRR--
