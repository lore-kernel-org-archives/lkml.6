Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC75C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531FF21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MYbTRI64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeLRPgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:36:55 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44452 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeLRPgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:36:55 -0500
Received: by mail-qk1-f193.google.com with SMTP id n12so9684962qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6HpRSAOxlCyi0OWTFvflnj2CYme3RasMPz+oPuzQIGg=;
        b=MYbTRI64ofdLfo5h6jTx9uplhdfX1ROq1iDPLmq7/d2xQkgUi+GzHQF4zrbxUKjrU/
         rPQU838wD427LQuBQMqcn8VSD5Aeu7GXYSvAmGf82tz+X+HW2PN5uK1ddJUSDpyuJ/7g
         b+ayKVt+U+b6TshrPcGXbHdFJRhw1bp15KBPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6HpRSAOxlCyi0OWTFvflnj2CYme3RasMPz+oPuzQIGg=;
        b=ePQFiZePU+QpfAfDY0zwKPFFfGqg/ZcFEzFR8cq3wPim4M0eDqMSQOScZYhhnmEVQE
         XXjRZQcXUwMJksSNyazaM+Yuukery0ldG0EjqUg6Qq9qp0Id5ncjMu/NNBr7cd1boE78
         hyUgIvZA+r5ncQZhVeu810qCSV3a2LpXFrcxFmisiIsGREfAQ+CtbeiCJa+ww23T9Pv8
         a//M/tm3VJLceOYcO944No9e0grQjuuODCkbvKnrVluPp4Ajx5svfglOKtS9yGklub+r
         jCiQC4h7uuiJF6mzk34gaE5KbISl2eCwwWHpDVp0xWCYHrRZjWddwEVjFRfaSPn6Addu
         J4eg==
X-Gm-Message-State: AA+aEWYjNSl9GANl4KJHAIb6ZA8Ou0F8lT4XCPUob+pRfNrFz/1tT+Rv
        UavwRH5lCwwlgCjypk8cP1WlRjOeFqsKiQ==
X-Google-Smtp-Source: AFSGD/UHANJ2Sbzst/VlHfg4qsmDhC8gbEE6IqGqS6zWMBuc6OuXq+0PijO35wCJtAMzh4CHqPr+zA==
X-Received: by 2002:a37:5bc1:: with SMTP id p184mr17083213qkb.121.1545147410850;
        Tue, 18 Dec 2018 07:36:50 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.31])
        by smtp.gmail.com with ESMTPSA id c77sm186584qkh.82.2018.12.18.07.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:36:50 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: selftests/net: udpgso: LTS kernels supportability ?
To:     shuah <shuah@kernel.org>
References: <bbabafb5-e16c-4025-31d0-d9e5feb5f39a@linaro.org>
 <1d2c9a10-6caf-49ff-b921-8b93dbe96f78@kernel.org>
 <1de7a003-0aac-1f4f-b836-267136e30a0a@linaro.org>
 <fd4c527a-daeb-1c73-c423-95d02e1b8e86@kernel.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <f0529af4-4eb6-afb3-3992-c196a09af6bc@linaro.org>
Date:   Tue, 18 Dec 2018 13:36:46 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <fd4c527a-daeb-1c73-c423-95d02e1b8e86@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 12:53 PM, shuah wrote:
> On 12/18/18 4:37 AM, Rafael David Tinoco wrote:
>> On 12/17/18 4:42 PM, shuah wrote:
>>> Hi Rafael,
>>>
>>> On 12/17/18 10:53 AM, Rafael David Tinoco wrote:
>>>> Shuah,
>>>>
>>>> I was recently investigating some errors coming out of our functional
>>>> tests and we, Dan and I, came up with a discussion that might not be
>>>> new
>>>> for you, but, interests us, in defining how to better use kselftests as
>>>> a regression mechanism/tool in our LKFT (https://lkft.linaro.org).
>>>>
>>>> David / Willem,
>>>>
>>>> I'm only using udpgso as an example for what I'd like to ask Shuah.
>>>> Feel
>>>> free to jump in in the discussion if you think its worth.
>>>>
>>>> All,
>>>>
>>>> Regarding: udpgso AND https://bugs.linaro.org/show_bug.cgi?id=3980
>>>>
>>>> udpgso tests are failing in kernels bellow 4.18 because of 2 main
>>>> reasons:
>>>>
>>>> 1) udp4_ufo_fragment does not seem to demand the GSO SKB to be > than
>>>> the MTU for older kernels (4th test case in udpgso.c).
>>>>
>>>> 2) setsockopt(...UDP_SEGMENT) support is not present for older kernels.
>>>> (commits "udp: generate gso with UDP_SEGMENT" and its fixes seem to be
>>>> needed).
>>>
>>> This case is easy right? Based on the test output below , I can see that
>>> the failure is due to
>>>
>>> ./udpgso: setsockopt udp segment: Protocol not available. setsockopt()
>>> is returning an error to clearly indicate that this options isn't
>>> supported. This will be a test change to say test is a skip as opposed
>>> to fail.
>>
>> You referred to (2). (1) isn't that straightforward.
>>
>>> We have a solution for this - test should SKIP as opposed to FAIL.
>>>
>>>> With that explained, finally the question/discussion:
>>>>
>>>> Shouldn't we enforce a versioning mechanism for tests that are testing
>>>> recently added features ? I mean, some of the tests inside udpgso
>>>> selftest are good enough for older kernels...
>>>
>>> Right - we do have generic way to handle that by detecting if feature is
>>> supported and skip instead of using Kernel version which is going to be
>>> hard to maintain.
>>
>> You can't distinguish case (1) failures between real failures OR older
>> kernel behaving differently then testcase expects.
>>
>>>>
>>>> But, because we have no control over "kernel features" and "supported
>>>> test cases", we, Linaro, have to end up blacklisting all selftests that
>>>> have new feature oriented tests, because one or two test cases only.
>>>>
> 
> Can you share the blacklisted tests?

Sure!

The following yaml file:

https://github.com/Linaro/qa-reports-known-issues/blob/master/kselftests-production.yaml

Contains a list of all "known issues" for kselftests running in LKFT.

1 entry example (this particular one):

 - environments: *environments_all
    notes: >
      LKFT: net: udpgso.sh PASS on 4.18 and failed on 4.17 and below
    projects:
    - lkft/linux-stable-rc-4.14-oe
    - lkft/linux-stable-rc-4.9-oe
    - lkft/linux-stable-rc-4.4-oe
    - lkft/linaro-hikey-stable-rc-4.4-oe
    test_names:
    - kselftest/net_udpgso.sh
    - kselftest-vsyscall-mode-none/net_udpgso.sh
    - kselftest-vsyscall-mode-native/net_udpgso.sh
    url: https://bugs.linaro.org/show_bug.cgi?id=3980
    active: true
    intermittent: false

Tells us:

Its a known issue for all environments (arm, arm64, x86, x86_64, qemus,
etc) and kernels 4.14, 4.9 and 4.4. The "url" shows our internal bug
related to the known issue/investigation.

With that, we don't consider it as a regression when this test fails for
4.14, 4.9 and 4.4 in any existing environment (boards, qemu/kvm, hosts,
diff archs).

I hope it helps you,

Cheers o/
-- 
Rafael D. Tinoco
Linaro - Kernel Validation
