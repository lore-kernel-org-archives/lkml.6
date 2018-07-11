Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D76BC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BFB213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS55nDzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BFB213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389575AbeGKUMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:12:41 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45443 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733070AbeGKUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:12:40 -0400
Received: by mail-yb0-f194.google.com with SMTP id h127-v6so10518779ybg.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p/8uJICFfz1lAZFU1T0zhYiVPV09MSxRuBkSA9zUNuc=;
        b=VS55nDzHyV7zledO8PulqEH1XIqC3JeeashmXqUmXEPgXlIcd69n4ErUQ9OFYa+g3D
         FeY4eHX/U3He9sTuoC97ri0DXzslODJ/SU/vzlKsjasX1iBIWP6E7HmjN5GlkfViPnVn
         jUfVNttqaKgn08P8VLBjXz6ZyluOSKdukEQYcWh8Pc3ayWu/a0O/fqqC5obz4JwxV94n
         C70wCEalIqhBy7WXeiqvlrra0WWvmpslwQZMMKuWYA5a/UWJNmYxwQd5441AB8dcE7zN
         qWU4ZcxEHQaU5Jeggnm9yFDSpiJOdAnW2+hXIcgjJdR8JgIW5onjCcQlZWIqubUmuisv
         OUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p/8uJICFfz1lAZFU1T0zhYiVPV09MSxRuBkSA9zUNuc=;
        b=iYkv7jcglv3xBZB0vwuwPB2Nh4K4oCYctymh/btQQEoKBleNjxBGMdvcnFu0syuG8b
         uuqo2urt+CadVqXfqNrPr3b3Abzg/ToV64klO/aA/5YQAFEO8YW8Yr3pK3vwQ2u2HBBH
         GI+OQXHX14m2E/W9luH4iY0yKMCXewqC5XmX2Ytel3/5vMPch39ek/yFNDDj2xkx2iy/
         tsORDZcw/QXU5WD64xtOZgohpLGvRzbShyZMdvkoel0jtJ6El/IWH9Rdvq01XsCJtG5w
         G3BSM99PhgY1IiWeTRBWcKMJ+6YmnsShC3a4pLFJ0NpyWKnaGN8vzvPFA6Cun0h76mEm
         MqNw==
X-Gm-Message-State: AOUpUlG2gyuIRFfXCXcGqNPZpyMz1/uAhscL4ApsJf2kHXwQIbWqrOC/
        FYap7kMXqKqg6DumNVImZtM3T+7O
X-Google-Smtp-Source: AAOMgpdIBoOoUJ4SjiYzzMzKLlXdgr18B6gLNPVyjlLNqTOIci0ghh5rbNCMSDg78eBIMr26ODKMUg==
X-Received: by 2002:a25:6f84:: with SMTP id k126-v6mr26633ybc.419.1531339603728;
        Wed, 11 Jul 2018 13:06:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:7350])
        by smtp.gmail.com with ESMTPSA id x185-v6sm8133009ywb.69.2018.07.11.13.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 13:06:42 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:06:41 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/12] blk: use for_each_if
Message-ID: <20180711200641.GJ72677@devbig577.frc2.facebook.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-2-daniel.vetter@ffwll.ch>
 <20180711164058.GC72677@devbig577.frc2.facebook.com>
 <20180711164536.GD72677@devbig577.frc2.facebook.com>
 <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
 <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
 <85df8c40-dac9-5f97-f81a-6de061cfdfa8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85df8c40-dac9-5f97-f81a-6de061cfdfa8@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 01:31:51PM -0600, Jens Axboe wrote:
> I don't think there's a git easy way of sending it out outside of
> just ensuring that everybody is CC'ed on everything. I don't mind
> that at all. I don't subscribe to lkml, and the patches weren't
> sent to linux-block. Hence all I see is this stand-alone patch,
> and logic would dictate that it's stand-alone (but it isn't).

What I sometimes do is including a short blurb on each patch giving
the overview and action hints (e.g. this is part of patchset doing XYZ
and should be routed such and such).  It's a bit redundant but has
worked pretty well for patchsets with dependenat & sweeping changes.

Thanks.

-- 
tejun
