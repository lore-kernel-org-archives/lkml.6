Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2033E206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A3nIokxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2033E206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeIYXMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:12:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45390 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeIYXMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:12:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id t70-v6so7202465pgd.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Nqwq16Q7LQxf+wL9ZlsvKIL3tzWSkHJMNq+NYLf1TYE=;
        b=A3nIokxAhKkR0zCjC5M3XSlc1gUvwDSW8Eojho+EJqgVXdH/i2xNUvbTceOKJR5Ert
         4HMWYogGRtQx85ka5dwChSB1Ji5Jmhj1tYF3FkpvzZJnHjQ7nxiyVE87Lee2qncMBtdM
         KE5NTCt+EoKRQ6JWQkooYu2eyG2V6MQWVJfKCT6Fj+EuqiUYRUSM7GPRyDPNvOcwF6Ni
         7wiYTesHjGyAQ2gVjj0kClVmTCEy/WtFh3USjvWItVH7gmrnJl2B7J4zNceaMk17K/aJ
         NCDKBLW6CkD7z+RaBmaJJX6XLxyARBbkX+BKKZZYWuSJVH+fxP7GtH6e+lNmWN8o3p0b
         x6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Nqwq16Q7LQxf+wL9ZlsvKIL3tzWSkHJMNq+NYLf1TYE=;
        b=agm3iTlyp0CSXUxAJFMUyrcO0Sp0/z9QH2nsJup0VQZ15xmBrH5sM2MRY2qP7E2Md+
         xb76oxAtC2xjV4OAz59tYFx+ohSWozqnP9GW5o4ddJ+BsusoeSy7/D+AnjlnTIlW8z2h
         xIeqY53+sI09V1p5XqMuWnTYM2D4CFW/CFcUDwaZffJXfE0Wd8kPwODD0OGjzZjTpzu/
         WbXQq9OSrJpdFw92vVZ2OMNpW2VXRtL0C97P91IjajHFy9GrunLVWzUw/w8F+nDJkDal
         5Hz+PDRj2bJ/UrW/sZ4ihyG2bxOV34v8zx52DEHfjn+r0AFTCo5WNPR+cfpnfl/R4HAH
         R3Lw==
X-Gm-Message-State: ABuFfoiZWhzdqETt8muC9bVDAWSPNziRPy9wh4mW7MBg9Tc69GL/PpLy
        IBJDwKLj+KrxF9YhB9bomQ9+TQ==
X-Google-Smtp-Source: ACcGV61gQtUE1qqx24YnRTX+9OhomVq0kzD3+KISfcF5USdbis4H+MeRCw5EymGr/Hg+gNgf23r4ew==
X-Received: by 2002:a17:902:8481:: with SMTP id c1-v6mr2133192plo.158.1537895024324;
        Tue, 25 Sep 2018 10:03:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r12-v6sm3818159pfh.79.2018.09.25.10.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:03:43 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:03:43 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Sep 2018 09:57:57 PDT (-0700)
Subject:     Re: [PATCH] RISCV: Fix end PFN for low memory
In-Reply-To: <50f35396-9e2b-c177-6a96-9c450c7abdde@wdc.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, Damien.LeMoal@wdc.com,
        anup@brainfault.org, linux-kernel@vger.kernel.org,
        terpstra@sifive.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-133e3d9b-f580-40d4-bb7a-9cafa72fbb93@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018 13:55:04 PDT (-0700), atish.patra@wdc.com wrote:
> On 9/17/18 7:08 AM, Christoph Hellwig wrote:
>> On Tue, Sep 11, 2018 at 11:30:18AM -0700, Atish Patra wrote:
>>> Use memblock_end_of_DRAM which provides correct last low memory
>>> PFN. Without that, DMA32 region becomes empty resulting in zero
>>> pages being allocated for DMA32.
>>>
>>> This patch is based on earlier patch from palmer which never
>>> merged into 4.19. I just edited the commit text to make more
>>> sense.
>>
>> Looks good,
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> Palmer, can you queue this up for 4.19?
>>
> Hi Palmer,
> I did not see this one pulled into your rc6 PR.
> Not sure if it was intentional or just lost in heap of emails.

Looks like it got lost, sorry.  It's in my branch now, I might re-spin the rc6 
PR because it looks like I may have screwed it up, if not I'll put it in rc7.

Thanks for the ping!
