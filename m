Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3951089-1519560834-2-9933629023066969968
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519560834; b=TNRHIchFmRidCvCadFSHtBarJpjSDTMvxE8HjzYjInicrkw
    HuFocdvP3Vaaa/U/Y1wMLFd82gqBoKvW+qcRkpWLLOcW5tUs+kzr5jiQ+juirTsY
    yCtpOBqgUTMAk25XPp9YvzCygOddXetz0UcpD4wa8LublghhJh/BCtmm3eJQfVtM
    fGyg0KxhJGgFSWnDp+GinhriY+0eBBzF6QxCIoj+/86e2BP40iqhYjFV9Hr49uzf
    NEOoth4rrBk2cxCd9QyHlevpjWRlbibKGlECMRUpLhhPeOcMHUeqUVi46lV1Bubx
    AoRXUNx+FeMpttgk67UhRkgt/UFHGA4VP195EsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519560834; bh=WRxTuQIM5ruM3nKuOcKgJscwTBkzn9Z7Co9mhAdkTMg=; b=a
    I7468QYuVHuYBhcWrl7s7zhbzr+V8CrLsepfyWTkPi+9ZB6sCVmFxY3SO13Edk8B
    wZFfkjUdVhi1Sm5WH7XUNSCcOV3fqKnMUMR5YJHkzByd9+OJnejlUbxKfX5P6oGa
    8JErv2+KTFgCXv0rlZlt6dXGxrBeb9Ipkxl2Q91RDegYZk0WY2EoydKzgZvpZwl5
    hWVQRbXs7vRdGxmzPSdmp+TbYmO9xxDMXgBYewoQ8kbBmN6xqz51XCdCnf61IV9b
    KOgWUp/S91omeqX/CreLDHgpMxWJnmw/9ylLk9DXURD9pKbBxTHg74E1aMRMjYv+
    0DMlQc59xCVv1dOSS+dJg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KV61UFly;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KV61UFly;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeBYMNn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 07:13:43 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:40646 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbeBYMNl (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 07:13:41 -0500
X-Google-Smtp-Source: AH8x2247mSsVwHmtL5sdouZ3W0qV+wKCmc0VFhBPkKXufxHPdRKbj2SOGrd1eWxD1dEF9KigWo3dug==
Subject: Re: [PATCH 03/12] usb: typec: API for controlling USB Type-C
 Multiplexers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-4-hdegoede@redhat.com>
 <CAHp75VdaK_LdsNeb5XY0kcA7sqH9G8OyjSLs7WRSftK9Zs98GQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <b2790a56-4dc8-5668-8e24-41e27e796197@redhat.com>
Date: Sun, 25 Feb 2018 13:13:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdaK_LdsNeb5XY0kcA7sqH9G8OyjSLs7WRSftK9Zs98GQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 16-02-18 15:00, Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> USB Type-C connectors consist of various muxes and switches
>> that route the pins on the connector to the right locations.
>> The USB Type-C drivers need to be able to control the muxes,
>> as they are the ones that know things like the cable plug
>> orientation, and the current mode that was negotiated with
>> the partner.
>>
>> This introduces a small API for registering and controlling
>> cable plug orientation switches, and separate small API for
>> registering and controlling pin multiplexer/demultiplexer
>> switches that are needed with Accessory/Alternate Modes.
> 
>> +       sw = __device_find_connection(dev, "typec-switch", NULL,
>> +                                     typec_switch_match);
> 
> Perhaps one line? (even if it takes ~83 characters)

I'm not a fan of breaking the 80 chars limit when we can
reasonably cleanly split a statement (such as here), so I'm
keeping this as is for v2.

Regards,

Hans
