Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854CBC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BA22075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8/sMyfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BA22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeLMWGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:06:33 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50550 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeLMWGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:06:33 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so6115159iti.0;
        Thu, 13 Dec 2018 14:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Irtg1MWzwLcTJvZ/Ca1ACf2zrzG1eygNsxjHRfKvoEI=;
        b=H8/sMyfg1IHzUm+cgONUc4SFNTTJqe++aEkYkIPbCiQqnU4nYwiXGX2Q6lruSXQSXv
         pmdegXYZNjBTySNZ3GNd62RXcwp8aEN1zhRTJU+zX8jjSbt4byX7XYTlQGRy1bN9zpEE
         4MRkbTOd29OfdT1QwcSmvr0BpzHI0+S5NDfqZyhkuGLL8mK25d4wUhD1HuMvaqoV8NGQ
         MbD2kwJXhtC3gTwBVlFMeI2HW7wGcQ+vbNWxLbF68ZB5FLIObPsAfrrrhvK9WL7o7knW
         NzyAnfX/sOdLzGjxNdmlmjN1YpX2lmZKuLaFvHRDmfvj52ihONCQq5UlnoRJ5korzoPs
         Xy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Irtg1MWzwLcTJvZ/Ca1ACf2zrzG1eygNsxjHRfKvoEI=;
        b=qC1xRGRgKuB6wOgIT1Yzosf29QnrjWHyKnJzPhALfz/p6hCEeOwdV/IqQONNtXynug
         4SEiOM5rEGMTH59chAy6SceTTyOCdkejkdC6jMkRWV9eJiVtkGgtDk+EpgijuSJn2jFg
         M7YAWHa7v0r+h600bBw96zZoBi/6mXST5Y99p4Ze/FZo4fS/7qxtUe03lPjvH1lcnxPn
         KYohCMP8bPVUl5fvM56VVuFG+/Y7GLQRWA2qh7wn0Ubfy52uB1JIhp25O6kzg3F2dd87
         SkAYYb6TTUelQKobrS/mpAL1YAxleGf9grBqvvfGoJmhn4lfbZNgZ2m0dRkZWVRu/XnF
         t6KA==
X-Gm-Message-State: AA+aEWa5MdP1xaCeWylYbBH6kLBFwIpPOD63sBvv0QSTWKlIZ5quyjIK
        wlcKBxurfVlV6kkpxpDQOlE=
X-Google-Smtp-Source: AFSGD/V8e4CtqGsFRItgsuxBKCDslZJaeyjzPAtv4HDB2D78aixp/iPOPn7QD2cs7rMGKNlpSbI9lA==
X-Received: by 2002:a05:660c:14a:: with SMTP id r10mr1077356itk.100.1544738792271;
        Thu, 13 Dec 2018 14:06:32 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id h14sm1211219ior.41.2018.12.13.14.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 14:06:31 -0800 (PST)
Date:   Thu, 13 Dec 2018 15:06:29 -0700
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 02/11] staging: iio: adt7316: invert the logic of the
 check for an ldac pin
Message-ID: <20181213220629.GB2496@r2700x.localdomain>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
 <20181212005503.28054-3-jeremyfertic@gmail.com>
 <20181212081949.GH3116@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212081949.GH3116@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:19:49AM +0300, Dan Carpenter wrote:
> On Tue, Dec 11, 2018 at 05:54:54PM -0700, Jeremy Fertic wrote:
> > ADT7316_DA_EN_VIA_DAC_LDCA is set when the dac and ldac registers are being
> > used to update the dacs instead of the ldac pin. ADT7516_SEL_AIN3 is an adc
> > input that shares the ldac pin. Only set these bits if an ldac pin is not
> > being used.
> > 
> > Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
> 
> Huh...  This bug has always been there...
> 
> Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
> 
> regards,
> dan carpenter
> 

Should I include this Fixes tag in v2? I wasn't sure how important this was
in staging. I think most of the patches in this series fix bugs that date
back to the introduction of the driver.

