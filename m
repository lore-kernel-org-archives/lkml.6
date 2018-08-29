Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D004C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AE2205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kwr7eVrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AE2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeH2Rva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbeH2Rva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:51:30 -0400
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94CE2205C9;
        Wed, 29 Aug 2018 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535550866;
        bh=+xF41fjEQY5SI4OOjxzVwEz2GfESwAzM4qrZdjusLf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kwr7eVrvSPpVXwToIRctiJtjE1G6HF0b0mt6Qh+GznY7tipBX0f+yrXU/IffHEPmI
         ncAU0Ne9r/k7JcGxEtBD+WO9RNMNHZPYQRLqYSJit80vX76udZVX3rLAYaKpJKAHcD
         0LbhOrVureRKpwNnehqOG3/lvUUJ/rjKY5VTTLw8=
Received: by mail-wm0-f49.google.com with SMTP id n11-v6so5615300wmc.2;
        Wed, 29 Aug 2018 06:54:26 -0700 (PDT)
X-Gm-Message-State: APzg51BO0+PzCJl5+Xfir9mlPib46wWGk7DpqLUePSo+1sFDrouS5Pep
        GW8IED0o6g7Pb3UAAulQ6PjNxmrlzQH/UqMWTpM=
X-Google-Smtp-Source: ANB0Vda+4+r0wFEMCl+JvsgNYiR0H/Rl5BqQE5z3B6l3mYgW23GA2ZVLuVn3kLgHndD91eQMSP6LaumNuQd3DAw1o6I=
X-Received: by 2002:a1c:3e8e:: with SMTP id l136-v6mr4366321wma.72.1535550865133;
 Wed, 29 Aug 2018 06:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180828162842.17503-1-colin.king@canonical.com>
In-Reply-To: <20180828162842.17503-1-colin.king@canonical.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 Aug 2018 15:54:13 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcy3emsEPRRK+sKxe51ZWPoVscwHdrVz0fw7vJfLh9HWw@mail.gmail.com>
Message-ID: <CAJKOXPcy3emsEPRRK+sKxe51ZWPoVscwHdrVz0fw7vJfLh9HWw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: remove unused pointer 'dev'
To:     colin.king@canonical.com
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 at 18:29, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer 'dev' is being assigned but is never used hence it is
> redundant and can be removed.
>
> Cleans up clang warning:
> variable 'dev' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/supply/cros_usbpd-charger.c | 2 --
>  1 file changed, 2 deletions(-)
>

Maybe add cros_usbpd prefix to the subject?

Anyway:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
