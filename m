Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E515C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4693E20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrJUG5O6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4693E20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeGLIOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:14:25 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46894 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeGLIOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:14:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so10344360pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XtjZYxrDNPEPq8UcV/aUKGmMXCiZ3LUEvev/K/gy77A=;
        b=jrJUG5O6VXbAMGz1KZOoWrOXp8NSFPxxUWWFZfvVwiGtM/7O7ra88PhAnOMCYjeTJQ
         bJaIgiNQneCF04egVl3hdC0grRUfuymlR+P1YlCNpiw0lynF9w1nvp/LcrdJvKO4Dhg7
         xdIWZBT9meeTgtd3t/X/NI9lQwpzYMzsLAd+31baDKLGXB6QUts1ksIVltpGCf0ZoHBC
         dgb4+XqtQdLYu0U0tmH1jyzexTvfai0qbvUpCuhU0k7ZOJYIoiuVfhpX6jqVDRIb5Ae0
         odLbF5x5XsFxgJv8l8WtovyBoO0iOIQIZEP8Ql9Su7X40QlIWBnNR4TEaTltVEERM32T
         AXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XtjZYxrDNPEPq8UcV/aUKGmMXCiZ3LUEvev/K/gy77A=;
        b=PxWBSB12wsCXyC2uUjvw4F8G57BLO4FXks1X2yYpDKfu9k6ZnN8aPLXRB0dbnHoDR7
         +FaJvmdhJzghjP7GSgKuC/u9YAIMlX0akH7+fs9/Zmv0WZmuXidg7rs7bmxN+ATrZgeR
         JmaSl6PIa0c72vwHspSSOW01Q+rOgUMljvGmrxD7OmvlmQlgpkq/abTPuTXLIhvPVlC4
         8X8nzhkgp2uuUIlqjUEdH+fBKWk/rdXUdqMz6g0i1wD1W8ESFJSFEXAgUIW/4qEyGFOA
         6glEVNBlvCl2SThnmXyUyW9u3/cdNAuzNz/nunSBjLNwmvaErnD6h3q2tNYbQoaPmVsd
         hBiQ==
X-Gm-Message-State: AOUpUlFLxIX0FWcqkvfHODWXPTvfJw1/f6H1h2PJgeTLxvTdk9RpYHEF
        nbiwP0G9iEn7AS0krYDwVfI=
X-Google-Smtp-Source: AAOMgpcyZbRcclu1bb4Yt/pecDezolvXKk2kXpyi10RT25XRswgfimrZBPstKUp5B+9qIxAF0EmIaQ==
X-Received: by 2002:a17:902:a581:: with SMTP id az1-v6mr1184541plb.61.1531382758804;
        Thu, 12 Jul 2018 01:05:58 -0700 (PDT)
Received: from localhost ([175.223.26.85])
        by smtp.gmail.com with ESMTPSA id r6-v6sm30743846pgv.0.2018.07.12.01.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 01:05:57 -0700 (PDT)
Date:   Thu, 12 Jul 2018 17:09:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] console: Replace #if 1 with a bool to ignore
 WARN_CONSOLE_UNLOCKED()
Message-ID: <20180712080920.GA17915@jagdpanzerIV>
References: <20180711151755.613eba3c@gandalf.local.home>
 <20180712015848.GA663@jagdpanzerIV>
 <20180711230912.2575fae1@vmware.local.home>
 <20180712042552.GB663@jagdpanzerIV>
 <20180712075315.vvcebweho635d3le@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712075315.vvcebweho635d3le@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/12/18 09:53), Petr Mladek wrote:
> > 
> > True, but at the same time nobody complained that we didn't have those
> > extra WARN_CONSOLE_UNLOCKED()-s. Just saying. Over all I agree that there
> > is probably some value in those extra WARN-s.
> 
> I agree that there is some value in the extra WARN's. Also it seems
> that it is useful to disable them for debugging purposes. I do not
> see a better solution. Therefore I am fine with this one.

Good.

> Yes, this extra comment would be appreciated.

Yep.

> If you send v2, please, break also the WARN definition to 80-chars's
> per line ;-)

Yeah, I noticed that too.

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
