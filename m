Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEB2C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C3020862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="keeINCM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C3020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeG1S0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 14:26:23 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:23828 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbeG1S0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 14:26:23 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D5E253BB990;
        Sat, 28 Jul 2018 18:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1532797153;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=qzpRA97Bwpj4+xsajotANWY9Z2CGdurdb4hQWHhvubU=;
        b=keeINCM+KChf9Y70d4EnrZkBWORAgBwpCN1HffuFUsZPP6KGDzCIjz8wwIN1YAEATu/oeq
        oPjqdSGJvBzrWNi0okiBMfnD9zMHw2aptWDh4OH+J0wqsMjsJ3XwDXURwykb3F+NHpvf8q
        5TO/8EQVFQJ7Id+l+G0nxY52Xui54N8=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name D5E253BB990
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 28 Jul 2018 18:59:12 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     erik.schmauss@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, torvalds@linux-foundation.org
Subject: RE: [GIT PULL] ACPI fix for v4.18-rc7
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53BB4FB62@ORSMSX110.amr.corp.intel.com>
Message-ID: <db31a9d497ce2ef0f4b51eeb76729278@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.6
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1532797153;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=qzpRA97Bwpj4+xsajotANWY9Z2CGdurdb4hQWHhvubU=;
        b=KCWR0oNcGcnk2gVXjgNH+SHNKL/7hJ9U2sCztRnHhPiGg66ttVBJTCOiOVDm4UdP2S9oGP
        R03eCVZBHEZRrPgk0gCBuPVHKJgSpponUIn0ILmDne2dpTvm9xQUI0BhbV27r/Iqmn9Cfo
        iFbFrvSScnb4bVA31/QIaHkcabtrufc=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1532797153; a=rsa-sha256;
        cv=none;
        b=zWMSRoWo7/XuQ+6Fe1VzMTIsmW1rHtqdvQ9MZP1Mi9wTctouovMVRR2zlAmUMBwepHnOaDhEXE8FCIfiQ7QE66RJfeJk5ri76FgN8eBFiPm4zoRRRlBTu4zDRf8UkJHSTg3TC7NWwJ5F4+0HUU5G91jLYc0FybvEFSGly2cQcpI=
ARC-Authentication-Results: i=1; vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> From a828a091828599154d8f6e8bfee1495a3df5cf34 Mon Sep 17 00:00:00 2001
> From: Erik Schmauss <erik.schmauss@intel.com>
> Date: Fri, 27 Jul 2018 15:37:35 -0700
> From: Erik Schmauss <erik.schmauss@intel.com>
> Subject: [PATCH 1] ACPICA: AML Parser: ignore control method status in 
> module-level code
> 
> Previous change in the AML parser code blindly set all non-successful
> dispatcher statuses to AE_OK. This approach is incorrect because
> successful control method invocations from module-level return
> AE_CTRL_TRANSFER. Overwriting AE_OK to this status causes the AML
> parser to think that there was no return value from the control
> method invocation.
> 
> fixes: 73c2a01c52b6 (ACPICA: AML Parser: ignore dispatcher error status 
> during table load)
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> ---
>  psloop.c |   19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff -Nurp linux.before_name/drivers/acpi/acpica/psloop.c 
> linux.after_name/drivers/acpi/acpica/psloop.c
> --- linux.before_name/drivers/acpi/acpica/psloop.c	2018-07-27 
> 15:53:31.073522915 -0700
> +++ linux.after_name/drivers/acpi/acpica/psloop.c	2018-07-27 
> 15:53:25.320522527 -0700
> @@ -714,15 +714,20 @@ acpi_status acpi_ps_parse_loop(struct ac
>  			} else
>  			    if ((walk_state->
>  				 parse_flags & ACPI_PARSE_MODULE_LEVEL)
> +				&& status != AE_CTRL_TRANSFER
>  				&& ACPI_FAILURE(status)) {
>  				/*
> -				 * ACPI_PARSE_MODULE_LEVEL means that we are loading a table by
> -				 * executing it as a control method. However, if we encounter
> -				 * an error while loading the table, we need to keep trying to
> -				 * load the table rather than aborting the table load. Set the
> -				 * status to AE_OK to proceed with the table load. If we get a
> -				 * failure at this point, it means that the dispatcher got an
> -				 * error while processing Op (most likely an AML operand error.
> +				 * ACPI_PARSE_MODULE_LEVEL flag means that we are currently
> +				 * loading a table by executing it as a control method.
> +				 * However, if we encounter an error while loading the table,
> +				 * we need to keep trying to load the table rather than
> +				 * aborting the table load (setting the status to AE_OK
> +				 * continues the table load). If we get a failure at this
> +				 * point, it means that the dispatcher got an error while
> +				 * processing Op (most likely an AML operand error) or a
> +				 * control method was called from module level and the
> +				 * dispatcher returned AE_CTRL_TRANSFER. In the latter case,
> +				 * leave the status alone, there's nothing wrong with it.
>  				 */
>  				status = AE_OK;
>  			}

Faced the same on my Dell Vostro 3360 with v4.17.11 update, and 
confirming that this patch fixes the issue for me too.

Thus,

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Also, please Cc Greg once you do a submission, so v4.17 stable branch 
will be fixed too.

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
