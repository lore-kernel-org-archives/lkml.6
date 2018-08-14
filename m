Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B67C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5A221725
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9ScD+jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5A221725
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeHNXO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:14:57 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52227 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeHNXO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:14:57 -0400
Received: by mail-it0-f65.google.com with SMTP id d9-v6so20207671itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B9RvVddNPXgtV/yWfg+5t5dhMdXeZXmBSQWTUID639g=;
        b=A9ScD+jbD/IC4RPbGaerE36A3gEnILiXAF2MKZ0+iqLfOmM7H2HDL2P9Kph42ie7pD
         6hb1c2C8fsM2m6IuaEcIbmw2ELxXIl1TBo5gCssZJdyK06xk/L/plBhk3ICFqPz3m0VB
         IrPiclsiVOBKC+II13V3J8tLYdYUfjl46+mfDZWq5M36vM8bMCTb2HFrzMZ1LXQI+Njs
         seskBq7u3qxBQ6l5f1lKDknr7TOvpsbK/Edit1ImJbSZNJvOxCaGsiB0K8l/t68FdQTt
         UUSR2ljYoCaSETcmHelzPP/4mCW0dvf32x41BpwncwfqHsJXS9oV0w6NSPmBdRNyQJsF
         A/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B9RvVddNPXgtV/yWfg+5t5dhMdXeZXmBSQWTUID639g=;
        b=bX9s/1Ck+wmry7vAVpjrZHhInDpkiRAqVp0+PPJ33NYAiwJwu5R9tkgx/YHXVQEVhH
         wALFcs4OWHzDKLpf868tQ0ujkFllYaEa39TFXcvdxROyFzQssJO7T4PKEq8rJdU7cMx9
         p6XVL+sG6kaNaSiraNOahmrHiz/Xl7ATR6gqfBQrV2oyqjDE4m8SeL4oidbbiYxLTp+L
         /z+egUyVKfqDCvtLryD1wBsZLVTIivbeJAVbZ2F2BfAvuE2IhutXrxVVQGJ6Dn7AJkG7
         5x6biRNukL8Hw/zb5H6zszFlP4LIiOJmiGHzG1AYoyz4fTWFk/ODCFdmKzk53bWJdRJm
         EL7A==
X-Gm-Message-State: AOUpUlG5IVDL/Hd7uTuxIK39A/r1obv6dUlqNBY+6i4EuNPPHHoeVCUw
        OWOlp8/9AvODeqXqUNMc9ih4dEfckqq3RPaqR9PmWw==
X-Google-Smtp-Source: AA+uWPx5I9Yvf2I9Y+uWnoowouVt0ImxJnAXqj+24ilLHUqTJy2fgKjX8CIvMe+Ey61Yey0QzYJ1li+5IYjCskCttAg=
X-Received: by 2002:a02:5c07:: with SMTP id q7-v6mr19713710jab.124.1534278365109;
 Tue, 14 Aug 2018 13:26:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 13:26:04
 -0700 (PDT)
In-Reply-To: <CAJuCfpF0Y6wc1z-rbn2wdWROgc_FkD2EX5HzDMcZ1oB5Z=dXSw@mail.gmail.com>
References: <20180813223910.26276-1-surenb@google.com> <20180814095413.vbjkcjkmytkffyaz@mwanda>
 <CAJuCfpF0Y6wc1z-rbn2wdWROgc_FkD2EX5HzDMcZ1oB5Z=dXSw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 14 Aug 2018 13:26:04 -0700
Message-ID: <CAJuCfpHSZuabLr6+t_n7UDamJCAP6EPTNEZ6kNqWOhk2mpYADg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFC: Fix possible memory corruption when handling
 SHDLC I-Frame commands
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     security@kernel.org, Kevin Deus <kdeus@google.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allen Pais <allen.pais@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 9:57 AM, Suren Baghdasaryan <surenb@google.com> wrote:
> On Tue, Aug 14, 2018 at 2:54 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> Thanks.  This is great.  I'm so glad these are finally getting fixed.
>>
>> Do we need to fix nfc_hci_msg_rx_work() and nfc_hci_recv_from_llc() as
>> well?  In nfc_hci_recv_from_llc() we allow pipe to be NFC_HCI_FRAGMENT
>> (0x7f) so that's one element beyond the end of the array and the
>> NFC_HCI_HCP_RESPONSE isn't checked.
>>
>> Also nci_hci_msg_rx_work() and nci_hci_data_received_cb() use
>> NCI_HCP_MSG_GET_PIPE() so those could be off by one.
>
> Good point. From hci.h:
>
> /*
>  * According to specification 102 622 chapter 4.4 Pipes,
>  * the pipe identifier is 7 bits long.
>  */
> #define NFC_HCI_MAX_PIPES 127
>
> And then:
>
> struct nfc_hci_dev {
>   ...
>   struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES];
>   ...
> }
>
> I think the correct fix would be to change it to:
>
>   struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES + 1];
>
> What do you think?
>

Just to be clear, this would fix the problem Dan described in his
reply and it should be implemented in a separate patch. The original
fix is still valid.

>>
>> regards,
>> dan carpenter
>>
