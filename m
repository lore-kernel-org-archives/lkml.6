Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2472440-1528201196-2-2371441264445235575
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528201196; b=CsvLHTGkgWMqt4ZpFKuY/eF2dAIJzQ7Y0vdpn/mSlh7EWi787T
    4wRAXMwWKiwBoSuKmUn/tFDbASm++E54+aM1Wc6J6sIjOw3r4IF0ayn8JI4ASqkv
    Rtj1K+u70P2+VY4eYq5WqdC+ADHoKv58MN1DBdt2z2ljRZBlt0SgmjEyGpLn/5q9
    JFi98y5Lj2EmcwLhGsHSg25HgNlHblQgcEeiI6NVrdfw/w1BTP7vYW6IF6s11nWp
    UQkv4eqCgadegcuXgCCQCkCEdalxLG1N1MHDtEqHzzVfODfo8pzml5mJSF5Xmr96
    VpkZyUF/1inalRzxQtcf+nzurqTwiHBlZdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528201196; bh=34M6/nD1L0fjZQWAGJdhAdCXAWtpA/zQpbWG4DWKAI
    g=; b=kVLpPistQ6xx8JtKbtMpyxtRycIpunFxR1CHynHLhHBoY50e4SvTLkM2bL
    IeCy5188izKzIbqNi/cLuCROmN8dalYoEMfEFzRtdtbs/v7YjAce6HwR3rFsBQdf
    srm2GypGJJ2EzJaM12WBU8l8Ct5dWNzLnY0GVr/h1RpL3l8pgG+tsTCT/O94/4wH
    xtPmyC8Dsp5i2TdmKVL6bJzlbpNOGz5DrvASunxGeGq9khYa1IZiwgkThVIr1oYF
    hCrsSm7NiUrZCsFLEy4lodZrU2Y0pGvlRIVVo5H//B0QMsb0u1gP3ZrmH8qCRsDH
    j33+e2h8tbdu4QdlsXL/HnPC/79w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=Wy+9zhZQ
    header.a=rsa-sha256 header.s=google x-bits=1024;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=qR3Guw/b
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=pYfMneD8;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=Wy+9zhZQ
      header.a=rsa-sha256 header.s=google x-bits=1024;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=qR3Guw/b
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=pYfMneD8;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBsPbq8eNOZA9z+03XsiFyO1JtAwn4iC18Ejuk7VBOIX2cXt7f3YIxzZqDAFv2NrYoHOj9rQWne/lZ+blPNNLg38t6eOi1mHwfQd0AwKoEKefOtHhg0D
    NpjAzIMAd1OXmiTi21P+MbniTObf29J7N/ah7v5koG2yQNtTVkZwwKHec075APmfWQAxPiKdC9KoWiiF+M3r9twY30+MfoJwcpVTfzacmUpYhun5x6jDc5CQ
    r+9ZlWRRIT1JYgHnxxoVcg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=hBqU3vQJAAAA:8 a=VwQbUJbxAAAA:8 a=0RnF_acHxUvAWn-2C24A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=WLjMIN4s_96MqnBbPenP:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeFEMTy (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 08:19:54 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40286 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeFEMTw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Jun 2018 08:19:52 -0400
X-Google-Smtp-Source: ADUXVKJSET2w5E/xf1bzOvvuwknc8OrtCN3RY60bdORjoIOB769rxFqBJlRpX0h8Vh1XaYitA58Nio+B/t9vQfCH9Fs=
MIME-Version: 1.0
In-Reply-To: <20180605040920.GA19747@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1528121025.3237.116.camel@linux.vnet.ibm.com> <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
 <20180605040920.GA19747@mail.hallyn.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 05:19:50 -0700
X-Google-Sender-Auth: Fjmatf4jpBswGjytWVV6kU8PkGY
Message-ID: <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.l.morris@oracle.com>,
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
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Personally I agree with Eric and prefer a new hook.  I don't feel strongly
> enough about it to keep bikeshedding, but since this set already exists,
> it seems like the way to go.

And the new hook is "load stuff without a file descriptor"?

-Kees

-- 
Kees Cook
Pixel Security
