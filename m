Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3264212-1518626232-2-4403896414663813601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518626231; b=lFoatGKNzXoA740Qi0tcVoH2kkBs1pOgcn32/pEIG7ex+j2
    DRd4SWwD7r7uI11ek0sdRYgvEvxdS9SEhdRIfO+aogWgSzC2lq6uACCq3OaPZg6X
    Nqw6lTiU0TBHYZfiZvzW3UZXHYy0DocOAvG0MiUKfby1/c7e+qBh0U8CtGRJSdbB
    1Bf2jF8yekovUcn+LW+h5yKhRj7sm8cvEVS9UoPTvclsEYBj37eCZjYvEMVE46c6
    9iwmd6AfPGSUp+pADtkHqJXmjYRwGNmaLIUwJXRQhb4wdJfccwtQUr2CLDdUHH8c
    grLdLH92iioui2hTviOA/5dacqFFXB9HWfOSNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518626231; bh=OWwmtnQncPckM/4+r0KSxcxOYogRMxwi11WFDr
    n3oM4=; b=FUlsinDg3JcLd1jnfHumhaM2GcbDcsFyYr9N8BQ9mA3OrWPxgfYkqD
    pKIjW8Y8P1tWfESA2YGdo14+l0W0IR0CdJWotO3OiIKP/YRI/O69BdfGNedOPnZe
    68SrNAE5K5l6+6RbRPwL92hhwZenOoRBqHc+QV+BPG+DdkpOxMEnHKRfl45adV1U
    NivLrtyHTcJxjJwUczlOyxNyz3cIdKHxTJ/T2J6zMede+G8dnSs2hX/ugyAnfvbH
    CsIU1kyUvRxa1YzEOcOnt6vDDgcEu4LuFalKqK2hsaX2i5f7PLwhF57eVa1otLXC
    TQh0Tl95KuVrzOkFQlGawsrVHoMS6K6w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032563AbeBNQhJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 11:37:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032526AbeBNQhI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Feb 2018 11:37:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850A921726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AH8x227/ajtsrT24P7m0i29IzDKYly9JgkTtBpuhuQ6CnoepJ/eH9OpVuNyt5l5hJ6FsJo0fFZi38NwvxURE7d70u9s=
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-12-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-12-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 14 Feb 2018 10:36:26 -0600
X-Gmail-Original-Message-ID: <CANk1AXTDC2YROkdFyhnnAn28nwrv7UHt5_saFGDn4-8VRqS7Sw@mail.gmail.com>
Message-ID: <CANk1AXTDC2YROkdFyhnnAn28nwrv7UHt5_saFGDn4-8VRqS7Sw@mail.gmail.com>
Subject: Re: [PATCH v4 11/24] fpga: dfl: fme: add header sub feature support
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

Looks good.

> From: Kang Luwei <luwei.kang@intel.com>
>
> The Header Register set is always present for FPGA Management Engine (FME),
> this patch implements init and uinit function for header sub feature and
> introduce several read-only sysfs interfaces for the capability and status.
>
> Sysfs interfaces:
> * /sys/class/fpga_region/<regionX>/<dfl-fme.x>/ports_num
>   Read-only. Number of ports implemented
>
> * /sys/class/fpga_region/<regionX>/<dfl-fme.x>/bitstream_id
>   Read-only. Blue Bitstream (static FPGA region) identifier number. It contains
>   the detailed version and other information of this static FPGA region.
>
> * /sys/class/fpga_region/<regionX>/<dfl-fme.x>/bitstream_metadata
>   Read-only. Blue Bitstream (static FPGA region) meta data. It contains the
>   synthesis date, seed and other information of this static FPGA region.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan
