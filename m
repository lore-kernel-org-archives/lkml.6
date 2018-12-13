Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC256C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCA32086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544699737;
	bh=HlemI4CIgJ8w7/qG1nxd2EbLi2shd5CdfiWZuaSNNnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F6I2HFi2bKZ0ibgSIuOBrhem14GNm0M6HTDz++pCgGwhZGI7yCXwfe2VDx1BUBjeJ
	 q9N+7DsfKS7i8X77PQ6dvUpQwveobUC4SWo8vcz43cgGvWMphr5/6Q03ZTyk50W5Es
	 A4jXYneEYwayv8bF4xCxP5Uws3nQiXWIY1dm284A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCA32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeLMLPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:15:36 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44827 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeLMLPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:15:35 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so1285729oig.11;
        Thu, 13 Dec 2018 03:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s17K0JVfndtjEzVI1eCbxu30DlroLlzlzzsq/ffeOdI=;
        b=hQkzzLAJj4s0LjbvyHR0+LWOpPhNADUqaMrxy8O8R/zuggQdKYIfCqJYYNXasSfrT5
         Yf/xxh6ABVC+2UUECVUprjO8r/8vdJyhskN+Bagguasy9LT8rXztPUIJ/bTbt20QXcOS
         ESwUpBbKNiWafM7IfT4u3MR/PuaeON8bGwHG6cOkBEYNrinBzby2vn05A0Kj9jF4OJLC
         VHOLK01jnQVkLLaClbu7klITPC2DU2D7FxEPQiBjYVd8LywH4K/PK8CD1yYei8yeZE46
         oUOuR2U9X8oOOgjCyEImff9SYZwZUiiQF4lxMbzR2gEX0ZyJN0jp8id+xGsaGy+cTbTA
         xoTg==
X-Gm-Message-State: AA+aEWYTqDYeLjBn1b2raO56IWZr+TXrJtev8kJ6h/sulzGGmiI7mhvH
        38zeUBKZb2IE/OzPZQCtzEjzjXBnJ2i5UsjGrm7Je35P
X-Google-Smtp-Source: AFSGD/Ulvn4iShscr6SAXUCTnMnV9VMp80AJkpUdiUQgZh8rSipHqZo8ojRglC6wvMemOyD0dv6BXFdYsyd3qnigQzg=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr2695268oia.95.1544699734942;
 Thu, 13 Dec 2018 03:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20181213044833.23952-1-okaya@kernel.org> <20181213044833.23952-3-okaya@kernel.org>
In-Reply-To: <20181213044833.23952-3-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Dec 2018 12:15:23 +0100
Message-ID: <CAJZ5v0iZa_m8zL+BKrpMNRhPF=6k__jCtiKSk6ZBFDc3pXMi1g@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] ACPI / OSL: Stub out acpi_os_read_pci_configuration
 when CONFIG_PCI is unset
To:     okaya@kernel.org
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 5:49 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> Getting ready to allow CONFIG_PCI to be disabled with ACPI enabled. Stub
> out acpi_os_read_pci_configuration function that depend on PCI.

Why don't you merge this with the next patch?  Is there any particular
reason why they should be separate?
