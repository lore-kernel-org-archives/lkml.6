Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366C0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D4F20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQnwOCOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D4F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389952AbeHARYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:24:02 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43246 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389698AbeHARYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:24:02 -0400
Received: by mail-vk0-f67.google.com with SMTP id s17-v6so9508982vke.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PtCG9U/WhstThGMeBKuPO1IiNp0+HQaoB3lAc8Wj3KU=;
        b=CQnwOCOpdWdQOlbxYoNjbzGxpQqvlUlHYSn6MWvQgCvKefXsfiJB5Epqeht3UeXQeJ
         ILDmimJ2zp/Dff4sRsCUlrubB+LZak4VHFUMBCekXxXALMIiAN2u1B3SiGbMUoSXBi4p
         kq0EuBUSBfjQbOu8FS//H3XZ5RdUVgdMYCBz3tuSYua3DBnLFxow8Bvxpikbt/F4BEO7
         Tc652YnUfIIPUIBjkq+KzyAP4uUMTIr1BUZ2XoSJu0eqmALkAbkMn44khQNvg9JSl/Hn
         2TjkH7W7ftNqTXrN3UlJIgJyl6Y2dmkmpC0eykgL1TtryMNYx784V9O+OKMQtK6F85AQ
         gZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PtCG9U/WhstThGMeBKuPO1IiNp0+HQaoB3lAc8Wj3KU=;
        b=Hr4/AIQJlIZ+tsmWyz4m3s5wiVNFME8H2N0nUGhiATpmMp66oPFNfWalZLTirigf1r
         8WpSV2ijUtlPevIq0iaBg0KjGaVUr9Z/ih4WBNkqefBVZaaVvVPMLdjqfqKoluZnsWXS
         mHQIQoN/H95ELKNyXy3jonixsO3pIH+wgjnTQCMxv5z3LsOW82vxjsVy7MLRhleeICnV
         XNSwu4iZBcxWqh23xDsj82SP8/PALPQFml+k7Fcx0J44ZmJlXtW5GKmmRjOXEBePUvfS
         fXhLSI37gPeasc7MD9G0C7KBPBscWtKZvXD4sgBoI/0XyE6QDhrz0fBUVpH0WnnCWBu9
         kwnQ==
X-Gm-Message-State: AOUpUlElkg6mEcC9lzY3WVsLnQwZogUFk9lzJZuBPS0W1VLgwDNJ9oXk
        OjAcil7c0o89ibg9GKD23l50Kauw/cbqwxdo1Kg=
X-Google-Smtp-Source: AAOMgpcbuqLuaFgT+zAi3+wPcYAjPYdJoCXf+DbQhrdGwsvZlULUfGrHlbIL8hBB128DnvMRFbrFhoD0Z3X5tDubR8Y=
X-Received: by 2002:a1f:844e:: with SMTP id g75-v6mr17297353vkd.16.1533137864897;
 Wed, 01 Aug 2018 08:37:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 08:37:44 -0700 (PDT)
In-Reply-To: <cac7e1d3-dc55-5857-5fe5-4ff5bc39f2d1@ispras.ru>
References: <CAHp75VfktnjL+G0vjHNHr=8mbDXu+4BDogsnxrp_2Bo4em=r2Q@mail.gmail.com>
 <20180801115557.7086-1-vasilyev@ispras.ru> <CAHp75VeSr-dDC+BvvTi1f2JBDL0UB31O=umatKE4y=0HQ4_8UQ@mail.gmail.com>
 <cac7e1d3-dc55-5857-5fe5-4ff5bc39f2d1@ispras.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Aug 2018 18:37:44 +0300
Message-ID: <CAHp75VfxjZVCTQc_RS=x-sWCG=k=wkL8CnrcdZswA5KQOPK1+w@mail.gmail.com>
Subject: Re: [PATCH v5] staging: rts5208: add error handling into rtsx_probe
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        Hannes Reinecke <hare@suse.de>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 5:08 PM, Anton Vasilyev <vasilyev@ispras.ru> wrote:
> I found that staging-next already contains my patch v3, committed by Greg
> Kroah-Hartman.
>
> Do I need to send a new patch

Yes. Based on staging-next.

> with a label renaming based on Dan Carpenter
> comments?

Dan is talking for himself :-)

-- 
With Best Regards,
Andy Shevchenko
