Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22311C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA4F2172F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jBM17P6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA4F2172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbeHNTp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:45:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40536 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732465AbeHNTp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:45:26 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so20686308ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XW/qdLx81kG+t6Db/Kq3x2qi5y4ij97R7JfflIoloHg=;
        b=jBM17P6b2vFcZtvVoqDsAJYUbgPN2RzkEMwkjrBRUtTdnPbU2v4q7J7Mg1LnUrc4NA
         5b4XjdiR/TnnboMGvN2d6N0u+EaUXrountTAdonVLq6+z1vGkteknpDuCsMs5HG7joGK
         IgLOyo7fOXqAUGESkJGFRo2J6+NyxJOXVsV/kV2HrCDDnsKmlt/60yvcuB07tI+Ew0FJ
         Gh5cRKPAIHBgJU/5QcbtbRDPNdIySLLHCfCuq5aWPf1EOmjl3b4pdiO9c34JTJBnutB7
         ZFLekEEokE1tvWgrcfs+05Gyyujg//BZYU9YmnmKWliNPycR5tH/V0tlaUSUwjaaar2i
         IhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XW/qdLx81kG+t6Db/Kq3x2qi5y4ij97R7JfflIoloHg=;
        b=t9xlQvE07cEKbRNvGqEQOrbo8kge+yGivbMNmHs17iMidilbGdSXWDw2JgFRkxBgp4
         BfGYRN9jRiVqCB5hzZWyN1ki5gbEkAtx1b7YQa/1r5Vd3Rh5FulOeB+UxjCrGyXxbXbW
         HHaft0Scwowv/bVh1eargtigK1Cx9kg3NxvXTAIEAhBqKoM09oAah9q/uv/jajfVVFPC
         psEVbTV1brlnhKCw/ceZqy8NDnMKz11R5so0NXi8Ko/Osqqcb7jwP8YenG9TgE4PcqKx
         IFUFTF0o8apo5ZtbSt1sWne3GvGzIaAHFWjAm6CcNVKjPkA1WvkQf4dEE1Nj+3jHig1u
         Yetw==
X-Gm-Message-State: AOUpUlFq1eLeu4Eh3dhFtt718iWBmxef75TL/C46XEWQBksAoTFPrGcH
        MlWw3R8mCf9oe/uUTanBRjQF5CNyG24aeto3Q0bGqw==
X-Google-Smtp-Source: AA+uWPw160n6GQgEvngZIxWhYFOGq68uVKnmg2X9xxV5Os8BqAuw1GszmkXJdX7odc0z3il4uz9PQa8XCIuDLTG/LDs=
X-Received: by 2002:a02:5c07:: with SMTP id q7-v6mr19075349jab.124.1534265848474;
 Tue, 14 Aug 2018 09:57:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 09:57:27
 -0700 (PDT)
In-Reply-To: <20180814095413.vbjkcjkmytkffyaz@mwanda>
References: <20180813223910.26276-1-surenb@google.com> <20180814095413.vbjkcjkmytkffyaz@mwanda>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 14 Aug 2018 09:57:27 -0700
Message-ID: <CAJuCfpF0Y6wc1z-rbn2wdWROgc_FkD2EX5HzDMcZ1oB5Z=dXSw@mail.gmail.com>
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

On Tue, Aug 14, 2018 at 2:54 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Thanks.  This is great.  I'm so glad these are finally getting fixed.
>
> Do we need to fix nfc_hci_msg_rx_work() and nfc_hci_recv_from_llc() as
> well?  In nfc_hci_recv_from_llc() we allow pipe to be NFC_HCI_FRAGMENT
> (0x7f) so that's one element beyond the end of the array and the
> NFC_HCI_HCP_RESPONSE isn't checked.
>
> Also nci_hci_msg_rx_work() and nci_hci_data_received_cb() use
> NCI_HCP_MSG_GET_PIPE() so those could be off by one.

Good point. From hci.h:

/*
 * According to specification 102 622 chapter 4.4 Pipes,
 * the pipe identifier is 7 bits long.
 */
#define NFC_HCI_MAX_PIPES 127

And then:

struct nfc_hci_dev {
  ...
  struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES];
  ...
}

I think the correct fix would be to change it to:

  struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES + 1];

What do you think?

>
> regards,
> dan carpenter
>
