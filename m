Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DE6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB25206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547071609;
	bh=HiVeWZOYxBQ7T4ZGyV3lZjsoq80OQZMBq2wLrrmu3XI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iw0ni10PiS9AjQP5qFI6BvVwLFlwh//bL4V/ZkOv/lVdUs1x0VZUBe1jjPidP/+rx
	 kym/XVJAm40juN9zyWnazehyFdHndx94qV+zrj1Z15ZK+PPcZb1jhJn1rSTCrVGFaS
	 meA5SROJlQ99llFZybanhEm3LynGeLwI/vw7SPxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfAIWGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:06:48 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:45490 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfAIWGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:06:47 -0500
Received: by mail-oi1-f178.google.com with SMTP id y1so7608001oie.12;
        Wed, 09 Jan 2019 14:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbOrBzvxpr23c/lgxXfwTc8+8FBXMZjPC223hJfy8qo=;
        b=sIRS4hZA1cEYi8d+lhHcgeKOkHV0id9gmwV9dwQgTlCs+obovfs0ibGuheJqcvB1zs
         RYb+CE8p/zDI0F8u/BlZzlS/Pz0652NV0UAeZiES7UrKXYgBgZ1Rfy/k7i6BQ0LqjJoz
         3WizIsDg13nSpFWEvBPVmBoNjqGc1uf09+bOQWXjIGQUsuGNV2Vo8dTX2yCoP/0z9axr
         NssoepobcrqPD6ReCeOjPOQJDijFG6P9xmZQRJtsaylPdPO/UFqtuiX8w5b6wgUD4mx9
         z4EXwbEJgxvy+Iwf3kqy9wI0lE8ez/VRID7hiLaBjHDqyjUS83pHqiOyr3SOX2C9d3Wb
         s99w==
X-Gm-Message-State: AJcUukeUSBfoFk6pJhEPl64hn8vQSYIOYvkmtTBwnEsXNNRhbYKYB7Ze
        jgunXhRI7142b9lngdfOkF+e0oW1DSt35rS+F5kKUw==
X-Google-Smtp-Source: ALg8bN66+S1vlmhpTzUBfTCHQO0EWVpWO+n2QOjXmuTFCHBbBxmywXc3H+sQvYP9uc127clQclVRxVdQZFS0sytUjUU=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr5061008oic.33.1547071606398;
 Wed, 09 Jan 2019 14:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109111703.GA28605@lenoch> <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
 <20190109115824.GA1353@lenoch> <CAKfTPtAAgYYW8A1LDg18bM=5vCAMDbQ05APp9QWSaifW=F0SgQ@mail.gmail.com>
 <20190109133337.GA13579@lenoch> <CAKfTPtAsENRKh_wTFXCLW2_MdMBug+tV2KtjC7x6RigN7hgPmw@mail.gmail.com>
 <20190109160736.GA7416@lenoch> <CAKfTPtBnNA6knrsHsZXeaotBSn5mS12xNWNUKdSwZ1EUvueQkA@mail.gmail.com>
 <20190109172623.GB1711@lenoch> <CAKfTPtBGh+ShbNCZLiYr4PZJooun7uctuQaomc40czvAk5Yizg@mail.gmail.com>
In-Reply-To: <CAKfTPtBGh+ShbNCZLiYr4PZJooun7uctuQaomc40czvAk5Yizg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jan 2019 23:06:34 +0100
Message-ID: <CAJZ5v0jPJYyszAs4qJhqX+5RGwzJoo=+reTS__buoCrfTeYY8Q@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ladislav Michl <ladis@linux-mips.org>,
        Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 7:05 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 9 Jan 2019 at 18:26, Ladislav Michl <ladis@linux-mips.org> wrote:
> >
> > On Wed, Jan 09, 2019 at 05:32:31PM +0100, Vincent Guittot wrote:
> > > On Wed, 9 Jan 2019 at 17:07, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > >
> > > > On Wed, Jan 09, 2019 at 03:12:25PM +0100, Vincent Guittot wrote:
> > > > > Please keep all thread list when replying :-)
> > > >
> > > > Ahh, sorry for that...
> > > > [snip]
> > > > > On Wed, 9 Jan 2019 at 14:33, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > > > I agree, but it doea all the magic correctly, so you won't need
> > > > > > to touch that code is ktime_t changes (I know, unlikely..)
> > > > >
> > > > > But the current implementation doesn't care of any changes in ktime_t
> > > > > as it uses raw ns
> > > >
> > > > Fair enough, so let's go back to:
> > >
> > > This one looks good for me
> >
> > Lets split is for 'comments fix' patch, which was just send and 'the rest'.
> > Now, 'the rest' can either be v2 of your "PM/runtime: Fix autosuspend_delay on
> > 32bits arch" or will wait for 5.1. You decide :)
>
> I don't really mind.
>
> Rafael,
> Do you prefer to only take the fix for u64 casting problem or do you
> prefer to also take the optimization below in one single patch ?

The casting problem is a bug and the optimization is next release
material in my view.  Please send the optimization separately.
