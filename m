Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A067C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB2D2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RI9xdeFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB2D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeK1Rky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:40:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40249 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeK1Rkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:40:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so21113013edx.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ttGnbqrOXizJJR+07WyXPDAIfutG877DgO/P4anA6k=;
        b=RI9xdeFk7oWTOcbfmv6Bwb7BQK+mE/SFqG8r6zIBzBu19T2BXQEsl8ilxAPnKzdRSc
         NV/nZlUfu9ay0k5JH4rY0dhE3uFh4Rq2/2oSKgJMZBmWLtn/e4NLxj1qA0YIDw5LfgtH
         D/LsNlynuIFaQSx5iT9JcXLhkBuEVjs5w8sdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ttGnbqrOXizJJR+07WyXPDAIfutG877DgO/P4anA6k=;
        b=WivZojoPwNF41IPODtc6XHyNYqCIqP7XeYq4iXhbAsm9ZCIr2ZBZZscfv9DFvynMOB
         6EA0p68hXy19fqB7a5OfxIOXNQvnk5c9Rk8IlBIL3WCK6+N8KK12odOHsQblmNjoBhsI
         LV7LW3ScCGFbvwl9b69Fa5CnU+cfPuPmISFfhi8HcDRDLqJt0nYPPfe6Zjc40tMIllaS
         NIS+7z2MEXqX/N3prfV99sp+DFQlIbWaeOvqScUKpGJ+FlqP81mGg9BOP6UqVURkaOmS
         0f284aBsceQYd2qHSq1iZR5fOY8rL3BBM7JefT/TjsjzCO6BJqazlxccsRfWHq70us6D
         ZuUg==
X-Gm-Message-State: AA+aEWb1jQbzG0BvMvfv5KsGO9yz44PwZTV/8lut0E974i4poKY7sxet
        FOygAyTTLvMHLhQJ/9U5DUbhbdFs1JANBqzmGp4fCg==
X-Google-Smtp-Source: AFSGD/XJWRqmu5SzS5AcOIkSR5eXqbxXJ97ZkXyoSyMMLTimpOFji8N/lrs7FRoDULhtBBVp1x/eSVglxEYIpc2ArDo=
X-Received: by 2002:a17:906:c3c3:: with SMTP id cj3-v6mr12172570ejb.178.1543387218797;
 Tue, 27 Nov 2018 22:40:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543374820.git.gustavo@embeddedor.com> <073efb316d0acba28e6105fcd4f4d5deda2ff3f7.1543374820.git.gustavo@embeddedor.com>
In-Reply-To: <073efb316d0acba28e6105fcd4f4d5deda2ff3f7.1543374820.git.gustavo@embeddedor.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Wed, 28 Nov 2018 12:10:07 +0530
Message-ID: <CAL2rwxodKijDbDYEEDSn_CfdFZ3k1md7GbvoNM8Eu6SaZV=oXA@mail.gmail.com>
Subject: Re: [PATCH 29/41] scsi: megaraid: megaraid_sas_base: Mark expected
 switch fall-through
To:     gustavo@embeddedor.com
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        megaraidlinux.pdl@broadcom.com, jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:02 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index b7d3fc6fb118..9db7aebc3564 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -3281,6 +3281,7 @@ megasas_complete_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd,
>                         megasas_complete_int_cmd(instance, cmd);
>                         break;
>                 }
> +               /* fall through */
>
>         case MFI_CMD_LD_READ:
>         case MFI_CMD_LD_WRITE:
> --
> 2.17.1
>
