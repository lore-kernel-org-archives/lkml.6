Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C8BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DBE2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1EiP87qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DBE2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeI1CIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:08:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40394 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbeI1CIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:08:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id g14-v6so3758339otj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aksygoKyaHVHwoMtXp2ALL1a/T9Exh0CtWUmOEjrnw4=;
        b=1EiP87qz/XgbBzl3UD++aXolY6RqvLAEmUW/qpCu6+zrtKGOsj+UCBUt7EfrF3mXHU
         LtnWybSGDNPudsFc0jygspEn/C1qK7O0Uqz97wv4RcylNSb9qnUWnqxZKbTCfyUK2f3w
         3D1g0cj6fJz1YQ1rbL7U2P5slOPVuss2++I3PfcX8t/NnC+MFzQelLqyBUy6okJS2ba1
         y765dltcG03NlqZ08Q2arHvcChVPyMTDIXM8aFO32XqnWD+ZOt9OvhsEgLALu+2ptVaw
         VCMNMJWDe+918yHJk2j7dxpIZbEFQjkjbRN/qcJEMRNR1r2XFtvp4JCEhsKp33uPnr4R
         vJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aksygoKyaHVHwoMtXp2ALL1a/T9Exh0CtWUmOEjrnw4=;
        b=nilMc3oUOCx6TNYJrPQwPoOKlMA6glaulnD6/vzMgpEXpOB7Myq82n1xiy+Jw3nx2A
         ETjW9U3qCaaEtOVOzghypXt9OpidF1hPT02rkRT5sAW1xGEYO2ZXwrIt5ksvGJeL+v6M
         pedwio9RFQXEKkLb1uMtSNwuk+50oD875A373odIdEr9h9tUZV7pGCGXIL2jz2Q2pwS2
         Nj6vbGezYMTYvxy+p3tSHzkClxoIDcKpGM/ST9woPJct87unxicYfCiXRRVRdwjQs/ht
         szn49Fhb0u4UvAAaD0pfOwBr+Pi2zvWEvuOWv0R8faWDvJqBv73gUU7ttoiVZfodn5gk
         29xg==
X-Gm-Message-State: ABuFfohbPmaEo6vcyR13g+F/F+rcOsMlKjZVNg9zksC0Qn2bJ+dRtDY3
        ryAci/uoKQmr4HPjAYiNElQT4vs3PgONEwbx5my9hQ==
X-Google-Smtp-Source: ACcGV60d5buf/PN98WXbR+bwESO9PLXAjrgAcaj5FEuVg968qSJYWx4uoitIf+uiqrxVT5hZeLn7vB0XX0tlKNS0ju4=
X-Received: by 2002:a9d:2e21:: with SMTP id q30-v6mr7677923otb.98.1538077734194;
 Thu, 27 Sep 2018 12:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215143.13512.56522.stgit@localhost.localdomain> <CAPcyv4iJOYiM+rHsM4GPifKNJ=X+AtV2MgWTn+f7u0VBzXb2og@mail.gmail.com>
 <d16cabf9-28f7-31e2-c43d-027738185518@linux.intel.com>
In-Reply-To: <d16cabf9-28f7-31e2-c43d-027738185518@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Sep 2018 12:48:42 -0700
Message-ID: <CAPcyv4iJeb-tJZVWRziwHQ-ug2P8Hgov2FSGvaXDOjw337kfMg@mail.gmail.com>
Subject: Re: [RFC workqueue/driver-core PATCH 2/5] async: Add support for
 queueing on specific NUMA node
To:     alexander.h.duyck@linux.intel.com
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        jiangshanlai@gmail.com, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 8:24 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
[..]
> >> - * Returns an async_cookie_t that may be used for checkpointing later.
> >> - * @domain may be used in the async_synchronize_*_domain() functions to
> >> - * wait within a certain synchronization domain rather than globally.  A
> >> - * synchronization domain is specified via @domain.  Note: This function
> >> - * may be called from atomic or non-atomic contexts.
> >> + * Device specific version of async_schedule_near_domain that provides some
> >> + * NUMA awareness based on the device node.
> >> + */
> >> +async_cookie_t async_schedule_dev_domain(async_func_t func, struct device *dev,
> >> +                                        struct async_domain *domain)
> >> +{
> >> +       return async_schedule_near_domain(func, dev, dev_to_node(dev), domain);
> >> +}
> >> +EXPORT_SYMBOL_GPL(async_schedule_dev_domain);
> >
> > This seems unnecessary and restrictive. Callers may want to pass
> > something other than dev as the parameter to the async function, and
> > dev_to_node() is not on onerous burden to place on callers.
>
>
> That is what async_schedule_near_domain is for, they can call that. The
> "dev" versions of the calls as just supposed to be helpers since one of
> the most common parameters to the async_schedule calls is a device, so I
> thought I would just put together a function that takes care of all this
> for us so I could drop an argument and avoid having to use dev_to_node
> everywhere.

Yeah, makes sense, I guess I was reacting to the fact that this
expands the number of exports unnecessarily. The other async routines
are exported because they hide internal implementation details of the
async implementation. The async_schedule_dev* helpers can just be
static inline wrappers.
