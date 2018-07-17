Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA64ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34A420C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFOz2A8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34A420C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbeGQMTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:19:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44062 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbeGQMTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:19:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so935668wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:from:date:message-id:subject:to:cc;
        bh=Q8vDbTbEgXxepij4g0lUfCa7q9OMME4tzMT5XZ7Pmig=;
        b=aFOz2A8oyojjO7Rkc16oFZjrx/kSAupAOl94oqaoRY3lgLWziwL32R4DFHkT2349De
         8tb3Nrs/xwqqm2ohoQyioUF6ZkVHtBhhyTtQ1V/5JvjZDhkTD7LMpU9StWo9XA/koF+o
         vX5ZQpdh/D7H3gFFULZs3P3vmFll9R9I4UrvKvbXml1+nY7gat3S3bSTSaGso/tE6FPH
         DJsguilQSmcO/PTgcupum2UQrweOsFZY+406e8QDi5L5PQbN2kzBZ5AZ7ihPmPEWpgqb
         Ffke6dT1vBwtv0dRpMijL8aMCnxgVNBeQm6r9usJpyScNaVmv9HiRdnN4nQ3Ib3zJh1T
         xatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:from:date:message-id
         :subject:to:cc;
        bh=Q8vDbTbEgXxepij4g0lUfCa7q9OMME4tzMT5XZ7Pmig=;
        b=MVStcCcN4Ch+npGeUmQAvYg+bK1lss74vTtf8mJ9PxvRkajgdLYhpN7aGi+cVw1f2+
         G/sQubBfSvXCGGDZvRt29Dd1V1FvWqH7O7TFJGww1fF3PySwOFDMrTzhwhfXJ0UVE3pB
         C3LeizeWs86jKR3Y3VND40nIasDzCx22Ke+DQLNoUxTCTLJ/YnKgHPXTNCIfnkrfm/F5
         dBP9fMt/Wpmj/kETuaHiN3mBnVtKOOc445eP/ELGXBojvzrfZDkDRxZGpt8+mcJ5kQ6U
         I7/Nu47oJ0JIhl3Ofg9mPLC11vq3RaIsTP6+kqh66q+aUP70IFhr0/lsgsSxOut4EiQl
         JCWA==
X-Gm-Message-State: AOUpUlFQ81CbZGS6xFi89fjAJn+PfMJfNPm3UlweVHN6nzuhvJIMG45P
        YyCWluThahi7JmUP7pFvtdubg/SPaaIgzGqlHR7vvA==
X-Google-Smtp-Source: AAOMgpcutN1x9ndNfI1+21usVjkxfIBe/ELukU0Mjg5FMVOQcv+OFraqdelzBwkLMrsO6N6Pv5UfbQctQgPaEpu7kls=
X-Received: by 2002:adf:e287:: with SMTP id v7-v6mr1190392wri.139.1531828012618;
 Tue, 17 Jul 2018 04:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180717020926.176408-1-toddpoynor@gmail.com> <20180717111600.GA17117@kroah.com>
 <CAAW3Ypb-5=oUWdRP=DdR50onROXYn0PD2ofoeCttnP09Qq_pHQ@mail.gmail.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Tue, 17 Jul 2018 04:46:40 -0700
Message-ID: <CAAW3YpY46af+Hu+qHo9OBMsuGGBmF=yZio-LKeT1ZEhc1WJwbQ@mail.gmail.com>
Subject: Re: [PATCH 00/32 v2] staging: gasket: sundry fixes and fixups
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>, benchan@chromium.org,
        devel@driverdev.osuosl.org, frankhu@chromium.org,
        LKML <linux-kernel@vger.kernel.org>, sque@chromium.org,
        groeck@chromium.org, Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:25 AM Todd Poynor <toddpoynor@google.com> wrote:
>
> On Tue, Jul 17, 2018 at 4:16 AM Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 16, 2018 at 07:08:54PM -0700, Todd Poynor wrote:
> > > From: Todd Poynor <toddpoynor@google.com>
> > >
> > > Various fixes mainly from the chromium review of the gasket and apex
> > > drivers.  More to come.
> >
> > What changed from v1?
> >
> > You have to list it somewhere...
>
> I have a list of each changed, dropped, and unchanged patch from v1 here, was hoping it's in the right place for that info, does it need to be elsewhere farther up?

Oops, I see I need to move it, will fix in v3.

>
> >
> > thanks,
> >
> > greg k-h
