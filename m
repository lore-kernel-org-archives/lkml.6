Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7303C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DAB2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UkE9luhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfA3GXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:23:44 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:42758 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfA3GXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:23:44 -0500
Received: by mail-ot1-f52.google.com with SMTP id v23so20178598otk.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 22:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRmnp+vDJWeOI4pMzvi9il0t55Ucm8w3d1TF8f5gXVU=;
        b=UkE9luhcQuJrz4RuTfnhvGw15e/mx4fdH/lTKtwfwQfFQ8pcI9b+wJf1fegVWVcT+M
         +IjzDBBkOVr3i6i69rYH8wwcDVAs8jixBL6ATm5ZNk+Va60aZQqqqm3UCcgYWPYbz8oY
         iBTz+gkn23TcWnvL1xXooOjZNeOzG6LLfznawxlv/X9A7uwwcwzDb3smvCYe5E9l2MgW
         ClNVylVsZM4vRU4wU7no+pvNGyRSU9evlFq0zyGf/sgucSQfKi/oFXJYl9gcNQUHLQIK
         agA56c7VOHn23YQMHG9mAxdbKhwFPmZS+P5VTAWKhijDDPjKwg6BHz81zO8ZntoNUSKa
         BcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRmnp+vDJWeOI4pMzvi9il0t55Ucm8w3d1TF8f5gXVU=;
        b=n8LbbcQ+4Zp8IDUgPBYr4weWpn4wnJjQU9J/U3mHxSQcD19wvaPzrlSJmdgjU6IdKb
         4GX+qW34ZsJIoveJfmL6LNM61EQQfa36SfLtr2K4iH+WxOLxVO2zzxb/uSZSNsXp4E6D
         4sV67I/Pk2qqHXs4i4TQOqnYyubv99hYEtnk+OCSKMA/HRB07pU3xnqjpTA/HTbgKE6e
         SDCn0Jm5o4CxfzKHvlu4h/SPu87nPSwo6qqvoPeFjAqCFg8GY1cRTgwCrXdKJUnBBSW9
         wYZxSQ9Cjq6q4vKfwxzqLQjF5x3YMnuYzFw7T1NV6/G4jqF8URoCmCbX5r1w2axuZSAg
         HpSw==
X-Gm-Message-State: AJcUukcW8LKXw9mESWtZi3Q6KZSSjkLVzkwwtL9iyU2OstwNhJSvS+zF
        x1/rytAuh0SN0w3hjIpVcSjhUc4FsuTBa1+5g862Mg==
X-Google-Smtp-Source: ALg8bN6Y4kKrffU62Mb+psHoGRAIfEUXkSeXJR85QFCqruFt4Jr/OJa1WZFEelWuf6NR54orJOUVsd1kh4zGRa/UquE=
X-Received: by 2002:a9d:3a0a:: with SMTP id j10mr21563625otc.229.1548829423231;
 Tue, 29 Jan 2019 22:23:43 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Jan 2019 22:23:32 -0800
Message-ID: <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com>
Subject: Re: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 4:56 PM Dexuan Cui <decui@microsoft.com> wrote:
>
>
> Add the Hyper-V _DSM command set to the white list of NVDIMM command
> sets.
>
> This command set is documented at http://www.uefi.org/RFIC_LIST
> (see "Virtual NVDIMM 0x1901").
>
> Thanks Dan Williams <dan.j.williams@intel.com> for writing the
> comment change.
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
>
> Changes in v2:
>     Updated the comment and changelog (Thanks, Dan!)
>     Rebased to the tag libnvdimm-fixes-5.0-rc4 of the nvdimm tree.

Thanks for the re-spin, applied.
