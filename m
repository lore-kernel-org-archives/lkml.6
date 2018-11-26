Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50193C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052BB213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052BB213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeK0Jb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:31:26 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42267 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbeK0Jb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:31:26 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so19610324qtq.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 14:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=qXxkPjsHIVgepAZ0xZ4OAkXymLVi1EmXXE216dj8PyA=;
        b=q/EQ3seL8V9SESqlyr+rxV36LPwSKBx2HaHSVwWUTY/hP6XdV4YOEihtyv7SBf3zQC
         Mb98sjlQxhK9qiPdsmXNUHxeB2HyFSeMwY9mEHcSty+HjH3G/HnIeNjE8Niv1GAOzMdu
         JWW7YYvlXxyJfK+zWAAC7oLLiScX5QMVL31+RemDZPD6/Gzabaudg6lf+bskd6ZRSugB
         ah4En8ZE+ZsAyub6ytAP77iZu4puWqnvgqvs+8OBtouKmIFh1T3Dz2pN6R4j0WgZjLHZ
         /OnuJA/6bEjCILqCCxAZcuzBPKI3BMbFFg+ANApJU+/5P964UPrZC0Q35o+2UX5IBSbV
         lYKQ==
X-Gm-Message-State: AA+aEWaHy+9SBuwrWcIVK1InZ5X0kGkbpkQK8V//O42VhqzDTSyLsq8F
        wv+RuuwHGjhmSSMnmeqS+u1n8Q==
X-Google-Smtp-Source: AFSGD/XWc0nTTkTp9EeNVBGAsUrtYRM5W64nluBztnxIRUDauJ8Py1tpiv47zoX+NMAXB4j2Fo25cg==
X-Received: by 2002:a0c:ba24:: with SMTP id w36mr28141323qvf.60.1543271746885;
        Mon, 26 Nov 2018 14:35:46 -0800 (PST)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id v50sm1354675qtc.7.2018.11.26.14.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 14:35:46 -0800 (PST)
Message-ID: <ad0799bd71afec272b7c76b1833c45ba47848029.camel@redhat.com>
Subject: Re: [RESEND PATCH v2 1/2] drm/dp/mst: Reprobe EDID for MST ports on
 resume
From:   Lyude Paul <lyude@redhat.com>
To:     "Li, Juston" <juston.li@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc:     "Ciobanu, Nathan D" <nathan.d.ciobanu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Taylor, Clinton A" <clinton.a.taylor@intel.com>,
        "jared_dominguez@dell.com" <jared_dominguez@dell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "cpaul@redhat.com" <cpaul@redhat.com>
Date:   Mon, 26 Nov 2018 17:35:43 -0500
In-Reply-To: <cfbb393ffa55af35a0db0b9412e0a3847dcf7055.camel@intel.com>
References: <20181024021925.27026-1-juston.li@intel.com>
         <20181024021925.27026-2-juston.li@intel.com>
         <f9b43dde4868d3c079b652b48babde9b8bebc728.camel@redhat.com>
         <ee20a313fb63792c05ab1b67babf1fa9431ebcf8.camel@intel.com>
         <a0646cacfbc4ed8ded12f15d7553c60553adac34.camel@redhat.com>
         <cfbb393ffa55af35a0db0b9412e0a3847dcf7055.camel@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 21:53 +0000, Li, Juston wrote:
> Sorry for the late reply, email got caught in a bad filter =/
> 
> I haven't been looking into it lately but we are still interested in
> getting this fixed so I can start looking into this again.
> 
> In your last email you mentioned a sysfs hotplug could be the way to
> go?
I had thought so; but I did a little more investigation and it looks like I
wasn't totally wrong when I first wrote this patch; we actually do need to
destroy the previous topology when it's not actually there and prevent the
driver from trying to set it up again. Something that apparently a simple
sysfs hotplug won't do.

I think what we might be able to do is instead of comparing against the
connector's EDID, we should try repurposing drm_dp_mst_port->cached_edid so
that it holds a copy of each mst connector's EDID instead of just logical
MSTBs, then compare against those EDIDs instead of the ones we assigned to the
drm_connector to avoid the lockdep issues that would occur from trying to grab
dev->mode_config.mutex from the suspend/resume codepaths, and decide from
where whether or not to tell the driver to cut off the topology.

Feel free to poke me about this on irc btw, might be quicker to discuss it
there
> 
> Thanks
> Juston
> 
> On Thu, 2018-11-08 at 19:43 -0500, Lyude Paul wrote:
> > Are you still looking into this at all? Even if it's not the right
> > approach
> > I'm still interested in seeing this get fixed as well/discussing what
> > I said
> > before
> > 
> > On Wed, 2018-10-24 at 22:45 +0000, Li, Juston wrote:
> > > On Wed, 2018-10-24 at 18:09 -0400, Lyude Paul wrote:
> > > > Since there's going to be quite a number of changes I need to
> > > > make to
> > > > this I'm
> > > > just going to make the changes myself! I'll make sure to Cc you
> > > > with
> > > > the
> > > > respin
> > > 
> > > Sounds good, thanks for picking it up!
> > > 
> > > Juston
> > > 
-- 
Cheers,
	Lyude Paul

