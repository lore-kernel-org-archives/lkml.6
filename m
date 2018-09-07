Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DA9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43822075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eGBN41G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43822075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeIGVHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:07:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35542 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeIGVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:07:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7-v6so7257320pgf.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wQOpuBlnqGSyJKB/72RCH98mGMvJ+WwVyGPsfZkXeGA=;
        b=eGBN41G7WNPI+a8bI+1Lw2hdZNREfZ4a9KMpzqcRUueVkryutOccey4UzkQhLLxM/A
         JZ3vFQixcW/pMxhxnNcpbZhFl/yLFKaxfxD4JJMPyPD2MGr5/g6Li7n5eDtzM7UE6tsW
         jIEdiGVWC7gWlyZKbWHvCzlP9fwGzHMaq5eXOWxAAoqSS/MEPi4+p8CBeHY+X7buFLr9
         P2wi3AeYNgS1Bh0rPacYd6ii8WFBE0cvmhOzXAxjbLze3A9EqJCxOfObC/5eC6CKAb0x
         oDOVIvbknUa6Nx/LsvZq1jcrKIL2QIalo27++hJKgZfb4nBmGKtUyWfNQY4JfHjeRijX
         iYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wQOpuBlnqGSyJKB/72RCH98mGMvJ+WwVyGPsfZkXeGA=;
        b=JvyB/+jNXmh1VE0DzBRqX+WIE6JGGTrS4TjlZSJMFcLFulNnczNYP847Ytftkjiff4
         SzbBBl+N04N4ZzU4Cqk+qQ5PsxcapGKFm8MBJYIwEvVD1vlmd6mX9Me5fecDHWYhhrqW
         eZvlSoWqsbIuRtaxQKLJEuBd61OXuheFsauAjwGlhteXQjf6n6viV79gSaIBGzJHSHzc
         rxzTtNqqSKNwxU/YolXkK08koKaijUuXo56noHOuG9yCM9tLvb/QvA5SM4FYO6Oz9oLZ
         /Gmn0gINg4D+wncgkYB2TRhA6Grb0T901Afy9EO9ekGHL8FkFHvMudK0jl6ezBlqMn8/
         Zvew==
X-Gm-Message-State: APzg51ApWPtOKxhJrbZL76r0v39gTkyideaAhv1zEIV+UP7vlIdlkNDf
        YGIR3KSwXOweca/ztfQ1ykyRaKAuq/hahvUohidzKg==
X-Google-Smtp-Source: ANB0VdaOcs4JTsHFA9j5I0R5vgXB7/hT3wUuh3wuyYFJzDjOv0cidMUtTVyHprAVpMwBgYJhwbTwWiTb9WKMpT7UK1M=
X-Received: by 2002:a63:5c5d:: with SMTP id n29-v6mr9210733pgm.253.1536337539315;
 Fri, 07 Sep 2018 09:25:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 7 Sep 2018 09:25:18
 -0700 (PDT)
In-Reply-To: <7c37c201-8bca-ffa4-5e8d-5e0b4b268b3f@kernel.org>
References: <CACT4Y+Ywimrr3_oD2r=u0-Sz-PFXL2tpXA4q0odKDMM_Tvw0AA@mail.gmail.com>
 <8e8f8ac1-8b72-a21c-f504-74a5ce12b625@kernel.org> <CACT4Y+bJ+o7yLcPwQRbsD4_Ye_SsXe3GfmiozVJ-8w-4asyxbQ@mail.gmail.com>
 <7c37c201-8bca-ffa4-5e8d-5e0b4b268b3f@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 7 Sep 2018 18:25:18 +0200
Message-ID: <CACT4Y+ZV2aMWjobgV=-aUdSLnGU=_2yuf2TOx4TD8ApoVqRVYw@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in vudc_probe
To:     Shuah Khan <shuah@kernel.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 6:20 PM, Shuah Khan <shuah@kernel.org> wrote:
> On 09/07/2018 10:14 AM, Dmitry Vyukov wrote:
>> On Fri, Sep 7, 2018 at 6:03 PM, Shuah Khan <shuah@kernel.org> wrote:
>>> Hi Dmitry,
>>>
>>> On 09/07/2018 04:54 AM, Dmitry Vyukov wrote:
>>>> Hi,
>>>>
>>>> I am getting the following error while booting kernel on upstream
>>>> commit a49a9dcce802b3651013f659813df1361d306172, config is attached.
>>>> Seems there is some kind of resource leak.
>>>>
>>>> Thanks
>>>
>>> Odd. This commit has nothing to do with vudc.
>>
>> This is not the guilty commit, I just described state of my tree.
>>
>
> Can you send me the full dmesg?

Here it is:

https://gist.githubusercontent.com/dvyukov/e9dec59fb23da9cedd8ab07a7d8c78ae/raw/3ee13c7a1f406c9927ca3b16db262f2c78e84536/gistfile1.txt
