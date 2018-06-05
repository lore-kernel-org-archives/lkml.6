Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2547981-1528206217-2-5833497635582757732
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528206217; b=GAt62gbdiksxeoaac4Cph+HdWq3dlckbySpJOB3IEbekQOAre+
    g5NDDSMs8R4r4b4TlZxD3Py+6ghPmZpGqAvb0wLUd15sO/1knWAFUd27oWpYBfr3
    34onmTiiuyUzPQ51c1XfpqdrqhUwBgY0fUqk/XchB265BMQtieJYCO7/M1Xv7LuQ
    mMGHt9JLN2YMFVd0qvUqHHl4ld87KxyNKt301BvMXbDrYAEIveMOocoRqBVnJJrW
    qrjKN6DiwE3cRY5C3RQPkciPwJJIzfu+KnyRAwAul/c3nkE/abLokj+GKRFaI/aw
    AwoXIN/lKitP7iNzJazvUtJzWtOcwUGVivnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528206217; bh=LCxc99GjoSUpfrL4YdrFxPhbfY5npxJb2DTW5zOA42
    k=; b=md5fvDzIvLysB7Vvo8Nc1ebsBqipMuQqn75kN/jH/FykWYKwk2HnSU+aed
    kn1kGs70Yp3p9X3d704PsdVBrxYUybHuXFWodea6MroEus1rrKtjOxbcu0MsC7Us
    X42CT0CXk0WL+zMItez/eq79n/muEFbsLINx0aZsLnf7CUY7Ha6NUNdU4Nn+9utm
    JJGxuceJcflUmg6EvhKlZdLXB4is9QiVdiBarfAQayCPDviZixfomvdnCGB8MVYo
    sGM95TYOfKSEU+AVa+BB2p0dAins4vMEqfMgRQ5JDN1oqPMNgUDlul0qNjSShGtE
    SjaP3XODlk69Rx96t5+6OOTB/Hkw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=VG/fb44O
    header.a=rsa-sha256 header.s=google x-bits=1024;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=YqJgecmD
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=YVurdY1p;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=VG/fb44O
      header.a=rsa-sha256 header.s=google x-bits=1024;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=YqJgecmD
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=YVurdY1p;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJzZnv7RLSyAAnE/7J13cjA5uvEBUsMDBTgLIqg/mBnJUdi8nLDOYF3XsW/WVq5RA2G4wUc7kO3uOSqqtXqbT0odCUCg0/gm4iPa/J7O8LY+ON7tP+ay
    9p7ZGfey6tTUPWRoDOlgQ3z91x5pxEj6eERiUg+tqgQbhgYB13wucca3CospmyvBQj1LUCMXvVm1qSMgYzmrfVYcgQ0ZOJcTY+4TW+61n6QBpG34HoEJCrjr
    RuaK6HQG3RePNYr9gykKwQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=hBqU3vQJAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=07KoFAoNhXjczju6ZJAA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=WLjMIN4s_96MqnBbPenP:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeFENne (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 09:43:34 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36038 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeFENnd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Jun 2018 09:43:33 -0400
X-Google-Smtp-Source: ADUXVKJHIZifIl2cxm5yESpmlH6Ra7KUuSDKrobtAw1lrf2RLDdtHH3H5IWufGU79gBKJ6TK1IKd5SehJcJe+kgIWoQ=
MIME-Version: 1.0
In-Reply-To: <20180605132542.GA26722@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1528121025.3237.116.camel@linux.vnet.ibm.com> <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
 <20180605040920.GA19747@mail.hallyn.com> <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
 <20180605132542.GA26722@mail.hallyn.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 06:43:31 -0700
X-Google-Sender-Auth: wc_1ykMrrsOQoGNFxbVmOCx_PMw
Message-ID: <CAGXu5j+vsYHBpH75i=GxVfi0HgvsAW6zgz6V-eO8ZD13ykq2mw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jessica Yu <jeyu@kernel.org>, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jun 5, 2018 at 6:25 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Quoting Kees Cook (keescook@chromium.org):
>> On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
>> > Personally I agree with Eric and prefer a new hook.  I don't feel strongly
>> > enough about it to keep bikeshedding, but since this set already exists,
>> > it seems like the way to go.
>>
>> And the new hook is "load stuff without a file descriptor"?
>
> Yes.  Load stuff based on my own credentials not those attached
> to a file.

Okay, I can live with that. :)

-- 
Kees Cook
Pixel Security
