Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28859C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1232152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1232152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeI0CR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:17:58 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:49293 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeI0CR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:17:58 -0400
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id D42336E;
        Wed, 26 Sep 2018 20:03:21 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.34.81.6])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 1B07E57;
        Wed, 26 Sep 2018 20:03:21 +0000 (UTC)
Date:   Wed, 26 Sep 2018 14:03:20 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     erosca@de.adit-jv.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V2 PATCH] selftests: watchdog: Add gettimeout and get|set
 pretimeout
Message-ID: <20180926200320.GB14558@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1537817767-78918-1-git-send-email-jerry.hoemann@hpe.com>
 <1537817767-78918-2-git-send-email-jerry.hoemann@hpe.com>
 <16941ebb-85ca-ad4c-de7b-c26f193ca611@kernel.org>
 <20180926162920.GB3948@anatevka.americas.hpqcorp.net>
 <ce60e815-10f1-08fd-d853-2629992a4a98@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce60e815-10f1-08fd-d853-2629992a4a98@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:47:25PM -0600, Shuah Khan wrote:
> On 09/26/2018 10:29 AM, Jerry Hoemann wrote:
> > On Tue, Sep 25, 2018 at 02:51:15PM -0600, Shuah Khan wrote:
> >> Hi Jerry,
> >>
> >>
> >> The rest looks good to me.
> 
> I spoke too soon. I ran your patch on softdog and error messages in unsupported
> cases could you refinement. Please see below:
> 
> Sorry for not catching this earlier.
> 
> >>
> >>>  }
> >>>  
> >>>  int main(int argc, char *argv[])
> >>> @@ -135,6 +142,30 @@ int main(int argc, char *argv[])
> >>>  			else
> >>>  				printf("WDIOC_SETTIMEOUT errno '%s'\n", strerror(errno));
> >>>  			break;
> >>> +		case 'T':
> >>> +			oneshot = 1;
> >>> +			ret = ioctl(fd, WDIOC_GETTIMEOUT, &flags);
> >>> +			if (!ret)
> >>> +				printf("WDIOC_GETTIMEOUT returns %u seconds.\n", flags);
> >>> +			else
> >>> +				printf("WDIOC_GETTIMEOUT errno '%s'\n", strerror(errno));
> 
> Either remove "errno" or change it to "error '%s'"

Oh, I see. I did a cut/paste from prior printf in file which have same issue.
I'll fix those while I'm at it.



-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
