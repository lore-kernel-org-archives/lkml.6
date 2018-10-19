Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7482EECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1395621476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF0HYS+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1395621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeJSRwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:52:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52528 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeJSRwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:52:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so2991802wmw.2;
        Fri, 19 Oct 2018 02:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22PqOxkjkyf0lthBa164ysgWoipsUGHbllR79QfBODQ=;
        b=aF0HYS+XDa35IDtvI/WBekxVEJM1uzphFMR+9aOyMjWjCTfGlLkzWPlkRHg0URO8ks
         LkGdfqzNBLrDo1wmH1RtiKnrJxiQ1VpmGevhuXtfckillTJn+c43oG6HAbGUJYXobWha
         jNxWopZWtFSNZd8NAEvH47wt+BbLXCgdwSdbKpK44lywbyzplui/40uOgOpyOIAPKrMg
         ZjkYAG4pOwFQtTkyTzMtBsrhJVhmSWPO2gjL1D+cTAzGWrwJpB6JaUPjpg8FRySBJ9S7
         rP4WF/ZZW7O5WC5Dojq/nNfdizy1Ipt4/Rb/iHpR9OdHLKqIo7ncqhTOfVBP+2TZGIRv
         ttsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22PqOxkjkyf0lthBa164ysgWoipsUGHbllR79QfBODQ=;
        b=qlV2EBV8YtoaejmPsKDRfN1XSRQQUTW9PsHSGHkSUcD2Wxxv35Tzh7a1F1ghv0Ag1I
         3bgdeVheVL8Qy6348N/JPVDhmNVmL6jVq80ar/kG03+ScQC99IsTgoN8EbTpGWNr9WYf
         y3LBpdsYTahY+Bmg53oELEnLDkrkDOstWV3OIOU2QlYUvH7lY4Z1K0zJmE3g8m+WseGF
         deR+Vr6qiwYSLNEMT9eZrfLYxPNqjTxojOQLDQ4334kyt9viEQ2IW6RJYbOJppinMMXr
         BZOCckbYMNAafrsAyQzKi8hxigOsMBF6/zC8vT0FeEvruObPJK66pbkMJvfGzVFwq6a0
         bKEA==
X-Gm-Message-State: ABuFfohOLw4d6bxMuxqEFYxNhr9H3HTOrGhv7MT3jQ9vMGCp5gRuWPlB
        uYbEvdcMzvanwpRR3CRTimeUMpT8THJjP9KR7DiLFg==
X-Google-Smtp-Source: ACcGV62adUg+8VIUjhoNr5UVsxExf4ond8f1yQctoBaCPTl5Ro3nnnOhvZsKSnDdhzqeSZkVQX2W53k7jtJUMhH1LFo=
X-Received: by 2002:a1c:1dc8:: with SMTP id d191-v6mr3994138wmd.27.1539942408214;
 Fri, 19 Oct 2018 02:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 19 Oct 2018 17:46:35 +0800
Message-ID: <CACVXFVO_vDrwGbv0gOOhcYsRFfDhiawfX6Myvgxeht5B_P54TA@mail.gmail.com>
Subject: Re: [PATCH] block: don't check position contiguity for DISCARD in attempt_merge
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 5:23 PM Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
>
> Discard command supports multiple ranges of blocks, so needn't
> checking position contiguity when merging. Let's do the same thing
> in attempt_merge as the blk_try_merge.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-merge.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 42a4674..c94749b 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -732,9 +732,10 @@ static struct request *attempt_merge(struct request_queue *q,
>                 return NULL;
>
>         /*
> -        * not contiguous
> +        * not contiguous, except for DISCARD
>          */
> -       if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
> +       if ((req_op(req) != REQ_OP_DISCARD) &&
> +           (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next)))
>                 return NULL;
>
>         if (rq_data_dir(req) != rq_data_dir(next)
> --
> 2.7.4
>
Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
