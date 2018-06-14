Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 39744C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CDF208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pwb5e1ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CDF208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754793AbeFNK37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:29:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41419 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754724AbeFNK35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:29:57 -0400
Received: by mail-oi0-f65.google.com with SMTP id a141-v6so5165595oii.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ywy2IJsZRT5bi1kwKueHiGZQTaeC/c5j1VLM+U1rz34=;
        b=Pwb5e1icw87F31nSK2lSYBYQMPGJTQS9Gps0gMy+Wx8wAvvalOFZ5o/jeHOsNtV72w
         sWGyhpjh4jIqeJv4DM1A/aFExU+N2qj/KEKGIcKjkyfcmSJytN5PcH85TB+NQ0NDDdMC
         4OVILcaLLXefp6HRASGLy6WE/muHQ/3UvFx7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ywy2IJsZRT5bi1kwKueHiGZQTaeC/c5j1VLM+U1rz34=;
        b=VfNJfaDCAQCk3do0yHhrCCaFfc4WuMORPuiatRlgc0qTQbglwgq8dZpCDN3rcIjxfu
         ALaeXRADlUYDGIbNAkUZe6j1jw4HltxULTYnA/6Xzm9XlSlyxVXH0dd2j2h963W5c/Sx
         rQltdJvXI4iFGlDWVVKsCoJ3z1ebO8i4eWC8IIkHRF6TuaTSXOYbiVYGxNR9Pi2iQKp4
         8N0gMu5T9RXxu+BBcNoQDiZ12eQ48Pzqu2qooD3pox2c2NNWWT6ZcCvMpH2eYhUhyt9a
         rdHAsnWB5NBpEcz/jqh4v6ZcRq9z1lRR/GXCf0A7DCoQrI46QCSgb0LmHd05vQEvYtE1
         7CRQ==
X-Gm-Message-State: APt69E0+RQjxxs6oUpybyLXYTzRMugQ4fxkoSFYRBKbtz5viASmO6Lcv
        +fAoNiZcwpZSpfDkbrRUnoiLRx1BCnpP+BA8OgdIyg==
X-Google-Smtp-Source: ADUXVKLyE2RpvMC2ALAr4m1C1X6K4xn4mhCBI4Y5v5kogeTNchLrd/+BnZW3PkhSB3ggcef8vkOg6e0p1VxMQ6XrjBs=
X-Received: by 2002:aca:e143:: with SMTP id y64-v6mr846329oig.282.1528972196401;
 Thu, 14 Jun 2018 03:29:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 03:29:55
 -0700 (PDT)
In-Reply-To: <20180614102001.GA20836@lst.de>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 14 Jun 2018 15:59:55 +0530
Message-ID: <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
Subject: Re: Requirement to get BAR pci_bus_address in user space
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++ Alex Williamson, kvm,

Hi Christoph,

Thank you for quick reply.

If we want to add this in vfio then I think we need to do the same in
uio case also.

As I mentioned in previous mail, in the current implementation
resource information (address and size) is gathering from resource
named file created in /sys directory.
So I expect it would be better to have similar method as existing in sysfs.


Regards,
Srinath.

On Thu, Jun 14, 2018 at 3:50 PM, Christoph Hellwig <hch@lst.de> wrote:
> The only safe way to use PCI(e) devices in userspace is through vfio.
> I think that is where you need to take your inquiries.
