Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B77C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F6020673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg84y+4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F6020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeGZIGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbeGZIGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:06:45 -0400
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37FDB20883;
        Thu, 26 Jul 2018 06:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532587883;
        bh=Os+4pxO3LMuThvXujVi0CzcqA3lHQf/qA+lBd6B7brM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Vg84y+4tkzl73DytcPhGtb4ZvNEW0jwIBJMQtcomcs3HyMcOREmCEpxnBxI+3EdNc
         n46RcFUftn1TS3Kt45v4t6YdsTLaLR3DuPX3rXYcUnqB+rUawIRRCvztriYhfhDAbu
         K2jk/cr3kGqUX995hVyPCiTIZhdXy1c6n9cqjibA=
Received: by mail-wm0-f47.google.com with SMTP id s9-v6so803649wmh.3;
        Wed, 25 Jul 2018 23:51:23 -0700 (PDT)
X-Gm-Message-State: AOUpUlFq63g/ERaH+/E9v4Hq8AfcnF3pRNRZBaunmilTneUGLHdaGE54
        bW5t4Vz/SPBur19kS2/mu3rjLVF0mxzWPGHjOAA=
X-Google-Smtp-Source: AAOMgpcjR05KfCfhaooGG2oxlzHdrot8CsFAJ2RJA2FOHH2C1V+8YzT96a919FIn0of/1qc1Lj/JGMUvDF9cXtyZCOI=
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr686972wma.72.1532587881668;
 Wed, 25 Jul 2018 23:51:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 23:51:21
 -0700 (PDT)
In-Reply-To: <20180725194630.10414-3-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca> <20180725194630.10414-3-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 26 Jul 2018 08:51:21 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeowiD7bXwRrG5horJOcxfEavB6XEmF8sz1unGDoykwoA@mail.gmail.com>
Message-ID: <CAJKOXPeowiD7bXwRrG5horJOcxfEavB6XEmF8sz1unGDoykwoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] power: bq25890_charger.c: Remove unused table
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 July 2018 at 21:46, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> The BATCMP table isn't used so drop it

TBL_VCLAMP also looks unused. TBL_IPRECHG does not have table entry.

Best regards,
Krzysztof
