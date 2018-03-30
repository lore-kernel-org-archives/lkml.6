Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeC3KH0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:07:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50040 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeC3KHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:07:25 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] power/hibernate: Change message when writing to /sys/power/resume
Date: Fri, 30 Mar 2018 12:07:41 +0200
Message-ID: <14931924.qmLzAlZrf0@aspire.rjw.lan>
In-Reply-To: <1522256470-2825-2-git-send-email-mario.limonciello@dell.com>
References: <1522256470-2825-1-git-send-email-mario.limonciello@dell.com> <1522256470-2825-2-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 28, 2018 7:01:10 PM CEST Mario Limonciello wrote:
> This file is used both for setting the wakeup device without kernel
> command line as well as for actually waking the system (when appropriate
> swap header is in place).
> 
> To avoid confusion on incorrect logs in system log downgrade the
> message to debug and make it clearer.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  kernel/power/hibernate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index d58fad3d..1028ecb 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1053,7 +1053,7 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	lock_system_sleep();
>  	swsusp_resume_device = res;
>  	unlock_system_sleep();
> -	pr_info("Starting manual resume from disk\n");
> +	pm_pr_dbg("Configured resume from disk to %u\n", swsusp_resume_device);
>  	noresume = 0;
>  	software_resume();
>  	return n;
> 

Both [1-2/2] applied, thanks!
