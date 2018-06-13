Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1C38DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C343E208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LBzWxVrG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LBzWxVrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C343E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935506AbeFMS3E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:29:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935202AbeFMS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:29:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EAAEE607E4; Wed, 13 Jun 2018 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528914541;
        bh=NoUUW4RU+MChkXxjxz3EgekvSB/hGsWURRRdeWLALHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBzWxVrGNZ2r0NW5zJmZe4G0Yc4NfjBeNN+syLTAK0dit2nmLjd9oaVe1ikUMCH9B
         n8ZT3oyWv0EREXG4VAJ6B3sK8KiceRjhH60RcRgbn2j9lTL1vuuZ5gcfzaabzD9TGQ
         F0+LmGbyCfXTOPGnXvb9jmEZix1cSXISLjEjCGhE=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B0FA60717;
        Wed, 13 Jun 2018 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528914541;
        bh=NoUUW4RU+MChkXxjxz3EgekvSB/hGsWURRRdeWLALHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBzWxVrGNZ2r0NW5zJmZe4G0Yc4NfjBeNN+syLTAK0dit2nmLjd9oaVe1ikUMCH9B
         n8ZT3oyWv0EREXG4VAJ6B3sK8KiceRjhH60RcRgbn2j9lTL1vuuZ5gcfzaabzD9TGQ
         F0+LmGbyCfXTOPGnXvb9jmEZix1cSXISLjEjCGhE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B0FA60717
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 13 Jun 2018 12:29:00 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     David Collins <collinsd@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] soc: qcom: rpmh powerdomain driver
Message-ID: <20180613182900.GB22824@codeaurora.org>
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-6-rnayak@codeaurora.org>
 <215deee5-6472-d587-9a90-f7158162ed82@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <215deee5-6472-d587-9a90-f7158162ed82@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25 2018 at 19:08 -0600, David Collins wrote:
>Hello Rajendra,
>
>On 05/25/2018 03:01 AM, Rajendra Nayak wrote:
>> +
>> +	to_active_sleep(pd, pd->corner, &this_corner, &this_sleep_corner);
>> +
>> +	if (peer && peer->enabled)
>> +		to_active_sleep(peer, peer->corner, &peer_corner,
>> +				&peer_sleep_corner);
>> +
>> +	active_corner = max(this_corner, peer_corner);
>> +
>> +	ret = rpmhpd_send_corner(pd, RPMH_ACTIVE_ONLY_STATE, active_corner);
>> +	if (ret)
>> +		return ret;
>> +
>> +	sleep_corner = max(this_sleep_corner, peer_sleep_corner);
>> +
>> +	return rpmhpd_send_corner(pd, RPMH_SLEEP_STATE, sleep_corner);
>> +}
>
>This aggregation function as well as the rpmhpd_send_corner() calls below
>are not sufficient for RPMh.  There are 3 states that must all be used:
>RPMH_ACTIVE_ONLY_STATE, RPMH_WAKE_ONLY_STATE, and RPMH_SLEEP_STATE.  The
>naming is somewhat confusing as rpmhpd is defining a different concept of
>active-only.
>
>For power domains without active-only or peers, only
>RPMH_ACTIVE_ONLY_STATE should be used.  This instructs RPMh to issue the
>request immediately.
>
>For power domains with active-only, requests will need to be made for all
>three.  active_corner would be sent for both RPMH_ACTIVE_ONLY_STATE (so
>that the request takes effect immediately) and RPMH_WAKE_ONLY_STATE (so
>that the request is inserted into the wake TCS).  sleep_corner would be
>sent for RPMH_SLEEP_STATE (so that the request is inserted into the sleep
>TCS).
>
>You can see how this is handled in the RPMh clock driver in patch [3].
>
>You may be able to get away with using only RPMH_SLEEP_STATE and
>RPMH_ACTIVE_ONLY_STATE assuming that you issue the RPMH_SLEEP_STATE
>request first due to the rpmh driver caching behavior added in the
>cache_rpm_request() function in [4].  However, could you please confirm
>with Lina that this usage will continue to work in the future?  I'm not
>sure what guarantees are made at the rpmh API level.
>
We expect to cache all active values into wake if there was a sleep
value already defined. Expect to continue this behavior in the future
as well. But it would be safer for you to send sleep and wake votes in
addition to active votes. It shouldn't add too much of an overhead.

-- Lina

