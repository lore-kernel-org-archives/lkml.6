Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF3AC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3652173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551175718;
	bh=mLQxu1QmrXQ/N4CKKjpnxiqqEu6iX7jxIjlIihZTYDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J96VkrjEreFlDSQiNOZoUjCH1L/yv08qfiCrNg+xrwxgCAAzEOheaC60DcsW084jx
	 Q8XPa+hWzQ6JKByiB+huElkO0WYVYx3Vd/39VrJD/YzKyJtPwDbo6uo019wVzVsT94
	 JWeoWlcFsoHfw4h4DOigHRfefvNOtd9lHf7oK6ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfBZKIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:08:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfBZKIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:08:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A92C2173C;
        Tue, 26 Feb 2019 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551175716;
        bh=mLQxu1QmrXQ/N4CKKjpnxiqqEu6iX7jxIjlIihZTYDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l9G5ajb77fW5Xn3fzWXj/XfO2KP6RqmzfleY7vRZzwnfmMDlDScj6ytIg0b1WDDKj
         Rqx6tHgynIfqRcRd2YKXX1e3xIDvVrRL0HQ39dWlYDbinzzg3SoFFawVbABCW5LeOb
         FAPcu7GBVtYSIKfpndxutOVHJgz2rIDe3bn6uuZ8=
Date:   Tue, 26 Feb 2019 11:08:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 4.20 161/183] mac80211: Change default tx_sk_pacing_shift
 to 7
Message-ID: <20190226100833.GA9320@kroah.com>
References: <20190225195054.748060397@linuxfoundation.org>
 <20190225195122.158033941@linuxfoundation.org>
 <87k1hmrhzy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1hmrhzy.fsf@toke.dk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:55:45AM +0100, Toke Høiland-Jørgensen wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > 4.20-stable review patch.  If anyone has any objections, please let me
> > know.
> 
> LGTM. Any chance of getting this into 4.19 as well? It doesn't apply
> as-is, but I can send an equivalent patch (where?).

Yes, I didn't apply it to 4.19.y as it did not apply cleanly.  You can
send a backported version to stable@vger.kernel.org and I will be glad
to pick it up for the next release after these.

thanks,

greg k-h
