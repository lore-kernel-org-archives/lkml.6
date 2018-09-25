Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17420C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C3320880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CN8Uz9Xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C3320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeIZDT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:19:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46647 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbeIZDT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:19:28 -0400
Received: by mail-oi1-f196.google.com with SMTP id k64-v6so2729342oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UfNmwHUqIZn5Wsrj9Nyn30QBnKlKK1jdWMuY2OFba8=;
        b=CN8Uz9Xk5GG51joG+QFifrZpbFqqiXfHiL8R4YE09e47nfbShx/8PvR6cH3Wx37O/4
         kwNw8hi0esUfcyekSgbTqS6Iq7DlL9YTvFZycyPppl7u0cDciHPnLbBm6uH1g9NJWrDw
         W1ubqq48NbLmPNzL+wWHK4/g75aH7Oxd/Ax3ZgZYWzwiRT1zdX8m3s+JcmONGntPZHjD
         3vBVNzCTqs6thfQL7dK+1/Phl0jYDxPRe/YUr8dMp85AIsxf83h7Z4T1jImwGP1zp7lX
         kPVTUv65bC0qTCSG+1sasa9axeUp6AcJ7bas13vDQc2v6zSbxGRIpTlynAAxYxby9CbK
         T9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UfNmwHUqIZn5Wsrj9Nyn30QBnKlKK1jdWMuY2OFba8=;
        b=f+iMb3oPmoFEQB4jMiLkEw369YbVNgrPm4QUEFCeie974lrPQZrYAVvVKzXiz02T+r
         n0X1DTGjT4arCc4y2d/6LqrWsLpbJ44gNONx+a/XIaZ/rgwm+2DMW6Kf3KMZmlTRP22F
         uISk2i4ARrAbXddPwBhoo4doKx2tCyUF+bgrljSFXSnaScf7CGQp9ADHhmCVR3s1Kdyu
         8yUa9+fAqjM//kZeVUHcugexJ+LrbLxxQcguuUXcfKDwbIBk5gIZ83zpL8ekVfs0OOWH
         nOKLjQPZfncCRqo9NXa09d2SjfAH+sn+BkObLSyZ9puV4jcj2IdjpdJ5nPJKcJNQZ5Wj
         1Vsg==
X-Gm-Message-State: ABuFfojZAo587DmbAo2oiXlFjP+Zz9RB0QuUBLWzcBtbZkF9vomPcf0j
        bTO7zB7jZONQF6BQn62UzLRhAhrq7q18QrA2PH5gmQ==
X-Google-Smtp-Source: ACcGV62fXfFMpfAmlYLaoucTpDSFA4iChvbr/rWGb8wOe0qvp5cIt3AxqKEWdovjF2d1ixaQ4h5lvS5H5lz6puawph8=
X-Received: by 2002:aca:b02:: with SMTP id 2-v6mr1724511oil.305.1537909800171;
 Tue, 25 Sep 2018 14:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180925204801.6182.73167.stgit@localhost.localdomain> <20180925205301.6182.58728.stgit@localhost.localdomain>
In-Reply-To: <20180925205301.6182.58728.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Sep 2018 14:09:48 -0700
Message-ID: <CAPcyv4jP6q3W67ZLCK6jvBuDcQ+F8mWSzYgr_hqUSYndVeeijQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvdimm: Hold reference on parent while scheduling
 async init
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 1:53 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Unlike asynchronous initialization in the core we have not yet associated
> the device with the parent, and as such the device doesn't hold a reference
> to the parent.
>
> In order to resolve that we should be holding a reference on the parent
> until the asynchronous initialization has completed.

Looks good to me. Thanks for splitting this out, applied.
