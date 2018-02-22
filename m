Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbeBVTuK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:50:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeBVTuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:50:09 -0500
Date: Thu, 22 Feb 2018 11:50:00 -0800
From: Darren Hart <dvhart@infradead.org>
To: Mario.Limonciello@dell.com
Cc: jeremy@jcline.org, notmart@gmail.com, pali.rohar@gmail.com,
        andriy.shevchenko@linux.intel.com, mjg59@srcf.ucam.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
Message-ID: <20180222195000.GE19843@fury>
References: <1628582.nV6hDClBbL@phobos>
 <01000161bdd7f206-c8d87cce-1b8c-4888-8d6a-5247198b3ead-000000@email.amazonses.com>
 <CAD6_Bos5Qrvz=Mr_rYCZXZ1s=5+8rawfZXxzXSvyc-tLBO07fg@mail.gmail.com>
 <b9b9ad823d9e49df82fc4626124c2a14@ausx13mpc120.AMER.DELL.COM>
 <01000161be3d1072-1c155203-359c-4566-9af6-2ebc33ad43ee-000000@email.amazonses.com>
 <c7694c9b4780413cb9621b0f3dd1501d@ausx13mpc120.AMER.DELL.COM>
 <01000161be4dbc6d-571d7479-35a2-4c6d-b3e0-f2405fc2064a-000000@email.amazonses.com>
 <722a48c6c0354609bf34f86c4269aef9@ausx13mpc120.AMER.DELL.COM>
 <01000161be64cac2-b17509ef-f7e5-4134-9188-941d7f5ac687-000000@email.amazonses.com>
 <88473a72368b43bdacebca279092ab0f@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88473a72368b43bdacebca279092ab0f@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 05:05:39PM +0000, Mario.Limonciello@dell.com wrote:
...
> OK thanks for confirming.  Here's what I've concluded:
> 
> * So looking through the ACPI tables on the 9360 it initializes that status
> (slate vs laptop mode) bit to "slate" mode.  The 9360 isn't a 2-in1- so that
> seems wrong to me, but that's what it does.
> It only gets updated based on dock status.
> 
> The 9365 (which is a 2 in 1) however seems to initialize the status properly.
> 
> So that's an impasse of what to do.
> It's not clear to me what is really happening:
> a) We're missing something else in this driver (eg something else that 
> indicates whether to trust VGBS output)
> 
> b) Mis-interpreting the results from it (we shouldn't report the switch for 
> tablet mode based on what we do)
> 
> c) 9360 has a BIOS bug (seems unlikely since Windows doesn't freak out and
> show virtual keyboard at wrong time)
> 
> I'm leaning on it's probably <a>.
> We should check for tablet mode should only be run if chassis type 
> matches 2-in-1 (chassis type 0x1F).  

This sounds like a good approach to me.

> I believe that should fix the problem on the 9360, let it continue to work on
> the 9365 (and other 2-in-1's).
> 
> Can you guys please test this?  If that works I'll split up the routine and submit
> it.

Queueing this up as well.
-- 
Darren Hart
VMware Open Source Technology Center
