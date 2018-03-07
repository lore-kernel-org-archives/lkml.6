Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELv8OnPj5s03ri+w4vDTTsZKKzfEQFU8Hck4/8zdDaZwkte2SlWW7c5fAoEUP1aLmU5/Gdqq
ARC-Seal: i=1; a=rsa-sha256; t=1520452294; cv=none;
        d=google.com; s=arc-20160816;
        b=tAVsyws4jHFKOmGHgnggV4cD2eoLY8GBoJQmtsHcEGb5f6O4khcKFrbKlQmaWsQZFl
         sqDjEOsd6EoljNO3qtWlchMBS/mJCqDqaIb3cA1gjJ6RlGgVQGutXMlwcvpr5axK6Os7
         QosnPjJkrG40po8CTVKj/SjnGK9p0ceWCNAEVr6P7L0S9mEQ5Tt2YBLzWuqCKP+SnueW
         kr6t8xzXXfYnRrOVD49xo+kJxSLPK1y4oBOlF6mRfWTR+0/xvAX3es4EQD7NZ+n5RX0m
         sJ2wYTTpBWltod7OZnbC427jZhow5ouwk3W4KH3AgAL1afYH20AbDOmxF6evbO62iDEk
         tOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:reply-to
         :arc-authentication-results;
        bh=RngUAed+vQHhyOAcs5qwvC06jp5xfFYHfyzFhveasnE=;
        b=UWxE07F4f5FQH4hKqb9WBKPWDmBsZLc/Me27oSHMf+GvJyIK5KaNdHjcjLt9yobPgB
         UbpRLbhW2soligxdvfR5VycEKKZFXDQoVHmnj/ehF/8vv20mUakdeB9RX6j+rekEYwzW
         VDZIE1c39Uu1A6Yp+pyDUqA6itmVsnYgEMI/KkuDjQHgvFeQd++Mp4j0HxB+4xrbXKT0
         iBlBE2nC6jEZ2yQN5no1Roxntns5JI1zb4oxzr9WKpQO1UO8KQF9VA2GG5r+HAUFoUnC
         3ufYxiVDEGOhKvsJz5ARU1KEDiW56HPShzv9Ij9dlPa3VCtncIzq4fsSAWIjv36+dlfH
         o6Pw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935133AbeCGTvU (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 7 Mar 2018 14:51:20 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:37260 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935127AbeCGTvS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Mar 2018 14:51:18 -0500
Reply-To: shuah@kernel.org
Subject: Re: [PATCH] selftest: net: reuseport_bpf_numa: don't fail if no numa
 support
To: David Miller <davem@davemloft.net>, anders.roxell@linaro.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180306151004.31336-1-anders.roxell@linaro.org>
 <20180307.132500.40232199631094354.davem@davemloft.net>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <1a84294d-babc-e4ff-1e2f-9265450fee8f@kernel.org>
Date: Wed, 7 Mar 2018 12:51:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307.132500.40232199631094354.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594201505777703046?=
X-GMAIL-MSGID: =?utf-8?q?1594309785291308987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/2018 11:25 AM, David Miller wrote:
> From: Anders Roxell <anders.roxell@linaro.org>
> Date: Tue,  6 Mar 2018 16:10:04 +0100
> 
>> The reuseport_bpf_numa test case fails there's no numa support.  The
>> test shouldn't fail if there's no support it should be skipped with a
>> pass.
>>
>> Fixes: 3c2c3c16aaf6 ("reuseport, bpf: add test case for bpf_get_numa_node_id")
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> I don't know about this.
> 
> The test did not pass.  So it should not be "skipped with a pass".
> 

You are right that "skipped with pass" is ambiguous. Don't we wish
we could have done that in college :)

> We were unable to run it at all, which means we don't know if it
> would pass or fail.  This means there is a third state besides
> pass or fail which we must acknowledge and implement.
> 

Several tests and test scripts treated test that can't be run as errors
which is also ambiguous. Test user community requested that they would
like Skips to be treated as pass. I think the reasoning is that on ARM
systems, several tests get skipped - NUMA happens to be one and there are
others. Also the configs. Not all config options might be enabled
and tests need to be skipped.

This seems to causing problems for test result analysis.

So I made a call to say - okay let's treat Skip as pass to make it easier
for analysis. Some test authors are okay with treating skip as pass. Some
test authors don't like doing so. So we are currently in an inconsistent
state. Maybe networking tests are the only ones that don't treat skip as
pass at the moment. In any case, dependency checks are made from test shell
scripts mainly and in some cases from test programs such as bpf_numa and when
dependency isn't met, some tests treat it as an error and sone as skip-pass.

Lots of test scripts check for !pass and call it fail. So changing skip as a
distinct state requires some work in several tests. Not impossible, just
effort.

Kselftest infrastructure on the other hand maintains skip count and for
tests skipped, also prints a distinct message for it. Originally skip was
treated by the framework as distinct state implying that the test can't be
run which makes more sense. Based on the request as stated above, I made
a change to map KSFT_SKIP to KSFT_PASS. Several tests use the infrastructure.

That said, I am open to adding a distinct state for skipped because can't
be run.

thanks,
-- Shuah




