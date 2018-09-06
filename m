Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99013C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9412083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="idC6XFBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9412083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeIGCGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeIGCGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:06:15 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 290D020844;
        Thu,  6 Sep 2018 21:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536269331;
        bh=U2Em47RNx0zHpIt/TgsF1VBPu32GHAmEL1EY4G5g7Vw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=idC6XFBdOzTYwV1lA0LnOjzPdBsI10FLUm3l8BTR1SRqIPFp04ysaTEvEwWnrIq96
         tpO4cLFgdy6zQ++CM2fyWP1WcsF91L6bSrqcgVM5tPs3O5vGVv9Zt7E+KcgWBaQ+up
         GjeidpF8pJOStlEDphkidkrCPkrSsaO5w9JTcOUA=
Received: by mail-yb1-f171.google.com with SMTP id k5-v6so4701128ybo.10;
        Thu, 06 Sep 2018 14:28:51 -0700 (PDT)
X-Gm-Message-State: APzg51BM2A1bb+kJUHzn0qkujXwFXvBt5i9otp5g1gZmfZRq6leuB/3V
        hiQdMiyYCOU7LGIUJ48kAe7XArg7bXhJGTN7TPw=
X-Google-Smtp-Source: ANB0VdZ9ggIt+pEsuV2NZzEZ8inRVhav69VRXXbZyOTRTHwUWNTqyyicBXuq5JJ/9N9xpVnYTWD8lq01fbYDvnWpU1w=
X-Received: by 2002:a25:db83:: with SMTP id g125-v6mr2656044ybf.412.1536269330424;
 Thu, 06 Sep 2018 14:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180904212237.3078-1-atull@kernel.org> <20180904212237.3078-7-atull@kernel.org>
 <20180906184338.GD20419@archbook>
In-Reply-To: <20180906184338.GD20419@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 6 Sep 2018 16:28:14 -0500
X-Gmail-Original-Message-ID: <CANk1AXQygEZYYrVVdWh5Z0M8ZLTEEH7E9CXxVBYx9JMgsNpm+Q@mail.gmail.com>
Message-ID: <CANk1AXQygEZYYrVVdWh5Z0M8ZLTEEH7E9CXxVBYx9JMgsNpm+Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] fpga: bridge: fix obvious function documentation error
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 1:43 PM Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

>
> On Tue, Sep 04, 2018 at 04:22:35PM -0500, Alan Tull wrote:
> > fpga_bridge_dev_match() returns a FPGA bridge struct, not a
> > FPGA manager struct so s/manager/bridge/.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Thanks!

Alan
