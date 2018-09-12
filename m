Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D9CC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18CF2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3u13uZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18CF2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeILVzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:55:51 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43071 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILVzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:55:51 -0400
Received: by mail-yb1-f193.google.com with SMTP id k5-v6so1966778ybo.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+GZ7nhCvCJtMfAnGwLb7t33EjeSQ6FLWypH0GUfebk=;
        b=j3u13uZUcJ0Eu4Kqh2TUgFz0bgIWqof3zJBkK0cW0A+/SsNM9GMLwUz56whQp2fot6
         1B44HfpOpcanuVf0ypWVuMXp5QvVZ7J5gENi2GNwM4EyhquyzYQ8S2KMicSWjffF+UnN
         V3KXSVZGJW4Wmg1x8CjLzF9jCzbkJecc9QnXkyHubz7vqTYcOCtXFs50VxTcskLS+IVC
         dWyU+C0oyZr9ipJB/tqF3Sm+xfcchxQkhhJnD7yoxkQvnbUrVyZj/7fkZhecz3DqnGEZ
         aLGxBCo6JDJ4FrSPNakAmTP0kENc4qkXeg4AvLlrB36SAPEhUPvP1YQHI/dEQD9Jir3o
         0gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+GZ7nhCvCJtMfAnGwLb7t33EjeSQ6FLWypH0GUfebk=;
        b=d1joqEBew8U+w2iuMgBBowIoxMUUbzT1C327AWAGSOtLvejsU6WynKDh1ZOrU9vUoj
         iKGcjKbgJt4y6hP7USySKAT0rrblUFnaxuMMxMjy32HPcIzM7iEDTa8DeSSDbi+U0r8U
         ani3VzCpTS6cOGgn++AeiqSUBMqI841h8587wXbKKp4+2BKflOW3qBknJQ2hYzmHVpUD
         JBz/+7DN+S1UdFoWlSFz18211Qz9/8JIoSXgF6pMramn4RWBsDB0Omw2Y80iZm0jeN66
         XJcsZG64fKozRFnN+tUOFFCQW1l/fnf55tSM5W20B5OUkkA7xtfc1ktN5pa+1vzBVicu
         h0jw==
X-Gm-Message-State: APzg51CZZZNccg2BIiZLXDiWogP+JOKqI5y4dmYyFCnQ6j7Btb56Gpnk
        RJuGxUQx+F7KZN4dkMsYXE8RuCqVmfzGM0l2OvEFHA==
X-Google-Smtp-Source: ANB0VdYzWqo+WKEIJtmWRt2l7SeShs9bGnU4NxxQ2sjuDSowtDeXtoxdK56yjETiZ+dJm/uugDvuQun/U5nw+/O3v/k=
X-Received: by 2002:a81:e54c:: with SMTP id c12-v6mr1311079ywm.299.1536771027663;
 Wed, 12 Sep 2018 09:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180912164510.23444-1-zsm@chromium.org>
In-Reply-To: <20180912164510.23444-1-zsm@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 12 Sep 2018 09:50:16 -0700
Message-ID: <CABXOdTd4iHi5=TJymRyD9c=A+=Lj2E3sFmaUzRpMJGLkk6+ZOA@mail.gmail.com>
Subject: Re: [PATCH] perf/pt: Annotate pt_cap_group with __ro_after_init
To:     Zubin Mithra <zsm@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 9:45 AM Zubin Mithra <zsm@chromium.org> wrote:
>
> pt_cap_group is written to in pt_pmu_hw_init and not modified after. This makes
> it a suitable candidate for annotating as __ro_after_init.
>
> Signed-off-by: Zubin Mithra <zsm@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  arch/x86/events/intel/pt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index 8d016ce5b80d..3a0aa83cbd07 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -95,7 +95,7 @@ static ssize_t pt_cap_show(struct device *cdev,
>         return snprintf(buf, PAGE_SIZE, "%x\n", pt_cap_get(cap));
>  }
>
> -static struct attribute_group pt_cap_group = {
> +static struct attribute_group pt_cap_group __ro_after_init = {
>         .name   = "caps",
>  };
>
> --
> 2.18.0.597.ga71716f1ad-goog
>
