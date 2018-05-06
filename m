Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2499662-1525566449-2-93991907487252421
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525566449; b=lwzsh3ZucIcShL8F4JR+tYp5VNCk/aGIyvYObOCbIbk+MRo9Af
    04FMNLCj5rNYUnjx5XHjWF0/AQLneP/NZ3dl3+Xk32M1CBaBieaWDyx82LdIJvq6
    zS2txg28vMarL76o3hzvELYvrXOoTZHEMxTasvOV5ERGB7bSv4MglYvD2F+VGCNo
    FN4oyx6l+dBfTDZKDVGHgWGDnQ4HmC0+M+QfMt3+uVsXdSykcmbDWOC7B+JhODt/
    UrKOMBIDx1mMYJLbiTESG/jmO+4u0hT2TJ2Pm83Wxn2Nc7/JVtYOELOP82ul6afh
    IrB2yeIUW6+q8ctq8M6/Id2uhTey0yLzaQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525566449;
    bh=mhSsb/LKqOfpMq1sdRMBrhsItaQmFqHBpyPXngOuIdQ=; b=Ztlnneg5B+Ya
    zqq5jsMLddbRYZ99SYg4xW5hhN8L/x7tLlp2n9zCP+iw1A9zq969z+lvUWelzgNI
    CBfBvG/OzPNY1zOmrdTxLaNPJFc+hLD5e6sG/zgEZldNTraSRO2pivJsG0k+6V/J
    gXMpxOZDN1+0CIHIcLmUuUMgglz2XC1+UiOzWyJ4xiPQIBwwku5I2jz8ND47nJPA
    j5BeDafIrfLeIcswMWH5z1OS6jGMBHdU8dTtmIEDmK9HRJ/yJz1IuSQ5tcvvsY9i
    Pcv3T+zFYk5tUDpKY2lTVb3ywp6/q91ZHQ/t3IZE4PsG2574GXsvV9KCQM7euvQ/
    cXlcbIh1/A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=s3ganU/t
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=s3ganU/t
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOfVhplwIgCzrG1+hxH48c4C/3xaz7iTIIrVKs5298XEevLKRQLi5L02mryMBYYPTV6Bk+Xk9x9ed7sDM3yRoDQFkD9RCx+6HllABCN9cFh2/ee/fle1
    mJm48zIXrMgakBH511ClTQiB0QJS/YMkejs4RG9NO/JRTqtW5Moi7j5pjNIoqaXmaYpyYRd2mDJzzyMv+ehokxdG62R1I4AOjZrguLrHQnmeLS+/DMDie47X
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=dBVVAcHtdfJYW15djC4A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeEFA10 (ORCPT <rfc822;linux@kroah.com>);
        Sat, 5 May 2018 20:27:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40308 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbeEFA1Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 May 2018 20:27:25 -0400
Subject: Re: [PATCH v2 4/5] kernel hacking: new config DEBUG_EXPERIENCE to
 apply GCC -Og optimization
To: "Du, Changbin" <changbin.du@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
 <1525268700-10631-5-git-send-email-changbin.du@intel.com>
 <20180502101707.206984e9@gandalf.local.home>
 <20180502134558.1f388e097dcde6f589635404@linux-foundation.org>
 <20180502211956.6c9e8d7b@vmware.local.home>
 <20180503134546.5p3z4g5na7ew4fun@intel.com>
 <20180503102823.5b54cd56@gandalf.local.home>
 <20180505235725.hglh6u77spw55qa5@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9dc6279b-767a-a4b1-75a9-aefdef61a224@infradead.org>
Date: Sat, 5 May 2018 17:27:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180505235725.hglh6u77spw55qa5@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/05/2018 04:57 PM, Du, Changbin wrote:
> On Thu, May 03, 2018 at 10:28:23AM -0400, Steven Rostedt wrote:
>> On Thu, 3 May 2018 21:45:46 +0800
>> "Du, Changbin" <changbin.du@intel.com> wrote:
>>
>>>> With that gcc comment, I still think CONFIG_OPTIMIZE_DEBUG is more
>>>> inline with what it is and understandable than
>>>> CONFIG_DEBUG_EXPERIENCE. The "OPTIMIZE" is the key word there.
>>>>
>>>> -- Steve  
>>> What about CONFIG_CC_OPTIMIZE_FOR_DEBUGGING? We alreay have
>>> CONFIG_CC_OPTIMIZE_FOR_SIZE and CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE.
>>
>> Yes I like that much better.
>>
>>>
>>> And do we need to move it to existing configuration menu "General setup->
>>> Compiler optimization level"? But I also want it appear in "kernel hacking"
>>> since this is a debug option.
>>
>> I understand why you would want it by debugging, but I think it does
>> make more sense to be included with the above two other options, as
>> they are all mutually exclusive.

mm, sounds good.

>> This brings up the topic of creating config paradigms. That is, a way
>> of saying "I want a debug kernel" and select one option that selects
>> everything you would expect. Or perhaps we should have a:
>>
>>  make debug_config

Sometimes I want to build allmodconfig-minus-debug options ... but not
all debug options.  I still want debugfs but most options that end with
_DEBUG are disabled.  I.e., I don't want the options that cause big
run-time slowdowns. (unless I cause that by printing some debugfs
contents)

Can merge_config.sh (or one of its cousins) help with that?

> Agree, I accomplish this by running script scripts/kconfig/merge_config.sh.
> 
>> that does it.
>>
>> But that's a different topic. For now, I would just included it in
>> init/Kconfig, and not worry about it not showing up in kernel hacking.

Ack.


thanks.
-- 
~Randy
