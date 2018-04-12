Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-868050-1523536352-2-3296146177563144776
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523536350; b=QlniggTJSvf1NUB8uaWrNG2hQLkAfAKZtPO/kRt2SzsanWUdQn
    b08PSlT792TWZRUtDJsriWPOFpqvQmTkkGSsuC1Njxn08Mu8RpYHPYQ3Vt3zOrit
    fpA0xlgVq5rtJoSoRtcSj7KmqkupsWw81dNrCpNbiEvZy0fFmuKRpaEQfhcrM15u
    S6VtvcHO7ErnJxb1B/0/hu1s0psI7mtnncpModX5JidaLfFaOuMkyT5PIE1kiPhM
    BQ0oIDShKJhjAenvMZh/SwNTED3XnfId8qIh4vVQcqXgnfnPTUchQ628XfGhYI0O
    YDpoVPKzaDWr3pJ302RtzVopvcMEW8ZO4GeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523536350;
    bh=KaX8KbPrwwyTvNYva85FcJzZO6V7Vl2ODFh3tnRGCw0=; b=CG70I0MrruLy
    XSpFnB+nw+nBmGXXxdrIETNu8PugVyAeXnn9B+qC0MnKJSxw8Ol2aiyv37eHPYd9
    +zUqwAQxUCb0TpoBnqVnYDecTE2wof6cIpDM2xPHE1hglkdJiSbyvoYvzIfObU2J
    gaCv91Sq4vw68uwwHmfJcFSK2CLzqSe+BtrPqHiOXP8V08+Iod3inKFiLk9OvoPN
    mJSCci8VFaCzRVB1ysOkGndXkVty++rOWoOU1fHVcXTQatV3rH+6R/4KZDn/wLU0
    6kluRpPpgdPbCyiIhVrYWZFeFoaPeuGLi9mWIXHb5up4Nz4d1xNgC1erpOE4OsV9
    B9SlV99fNw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=gxl4747y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TXSnCwle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=gxl4747y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TXSnCwle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO6lHQ4HO4ucnm/Tk+DQGAbQko8Vn90butDOg7aj0DmLWt29UN9VilAXmDfIdkB7Wogj6msJLlj3FEFXnpeLZuuZfhkGL9231WKFKI5yduzUv7otfN6G
    zXpyMHhxQl9P4AvLCeKwcwteIZjaxIvxRdUEQFjCKANHhAKrSSMbhQnyDwFaktTClxqA88IL07Haj2Sh3/SZ7gMAUL53gNrCSKu4GCXea6HrqTL69P2vf/3A
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=zoehSAk54XIA:10
    a=Kd1tUaAdevIA:10 a=KKAkSRfTAAAA:8 a=D19gQVrFAAAA:8 a=dXujQiBl2WLyec4U8OkA:9
    a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeDLMcP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 08:32:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50297 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDLMcM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 08:32:12 -0400
X-Google-Smtp-Source: AIpwx4+LZI0vz7kX9LlFYQoc/vC4VDMwJJlne2tqb/c9d/ooOpVWlc1iRvyzqB1Ttvby7mtuO3PTog==
Subject: Re: [PATCH 4.9 000/102] 4.9.93-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Will Deacon <will.deacon@arm.com>
References: <20180406084331.507038179@linuxfoundation.org>
 <20180406222524.dzzyzh3su3ytgh3u@xps> <20180407061118.GF18744@kroah.com>
 <45305b36-b5fb-5016-4948-38a7465691af@linaro.org>
 <20180412122305.GA19236@kroah.com>
From: Thierry Escande <thierry.escande@linaro.org>
Message-ID: <5195ccd4-1a9d-b1e5-3cb4-1b6b6243f3ed@linaro.org>
Date: Thu, 12 Apr 2018 14:32:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412122305.GA19236@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12/04/2018 14:23, Greg Kroah-Hartman wrote:
> On Thu, Apr 12, 2018 at 02:17:50PM +0200, Thierry Escande wrote:
>> Hi Greg,
>>
>> On 07/04/2018 08:11, Greg Kroah-Hartman wrote:
>>> On Fri, Apr 06, 2018 at 05:25:24PM -0500, Dan Rue wrote:
>>>> On Fri, Apr 06, 2018 at 03:22:41PM +0200, Greg Kroah-Hartman wrote:
>>>>> This is the start of the stable review cycle for the 4.9.93 release.
>>>>> There are 102 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Sun Apr  8 08:42:55 UTC 2018.
>>>>> Anything received after that time might be too late.
>>>>
>>>> Results from Linaro’s test farm.
>>>> No regressions on arm64, arm and x86_64.
>>>>
>>>> There is a new test failure on dragonboard 410c (arm64) in
>>>> kselftest/cpu-on-off-test. However, it looks like the test was failing
>>>> but giving a false "PASS" on previous versions of 4.9. This -RC seems to
>>>> have changed the behavior enough to cause the test to actually mark a
>>>> failure.
>>>>
>>>> In any event, this looks like a db410c-specific pre-existing issue that we have
>>>> already escalated to our Qualcomm team. Details can be found at
>>>> https://bugs.linaro.org/show_bug.cgi?id=3723 for those interested.
>>>
>>> Thanks for testing these and letting me know.
>>
>> The test failure on dragonboard 410c comes from [1] to fix a possible
>> deadlock related to the hotplug rework. It's been reverted in v4.12 by [2]
>> because the cpu hotplug rework was not ready yet at that time. Since the
>> hotplug rework has not been backported to v4.9.y, the splat cannot be
>> reproduced and so [1] can be reverted or [2] applied on v4.9.y.
>>
>> [1] https://lkml.org/lkml/2018/3/23/452
>> [2] https://lkml.org/lkml/2017/5/7/124
> 
> Hm, so I need to drop some patch, but what one?  lkml.org does not work
> for me, please be specific and use the git commit ids, or at the
> very-least, the subject of the patches.  Never make someone have to rely
> on the existance of a random web site not under kernel developer's
> control to figure out what to do...

So the commit to be reverted is [1], introduced in v4.9.90. Or you can 
apply [2] from v4.12 that actually reverts [1].

[1] 18dd7b964c01ac44497471f4ea3f4c0c663eab55
[2] 51d638b1f56a0bfd9219800620994794a1a2b219

Regards,
Thierry
