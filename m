Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4175430-1518920131-2-11105040733510458166
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518920131; b=dzv79GFpFTfPfV2ymy0Dg3C+iERog78tbqdtzKO5nsJlinC
    J2ZS3+sjgJ72DchKN/DzrujlGPQ+csZ/Ajqdvld1lfX+h0yEo7ytVMr85Q0YHnLC
    t19iSOXOhi+hkDRwMo1yMgwFniLqig4TdLt4yOWNNy5lBAoi+YhGErP2kzy2Sfun
    IO685kcBzdu0rRFUFNJ5kyDEaTe6o5rksUA5XdhrHfb07iYaayUj1w1TtZY5Uxjn
    8IqocvFte1Q2xxovg0RfLbv8/vaeW5UnAnmVDoOtiD15u1m1wYuz0d97QSSl9Y9r
    tTsq+WcfvpfCYoAptwy/aYqgunVfuMAeIZne9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1518920131; bh=s5Gc0B
    TNmhSNKbU9KNf3b1xl8ozaXuRaWs01qb2lKb0=; b=ETdNNtxdTFBe9nhzJnnfsb
    sDEhtBbBQbIUCOZzPoWxFhgPNfvkptE9pXMTF4EK+dokGe2+whTpZz+NLCSEz0fo
    8Y0MVFDKwqPLwSf+kc5TCM1W38vXs0vGM2WCwfVRYc8a+CZxgxcDh01oIVvJMybQ
    A7vh+r/pGd/Xyn0YyMa66/MWS1XUOMsXk+2BAuNHvB+I2fg0q4Mgy5Z4D4gYXKnz
    p6qoeFTa/Wabi/t67r/F6vK3PuoBF/yQR5BmRrQifiDyP7v55UIY1NA7JXJYTyqP
    Hecf0F7N3c7hg4dIUyp/f1bgCQ6nggC3k/eNocoKPmz9SWBfVpVEtrS8q9ctfK0g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeBRCP0 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Sat, 17 Feb 2018 21:15:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:9643 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeBRCPZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 17 Feb 2018 21:15:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,527,1511856000";
   d="scan'208";a="201959724"
From: "Wu, Hao" <hao.wu@intel.com>
To: Moritz Fischer <mdf@kernel.org>
CC: Alan Tull <atull@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        "Whisonant, Tim" <tim.whisonant@intel.com>,
        "Luebbers, Enno" <enno.luebbers@intel.com>,
        "Rao, Shiva" <shiva.rao@intel.com>,
        "Rauer, Christopher" <christopher.rauer@intel.com>
Subject: RE: [PATCH v4 07/24] fpga: dfl: add feature device infrastructure
Thread-Topic: [PATCH v4 07/24] fpga: dfl: add feature device infrastructure
Thread-Index: AQHTpK4DVba3ru3Qfk6Vgd/PbQo+oqOj3wKAgAAC9QCAAVknQIAAIXaAgAQVgCA=
Date: Sun, 18 Feb 2018 02:15:18 +0000
Message-ID: <BE8371DA886269458E0220A16DC1F8277E156640@SHSMSX104.ccr.corp.intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-8-git-send-email-hao.wu@intel.com>
 <20180214210319.GC25618@tyrael.ni.corp.natinst.com>
 <CANk1AXRksJum6s5yB5727136DBLHs4UPW7xaLn_dT5qMEfqm9A@mail.gmail.com>
 <BE8371DA886269458E0220A16DC1F8277E154EC0@SHSMSX104.ccr.corp.intel.com>
 <20180215194901.GA4382@tyrael.ni.corp.natinst.com>
