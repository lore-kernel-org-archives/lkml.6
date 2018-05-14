Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-436143-1526283421-2-18151559165886569443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='fi',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526283421; b=RjbXBLszBwJR/UnjZyP45GSpNiGpxNVdBqAUJj/W21cGZUFbHx
    QwMYkeXhTS6Z/g+sPLSAoqalj+ZZhhKUEDM87Xrc95/q+oEBcJn1njKY36LSOt3o
    s+I9S1xc2Nz7h1p6Q6jWjqjSVHKxeFAMLvTfcz55xygQPqD+Uio+RJhgWR0O2+tp
    WGi7Lumzk1xFs/drc9DAzKONan4PWg4IWUWfGBPiLz/qjQKtX1brnqN1CCM8JUkB
    BqYCaAq0bHtGA2jFVPKFRK2HR4DYPehBQWp0/IHXCWY1NVnSMqjHGRwywGlw+6bx
    Sl44r9q8BwkgMAb/BZyyfxOg+4VBjHZ/CGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526283421;
    bh=McbxPHyvsgGxRAz9hoNizD8hL0W6zIWSSUzMR5EW4wk=; b=cHKfALrXzUWb
    Hzs/shnSKLfkYn56QhKoDw6KRWpH1mdLb0gwroq/iAIXDDLL1XUR0laGohRXmner
    qrdPmN0jPOs1giumMfAFCoVEJsIeLTprCv29UueHGL553tNnU55rBkdFEi8Qk3X2
    A3JOVEuqxxv7Sik+NV0HsC45pJXHcVnuaD1UxQPT1pAB8Ijde77LA4KdnbB5KogO
    Alxnj9b7DYet7LoF3C32kw6e+W0hSj7qU7YRZAOAuyiHZExHDbclYeQCL9m7dvRN
    k9kPjkgSWlV6cU6KRbpjHtzIGpf57T20RBBuFs7SI4CkNVSuzJPlpGahcvc3OCMJ
    CZltHyJFfg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=kapsi.fi header.i=@kapsi.fi header.b=v4F1LWB/ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161220;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kapsi.fi;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kapsi.fi header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=kapsi.fi header.i=@kapsi.fi header.b=v4F1LWB/ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161220;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kapsi.fi;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kapsi.fi header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEmEOtcjBifxgXzlVbtDP5LxcvqYGtvSeYRMDMxOXyf8GER23dBr0Br/8+Ykw4Bgv07S/uc7dZ+igcjgrSr/CeCNOpQ092liK1jpnmovmJIDnMHShGHA
    RPQk4g+MG8c1Ntfh1a0svDsICeIuR7ne72/4bdVWwzW1+UMi+gsQyrtitS5iG2lcYIOgtcHqGP67geTG1VcY4MJxKfdm0x07kU3fkkVJrOVzbhTCKqHRyyTt
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=LiKsbbkGBDXS28OhBwAA:9
    a=6LCEndhrrXRIotYh:21 a=t2Qi1PnGUSj50wfw:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeENHgp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:36:45 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:33727 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752990AbeENHgn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 03:36:43 -0400
Subject: Re: [PATCH 6/8] serial: Add Tegra Combined UART driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-7-mperttunen@nvidia.com>
 <CAHp75VfYF_u2bZ+temGbReEB9K-t3A75aUNYwffyv9-=zEi0Lw@mail.gmail.com>
 <662ce972-56a9-9daa-d332-faa08b89c05a@kapsi.fi>
 <CAHp75VeJcqaiWUVr=oXEH5YurY3yCDdE1eeoWumo6jCa_4PWEQ@mail.gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, araza@nvidia.com,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <513a6287-9bb3-1441-b3ea-6866f2e74c99@kapsi.fi>
Date: Mon, 14 May 2018 10:36:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeJcqaiWUVr=oXEH5YurY3yCDdE1eeoWumo6jCa_4PWEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.209.167.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14.05.2018 01:20, Andy Shevchenko wrote:
> On Sun, May 13, 2018 at 9:04 PM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>> On 05/13/2018 05:16 PM, Andy Shevchenko wrote:
>>>
>>> On Tue, May 8, 2018 at 2:44 PM, Mikko Perttunen <mperttunen@nvidia.com>
>>> wrote:
>>>>
>>>> The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
>>>> multiplexing multiple "virtual UARTs" into a single hardware serial
>>>> port. The TCU is the primary serial port on Tegra194 devices.
>>>>
>>>> Add a TCU driver utilizing the mailbox framework, as the used mailboxes
>>>> are part of Tegra HSP blocks that are already controlled by the Tegra
>>>> HSP mailbox driver.
>
>>>> +static void tegra_tcu_uart_set_mctrl(struct uart_port *port, unsigned
>>>> int mctrl)
>>>> +{
>>>
>>>
>>>> +       (void)port;
>>>> +       (void)mctrl;
>>>
>>>
>>> Huh?
>>
>>
>> The serial core calls these callbacks without checking if they are set. They
>> don't make sense for this driver so they are stubbed out.
>
> My question why do you need these ugly lines? I'm pretty sure no other
> driver with stubs using such style.

It's my personal style, being explicit about unused variables in this 
way - I don't consider them ugly. But I can certainly remove them for 
the next version.

>
>>>> +}
>
>>>> +               if (written == 3) {
>>>> +                       value |= 3 << 24;
>>>> +                       value |= BIT(26);
>>>> +                       mbox_send_message(tcu->tx, &value);
>>>
>>>
>>>> +               }
>>>
>>>
>>> (1)
>>>
>>>> +       }
>>>> +
>>>> +       if (written) {
>>>> +               value |= written << 24;
>>>> +               value |= BIT(26);
>>>> +               mbox_send_message(tcu->tx, &value);
>>>> +       }
>>>
>>>
>>> (2)
>>>
>>> These are code duplications.
>>
>>
>> Indeed - the length of the duplicated code is so short, and the instances
>> are so close to each other, that I don't find it necessary (or clearer) to
>> have an extra function.
>
> It makes sense. Consider to refactor other way w/o duplication then.

I'll see if I can refactor it out.

>
>>>> +static void tegra_tcu_uart_set_termios(struct uart_port *port,
>>>> +                                      struct ktermios *new,
>>>> +                                      struct ktermios *old)
>>>> +{
>>>> +       (void)port;
>>>> +       (void)new;
>>>> +       (void)old;
>>>> +}
>>>
>>>
>>> Remove those unused stub contents.
>>
>>
>> Sure. I had these here so that we don't get unused parameter warnings, but I
>> can just as well remove the parameter names.
>
> What warnings? How did you get them? We have them disabled as far as I
> know even with W=1.

May be - it's just a habit, maybe from other projects where the warning 
is enabled.

>
>>
>>>
>>>> +       return uart_set_options(&tegra_tcu_uart_port, cons,
>>>> +                               115200, 'n', 8, 'n');
>>>
>>>
>>> Can't it be one line?
>>
>>
>> It would be a total of 81 characters in length on one line, so no.
>
> So, yes. 1 character doesn't prevent us make the readability better.
> Please, put to one line.
>

Ok, I'll change this.

Thanks,
Mikko
