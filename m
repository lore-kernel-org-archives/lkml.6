Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeBHKE2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:04:28 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:43531 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbeBHKE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:04:26 -0500
X-Google-Smtp-Source: AH8x227l3RrOVQpCHLbbewFbbw8vXA1zX5usjsEf0ugws3MlaU1dkGbTN1f9S9NVu/i/LSJ7q0qCKQ==
Subject: Re: [git pull] Input updates for v4.15-rc8
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20180119174205.iq76oggc2h7neymf@dtor-ws>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <b41e15f7-845a-6873-ddd1-0829b39319a4@suse.cz>
Date: Thu, 8 Feb 2018 11:04:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180119174205.iq76oggc2h7neymf@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/2018, 06:42 PM, Dmitry Torokhov wrote:
> Please pull from:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> 
> to receive updates for the input subsystem. You will get:
> 
...
> - touchpad on Lenovo T640p is switched over to SMbus/RMI
...

> 王振杰 (1):
>       Input: synaptics - Lenovo Thinkpad T460p devices should use RMI

Hi,

one of openSUSE users with T460p reports that the touchpad is defunct
after resume in 4.15. psmouse.synaptics_intertouch=0 works around the
problem.

The problem is:
 kernel: rmi4_smbus 8-002c: failed to get SMBus version number!
 kernel: rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed to read
current IRQ mask.
 kernel: rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -16.
 kernel: rmi4_f01 rmi4-00.fn01: Resume failed with code -16.
 kernel: rmi4_physical rmi4-00: Failed to suspend functions: -16
 kernel: rmi4_smbus 8-002c: Failed to resume device: -16
 kernel: rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03
TX register (-16).

The downstream bug is at:
https://bugzilla.suse.com/show_bug.cgi?id=1079862

Any ideas?

thanks,
-- 
js
suse labs
