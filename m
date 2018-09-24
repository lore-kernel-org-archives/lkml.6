Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03DDC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEB020989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI3WXrFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEB020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeIXPOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:14:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42372 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbeIXPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:14:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id d7-v6so12210834lfj.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kZuhokDD0Jtw3q5m7ByPu+HckcPWo+YoskG84UBh6OQ=;
        b=VI3WXrFGDXGJ2eQ9Lrk5Z7aqsz3YpozUtHr3sGuyuuYHIIajw636pJNdQk1aQXvfS9
         MWuMDslBlcL9s2op/HX83/Joqah43F5wUa3X+TbemlwKIKJNyHN3Qxbcp2QpSfEIGFd+
         6Q3GVWWABuvbQdPxygALdjJFrl4r2ME880sxfwA8kcaqPKPT4Zd61veH6fcBkvLrkojF
         0acpLL83M/SbacXF9GKeknfsK/+x2ZREHfHuSPWz2W6Ua41E6KDFSNO9HKEgPhVErYO2
         sa9KzR+QAdic7zpun5CuaqyMFCjYyTC/yPaPiiBV17Ua34w0ApteQ/vJSSJEm1Jciikz
         95XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZuhokDD0Jtw3q5m7ByPu+HckcPWo+YoskG84UBh6OQ=;
        b=WyL1ooKdYAyDgvbzuUrKj7FktqzGf0CZ6Tw08k192MtUx+606QJw8ugrMR7J1njQCh
         QenqSDEysUzIJjkSSvUcaV/lHm12cWETLUuVgZ6x3Rx2PzB1ghftqLCuN9A7xT4vVD2j
         /vxMUhKyb2Bgkjtyo9gMYU4/moyb3vn46g7gqw+2wljPTAnNMOOjTxoMNVwQob1SnHvN
         0lDMRU+Mr08lspcrmRpOVkZ3zltihsSCJW8TSCNWen0qDuKK8UKnlXcfZLyKGm1q+Dsg
         Zr6Kme7U7VfO0FU9LZrdefiVWWIeoccLemWqsi+dCutIWuGoLskRuidEo0ft7CBGTxJW
         gApg==
X-Gm-Message-State: APzg51Cl3y1JwfrVlg6ne+/fetSr0wkcb6AU4nBVbEKYyh5wnHxISVK3
        VkPCz3JGuRYyLFfHKyAAS8w=
X-Google-Smtp-Source: ANB0VdYVM1fUWNHaUIUC5yPwDEuEGZsPZUuCVYGq3ICHH87tCr/V7jEDdo5wVpN/vDw8+RNraa0lHg==
X-Received: by 2002:a19:7709:: with SMTP id s9-v6mr5244870lfc.84.1537780403235;
        Mon, 24 Sep 2018 02:13:23 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b90-v6sm762831ljf.94.2018.09.24.02.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 02:13:22 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g4Mvh-0006JY-8O; Mon, 24 Sep 2018 11:13:21 +0200
Date:   Mon, 24 Sep 2018 11:13:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Aaron Williams <zero@zeroaptitude.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: control.c: fixed some coding style
 issues
Message-ID: <20180924091321.GG5101@localhost>
References: <20180920123828.22059-1-zero@zeroaptitude.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920123828.22059-1-zero@zeroaptitude.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:38:28PM +1000, Aaron Williams wrote:
> fixed some "Alignment should match open parenthesis" checks.

Note that this is not something that is mandated by the kernel coding
style, but rather a preference of the authors of checkpatch (and the
check is only enabled when the --strict option is given or when
checkpatch is run on net and staging code).

As the author and maintainer of this particular code, I do not think
this patch should be applied, but Greg may have a different opinion on
this as the overall staging maintainer.

> Signing up for the kernel clean up crew while I learn C

I would strongly suggest learning C *before* moving on to do kernel
work. 

Thanks,
Johan
