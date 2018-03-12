Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134551-1520846397-2-6777955522437099157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
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
    t=1520846396; b=pvO281AzqhnonXWEPvcqvxmKSYk7igWubGC/EtbTj0VsBrm
    AJ13uheJEzu8UpjXTbH7UVmXXWJRIu6fUSKWF0TD7vqsAGWwFOu0lUm4a9jGw+Hu
    I2hl/W5RTOhYEaovBP4TmnpHR+EBpDL1MjUL4q6u0l90H/SWtTN1I5GQ4Hs7agbk
    gm8KW/ARzLRVlS80gvTuMzXxpOHHHKelgu/MzlcG2gaBS/GvUeDtDqp62L/XmLuJ
    QoDoKZn1n8SdvCfxze7hSSble6ou64CTyopeiqu5nv9mNjJbfZ2Bjepbckl6pERy
    4yZbsPhUSmvfow77TemF8j5NYqnREAu3gs7wuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520846396; bh=9i1SKXc4coW1Kf0tJJi1PyvUpNy4LQ3LOVBisOMX6TU=; b=v
    URDCk8+ieR1LoVyXjkn2a1IxdrH9yXXetyucbkFupwTUdx8Lq5qs0uptrg77yUhN
    Vvs43e3UTv2pNaPy6hdIfQzYxofcpHzb5es5ILFBPWLeVVniki+jtLLKXsMq+gZS
    mddW+oly67A+ku9QALMrH/KJSVp1TX+m82VPREM9fSIpRZ2J2iqnMcm4KAogUJJV
    zAi5UctnFD/iUWYondzW1lcQflwF+NiiOjhRktv++OlyTwAvAtkVHvylD07IU3Oz
    DPzdKwtLQDFge4yEusAnci0BrmuTOtm/ly90AqWlTB+72MI7/TYz4l2A6SdsarRh
    A7wMNJgY5VXi3O3P+LJ0Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y0qNZWHS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y0qNZWHS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeCLJTw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 05:19:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51390 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeCLJTh (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Mar 2018 05:19:37 -0400
X-Google-Smtp-Source: AG47ELvLwK13gahuql+OLZry3KMu2yuvCBrbpOtsiQc/3U1/JD4xid1EF86M3e0eUXsX56EB1+DqeA==
Subject: Re: [PATCH v6 01/12] drivers: base: Unified device connection lookup
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180302102057.8917-1-hdegoede@redhat.com>
 <20180302102057.8917-2-hdegoede@redhat.com>
 <20180309175347.GA12150@kroah.com>
 <bddcf7ea-e58c-637a-e546-9978fd2cb540@redhat.com>
 <20180312081345.GH21904@kuha.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <212ceba2-2f13-0501-c59e-612b72989cb3@redhat.com>
Date: Mon, 12 Mar 2018 10:19:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312081345.GH21904@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 12-03-18 09:13, Heikki Krogerus wrote:
> On Sun, Mar 11, 2018 at 07:24:18PM +0100, Hans de Goede wrote:
>> Hi all,
>>
>> On 09-03-18 18:53, Greg Kroah-Hartman wrote:
>>> On Fri, Mar 02, 2018 at 11:20:46AM +0100, Hans de Goede wrote:
>>>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>>>
>>>> Several frameworks - clk, gpio, phy, pmw, etc. - maintain
>>>> lookup tables for describing connections and provide custom
>>>> API for handling them. This introduces a single generic
>>>> lookup table and API for the connections.
>>>>
>>>> The motivation for this commit is centralizing the
>>>> connection lookup, but the goal is to ultimately extract the
>>>> connection descriptions also from firmware by using the
>>>> fwnode_graph_* functions and other mechanisms that are
>>>> available.
>>>>
>>>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Sorry for the delay, just now reviewing this patch...
>>>
>>> The content is fine (if not scary for the obvious reason of passing
>>> around 'struct device' of different bus types, but ok...), but the api
>>> naming is "rough":
>>
>> Heikki, I think it is best if you answer Greg's remarks. FWIW I'm
>> fine with the changes Greg proposes.
> 
> Me too.
> 
>> I currently have significantly less bandwidth for this due to
>> personal circumstances, so if a new version of this patch-set
>> is necessary it would be great if you (Heikki) can do a v7.
> 
> Sure thing. I'll prepare the v7.

Great, thank you. Don't forget to squash in the 2 fixes from
fengguang.wu@intel.com .

Regards,

Hans
