Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3E1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4F3206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TMaJKRlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfAHSK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:10:57 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34148 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfAHSK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:10:57 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so3659050lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4p9kQS9d/rYiye9iB/h7RrZgVY153buqId33GQYen4=;
        b=TMaJKRlobRWsxLX/QSR2DNg7DWjudvN3j8vWbiS7Uoon+OqUSpEgpso+Fo0eQXo5Kb
         f5U/tFRJYv9rqtD1hLNGNRlijzmdxHQqySJzw/tj1aFVXUCkjtuw34QJdiGbFR/cV+I3
         bZ4tt8ib5SpOWwyJ2+luBqe+Pu2lZG29vO5FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4p9kQS9d/rYiye9iB/h7RrZgVY153buqId33GQYen4=;
        b=dQ+5QcRdX5+7BdVUAWCRPY+NgP9FbXng10etVnlIEGRHoN1/6oJPDTckMc/CwxCE3t
         xe885blyAoQQBQoed8v9Sba2MdCvWHGeaat5pOppRQg9rf+HiNP8IID5K2cyT3AvFyd6
         7z4Z2TCgMXvo6/CGZTcU+LDErhx9JGjoAFB/fbCoPj58N8TNtzIul454sz3HhoeOEQBY
         6dBtioIePkE19Y5CwTg0L/WBvuxjGd/KJw6zde5DQ7wWRK0HhK8OOhvWIm3lM0RLnWCM
         fFMNSe9H61+hAMYHunAa3eGWmAKNh/CSWNtn8L4zB+BOabyP1z90o5L2RGlrrJmIuFSM
         T/EA==
X-Gm-Message-State: AJcUuke+hR/dfYNWACfVlk3bnwBpTxnEYAgJxVQmiK/Hd6GDInt6UGoV
        RIxrAzytaf2TXzrQYIsd9PRN+Qq36zU=
X-Google-Smtp-Source: ALg8bN45QHj7m0tC19jplP6UAYahN1sQMtURcICP+MO0lbSJceeqbAnI51Z3mE9RsRllmMjp5rs6WA==
X-Received: by 2002:a19:f510:: with SMTP id j16mr1545132lfb.35.1546971055044;
        Tue, 08 Jan 2019 10:10:55 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h12-v6sm14308403ljb.80.2019.01.08.10.10.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:10:54 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id g11-v6so4222586ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:10:54 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr1461299ljj.120.1546971053650;
 Tue, 08 Jan 2019 10:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20190108131516.27903-1-shorne@gmail.com>
In-Reply-To: <20190108131516.27903-1-shorne@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Jan 2019 10:10:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whR9UX8wG0CKp87sNQkNdtMPVmAmi-gjGRwWTYYAJ9v_w@mail.gmail.com>
Message-ID: <CAHk-=whR9UX8wG0CKp87sNQkNdtMPVmAmi-gjGRwWTYYAJ9v_w@mail.gmail.com>
Subject: Re: [PATCH] arch/openrisc: Fix issues with access_ok()
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 5:15 AM Stafford Horne <shorne@gmail.com> wrote:
>
> The commit 594cc251fdd0 ("make 'user_access_begin()' do 'access_ok()'")
> exposed incorrect implementations of access_ok() macro in several
> architectures.  This change fixes 2 issues found in OpenRISC.

Looks good to me. Should I apply this directly, or expect a pull
request with it later?

             Linus
