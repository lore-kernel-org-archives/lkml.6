Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8019FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52099217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549645622;
	bh=thzhJiqS+mjocx3nQpTVcrVDTUDQsfv8N/d8bnEn4DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y7jWi5PjN7qXudE/0pCus/vrLdHh9yooWdSjFqpw0LylttY5c1VFAl43wZETiAw3K
	 HpNw310WxkXcSuVAb4RN9U6UBDxQc0SyaII0gStIswopCictDuQUhbfSFbBFiVM5Ku
	 aCvTIETzqq1iEheKej5BatNngULi5Qxca6b44HqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfBHRHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:07:00 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39495 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:07:00 -0500
Received: by mail-yb1-f196.google.com with SMTP id s17so1685601ybp.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ooj+zw+YBLytS2PSdNmBfDnd/v+4zq3W3AATSUlfrQ=;
        b=OyNXpB/wjXhZXdoTZWUAbiDGAyzKi5GXExY8NE4m+D+/yFj1ABi010xUgC7/Kf5239
         drh5+xihn6LGweE1pFf1cCG13xSSRoT/zexKcd98ER4qfanUoGaY29Bw28isfwm65rC3
         UsS+IjYBZFLqW3+gVXvJKKdiGpT2+9gRW4IKCA2Uf5pRYhh7gegQDsza9en2ho4zzXfd
         AsQddL6r55iAm9dyD7AQCvtfJmB7V5kp/GB/c6F2Rmu4frk8seUTLDItGt9fp4/aMHnC
         zkV5bJG/teFnj2r8sRoHocvp5f1m5lfgZn4lINPKCSN9Db8CYzbrT847HAqnhipAxOQV
         At+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ooj+zw+YBLytS2PSdNmBfDnd/v+4zq3W3AATSUlfrQ=;
        b=QhnYB4pQWhHQJmiG+/5DO2qA6RJWXnxDNAd2nyRShij1EmwXavqeCIu+6OUb8xfbSO
         4WTwmYBbajz5sX+RwtdjO6kWEGodq3uOrfiJ6i4Hl4owwDdfkeXSt61iVpsxY33P7BBT
         jCraCtYBKMrgPxilNSp8+axicV+BNtcY9EuDWLldKoUy/LvKsFRTFTxZjUp8srl+4i4q
         8KxCb7mjRykniaoJdblOb03HFUTH7+Z/mmYXCPBHMxB5dd2fIJPS0dP9EsuTEwAUQVPM
         oggedEk1HFNEUeI+YuxNEtmCmQvI5j2OL1gwWkaGMm9My49MRp68rabTzUOf4Paup/+b
         TPIQ==
X-Gm-Message-State: AHQUAuZx7lWUy0Ai2TWjnbYvOzlwh6P6LeyhW9aNBbftalcY2JvRDDo7
        cZonP6lKIYFeDwwkvMCV8S8=
X-Google-Smtp-Source: AHgI3IYdYEl3bCqUMX/ZGDtMBwCjw+8YWpgQk1Xal504PYFY1wHUyNj58uY6oyjthBCJyH878UoBJw==
X-Received: by 2002:a25:abf0:: with SMTP id v103mr18932844ybi.429.1549645619244;
        Fri, 08 Feb 2019 09:06:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:1597])
        by smtp.gmail.com with ESMTPSA id s185sm1161081yws.69.2019.02.08.09.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:06:58 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:06:56 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1 1/3] workqueue: Add resource-managed version of
 INIT_[DELAYED_]WORK()
Message-ID: <20190208170656.GL50184@devbig004.ftw2.facebook.com>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <20190204220952.30761-2-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204220952.30761-2-TheSven73@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 05:09:50PM -0500, Sven Van Asbroeck wrote:
> In modules which extensively use devm_ resource management, it is often
> easy to overlook (delayed) work that is left pending or running after the
> module is unloaded. This could introduce user-after-free issues.
> 
> Nudge kernel developers into 'doing the right thing' by introducing a
> resource-managed version of INIT_[DELAYED_]WORK(). This can be used as
> an elegant way to ensure that work is not left pending or running after
> its dependencies are released.
> 
> Functions introduced in workqueue.h :
> - devm_init_work()
> - devm_init_delayed_work()

I don't object to the basic idea but cancel_[delayed_]work_sync()
works iff queueing is disabled already, so there can be situations
where this can lead to surprising / subtle failures.  Given that, it
*might* not be a bad idea to keep this explicit unless there is a way
to reliably block future queueing.

Thanks.

-- 
tejun
