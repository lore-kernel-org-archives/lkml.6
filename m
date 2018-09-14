Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0511AC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE3320882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWErygfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE3320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeINNEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:04:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42330 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeINNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:04:30 -0400
Received: by mail-lf1-f66.google.com with SMTP id z11-v6so7038831lff.9;
        Fri, 14 Sep 2018 00:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jYYpp72RC71h8Vl4cD8thJAIEsTmmyatJ7HjoZit7Tk=;
        b=tWErygfbKmX/M9GXuxy+JTVRVOjJcrf/ZTNqBYOz5FjlCVA1k+zOs8pn+NwaOwwuEF
         sk83Rjgv0OA/MB5WwNTPWclzdGR7PMDmKESVkukOUXolVwbgfZhlESFxh1Y+AsAKRAQp
         OqVCWSkv9svju31NgPA0CvgPb/PrewpNPNAw7ZhN3pGUR3EBLv+y9MWZDw1wRGXQXue/
         OPcvIzWZo6kbf1xi2KhmlLKeF8PzU5rQCIHHf+zvt2L7o1o3tmV3JIn31XtC9sCvr9cC
         zqXR0nzM6o3M1FlSVse60xxKX+UtbUYrt2DRDX/Lr8RNwfaCZs9xx29Db5K9SaQvC7Gp
         2LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jYYpp72RC71h8Vl4cD8thJAIEsTmmyatJ7HjoZit7Tk=;
        b=ppog2LTypec4iso7efNQa0E4i01RjeKcvlVFW8M+783U81jUESPtEGI8+h0zPjWl9x
         TypCvMraeBCHNrHlDSqtsaollmOAvJtLwzp0LLDJh8fy6EnukUkCNz8a1p3OxzrOC/bk
         TGy4jLOpSsoJtIl7FXX584UPESCHH7f+rkS2DTnjAnZJQbgVeNiP6yWBimJkQAW2uyoO
         OgaXSxpfiSC1/sVu88P9VwKD6v3bNA3r2Zh9IskKXOT/91sUJDT+C46LTdlJ/PGgpPlZ
         s0AwHRoSmBJUFeCCCk+KMllfnm0QiqhS5vVEDYK8YFR8cIcj04dgvBqKH8zTqsSeSVIy
         faUw==
X-Gm-Message-State: APzg51D7u9AwK5igzDWX+y5wA2CAMfA/lNiLwXEp929dyaB8NM30kT9w
        Vamnf+WiiitAX2LeXl1VSi0NANrv
X-Google-Smtp-Source: ANB0Vdbz3VIpYaJp5JJzhhv2ZTH1WePx9iyFqnfqpemyMlsayQFD0NZkJTv1idn0KWr9WP/gPBtz7g==
X-Received: by 2002:a19:d8e8:: with SMTP id r101-v6mr7307716lfi.37.1536911473877;
        Fri, 14 Sep 2018 00:51:13 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r22-v6sm1081159ljh.22.2018.09.14.00.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 00:51:13 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0isk-0001vi-NV; Fri, 14 Sep 2018 09:51:14 +0200
Date:   Fri, 14 Sep 2018 09:51:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, dcbw@redhat.com,
        Lars Melin <larsm17@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
Message-ID: <20180914075114.GA1362@localhost>
References: <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
 <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com>
 <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
 <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com>
 <CAKfDRXi3QdB0qCvqHPFXpxdpiHSJ2WoSqZGgjD3gEzAaPbBPUQ@mail.gmail.com>
 <f2c15eef-ed8d-12c0-2ba4-3dc068ca9fd4@gmail.com>
 <f3c647ec7c50ae390fb92861d492e7aa4bef8c6f.camel@redhat.com>
 <87y3c6a1zw.fsf@miraculix.mork.no>
 <20180913091753.GA3443@localhost>
 <CAKfDRXgNxohLv_SzAZ0niv5QreToSotACadTMx_fqSi_ozObvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfDRXgNxohLv_SzAZ0niv5QreToSotACadTMx_fqSi_ozObvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 05:13:02PM +0200, Kristian Evensen wrote:

> I just finished backporting + testing your patch with our 4.14-kernel
> (mine is already there) and it works great. The driver correctly
> handles different EP06-configurations.

Great, thanks for testing. Do you mind if I add your tested-by to the
patch?

Johan
