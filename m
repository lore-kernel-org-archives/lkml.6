Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeBIBjW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 20:39:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38412 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBIBjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 20:39:20 -0500
X-Google-Smtp-Source: AH8x225UhT4us4VGsN4qh+PrHBX5tWktixgA9mscdb0FXQc03gHO11uur2UnI1kq3rm1/dgO+1eAAQ==
Date: Thu, 8 Feb 2018 17:39:16 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [git pull] Input updates for v4.15-rc8
Message-ID: <20180209013916.GA42766@dtor-ws>
References: <20180119174205.iq76oggc2h7neymf@dtor-ws>
 <b41e15f7-845a-6873-ddd1-0829b39319a4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b41e15f7-845a-6873-ddd1-0829b39319a4@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 11:04:22AM +0100, Jiri Slaby wrote:
> On 01/19/2018, 06:42 PM, Dmitry Torokhov wrote:
> > Please pull from:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> > 
> > to receive updates for the input subsystem. You will get:
> > 
> ...
> > - touchpad on Lenovo T640p is switched over to SMbus/RMI
> ...
> 
> > 王振杰 (1):
> >       Input: synaptics - Lenovo Thinkpad T460p devices should use RMI
> 
> Hi,
> 
> one of openSUSE users with T460p reports that the touchpad is defunct
> after resume in 4.15. psmouse.synaptics_intertouch=0 works around the
> problem.
> 
> The problem is:
>  kernel: rmi4_smbus 8-002c: failed to get SMBus version number!
>  kernel: rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed to read
> current IRQ mask.
>  kernel: rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -16.
>  kernel: rmi4_f01 rmi4-00.fn01: Resume failed with code -16.
>  kernel: rmi4_physical rmi4-00: Failed to suspend functions: -16
>  kernel: rmi4_smbus 8-002c: Failed to resume device: -16
>  kernel: rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03
> TX register (-16).
> 
> The downstream bug is at:
> https://bugzilla.suse.com/show_bug.cgi?id=1079862
> 
> Any ideas?

Hmm, maybe the seuence between psmouse and rmi/smbus is not quite right
on resume on that box. Can you ask the reporter to:

echo 1 > /sys/power/pm_print_times
suspend/resume

and send dmesg?

Thanks.

-- 
Dmitry
