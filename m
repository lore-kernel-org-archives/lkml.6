Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1163969-1520620564-2-12217598546428938197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520620563; b=n8lmRcgkMF0vz/SmxV+oBDN8CQGLBTKhOw6zmhu/TrO66EH
    laG3jgXgA5n+R22ZKZ02MFbW6l8+MzonFss5+4eaD8zMpz1XEZ0UuoREo2bwjJMr
    Xn8YsZ4q6jZMwb6hNFzCOcH1AE+Qdeo/wXQtqFNyEyztBbF4vcIg58pIyI6eOIHs
    dnjl9llV1UZyAFYKHknMb/LXKQKELW+LFIQH6Wijq1kij5ti2aehoBxIz+TrJ4as
    vBe4vNE2j2mZ6ypPd5y+ToO6KdnIlx4GKfL8W2DCfvZkXzYrP83zFt4VvthcZx4c
    xzj4scZwIFOcv1qE+vlX0ODWS6bB5NPfNpRLvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520620563; bh=H
    SfIRUojGymEa8atEUm8gA5VPVvbhmE53Qozla7lYbY=; b=j2oJ8AipBqDiAj3kw
    /U2HHbIWlukSD78QyDylQb9OU1vUC/YGcSTaZ3Y34rCMD2Jf9CM2ak7ip6nTBQVz
    bN80aXfIylUKRXOLErQkXGSdf7Fgcvsp/j9pKlYRF+v3sCVa4/Hb8iUbxLRrg/ye
    4H3Vs6a193hx+IXmvW7Y/svniBS/25MopuUPxuYL/isxNwC+n39YqCJBaomd89xg
    EI9Io2LGepoLdgDRc3R9iHlCE9IpUVS/yW648mm15nmzXq8s7UydySbZuqAOIWvD
    drewTM2YBCLYDKHtTkouRRQN/5nYp8yURVqjLa9SdJpzQKJDWdKzd8+BUuINa08U
    GQfWQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=RUUpQAuU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=eOr/BTPe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KtUlh5gO;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=RUUpQAuU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=eOr/BTPe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KtUlh5gO;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELty7w2+9tZSTd2d1NV/6Kd3hRz5NwK0nQkLA2ZZQ5+ew87YR8o/2fuYPW4C16zdazbs8SYzbL35JO5RW6Z8sIg=
MIME-Version: 1.0
In-Reply-To: <877eqli0f0.fsf@anholt.net>
References: <1520576470-20628-1-git-send-email-me@tobin.cc>
 <877eqli0f0.fsf@anholt.net>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Mar 2018 10:35:55 -0800
X-Google-Sender-Auth: h-2KywPAGS78sMwNfC77SNEyK28
Message-ID: <CAGXu5j+k6SkGP19EYxOAvwy+uzvkJ664_Lj_Rz5t8a6Fi60+JQ@mail.gmail.com>
Subject: Re: [PATCH] staging: vchiq_arm: Clear VLA warning
To: Eric Anholt <eric@anholt.net>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Tycho Andersen <tycho@tycho.ws>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 driverdev-devel@linuxdriverproject.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 10:11 AM, Eric Anholt <eric@anholt.net> wrote:
> "Tobin C. Harding" <me@tobin.cc> writes:
>
>> The kernel would like to have all stack VLA usage removed[1].  The
>> array here is fixed (declared with a const variable) but it appears
>> like VLA to the compiler.  We can use a pre-processor define to quiet
>> the compiler.
>>
>> [1]: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Tobin C. Harding <me@tobin.cc>
>> ---
>>
>> The name of this constant may need changing, there is already a
>> pre-processor constant VCHIQ_MAX_SERVICES
>
> Maybe just use ARRAY_SIZE(local_max_services) and not have the #define?

I think you mean ARRAY_SIZE(service_data) ? In that case, yeah, it
seems like a raw "64" for the array size can be used instead.

-Kees

-- 
Kees Cook
Pixel Security
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
