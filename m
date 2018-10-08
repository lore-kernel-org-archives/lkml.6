Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDAC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4B7204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv+0JXpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4B7204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeJHV41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJHV41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:56:27 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE3C3204EC;
        Mon,  8 Oct 2018 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539009863;
        bh=i98SgM2C+T2JAG+/vf6hIHL0F1AcYMdN3vsOjP8g8x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bv+0JXpWGrltq51XGy2vzU6FXBDzzayq4FBTx8lZzptRNSVlTBUzvf0QYni4NWv4R
         pA/s3I7aZLgg9SPPMECRkfh2nH8LXlbeclgvuKUSV1O9EDRKl9CoJkwkOIo5tG5bFy
         NGFUiPMOWsV8LuHqXKuCDkjqBXSPvsIEaRNw/D9k=
Date:   Mon, 8 Oct 2018 16:44:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Zhu, Rex" <Rex.Zhu@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
 smu7/8
Message-ID: <20181008144421.GB15968@kroah.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113125.488862921@linuxfoundation.org>
 <BN6PR12MB18092FFEF5BB3861912C8535F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR12MB18092FFEF5BB3861912C8535F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 02:33:56PM +0000, Deucher, Alexander wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, September 24, 2018 7:53 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > stable@vger.kernel.org; Wentland, Harry <Harry.Wentland@amd.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Rex
> > <Rex.Zhu@amd.com>; Sasha Levin <alexander.levin@microsoft.com>
> > Subject: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
> > smu7/8
> > 
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> 
> This regresses power usage on 4.18.  Please revert.
> https://bugzilla.kernel.org/show_bug.cgi?id=201275

Is it reverted in "upstream" as well?  If not, please get the fix in
there and then I will be glad to backport it here.

thanks,

greg k-h
