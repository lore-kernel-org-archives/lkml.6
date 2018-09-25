Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D45C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B682098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B682098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbeIYV5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:57:06 -0400
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:39249 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729306AbeIYV5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:57:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9ADA618224D78;
        Tue, 25 Sep 2018 15:48:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hose92_4dc532eec9b2a
X-Filterd-Recvd-Size: 2724
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Sep 2018 15:48:54 +0000 (UTC)
Message-ID: <a729cfd1102ef280650074dd8bec32c6b12636db.camel@perches.com>
Subject: Re: [PATCH v4 0/4] devres: provide and use devm_kstrdup_const()
From:   Joe Perches <joe@perches.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 25 Sep 2018 08:48:52 -0700
In-Reply-To: <c25df148-718a-d29d-9c1d-20701a0e4534@arm.com>
References: <20180925124629.20710-1-brgl@bgdev.pl>
         <c25df148-718a-d29d-9c1d-20701a0e4534@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 13:51 +0100, Robin Murphy wrote:
> On 25/09/18 13:46, Bartosz Golaszewski wrote:
> > This series implements devm_kstrdup_const() together with some
> > prerequisite changes and uses it in pmc-atom driver.
> 
> Is anyone expecting me to review this series,

Probably not.

> or am I just here because 
> I once made a couple of entirely unrelated changes to device.h?

Most likely yes.

It is likely that Bartosz should update his use of the
get_maintainer.pl script to add "--nogit --nogit-fallback"
so drive-by patch submitters are not also cc'd on these
sorts of series.

$ ./scripts/get_maintainer.pl -f \
	drivers/base/devres.c \
	drivers/mailbox/tegra-hsp.c \
	include/asm-generic/sections.h \
	include/linux/device.h \
	mm/util.c | \
  wc -l
26

$ ./scripts/get_maintainer.pl -f --nogit --nogit-fallback \
	drivers/base/devres.c \
	drivers/mailbox/tegra-hsp.c \
	include/asm-generic/sections.h \
	include/linux/device.h \
	mm/util.c | \
  wc -l
10


