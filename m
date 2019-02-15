Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4577C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2C520836
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhWSoIL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbfBOC1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:27:55 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35604 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbfBOC1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:27:52 -0500
Received: by mail-it1-f195.google.com with SMTP id v72so19926066itc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FbjK01imgIQbfuGT+Pca7eV/Iab31UETe/uorT92hwg=;
        b=BhWSoIL6ANsVEkRXDEHlGHLM60c7shqLl+bRbjRDJCA1HVWtKewz80+utw1mK2CN7S
         4FwFyLmFdfVvkJRi6QjpTJsJn2FHAzm12EzDcqUv7cCp5A47LY5jlGImBckBXzH1V3TY
         Djg0f4+7W/D4Hl07EMkiBBOncAf423P3PANE9c4mvVnXlMc8XUSSydiyp3GLS2qYQ/xw
         IKiqPjXulA0ADB0XkAcq0pQnQYAsAgBGdwWTTkSN8QiHCDMFCvf73ttd3RgR3fQgrEQW
         9ptewuWT70xOoo/+M0lT+QDRdMakRrb5R1YozpAoxnNaURUaCUlKadgA4yKZVErmZw9v
         pz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FbjK01imgIQbfuGT+Pca7eV/Iab31UETe/uorT92hwg=;
        b=S+4CdL/e8UGAD8ny1f0HdMpRcZtEvhpIOMo2WGHKyJIyEPrrKLrvYhgyACuxqSZOk+
         2ux8To8n0vDnFWnUabPIU69g/XDqwNefrFPN6PDjnISOYhP3igcof9N4tUFBd6BNELTm
         6wHJrsPJadZWwKYtV6l8we2Rfdlg30p/f6Pg/Base6x07Rgg//hgKeknnymHaPvzpKtT
         gXHS6cz+sOjVn5xfeQr7cPWZLxfRtLLMEpml7oXn/e+kl4tBq44OU9P/4E9sVgv2hb2y
         z7uaoMhyEmzz4yv15Ojsjnn4Fpk4QUYF8khAWPJeDV/Aec8OVLARiNDZc0uLyzq/4AAT
         pBlA==
X-Gm-Message-State: AHQUAubnPLDimjM5MgDsybBsXyA7i1nbytz5QMj2KmRviq1qHg8+ZjhJ
        pd9Q8xNZEQN9dBIXwKgJF2QvIsVwxZc=
X-Google-Smtp-Source: AHgI3IZdoRW+CG7HHXNeh2V6jfHY/an1BgDFkdsmohVVOUNWDJRcGvOxv6gu0FZhEhg/QI2fPtBeXQ==
X-Received: by 2002:a05:660c:1cc:: with SMTP id s12mr3666356itk.33.1550197670531;
        Thu, 14 Feb 2019 18:27:50 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id p18sm126008itp.10.2019.02.14.18.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 18:27:49 -0800 (PST)
Date:   Thu, 14 Feb 2019 21:27:47 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Message-ID: <20190215022747.GA53910@ubu-Virtual-Machine>
References: <20190122064246.GA28613@ubu-Virtual-Machine>
 <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190128195845.GA3723@ubu-Virtual-Machine>
 <PU1P153MB01699B96311157EA9DF515E6BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190131151958.GT3973@sasha-vm>
 <DM5PR2101MB091847B2B68D7F9F2050CE45D7910@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <20190131174707.GA2055@ubu-Virtual-Machine>
 <PU1P153MB0169227534F832C2DAEC02B4BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190202200735.GA2637@ubu-Virtual-Machine>
 <20190215015431.GK69686@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215015431.GK69686@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 08:54:31PM -0500, Sasha Levin wrote:
> On Sat, Feb 02, 2019 at 03:07:35PM -0500, Kimberly Brown wrote:
> > On Fri, Feb 01, 2019 at 06:24:24PM +0000, Dexuan Cui wrote:
> > > > From: Kimberly Brown <kimbrownkd@gmail.com>
> > > > Sent: Thursday, January 31, 2019 9:47 AM
> > > > ...
> > > > 2) Prevent a deadlock that can occur between the proposed mutex_lock()
> > > > call in the vmbus_chan_attr_show() function and the sysfs/kernfs functions.
> > > Hi Kim,
> > > Can you please share more details about the deadlock?
> > > It's unclear to me how the deadlock happens.
> > > 
> > 
> > Hi Dexuan,
> > 
> > I encountered the deadlock by:
> > 1) Adding a call to msleep() before acquiring the mutex in
> > vmbus_chan_attr_show()
> > 2) Opening a hv_netvsc subchannel's sysfs file
> > 3) Removing hv_netvsc while the sysfs file is opening
> 
> Dexuan, any objections to pulling this fix in?
> 

Hi Sasha,

This fix can cause a deadlock. I'm working on a different fix for the
original race condition problem.

Thanks,
Kim

> --
> Thanks,
> Sasha
