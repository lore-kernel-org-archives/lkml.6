Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeBHMFT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:05:19 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:32852 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeBHMFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:05:18 -0500
X-Google-Smtp-Source: AH8x226RGY29EJebtoAKJR4ruQSofZQkdv4p9lmpXn0C2JrzbFEBrkni05rEwDXV1MEYMeNgoo3qKw==
Subject: Re: [PATCH 1/2] trace-cmd: Fix the detection for swig
To: Vladislav Valtchev <vladislav.valtchev@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com
References: <20180204032014.6962-1-sztsian@gmail.com>
 <20180204032014.6962-2-sztsian@gmail.com>
 <20180206181807.2d35393e@gandalf.local.home>
 <df980185-aa29-f65b-d5b0-f42d85a66a51@gmail.com>
 <1518024315.3742.16.camel@gmail.com>
From: Zamir SUN <sztsian@gmail.com>
Message-ID: <a1c2c3f6-8d69-227d-51d4-1c40c53e0645@gmail.com>
Date: Thu, 8 Feb 2018 20:05:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518024315.3742.16.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2018 01:25 AM, Vladislav Valtchev wrote:
> On Wed, 2018-02-07 at 22:01 +0800, Zamir SUN wrote:
>>
>> While just a note for this, in Fedora 27:
>>
>> $ if command -v swig; then echo 1; else echo 0; fi
>> /usr/bin/swig
>> 1
>>
>> Actually this test has the same problem as of `which swig` - When swig
>> exists, the var SWIG_DEFINED will not be 1 (as shown above).
>>
>> I see Vladislav is already on this thread. I hope this can be fixed
>> before merging the patch set.
>>
> 
> Hi Zamir,
> I'm sorry but I'm unable to reproduce the issue on Fedora 27,
> after applying my series of patches.
> 
> In my case (fresh install of Fedora27, no customizations):
> 	if command -v swig; then echo 1; else echo 0; fi
> works as expected.
> 
> SWIG_DEFINED does not have to be '1' in order the Makefile to work.
> Because the check in my branch is:
> 
> ifeq ($(SWIG_DEFINED), 0)
> BUILD_PYTHON := report_noswig
> NO_PYTHON = 1
> endif
> 
> So there should be no problem. Just to be sure, I've tried to compile trace-cmd
> with my patches first without 'swig' and later with it (on Fedora).
> The result was that, in the first case the message 'no swig installed'
> was displayed, while in the other case it was not. Or better, a message
> saying that 'python-dev' is missing was shown.
> [Yes, both swig and python-dev are necessary].
> 
> After installing also 'python-devel' (in Ubuntu is just '-dev'), the
> build system was able to build the rest of the python targets as well.
> 
> 
> Could you please try by using my fork on GitHub?
> https://github.com/vvaltchev/trace-cmd-fork
> BRANCH NAME: make8.
> 
> Let me know if you still experience the issue.
> 

Hi Vladislav,

Thanks for the URL. I tried to build from your make8 branch, it works
fine. I must made some copy-paste mistake yesterday.

Sorry for the noise.

Thanks.

> Thanks,
> Vlad
> 
> 
> 

-- 
Zamir SUN
Fedora user
GPG : 1D86 6D4A 49CE 4BBD 72CF FCF5 D856 6E11 F2A0 525E
