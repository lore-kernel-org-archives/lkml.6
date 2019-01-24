Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8DEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE5A218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548368306;
	bh=7IXz9FAozwMcOb/SIcWiY1WhQcGGjm39TNnPdM05DP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I1gtxuU35U+4sietKunQEQ6RNsKE1QvHnekUjqdZXOa0LNiwsNdFEbPGXUniyIw3K
	 +VaNgooy7iDuu/h0e6Mf0c6L+HyjL0DKnch1gDQjNF31iSzT6iF3NFkZhHWUlnIdyH
	 4t208crPWcuCgm954uP4ZQhqt+QYMYKPEX+C8XrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfAXWSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:18:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfAXWSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 17:18:21 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004A1218D0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 22:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548368301;
        bh=7IXz9FAozwMcOb/SIcWiY1WhQcGGjm39TNnPdM05DP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v4T98Lj5gF30aqCNKbBqzgknA3Fd1w6c2bwdRFy32gCnFAPLDn2o1dI4WHHg1RsZT
         QahX3EvwpAWE7tpLK+r5YESCD2n8TdLfn7LFTTQx80ZJapGRX1vWG12L7/T1hGQ25s
         e7dXeUMySDIJDT0hxP5oyjIrxYV0C1g37CG/lpKc=
Received: by mail-vs1-f43.google.com with SMTP id b74so4514265vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 14:18:20 -0800 (PST)
X-Gm-Message-State: AJcUukdmUd4vQo2MZG5A6UFx3RwHCLmb1LNZY4eyoPfqFdWofWIZ3o3G
        CXplz1FooDFFqFGSzAKnlB5T+yyR0pAEcbcleBQ=
X-Google-Smtp-Source: ALg8bN6EIfDNAbDdNMMFNxt0jJg/SN8lqwPqYq/SSDAjNNqkkPkJNZOGFWkhSV69TAzrEuO3X6GE1m/Khk8wg9hF6U4=
X-Received: by 2002:a67:3a1c:: with SMTP id h28mr3467555vsa.218.1548368300175;
 Thu, 24 Jan 2019 14:18:20 -0800 (PST)
MIME-Version: 1.0
References: <154835747897.2884847.389054528444820204.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190124221226.GB9882@localhost.localdomain>
In-Reply-To: <20190124221226.GB9882@localhost.localdomain>
From:   Ross Zwisler <zwisler@kernel.org>
Date:   Thu, 24 Jan 2019 15:18:08 -0700
X-Gmail-Original-Message-ID: <CAOxpaSVfJo4ED2rr16STj6Rht3yonKYsw-j4aLHirZ3=JdW03w@mail.gmail.com>
Message-ID: <CAOxpaSVfJo4ED2rr16STj6Rht3yonKYsw-j4aLHirZ3=JdW03w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update filesystem-dax and NVDIMM entries
To:     Keith Busch <keith.busch@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 3:13 PM Keith Busch <keith.busch@intel.com> wrote:
> On Thu, Jan 24, 2019 at 11:17:59AM -0800, Dan Williams wrote:
> > Ross has moved on to other areas.
> >
> > Matthew and Jan are trusted reviewers for DAX.
> >
> > Dan is now coordinating filesystem-dax pull requests.
> >
> > Ira and Keith are now involved with the NVDIMM and Device-DAX
> > sub-systems.
> >
> > The linux-nvdimm mailing hosts a patchwork instance for both DAX and
> > NVDIMM patches.
> >
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Ross Zwisler <zwisler@kernel.org>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Acked-by: Keith Busch <keith.busch@intel.com>

Acked-by: Ross Zwisler <zwisler@kernel.org>
