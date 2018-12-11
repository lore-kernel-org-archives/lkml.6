Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E797C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04592086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FpnABF23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04592086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeLKXQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:16:44 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39397 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKXQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:16:42 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so9697856qkh.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46Nbr/qGAD9OMlEin27/aFadtS0XnpZ+RxosG/vtMXQ=;
        b=FpnABF230kRr9I203PvkeC7TeG2gCjezOhtvtgFZfqm2Rp8by9dSpnOS1xL78TSCr4
         Jh8kfsocW/wWhYLYdiLaWLp6CBrErvtTwhNsDWBXKMdxiRlVYPNuvOwYTiiy0eII4zyU
         CkpumoK9cc5y3WtTfCP+rIZqDLOu10Cm6WWpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46Nbr/qGAD9OMlEin27/aFadtS0XnpZ+RxosG/vtMXQ=;
        b=GsnV6gaMI6Gj9QB0aY/3sqxnaL0PHjFkZLoI7d3ggzt0PB3ug2FDa7IHC2JnHnker3
         AU2BJJsIHyNjyJtVP62XP7ClalsyKaibeCCpnR2Ahoq/z5q6ctDxaMyReION18fh9PEz
         wVpFhJX6NyULKVQQM6fdqCYSWb1XTszaRGmTaXaiSkzLAw2X8ayCkqbZLzzK0dLixIO+
         zDci03F+xkjB6pdoiGQsZ3RGd2JNsPxqCbzxOkeTPsHifGwzSwVfLcHxIssUk2EzULPQ
         l21A1ewSzcZtbhN+sGMkMe2MGOMF1ql04MrkWAhKUYU5BqBpKFEZQNGy4vvmPiWPnzXr
         QcjA==
X-Gm-Message-State: AA+aEWbEfBqLWqnPsMktCYrjEWubwEtFYvnbrZR1L20CBMX4cMVXXnpS
        JHR4tyF0ovgJ5r+kA7r4hFnkfryMhAc5N4RDzpkJeQ==
X-Google-Smtp-Source: AFSGD/W3yYRH90WifwI+FKEvR7l5Bas4hlTVuWRpadKQ+IBsgvK3GjxvREB73+npNdHWNhXDUIKeAC881fIhRmNx6qk=
X-Received: by 2002:a37:291:: with SMTP id v17mr16329531qkg.208.1544570201794;
 Tue, 11 Dec 2018 15:16:41 -0800 (PST)
MIME-Version: 1.0
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me> <b7b26a7a-70be-d805-ee64-67fba0b4efa8@mellanox.com>
 <CAJX3Cti_ZJF5E+NRuRzSeEUgaXsbA2U9C+Rh5OdYd4EMwXC1gw@mail.gmail.com> <773bb91f-40a4-a525-f7b8-db821b402821@mellanox.com>
In-Reply-To: <773bb91f-40a4-a525-f7b8-db821b402821@mellanox.com>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Tue, 11 Dec 2018 15:16:30 -0800
Message-ID: <CAJX3Ctjtt2zebuLfzKM30PV1x3fm8HaJJFJw3zZSOShWnQnu=Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-rdma: complete requests from ->timeout
To:     nitzanc@mellanox.com
Cc:     sagi@grimberg.me, keith.busch@intel.com, axboe@fb.com, hch@lst.de,
        Roland Dreier <roland@purestorage.com>,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Ashish Karkare <ashishk@purestorage.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot reproduce the bug with the patch; in my failure scenarios, it
seems that completing the request on errors in nvme_rdma_send_done
makes __nvme_submit_sync_cmd to be unblocked. Also, I think this is
safe from the double completions.

However, it seems that nvme_rdma_timeout code is still not free from
the double completion problem. So, it looks promising to me if you
could separate out the nvme_rdma_wr_error handling code as a new
patch.
On Tue, Dec 11, 2018 at 1:14 AM Nitzan Carmi <nitzanc@mellanox.com> wrote:
>
> I was just in the middle of sending this to upstream when I saw your
> mail, and thought too that it addresses the same bug, although I see a
> little different call trace than yours.
>
> I would be happy if you can verify that this patch works for you too,
> and we can push it to upstream.
>
> On 11/12/2018 01:40, Jaesoo Lee wrote:
> > It seems that your patch is addressing the same bug. I will see if
> > that works for our failure scenarios.
> >
> > Why don't you make it upstream?
> >
> > On Sun, Dec 9, 2018 at 6:22 AM Nitzan Carmi <nitzanc@mellanox.com> wrote:
> >>
> >> Hi,
> >> We encountered similar issue.
> >> I think that the problem is that error_recovery might not even be
> >> queued, in case we're in DELETING state (or CONNECTING state, for that
> >> matter), because we cannot move from those states to RESETTING.
> >>
> >> We prepared some patches which handle completions in case such scenario
> >> happens (which, in fact, might happen in numerous error flows).
> >>
> >> Does it solve your problem?
> >> Nitzan.
> >>
> >>
> >> On 30/11/2018 03:30, Sagi Grimberg wrote:
> >>>
> >>>> This does not hold at least for NVMe RDMA host driver. An example
> >>>> scenario
> >>>> is when the RDMA connection is gone while the controller is being
> >>>> deleted.
> >>>> In this case, the nvmf_reg_write32() for sending shutdown admin
> >>>> command by
> >>>> the delete_work could be hung forever if the command is not completed by
> >>>> the timeout handler.
> >>>
> >>> If the queue is gone, this means that the queue has already flushed and
> >>> any commands that were inflight has completed with a flush error
> >>> completion...
> >>>
> >>> Can you describe the scenario that caused this hang? When has the
> >>> queue became "gone" and when did the shutdown command execute?
> >>>
> >>> _______________________________________________
> >>> Linux-nvme mailing list
> >>> Linux-nvme@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-nvme
