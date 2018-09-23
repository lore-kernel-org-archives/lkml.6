Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C77ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A77214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="dEmqVJ6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A77214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeIWTKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:10:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32910 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeIWTKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:10:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id l19-v6so1421571ljb.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rvk/6LqTmb7TINouDKZPyi0AmjRpG91p7AkTBJkYPMg=;
        b=dEmqVJ6GickYyG/DSRpCcylxiF3yzqDND+thGuLZTOfJJlA2zBRATOdKAqIQr7jeVm
         tZaVusmuwDOcMz+TU0LovBF+kB76cOe+G1itSbYOrhmJGIIsk27tJrH3qatjL8EfhbIX
         FoPavvMGgcP8J4umkvinAfezgJ6jCrVGgz0GhzTIxZbFXKNDI9cif3rUhQ1mpxckFYIH
         lZbwBg/Hnnng4RpRJaAiDaIbBT9f/onU0mlEqZsUb647ajF1Hleds5bGYMjCw7XQX+18
         sfGI1RM2Eah4hAZK0bCziJyJo65XrqiGpklfWsN1N4l8rirlX4QuoayzZrJPr/ZvIZUc
         mpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rvk/6LqTmb7TINouDKZPyi0AmjRpG91p7AkTBJkYPMg=;
        b=cIV/FlCegF2Lg0mLzIH+VS9EVcoQXYn8QtU80wr+zZiG/nUc2V9R5Ree9RzyoLQsfh
         mXsLYwVyb2MJIejzDL5pfvJyvNc6sMP/F1JI5iAa6cIxX4bqHrQOI+FvLbJlo/5F/yUR
         ZkC7aD5FCAGj8Ttig7f/vYQolcW3gOb4zrcjE9GhvE/wI4pb31/52JqrSCOpD34SlhWU
         4+FZUnvyr+dc6J399t2jObRBTDEV/rUB5ppt+L06HYKsW3CfWW4kU9gp9Biw587iREiP
         eitI8ZrG09lv7qLzms2K5ASdKfyDUKfH+QKVZKOH79j93XlD/4GWOcbPtef2xNmankzg
         W5sg==
X-Gm-Message-State: ABuFfohATq/dD8nVOAlfvpmyCj0AZFtuVbVrVbKifDSy0DqA8EOPyPN6
        fvXwIOASv88LBk20T/yMyumzZzNR0n7cPj/3ujGd8Q==
X-Google-Smtp-Source: ANB0VdaWDK2WbgrSx2Itrgt41Uneea77BhnAmGB1mTQySe/yZS3D3T/rCrWlFDAKUthhkblv99MeVjig6W3Pb+0yogI=
X-Received: by 2002:a2e:87cf:: with SMTP id v15-v6mr7670613ljj.13.1537708404715;
 Sun, 23 Sep 2018 06:13:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:eac3:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 06:13:23
 -0700 (PDT)
X-Originating-IP: [85.30.9.151]
In-Reply-To: <CY1PR02MB21385F71D8BC4498654CD0BFB8130@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com> <CY1PR02MB21385F71D8BC4498654CD0BFB8130@CY1PR02MB2138.namprd02.prod.outlook.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 23 Sep 2018 14:13:23 +0100
Message-ID: <CAOesGMgUaQMcTQsbLR_qN95QPfOE1gCJuM9=6AiFLg+_t98qaw@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] drivers: Introduce firmware driver for ZynqMP core
To:     Jolly Shah <JOLLYS@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>,
        "arm@kernel.org" <arm@kernel.org>, Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 5:46 PM, Jolly Shah <JOLLYS@xilinx.com> wrote:
> Hi Olof,
>
> As suggested, this patchset is generated without ioctl interface. Please review. If you are ok, Michal can create a pull request for merge.

Hi,

I replied on the other thread as well; it sounds like you will need
something _like_ the ioctl interface for some of the dependent
drivers. For those, would it be possible to only expose some of the
ioctls through the interface, and not just pass through any call? I
think that'd probably take care of my concern.

But yeah, go ahead and stage these in a pull request for now, that way
we can take care of these and merge them as the rest are getting
ready. I don't want to hold you up more than needed; the patch set is
already up to a very high version number and it's not fair to make you
rework it completely yet again.



-Olof
