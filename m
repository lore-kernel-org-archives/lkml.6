Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4190698-1525433175-2-751672244456284801
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525433175; b=b2c5BK/FmiuKZff48Xold0DS4EL+Yp6Nlrbca368AQcY/JfV3Z
    KUGhUrmC2jHXgMd/7FAVXHNBqOOKaW6CjUlkm2s6CldSuJyYOdLJncdi4h+b/Tz5
    Xfo6bOxPK0on3h8C+GnH9GzVXbDMoupVs92Dq6bFSdaDkMoWWaX55TJVECGhC1Nc
    tiY6OQV57t+kBG6Fk9hPFhslTXgpI03QvNQTPvylHLV8Fp6dWH/WbPxluiNPrMm7
    KOXAGxyljByA5NlqO0xH4nD1ObNXX6HjDWMLfd7hiBYtckaFxGfhdnkQWLUOdzK4
    LUcxyB3lX35SyAHbXr/1bevMLvS4ecvJuQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525433175; bh=ar6T/02Iz+lpUX2GXhl+Tm03+UvXaBcFgl8RnvG0/i
    Y=; b=GF/hpS01AcYg0MbDwx87zNdP+3OsKClxuYwE8bIJVG0rDZBXSoQLSNLmpu
    8PXgjdudtjMxOfHNtLaPQo3za4zi5Xt03ziqhCaBXexhxxsUyMt+UsOZWfkEVVrB
    aH7a12/q4Xbovpcq+fszoKhRes9VXuiFnqGQ++12Q4qb1bfGfZHs9851bUFyF2HQ
    n2VWluQjM8lbUw1ghsQtQnt5/rVceiYx7VzSuSFP/Vvy6YDcXGkNEpOMCxQIVU07
    GAUaIbyI3lI0//z+WYRp7ED3qsDZOXcpwpr2ufsuhW0Nw7AwZDW1kyArzMhiG3fe
    VQTUN/QOuqjAGBNp7xobSOZlmM5Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=FbNX7xYA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=FbNX7xYA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMiY2G4cJaWV0hi8E515mEwYrtC7WCRFXGxWhZE79AmgkX3S8Bq/p/8RIjEn+qcwimcu+CW/gVx/udiH8yRdy0NDPAgov294sq9v03atLjs7ZRq59NPy
    ru2lNDk28JX/mMZEp9gs5RN9ox+VCjRj9XexJcbtGm8LZxxpuqjdOZZDFQ2kHVMKizyqSbw8PaZUhfnCNfUb6HF+uxSFQasmkfRa3GUaMs7VjLYVOGLDbcUg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=eh1Yez-EAAAA:8 a=20KFwNOVAAAA:8 a=s5uD4gFR6s9gwarx3VQA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeEDL0M (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 07:26:12 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:50872 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeEDL0L (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 May 2018 07:26:11 -0400
X-Google-Smtp-Source: AB8JxZpratGriWKyevYYuMPh4LCPOiL6I0IzuxapOfUu+cGZwNSCObCH/HFBthZjAgs8nVIN6nBnfACbuKRCEKHGPWk=
MIME-Version: 1.0
In-Reply-To: <162DEB66-373B-4E01-8D64-3CE7BEF47920@vmware.com>
References: <20180419063856.GA7643@kroah.com> <20180419181722.12273-1-namit@vmware.com>
 <162DEB66-373B-4E01-8D64-3CE7BEF47920@vmware.com>
From: Oleksandr Natalenko <oleksandr@redhat.com>
Date: Fri, 4 May 2018 13:26:10 +0200
Message-ID: <CAHcwAbR-q27VDhWcwXZOXkazheerVZ1KzkvnUvruQV0qHUN2FQ@mail.gmail.com>
Subject: Re: [PATCH v3] vmw_balloon: fixing double free when batching mode is off
To: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        pv-drivers <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gil Kupfer <gilkup@gmail.com>,
        "ldu@redhat.com" <ldu@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi.

On Mon, Apr 30, 2018 at 7:30 PM, Nadav Amit <namit@vmware.com> wrote:
> Ping. Please consider it for inclusion for rc4.

FWIW, we've got a positive feedback on the kernel built with this patch, so:

Tested-by: Oleksandr Natalenko <oleksandr@redhat.com>

Thanks.

-- 
Best regards,
  Oleksandr Natalenko (post-factum)
  Senior Software Maintenance Engineer
