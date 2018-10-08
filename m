Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9ACC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD8C213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwEIr2Au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD8C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJIAPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:15:53 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:37437 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJIAPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:15:52 -0400
Received: by mail-it1-f179.google.com with SMTP id e74-v6so12919330ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IJnAXTwJtHHGxB5Rffg5YpaYYGzGa22HFHtgCjlppV8=;
        b=RwEIr2AuY0DUtFUZv0a9h2HWGchMj99hQtoSbrNOYvKSkwnHTmdKqT27oQ7ydymPIl
         ONTLT0X3go5E71HUic/zkdZdzJ5ITBNW0OV4/DKxjlGKjjFK5NV+66+NLNaTB7f8bbdf
         cfT0D10by1rqfNJBs9rnOBYI00u/nRM+1Pc0Nn6CcUJVgr9WdNwyWHgV1PzCdBiMixjx
         FbBLDZoM+z6IfG/I0GXI2bOljU3140vBq1DlbNnK+nK4FFGCswMMR2nRint2tKtOuTWm
         rJwgYmiCCzd1iZ/wEOQqpL1VPfqvOQW1SH39WnIEWq0TFBOL7bX0HwGQ47l7nmgxTdlL
         TXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IJnAXTwJtHHGxB5Rffg5YpaYYGzGa22HFHtgCjlppV8=;
        b=jD2BdgMsj7Vix8wtL5A0iFe32UBzIle57crTGyBPu2TRwqoyjXJsFLkBqeCEPvySek
         DTYnHNmqDp3mSnKMuFPn3AmB/MbKtet5ZiyIyUdolM1PcmZwX4ZlNsJXsfWfQjGAlhac
         c1q3lYik+FttG+tIaGFhVWWysnmPrKlLU9CikGWNqGCeBUED+Xf/+1axWLyiIEH5o5LR
         VOFx8PdDyIVizk0yjPdcHocHeMRvKGkvzSipFSgZqHYwChC8QV5SmgB2fysikTqXw8Pq
         2vbGPIxZesyxrxdDH/qvI1GA6DkyDKVoIjNAH2P5vqz7AW+OWRdb5TX6oDgx8SR9XyIr
         GBIA==
X-Gm-Message-State: ABuFfoj1RhRWs0CR36qlF9V9+xROvnjArGwfCZenu6dR57nPRIiccy+K
        DX4adLi3nTef+0qn/+w8Z2bK7mkwzr/f4D6ze7tUhg==
X-Google-Smtp-Source: ACcGV60EtGK88j7YZLCWpnaMhWfbo7446aNH41aKIKbo2ZBibRTXd7RWTtQfPcK7KfNaK9raW03Fr0vB3kdoLgUE6zc=
X-Received: by 2002:a02:97c5:: with SMTP id v5-v6mr18045877jaj.72.1539018192114;
 Mon, 08 Oct 2018 10:03:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 10:02:51 -0700 (PDT)
In-Reply-To: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 Oct 2018 19:02:51 +0200
Message-ID: <CACT4Y+Y+6arxj4=72DZSj45u5kjKRksJZ7c6pBLeFDxUSBFwOg@mail.gmail.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
To:     Dhaval Giani <dhaval.giani@gmail.com>
Cc:     Sasha Levin <alexander.levin@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 7:13 PM, Dhaval Giani <dhaval.giani@gmail.com> wrote:
> Hi folks,
>
> Sasha and I are pleased to announce the Testing and Fuzzing track at
> LPC [ 1 ]. We are planning to continue the discussions from last
> year's microconference [2]. Many discussions from the Automated
> Testing Summit [3] will also continue, and a final agenda will come up
> only soon after that.
>
> Suggested Topics
>
> - Syzbot/syzkaller
> - ATS
> - Distro/stable testing
> - kernelci
> - kernelci auto bisection
> - Unit testing framework
>
> We look forward to other interesting topics for this microconference
> as a reply to this email.

Hi Dhaval and Sasha,

My syzbot talk wasn't accepted to main track, so I would like to do
more or less full-fledged talk on the microconf. Is it possible?

Thanks
