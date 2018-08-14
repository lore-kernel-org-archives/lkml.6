Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D2EC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F76421715
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/ADQESF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F76421715
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbeHOBIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:08:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53041 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeHOBIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:08:31 -0400
Received: by mail-it0-f68.google.com with SMTP id d9-v6so20679590itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/8yrARMpDkSLXhT38ZLoTuIbOEs11/Hkexya1itX7ZQ=;
        b=n/ADQESFa0SRcRQGLQQwu6qDJ/4oNVlE7IcvehMz6ZuD7foz0HcSZgJbnGLazvmSl3
         79lH/MyWjfoShEcLOVoIW4ikMFklcIqNlqqMCC1EhZ7nNZcbHg31DN6p2fzsARL4gMl4
         vQfrjQNYfNdCiYPtQGt6VjK+OwIrT2e5ZprYf/C8kxALuWJI65AmjoKqlH/B2Udfq8CM
         znofuqY6zOwoOEP+IlES80Icx+tw/8zXVLYywvAMQb7w+zBBflylBu0JEZlclz/yRawO
         Psosj8OPyH9glf9VQz4VPTkoRRVAowIQGQkdu0spN2c/pK9n4Db48wbM6ixyvJNNtpPa
         NkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/8yrARMpDkSLXhT38ZLoTuIbOEs11/Hkexya1itX7ZQ=;
        b=GDy1qcCykXY4a+MtlAqV5Asz+TV7bFnIl9841qKEyBaGX3tjGcejWFAowR24aDZeGe
         RjfzT+uBmrBXW95xI/2Fg/p+G9lNcTjtGLViN78u3HWLKE+takgxWxw/4jZkVityRSyB
         xnFIZteTsPooqYLJ2E47XAe4qhUvgyAvJrfJrcqAfbvu2S5WZiok3PMTDp+SEr6JfLwS
         ICQJEmHNL2Zna/kPqdbrG8Bn5h02Ns0uSQTBfZSq7rpTxMDP6paEMhbQlzWGTFIq56/r
         o7h7lCdcZBJOdf0RUyegVxgrVbzsu37HRdrz6AHMsbUzzNlNh+1qOHF4BTt1DSC0EZCI
         9Bpw==
X-Gm-Message-State: AOUpUlHLVqgZphlWtyXHyG2/jb31O9skwghFB8+SgY/1xfVfhuGt//8q
        Th5a7poccudsn6JRdezm8UAN026L7QNFl93lOXIAdQ==
X-Google-Smtp-Source: AA+uWPwcUvtQHJ6xHZUB+4zn4Obryl3ARfRUz8qQDU70qG8RpZUj4DxmSqprg6jHRLpWSQ1S19Y/eX2PfEwm3peQUZU=
X-Received: by 2002:a02:6a2f:: with SMTP id l47-v6mr20743030jac.71.1534285154833;
 Tue, 14 Aug 2018 15:19:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 15:19:14
 -0700 (PDT)
In-Reply-To: <CAGXu5jJB9wMDJnfsurpxsXm6_0WsWWCaTuWBfy+3aMSE_LL9Rw@mail.gmail.com>
References: <20180813223910.26276-1-surenb@google.com> <20180814095413.vbjkcjkmytkffyaz@mwanda>
 <CAJuCfpF0Y6wc1z-rbn2wdWROgc_FkD2EX5HzDMcZ1oB5Z=dXSw@mail.gmail.com>
 <CAJuCfpHSZuabLr6+t_n7UDamJCAP6EPTNEZ6kNqWOhk2mpYADg@mail.gmail.com>
 <CAGXu5jKqcpbpG0Ky4-yXV4d5q10HtGwJtdyPKcrwkJUPhA_Mpg@mail.gmail.com>
 <CAJuCfpEX69Sbd=0i0ismP6q2NsZGUF4gMSCr1G5NdXd3n1NyZA@mail.gmail.com> <CAGXu5jJB9wMDJnfsurpxsXm6_0WsWWCaTuWBfy+3aMSE_LL9Rw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 14 Aug 2018 15:19:14 -0700
Message-ID: <CAJuCfpEX+F-EPxQYXNdUg-uT9ecwYYdxBsr9y_69zQ0Fq50GeA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFC: Fix possible memory corruption when handling
 SHDLC I-Frame commands
To:     Kees Cook <keescook@chromium.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Security Officers <security@kernel.org>,
        Kevin Deus <kdeus@google.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allen Pais <allen.pais@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 2:49 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Aug 14, 2018 at 1:55 PM, Suren Baghdasaryan <surenb@google.com> wrote:
>> On Tue, Aug 14, 2018 at 1:33 PM, Kees Cook <keescook@chromium.org> wrote:
>>> On Tue, Aug 14, 2018 at 1:26 PM, Suren Baghdasaryan <surenb@google.com> wrote:
>>>> On Tue, Aug 14, 2018 at 9:57 AM, Suren Baghdasaryan <surenb@google.com> wrote:
>>>>> On Tue, Aug 14, 2018 at 2:54 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>>>>> Thanks.  This is great.  I'm so glad these are finally getting fixed.
>>>>>>
>>>>>> Do we need to fix nfc_hci_msg_rx_work() and nfc_hci_recv_from_llc() as
>>>>>> well?  In nfc_hci_recv_from_llc() we allow pipe to be NFC_HCI_FRAGMENT
>>>>>> (0x7f) so that's one element beyond the end of the array and the
>>>>>> NFC_HCI_HCP_RESPONSE isn't checked.
>>>>>>
>>>>>> Also nci_hci_msg_rx_work() and nci_hci_data_received_cb() use
>>>>>> NCI_HCP_MSG_GET_PIPE() so those could be off by one.
>>>>>
>>>>> Good point. From hci.h:
>>>>>
>>>>> /*
>>>>>  * According to specification 102 622 chapter 4.4 Pipes,
>>>>>  * the pipe identifier is 7 bits long.
>>>>>  */
>>>>> #define NFC_HCI_MAX_PIPES 127
>>>>>
>>>>> And then:
>>>>>
>>>>> struct nfc_hci_dev {
>>>>>   ...
>>>>>   struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES];
>>>>>   ...
>>>>> }
>>>>>
>>>>> I think the correct fix would be to change it to:
>>>>>
>>>>>   struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES + 1];
>>>>>
>>>>> What do you think?
>>>>>

Actually, after looking more closely, NFC_HCI_MAX_PIPES is always used
as the number of supported pipes and not as the max pipe ID, so the
right fix would be:

-#define NFC_HCI_MAX_PIPES 127
+#define NFC_HCI_MAX_PIPES 128

I would prefer to rename it into NFC_HCI_PIPE_COUNT but don't want to
introduce unnecessary churn for one-line change, so will keep the
name. Will post a separate fix for this shortly.

>>>>
>>>> Just to be clear, this would fix the problem Dan described in his
>>>> reply and it should be implemented in a separate patch. The original
>>>> fix is still valid.
>>>
>>> I think you could merge the fixes into a single patch.
>>
>> Couple reasons I would prefer to keep them separate:
>> - I feel that descriptions for these two issues should be different
>> and it's easier if we don't mix them up
>> - This one is already merged into Android kernels, so would be easier
>> to introduce the second fix separately
>> - I would like to give credit to people who noticed the problem (in
>> this case those are different people)
>>
>> However if more people think we should fix both issues in the same
>> patch I'll happily do that.
>> Thanks!
>
> If it's already landed separately somewhere else, then yeah, 2 patches
> sounds good. No objection either way from me!
>
> -Kees
>
> --
> Kees Cook
> Pixel Security
