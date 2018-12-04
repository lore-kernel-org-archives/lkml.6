Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C487BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E03206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpgRWJeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E03206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeLDPkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:40:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43340 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:40:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so8470264plb.10;
        Tue, 04 Dec 2018 07:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZmABk8MDzscBmhJmL+d4p4mB4+153PS58j7T7aq7OSk=;
        b=FpgRWJeUJ37TnjwgfyZhRHxJ5xo09jWp0Rhq92bQykxVjTi5Bxz32nVFd/h3KvWoDL
         OS0tq/kKwKRcS2Xq/KcSenFPabFoUE0vLLRcNmZoQxvFrfj+jbZ7HE87QCcNKRdpXFuk
         wsl6iXSbaKUVPI8f9BFhIily6Xo2aKVfbJ7SyEYn/ucIXgfXSL8dyqitQRJBE0iKO2TN
         gEjiWMZCaQG9EsFWPZIUxviK4zrBPy+yUWAnr/j8lX9wn0XLHb4J8DuhooIy+7haSCiH
         m7/OlsN4lhbCNuGa5ysuGFmxAZijhImZheYZtwJRzGFN/yR+l5s1U+F2Zdsl7SZq4plS
         H48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZmABk8MDzscBmhJmL+d4p4mB4+153PS58j7T7aq7OSk=;
        b=qnhpkQSvCUoy6JTlkv/YN9FkATomCyRW/Jv+GOhzSEcJAU9QbQzGZo9DaTdM4j55Uk
         32vJsRH3G4qqlrg9Og1fmESzL7cb0hzC4JPJWm6fPKhFNoBodEAH2sJJGMn47IRLrf4c
         V1Co6iRpOQAYo7liRxUKBi6A6dsuHwheBhZTWofW7nfuQFQ3n7nMju8jGk+b+KHHt9Gi
         V64GhtlkRUtpO0rV1FbrZytQFJXRexLhCy1yAsS/H49VDNBqo/9zSXDjNK8XkeLZS6a5
         cagXq8Yzq0F00Mu+uPHEMvvjvtuY+HURiUllgfrnu9spZMB8htswfke/DC8lSny9Zu25
         SqJA==
X-Gm-Message-State: AA+aEWa7YWuxsP5mfZICy5FR7rz52+ULRtHxAgK+IZBm1xqiBe3Gl7p+
        rksvWTsxIrAlN4Ss7p60WZQ=
X-Google-Smtp-Source: AFSGD/VV/MjfXpBU8HoSew02sIk7THHjhv+wHOJmuP0pj4URBNePCot8jBwxxmc1OkgUq+kACXmaqw==
X-Received: by 2002:a17:902:b090:: with SMTP id p16mr20486514plr.190.1543938006726;
        Tue, 04 Dec 2018 07:40:06 -0800 (PST)
Received: from [192.168.11.4] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b7sm25189584pfa.52.2018.12.04.07.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 07:40:06 -0800 (PST)
Subject: Re: [PATCH memory-model 0/3] Updates to the formal memory model
To:     paulmck@linux.ibm.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr
References: <20181203230411.GA27476@linux.ibm.com>
 <802d5c17-74fd-86a1-efba-5ee2825a0c3c@gmail.com>
 <20181203235127.GS4170@linux.ibm.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <fbd7b1ed-7a4f-b877-e2f0-8dafca817f68@gmail.com>
Date:   Wed, 5 Dec 2018 00:40:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181203235127.GS4170@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/03 15:51:27 -0800, Paul E. McKenney wrote:
> On Tue, Dec 04, 2018 at 08:28:03AM +0900, Akira Yokosawa wrote:
>> On 2018/12/03 15:04:11 -0800, Paul E. McKenney wrote:
>>> Hello, Ingo!
>>>
>>> This series contains updates to the Linux kernel's formal memory model
>>> in tools/memory-model.  These patches are ready for inclusion into -tip.
>>>
>>> 1.	Model smp_mb__after_unlock_lock(), courtesy of Andrea Parri.
>>>
>>> 2.	Add scripts to check github litmus tests.
>>>
>>> 3.	Make scripts take "-j" abbreviation for "--jobs".
>>>
>>> There is another series in preparation to model SRCU, but this series
>>> requires hot-off-the presses changes to the herd tool that have not yet
>>> been released.  This SRCU series is therefore targeting the merge window
>>> after the upcoming one.  People wishing to experiment with the prototype
>>> SRCU model may obtain it from my -rcu tree at branch "dev", and use
>>> a bleeding-edge herd7 built from https://github.com/herd/herdtools7/,
>>> version 7.51+2(dev), which is (commit 10403b24070c) or later.
>>
>> On the master branch of herdtools7, SRCU support was added in version
>> 7.51+4(dev), which is commit 6ec9da1f4d58, or later.
> 
> It has been working for me with version 7.51+2(dev), but perhaps I
> have just been getting lucky.  It wouldn't be the first time!  ;-)

Sounds like you've been at the HEAD of topic branch "srcu".

        Thanks, Akira
> 
> 							Thanx, Paul
> 
>>         Thanks, Akira
>>
>>>
>>> 							Thanx, Paul
>>>
>>> ------------------------------------------------------------------------
>>>
>>>  .gitignore                 |    1 
>>>  README                     |    2 
>>>  linux-kernel.bell          |    3 
>>>  linux-kernel.cat           |    4 -
>>>  linux-kernel.def           |    1 
>>>  scripts/README             |   70 ++++++++++++++++++++++
>>>  scripts/checkalllitmus.sh  |   53 +++++++----------
>>>  scripts/checkghlitmus.sh   |   65 ++++++++++++++++++++
>>>  scripts/checklitmus.sh     |   74 +++--------------------
>>>  scripts/checklitmushist.sh |   60 +++++++++++++++++++
>>>  scripts/cmplitmushist.sh   |   87 +++++++++++++++++++++++++++
>>>  scripts/initlitmushist.sh  |   68 +++++++++++++++++++++
>>>  scripts/judgelitmus.sh     |   78 +++++++++++++++++++++++++
>>>  scripts/newlitmushist.sh   |   61 +++++++++++++++++++
>>>  scripts/parseargs.sh       |  140 ++++++++++++++++++++++++++++++++++++++++++++-
>>>  scripts/runlitmushist.sh   |   87 +++++++++++++++++++++++++++
>>>  16 files changed, 757 insertions(+), 97 deletions(-)
>>>
>>
> 

