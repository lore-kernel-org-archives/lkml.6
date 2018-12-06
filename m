Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFFAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FE3214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PKlR6zy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FE3214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeLFLC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:02:26 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36821 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbeLFLC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:02:26 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so31806ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 03:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=c/IGq5GxaNvdaxmXiH+yQUI992C23PsGorESX9ykm0w=;
        b=PKlR6zy3uvXw6xgxWR4ho3vQoebtE3Y4UJSogYDbdgU8NHPg9tRneMLxby3j89Pet5
         qkvx8f/PvwjM0sVbgDU0ZPAMOHu+mHIskEuTbQK0sKhie/8UzTg3qiqlJdVfR5MSYXwH
         zIQkCM+A6yv5vuE93ZbwqOlVQCp+lXBLUweAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=c/IGq5GxaNvdaxmXiH+yQUI992C23PsGorESX9ykm0w=;
        b=qQ+5bXqe955RB4dURAYJmewev6bJTQVHm24gj+23zL2O/tZDnFEYGf5PV38mDlpIe7
         DpNzHHWXd+nxspfBhiyH3qou7DlrhuPYIGTH/VMH+EZ1k7UZHWCZ+9i5B50OA7K/bSOS
         S1BuVCQOYKIgNfbSqhOyJAzk/46LH2f5GNxeFRrykd6W9Ma2KkLMmalMZYlTwd4oxfpJ
         vz15NpSkRWooh0o9qPZiKdvTxg1yhiSZy3iEPH7jMztb4S8JHJvSusTd8lxR77yGFa84
         9Kl1ldE5/XQQIOvUnZZDNlHl4BLX0DloZHKNGihEXJ6r+IpjAEsIveI6hW4sQ5uTtLWj
         SulQ==
X-Gm-Message-State: AA+aEWZLqkXmnzKT1mxfWCod1WBh/vLM4kC3VSf98AhrNNckjFR+8whY
        C+myNsA9Yhpm0IN84epzjaeZYY3yPprzCglC5iN5+w==
X-Google-Smtp-Source: AFSGD/X+H/sJebSExz1V7DZZtFnt8kmgGuOFriRj1WoLgCRhOoLSO66YYXIlhzPAsNxFRS3qw8vmxNkg/OJ1fuYri8g=
X-Received: by 2002:a6b:91d4:: with SMTP id t203mr24518952iod.267.1544094145193;
 Thu, 06 Dec 2018 03:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20181205235220.3461-1-jagan@amarulasolutions.com> <20181205235220.3461-2-jagan@amarulasolutions.com>
In-Reply-To: <20181205235220.3461-2-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 6 Dec 2018 16:32:13 +0530
Message-ID: <CAMty3ZAHf=66=r47Qs5FO1Gi_ypc8cJkVnTZ0EGKzBRBxOcx8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Input: goodix - Add ADVV28-supply regulator support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 5:22 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Goodix CTP controllers have AVDD28 pin connected to voltage
> regulator which may not be turned on by default, like for GT5663.
>
> Add support for such ctp used boards by adding voltage regulator
> handling code to goodix ctp driver.

s/ADVV28/AVDD28 on commit head, let me know if you need another
version to update that or is it OK to you to change while applying.
sorry.
