Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A163C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8112081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="li8gwx07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8112081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbeKFCR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:17:58 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:35046 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbeKFCRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:17:55 -0500
Received: by mail-io1-f48.google.com with SMTP id 79-v6so7017715iou.2;
        Mon, 05 Nov 2018 08:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhMZ5QwgCRzjvi5pZmc/QFkuLseDWK9Exg7+7ZsKiQ8=;
        b=li8gwx07sGdWZa8Ia4HF4+vloQlT2OBVZlcSvETJgUxZJUMOJ/n7RKPYHTY1dV347y
         dCJWtLiMlid+Vrq3H8elmd44yHDa4pjgeA799Y3vFuDJ8rCN2GQWgiODRv04FZ8Fzgz5
         ClRQn+rS4WbwQlUCiNJ3xwveZHThfcyVxg1ElwmKDzYt74ETPIrpJ0b+ccdz9w8poXLE
         +92hBOHKeG9rhJ9MjKnLHy3zfsx8nQuca0iCbyCiVkNZcDzDV8T65XXkKQVPjov68+y5
         eX03v0q4bn0q0I3pIsKEF/VCXo/zlOWnfX+GzQSd6SJ3pPEw8fOgymDm+oFh714DFv7p
         8+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhMZ5QwgCRzjvi5pZmc/QFkuLseDWK9Exg7+7ZsKiQ8=;
        b=GOkVdPw8o43+OZDSecQXwR+3I7ng+4Q76N0L8946CmVvfJJ5CI5qfv2fqjgWk0IdQ/
         deH4iF2jcQFNKNRcXDAq6oh5xWUofbR4ZMS4dT7IuY4BnI2rNZJtba/4TuqX1HYaoPS1
         vtaX+elKP+M9lo+9tkybu75TY8vIa01AdXtjWNWk4gf22YpRB8Ml4ckDOnTmkUONPfhE
         OQ1120ooe6hoDylqFoD88jgwhDgRaANWoaDEinilUrT+35YlgvBwYap8WksO/qE2EKQO
         towqO23GmnD4dNTyDAkoWQSgV1OPKyW62TCukFXHEEn5831ZP10Jrg8XMOS3pNNKKpgd
         ZFvg==
X-Gm-Message-State: AGRZ1gLpZ4TxV+rHRnJ2zkLCOOAbznRZ3su9r+jbtp5DbYb7dd2M6EsJ
        uNcD3+3LNdVyu8D6PPgzeazWjJycl7V73w8u+p0=
X-Google-Smtp-Source: AJdET5cHn1diG4YsRW9e/HYSkbbHwyZBMk7xQ8+jqVqcbjtIf3wL2xaB+dDT1zD+yzC5blDpU31O3BHHcmnIySVKxEY=
X-Received: by 2002:a6b:8f12:: with SMTP id r18-v6mr18936306iod.56.1541437040482;
 Mon, 05 Nov 2018 08:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20181019101758.1569-1-stefanb@linux.ibm.com>
In-Reply-To: <20181019101758.1569-1-stefanb@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 5 Nov 2018 08:57:09 -0800
Message-ID: <CAA9_cmfk5O74Hsek9sBRCg=B4+adC7hO4dkUXMw9mNHZ_dfrCw@mail.gmail.com>
Subject: Re: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
To:     stefanb@linux.ibm.com
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        Alexander.Levin@microsoft.com, jsnitsel@redhat.com,
        James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 3:19 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> Extend the documentation for trusted keys with documentation for how to
> set up a key for a TPM 2.0 so it can be used with a TPM 2.0 as well.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks for the updates:

Acked-by: Dan Williams <dan.j.williams@intel.com>
