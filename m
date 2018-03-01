Return-Path: <arkadiusz.hiler@intel.com>
X-Google-Smtp-Source: AG47ELvRUmc2SdSB0vWRhJdUd/Scci/d1oPkwJlqSe8mOG1pSMiKzRXs8ZVptQRHFi/ovgsQ1EnL
ARC-Seal: i=1; a=rsa-sha256; t=1519911005; cv=none;
        d=google.com; s=arc-20160816;
        b=w51kPRSK5NtNnvUNkCINx1UHmPkfM/pLjQppF7EwNVYljuGzxE0Q0R41F8jLv2d7Q7
         l8gYSYFdSdusnQzqITvu3T5bNNWRIjjsQvDvbySF/VDS/dIeijStlberUw0aseCmlgjK
         ATOpd7uowIJ3MgfOPTs/CjgSIjehlJiLV8iMjun99cwUuKavenzh4eCr/h261DmjSe+h
         nPXFfcKeWIZzJjEnPRcpAd36oQoycJXWssWS5nKpfTzl4bX/2MRzb5p7y/stqw9A8TDZ
         /umW+lXACufxqZejgYYm+LWNHLrmKz1C/BtCNUx6f4gjbWpdACPyvyz0zC+SyHtUr+Nr
         Jdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=sMTOXA5KX7wz7+BbuZZbRbkXSrFfXXPAh580rkOppFg=;
        b=UNEhVJPcZhyIyA+B2Br57VmvfQlXbUPTydmCK0K44rvz8W8h89gN+DHtCmyTvYi2c1
         xl4O3H3ez5V5PhFvfUThwGp1ByyT3vb/7iSlBP6YaAqdYrDG06lbJ+67kLuFGxMmhkKx
         Ib2UzmzKYGJCqxOJBlsLM7Qu+csfi0u72egFJ89sYpkbI0n9DH2cA5QMbKk46g5euIeL
         Qqa0Ub9pxkOw84hmZ1LXGNQSvjpLYfOFK7idR3AqBpJs9tt9zRZwFGGAdRq074RIPiKb
         xFO4K7c03M2JFNEVQxjGpxjRZsjG2qZjLVb4ZXwXDheFu+i2WrtQS63GyCVvdxd0P9RJ
         f5tA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of arkadiusz.hiler@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=arkadiusz.hiler@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of arkadiusz.hiler@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=arkadiusz.hiler@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="208079273"
Date: Thu, 1 Mar 2018 15:29:59 +0200
From: Arkadiusz Hiler <arkadiusz.hiler@intel.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
CC: Jiri Slaby <jslaby@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	open list <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: rmi4 defunct on T460p [was: [git pull] Input updates for
 v4.15-rc8]
Message-ID: <20180301132959.GB27356@ahiler-desk1.ger.corp.intel.com>
References: <20180119174205.iq76oggc2h7neymf@dtor-ws>
 <b41e15f7-845a-6873-ddd1-0829b39319a4@suse.cz>
 <20180209013916.GA42766@dtor-ws>
 <6eb210d1-5b1b-d7ad-6188-e632fde2c6f7@suse.cz>
 <CAJ+F1CLFE=02hBY8paC83c-GjcPBM3YekAeYwxaporw8QczLFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CLFE=02hBY8paC83c-GjcPBM3YekAeYwxaporw8QczLFw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [10.237.68.151]
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1593742202370261986?=
X-GMAIL-MSGID: =?utf-8?q?1593742202370261986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 02:22:10PM +0100, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Feb 13, 2018 at 9:22 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> > On 02/09/2018, 02:39 AM, Dmitry Torokhov wrote:
> >> On Thu, Feb 08, 2018 at 11:04:22AM +0100, Jiri Slaby wrote:
> >>> On 01/19/2018, 06:42 PM, Dmitry Torokhov wrote:
> >>>> Please pull from:
> >>>>
> >>>>     git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> >>>>
> >>>> to receive updates for the input subsystem. You will get:
> >>>>
> >>> ...
> >>>> - touchpad on Lenovo T640p is switched over to SMbus/RMI
> >>> ...
> >>>
> >>>> 王振杰 (1):
> >>>>       Input: synaptics - Lenovo Thinkpad T460p devices should use RMI
> >>>
> >>> Hi,
> >>>
> >>> one of openSUSE users with T460p reports that the touchpad is defunct
> >>> after resume in 4.15. psmouse.synaptics_intertouch=0 works around the
> >>> problem.
> >>>
> >>> The problem is:
> >>>  kernel: rmi4_smbus 8-002c: failed to get SMBus version number!
> >>>  kernel: rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed to read
> >>> current IRQ mask.
> >>>  kernel: rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -16.
> >>>  kernel: rmi4_f01 rmi4-00.fn01: Resume failed with code -16.
> >>>  kernel: rmi4_physical rmi4-00: Failed to suspend functions: -16
> >>>  kernel: rmi4_smbus 8-002c: Failed to resume device: -16
> >>>  kernel: rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03
> >>> TX register (-16).
> >>>
> >>> The downstream bug is at:
> >>> https://bugzilla.suse.com/show_bug.cgi?id=1079862
> >>>
> >>> Any ideas?
> >>
> >> Hmm, maybe the seuence between psmouse and rmi/smbus is not quite right
> >> on resume on that box. Can you ask the reporter to:
> >>
> >> echo 1 > /sys/power/pm_print_times
> >> suspend/resume
> >
> > He uploaded it here:
> > https://bugzilla.suse.com/attachment.cgi?id=759933
> >
> 
> Same problem (with f27 and upstream kernel), is there anything else we
> can do to help? Should we open a bug on http://bugzilla.kernel.org ?
> 
> thanks

There are already two reverts on this mailing list that fix the problem.

https://patchwork.kernel.org/patch/10239877/
and
https://patchwork.kernel.org/patch/10228565/

Since the regression made it to the stable kernel and this is not moving
I think it's appropiate to cc Greg here.

- Arek
