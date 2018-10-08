Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B438C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD01921479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZHddEGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD01921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJIEQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:16:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41906 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIEQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:16:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id l41-v6so9933402qtl.8;
        Mon, 08 Oct 2018 14:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKpC6wdeM4j4YaEODz6Iu3/eXkhlCF0kf5UMe1jidP4=;
        b=fZHddEGZssDOLdiF15rCsU8CSphmvtLy8nPpYnkCPIIq0waOYGUUGl/Racf2LnKExH
         k9z4A1yGl7fU6UO725A5eq0kMG/zll88YMEz98yJEviVyeqDI4VYtDmy+h9KgTcvamoB
         S0QS33N8hmU/L9k1Xz5V7K7KwAVkD0r5AojbLSMjx+cnVNuyNdQnaMZf4dPjU3c/CkrL
         JBGtyhDwAEoOm9TNna96kyAseZaxoxnCY74bB9Nowv33WCxtd+S9wqL9UYQR1rcLkvCZ
         qxGayn5oED3or2qD2oYRNa+rsahHruyDMU8McTQBpOBjaJbIR0bhq/Bbl8jJyP9kisX/
         btAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKpC6wdeM4j4YaEODz6Iu3/eXkhlCF0kf5UMe1jidP4=;
        b=IRitW+5aPSZnY/Gn89jyAB49dsy4/oyC4hD68y57GmLSg8NmMX3A7iCI2jL5Klozb9
         OYnGGxPUb1Cl6ktpGfDVKjNvcWV6J1wn3mh3TBndLqPSeS3uTFrubRoDYrEXtcn42klv
         rK4dDSacWhxVFfkZ9KDKQ37ACP2yWm1JnEHLBYBJ5/XRj02Y71ODZrck/DBdHBg/j9QN
         L0TtDinsexXU2Rchm3Nejwfp97K416TRFJlbuZCEHn9VVticy6U6OvTj7rkCkG1oilJV
         1vi8t7gNoynt8w9iO1N5yHJySSusfMHHClIo0pRrKtPusX2IbaoO32X9jdRl6kMkDQud
         FBrw==
X-Gm-Message-State: ABuFfohAO6XoolkbJENNapGdpSVxXJksUqyUknf8tMGw7EG2SjQmI5Eu
        5ytSY08wQLLCaKtvJ1diNKXNIJVHgNLpmlTzpUs=
X-Google-Smtp-Source: ACcGV6333+8jLjKdqCREsHCBPT9q1liJqKx1ZiBXD0hdLOLdjMbg+hzMd1vzd9pO7cYxpk7qvTvGAOwaOTMVmpW+ibA=
X-Received: by 2002:aed:3121:: with SMTP id 30-v6mr21424831qtg.180.1539032557946;
 Mon, 08 Oct 2018 14:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181008082259.26742-1-jolsa@kernel.org>
In-Reply-To: <20181008082259.26742-1-jolsa@kernel.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 8 Oct 2018 14:02:26 -0700
Message-ID: <CAPhsuW6x6dUExMdDR1togWCss6hHd5gbJROvs6HN_AoXWz0cmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpftool: Allow to add compiler flags via EXTRA_CFLAGS variable
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 1:24 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding EXTRA_CFLAGS allowing user to specify extra flags
> for CFLAGS variable.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/bpf/bpftool/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 74288a2197ab..5bfa07e3f2f7 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -46,6 +46,10 @@ CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
>         -I$(srctree)/tools/lib/bpf \
>         -I$(srctree)/tools/perf
>  CFLAGS += -DBPFTOOL_VERSION='"$(BPFTOOL_VERSION)"'
> +ifneq ($(EXTRA_CFLAGS),)
> +CFLAGS += $(EXTRA_CFLAGS)
> +endif
> +
>  LIBS = -lelf -lbfd -lopcodes $(LIBBPF)
>
>  INSTALL ?= install
> --
> 2.17.2
>
