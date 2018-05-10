Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2746254-1525985970-2-17515481402443248875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525985970; b=KoqSz2gdfjuIKVhRdl2UBp1U5H7IaJpaqw3nkGBuN9WkPTBfuJ
    7ldIzMnTB8/nst4YkdhAaoTOro35ZoUMHktEOlt1sYAR7fO4mcxNnO5DhlEqce+n
    jTLoGaSXrnmIsPh/ma7eelSyweoMjG2tau9g3RM4c7gBmOZsWGa3vFkAjpSiJNQU
    pUWTduIE2KfO2MsQ2a8Vg8OkSv7S+8EUFUvXlk7t0wvmZeaIJHb2hw/WUv9kiEUl
    sGMnD/EI702UydLbzZZQhpAWSfpsNnervNOMzp0SG+NgiDYPczfUVY9eEkzzFgEf
    dWpciWhT10lSwiDMHiSiTj+FuNdD62C8YHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525985970; bh=HdoBMXkl4mcoA7HaqxxFX+7bnCjPw3w3FSo1Xi7X82
    E=; b=LLNt7fal1XSatzEBd12M/1VQrAdL8Cg5GMcdxtVQLZ5T0avBJB7JIcY629
    OBbsSxOduWiId7gjy/O3Kfp03bXbcIGuSa3xWtH8vRzLsUL8L3guj4pFYI7ZY+uR
    pdmoyqw3X+cZkdmsv6nYuhnKGxIEuqD69XpzVfxh45yAzaokn3Bqqt5/8ygdlOMw
    HBFJrngJjt9JLud6FGd0HcAW4QJO01IeG17SLxkdVIi3UsIwqvAADb77XDsgMQI1
    tN0T/zUVQz1SlAF6DkArb24WCNxDCCGS9Phgpz3cxxatd0jQ+qDyKp/P0EjRAGqW
    b1hUDe/aWVrOC78azdx5Uie/vZIQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=tgYlaYef x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=IjhTfh2h;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=tgYlaYef x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=IjhTfh2h;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDe1U7WB+M8A3X2dbGuDbkgWWu43xfM75EA/ySRiQBBBoNl+vuFWpcJXhFwFfyUrw+ApL4ClF48thpC6rjIcW+SNfuKq/vDOaOiu7qB+PNBUhkQ0zuMc
    oJr28pYT6lKMknL3ZPl4nyefxfV0hIyuPOTF4zeAJ7x2ZgWhxLfDYRnDy+DIdFgY3CWS0U9sY21cRWgOuW1wJSilv5CTErKl7zGG8+ZnMkHj80IxXHTnB97G
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=XGcojCJXKwz2LMdhw0AA:9
    a=303orzrfGTnFpfhN:21 a=GOG6Ok6r4845NDbf:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbeEJU7Q (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 16:59:16 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:43517 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeEJU7P (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 10 May 2018 16:59:15 -0400
X-Google-Smtp-Source: AB8JxZpcvDZ0TLbqjaD+0892qQpjexNTugagbiucjN0I8HzKqciOrFzfKydwclPYMvr4kKXIwg3CAIVm2KYDb+AWwOE=
MIME-Version: 1.0
In-Reply-To: <196bd304-3c6b-91b6-1743-50d6d13fc5a5@rock-chips.com>
References: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com>
 <1525748846-7767-2-git-send-email-william.wu@rock-chips.com>
 <CAD=FV=VKBVp++gPXzYN0N46NVarPNWqs1YZjfcd7twkU25WNyQ@mail.gmail.com>
 <f2e0fba2-da0b-38ba-6e25-3da9ccf1e4ee@rock-chips.com> <CAD=FV=W0Aufw1=UH2eZjb4cpiLjt9ty49CrUOdM5B2wF+WoY-A@mail.gmail.com>
 <196bd304-3c6b-91b6-1743-50d6d13fc5a5@rock-chips.com>
From: Doug Anderson <dianders@google.com>
Date: Thu, 10 May 2018 13:59:13 -0700
Message-ID: <CAD=FV=Xsa9MAw==_Oi28B69oqZehwL2JTwEzjKAnH5PS5wKC_A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] usb: dwc2: alloc dma aligned buffer for isoc split in
To: wlf <wulf@rock-chips.com>
Cc: William Wu <william.wu@rock-chips.com>, hminas@synopsys.com,
        felipe.balbi@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Frank Wang <frank.wang@rock-chips.com>,
        =?UTF-8?B?6buE5rab?= <huangtao@rock-chips.com>,
        "daniel.meng" <daniel.meng@rock-chips.com>,
        John Youn <John.Youn@synopsys.com>,
        =?UTF-8?B?546L5b6B5aKe?= <wzz@rock-chips.com>,
        zsq@rock-chips.com,
        =?UTF-8?B?6Kix5ZiJ6YqY?= <Allen.Hsu@quantatw.com>,
        Stan Tsui <StanTsui@aopen.com>,
        =?UTF-8?B?U3BydWNlIFd1ICjlkLPlu7rli7Mp?= <Spruce.Wu@quantatw.com>,
        Martin Tsai <Martin.Tsai@quantatw.com>,
        Kevin Hsueh <Kevin.Shai@quantatw.com>,
        =?UTF-8?B?TW9uLUplciBXdSAo5ZCz5a2f5ZOyKQ==?=
        <Mon-Jer.Wu@quantatw.com>,
        =?UTF-8?B?Q2xhdWQgQ2hhbmcgKOW8teaBreeviSk=?=
        <Claud.Chang@quantatw.com>,
        =?UTF-8?B?U2FuIExpbiAo5p6X5bu66I+xKQ==?= <San.Lin@quantatw.com>,
        Ren Kuo <Ren.Kuo@quantatw.com>,
        "David H.T. Wang" <davidhtwang@aopen.com>,
        Fong Lin <fonglin@aopen.com>,
        Steven Cheng <stevencheng@aopen.com>,
        Tom Chen <tomchen@aopen.com>, Don Chang <donchang@aopen.com>,
        milesschofield@aopen.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, May 9, 2018 at 1:55 AM, wlf <wulf@rock-chips.com> wrote:
>>>>> +       } else if (hsotg->params.host_dma) {
>>>>
>>>> Are you sure this is "else if"?  Can't you have descriptor DMA enabled
>>>> in the controller and still need to do a normal DMA transfer if you
>>>> plug in a hub?  Seems like this should be just "if".
>>>
>>> Sorry, I don't understand the case "have descriptor DMA enabled in the
>>> controller and still need to do a normal DMA transfer". But maybe it
>>> still
>>> has another problem if just use "if" here, because it will create kmem
>>> caches for Slave mode which actually doesn't need aligned DMA buf.
>>
>> So right now your code looks like:
>>
>> if (hsotg->params.dma_desc_enable ||
>>      hsotg->params.dma_desc_fs_enable) {
>>      ...
>>      ...
>> } else if (hsotg->params.host_dma) {
>>     ...
>> }
>>
>>
>> I've never played much with "descriptor DMA" on dwc2 because every
>> time I enabled it (last I tried was years ago) a whole bunch of
>> peripherals stopped working and I didn't dig (I just left it off).
>> Thus, I'm no expert on descriptor DMA.  ...that being said, my
>> understanding is that if you enable descriptor DMA in the controller
>> then it will enable a smarter DMA mode for some of the transfers.
>> IIRC Descriptor DMA mode specifically can't handle splits.  Is my
>> memory correct there?  Presumably that means that when you enable
>> descriptor DMA in the controller the driver will automatically fall
>> back to normal Address DMA mode if things get too complicated.  When
>> it falls back to Address DMA mode, presumably dwc2_hcd_init() won't
>> get called again.  That means that any data structures that are needed
>> for Address DMA need to be allocated in dwc2_hcd_init() even if
>> descriptor DMA is enabled because we might need to fall back to
>> Address DMA.
>>
>> Thus, I'm suggesting changing the code to:
>>
>> if (hsotg->params.dma_desc_enable ||
>>      hsotg->params.dma_desc_fs_enable) {
>>      ...
>>      ...
>> }
>>
>> if (hsotg->params.host_dma) {
>>     ...
>> }
>>
>>
>> ...as I said, I'm no expert and I could just be confused.  If
>> something I say seems wrong please correct me.
>
> Ah, I got it. Thanks for your detailed explanation. Although I don't know if
> it's possible that dwc2 driver automatically fall back to normal Address DMA
> mode when desc DMA work abnormally with split, I agree with your suggestion.
> I'll fix it in V4 patch.

Hmm, I guess you're right.  I did a quick search and I can't find any
evidence of a fallback like this.  Maybe I dreamed that.  I found some
old comment in the commit history that said:

/*
 * Disable descriptor dma mode by default as the HW can support
 * it, but does not support it for SPLIT transactions.
 * Disable it for FS devices as well.
 */

...and it looks there's currently nobody using descriptor DMA anyway
(assuming I read the code correctly).  It does seem like people were
ever going to turn it on then it would have to be dynamic as I was
dreaming it was...

-Doug
