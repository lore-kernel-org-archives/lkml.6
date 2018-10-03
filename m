Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3327C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0062082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edDLq/MQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0062082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeJCXPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:15:32 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35509 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCXPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:15:32 -0400
Received: by mail-lj1-f171.google.com with SMTP id o14-v6so5724739ljj.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZEcrViwqOMLDkMcvcD57VAUYaNClOsqF6M3ErrhkyA=;
        b=edDLq/MQ1hoXZb7GCTGb3P9mC5K4DOeNqkdKGG8c2RXjabqslXuEjZS6lgmTXY6m1Y
         qLbotCKfHXhS3itkakEHkr6SO1xQdLl4woif9bMWjCY1ibXl1xwI8p+U8W+RH1JA848h
         f2tLQ6uXduYIMvw0Pk111vlMZcPjTM1cHDxXY4DNnI5GICO/0LKn+v2QVY6Z5lUlpIQs
         svbSAGO5W1u3E9efX9cLkXLvfkGMMNJ1GmicjFyCNwkFl7fErGmyBgdNFxVDCPtxTx9Y
         4SwErg3lMxrFOccrA/F/DeKn50cquY+5DXOYmS1U4SDSnNE+i09WEr+Uz66Db2BnrJwV
         dcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZEcrViwqOMLDkMcvcD57VAUYaNClOsqF6M3ErrhkyA=;
        b=Bfj2vE28bFfzVz6OSh48WDB0GhzqhQQMis4tipT70xG6fVKSHOwF6vi8+BmXh3WlTK
         ao3OyV3uVuplg8Cx9txhwZurq6epdDt5whylUrqD3UeXepEXUOJ+6cshSGKtRdvyHCkU
         PH203O7I1bO7JYH0m1PWgAmBXtNYBtLSXPxQIbIUoevqwfQBvRpYTjwlHK1uTtcKG+sc
         2c8AdfbwV5hEaBO2bPbZ94tHadQxMaCe2AGXRojfWpjr51RL20+1nLOTa52cKSp3hREC
         jvy/qYIhSuyXShx4K5R12PFXhK3Q+5r6/9hH1B+NBHXgfK6zWXSoh3P7J/D7PvVWwdaF
         Og6A==
X-Gm-Message-State: ABuFfogNwJIJCoDA9Lin43TubDgQEx7BdftjKcwDwB0MG7yWV+YAzBSu
        /APfjImvNu37ra7eA52Hy5Sh7iiptz5J3DUnDyelcF3e
X-Google-Smtp-Source: ACcGV61EKVD7ZGBuxGKtvi3tzAEXnXDwDL/Pt9Gj93bhiPe517oZV1yEDiplB4AApq7R3WZS4QEbbkgf4Fjpy5S913I=
X-Received: by 2002:a2e:9851:: with SMTP id e17-v6mr1487751ljj.143.1538583984211;
 Wed, 03 Oct 2018 09:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181002231024.58408-1-rkir@google.com> <20181003110514.GA12267@kroah.com>
In-Reply-To: <20181003110514.GA12267@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Wed, 3 Oct 2018 09:26:12 -0700
Message-ID: <CAOGAQer9HGNjKRRCM8cudJ4uVZ5s5ViT8YQiRSdhLWNNbQ5WdA@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] platform: goldfish: pipe: Move the file-scope
 goldfish_interrupt_tasklet variable into the driver state
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I only received 3 emails in this series.  Always resend them all.

Hi. It was not obvious to me to resend all patches.

Do I mark all other patches "v2" as well? What do I put there in the
"Changelog"?
