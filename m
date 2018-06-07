Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yT0zBkztGFs9dwAAmS7hNA
	; Thu, 07 Jun 2018 08:34:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1BAF56089E; Thu,  7 Jun 2018 08:34:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3fN0R5n"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 63B5A60452;
	Thu,  7 Jun 2018 08:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63B5A60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932641AbeFGIe2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752570AbeFGIe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:34:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA1D020874;
        Thu,  7 Jun 2018 08:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528360465;
        bh=P5WJNCsKG9nw3u6hXhYyXT9BaBN8VsWkuwVqXsD7UWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3fN0R5nxzJ2zrG/0z7eO452gv95RZkzspMkV0QohmtFbeUbi9kbxFOhLWB/A1CJ5
         Q02A4KezgI9kifOqwsBHDaqqXwxJqkwGXeV+1jUMXlMfeiRfMHvyslDI6ffs/NvVVV
         6GEbt0miuDg4V+n54N6XFpSuP58AiXckY2u7YJ7Y=
Date: Thu, 7 Jun 2018 10:34:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
Message-ID: <20180607083401.GE16651@kroah.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-6-kim.phillips@arm.com>
 <20180606082422.GB19727@kroah.com>
 <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
 <20180606155501.704583e1412996a1a2c6fa61@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606155501.704583e1412996a1a2c6fa61@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 03:55:01PM -0500, Kim Phillips wrote:
> On Wed, 6 Jun 2018 10:46:36 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> 
> > On 06/06/2018 09:24 AM, Greg Kroah-Hartman wrote:
> > > On Tue, Jun 05, 2018 at 04:07:01PM -0500, Kim Phillips wrote:
> > >> Increment the refcnt for driver modules in current use by calling
> > >> module_get in coresight_build_path and module_put in release_path.
> > >>
> > >> This prevents driver modules from being unloaded when they are in use,
> > >> either in sysfs or perf mode.
> > > 
> > > Why does it matter?  Shouldn't you be allowed to remove any module at
> > > any point in time, much like a networking driver?
> > > 
> > > 
> > >>
> > >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > >> Cc: Leo Yan <leo.yan@linaro.org>
> > >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > >> Cc: Randy Dunlap <rdunlap@infradead.org>
> > >> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> > >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >> Cc: Russell King <linux@armlinux.org.uk>
> > >> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> > >> ---
> > >>   drivers/hwtracing/coresight/coresight.c | 9 +++++++++
> > >>   1 file changed, 9 insertions(+)
> > >>
> > >> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> > >> index 338f1719641c..1c941351f1d1 100644
> > >> --- a/drivers/hwtracing/coresight/coresight.c
> > >> +++ b/drivers/hwtracing/coresight/coresight.c
> > >> @@ -465,6 +465,12 @@ static int _coresight_build_path(struct coresight_device *csdev,
> > >>   
> > >>   	node->csdev = csdev;
> > >>   	list_add(&node->link, path);
> > >> +
> > >> +	if (!try_module_get(csdev->dev.parent->driver->owner)) {
> > > 
> > > What is to keep parent->driver from going away right here?  What keeps
> > > parent around?  This feels very fragile to me, I don't see any locking
> > > anywhere around this code path to try to keep things in place.
> > 
> > You're right. We do have coresight_mutex, which is held across the build 
> > path and the csdev is removed when a device is unregistered. However, I
> > see that we don't hold the mutex while removing the connections from
> > coresight_unregister(). Holding the mutex should protect us from the
> > csdev being removed, while we build the path.
> 
> OK, I'll add this for the next version:
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index f96258de1e9b..da702507a55c 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1040,8 +1040,12 @@ EXPORT_SYMBOL_GPL(coresight_register);
>  
>  void coresight_unregister(struct coresight_device *csdev)
>  {
> +       mutex_lock(&coresight_mutex);
> +

Locks are to protect data, not code, be careful here please.

That's the big issue with the module reference counting, it "protects"
code, not data.  If at all possible, never grab a module reference
count, as you should always be able to unload a module, unless you have
a file handle open, and if you have that, the kernel core will properly
protect you.

thanks,

greg k-h
