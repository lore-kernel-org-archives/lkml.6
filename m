Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5918C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E16B20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWcgtNmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E16B20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeKIQZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:25:10 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43351 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeKIQZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:25:10 -0500
Received: by mail-yb1-f195.google.com with SMTP id h187-v6so621668ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AP4Ewgs+5Jq7FQarioU1HN8Osr1pYvMNapI7hdcCNg4=;
        b=DWcgtNmT8rGocsWFkOpMejrJLbMyf1Y7pDx+/2PXesW8mQGP6qtgN77W0Aoiy2KuLQ
         1hRiGCYedDBKBV2P0999+3LblpLGEBJ6CHy4wHJIuOr2o+kod/ojFtc0ndkawN2WlaG4
         nBnhj1SfjeATdJyk4Q1gLAp6LjjQqHXn4pD3EpraSLvNsgFdvOcreRKqqcCEqoNZMGqs
         d75uCOBrUxHjnrOmnIFQ1HNCCCLI7elldBQ57QEcRfrLLMH7yyIWhSLnO9/B/7AROC/U
         6Ogwnvg5k9eP76nzHqtl6sXK68WMaYGJrBWSMkOkA+qqtx0YiV5MRJfuAXvcfiIY/9np
         YEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AP4Ewgs+5Jq7FQarioU1HN8Osr1pYvMNapI7hdcCNg4=;
        b=pPSRvcyI7cyBFYF16XDdTZeT10slt65pjRKWu8PoRurd+OfHp69go+RFdSMvnSpoP2
         4V1mrkIm9FXVvHpDubNQ3d29DqdiVFWOsKsIDrWiLmYD14T2Ow6LmeSOkKda38pA1JXj
         KqvizAL9fgY/I5UuWAPgF1E6l85Z+FWGI+NYUhERcwKEiq/gejNIcoFDkPqYPTbZZa7a
         XwJTHaTMtcC9tznD57/fj+Vuc+4vjR+fYNv/Q8cNvhFRmf0i9+61WBANql3nJohd5bpm
         SI/hwNtxuY/tdo+sANHURQ6BHEIExDzwW5R+m4ijYHudAJD5UIHspyGX7pCw9lHsvqqL
         gOag==
X-Gm-Message-State: AGRZ1gKC7xks3+QeFnjX1wTX7xWvXnYg1kjQRGjt64ZHlLo8DpltHazO
        sbNOyMHQEZbzib3W0oWmteuQNj/PVBzJZ97lH38=
X-Google-Smtp-Source: AJdET5dLzMlgik0OVeCVYO392rUxBqZ6N0wjnu0ZNhCv0enZpEiMTvupY8mYZUHjDeLmqp2seJsJs7skZQAS+ujEsdI=
X-Received: by 2002:a25:aa52:: with SMTP id s76-v6mr7416829ybi.405.1541745962101;
 Thu, 08 Nov 2018 22:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20181109031303.GA20906@altlinux.org> <20181109031551.GD21511@altlinux.org>
In-Reply-To: <20181109031551.GD21511@altlinux.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 8 Nov 2018 22:45:50 -0800
Message-ID: <CAMo8BfLFrYQk8ZE4W0SgGDceiJuh6bx52X5VnhfrFG53+ck4og@mail.gmail.com>
Subject: Re: [PATCH 04/13] elf-em.h: add EM_XTENSA
To:     Andrew Lutomirski <luto@kernel.org>,
        Chris Zankel <chris@zankel.net>, lineprinter@altlinux.org,
        linux-xtensa@linux-xtensa.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 7:15 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> The uapi/linux/audit.h header is going to use EM_XTENSA in order
> to define AUDIT_ARCH_XTENSA which is needed to implement
> syscall_get_arch() which in turn is required to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> The value for EM_XTENSA has been taken from
> http://www.sco.com/developers/gabi/2012-12-31/ch4.eheader.html
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  include/uapi/linux/elf-em.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
