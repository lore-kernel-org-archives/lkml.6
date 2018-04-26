Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbeDZTQa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:16:30 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43386 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeDZTQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:16:28 -0400
X-Google-Smtp-Source: AIpwx4+f7qNzP2S0FMSwM6c4WNd93mALstJYnRNee6c6h0XzFqIbWI8N+FTxah6gKnxMAw6cxH79rA==
Date: Thu, 26 Apr 2018 12:16:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lyan@suse.com, boris.ostrovsky@oracle.com, andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] Input: xen-kbdfront - allow better run-time configuration
Message-ID: <20180426191624.GB162443@dtor-ws>
References: <20180418150445.9805-1-andr2000@gmail.com>
 <ccb7a33b-7862-9803-fb24-67861d5ecab9@suse.com>
 <2bff035e-303e-d644-5f51-5e64150c097c@gmail.com>
 <20180423185325.GB66646@dtor-ws>
 <8ef84389-4659-d4bb-271f-53155062b7b6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ef84389-4659-d4bb-271f-53155062b7b6@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 08:55:19AM +0300, Oleksandr Andrushchenko wrote:
> On 04/23/2018 09:53 PM, Dmitry Torokhov wrote:
> > On Thu, Apr 19, 2018 at 02:44:19PM +0300, Oleksandr Andrushchenko wrote:
> > > On 04/19/2018 02:25 PM, Juergen Gross wrote:
> > > > On 18/04/18 17:04, Oleksandr Andrushchenko wrote:
> > > > > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > > > 
> > > > > It is now only possible to control if multi-touch virtual device
> > > > > is created or not (via the corresponding XenStore entries),
> > > > > but keyboard and pointer devices are always created.
> > > > Why don't you want to go that route for keyboard and mouse, too?
> > > > Or does this really make no sense?
> > > Well, I would prefer not to touch anything outside Linux and
> > > this driver. And these settings seem to be implementation specific.
> > > So, this is why introduce Linux module parameters and don't extend
> > > the kbdif protocol.
> > Why do you consider this implementation specific? How other guests
> > decide to forego creation of relative pointer device or keyboard-like
> > device?
> > 
> > You already have "features" for absolute pointing device and multitouch,
> > so please extend the protocol properly so you indeed do not code
> > something implementation-specific (i.e. module parameters).
> Ok, but in order to preserve the default behavior, e.g.
> pointer and keyboard devices are always created now, I'll have
> to have reverse features in the protocol:
>  - feature-no-pointer
>  - feature-no-keyboard
> The above may be set as a part of frontend's configuration and
> if missed are considered to be set to false.

I think you can have them as "feature-pointer" and "feature-keyboard"
(no negation), but assume not present considered enabled. I.e.

	kbd = xenbus_read_unsigned(..., XENKBD_FIELD_FEAT_KEYBOARD, 1);
	if (kbd) {
		...
	}

Thanks.

-- 
Dmitry
