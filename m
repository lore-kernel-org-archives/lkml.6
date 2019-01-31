Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD596C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F3D218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548946744;
	bh=3DklHMK5y5WQItuvcGvRG1rmvAdKn1IwoxHiJV+lXL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2gdYyEdh+A5QJ1GdapRI7wKbEXbnrCuGfSm1ns/MxBIpAxc3in9mbmkHoP4rEE+/v
	 gCK+lk33g2ieej6n7pSFLifv4GHSmurKKZpD+eRkp0/yk8M68OJtI2fxiG58zULLDH
	 XgacpOwBhuf7EhbckaTUx1w77/+6a0pIvUYzfsNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfAaO7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:59:03 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37439 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaO7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:59:02 -0500
Received: by mail-yb1-f195.google.com with SMTP id 2so1411420ybw.4;
        Thu, 31 Jan 2019 06:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YisreuC3zrGql8vGIntXXcDgBVnywL4Va4Vu8WLo1iQ=;
        b=BnvTwXQl+sUA5bPGlHgb/uMP4W3E81CkUxMglbsvIAXefIlXexh7SNqgRgv1Mcrgb4
         LpusMYKTFLJQd9fNruMlTbE+Z/vWp00Mzs6c+rnZdaqFwZZOGdx0NWwy3ae9YKkzRZ36
         KaPqyUgzSfl1do7Zw8xldnsDaZ81VZpuHXuIx7hQZ40+HNoISRBVe9IdQmlk30sJoG6m
         zhbnPHDndqWtcBmdCXyLLyLINw504y7vZ5+MsXmcAnoS/MPwTTQZn0QCAsQEGZ01HO5T
         Y9Xh5M8u+TgEPti1zeNu0gbtoP5w4FMM+2OteO9OS6jJz/av8XbXR4xzgvXUdzza/Ad3
         c/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YisreuC3zrGql8vGIntXXcDgBVnywL4Va4Vu8WLo1iQ=;
        b=AEc3AK4uk9UILZHBMHLXyzk2LY7/IB3wCKdvOXHBuVZj3/yB9EKvs+G2ibAiq8VVcH
         TuSelQU/zE4fkAk23OcdyMhYcz4hbOViU39jelL3RB+H9rCu8kmDLTyklAa74M9byuBu
         KIArttS19+db12izkWIU5MANL/QLFie75whFiSPnLBzcYPhleKkhvUTs/yV7PkDQAvL9
         D3M0fvyqgolNkeJkiEQ2oZxHHKE55TzhYfGBiKDrZy9lZfLuhIU0Q5K7SWCYYKcy3J9z
         63cSS7jUS3ufEoIvMtZ5SgMfPiCl82KMPPs729dHku+7jmngIKUEfJSWH0cqyWhyZh/4
         g44Q==
X-Gm-Message-State: AJcUukeVL+utYVCiQhgnxTQpMMApODKMcovB2Q6tgNFPCHecuRqVzv1d
        QMpT9/ejM+SzsYwnFjNI/n4=
X-Google-Smtp-Source: ALg8bN7OXo00ss8PiGeB6OsfjUhW1ICbSrtqkj3Yt5GW1kPsemWuxJ6d8dM4Nz7L9eaUdyxYNICvAg==
X-Received: by 2002:a25:bfc8:: with SMTP id q8mr32277947ybm.78.1548946741564;
        Thu, 31 Jan 2019 06:59:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:b53a])
        by smtp.gmail.com with ESMTPSA id f62sm2090798ywd.68.2019.01.31.06.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 06:59:00 -0800 (PST)
Date:   Thu, 31 Jan 2019 06:58:58 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update cgroup entry
Message-ID: <20190131145858.GD50184@devbig004.ftw2.facebook.com>
References: <20190131142219.10175-1-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131142219.10175-1-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 03:22:19PM +0100, Andrea Parri wrote:
> Fix wildcard patterns and add cgroup-v2 documentation.
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Applied to cgroup/for-5.0.

Thanks.

-- 
tejun
