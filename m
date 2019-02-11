Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2466C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF7521B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="nIVjxsPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfBKSC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:02:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46019 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfBKSC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:02:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id r14so641039pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f++MmBXaPJCob+y5zj7VHYIu0GW7VfXf1nfSBVldpsU=;
        b=nIVjxsPCJ1HC7kBOnBRBDPxWikLhLvBWsONghvQ7jrXNnwbCxZB0VLpPrd27kymCK/
         xf8VRubhis7Zv3rEfy1gWIbKoj5D+qHq+DqYgKaymfJHeY13SUnepLUzeIaTvFsh9cnL
         S0KQRzWfrE7qenQ7YQYZfOfJDki/Ndt1yCWSmntO1rHEsbl8yGai4xaA8+SPnmdsB+tO
         rWhUzVMJDUIZuieM5HCWpZ8mdgOHQQhUSMjeHxL4lyZV91SaEF/jEnLLvafhrEx19Ea6
         LSZkEttEipX3Yr+87brw9TInnKxFEswEUKxiZzbh9QAZfHk0QGJdFEhJGb8Mhs/Tk2Yc
         EMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f++MmBXaPJCob+y5zj7VHYIu0GW7VfXf1nfSBVldpsU=;
        b=Mk9qd/jxprGdzBJqDv+ou20v8Bhf3Omqvipejo4uw47HX/7e0B3rSDeE0GKbUWbH9X
         1mtZh0krwzgjjhSNQfBEu4laCO4cZVkXRSYM73iV43SWY0bSgjP0bXV6nM95tbdYCkmY
         d+Wz+h/7i+Qe2fOCqsF7MsIsWlrTIEFFRCfpcY52kZm4gFadRCV9ZeNgabRiyelCMZuQ
         /UbPan4odppQcuhxqhmrwwO2HQ87kwYlNbdJ7Qx8O8WzgrDwZE2iGhpQoG6uWs/sS4/y
         atLcsICAjQMXj6LzcR6gIPYRGFBK7Ph9rjx5Dp6xHVokyXmyefDjCXnQaFZmlCPPlMU4
         zUIg==
X-Gm-Message-State: AHQUAubPkGeuMrkbHMEKY3yhEw4OTpdhuxMATpXXEcp66n/0U2lkQf5Z
        HgDVW0Pqm3Wek8bNq6Z5ryTgDA==
X-Google-Smtp-Source: AHgI3IaRpGhuzMtVkKtd8oHuGWL1qiJwGCg5YX6tVpWrKINr7WVY8cR+dCbBSh7C/tv8ttb/NIkj0w==
X-Received: by 2002:a17:902:8641:: with SMTP id y1mr38594173plt.159.1549908175051;
        Mon, 11 Feb 2019 10:02:55 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id l8sm24138991pgf.60.2019.02.11.10.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 10:02:54 -0800 (PST)
Date:   Mon, 11 Feb 2019 10:02:47 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, devel@linuxdriverproject.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Display nothing in sysfs if
 monitor_allocated not set
Message-ID: <20190211100247.12221570@hermes.lan>
In-Reply-To: <20190211070118.GA2977@ubu-Virtual-Machine>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
        <52d58fe5805f2ba2405c9091b4c86033d434d2b9.1549619051.git.kimbrownkd@gmail.com>
        <20190208143148.052c8d9c@hermes.lan>
        <20190211070118.GA2977@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 02:01:18 -0500
Kimberly Brown <kimbrownkd@gmail.com> wrote:

> On Fri, Feb 08, 2019 at 02:32:09PM -0800, Stephen Hemminger wrote:
> > On Fri, 8 Feb 2019 05:01:12 -0500
> > Kimberly Brown <kimbrownkd@gmail.com> wrote:
> > 
> > You are right, the current behavior is broken.
> > It would be good to add a description of under what conditions
> > monitor is not used. Is this some part of a project emulating
> > Hyper-V?
> >   
> 
> I'm not sure which conditions determine whether the monitor mechanism is
> used. I've searched the Hypervisor TLFS, and I couldn't find any
> information. If you have any suggestions for where I can find this
> information, please let me know.

The monitor page stuff pre-dates my involvement with Hyper-V. KY might know.
But based on comments it looks like it was added to avoid hypercalls
for each message. It probably showed up in Windows Server 2012 timeframe.

To test you might want to dig up Windows Server 2008.
 
> No, I'm not working on a project emulating Hyper-V.

OK, I had heard that KVM project was doing something with QEMU.

> >   
> > > +
> > > +	if (!hv_dev->channel->offermsg.monitor_allocated)
> > > +		return sprintf(buf, "\n");  
> > 
> > If monitor is not used, why not return an error instead of empty
> > data. Any program (or user) would have to handle that already.  
> 
> I think that returning an error instead is fine. I'll make this change
> in the next version of the patch.

