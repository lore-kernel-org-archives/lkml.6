Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3282790-1519920003-2-15769273389660238805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519920002; b=dP+GOpdWilvTjUJL7/gEyQT9QTOec1tKWBDOx/qzxzdU6E2
    yQuE2PySLZbAV9l7E2LkLEec0lLO+ZLJIM0vAIe11tmuRSIifCJkiOgavKX0RRCx
    hrOAnplb0UfukuVm5nVnNR4Fd+kzYA0zVebSmHxTrmzZFC14aLw+FEuvQqVlS6y1
    9klCkGevt4Pc6VULVZ4JwyPBmNUhWVQ7UrkScuRtUxRncsmIJakYdMTUuv+ITHhU
    uYTCczdssehXnBdsDLw2DpfDNdXI5nvOh+Yqo/eEQWUJyFJHAhh8B7ChwdE+3px9
    4S0toV51Rl19uhbGChSl6bFRIPh++1C5/GGYyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519920002; bh=3KjwGXq9zqfDJoyOPNUgwUmau/n2O7wJI4+JfP
    AGo3Y=; b=jBjsyQnE6EjOjPRT5u0iW2c1tyIkBtYunB4MMzZAXYdavOFF3akOtF
    65tToifmraI27XOjD+LDNloAt8Eh2cXaFXsldMG9IqMAgDWD7eIZaXiEtKFz54Ot
    S33dHzPq+cAX1iZlWSbpXMoqMEQHvO/WmbWCt3H4GHeyN8uS3+pak3rBS/i/9gAR
    CjNq5qqNhHeEjRVOSYgHiOOuVoZsQR0Q6pA2crDVN8SvySP4WxR+gRbxJUv9eXZg
    1EOh6Rlke2CDJ8wEtrRg1FHrXwf/KJYakb4T4Nv5ZiknYBIfWWHByp27fObX6Edb
    Vkm116xXj+IgW4DeK5ak4jeU5vWN7W6w==
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
        id S1031996AbeCAP77 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 10:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031541AbeCAP76 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 10:59:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EB4217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELtxC3qqQX5wguNnWNQSlDFg5vVuunHEkxXFGeoEHwNCEd0XdzXpto38yhKFh2GK3Wx7ms4iSISKAyJLuOqEERo=
MIME-Version: 1.0
In-Reply-To: <20180301054935.GA8999@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-16-git-send-email-hao.wu@intel.com> <CANk1AXR9473+QqjF=R2JqqJGPB_XH9k+2qDhh68hN=5Fq4E7uw@mail.gmail.com>
 <20180301054935.GA8999@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Thu, 1 Mar 2018 09:59:16 -0600
X-Gmail-Original-Message-ID: <CANk1AXRp_oKnLemFS4C7MgJwyFsjOUxgbYN0=S5wdSiUP9iM0g@mail.gmail.com>
Message-ID: <CANk1AXRp_oKnLemFS4C7MgJwyFsjOUxgbYN0=S5wdSiUP9iM0g@mail.gmail.com>
Subject: Re: [PATCH v4 15/24] fpga: dfl-fme-pr: add compat_id support for
 dfl-fme-region platform device.
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 11:49 PM, Wu Hao <hao.wu@intel.com> wrote:
> On Wed, Feb 28, 2018 at 05:06:57PM -0600, Alan Tull wrote:
>> On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:

>> > +
>> > +       compat_id.id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
>> > +       compat_id.id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
>>
>> I tried building for 32 bit ARM and ran into readq and writeq not
>> being defined.  v2 had proper '#indef readq/writeq', so looks like we
>> need that after all.
>
> Sorry, it's missing a header file for dfl-fme-pr.h, as some files don't include
> dfl.h at this version. That header file has definitions for readq/writeq.
>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>
> will fix it.

Hi Hao,

That sounds good.  I was able to build if I added it.  There are a
couple issues in the enumeration code:

In file included from
/home/atull/repos/linux-socfpga/include/linux/kernel.h:11:0,
                 from /home/atull/repos/linux-socfpga/include/linux/list.h:9,
                 from /home/atull/repos/linux-socfpga/include/linux/module.h:9,
                 from /home/atull/repos/linux-socfpga/drivers/fpga/dfl.c:13:
/home/atull/repos/linux-socfpga/drivers/fpga/dfl.c: In function
'parse_feature_list':
/home/atull/repos/linux-socfpga/include/linux/bitops.h:7:24: warning:
left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (1UL << (nr))
                        ^
/home/atull/repos/linux-socfpga/drivers/fpga/dfl.h:73:19: note: in
expansion of macro 'BIT'
 #define DFH_EOL   BIT(40)   /* End of list */
                   ^
/home/atull/repos/linux-socfpga/drivers/fpga/dfl.c:643:12: note: in
expansion of macro 'DFH_EOL'
   if ((v & DFH_EOL) || !ofst)
            ^

and

  CC      drivers/fpga/dfl-fme-mgr.o
In file included from
/home/atull/repos/linux-socfpga/include/linux/kernel.h:11:0,
                 from /home/atull/repos/linux-socfpga/include/linux/list.h:9,
                 from
/home/atull/repos/linux-socfpga/include/linux/kobject.h:19,
                 from /home/atull/repos/linux-socfpga/include/linux/device.h:16,
                 from
/home/atull/repos/linux-socfpga/drivers/fpga/dfl-fme-pr.c:20:
/home/atull/repos/linux-socfpga/drivers/fpga/dfl-fme-pr.c: In function
'pr_mgmt_init':
/home/atull/repos/linux-socfpga/include/linux/bitops.h:7:24: warning:
left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (1UL << (nr))
                        ^
/home/atull/repos/linux-socfpga/drivers/fpga/dfl.h:113:27: note: in
expansion of macro 'BIT'
 #define FME_PORT_OFST_IMP BIT(60)
                           ^
/home/atull/repos/linux-socfpga/drivers/fpga/dfl-fme-pr.c:449:23:
note: in expansion of macro 'FME_PORT_OFST_IMP'
   if (!(port_offset & FME_PORT_OFST_IMP))
                       ^
Alan


>
> Thanks
> Hao
>
>> Alan
