Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAF6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CF82087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SXRypt7s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FOyz0AEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CF82087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbeKPVBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:01:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52046 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKPVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:01:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2416D607EF; Fri, 16 Nov 2018 10:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542365405;
        bh=/b3bIGLEtyTMrzfu6pwutm+dxr+uFIi4lqCBRJbRC4A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SXRypt7sV+XUeULqfo0qXyH2dihvAbvW3fb4FWhYdABDu7q2DkiiXa+Mng4GOyTsQ
         E/GKvhHbeVit3E9brTL9DHFIGysDvqE2dozuXA6vY7UiTi6OWKu1TC6NdJMa4qGCM2
         70OpuYHzYZiVjjMUcZT0H5jEIV4/ddR+jyOdybSc=
Received: from [10.79.128.250] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 676EB6024C;
        Fri, 16 Nov 2018 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542365397;
        bh=/b3bIGLEtyTMrzfu6pwutm+dxr+uFIi4lqCBRJbRC4A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FOyz0AELA6Mr+A6aasjudVPPNM0zldyApK7pE9nhuIeMzCIbyDd81BdrgoEN8ZOm5
         tLvrh5xq92OVDx+82TArPp8Ox9qSfmfJSGnLYIWjPwSdSfgcL41idRDTXuf/E0VT5D
         +QCsNQOBT6HYH61Ri66drQkU6JRSAGBNbaZus54s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 676EB6024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        srinivas.kandagatla@linaro.org
Cc:     Steven Rostedt <rostedt@goodmis.org>, sboyd@kernel.org,
        joel@joelfernandes.org, bjorn.andersson@linaro.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>, geliangtang@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        gpramod@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        vivek.gautam@codeaurora.org, sibis@codeaurora.org
References: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181017223334.29ca2837@vmware.local.home>
 <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
 <20181018091706.62310b38@gandalf.local.home>
 <20181019041740.GB141835@joelaf.mtv.corp.google.com>
 <8a75f2d5-f1bd-504e-b545-ae2e2f61ca8f@codeaurora.org>
 <20181019095122.0f1c0946@gandalf.local.home>
 <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org>
 <20181019111205.5c8e98e8@gandalf.local.home>
 <1e6cc1fa5263b9edfcf7567d3f9f65fd@codeaurora.org>
 <38099043-f5ed-6d81-bf94-13f61cfa8507@linaro.org>
 <8f65f83b-8cd9-5e35-c324-30b86390906e@codeaurora.org>
 <ed648cc5-0748-8bcc-5ebb-ce6dbc7d4fee@linaro.org>
 <CAOh2x=kHQ_PfZqcoDE1+jx-ArMOh4hAFqXxiiKJ9=3JZUySQEw@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <6ba6073e-c2ff-193c-3038-8329c06e325c@codeaurora.org>
Date:   Fri, 16 Nov 2018 16:19:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAOh2x=kHQ_PfZqcoDE1+jx-ArMOh4hAFqXxiiKJ9=3JZUySQEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/2018 9:09 AM, Viresh Kumar wrote:
> On Thu, Nov 15, 2018 at 4:23 PM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
> 
>> Yes, this is not the solution, but it proves that the hand-off between
>> booloaders and kernel is the issue.
>>
>> In general there is wider issue with resources hand-off between
>> bootloader and kernel.
>>
>> There has been some proposal in the past by Viresh for a new framework
>> called boot-constriants (https://lkml.org/lkml/2017/12/14/440) which am
>> not sure if its still actively looked at. But something similar should
>> be the way to address such issues.
> 
> It isn't dead code yet and I am waiting to gain few more use-cases
> before I attempt
> to convince Greg again :)
> 
> Here is the code..
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git boot-constraint
> 
> --
> viresh
> 

Maybe you can take this earlycon issue as a usecase.
I have added a boot constraint for earlycon on db410c and have sent a 
patch. Whenever you repitch boot-constraint, you can add that as well :)

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
