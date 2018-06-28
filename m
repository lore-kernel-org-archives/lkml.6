Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AF0C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A472208DE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rezpgviz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A472208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966274AbeF1Nre (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:47:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54395 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965476AbeF1Nrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:47:32 -0400
Received: by mail-it0-f67.google.com with SMTP id 76-v6so12829661itx.4;
        Thu, 28 Jun 2018 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnoSRZc4iH6ZDQuLdw7aa6g7wsq6jn5f2F5da47dgWM=;
        b=rezpgvizdHgeK1xSEDsLmVVUiAOPDmTB2uhypgF5hU7Y7fvNrq5A9CZ37pKREu8o6K
         NCSeoPMLzJTDbtsIByNTZBOO65h9Tg6tSQqLDDf5/c09MXLlUMID3k7NuALA0Y1DvZRs
         sEuu+a5/Y0Nqjp6S3fOtZO7Miz+jPYNyOVSKfqZuEc8cAC9XEcdXbNmRaaOlsVA8t0NH
         aXt7AEU/OIalpLqhhlbfNZ6zaV8IpfoFJOMOGcKua7CNIhJTCYaClxbknzvw9Be9Rztx
         MeY6x2xNC5DFUYtgON2rPfYdBFkG1rIJx3sl0WDroCywR2Z8sRNbquk5DFEjQeEBCPMF
         5FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnoSRZc4iH6ZDQuLdw7aa6g7wsq6jn5f2F5da47dgWM=;
        b=c3oWRjK1VPpjt8TpZR71gAafFUq8M6C92cnC1Ys6vMceOeGfjywyt2fMJodda6c4Oe
         ksJQnUVaCXoXKKfhdD7fb45XpO6FgxkDV99Pdau5l+INRzEbfgU7i5MKj4RFWqD3H64z
         UGZ5FyxbYxfbqrTISX1/nhnL2yJi1Ree7GojMyQ84lDX03Y+SHY7s9/oMLvYGWUXULbf
         TdaY0BVHxAwbDk+AhylSrLzwi69EwSwNYmd3462u95Tdbsj4mLp+sJIO2axOBgld/YCF
         UxdkmtEkJHN8w0ix8dcitPFzHFWKodxlQPvo3MnLoF4hfL7UN7GYgFO1Nc9Ooap4MDGD
         gkmQ==
X-Gm-Message-State: APt69E3eiQrOn0ZXCAs0kvSnXpTUtjwNGr/FaVJUfr14Tyo4yynwm9lv
        5Iw7Vd/1R4XDtsAO+8S46jHmRXsiQy8VhycVZA==
X-Google-Smtp-Source: ADUXVKK0kZuyG5gMdnlozfkxxxxay/7Uh+jZt6rnzWuSGOBiYlBuIOqiWS4d+ahMK7YTAVJ9v6GM19Nj9FN4wY+2RWY=
X-Received: by 2002:a24:1fce:: with SMTP id d197-v6mr8042880itd.52.1530193651965;
 Thu, 28 Jun 2018 06:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <1529904187-18673-3-git-send-email-kernelfans@gmail.com>
 <20180626074426.hzunfbvwbubt3t3p@mwanda> <CAFgQCTsCFP_6znUaFKnczuUJjMMA1Hq_Qrk6CUVs+EFEBZgTMQ@mail.gmail.com>
 <20180627083445.jsu2ffyz5cl4wbjn@mwanda>
In-Reply-To: <20180627083445.jsu2ffyz5cl4wbjn@mwanda>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 28 Jun 2018 21:47:20 +0800
Message-ID: <CAFgQCTsZk=gQmwpTcaaTkLjmb1W5mPKbo5Bonkd+Bj_rW+mZYg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drivers/base: reorder consumer and its children
 behind suppliers
To:     dan.carpenter@oracle.com
Cc:     kbuild@01.org, kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 4:35 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Jun 27, 2018 at 10:34:54AM +0800, Pingfan Liu wrote:
> > > 1b2a1e63 Pingfan Liu 2018-06-25  243            }
> > > 1b2a1e63 Pingfan Liu 2018-06-25  244    }
> > > 1b2a1e63 Pingfan Liu 2018-06-25 @245    BUG_ON(!ret);
> > >
> > > If the list is empty then "ret" can be unitialized.  We test a different
> > > list "dev->links.suppliers" to see if that's empty.  I wrote a bunch of
> > > code to make Smatch try to understand about empty lists, but I don't
> > > think it works...
> > >
> > Yes, if list_empty, then the code can not touch ret. But ret is
> > useless in this scene. Does it matter?
> >
>
> I'm not sure I understand what you're asking?  Of course, it matters?
>
Oh, I misunderstood your original comment. Yes, you are right. I will
fix it in next version, if this code section is still used.

Thanks and regards,
Pingfan