In-Reply-To: <20180215194901.GA4382@tyrael.ni.corp.natinst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTYxMTk1OTgtZjBlNi00MTE3LTljN2YtMjg5YTRmNTc0MDJjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJ5Q0ZRZm5POGlxYXp5clZFaDFsZmVKeklyYXUyVUVkTWdxaXo4QXpxYytqQ3FiVGUyRlE3dVBKUnlHR1NcL2Q3aCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On Thu, Feb 15, 2018 at 10:05:20AM +0000, Wu, Hao wrote:
> > > On Wed, Feb 14, 2018 at 3:03 PM, Moritz Fischer <mdf@kernel.org> wrote:
> > >
> > > Hi Moritz,
> > >
> > > > HI Hao,
> > > >
> >
> > Hi Alan and Moritz
> >
> > Thanks a lot for the code review and comments.
> >
> > > > On Tue, Feb 13, 2018 at 05:24:36PM +0800, Wu Hao wrote:
> > > >> From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > > >>
> > > >> This patch abstracts the common operations of the sub features, and
> defines
> > > >> the feature_ops data structure, including init, uinit and ioctl function
> > > >> pointers. And this patch adds some common helper functions for FME and
> > > AFU
> > > >> drivers, e.g feature_dev_use_begin/end which are used to ensure
> exclusive
> > > >> usage of the feature device file.
> > > >>
> > > >> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > > >> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > > >> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > > >> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > > >> Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> > > >> Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
> > > >> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > > >> Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > >> ---
> > > >> v2: rebased
> > > >> v3: use const for feature_ops.
> > > >>     replace pci related function.
> > > >> v4: rebase and add more comments in code.
> > > >> ---
> > > >>  drivers/fpga/dfl.c | 59 +++++++++++++++++++++++++++++++++++++
> > > >>  drivers/fpga/dfl.h | 85
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > > >>  2 files changed, 143 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > > >> index 38dc819..c0aad87 100644
> > > >> --- a/drivers/fpga/dfl.c
> > > >> +++ b/drivers/fpga/dfl.c
> > > >> @@ -74,6 +74,65 @@ static enum fpga_id_type
> feature_dev_id_type(struct
> > > platform_device *pdev)
> > > >>       return FPGA_ID_MAX;
> > > >>  }
> > > >>
> > > >> +void fpga_dev_feature_uinit(struct platform_device *pdev)
> > > >> +{
> > > >> +     struct feature *feature;
> > > >> +     struct feature_platform_data *pdata = dev_get_platdata(&pdev-
> >dev);
> > > > See comment below w.r.t ordering declarations. Not a must for sure.
> > > >> +
> > > >> +     fpga_dev_for_each_feature(pdata, feature)
> > > >> +             if (feature->ops) {
> > > >> +                     feature->ops->uinit(pdev, feature);
> > > >> +                     feature->ops = NULL;
> > > >> +             }
> > > >> +}
> > > >> +EXPORT_SYMBOL_GPL(fpga_dev_feature_uinit);
> > > >> +
> > > >> +static int
> > > >> +feature_instance_init(struct platform_device *pdev,
> > > >> +                   struct feature_platform_data *pdata,
> > > >> +                   struct feature *feature, struct feature_driver *drv)
> > > >> +{
> > > >> +     int ret;
> > > >> +
> > > >> +     WARN_ON(!feature->ioaddr);
> > > >
> > > > Not sure I understand correctly, is the !feature->ioaddr a use-case that
> > > > happens? If not just return early.
> >
> > Actually this should never happen (init a feature without mapped mmio
> > resource address). If this warning is seen, that means there should be
> > critical issues somewhere in driver enumeration code. But sure, I can just
> > use if () return instead. : )
> >
> > > >> +
> > > >> +     ret = drv->ops->init(pdev, feature);
> > > >> +     if (ret)
> > > >> +             return ret;
> > > >> +
> > > >> +     feature->ops = drv->ops;
> > > >> +
> > > >> +     return ret;
> > > >> +}
> > > >> +
> > > >> +int fpga_dev_feature_init(struct platform_device *pdev,
> > > >> +                       struct feature_driver *feature_drvs)
> > > >> +{
> > > >> +     struct feature *feature;
> > > >> +     struct feature_driver *drv = feature_drvs;
> > > >> +     struct feature_platform_data *pdata = dev_get_platdata(&pdev-
> >dev);
> > > >> +     int ret;
> > > > We don't have clear guidelines here, but some subsystems want reverse
> > > > X-Mas tree declarations.
> > >
> > > Sounds good!  I agree.
> >
> > Do you mean we should reverse fpga_xxx definitions? If yes, then I can update
> > the code to use fpga_dfl_xxx or dfl_xxx instead. : )
> 
> More a stylistic thing, in the sense that you'd have the longest line
> first:
> 
> +     struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +     struct feature_driver *drv = feature_drvs;
> +     struct feature *feature;
> +     int ret;
> 
> Instead of:
> 
> +     struct feature *feature;
> +     struct feature_driver *drv = feature_drvs;
> +     struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +     int ret;
> 
> as I said not a big deal, some subsystems want you to do this, I don't
> think we made that a strict rule so far, but it makes it visually more
> pleasing ;-)

Oh.. I see. Thanks for the suggestion, I will update the patch for this.

Hao

> 
> Moritz
