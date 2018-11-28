Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FF4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CF82081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CuzeBCnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CF82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeK1Rl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:41:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37212 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeK1Rl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:41:58 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so21136181edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMak6gSU4QBF+67dl6Q8Cvek028+sfDvM2KmYpnwG0E=;
        b=CuzeBCnH11yUpn5AG+igin5sw0n5DVNQgNbzxJ7wVT0IXfEQSp6NEZ2Ktg/c1bjqzO
         tosu4LlGJsn4e5RKVHaWaD5AwedK2lKsbir9dBjsuji0A5krciAMFMzpmlv0nkcOtsaZ
         iDBR4urmcJdsIKUv4fdBNpdd7c3DdhYQlLOZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMak6gSU4QBF+67dl6Q8Cvek028+sfDvM2KmYpnwG0E=;
        b=Ot6XyoQiomqaLW9vAkg6Vd7TwmEXmYee/pJszTmyTCzV6wzOlPjuwnVH7kwNsQCZOw
         lgInQE59w/7w1cA0fuzWWgOzYpO9aRxNJKX6dRVCSxKD2RtqCxd7w8P9smvZb51vqWDA
         KMcs9MUbqnmq4OR88yRi07Pe0G/+lsJjzus15mAQtG6+Ix+wjy57ycX4VshjaCzylqWn
         MZkjhjoDctSI+gtS+15iAs2VkDr00bb0Ie4kZyf1jl2v1CaEWZmK7cRGVl8UtUvWVH8I
         +8/WQbw6k7qjHvuJXjE2yY7StOSiJYj+P+yM2Vf3aZf1XwTr+yTVuWXLRnALPNOlyPN/
         V38g==
X-Gm-Message-State: AA+aEWZq17YdiLqX05AD+i1CCO6JxcwynbJya+PjBYJY2WxS/RLFWO+3
        Y384qytKZ+2mAgDEAYifp6p07N+jinnkj05m6SzXSw==
X-Google-Smtp-Source: AFSGD/UnomCwae2phCuge6TB14skzwOOAevnn8CflxsJqL+avuURAocotzWSroB2/KaBt294quPFrSKqvJPZnffEqhQ=
X-Received: by 2002:a17:906:77c1:: with SMTP id m1-v6mr4947060ejn.233.1543387283884;
 Tue, 27 Nov 2018 22:41:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543374820.git.gustavo@embeddedor.com> <5fceeac101cc3dfe4a129764a139c1b616cba292.1543374820.git.gustavo@embeddedor.com>
In-Reply-To: <5fceeac101cc3dfe4a129764a139c1b616cba292.1543374820.git.gustavo@embeddedor.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Wed, 28 Nov 2018 12:11:12 +0530
Message-ID: <CAL2rwxo0UW1N8K4qnYaNSwW5QtyBdOMQyt8KrO58PbqMaeOdfw@mail.gmail.com>
Subject: Re: [PATCH 30/41] scsi: megaraid_sas_fusion: Mark expected switch fall-through
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
> Notice that, in this particular case, I replaced "Fall thru" with a
> "Fall through" annotation and added a dash as a token in order to
> separate the "Fall through" annotation from the rest of the comment
> on the same line, which is what GCC is expecting to find.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index c5e6bccb0895..8f37ad83be9a 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -3453,7 +3453,7 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex)
>                                 atomic_dec(&lbinfo->scsi_pending_cmds[cmd_fusion->pd_r1_lb]);
>                                 cmd_fusion->scmd->SCp.Status &= ~MEGASAS_LOAD_BALANCE_FLAG;
>                         }
> -                       //Fall thru and complete IO
> +                       /* Fall through - and complete IO */
>                 case MEGASAS_MPI2_FUNCTION_LD_IO_REQUEST: /* LD-IO Path */
>                         atomic_dec(&instance->fw_outstanding);
>                         if (cmd_fusion->r1_alt_dev_handle == MR_DEVHANDLE_INVALID) {
> --
> 2.17.1
>
