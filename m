Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F9C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3332086B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHc7Ckk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3332086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbeHNXoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:44:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52180 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHNXoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:44:23 -0400
Received: by mail-it0-f66.google.com with SMTP id e14-v6so20336438itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6H28aX+Dw1yOLcG5aH6Uv0eym91ZuZ2780ZuzPEc1J4=;
        b=nHc7Ckk1g22uCUiFVfNE7jePot5HBv2iFpN5ldWuaEU7OZPCet6JLBmyxHGIx1h+rJ
         m9W6tq9SYOtUaCnoZLX3xrZMNpdTyemQBYSlXEPAFoeprLNOOnAMg20S/HNjDaHQr+W3
         vQbeM5xrjwk9nMl8pJbjmKFAGdQMlDTm2S6IcwZycsWlo34XwBQdI2Mwyu5NOtANq7nj
         SBzKWkwJ+QH71/kHLeKIPELya1BKVqseKXwLmKVjUTuBH/DnqQbzBDq+AzHkXcBFQh8I
         7XDz9z/0Zz2hji0bqE7vrtOb9oJrd4AEHS/sDFD9Tn/3Hw3coLjocfgRw3XP3XQ20Nir
         99Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6H28aX+Dw1yOLcG5aH6Uv0eym91ZuZ2780ZuzPEc1J4=;
        b=b7y0+k/55Bg9Z1BPbkGsiSRu1vTM/LE8Qw0OvPblH5Blvj2OVXRD1B9wvXCgSETx3i
         ug/b9RSzwN/A6AgzwzihsKZShF2WvYAuhfWsObyAqHka7r6xJ3Uwmt/64+LjLp9b9ye9
         vC+QS7dzid1GeNBxLV4fFVFvt3ogfJV7pV1j8S6Pe8bJbYCiDFl44R2elJaAT20TE0Rp
         Z7reLaU4zM6bm110a4KHDs4gXR8LRN23XYGdrFnZZUKUavok0zojg3aMjyVk5QsE5laN
         2e8yllo8I1c4W85Why2P/L0HWZj48Z9ldbKVlR/EJLg0xgBklLjndV55jCE12FdyjojV
         yTaw==
X-Gm-Message-State: AOUpUlHoEW1RAAFwiomMDkk+Nn8NmvCcFpnPrW7pFefiMGh3tnrAPpnx
        fqomLJuFyP/MQf6dC6bLgR1bjwTudc1Fl9U/rjRbuQ==
X-Google-Smtp-Source: AA+uWPzI6vqzj3jRJSCF14afVr3l26j7NQD95xrEisXAklt3n5r6QwICMykUNx3OnKEHHYXCem7H9H0rl8mvNKXqlS0=
X-Received: by 2002:a24:598f:: with SMTP id p137-v6mr16438388itb.5.1534280124342;
 Tue, 14 Aug 2018 13:55:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 13:55:23
 -0700 (PDT)
In-Reply-To: <CAGXu5jKqcpbpG0Ky4-yXV4d5q10HtGwJtdyPKcrwkJUPhA_Mpg@mail.gmail.com>
References: <20180813223910.26276-1-surenb@google.com> <20180814095413.vbjkcjkmytkffyaz@mwanda>
 <CAJuCfpF0Y6wc1z-rbn2wdWROgc_FkD2EX5HzDMcZ1oB5Z=dXSw@mail.gmail.com>
 <CAJuCfpHSZuabLr6+t_n7UDamJCAP6EPTNEZ6kNqWOhk2mpYADg@mail.gmail.com> <CAGXu5jKqcpbpG0Ky4-yXV4d5q10HtGwJtdyPKcrwkJUPhA_Mpg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 14 Aug 2018 13:55:23 -0700
Message-ID: <CAJuCfpEX69Sbd=0i0ismP6q2NsZGUF4gMSCr1G5NdXd3n1NyZA@mail.gmail.com>
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

On Tue, Aug 14, 2018 at 1:33 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Aug 14, 2018 at 1:26 PM, Suren Baghdasaryan <surenb@google.com> wrote:
>> On Tue, Aug 14, 2018 at 9:57 AM, Suren Baghdasaryan <surenb@google.com> wrote:
>>> On Tue, Aug 14, 2018 at 2:54 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>>> Thanks.  This is great.  I'm so glad these are finally getting fixed.
>>>>
>>>> Do we need to fix nfc_hci_msg_rx_work() and nfc_hci_recv_from_llc() as
>>>> well?  In nfc_hci_recv_from_llc() we allow pipe to be NFC_HCI_FRAGMENT
>>>> (0x7f) so that's one element beyond the end of the array and the
>>>> NFC_HCI_HCP_RESPONSE isn't checked.
>>>>
>>>> Also nci_hci_msg_rx_work() and nci_hci_data_received_cb() use
>>>> NCI_HCP_MSG_GET_PIPE() so those could be off by one.
>>>
>>> Good point. From hci.h:
>>>
>>> /*
>>>  * According to specification 102 622 chapter 4.4 Pipes,
>>>  * the pipe identifier is 7 bits long.
>>>  */
>>> #define NFC_HCI_MAX_PIPES 127
>>>
>>> And then:
>>>
>>> struct nfc_hci_dev {
>>>   ...
>>>   struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES];
>>>   ...
>>> }
>>>
>>> I think the correct fix would be to change it to:
>>>
>>>   struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES + 1];
>>>
>>> What do you think?
>>>
>>
>> Just to be clear, this would fix the problem Dan described in his
>> reply and it should be implemented in a separate patch. The original
>> fix is still valid.
>
> I think you could merge the fixes into a single patch.

Couple reasons I would prefer to keep them separate:
- I feel that descriptions for these two issues should be different
and it's easier if we don't mix them up
- This one is already merged into Android kernels, so would be easier
to introduce the second fix separately
- I would like to give credit to people who noticed the problem (in
this case those are different people)

However if more people think we should fix both issues in the same
patch I'll happily do that.
Thanks!

>
> -Kees
>
> --
> Kees Cook
> Pixel Security
