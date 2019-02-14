Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43980C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EF3222D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550154626;
	bh=IMMRQYO4G34EAT3MtGVyI8hF/noM/dk4PKXu4E3lHg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jyUMHGhPiETK/QR6QRZDODBjBpwULwRzYwinv0Q6NV3+0x8ZQWYV+tvvQGcW5kzZp
	 kjvX03Gm6FhrsuWYTobG0ALX4RoY2niBPitctJ7DYRuEz+vwXXhH7nA2lNfRIroTV9
	 7hndfUhLrPvEybWuI/pNUdFtz6c43M/fgdTfmfdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395252AbfBNOaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387633AbfBNOaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:30:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E7F9222D7;
        Thu, 14 Feb 2019 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550154622;
        bh=IMMRQYO4G34EAT3MtGVyI8hF/noM/dk4PKXu4E3lHg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9D9onDnJIm/9Xs5Rq68/aRjvh+UsG6Ytv/ReeYBLsVPeVcO8BluWhFN9o6VkvJKz
         /eti2nRIR4S/dAZJydYprK1qo2afCV+/fpmB5+aVIyDW+6bckc9KcS/RK41zJKNrgS
         pllrrq6nye4m6UuRSbxLpUzVjEKB8RKz9W7sO8AA=
Date:   Thu, 14 Feb 2019 15:30:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Kyle Tso <kyletso@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
Message-ID: <20190214143020.GA1317@kroah.com>
References: <20190131035411.53576-1-kyletso@google.com>
 <20190131070238.GA4500@kroah.com>
 <CAGZ6i=07EOHqd3r9y1MpYn_e1nFeYGt_wp9arhMZWWeTBm-udA@mail.gmail.com>
 <20190212105421.GA23271@kroah.com>
 <c838e214-4888-c708-6a7c-a8de6ecb5282@roeck-us.net>
 <AM5PR1001MB0994B54049DDCF2CE376263A80670@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB0994B54049DDCF2CE376263A80670@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 02:17:14PM +0000, Adam Thomson wrote:
> On 12 February 2019 16:20, Guenter Roeck wrote:
> 
> > On 2/12/19 2:54 AM, Greg KH wrote:
> > > On Tue, Feb 12, 2019 at 06:29:39PM +0800, Kyle Tso wrote:
> > >> On Thu, Jan 31, 2019 at 3:02 PM Greg KH <gregkh@linuxfoundation.org>
> > wrote:
> > >>
> > >>> On Thu, Jan 31, 2019 at 11:54:11AM +0800, Kyle Tso wrote:
> > >>>> Provide a function to get the partner Source Capabilities.
> > >>>>
> > >>>> Signed-off-by: Kyle Tso <kyletso@google.com>
> > >>>> ---
> > >>>>   drivers/usb/typec/tcpm/tcpm.c | 23 +++++++++++++++++++++++
> > >>>>   include/linux/usb/tcpm.h      |  1 +
> > >>>>   2 files changed, 24 insertions(+)
> > >>>>
> > >>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c
> > >>> b/drivers/usb/typec/tcpm/tcpm.c
> > >>>> index f1d3e54210df..29cd84ba9960 100644
> > >>>> --- a/drivers/usb/typec/tcpm/tcpm.c
> > >>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
> > >>>> @@ -4494,6 +4494,29 @@ int tcpm_update_sink_capabilities(struct
> > >>> tcpm_port *port, const u32 *pdo,
> > >>>>   }
> > >>>>   EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
> > >>>>
> > >>>> +/*
> > >>>> + * Don't call this function in interrupt context. Caller needs to
> > >>>> +free
> > >>> the
> > >>>> + * memory itself.
> > >>>> + */
> > >>>> +int tcpm_get_partner_src_caps(struct tcpm_port *port, u32
> > >>>> +**src_pdo) {
> > >>>> +     unsigned int nr_pdo;
> > >>>> +
> > >>>> +     if (port->nr_source_caps == 0)
> > >>>> +             return -ENODATA;
> > >>>> +
> > >>>> +     *src_pdo = kcalloc(port->nr_source_caps, sizeof(u32), GFP_KERNEL);
> > >>>> +     if (!src_pdo)
> > >>>> +             return -ENOMEM;
> > >>>> +
> > >>>> +     mutex_lock(&port->lock);
> > >>>> +     nr_pdo = tcpm_copy_pdos(*src_pdo, port->source_caps,
> > >>>> +                             port->nr_source_caps);
> > >>>> +     mutex_unlock(&port->lock);
> > >>>> +     return nr_pdo;
> > >>>> +}
> > >>>> +EXPORT_SYMBOL_GPL(tcpm_get_partner_src_caps);
> > >>>
> > >>> We don't add new functions that no one uses :(
> > >>>
> > >>>
> > >> This function is useful if the PD Device Policy Manager is
> > >> implemented outside of TCPM.
> > >> In this situation, Device Policy Manager needs to know the partner
> > >> capabilities to optimize the charging process.
> > >
> > > And where is that code?
> > >
> > 
> > Agreed - that code should be sent upstream as well to let us see the entire
> > context.
> > 
> > >> Take existing functions in TCPM for example:
> > >> Function "tcpm_update_sink_capabilities" and
> > >> "tcpm_update_source_capabilities" are exposed as well. And no one
> > >> uses them now.
> > >
> > > Great, let's go delete them now, we should not have apis that no one
> > > uses.  This isn't a new thing...
> > >
> > 
> > I sent a patch to do just that. Quite frankly I don't recal why I thought those
> > functions might be needed.
> 
> As a mind jog - https://lkml.org/lkml/2017/11/27/1256 :)

Nice find :)

Given that no one used these functions in over a year, we should be safe
deleting them.  If not, it's trivial to do 'git revert'.

thanks,

greg k-h
