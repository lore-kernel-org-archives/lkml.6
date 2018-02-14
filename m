Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3837409-1518642880-2-473252688076536725
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
    t=1518642879; b=GyqUrVL8g46Aj2sehiki4FF1sJtLiOjNgF2tKs/DzaK1+Sy
    nCYJ8vYSYIVLhevSaBZvwqcAKn+jZ1ATU6sC0Baw+6XoFUoyQiQoBgvinJ4f2j5n
    bTJH3USPPFA+turgcuDpor3dEJeOutQ8p0LP/6dg80CTC7Cl2g2HpejILc3AZTF3
    tkFZrg1mYLXL7Fwa8JqUL0qzaw5oh4LYG0cYh27nUZFTvEldfwywvGQTPGzzjCDJ
    3hldCiQP8vgnJjAG2GAaq4HHQ0XSJ0sHsNuvdxK4T0WUGrRrH4fhuI9MozE8UfL3
    GG5KGVhq3YESEol8jxsg3LsdHa1ed4lW0zsryMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518642879; bh=v1YIUFzgtJP4RrZiOgVX2bRDRC8ioLn2ZrSijh
    sFh5w=; b=KDno6TWXwf8rmtbbS7ssrKb5beVFMoneNr4oOF7bXjJ6s3y/rimh5C
    SQ4PwMYRQUOTXQh1n3ySL4OxMU0lV3BrS9lLC2aN9CsHBI24nSHQ4ndqTvtViryQ
    1hmTxQaz9Mr/NDFAyl5j+z24zA42qxWp6d0hojSjS1nsn3eP8Xhz0GijxTY+NWve
    mPs5abT4wGR2vn6so4uHy9Pud90n4zO3OafBDMA14bw0nxOpX+VpxtLVNJgpsDIR
    n/lH9YUDMcrjoO4qvLJ2oWWyaEAsLcwNIxN31l7WweCDSigit0oPYd9KNagllEK3
    mta5m134TIjJBc9HnIjumwwmIzQZStZQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031257AbeBNVOh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 16:14:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030501AbeBNVOg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Feb 2018 16:14:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E40217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AH8x224Lm9i7CInBErhYaqYmHcAC/yRe9cyFFZya1tGkPsLiWA7tjg4UYsdtKzKp8YB1U/JKGAXWTeBbNiVy6pMCs64=
MIME-Version: 1.0
In-Reply-To: <20180214210319.GC25618@tyrael.ni.corp.natinst.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-8-git-send-email-hao.wu@intel.com> <20180214210319.GC25618@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 14 Feb 2018 15:13:54 -0600
X-Gmail-Original-Message-ID: <CANk1AXRksJum6s5yB5727136DBLHs4UPW7xaLn_dT5qMEfqm9A@mail.gmail.com>
Message-ID: <CANk1AXRksJum6s5yB5727136DBLHs4UPW7xaLn_dT5qMEfqm9A@mail.gmail.com>
Subject: Re: [PATCH v4 07/24] fpga: dfl: add feature device infrastructure
To: Moritz Fischer <mdf@kernel.org>
Cc: Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 3:03 PM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

> HI Hao,
>
> On Tue, Feb 13, 2018 at 05:24:36PM +0800, Wu Hao wrote:
>> From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>>
>> This patch abstracts the common operations of the sub features, and defines
>> the feature_ops data structure, including init, uinit and ioctl function
>> pointers. And this patch adds some common helper functions for FME and AFU
>> drivers, e.g feature_dev_use_begin/end which are used to ensure exclusive
>> usage of the feature device file.
>>
>> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
>> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
>> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
>> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
>> Signed-off-by: Kang Luwei <luwei.kang@intel.com>
>> Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
>> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>> Signed-off-by: Wu Hao <hao.wu@intel.com>
>> ---
>> v2: rebased
>> v3: use const for feature_ops.
>>     replace pci related function.
>> v4: rebase and add more comments in code.
>> ---
>>  drivers/fpga/dfl.c | 59 +++++++++++++++++++++++++++++++++++++
>>  drivers/fpga/dfl.h | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 143 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>> index 38dc819..c0aad87 100644
>> --- a/drivers/fpga/dfl.c
>> +++ b/drivers/fpga/dfl.c
>> @@ -74,6 +74,65 @@ static enum fpga_id_type feature_dev_id_type(struct platform_device *pdev)
>>       return FPGA_ID_MAX;
>>  }
>>
>> +void fpga_dev_feature_uinit(struct platform_device *pdev)
>> +{
>> +     struct feature *feature;
>> +     struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> See comment below w.r.t ordering declarations. Not a must for sure.
>> +
>> +     fpga_dev_for_each_feature(pdata, feature)
>> +             if (feature->ops) {
>> +                     feature->ops->uinit(pdev, feature);
>> +                     feature->ops = NULL;
>> +             }
>> +}
>> +EXPORT_SYMBOL_GPL(fpga_dev_feature_uinit);
>> +
>> +static int
>> +feature_instance_init(struct platform_device *pdev,
>> +                   struct feature_platform_data *pdata,
>> +                   struct feature *feature, struct feature_driver *drv)
>> +{
>> +     int ret;
>> +
>> +     WARN_ON(!feature->ioaddr);
>
> Not sure I understand correctly, is the !feature->ioaddr a use-case that
> happens? If not just return early.
>> +
>> +     ret = drv->ops->init(pdev, feature);
>> +     if (ret)
>> +             return ret;
>> +
>> +     feature->ops = drv->ops;
>> +
>> +     return ret;
>> +}
>> +
>> +int fpga_dev_feature_init(struct platform_device *pdev,
>> +                       struct feature_driver *feature_drvs)
>> +{
>> +     struct feature *feature;
>> +     struct feature_driver *drv = feature_drvs;
>> +     struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> +     int ret;
> We don't have clear guidelines here, but some subsystems want reverse
> X-Mas tree declarations.

Sounds good!  I agree.

Alan
