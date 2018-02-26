Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3069381-1519657715-2-11909510439360848493
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519657715; b=laMvfrt61d9OMY4eWafqrDxxPVV5camD2cok+7HrfyI37q2
    GiBWPpJ9jvjaAVzXevK7ZlGg9GvUiCZHatX2IzGf9V5wpfYuyZ2Z3fZSKo9G7XDe
    02ZP6djfUM4YRm/jBGTe4Ieq1j7pg8SEFV5LAZpLNMRhf/3BjJGh6Qk0RcE5BtV1
    o2INf736HKwjzTgHMGrgFGyrUTi3yPI2reFQIwmc7TjhIMbLqjqYOMrwDo8z3bUg
    BpjFy5jwo16iIqqGId6v78FTC2O2eZfW+pFO08DSOh3ZgHmZs6h0iC7gyOb6USqn
    sOcjTK18CmV1RNAKUcMpqtGeAI0euP7rnjfN0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519657715; bh=daAvBCIKtA9She0Zy78ps9kKeT3OKwiJL2uQB8kDtz0=; b=L
    WGd/RxKBcGwxuGl13Jnr+FB+pp51sDXd2aB+/PJUuqWxe5DfsBmIAZcicYD5jvsl
    u1ORNdgz+UeCmtm3GkPBjZF5PZ5A0zi9r+n9JosG95CD6tpF8idg1CcbMxH2phtX
    MHclhw8sxs7ok2KyvRSa/wX+ohvOdi++oewahjdReB4QQnUtfkN/h7pI5TgO97BD
    l32WndGYgAJFhnR2M9DIkpeVZjDeaUCi1o6BCVrXbuZnFSbtNwnRBG+oOCrnFbTp
    dexTcd2zDfRigKd4xjprnB9fRjFGEeKInFAOMm5Cqpj7ICGzTC88/zF5TdecHJy+
    ISdwwenC/wQPcj5Et1JIw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754083AbeBZPHm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 10:07:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60936 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754122AbeBZPHk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Feb 2018 10:07:40 -0500
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <p.zabel@pengutronix.de>, <heiko@sntech.de>,
        <ed.blake@sondrel.com>, <jhogan@kernel.org>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519381801.10722.103.camel@linux.intel.com>
 <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
 <1519407117.10722.124.camel@linux.intel.com>
 <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
 <1519638828.10722.153.camel@linux.intel.com>
 <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
 <1519644517.10722.179.camel@linux.intel.com>
 <b5904a5a-66d8-4385-cc5b-a52529e9d28f@huawei.com>
 <1519647669.10722.184.camel@linux.intel.com>
 <1519648063.10722.185.camel@linux.intel.com>
 <22270a6a-44fb-d2ad-d6d3-3d301bdde26e@huawei.com>
 <1519657365.10722.187.camel@linux.intel.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <98039a90-cbf2-6d76-bdb5-56c8e83f6470@huawei.com>
Date: Mon, 26 Feb 2018 15:07:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1519657365.10722.187.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26/02/2018 15:02, Andy Shevchenko wrote:
> On Mon, 2018-02-26 at 13:15 +0000, John Garry wrote:
>> On 26/02/2018 12:27, Andy Shevchenko wrote:
>>> On Mon, 2018-02-26 at 14:21 +0200, Andy Shevchenko wrote:
>>>> On Mon, 2018-02-26 at 11:56 +0000, John Garry wrote:
>>>
>>>
>>>>>    Device (LPC0.CON0) {
>>>>>      Name (_HID, "HISI1031")
>>>>>      // Name (_CID, "PNP0501") // cannot support PNP
>>>
>>>
>>> One more question. What is the problem with this CID? Do you have a
>>> race
>>> condition in enumeration?
>>>
>>
>> Hi Andy,
>>
>> Not sure if race condition exactly. I tried enabling this CID and a
>> pnp
>> device is created in pnpacpi_add_device_handler(), while we have
>> already
>> marked the corresponding acpi_device to skip enumeration in ACPI scan
>> handler (by flagging it as a serial bus slave).
>
> Is that code already in upstream?

No, not yet.

>
> If no, please, Cc next version to me and possible Mika.

Of course. I should be sending it later today.

>
All the best,
John

