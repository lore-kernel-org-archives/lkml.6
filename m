Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90242086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcuVhSLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90242086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKGWQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:16:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35869 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeKGWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:16:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id z17-v6so7297259pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 04:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mlpGnthCumwwml9wvbukE3fDDjhbz2+cW9Pvq9KKRG4=;
        b=dcuVhSLfIeSWLWy4NP71vh2VG/AFdHMBC5DMDBN4mvC1kO3jWhPmlYk2kBHj0eNJlA
         n8xdQGqkAewTjp9GxWQz78FepTidnpMn8J051nY6AR9pvcX5kDF4At9tDcqgXYxpHuZ+
         5bjOqgB1qsKE9xE3y/E8IGrdlJKFdW0X5JPXLvOWjhGxMQctRlWeTLSDP0VOAjgaDCOO
         pR7gMp/8KSf23Tlgg+la1MQamb3vpNXfA0Msyh1hTj6twjah4JnxO6tnNO9iGarVdtGv
         4UTmKCy4oIZFB3gigLXjjIJf/9MhYnxZkrhZLryJF0hEzadfETs8eMLwaY+Z6AeEAZ0z
         tAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mlpGnthCumwwml9wvbukE3fDDjhbz2+cW9Pvq9KKRG4=;
        b=rfNtagP6JNlmg0Dq4xhkTYbnyato7BcQXfsa1/Rb+H0u1i/+QZrV1ubZ76/UrWlWVG
         Kvpfv9eXt05K48Nvb82iyeI+LBg1RoV9i5n3xc7em95tOXQzoR01ZbU9ecwHomYL/Obd
         uM/o38HQ7cxatyheftsP50ZXxnGeQW9ZtUJVJXn/gHTxjWM0FFdg0Vv3dpbHJL9Ytc7D
         XvYeV9GY+wk8wLK6RuDwOUNbj2sOduQ1fxQSdGFBQub+x3aQi7CpTFfkPocuiWUSVqL2
         Vv62yZ0Ao43VUmsa/CtLU1lBXgIcDVwkfthKjZqXVZnvqbZiorhf/G8qe78+trsrixB8
         8+lw==
X-Gm-Message-State: AGRZ1gKtKWrdyrhRT+zbPDuF+3bmebq77Rtao0yq29Cx9XvwiZbIJedO
        6P4nLwdBluxeNZvnkskWYwo=
X-Google-Smtp-Source: AJdET5fkezzwV/kjXnquA2tw4bANdi4L7AGc82ngmtzU8C2cmpywXc4xwF8Ekvtg+/HOCTbT6ZcOhA==
X-Received: by 2002:a62:2681:: with SMTP id m123-v6mr52287pfm.131.1541594774196;
        Wed, 07 Nov 2018 04:46:14 -0800 (PST)
Received: from nishad ([2401:4900:1880:5d72:7998:219b:665e:21b1])
        by smtp.gmail.com with ESMTPSA id v37sm733397pgn.5.2018.11.07.04.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 04:46:13 -0800 (PST)
Date:   Wed, 7 Nov 2018 18:16:04 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: olpc_dcon: olpc_dcon_xo_1.c: Switch to the
 gpio descriptor interface
Message-ID: <20181107124601.GA21698@nishad>
References: <20181106074314.GA11430@nishad>
 <20181107113652.GA16124@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107113652.GA16124@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 12:36:52PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 06, 2018 at 01:13:19PM +0530, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface in olpc_dcon_xo_1.c.
> > ---
> > Changes in v3:
> >  - Resolve a few compilation errors.
> > Changes in v2:
> >  - Resolve a few compilation errors.
> >  - Add a level of indirection to read and write gpios.
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> 
> The signed-off-by has to be above the --- line otherwise it will get
> stripped off by git when the patch is applied :(
> 
Ok, I'll change it.

Thanks for the review.

regards,
Nishad
