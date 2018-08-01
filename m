Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AA2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA6E20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx6MPWGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA6E20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbeHAGq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:46:28 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:37405 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeHAGq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:46:28 -0400
Received: by mail-yw0-f179.google.com with SMTP id w76-v6so6717555ywg.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 22:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dP7eYFy3YOqdeb5zGVmkhoTe6XT5zLGPdXgEgQ535pU=;
        b=Jx6MPWGFbDUOFrMP9kixhf3qwyaRRWbWymM2cRJxLhno8FvJIGlS5zQvzSg4fpXuMv
         8jbzQpvdXLMLyzbC895UZXXyVWlJxtPk4CcviJHTs0PyGJxmtSi7B6VKRF5tAXXNiX++
         Nzqejk4J3T4YTWVESGdvoqyxekA8929vnDlnrxAyn3n7yFcnYjzsoezv2KFOvDdGfd9r
         ivwvu5oQp1fyFp1dScFu+O2991bbpEn+m2ORwQ12GzKmo013h3CG6VviHyE7rPWvCOvE
         3KtoWE099OtBpnTVuuNY9fhIW4ji4xpH4GsbB3y1mNX8j9RJSLCf0Us3O1cAiu6IMPA+
         7fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dP7eYFy3YOqdeb5zGVmkhoTe6XT5zLGPdXgEgQ535pU=;
        b=GJz1kTsz5O6zM9LjK8zotw+UcpT3oPvITryE1z/IlUUQtNW3ASWJv9kgF05fjPz1Nr
         ftza61i7WAAUIMuvM8lS/mnlh0T77m+Gf8Y9kWkVi8JG27T1BOdW+n3Li9ssSG2kYyZl
         FplPZQrjSXXbUiiN+QTwPFH4rUMoUa7u2yCZPmkXzfwe6+sB8xPXTaO6fvDrpGmiDDsf
         xTOlKTXn7mhHXHhVD61LfmdWSH8is9dMr5R4dAdlLTJU6yzI7adX10vEr9vG4w6Cyh1p
         9WvmeBqMrYCRksZoPTgNLiAfsxTqP6HFhpSCYGQLywh2vK6ze3wzT6Hmy38GYCh5o0pQ
         jB1g==
X-Gm-Message-State: AOUpUlEIZZmsxGCUIQbsWCLa9AhCKi8nKKsvYNa8ARSVVhfM/pnly7Bi
        P2aohLsw2N4mUcLnSrQfV9cgD4YIK8K9WwcItHQ=
X-Google-Smtp-Source: AAOMgpe0VNmMKaBdu6uxhln6XFH6OwAKWMo5//NzkFBzZz9MCT2PaxxiVQ/j6MGR2uqsCjEF1dYDCLVeZ/jE5k7piKI=
X-Received: by 2002:a81:8085:: with SMTP id q127-v6mr12105073ywf.180.1533099766221;
 Tue, 31 Jul 2018 22:02:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:3007:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 22:02:45
 -0700 (PDT)
In-Reply-To: <CACVXFVPpSJDqR8ki2PiDBbU36KsGFMYsOEf_9bmN6Cpo3w_YoQ@mail.gmail.com>
References: <CAAJw_ZuQXrYaEu9_pXWtoDpUjR2au1gGT_FP9F1e1Y7veHSz2Q@mail.gmail.com>
 <CACVXFVPpSJDqR8ki2PiDBbU36KsGFMYsOEf_9bmN6Cpo3w_YoQ@mail.gmail.com>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Wed, 1 Aug 2018 13:02:45 +0800
Message-ID: <CAAJw_ZtZ8hXi_B6+duiQYpaeSsQ7BQD-KwtE3H6K8Y8O8pAuig@mail.gmail.com>
Subject: Re: How to secure erase PCI-E NVME SSD connected via USB3?
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 7:07 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Sun, Jul 29, 2018 at 5:09 PM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>> I'm testing the USB3-to-PCI-E NVME SSD. It's works using uas module,
>> recognized it as /dev/sda.
>>
>> Since it's an USB device, the nvme-cli tools won't work, nor does
>> hdparm, as it's a NVME SSD.
>>
>> So, how to secure-erase the NVME SSD connected via the JMS583 chip?
>
> You may try 'blkdiscard --secure' and see if you are luck.

Interesting, will try that.

Thanks for the pointer.

Jeff.
