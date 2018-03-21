Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1112617-1521676300-2-15718663241779298757
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521676300; b=uPISy0FGM2oIQZPYhuUPIKNAhvfvBQy9dJ6dQr9V7Tv+6qn
    ps2fCsadPIWKVcWZqNZf9TiQMjmOIKsdSBso85L2auKzSIr58VeKyWG2haZxDEEG
    wVUA74bCHI0/1yqhfFoKFgyjaFWvUmdW5g6HgRDbCEviUCyUMxMCcoQeN7qGqCAg
    H4ka7Y2gH7dxmNNwud1n/b1TaZexbqUzALBsnqTrtWhf7nZTfSbRi64lO0OiqiTw
    Rczb8QDqtjl1rrVdskAF9K/4pI58SQ34xosMWFgJnhFPKEFtfysbz5GQ4f/iluwt
    nN9dcW0J0FFIbid7/6GitXf/uAyHFCEN1ZHPyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521676300; bh=ePJ4lxuHj9yPo2pWbq1UudrnUbSXH0wZfWuCFk
    y6Q+0=; b=EnQ5gYd0u0Oj2AAyyAzIh+veu1ToYpimjXK7fVXPHxNaJfH8fLqhVP
    m20Ge/sJyCGHIVgB+NCXG5h7lMlnRdkWxdVGkj9M3npfSxpIiwkz1p+9fJ5v6LOy
    DqEYLSA489eQfs0S3/GauJks9s2yLFafx6JDKbyu26kktzD28bhjbzo24z8OW5Qe
    BONNkpefE70VQdyjTnyghEM7K7gMxs/CnlWm+Lh1lYeDUH7QSmZK+RWqEWhr7lxn
    /Hm4RgVjwmR4KFm1GMtCjTRUpYIO49+alMjjhGL/0SdQfGscCpZPWw9+Q/DMTLlg
    3VxKr4wfgCNOSbRsbgi7bgcTknwkgynA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753967AbeCUXvh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 19:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753732AbeCUXvg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 21 Mar 2018 19:51:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32FF217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AIpwx49Mz9dJueVhndsfnt3S3dvAjqu3kqt4gUZeLbWaO4BEj/XvbReQXSg8xAwRtTMbIcgb9ZjJglmg4HICB57UZP0=
MIME-Version: 1.0
In-Reply-To: <20180320071037.GB31239@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-24-git-send-email-hao.wu@intel.com> <CANk1AXQpPXhNoPt1Uj=YvbtO+jun7e2Yzvyp+wuR1ZXx6+-i8Q@mail.gmail.com>
 <20180320071037.GB31239@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Wed, 21 Mar 2018 18:50:54 -0500
X-Gmail-Original-Message-ID: <CANk1AXSyh1ZcbgVbj3DxjULEeYKMfq_4CA6P0DK6+_z-pnBMUw@mail.gmail.com>
Message-ID: <CANk1AXSyh1ZcbgVbj3DxjULEeYKMfq_4CA6P0DK6+_z-pnBMUw@mail.gmail.com>
Subject: Re: [PATCH v4 23/24] fpga: dfl: afu: add user afu sub feature support
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
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

On Tue, Mar 20, 2018 at 2:10 AM, Wu Hao <hao.wu@intel.com> wrote:

>> > +static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>> > +{
>> > +       struct fpga_afu_region region;
>> > +       struct platform_device *pdev = filp->private_data;
>> > +       struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> > +       u64 size = vma->vm_end - vma->vm_start;
>> > +       u64 offset;
>> > +       int ret;
>> > +
>> > +       if (!(vma->vm_flags & VM_SHARED))
>> > +               return -EINVAL;
>> > +
>> > +       offset = vma->vm_pgoff << PAGE_SHIFT;
>> > +       ret = afu_get_region_by_offset(pdata, offset, size, &region);

Most of the functions here are afu_region_*, but there's also
afu_get_region_by_*.  Better if afu_region_get_by_* to be consistent.

>> > +       if (ret)
>> > +               return ret;
>> > +
>> > +       if (!(region.flags & FPGA_REGION_MMAP))
>>
>> FPGA_REGION_*?  We already have FPGA regions which are something
>> different.  Please call this something else.
>
> Yes, will replace it with DFL_FPGA_*.
