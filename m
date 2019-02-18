Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7085FC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417C82177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQEdvnu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfBRUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:15:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35430 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfBRUPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:15:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so9258242plo.2;
        Mon, 18 Feb 2019 12:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cOLz6qBhXCKb5LnKRIn4o2cL/uqrCnw7qiMuGJ+OSYo=;
        b=IQEdvnu3cMEWGb4Jg7eOySz1v0Blm+nX+d+lpznDPyTrVT77Gp2ribN4Ne7uMSwuQ4
         dGyovPNZxnKSWjYl5tgScmEHJM76PDt4+1UoyVVBzHTDXIXHX/zHZzMcefkKOjPp07g6
         rndDoi+QaaUaW2i+62lIOhSGIWu6HYCUjy43APSUBUrP8hke5YZQnOp8reGLjsDG9gCm
         rXApdgSHz95L0JXQZ9pPIbacC9XIRfmyh6hhNgaVUynD1+nFWlpNOfHcrJpmATyXstSo
         gDb4vnWBsRbadlmD681gFdjOYNqM+i4omj1c9Uhjc4sVgbgLPDB4mbWxEQy9a2vWruH9
         PKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cOLz6qBhXCKb5LnKRIn4o2cL/uqrCnw7qiMuGJ+OSYo=;
        b=rXWetrJxuAdHIXo9kQPf+ITqt/NLFcatIHLUkloC1D6X0eM5/0Eeq+zHHKrF/8yrWz
         jum6YQc0mjOrsiSLtMLJcBaI3BkvE6ezEeXccLW/PAdpoQmSbV2oCfOIb4xCVEc/E6x/
         CgVGsv1d7IdgQAzXs2PY9V343e/CRH7rlKUgcY+4svLRlqp4ESmyXrvQ+2I2HNJjK6w/
         r+w70qjvSmFFxGLa2XJGE/+liO4qXRrrjJP0C0zTjLl++zUjIJ9BWB5JF8Tf3y6r6eUI
         LD0XmbH6MjefM40W8SDZzMLq9G2cQ9NpR83ZyUcKXtnwtSDjeNMu9OsNcgc6CfW67kZY
         BZPg==
X-Gm-Message-State: AHQUAuaxxg4oyNvJjwM17XQkE836duSjDDVLOw2fpRE0T8jNNQDHG10K
        21E+iaOWs6fwNHzT2fqCF9s=
X-Google-Smtp-Source: AHgI3IY2+v/19tlkYxVBroCoAOIeWcg4NMlmWI5Qr9zxYlFccAekf/KIoIsC0wpDGw+ynxUdG39bTQ==
X-Received: by 2002:a17:902:a612:: with SMTP id u18mr26646261plq.145.1550520946497;
        Mon, 18 Feb 2019 12:15:46 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b12sm21605332pfb.30.2019.02.18.12.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:15:45 -0800 (PST)
Date:   Mon, 18 Feb 2019 12:15:44 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Martin Kepplinger <martink@posteo.de>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)" 
        <linux-input@vger.kernel.org>
Subject: Re: [PATCH] Input: uinput - Allow uinput_request to be interrupted
Message-ID: <20190218201544.GA192977@dtor-ws>
References: <20190218004305.339758-1-marcos.souza.org@gmail.com>
 <20190218142110.GA23087@casa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218142110.GA23087@casa>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 03:21:10PM +0100, Rodrigo Rivas Costa wrote:
> On Sun, Feb 17, 2019 at 09:42:52PM -0300, Marcos Paulo de Souza wrote:
> > -	if (!wait_for_completion_timeout(&request->done, 30 * HZ)) {
> > +	if (!wait_for_completion_interruptible_timeout(&request->done,
> > +							30 * HZ)) {
> >  		retval = -ETIMEDOUT;
> >  		goto out;
> >  	}
> 
> Now this function can succeed or fail because of ETIMEDOUT or an
> interrupt. I think you should return -EINTR or maybe -ESYSRESTART if
> interrupted.

Rodrigo, you are right. Marcos, could you please send updated patch that
returns different error code for timeout vs interrupt condition?

I dropped the patch for now.

Thanks.

-- 
Dmitry
