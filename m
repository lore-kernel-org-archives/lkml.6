Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62172C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 12:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0886F21762
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 12:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8YpFas7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0886F21762
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeHLOl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 10:41:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35410 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeHLOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 10:41:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10-v6so6330338pgv.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CsLpNdu66XgC81HZa7qm12NGo47wYkuQBz9+oCM2M8o=;
        b=Q8YpFas7B1wrJ5g7IMgh+HV8bOPY0cOh+M5jRXucpU/LCGugGjVBWA8TaIVSkW6boq
         Lo+EqSGBgK5V0Yp6cQli7fhLE/25v/7EGMdg3kmXYmX2Mo6WDotU2WmZA4HD1/XarcqZ
         nCQ50jBV4t5q7c0P4DcjyXyqip6I2NJeFxxhY63RVHX997CqauR01nsjj+fqoXtNTvIO
         ORT7InzxQuAOxM9nR+wlGLayGdocMnUHCpyIyYzSn2CAlhsMbYGHReA8hJ27KaSz1tNQ
         GWKlrTiH2SWQtHfLqf6LrdqnBfyXLrnZA4dvUnjGwYqs7rtr9pm93WtaOHy7c/zk2/ye
         td/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CsLpNdu66XgC81HZa7qm12NGo47wYkuQBz9+oCM2M8o=;
        b=Rvg76/HHmLCv9hOo1oehEW0UbDuVzyrXHKqo+AYfK3SHYYQKgGDWSHtRXROnvLN1ND
         Hxlu4CptDRzIOsvKTpS+k+01BmAdeJW9pOLYjsYWpxP6KwhVELM7103nSGT1LLlkVbi1
         IUvjmnX+WPsw2fL1BLvl94d/PLZgzC3VZRGu7jDDJb7pVtNCNDk4iig4ZUlPINXxsWCS
         MI8YvWGIzi5PnZIMdPVPa0kyJsa0oEfz8/PHaAa/WETY3bPC+gHDF5/gxx8bP7aDvLOK
         WUxNrgr99qMWgEGqLbMcH/RCX9ADTBQnKmwi0mzY+PZfe3R/CfJ1hHWZvHEkCOLt4TCb
         0ErA==
X-Gm-Message-State: AOUpUlEF5BANWq7w5SK02qNBrUmfqWTu1yhj+t8co79p1u95W3VdSwlo
        YOy8Z5Odifb8d8EVXVIU0rc=
X-Google-Smtp-Source: AA+uWPxJ58YE6eylXtFUjAIvRbLZVC+Uo8MgBvaf/OSt/BnYi/IK/gUq1YiekFskPzbWR2U3iqUhjQ==
X-Received: by 2002:a63:9856:: with SMTP id l22-v6mr13421628pgo.208.1534075418811;
        Sun, 12 Aug 2018 05:03:38 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id h130-v6sm55030031pgc.88.2018.08.12.05.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Aug 2018 05:03:38 -0700 (PDT)
Date:   Sun, 12 Aug 2018 17:33:31 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Sumit Kumar <sumit686215@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: remove null ptr check before kfree
Message-ID: <20180812120331.GA5913@himanshu-Vostro-3559>
References: <20180812065837.GA20728@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812065837.GA20728@ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 12:28:37PM +0530, Sumit Kumar wrote:
> Remove null ptr check before kfree because kfree is null ptr safe.
> Issue found by checkpatch.
> 
> Signed-off-by: Sumit Kumar <sumit686215@example.com>

Hmm. Victim of copy-paste I guess.
No worries. Next time just use:

$  git commit -s

To understand what -s flag does, refer `man git commit`.

> ---

Now, this where you should have put versions just below the '---':

v2:
   - corrected email address.

And yes, the subject should be:

"Subject: [PATCH v2] staging: gasket: remove null ptr check before kfree"

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

Hope that helps!

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
