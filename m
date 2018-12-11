Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443D6C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011432086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544564809;
	bh=q95xDmeU83eoArAwhUGDRUNiUUUbhCM3W2ZPqRgP3UI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=R//VtUtRuHpgzC0GeiNM0Pfyhd9TAWvFADXoE8n67U63SoRD+s/QLaaXeLYzsdRc+
	 SYmbxGUQTU4m6fvau7bPF7Kh/aagNxLHZ5/CkX6PYf2oCzM31mTs8h6psDCqTV0wCI
	 rIUXycl79KeJKgQgWxy4jJjesZQOYadxKTPPIUUw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011432086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLKVqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:46:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39468 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKVqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:46:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so15625162otl.6;
        Tue, 11 Dec 2018 13:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6sfkrvTbFyZTaDEjulUoXxVgbzPjL+q+Xdj+8gbQhk=;
        b=HJn4Al6ViCCWcWWUlNJBSZki6Aw60PX5IVA+zm40Jhma6w6KPRlJOaQv4fDaUzPqar
         OsFLKR0QYDBNUVR19zUT5blE9vvLftHrUz0njRSxJAlAxK8inqLx4RXx4QVVdTawwrEN
         XbFwPVbUU0q+Z+pTSVp3f/vE3h7xJgfGDmO8/oOnYpMcLdI9udEC6IRVHPEI/GY8OU+t
         BxHlb3p75GnNYBNNvXHqba6bQOb32rwWjRpdjuPPHRRcQEpe1sT9Ou3W7gzj/gF0OYyQ
         SmV5dZ/jEKS8DgJS9BS16wOt6MUKG27tT82BDoPzaHh1K0HcRsEQgU90RprfmhGdT7AK
         2H/A==
X-Gm-Message-State: AA+aEWbEFAFTXYjed0qIrnVDBOj4wR5B7aS3MIi/mgoIXsy2u4WyZ3cQ
        CM4JwPliOE1aaYddzL0uMf7vNkNKwGAd+F/n9Jw=
X-Google-Smtp-Source: AFSGD/Xqfx1EdgOhv7b76mQJHEJnN+Xi8Z/sk5Wt7al0wN2OUuMTH7XX3Rk9VxTyLwaGUs2+pQsNZ3CEiDq09gGC82I=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr13364203otl.343.1544564806701;
 Tue, 11 Dec 2018 13:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20181210181315.5023-1-okaya@kernel.org> <20181210181315.5023-2-okaya@kernel.org>
 <20181211170957.GA335@infradead.org> <342c5dd9-cb3d-d714-c87f-814a942cf395@kernel.org>
In-Reply-To: <342c5dd9-cb3d-d714-c87f-814a942cf395@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Dec 2018 22:46:34 +0100
Message-ID: <CAJZ5v0ia+eotSZgjbitt7TAT0ECSmTAz1XJhS3Auz5w5Z61SZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
To:     okaya@kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 6:37 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 12/11/2018 12:09 PM, Christoph Hellwig wrote:
> > On Mon, Dec 10, 2018 at 06:13:14PM +0000, Sinan Kaya wrote:
> >> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
> >> out calls that depend on PCI.
> >
> > I think you want to skip building at least all of hwpci.c if CONFIG_PCI
> > is disabled.  Or replace that whole stiking pile of crap with something
> > resembling C code..
> >
>
> I can give it a try but I'm under the impression that we don't touch
> ACPICA code in general.
>
> Feel free to correct me.

We don't as a rule, but depending on what the patch looks like, we
might not follow the rule this time.

I wonder though what we do if some AML wants to access PCI config
space via an opregion in there.  Have you thought about that?
